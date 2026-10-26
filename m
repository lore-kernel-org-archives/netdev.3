Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008137;
	b=YRCOP9YVCjGTEXJXvqoQedxGqM+8pXQJuQ5hq/oh9LxKbru/wJ9GH1TLoN+/m8UBKRcj
	 ZbNgKdZUsNal/mer+9e4cEQwm/+yAlKX3MnMA5GA5dISyLkm4Dvz6pCzml8nhJgxBKfb1
	 oIlQAfSdCqZXHrmRd0C20lTjbawmeLNc0CWp3ivYp7DUosUiQCQQNjCwWkLlfZ3kQ2uFy
	 0EcmZ3YUYNlyX8sfQCWEqDcJpP81Av9vFqyilJz6zy1Wt5urzT3zul9IW30jBFdW3EJo2
	 2f6/rCvdW5u/CAk0YUZi6YMaeUpxKlX95KzHdMUVs/V0ex1GXVUeMSnlj0XvuGdM1Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008137;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ut5cOuwAwWWbw+hIJ5YB12u8I1Xh3pMKEfgeNTBtJqc=;
	b=ZGow3/1qGdRIIdJq/6PaAWIdldhrwhMjXpWmh0XLdusE0UvSg855zuKSrtqkGC1gtfEv
	 G1MSWxuIA9cmlN8kD9cD1GaFueubTyvM9PNLbqz+yBkOxb1GDg9qFKRPsjHxmb93sS/Kw
	 UFQWqhNTxDp1GMVCjviTLnl4XFiWXYciZYJoX8SaTPCKtO6X5d9f3Xo6WxBZ0UvKSoK1h
	 gTUguq4oBsDKt1Me3oil6DUawUEnTZPTC2JYpaJTHvYLCPr0E29lbBfO249ICPQ2mjrSX
	 mHlnQH7HG05dubKcc/dF1AggG5MfjFRgYvP6p7eJ3M7SIpUIzel2ZGcYLrDV4HAqtVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNMBzXia;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D736606A31F;
	Mon, 26 Oct 2026 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNMBzXia
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6AC1F01825;
	Mon, 26 Oct 2026 09:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008137;
	bh=Ut5cOuwAwWWbw+hIJ5YB12u8I1Xh3pMKEfgeNTBtJqc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oNMBzXiaKeZF3qShUTtc8iYhVDhW4laMBXVkpWCIzwn4dj2FVcar6PqFFklifK8/U
	 /7dFi0ne7iAoaYwuAfgadnnJipxdnYiMp+aF2opLMFIAHbeaoEybqFdmnejNWtHj+v
	 GBTGMVBLxLVWZUVbjcw5X0YCNTXM33MwsWcKnxzvY0ltDxD3H+LlZdhkdNlmU2rGQ4
	 7NhxbBrMJ8eELCy6kO1dCemZCCf3QpB0bM7nwLzn3rdw9eEskcIJdbd6r8XgRQLLJ0
	 OUIhJ/udMTgob0gApY7LEU/Z5xuAAtSS0rMVwTY9E03mxvrmDn7FC0zaZYLBGiCpgG
	 dIMNJ0c7WTFKQ==
Subject: Re: [PATCH net-next v4 1/2] net: phy: aquantia: restore EEE discovery
 in get_features callbacks
From: netdev-bot+sashiko@kernel.org
To: hongmei.xu@oss.qualcomm.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 09:48:56 +0000
Message-ID: <179300813648.3134.9297051486113517048@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261022-net-phy-aqr113c-fix-pma-capability-v4-1-9?=
 =?utf-8?q?5a17f75dd7a=40oss=2Equalcomm=2Ecom=3E?=
References: =?utf-8?q?=3C20261022-net-phy-aqr113c-fix-pma-capability-v4-1-95?=
 =?utf-8?q?a17f75dd7a=40oss=2Equalcomm=2Ecom=3E?=
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

- [Medium] net: phy: aquantia: premature and unmasked EEE read in
  aqr115c_get_features()
- [Low] aqr115c_get_features()
  (drivers/net/phy/aquantia/aquantia_main.c:1082) now ends with `return…

--

net: phy: aquantia: restore EEE discovery in get_features callbacks

This patch makes aqr115c_get_features() call
genphy_c45_read_eee_abilities() after it builds the supported mask, so
supported_eee gets filled in for AQR111, AQR111B0, AQR114C, AQR115,
AQCS109 and AQR115C. It also makes aqr111_get_features() pass on the
return value of aqr115c_get_features().

> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index e95d391a6dc2..099ee919de94 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -1079,15 +1079,17 @@ static int aqr115c_get_features(struct phy_device *phydev)
>  	linkmode_or(supported, supported, phy_gbit_features);
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
>  
> -	return 0;
> +	return genphy_c45_read_eee_abilities(phydev);
>  }
>  
>  static int aqr111_get_features(struct phy_device *phydev)
>  {
> -	/* PHY supports speeds up to 5G with autoneg. PMA capabilities
> -	 * are not useful.
> -	 */
> -	aqr115c_get_features(phydev);
> +	int ret;
> +
> +	ret = aqr115c_get_features(phydev);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Two related problems here. The 2.5G-only parts can end up with
supported_eee out of sync with supported. In aqr111_get_features(),
the EEE read also runs before the final supported mask is built.

genphy_c45_read_eee_abilities() reads 3.20 via
genphy_c45_read_eee_cap1(). That function masks the result against
supported:

	linkmode_and(phydev->supported_eee, phydev->supported_eee,
		     phydev->supported);

It then reads 3.21 via genphy_c45_read_eee_cap2(), which only does:

	mii_eee_cap2_mod_linkmode_sup_t(phydev->supported_eee, val);

That helper sets 2500baseT_Full and 5000baseT_Full straight from
MDIO_EEE_2_5GT and MDIO_EEE_5GT. Nothing masks that result against
supported afterwards, either here or in phy_probe().

For AQR115C, AQR115 and AQCS109, supported stops at 2500baseT_Full.
The commit message itself says these PHYs misreport their
capabilities. If 3.21 also reports 5GT on them, supported_eee ends
up with 5000baseT_Full on a 2.5G PHY. phy_probe() only intersects
advertising_eee with supported_eee, so a 5G EEE advertisement can
survive into advertising_eee. ethtool --show-eee would then list
5000baseT/Full on a PHY that cannot link at 5G.

The ordering in aqr111_get_features() does not match the commit
message, which says the EEE read happens after the final supported
mask is built. Here aqr115c_get_features(), and with it the EEE
read, runs before 5000baseT_Full is added to supported. For 5G this
only works because cap2 is unmasked.

For cap1 modes it breaks. Patch 2/2 has the AQR113C get_features()
chain onto aqr111_get_features() before it sets 10000baseT_Full. So
the linkmode_and() in genphy_c45_read_eee_cap1() strips
10000baseT_Full from supported_eee while 10G is not yet in
supported, and it never comes back.

Could the EEE read be done once per driver, after that driver's
supported mask is complete? For example, keep the mask building in a
shared helper and call genphy_c45_read_eee_abilities() last in each
get_features(). A linkmode_and() of supported_eee against supported
after that would keep 3.21 from adding modes the PHY lacks. Or do
you think genphy_c45_read_eee_cap2() should apply the same mask that
cap1 already does?

[Severity: Low]
Should the result of genphy_c45_read_eee_abilities() be passed back as
the ->get_features() result here?

With this change, if reading the optional EEE ability registers (3.20
MDIO_PCS_EEE_ABLE or 3.21 MDIO_PCS_EEE_ABLE2) fails, aqr115c_get_features()
fails, and so does aqr111_get_features(). phy_probe() then aborts:

drivers/net/phy/phy_device.c:phy_probe() {
    ...
	else if (phydrv->get_features)
		err = phydrv->get_features(phydev);
    ...
}

The phylib core ignores the return value of this helper on purpose at
all three of its call sites. genphy_c45_pma_read_abilities() and
genphy_read_abilities() both have:

	/* This is optional functionality. If not supported, we may get an error
	 * which should be ignored.
	 */
	genphy_c45_read_eee_abilities(phydev);

The phydrv->features branch of phy_probe() also ignores it:

	if (phydrv->features) {
		linkmode_copy(phydev->supported, phydrv->features);
		genphy_c45_read_eee_abilities(phydev);
	}

The commit message says it restores EEE discovery. The code path it
restores, genphy_c45_pma_read_abilities() as used before 17cbfcdd85f6
and 8f61d73306c6, never failed probe because of EEE discovery.

In practice this is hard to hit. aqr107_probe() already reads VEND1
registers in aqr_wait_reset_complete() and fails probe on read errors.
That mostly leaves a transient MDIO bus error during this exact read as
the newly fatal case.

Would it match the core better to call genphy_c45_read_eee_abilities()
without passing its result back, and keep return 0?

> +
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
>  			 phydev->supported);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-net-phy-aqr113c-fix-pma-capability-v4-0-95a17f75dd7a%40oss.qualcomm.com
