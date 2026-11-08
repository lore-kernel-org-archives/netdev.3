Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141579;
	b=CWsc+blwx0MDGSJBzXvaurr8d7m+Dl2BGkgbDsLktCdTiAY5hcZd0vxfbrRRXV9v3TWS
	 gPoG91Y1bq3Kl7Vdob2i8DuXAzDUOZFj5OFpLnpp0ahASn3UYfwtaNZOIYIK47v+3vYqD
	 g0aY32CJPqYHlnz1K69QTdj/LfAtYMrzoxoG2cDzw3ngCKUlhU/mP9YoQ4NyhXqhUNLUO
	 K6dpeFV0/oY0iNgCW3SsCb6Xh/vz2RXJjG8KQ38C0IxdFZZfYtxhBpv9rIYkcZemQozG5
	 NWKY6TnWX3dMhrhnzB35G578KeUN8L/AHNwbFu0nb6ibCigYS/YGUG9MYbIPgLQmlVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141579;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=A/8HbcVlRuERO8DwLj45a+EZMPGwkTzISV+xYxVRBL0=;
	b=4KCz6INs4zZaiX8lLFkoCjWlsiROJhE+H9TKPGCpoHXCbVhWiIeae5IwJ1N2D6B9rJZi
	 MuF6ofEeS+VDhm9hoy4C8DA7aJeTFv1NlV201wfX322OkqZN4h/Hogw7/SjLYx0nzVeve
	 Ugm6Yhx2iSfCeIhwwRJgHBVXUn8HzeFf13ampYUn0dEY0d6hNzMxN7zHzjAVtGU36aJNP
	 /i7Si9O5Rt/1Mx04KCAVmye78el2z/cJK45mBZwjlguYbGvMnovM/PGFwsVFgq2TvJgfe
	 bC+ALV1Ct8CVDUivdB22Bq1uxyTeei0y0pSYOyrTRdTh5KNFRFKlLj7Bsk6iJCj6jtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhwXUOqN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D0606A335;
	Sun,  8 Nov 2026 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JhwXUOqN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396D11F008BD;
	Sun,  8 Nov 2026 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794141578;
	bh=A/8HbcVlRuERO8DwLj45a+EZMPGwkTzISV+xYxVRBL0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JhwXUOqNMAtGRUvPpHn1TMW60AKl8oa0Mbs9v9a3N1OynMJJW33AlU/WKhXwOqL0M
	 TCUS1P95uWAJM0tbzxcl/ZwcJXUX7lCRrmxNS6mRGE4ogYwQyiynsjMvtaQESeRth9
	 ZeVcNEa6ZomsH4rhpkj2jU+r9o3RS9Ekz30D+Hld7p9Wyef7YiAwOehFeCI/OdnSGf
	 x7Ko0JWeHpU5jHU3nbclfiXhSXiCYmz3lPr1oZyV7RsuFKOhnc9eKznpHNxa/YgIQf
	 V7P7RNu6viwcHiW97hYHAmAtwPxfW/uYBWxEZ9T4VpNsJCv05XL8fXzThJVGVbCM2B
	 MxAwVXFyqujdg==
Subject: Re: [PATCH net-next v4 7/8] net: dsa: motorcomm: Translate FDB VID
 for VLAN-unaware bridges
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 12:39:37 +0000
Message-ID: <179414157777.994134.13352035575135683593@kernel.org>
In-Reply-To: <20261107121631.1040612-8-mmyangfl@gmail.com>
References: <20261107121631.1040612-8-mmyangfl@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Static entries for VLAN-unaware bridges now share FID 4095
  with hardware-learned dynamic entries.
- [Low] The commit fixes a functional bug that has existed since the
  driver was added, but it carries no Fixes: tag.
- [Low] yt921x_fdb_dump() declares `u16 vid;` (line 582) with no
  initializer.

--

net: dsa: motorcomm: Translate FDB VID for VLAN-unaware bridges

This patch maps VID 0 from a VLAN-unaware bridge to the unaware FID
(YT921X_VID_UNWARE, 4095) in yt921x_fdb_join() and yt921x_fdb_leave().
It also maps FID 4095 back to VID 0 in yt921x_fdb_dump(). The goal is
that static FDB entries installed through switchdev match the hardware
lookups.

> A VLAN-unaware bridge reports VID 0 for its FDB entries, but lookups run
> with the unaware FID (VID 4095). Entries added through switchdev were
> installed under FID 0 and could never be hit by the hardware lookups.

[Severity: Low]
This describes a user-visible bug that has been there since the driver
was added. Should this carry a Fixes: tag?

YT921X_VID_UNWARE was added in the same commit as the PVID 4095 setup in
yt921x_vlan_filtering(). So were yt921x_fdb_join() and yt921x_fdb_leave(),
which write the caller's VID straight into FDB_IO1_FID. That suggests:

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 1b05ac29ecd76..e41fe4859bfe4 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -590,6 +590,9 @@ yt921x_fdb_dump(struct yt921x_priv *priv, u16 ports_mask,
>  	res = yt921x_fdb_read(priv, addr, &vid, &pmask, &index, &status);
>  	if (res)
>  		return res;
> +
> +	if (vid == YT921X_VID_UNWARE)
> +		vid = 0;

[Severity: Low]
Can this read vid before it has been initialized?

In yt921x_fdb_dump(), vid has no initializer. yt921x_fdb_read() returns 0
without writing *vidp when the slot is NOTFOUND or has INVALID status:

yt921x_fdb_read() {
    ...
	if (val & YT921X_FDB_RESULT_NOTFOUND) {
		*ports_maskp = 0;
		return 0;
	}
    ...
	if ((data1 & YT921X_FDB_IO1_STATUS_M) ==
	    YT921X_FDB_IO1_STATUS_INVALID) {
		*ports_maskp = 0;
		return 0;
	}
    ...
}

When FDB index 0 is empty, the new comparison therefore runs on an
uninitialized stack value. The result is thrown away because cb() is
skipped when pmask is 0. KMSAN or -Wmaybe-uninitialized could still flag
it.

Before this patch, vid was only read inside the (pmask & ports_mask)
block.

The copy inside the GET_NEXT loop is fine because the !pmask break runs
first. Could this remap move inside the pmask check, or could vid be
initialized?

>  	if ((pmask & ports_mask) && !is_multicast_ether_addr(addr)) {
>  		res = cb(addr, vid,
>  			 status == YT921X_FDB_ENTRY_STATUS_STATIC, data);

[ ... ]

> @@ -782,6 +791,13 @@ yt921x_fdb_join(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
>  	u32 val2;
>  	int res;
>  
> +	/* A vlan-unaware bridge reports vid 0, but untagged lookups on its
> +	 * ports run with the unaware FID; map so that static entries match the
> +	 * hardware lookups.
> +	 */
> +	if (!vid)
> +		vid = YT921X_VID_UNWARE;
> +
>  	/* Check for presence */
>  	res = yt921x_fdb_has(priv, addr, vid, &index);
>  	if (res)

[Severity: Medium]
With this mapping, static entries for a VLAN-unaware bridge now share FID
4095 with entries the hardware learns. Before, they were in FID 0, which
learning never touched. What happens when yt921x_fdb_has() finds an
already learned entry for the same MAC?

Further down in yt921x_fdb_join(), the existing entry is not replaced.
It is forced to static and the new port is ORed into its egress mask:

	ctrl1 = val1 & ~YT921X_FDB_IO1_STATUS_M;
	ctrl1 |= YT921X_FDB_IO1_STATUS_STATIC;
	ctrl2 = val2 | YT921X_FDB_IO2_EGR_PORTS(ports_mask);

A learned entry on port P thus becomes a static entry for both P and the
new port, so unicast to that MAC is also sent to P.

On delete, yt921x_fdb_leave() only clears the departing port's bit:

	ctrl2 = val2 & ~YT921X_FDB_IO2_EGR_PORTS(ports_mask);

That leaves a static entry on P that never ages out. It is not cleared by
yt921x_dsa_port_fast_age() either, because that calls
yt921x_fdb_flush_port(priv, port, false).

Assisted learning on the CPU port is one way to get there:

  station X is learned in hardware on switch port P
  X moves to a foreign bridge port, e.g. Wi-Fi
  port_fdb_add(cpu, X, 0)  -> static {P, CPU}
  bridge entry ages out
  port_fdb_del(cpu, X, 0)  -> static {P}

If X later shows up on another switch port, hardware learning cannot
override the static entry. DSA also ignores bridge-learned entries on
offloaded ports, so traffic to X keeps going to P.

The same stale state can come from a user "bridge fdb add X dev swpA
master static" for a MAC currently learned on swpB, followed by
"bridge fdb del".

The merge logic is older than this patch and already affects VLAN-aware
bridges. This mapping makes it reachable for VLAN-unaware bridges too.
Can this leave static entries in FID 4095 that the software bridge does
not know about?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107121631.1040612-1-mmyangfl%40gmail.com
