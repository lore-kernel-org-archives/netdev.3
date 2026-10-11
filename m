Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E876A443AB4;
	Sun, 11 Oct 2026 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748289; cv=none; b=sE9A/FsalgJ7dCnVdScGxpT9c4jasnARunWxbOCa3zqtPLLwPQp7DiHG1oeuTFpRpfgypg9N7wucLBl3JFR+lntzs/FBn10jLyspeP3qi9zOcRO7H1xhpxIhIVLiTZBVyvcUqHdB+4BI06yuJ3yXFBPrLpqwK7uvozWhX5Rhftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748289; c=relaxed/simple;
	bh=f6FpqZ6fDrSQv4pH+BbNus34IMgIZbMYcnBFTNx97Hs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vbxli2JHal13SSdQQmG5FMv65s+oOJeENiTmxjC0UhnBizl0xZdMmRhMTfLSv0dMgqt/R+77F6YzpexTx7lSEaF2GLf6n7QsxcPM1v3PRlS8wkYJpr7IENAbF3mWL9szfc2dyjMFOgZPK5y089XgPxt1eDv9sVBQMHS+6SLr9xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4MWi4dN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4MWi4dN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E948B1F0089C;
	Sun, 11 Oct 2026 19:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748287;
	bh=OEnLYupWNFVpWrRQEQKNjOZ/yQ+6620YHEhGcUeoYnk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S4MWi4dN4BNbo8hmdB24k/q4TPPBwB9V3V0qfK6vB/47IbJb+6GWBLEhVyGvDCC30
	 XV00veHARqOBziqNKr48iO5rUt7c2p7BLC7+O172WcjxmqNM+qmRWQHyLd4dZCdkvN
	 AKmE07QHz5rsAKOTLkkyePJaLD/DHqW4BZ8iLTtBi2yozO1XZpRJDEo/74Ppljk6aZ
	 wc44RaOiVMCZpUImtxzHYvvLvrajy3JQlICEg0KeauwvjLskAzCieKD4kwMxxVAneo
	 Pa1KJpY5BScZO/qPTJgxJaJhj4D0SXcH2NKbp+z/7u9zvObRcA42PALJ5KAVwPATgr
	 HtRBcZir3Plsg==
Subject: Re: [PATCH net-next v3 6/9] net: dsa: realtek: rtl8365mb: use raw VID
 for PVID on family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 11 Oct 2026 19:51:26 +0000
Message-ID: <179174828653.434549.15521627518184901889@kernel.org>
In-Reply-To: <13e3fcb3-895e-4c1a-a8f5-70dd9a0ed345@yahoo.com>
References: <13e3fcb3-895e-4c1a-a8f5-70dd9a0ed345@yahoo.com>
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

- [Medium] This patch adds a family D branch to
  rtl8365mb_vlan_port_get_pvid()…

--

net: dsa: realtek: rtl8365mb: use raw VID for PVID on family D

On family D chips, this commit reads the PVID as a raw 12-bit VID from the
per-port register at 0x0700 + port. Family C keeps using the VLAN MC table
index. It also adds direct-VID variants of the PVID set and clear paths
that skip the MC table on family D.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> index 2c4c5baf93f10..ccfa764b98125 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c

[ ... ]

> @@ -742,11 +751,25 @@ int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, u16 *pvid)
>  	u8 vlanmc_idx;
>  	int ret;
>  
> -	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx, &vlanmc);
> -	if (ret)
> -		return ret;
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D) {
> +		u32 data;
> +
> +		ret = regmap_read(priv->map,
> +				  RTL8365MB_D_VLAN_PVID_CTRL_REG(port),
> +				  &data);
> +		if (ret)
> +			return ret;
> +
> +		*pvid = data & RTL8365MB_D_VLAN_PVID_CTRL_MASK;

[Severity: Medium]
Can this report a PVID that the bridge never configured?

The kernel-doc for rtl8365mb_vlan_port_get_pvid() still says:

 * Returns the port PVID if defined or 0 if not.

On family C that holds. An unconfigured port has VLANMC index 0, and
rtl8365mb_vlan_get_pvid_mc() memsets the entry, so evid is 0. On family D
this branch returns whatever the register holds.

rtl8365mb_vlan_setup() only calls
rtl8365mb_port_vlan_filtering(ds, dp->index, false, NULL) for each port
and then sets RTL8365MB_VLAN_CTRL_EN_MASK. Nothing there writes 0 to the
family D PVID registers. The only code that writes 0 is
rtl8365mb_vlan_pvid_port_clear_direct(), and it only does so when the
bridge clears a VID that matches the register.

After rtl8365mb_reset_chip(), the register holds its hardware default or
a value loaded from EEPROM. If that value is non-zero, two callers act on
it.

In rtl8365mb_port_vlan_filtering() with vlan_filtering set:

	if (pvid_vid)
		accepted_frame = RTL8365MB_FRAME_TYPE_ANY_FRAME;

Here, a VLAN-filtering port with no bridge PVID (for example a bridge
with default_pvid 0) would accept untagged frames into the stale VID.

In the undo_set_pvid path of rtl8365mb_port_vlan_add():

	if (pvid_vid)
		(void)rtl8365mb_vlan_pvid_port_set(ds, port, pvid_vid,
						   NULL);

On error, this path would program the stale VID as the PVID.

I couldn't confirm the reset value of these registers from the tree, so
this depends on the hardware or EEPROM default. The family D get_pvid
branch and rtl8365mb_vlan_setup() also look unchanged at the end of the
series.

Should rtl8365mb_vlan_setup() clear the family D PVID registers to 0? That
would match the family C convention of VLANMC index 0 as the neutral
PVID.

> +	} else {
> +		ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx,
> +						 &vlanmc);
> +		if (ret)
> +			return ret;
> +
> +		*pvid = vlanmc.evid;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/e84d76ee-03df-49b0-8c9a-b289dfae8728%40yahoo.com
