Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484844;
	b=mYGcUhCS0Pkwb0wxPaq8OOC7wsoDadq+2CW5DE3SgCAdn8+rmC3gj1RrN8Bi4X9zNaRL
	 yq9MNXPKi6UkjX5lozo2cIln6lAw1V7a2HhTdcohrlzkdkkKCdLqpBqHHQP5b10kJoE4u
	 bjCmLaKZksFCY1uLZ/3xj8BPTPI3v/L0jI7w/U/SyNYmvziEqike5HqB93Fr58B+4Fzr6
	 bDgHuVSSpq3koaoVHwx+lIiBsyQmFQgEWueQtL8xj5w2MD/wLqhWfVZFtS5ePpRuP7K4U
	 5YYoj2kk/C4HKCwm/C+AgNabOwslA9LfWnyX7Zc34pDujhZfkTuT/Qzkyjy1u2Gjkzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484844;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RgE6qh5s5sRj9jwHdylaP3f2Qab7dZpbONrZPzb6Q24=;
	b=P4p2TdaQfs1M8eFS6cQWsxSoo3LkXK8LHrBQxjczPa/FDwLj1MhIWnY4C/uNFDmCk1+B
	 AQCOi2BNFUrw7IOSiySw3adRQe2wk7PVsMQMBZXyscpXYtyGti/jOWEwL9E6F2DqJxBdX
	 rvsxEqoE4TKsXCRe6YjIUOFzhGZlX1hxwbZT0Zwg8BtWBE8lkPJKodm0YjA1GB3yrlJOc
	 9GwUYwXW9/5dztH9GGlw/McVw0RWswNDLD880xQqMi7Qx8WwTX3Oi9C+ybr6SpcxekBbT
	 dthIR6MX9ooweRo2gn+ObolA00/sf6XJZmFvAQPbBM9G/Ii3fZpxialPmadOZ8mamPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWecKIxK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306C60A2622;
	Thu, 12 Nov 2026 12:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWecKIxK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B991F00ACE;
	Thu, 12 Nov 2026 12:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484844;
	bh=RgE6qh5s5sRj9jwHdylaP3f2Qab7dZpbONrZPzb6Q24=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QWecKIxKs35TuANprpL/3f2b7njVWU06zNP1skmCV8jJmjsplVVOIaG3N5rM1fvcb
	 q6vA5nM/HPHHhq6T+4jCYyMhJfU7GU8IdekVwfl2u2Lbk8Eak7IiwaMrm+MxvYzlP2
	 rd/zFraYKNf5DU0gMHQkhUbZyEgE644qW9FafHub6PczRrvQdSC47A7iOjvoCLzRj3
	 /92bE5Ypm6c1wsICrYRYXl6asMpcnZkn6KTx0T6BswkJtk69w0wxNatNbKYzLZ+ttF
	 D9F7tb0uJLuYVVzsPA4n+hPckYcZJfPg2vVqBkYAS2sxquXkHgUPVQofHvfpbfFUFI
	 QxniGEugdCGXw==
Subject: Re: [PATCH net-next v2 5/7] net: phy: adin1100: Skip the soft reset
 on ADIN1110/ADIN2111
From: netdev-bot+sashiko@kernel.org
To: iustin.stolniceanu@analog.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, parthiban.veerasooran@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, marcelo.schmitt@analog.com,
 alvin.sipraga@analog.com, ciprian.regus@analog.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 12:00:42 +0000
Message-ID: <179448484265.2199510.11571056279428140346@kernel.org>
In-Reply-To: <20261109085952.105331-6-iustin.stolniceanu@analog.com>
References: <20261109085952.105331-6-iustin.stolniceanu@analog.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says the whole-chip CRSM_SFT_RST is "not an
  issue with the generic SPI protocol" because adin1110 configures the…
- [Low] The patch justifies dropping .soft_reset with "The MAC driver
  already resets the chip before attaching the PHY".

--

net: phy: adin1100: Skip the soft reset on ADIN1110/ADIN2111

This patch removes .soft_reset from the ADIN1110 and ADIN2111 entries in
the adin1100 PHY driver. On these MAC-PHYs, CRSM_SFT_RST resets the whole
chip, which would undo the configuration that the upcoming OPEN Alliance
TC6 support does in oa_tc6_init() before the PHY is attached.

> This is not an issue with the generic SPI protocol, where the adin1110
> driver configures the MAC in ndo_open, after phy_connect(). The OPEN
> Alliance TC6 protocol support, added in a following patch, configures
> the device in oa_tc6_init() before the PHY is attached, and the
> configuration would be lost.

[Severity: Medium]
Does this hold on the resume path as well? phy_init_hw() is not only
called at attach time. mdio_bus_phy_resume() also calls it when the PHY
was suspended by the MDIO bus and mac_managed_pm is not set:

drivers/net/phy/phy_device.c:mdio_bus_phy_resume() {
    ...
	ret = phy_init_hw(phydev);
    ...
}

adin1110.c has no dev_pm_ops and never sets mac_managed_pm. The adin1100
driver provides .suspend, so on system resume with the interface up, the
sequence before this patch was:

mdio_bus_phy_resume()
  phy_init_hw()
    adin_soft_reset()
      CRSM_SFT_RST (whole-chip reset)

Would that wipe what adin1110_net_open() programmed: CONFIG2 CRC_APPEND,
the IMASK1 interrupt mask, the MAC address filter slots and CONFIG1 SYNC?
Nothing in adin1110 writes them back. The link can then come up while
the MAC is still at reset defaults, and it stays that way until the
interface is taken down and up.

If so, this patch also fixes an existing resume regression on the generic
SPI path. Could the commit message describe that? And should it carry a
Fixes: tag so stable picks it up? The tag would probably be:

Fixes: 875b718ac380 ("net: phy: adin1100: add PHY IDs of adin1110/adin2111")

> diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
> index b946cb86b6c41..ddb91b0e7081f 100644
> --- a/drivers/net/phy/adin1100.c
> +++ b/drivers/net/phy/adin1100.c
> @@ -341,7 +341,6 @@ static struct phy_driver adin_driver[] = {
>  		PHY_ID_MATCH_MODEL(PHY_ID_ADIN1110),
>  		.name			= "ADIN1110",
>  		.get_features		= adin_get_features,
> -		.soft_reset		= adin_soft_reset,

[Severity: Low]
With .soft_reset gone, does anything on the generic SPI path still wait
for the chip reset to finish before the PHY is accessed?

The commit message says "The MAC driver already resets the chip before
attaching the PHY". However, adin1110_probe() writes the reset and goes
straight to MDIO bus registration:

drivers/net/ethernet/adi/adin1110.c:adin1110_probe() {
    ...
	ret = adin1110_write_reg(priv, ADIN1110_RESET, ADIN1110_SWRESET);
	if (ret < 0)
		return ret;

	ret = adin1110_register_mdiobus(priv, dev);
    ...
}

There is no sleep and no poll of STATUS0.RESETC there. The commit message
itself says MDIO reads return stale data until the reset completes. The
oa_tc6 patch in this series ("net: ethernet: oa_tc6: Allow custom reset
settle time values") says the ADIN1110 can need up to 10 ms after a
software reset.

Before this patch, phy_connect()->phy_attach_direct()->phy_init_hw()->
adin_soft_reset() polled for SYS_RDY:

	return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1, ADIN_CRSM_STAT, ret,
					 (ret & ADIN_CRSM_SYS_RDY),
					 10000, 30000, true);

That was the only readiness check on this path. phy_init_hw() now goes
straight to config_intr(), which does a read-modify-write of
ADIN_PHY_SUBSYS_IRQ_MASK. phy_attach_direct() then calls adin_resume().
Either of these can run inside the reset window.

The practical impact looks small, since the MDIO scan already raced this
reset before the patch.

The TC6 path handles this in oa_tc6_sw_reset_macphy(): it calls fsleep()
for the settle time and then polls RESETC. Could adin1110_probe() do the
same before calling adin1110_register_mdiobus()?

>  		.probe			= adin_probe,
>  		.config_aneg		= adin_config_aneg,
>  		.read_status		= adin_read_status,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109085952.105331-1-iustin.stolniceanu%40analog.com
