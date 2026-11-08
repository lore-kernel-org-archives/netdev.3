Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794127427;
	b=g10sUEVXD5kMu/r9a4UI4lIytT8OjIs55mofJai+ua9d3tBlsA3YBgtrk2YhtMs3bMjq
	 mltICnhg6Xw97f+VNZTgjaoVH8polwvN8ncwhoN7CVXB2NG1HDLVkDEzeaeOx5d9eWCPk
	 Nx3rYULJ1Hx7jDUO4CxMIbTpe6W5KtJg6DD1Ac8sy8Kx34eg6iJw7xfxRAr0yGAy2aIl0
	 IbSjftKfKVdbxcJKg9LvatmsmpZx9xRXusHCOGv6JrQ78uASiFialgYzB6oK+aze20PxI
	 XdkRmEUsG1w3ihNe/zcUXl1gTtK8dTXIIcWyMJdKBUn0nEVQqPUZk9BCynns/NQZnpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794127427;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=D03DLPhiUbatlmzCbhFPIl/sOaArPvqf62qjeV0nhO0=;
	b=CGtOoYxsbyxqSO8lzD+BimA2gnIA9F41WMPR3MYEwDWtnzeP2IMLvVZbdtejeEBCYavb
	 GVfSkvIp8TUK78HoxwOm6vHINcdFk+HOsucL1dn0Umwj9N0WHffO3vWCdIVM7pljHsq21
	 XTboCF7/M/qltqywnBNuEQfwKWp+z2azOPaT6gKpTVDYzlLoMI5Qk6cjWKym+VSlmoSVP
	 kEhW9OjL2IVToV29T3zgKinDAT2U7Rp0u1+X2tlIZb/HmCJRZeEl5mEU0LUPVjoom9P6g
	 DsCPLwRspF1q9L2e9cHd+Jv0jydgA31YxK7C5wnjWejoWunV05E+aDGWGAo/RougxRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYVl7s+w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACDF606A321;
	Sun,  8 Nov 2026 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYVl7s+w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE96E1F0089F;
	Sun,  8 Nov 2026 08:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794127426;
	bh=D03DLPhiUbatlmzCbhFPIl/sOaArPvqf62qjeV0nhO0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JYVl7s+wHQYByJI7xny9hgmFDi/syrj/lODnMBpEfM7QlDOj0RkFyc9VoU/quGTHT
	 Tx8ilQri/nRj/ahIxxIxx6Hf6bAHLeTmSRiY96ucTcGEKbVWwOOGADUm5wvDIkTMN+
	 lIZJItcKdadxjbOxJ3/HxCutN9GAmfg/QFrPfQpiWWFZZq8qN3eSXQdvc7NvrNslpL
	 lZgDASslv3nuJf/yt096NQDzmQV0DLgS0g0UVyWkmK3jfO4u9Ib9kbv3JbM/TGDPsR
	 /jLyiTqPBvSw4xHl1Mme+/XlLEIgeEGdUl1w/9cJMQqVVb99YdNUVSnJbxPWS4KRnu
	 WjgLdp30JmxnA==
Subject: Re: [PATCH net 2/2] net: dsa: realtek: rtl8365mb: keep the neutral
 PVID in VLAN-unaware bridges
From: netdev-bot+sashiko@kernel.org
To: stijncleynhens@gmail.com
Cc: netdev@vger.kernel.org, linusw@kernel.org, luizluca@gmail.com,
 alvin.sipraga@analog.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 namiltd@yahoo.com, linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 08:43:45 +0000
Message-ID: <179412742527.994134.15454493035066829519@kernel.org>
In-Reply-To: <20261104082514.2139278-3-stijncleynhens@gmail.com>
References: <20261104082514.2139278-3-stijncleynhens@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch keeps untagged frames of VLAN-unaware bridge ports on
  the neutral PVID (VID 0).

--

net: dsa: realtek: rtl8365mb: keep the neutral PVID in VLAN-unaware bridges

This commit stores the PVID that the bridge requests for each port. It only
writes that PVID to the hardware while the port filters VLANs. Ports of a
VLAN-unaware bridge stay on the neutral PVID (VLANMC index 0, VID 0), so
their untagged frames are looked up against the VID 0 FDB and MDB entries
that DSA installs.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index b90e46c165bf8..a7db267bc8816 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -2004,6 +2007,41 @@ rtl8365mb_port_set_vlan_egress_mode(struct realtek_priv *priv, int port,
>  			RTL8365MB_PORT_MISC_CFG_VLAN_EGRESS_MODE_MASK, val);
>  }
>  
> +/* Program the PVID that the port should use for untagged frames: the PVID of
> + * the bridge while the port filters VLANs, and the neutral PVID (VID 0)
> + * otherwise. A VLAN-unaware bridge, like a standalone port, gets its FDB and
> + * MDB entries with VID 0 from DSA. As the switch looks up its forwarding
> + * database by the VLAN that it classifies a frame to, a bridge PVID would make
> + * those entries miss every lookup.
> + */
> +static int rtl8365mb_port_commit_pvid(struct dsa_switch *ds, int port,
> +				      bool vlan_filtering,
> +				      struct netlink_ext_ack *extack)
> +{
> +	struct realtek_priv *priv = ds->priv;
> +	struct rtl8365mb *mb = priv->chip_data;
> +	u16 hw_pvid, pvid = 0;
> +	int ret;
> +
> +	lockdep_assert_held(&priv->vlan_lock);
> +
> +	if (vlan_filtering)
> +		pvid = mb->ports[port].bridge_pvid;

[Severity: High]
Ports of a VLAN-unaware bridge now classify untagged frames to VID 0. Since
the preceding commit "net: dsa: realtek: rtl8365mb: use IVL in VLAN 0",
can bridged multicast now match VID 0 MC entries that belong to someone
else?

The hardware MC entry is keyed only by MAC and VID. Member masks from all
databases are ORed into the same slot:

drivers/net/dsa/realtek/rtl8365mb_l2.c:rtl8365mb_l2_add_mc() {
    ...
	memcpy(mc.key.mac_addr, mac_addr, ETH_ALEN);
	mc.key.vid = vid;
	mc.key.ivl = true;
    ...
	mc.member |= BIT(port);
    ...
}

rtl83xx_port_mdb_add() accepts both DSA_DB_PORT and DSA_DB_BRIDGE, then
drops the database before it programs the entry:

drivers/net/dsa/realtek/rtl83xx.c:rtl83xx_port_mdb_add() {
    ...
	/* EFID is not used by hardware MDB entries; debugging only */
	efid = db.type == DSA_DB_BRIDGE ? db.bridge.num : 0;
    ...
}

VID 0 also holds the standalone host entries. Take this call chain:

dsa_user_set_rx_mode()
  __dev_mc_sync()
    dsa_user_sync_mc()
      dsa_user_vlan_for_each()

dsa_user_vlan_for_each() always calls the callback for VID 0, whether the
port is bridged or not. As a result, dsa_port_standalone_host_mdb_add()
installs every address in each user port's mc list on the CPU port at
VID 0. Every lan port that is up has 01:00:5e:00:00:01 (224.0.0.1) and
33:33:00:00:00:01 (ff02::1) in that list.

Now take an untagged frame to ff02::1 or 224.0.0.1 that enters lan1 of a
VLAN-unaware br0. It now hits an entry whose only member is the CPU port.

The bridge never adds port members for these groups, because br_multicast.c
returns early for ipv4_is_local_multicast() and
ipv6_addr_is_ll_all_nodes(). So the switch would send the frame only to the
CPU.

rtl8_4_read_tag() then marks the frame as already forwarded:

net/dsa/tag_rtl8_4.c:rtl8_4_read_tag() {
    ...
	if (reason != RTL8_4_REASON_TRAP)
		dsa_default_offload_fwd_mark(skb);
    ...
}

Because of that mark, the software bridge doesn't forward the frame to lan2
either. Would IPv6 router advertisements, MLD/IGMP general queries and
other all-nodes or all-hosts traffic then stop reaching the other wired
ports of the bridge?

There is a second case when the same switch has two VLAN-unaware bridges.
An MDB entry for group G in br0 with members {lan2} would also match br1
traffic to G arriving on lan3.

The entry's members ANDed with the port mask of lan3 give an empty set, so
the switch would drop br1's traffic to G instead of flooding it. Is that
the intended behavior?

Neither case was possible before this patch. These ports were classified to
the bridge PVID (VID 1), so they missed every VID 0 entry.

The commit message only mentions a limitation for tagged frames. The
comment in rtl8365mb_l2_add_mc() argues that colliding MC entries cannot
leak traffic across bridges. It doesn't cover traffic that ends up dropped
or not flooded.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104082514.2139278-1-stijncleynhens%40gmail.com
