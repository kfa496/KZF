const { BN, ether, expectRevert } = require('@openzeppelin/test-helpers');

const { shouldBehaveLikeBEP20 } = require('./behaviours/BEP20.behaviour');

const { shouldBehaveLikeGeneratorCopyright } = require('../../utils/GeneratorCopyright.behaviour');

const Standard = artifacts.require('Standard');
const ServiceReceiver = artifacts.require('ServiceReceiver');

contract('Standard', function ([owner, other, thirdParty]) {
  const _name = 'Standard';
  const _symbol = 'BEP20';
  const _decimals = new BN(18);
  const _initialSupply = new BN(100000000);

  const fee = ether('0.1');

  const version = 'v2.0.0';

  beforeEach(async function () {
    this.serviceReceiver = await ServiceReceiver.new({ from: owner });
    await this.serviceReceiver.setPrice('Standard', fee);
  });

  context('creating valid token', function () {
    describe('without initial supply', function () {
      it('should fail', async function () {
        await expectRevert(
          Standard.new(
            _name,
            _symbol,
            0,
            this.serviceReceiver.address,
            {
              from: owner,
              value: fee,
            },
          ),
          'Standard: supply cannot be zero',
        );
      });
    });

    describe('with initial supply', function () {
      beforeEach(async function () {
        this.token = await Standard.new(
          _name,
          _symbol,
          _initialSupply,
          this.serviceReceiver.address,
          {
            from: owner,
            value: fee,
          },
        );
      });

      describe('once deployed', function () {
        it('total supply should be equal to initial supply', async function () {
          (await this.token.totalSupply()).should.be.bignumber.equal(_initialSupply);
        });

        it('owner balance should be equal to initial supply', async function () {
          (await this.token.balanceOf(owner)).should.be.bignumber.equal(_initialSupply);
        });
      });
    });
  });

  context('Standard token behaviours', function () {
    beforeEach(async function () {
      this.token = await Standard.new(
        _name,
        _symbol,
        _initialSupply,
        this.serviceReceiver.address,
        {
          from: owner,
          value: fee,
        },
      );
    });

    context('like a BEP20', function () {
      shouldBehaveLikeBEP20(_name, _symbol, _decimals, _initialSupply, [owner, other, thirdParty]);
    });

    context('like a GeneratorCopyright', function () {
      beforeEach(async function () {
        this.instance = this.token;
      });

      shouldBehaveLikeGeneratorCopyright(version);
    });
  });
});
