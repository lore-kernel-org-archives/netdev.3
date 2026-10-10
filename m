Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4343DBD43;
	Sat, 10 Oct 2026 05:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609259; cv=none; b=e+lNPhluQBIBY6b5XaTgGHO1kBxs1WaLiAz8/3y1D1PK36aQXjlMLTc145ww/CtuTgYa00x8pWZzwaBPCW0xTstBbZPzsmcjVarsmYL9N3Cx9wF4JVzvynGEUlyiggMjAWjTJsaR6E8feZ4qA2kMJrK0IWntaW57cdDpaOA0Kxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609259; c=relaxed/simple;
	bh=ccffT9k65X2e5hyKkZGLUbqBP7Utixj7WCVOWlAOcOs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V0rNdzmbQiyTEvc4r+lyM30iji1lSxwvwQGJyMyNg3MDKzqgnYyJ83tpMO+0BTsiMlMpb1/NUcshWr6KrkKezkJVni/KVMRTHuXJ8Vqal0eNoCuiW79szjd3HYvbX538Q5QIRQzH7kfveca8KBfa128XF/T7dloCMgF6t+XEOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om8kGrju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om8kGrju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C921F000FF;
	Sat, 10 Oct 2026 05:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791609257;
	bh=S+7SxJJF2e2C6SrlZL11OcXnqaOExIveVR99YvWehtI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Om8kGrjuaUjfkxO4IAvFu3OhryFsvA/5ukCyTto34tN3fvDc002H/DBu3/5TyHUQL
	 H3cdwuYFlzcdqHQ2kG9pugC1YiwvVLZt2geE4XzzznmsWwW4sRau7eqWsTrP9+c6y7
	 P6EsbAkN8xsIS6VjwrUq4lmUVFTlQ+w+KujIHOV8bOOWh2ZkeiiVpIAXBaMVTl/R8+
	 rjVtahaULlVi/AK6aP+KL31sXUDM2VNSvQ1fktTYXNkIp5yCr/Dzb/gvAjfhKNvC3y
	 WKasyz49qK3e6S0dEXaFRV5uFSVP0Zg7z84oN34/Gztb7WJo44Molv+9+FN7KZPK3r
	 qUSQJ+X1S0/GQ==
Subject: Re: [PATCH net-next v2 3/8] net: dsa: realtek: rtl8365mb: get pvid
 for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 05:14:16 +0000
Message-ID: <179160925651.434549.11653230490116316082@kernel.org>
In-Reply-To: <522f75c1-28fc-4163-88e2-63c36502c60e@yahoo.com>
References: <522f75c1-28fc-4163-88e2-63c36502c60e@yahoo.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] At this commit only rtl8365mb_vlan_port_get_pvid() is converted
  to the family D layout.

--

net: dsa: realtek: rtl8365mb: get pvid for family D

On family D chips, this commit changes rtl8365mb_vlan_port_get_pvid() to
read the PVID directly from a per-port register at 0x0700 + port, taking
bits [11:0]. Family C keeps the old lookup through the VLAN MC table
index.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> index 8d49ffadce926..7add1fb1bea19 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c

[ ... ]

> @@ -679,11 +685,22 @@ int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, u16 *pvid)
>  	u8 vlanmc_idx;
>  	int ret;
>  
> -	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &vlanmc_idx, &vlanmc);
> -	if (ret)
> -		return ret;
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D) {
> +		u32 data;
> +
> +		ret = regmap_read(priv->map, RTL8365MB_D_VLAN_PVID_CTRL_REG(port), &data);

[Severity: Low]
At this commit, do the family D reader and writers use different register
layouts?

The new branch reads 0x0700 + port and treats bits [11:0] as a VID. The
writers are not changed, so on family D they still use the family C
layout. rtl8365mb_vlan_port_set_pvid() writes a 5-bit MC index into
0x0700 + (port >> 1):

drivers/net/dsa/realtek/rtl8365mb_vlan.c:rtl8365mb_vlan_port_set_pvid() {
    ...
	val = vlanmc_idx << RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_OFFSET(port);
	ret = regmap_update_bits(priv->map,
				 RTL8365MB_VLAN_PVID_CTRL_REG(port),
				 RTL8365MB_VLAN_PVID_CTRL_PORT_MCIDX_MASK(port),
				 val);
    ...
}

rtl8365mb_vlan_pvid_port_set() and rtl8365mb_vlan_pvid_port_clear() also
still read the old state through rtl8365mb_vlan_get_pvid_mc(). So on
family D at this commit, reading the PVID back after
rtl8365mb_vlan_pvid_port_set() would not return the VID that was set.
That affects callers such as rtl8365mb_port_vlan_filtering() in
rtl8365mb_main.c.

This is resolved later in the series. The commit "net: dsa: realtek:
rtl8365mb: set/clear pvid for family D" adds family D dispatches at the
top of rtl8365mb_vlan_pvid_port_set() and rtl8365mb_vlan_pvid_port_clear().
Those dispatches go to rtl8365mb_vlan_pvid_port_set_direct() and
rtl8365mb_vlan_pvid_port_clear_direct(), which use the same
RTL8365MB_D_VLAN_PVID_CTRL_REG(port) / GENMASK(11, 0) layout as this
getter.

Also, the family D chip (ID 0x6642) only starts probing with "net: dsa:
realtek: rtl8365mb: detect RTL8367S-VB" later in the series. So no
existing setup is affected.

Could the getter and the set/clear conversion be merged into one commit,
or reordered? That would keep the family D read and write paths
consistent at every point in the series.

> +		if (ret)
> +			return ret;
> +
> +		*pvid = data & RTL8365MB_D_VLAN_PVID_CTRL_MASK;
> +	} else {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/28382f3f-03c1-4606-9b11-86f118abeafe%40yahoo.com
