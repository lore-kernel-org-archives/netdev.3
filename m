Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925573CFF6A;
	Sat, 10 Oct 2026 05:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791609260; cv=none; b=NO7JgDCpAlsIzmNbQy8/LxUooXPwGSbsq2hhCnXW1NUIQifXF7iUlZ5pUaLJDJptEQl3qUwcQZ+UajDyGl0SNc0LolTcWbHbwvYngRftaoqLirYMi1mwCmPhQGSHFFws/UjtW2LUGi/MXEnL8AtQ2Kn6sAkqE2sL2ITgtrPECt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791609260; c=relaxed/simple;
	bh=gjp0hzB4/se2w0PN88AATbfDhZvcYRHBXz4puBbvN+Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BXOZGQJ+qeGDh3uJwcdvVEPxrrraM3zt9m5Tz1aOra05bT1mlMDRxQ+zOyGfOUDr4ZUop0CPPIafbPuDB3EWhF++016Hve4KFv1W8Lcj36FjyCID6yDWk5JI5dstQpzq17I0UgRMZGFswb2rbKUpbROrr7hsh0k1XUyLryVE6qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgJ1NBOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgJ1NBOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFD91F00893;
	Sat, 10 Oct 2026 05:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791609259;
	bh=j7ylKT/EVB6TudViOAFvT+T2wATe3G/YmELgGKFxjdo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TgJ1NBOEY4frxlysZT0o15zyel43u4k3qT4r05F3K3H/huvQBJMGEfwDKqlvTbl5y
	 ZLYnjIu2ASP0RlAvb12YAYihjaUfGmf9JCNGHSlY0LcLmcMMGLKQm8dfd9oBZVoixj
	 mYAlIWpwwH8mVIg2yBSMU0W94Lw347OBjWgTIggExwqaT4jE0MV5R9QNh1etrvW5mS
	 gyz6krI3oTAAmBzfWX931Is3iMo6+swluhjD01GCRQC6RDNtQgFyWuDLjyteX+wTn0
	 YhUkw9oW1WJCoENyJsazY4+Ou6yLCzfVxL730l5I1iQmTCSm7iWO28PDJG1pxF2j7P
	 05ACIDu5uJYLA==
Subject: Re: [PATCH net-next v2 6/8] net: dsa: realtek: rtl8365mb: set/clear
 pvid for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, alsi@bang-olufsen.dk, andrew@lunn.ch, olteanv@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 05:14:17 +0000
Message-ID: <179160925797.434549.12327289507107214339@kernel.org>
In-Reply-To: <b65ed622-c511-4acb-9661-89ed0615e0b8@yahoo.com>
References: <b65ed622-c511-4acb-9661-89ed0615e0b8@yahoo.com>
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

- [Low] The commit message and the new kernel-doc are inaccurate in two
  places.
- [Low] Several comments are stale after this patch.

--

net: dsa: realtek: rtl8365mb: set/clear pvid for family D

This patch adds a direct-VID path to rtl8365mb_vlan_pvid_port_set() and
rtl8365mb_vlan_pvid_port_clear() for RTL8365MB_FAMILY_D chips. On those
chips, the PVID is written as a raw 12-bit VID to a per-port register, and
the VLAN MC table is skipped entirely.

> The RTL8367S-VB (family D) has no working VLAN member-config (MC)
> table in hardware. rtl8365mb_vlan_port_get_pvid() was already fixed
> to read PVID directly from its dedicated per-port register, but
> rtl8365mb_vlan_pvid_port_set() and rtl8365mb_vlan_pvid_port_clear()
> still went through the MC-index allocation path meant for family C,
> which on family D hardware writes into the wrong register/field
> (colliding with the neighbouring port's real PVID register) and reads
> back a VLAN MC table that does not exist on this silicon.

[Severity: Low]
Is "the neighbouring port's real PVID register" accurate for all ports?

The family-C macros map port p like this, with a 5-bit field at bit offset
((_p) & 1) << 3:

#define RTL8365MB_VLAN_PVID_CTRL_REG(_p) \
		(RTL8365MB_VLAN_PVID_CTRL_BASE + ((_p) >> 1))

On family D, 0x0700 + q is port q's own 12-bit VID register:

#define RTL8365MB_D_VLAN_PVID_CTRL_REG(port) \
	(RTL8365MB_D_VLAN_PVID_CTRL_BASE + (port))

So a family-C write for port p lands in the VID field of port (p >> 1).
Port 0 corrupts its own VID. Only ports 1 and 2 hit a neighbour (ports 0
and 1). Port 3 hits port 1, ports 4 and 5 hit port 2, and ports 6 and 7
hit port 3.

Could the commit message say that port p's write lands in port
(p >> 1)'s PVID register?

Separately, the new kernel-doc for rtl8365mb_vlan_pvid_port_set_direct()
says:

 * the rollback behavior of the family-C implementation above.

The family-C rtl8365mb_vlan_pvid_port_set() is defined below this helper,
though, not above it.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_vlan.c b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> index 0466e8cbc4123..da517b1aae208 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_vlan.c
> @@ -810,6 +810,64 @@ rtl8365mb_vlan_port_set_framefilter(struct realtek_priv *priv,

[ ... ]

>  /*
>   * rtl8365mb_vlan_pvid_port_set() - Configure a port's PVID and associated
>   * VLANMC entry
> @@ -839,6 +897,13 @@ int rtl8365mb_vlan_pvid_port_set(struct dsa_switch *ds, int port, u16 vid,
>  
>  	lockdep_assert_held(&priv->vlan_lock);
>  
> +	/* This chip family has no VLAN MC table - PVID is a raw VID in a
> +	 * dedicated per-port register, and there is no separate membership
> +	 * table entry to allocate/track.
> +	 */
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D)
> +		return rtl8365mb_vlan_pvid_port_set_direct(priv, port, vid);
> +

[Severity: Low]
With this early return in place, should the kernel-doc for
rtl8365mb_vlan_pvid_port_set() be updated too? It still says:

 * rtl8365mb_vlan_pvid_port_set() - Configure a port's PVID and associated
 * VLANMC entry
 ...
 * Allocates or reuses a hardware VLANMC entry to map the given port to its new
 * PVID.

On RTL8365MB_FAMILY_D, rtl8365mb_vlan_pvid_port_set_direct() writes a raw
VID to RTL8365MB_D_VLAN_PVID_CTRL_REG(port) and never touches the VLANMC
table.

The same applies to rtl8365mb_vlan_pvid_port_clear(). Its kernel-doc still
says:

 * Resets the target port's hardware PVID allocation to 0. Cleans up and frees
 * the associated VLANMC entry if no other ports are referencing it.

The new family D branch calls rtl8365mb_vlan_pvid_port_clear_direct()
instead, which does no VLANMC management.

The file header comment also still says, without naming a family:

 * programming of a port-based VLAN ID (PVID). The PVID is programmed on a
 * per-port basis via register field, which refers to a specific VLAN membership
 * configuration via an index 0~31.
 ...
 * VLANMC index 0 is reserved as a neutral PVID, used for standalone ports.

The struct rtl8365mb_vlanmc kernel-doc also still lists "PVID
configuration" as one of the remaining uses of the VLAN membership
configuration database.

Could these comments mention the family D raw-VID path? The "above"
reference in the rtl8365mb_vlan_pvid_port_set_direct() kernel-doc, noted
earlier, is the same kind of stale comment.

>  	/* Read the old PVID exclusively to undo in case of error */
>  	ret = rtl8365mb_vlan_get_pvid_mc(priv, port, &prev_vlanmc_idx,
>  					 &prev_vlanmc);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/28382f3f-03c1-4606-9b11-86f118abeafe%40yahoo.com
