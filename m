Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008139;
	b=tMDj17+Ua3PmPgHWeWi40OUZQXF+lmaFmB40Q+EzUXUJBQ/x8uh/H7gpJM4RFXeEmMxb
	 7d7P9BbSFdNNUer/DLQYsefa5+ElueSjcNtMCsnIU+AbGdr2Y9jQ6N++6ezfDg6GVn9nQ
	 fEHF57wZ+owA/k46uOGd1yuMnf9NBeyxV0gU29sBLOB7BcgSaJG803KOfqQiUXA60Dof1
	 jDXcjfvfXWIZa518hR+XnHbB6ZuiHzXVgVFbozJcSP9pLl58oCO3pK8kYJ06zE+3eCNh7
	 vQQdeWqZePr9AoDg5pq++FgdAggBV/rNz4J7KRkQ7oZ0GtS5tywG+9JT0dI5LpcTTPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008139;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=WyKK1CAEFSEVJm3M6nU8KNp47IQ4TKjIr1NibyfyJl0=;
	b=rDjeWpnW/4ila27nY5FZURKGL9eOQ5MljIyjaDoQ9rfWBfPw3FRkG+W0wBsjUrcVrsDA
	 ZR0qDjr2W3CbH0a/ExngRr5igiS0Lw/cIREdV5zvFFTplrpz05WItr+bJ7ZJ1fswINy6X
	 My8iIygoGORYgMQZ53tKzLYCuUKO4nC3wY91XItEWMIV22P8jfy1j8fxeFbbdyq57sCTF
	 qmPbnrslDE3hlDsWDFqVJKV/Ndnn1hQs8zt5nhoK+VCtkuqKscpF5V1Urjf3y2QjNTbuL
	 hoYHSadcm0BJXWr/zVdAODV62flSfUcZ1RigiYjXeiKogAu7TT2uNEa7v7fNjju/poQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcsbAkY1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D54606A330;
	Mon, 26 Oct 2026 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IcsbAkY1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC701F01825;
	Mon, 26 Oct 2026 09:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008138;
	bh=WyKK1CAEFSEVJm3M6nU8KNp47IQ4TKjIr1NibyfyJl0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IcsbAkY1WFzUmG+pYlqwEtui1FGPB/IPjkQ5TpRXvQ9WJhovvGFcGJZ7TnmETCIEw
	 uOorztLEZb80y6/+u8B5ODNbdl6+Fq65uMfpOCbkC07cAbL8DJFUxbji0VnCwDUrBX
	 8oVPLSlWmzH3UTgqS9yi/PoZ9wQLm2jVM+B3HNMpCmzVDD5ViM1w+tZlq5lwGezilY
	 xrbxuu4MEW6xYaMl8q70ghUBQ9+diDv52a/dnHjjMQ+yai2qmaEjEOlpEFqGIF97t5
	 XSG9vGw8XP89NjzXlaMmQQtmW+5WywBYfEQFC5FsBdrSuHsl1nM9NYAJ0aXwTzn9pu
	 vRhnuWmQSN3Vg==
Subject: Re: [PATCH net-next v4 2/2] net: phy: aquantia: add get_features()
 for AQR113C
From: netdev-bot+sashiko@kernel.org
To: hongmei.xu@oss.qualcomm.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 09:48:57 +0000
Message-ID: <179300813766.3134.9194099464144589935@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261022-net-phy-aqr113c-fix-pma-capability-v4-2-9?=
 =?utf-8?q?5a17f75dd7a=40oss=2Equalcomm=2Ecom=3E?=
References: =?utf-8?q?=3C20261022-net-phy-aqr113c-fix-pma-capability-v4-2-95?=
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] aqr113c_get_features() adds 10000baseT_Full to
  phydev->supported only after EEE discovery has already run, so…
- [Medium] The commit message describes the fix's mechanism incorrectly.

--

net: phy: aquantia: add get_features() for AQR113C

This adds an aqr113c_get_features() callback for the AQR113C. It builds on
aqr111_get_features() and then sets 10000baseT_Full in the supported mask.
Previously phy_probe() fell back to genphy_c45_pma_read_abilities(), which
the commit says produces an incorrect supported mask for this PHY.

> Add aqr113c_get_features() that calls aqr111_get_features() as a base
> (which reads PMA abilities and forces 1G/5G/2.5G that the PHY misreports)
> and sets 10000baseT_Full explicitly since the PHY also misreports 10G.

[Severity: Medium]
Is this description of aqr111_get_features() accurate? It calls
aqr115c_get_features(), which does not read any PMA ability registers:

drivers/net/phy/aquantia/aquantia_main.c:aqr115c_get_features() {
	/* PHY supports speeds up to 2.5G with autoneg. PMA capabilities
	 * are not useful.
	 */
	linkmode_or(supported, supported, phy_gbit_features);
	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);

	return genphy_c45_read_eee_abilities(phydev);
}

The only hardware read in this path is for the EEE abilities. MDIO_STAT2,
MDIO_PMA_EXTABLE and MDIO_PMA_NG_EXTABLE are never read, so this patch
moves AQR113C from a mask built from the registers to a fully static one.

The message also leaves out a side effect. phy_gbit_features includes
1000baseT_Half and the 10/100 half and full duplex modes, so these are now
always in supported. aqr_config_aneg() will then advertise 1000BASE-T half
duplex:

	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
			      phydev->advertising))
		reg |= MDIO_AN_VEND_PROV_1000BASET_HALF;

The previous genphy_c45_pma_read_ext_abilities() path never set this bit.
AQR111, AQR114C and AQR115C already behave this way, but could the change
be mentioned in the message?

The new comment in aqr113c_get_features() says only 10G is misreported in
the PMA extended abilities. The commit message says 1G, 2.5G, 5G and 10G
are all misreported. Could the message and the comment be brought in line
with what the code does?

The inherited "up to 2.5G" comment in aqr115c_get_features() is also stale
now that a 10G PHY uses it.

> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index 099ee919de94..153adfbda53f 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -1096,6 +1096,23 @@ static int aqr111_get_features(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int aqr113c_get_features(struct phy_device *phydev)
> +{
> +	/* AQR113C does not correctly report 10G in PMA extended abilities.
> +	 * Build on aqr111_get_features() for 5G/2.5G and add 10G explicitly.
> +	 */
> +	int ret;
> +
> +	ret = aqr111_get_features(phydev);
> +	if (ret)
> +		return ret;
> +
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +			 phydev->supported);

[Severity: Medium]
10000baseT_Full is set here only after EEE discovery has already run. Does
that mean AQR113C always loses 10GBASE-T EEE?

The call chain is:

aqr113c_get_features()
  aqr111_get_features()
    aqr115c_get_features()
      genphy_c45_read_eee_abilities()
        genphy_c45_read_eee_cap1()

At that point supported holds only the gbit modes and 2500baseT_Full.
genphy_c45_read_eee_cap1() maps MDIO_EEE_10GT from register 3.20 into
supported_eee and then masks it against supported:

	mii_eee_cap1_mod_linkmode_t(phydev->supported_eee, val);
	...
	linkmode_and(phydev->supported_eee, phydev->supported_eee,
		     phydev->supported);

10000baseT_Full is not in supported yet, so the 10G EEE bit is cleared.
Nothing reads the EEE abilities again afterwards: phy_probe() only calls
genphy_c45_read_eee_abilities() in its drv->features branch.

After that, phy_probe() ANDs advertising_eee with supported_eee. Then
genphy_c45_an_config_eee_aneg() writes the reduced mask to MDIO_AN_EEE_ADV,
which looks like it would clear any default 10GT EEE advertisement in the
hardware.

genphy_c45_ethtool_set_eee() would also return -EINVAL for a 10G EEE
request:

	if (linkmode_andnot(tmp, adv, phydev->supported_eee)) {

5G is not affected, because cap2 is not masked against supported.

Before this patch 10G was missing from supported entirely, so this is not
a loss compared to the old state. However, supported and supported_eee now
disagree on 10G.

The earlier commit "net: phy: aquantia: restore EEE discovery in
get_features callbacks" put EEE discovery at the end of
aqr115c_get_features() so that supported would be final by then. With this
nesting, that no longer holds for a cap1 mode.

Would it work to set all the forced modes before calling
genphy_c45_read_eee_abilities()? For example, the EEE read could move to
the end of each top-level get_features callback.

> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022-net-phy-aqr113c-fix-pma-capability-v4-0-95a17f75dd7a%40oss.qualcomm.com
