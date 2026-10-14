Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760A54CEE4B;
	Wed, 14 Oct 2026 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968210; cv=none; b=f9arGCQsWnHhpnMxhLfxTPUwxl4lmoAIMGnfQl0rvjYQUqNERjF4Xbvrny02HhPxozmiFgnkW+QamLyrA0EQPpSOnrdUf65IGpDpeubOSn6GUZF0+S9qWeS9YAkbZkkNhFXgvN41uvlsBdgO0BhCZKVI+Wb7BUcEAH2klLF7+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968210; c=relaxed/simple;
	bh=EDZak8+h+Y4UcrWafBLfeRLdBpahCbd3fbP4HO/CZyw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eQ3he8EGNlIejIObP7bKMBEiBhntDTKh5O10/JB3/Cuvs/Fs4N4/04kD+ORKX35GPWBBcGRlyPE3p8H/c9IOWwhF8uRTGpwkNjjYwujti79fyUZCuVl58myxTbwcT9c6H9037Sphvlqm1veAQ3Oj4sdx8jNPChkERlpixiIOvgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTRRwZYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTRRwZYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6570D1F00898;
	Wed, 14 Oct 2026 08:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791968206;
	bh=eN1VO0KeY8c3I3DHtgB3bRfOcPx/YQ1roINXCBrLLTI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aTRRwZYQvCoA3gDADnTpdJnDOVq9jiDFr42XqdfWkZcgXw5kfCwR8YpxRIx6QhvKw
	 TkJzpfLihuH6S/wmq/QBA2tkCDcvNxCtv5C2OReJqY/km4kgYwkNbr6gW45mJN38s7
	 oOde9bGi/j0jSu6nwSkclqarfNKSwPs/EaZp/l0wJRV+Zh7o5hVX2vF0vZhti2GmqO
	 eFz99y2ouAMUKQGna99dADon/CJ8SfJJ8Zk3LM4HCr6hQ6StvrJ/21Ei4zZRzTMTOO
	 PzykS2F86QSyVUJfxhmOKp7qow+/9NOo+xCgtiM9VE8T9Jc2G8QcP9tb9Ohz0JvN1a
	 PIUL3io2NaZOw==
Subject: Re: [PATCH net-next v5 7/9] net: dsa: realtek: rtl8365mb: add family
 D SDS13 PCS support
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 08:56:44 +0000
Message-ID: <179196820499.434549.15338494683852265589@kernel.org>
In-Reply-To: <2699037c-3cb9-40b6-b02b-8d20934729f9@yahoo.com>
References: <2699037c-3cb9-40b6-b02b-8d20934729f9@yahoo.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Consider family D port 6 in SGMII with managed = "in-band-
  status" and no PHY.

--

net: dsa: realtek: rtl8365mb: add family D SDS13 PCS support

This extends the rtl8365mb SGMII/HSGMII PCS code to family D switches. On
those switches the CPU SerDes is reached through the indexed SDS13 window,
and the SDS_MISC layout differs from family C. For family D,
pcs_link_up() becomes a no-op and the link is forced only from
mac_link_up().

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 9ba31dfb161c8..6c51f4805b595 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1636,6 +1740,17 @@ static void rtl8365mb_pcs_get_state(struct phylink_pcs *pcs,
>  	if (!state->link)
>  		return;
>  
> +	if (is_d) {
> +		/* Only 2500base-x is a fixed rate; for the other modes keep
> +		 * the speed and duplex phylink passed in.
> +		 */
> +		if (state->interface == PHY_INTERFACE_MODE_2500BASEX) {
> +			state->duplex = DUPLEX_FULL;
> +			state->speed = SPEED_2500;
> +		}
> +		return;
> +	}
> +

[Severity: Medium]
On family D in SGMII mode with no PHY, can phylink pass SPEED_UNKNOWN to
mac_link_up() here?

Take port 6 with phy-mode = "sgmii", managed = "in-band-status" and no
phy-handle. rtl8365mb_pcs_inband_caps() only reports LINK_INBAND_DISABLE.
That makes phylink_pcs_neg_mode() pick PHYLINK_PCS_NEG_OUTBAND, and since
there is no phydev the mode stays MLO_AN_INBAND.

phylink_resolve() then gets the link state through
phylink_mac_pcs_get_state(), which seeds speed and duplex like this:

drivers/net/phy/phylink.c:phylink_mac_pcs_get_state() {
    ...
	} else {
		state->speed =  pl->link_config.speed;
		state->duplex = pl->link_config.duplex;
    ...
}

phylink_create() sets link_config.speed/duplex to SPEED_UNKNOWN and
DUPLEX_UNKNOWN, and nothing updates them on this path.

When the SerDes reports link up, the family D branch above only overrides
speed and duplex for 2500BASEX. For SGMII it returns with SPEED_UNKNOWN
still set. The call chain would then be:

phylink_link_up()
  rtl8365mb_phylink_mac_link_up()
    rtl8365mb_ext_config_forcemode()
      dev_err(..., "unsupported port speed %s\n", ...)
      return -EINVAL

mac_link_up() returns void, so phylink still marks the link up and turns
the carrier on. However, the family D MAC force register is never
programmed, so wouldn't the port show link up and pass no traffic?

Family C avoids this because its pcs_get_state() reads speed and duplex
back from SDS_MISC. This also seems to still be present at the end of the
series.

Could the family D branch report a concrete speed and duplex for SGMII as
well, or otherwise avoid returning link up with an unknown speed?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/aa5fa12c-e43e-4e5e-9f77-c6eaf477abc4%40yahoo.com
