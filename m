Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCEA4B2052
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382718; cv=none; b=GQX2K1AwntL9Bj5Q4cjHzjNvuDw59drH4oxibUjNZLQI0Aat30iCflCx//zIbR7hApnbVrdwGPyyf5HD45IzHW2SPf/tI4d0IKBLjSKnENOaahypoXisB8TtzQGe/6bPRDrRC9EIW9Wyk0jYxF4uYsgBbMU+kxR1X7v0HpkDmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382718; c=relaxed/simple;
	bh=udmjQ12SfnBZ3TrchKwvxWMCktfO6aJCmItGMrVTRMA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dTtd2HhGJ5gEJE4sxIHRsAY+MxjQ+B+HonPo/cDxen/YyFuGQ6CKLm3Vo+nHPESOW/PX4ciPRegYH0TISIkf89Hb2L/xE5rX1Ft9La0JEKq3MK1k8ZbPa7/XLMW6D3RAUUm0RalJyH6VmvtI2mV3nVq3QT+0RLRGGoEnA3I+0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWY+IRRk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWY+IRRk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B541F0089B;
	Wed,  7 Oct 2026 14:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382711;
	bh=Jg5s9XrsRxbgyYsmWtTmOF/6m3SlcjXbKlax5q/5yeA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RWY+IRRk1LB2b39U9LNbCI24qBhYdB+YsvBz1ffce/GeSXV3P/9E9EBMyHl2TsdjS
	 PurJVaJ1Dl1rWV7qNKyXwBPAHDOSmLb44/tHjZ8OnIutSgZSHlLkP9KH13tlDyHxAt
	 rIx+j2c8aCBXHbVH8xV1clLhNjIB8PX8SIftooPLzENBozlYZogT29h3J+yZ5IYvrB
	 lFEqTH+j37x8c93Hr1Uj/drTjZiWL0tBZksKteiO2JCv+a49HJUDfPX2kSapfSBiJs
	 nUmuuGVo3TjdVDeqhQoFyD7NqKcWuU+tdaGPPB1SDDITOCMDCdzg5M4Mqw2RFgiNFk
	 YYC7U2VhwcEGA==
Subject: Re: [PATCH net] net: dsa: microchip: fix KSZ8765 fiber detection
From: netdev-bot+sashiko@kernel.org
To: sebastien.royen@armadeus.com
Cc: woojung.huh@microchip.com, netdev@vger.kernel.org, kuba@kernel.org
Date: Wed, 07 Oct 2026 14:18:31 +0000
Message-ID: <179138271112.434549.5315304282562833925@kernel.org>
In-Reply-To: <20261006130006.134847-1-sebastien.royen@armadeus.com>
References: <20261006130006.134847-1-sebastien.royen@armadeus.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch fixes a long-standing, user-visible misdetection but
  carries no Fixes: tag and no Cc: stable.

Pre-existing issues:
- [Low] In ksz_switch_detect() (ksz_common.c:2927-2933), `u8 val;` is
  declared uninitialized and `ksz_read8(dev, KSZ8_PORT_STATUS_0, &val);`…

--

net: dsa: microchip: fix KSZ8765 fiber detection

This commit changes KSZ8_PORT_STATUS_0 from 0x08 to 0x18, so that
ksz_switch_detect() reads the Port 1 Status 0 register when it checks the
fiber mode bit. The old address was Global Control 6, where bit 7 is the
MIB flush counter bit, so KSZ8765 chips were never identified.

> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index cbe98494578c3..f6104f714a8d1 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -853,7 +853,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
>  #define KSZ88_FAMILY_ID			0x88
>  #define KSZ8895_FAMILY_ID		0x95
>  
> -#define KSZ8_PORT_STATUS_0		0x08
> +#define KSZ8_PORT_STATUS_0		0x18
>  #define KSZ8_PORT_FIBER_MODE		BIT(7)

[Severity: Medium]
Should this patch carry a Fixes: tag and a Cc: stable? Signed-off-by is
the only trailer at the moment.

With the old value of 0x08, ksz_switch_detect() reads REG_SW_CTRL_6, where
BIT(7) is SW_MIB_COUNTER_FLUSH and not the fiber mode bit. A real KSZ8765
stays detected as KSZ8795_CHIP_ID. ksz_check_device_id() then fails the
probe with -ENODEV, even with a correct "microchip,ksz8765" DT:

ksz_switch_register()
  ksz_switch_detect()
    ksz_read8(dev, KSZ8_PORT_STATUS_0, &val)
  ksz_check_device_id()
    "Device tree specifies chip %s but found %s, please fix it!"

The original driver, commit e66f840c08a237 ("net: dsa: ksz: Add Microchip
KSZ8795 DSA driver"), read REG_PORT_1_STATUS_0 (0x18), which is correct.

The wrong address appears to come from commit 4b20a07e103f ("net: dsa:
microchip: ksz8795: add support for ksz88xx chips"). That commit replaced
the register with the per-port offset REG_PORT_STATUS_0 (0x08) inside the
same global ksz_read8() call.

Commit 91a98917a888 ("net: dsa: microchip: move switch chip_id detection
to ksz_common") then carried 0x08 into the new KSZ8_PORT_STATUS_0 define.

Would something like this fit?

Fixes: 4b20a07e103f ("net: dsa: microchip: ksz8795: add support for ksz88xx chips")
Cc: stable@vger.kernel.org

[Severity: Low]
This is a pre-existing issue that this patch did not introduce. Now that
this read returns a meaningful bit, should ksz_switch_detect() check the
return value of ksz_read8()?

drivers/net/dsa/microchip/ksz_common.c:ksz_switch_detect() {
    ...
		if (id2 == KSZ87_CHIP_ID_95) {
			u8 val;

			dev->chip_id = KSZ8795_CHIP_ID;

			ksz_read8(dev, KSZ8_PORT_STATUS_0, &val);
			if (val & KSZ8_PORT_FIBER_MODE)
				dev->chip_id = KSZ8765_CHIP_ID;
    ...
}

ksz_read8() copies its local value into *val even when regmap_read()
fails:

drivers/net/dsa/microchip/ksz_common.h:ksz_read8() {
	unsigned int value;
	int ret = regmap_read(ksz_regmap_8(dev), reg, &value);
    ...
	*val = value;
	return ret;
}

On a bus error, the choice between KSZ8765 and KSZ8795 is then made from
uninitialized stack data. If that picks the wrong chip,
ksz_check_device_id() returns -ENODEV with the "please fix it!" message
and the real I/O error is lost.

The other reads in this function (REG_CHIP_ID0, REG_KSZ8864_CHIP_ID and
REG_CHIP_ID4) all check ret and return it.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006130006.134847-1-sebastien.royen%40armadeus.com
