Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262951;
	b=Kuof3eKpG2u3auyJOL8ub47YdG1+w+74E74w2Kdyp8JnnbDTGD9fEc52qF95Ba9kqPL0
	 hwbECqKpx6JvwJ80EuMHLLnoy9Q5zUo0vW9R6whkoKyqbKmYeNDwZntXk0bl+kNelxBXu
	 P6xieGNb+0ar4V8nNnpxIdMLZ8b3vCd5mT/t9FXJD0gt/klsHvXY1AtpkTncMQws5l1+6
	 9dqVjnbmV4KExsS2qCS7vUXoYubcrn0CjuSMTwRWXzlDAJrVtcOBPExqcp90ZbJeYZqfA
	 76VBHGTI6F0/18/b3gepcIpQ3D3aBpCiwnpSDpqW19wqIM4OEJ5tvHWJy+8NLMSuodg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262951;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=O0a6fglP0H3yIqJEiLTB6YZUM/nKYqXeYK5nl4wY4+g=;
	b=GSBF50+VAOS1OHkviHwtSchFCrVCHgzZs1ZUy2eYHd4fyxOmsWBVoqNWgTxx40nsgwhh
	 gjTy+RyB9rwsnETJfx7vS0zmJnsbbmbi7F0Bz5RCZD1pwsmBAMNx0cdxstQB2XLqK9TlK
	 8L1tKeljW2HUjfHjzw75RCqfB5NtNuVDac4/OJTFgAXYmHJHPz60mb99DkV2HCeRw1EQD
	 6X1yzVe5myfda018k9QLZlQ75XZStoENYkCPhC+AVjqGxsnSyzW5D/kZYa10HBZF3VxU1
	 L3zUp7RoJrDH47wQkOWDKJrvk9kbVQ2bK5c2vdQSljPwE7khMmLkBO0WlYSYuxqzftw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rkx4XElr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E020060A2611;
	Mon,  9 Nov 2026 22:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rkx4XElr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B361F008A1;
	Mon,  9 Nov 2026 22:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262950;
	bh=O0a6fglP0H3yIqJEiLTB6YZUM/nKYqXeYK5nl4wY4+g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rkx4XElrh6LJfbP6o/GJnpr0WY9u5dg/6Po2XhAOcHVyreqd+cLRREhCc5sTL5Ygn
	 fav/RfoBbbXq5ioYSN8mW0FRL/xbHoqYmmIR3Llu1VTOrP8nquQDCJuoWEcq0J1bSa
	 Vok/UrFfUxiYeL6YLsLpLYmgfdWUmzxiJlnGu2u8gQ5mvebpaoqfKglwSdh7dVaYJY
	 e20y03i52NJT2kjoPaPZthj4kU+eMvgrfihRObtDMfl8S9z504saOwoyFy6DVB89pQ
	 h3mmUGJHb/8g1FZZ2+eG5u+pyhRXD7rhpWI3FlNrwDGaDr7utVJztbvj5iJjua1iCN
	 RgYayplKLXOrw==
Subject: Re: [PATCH net-next v5 5/7] net: dsa: motorcomm: Translate FDB VID
 for VLAN-unaware bridges
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 22:22:29 +0000
Message-ID: <179426294961.994134.2967123857690354980@kernel.org>
In-Reply-To: <20261108214450.1662362-6-mmyangfl@gmail.com>
References: <20261108214450.1662362-6-mmyangfl@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In drivers/net/dsa/motorcomm/chip.c, yt921x_fdb_join() (line
  798) and yt921x_fdb_leave() (line 749) now rewrite every vid-0 FDB/MDB…
- [Low] The patch fixes a defect that has existed since the driver was
  added in commit 186623f4aa72 ("net: dsa: yt921x: Add support for…
- [Low] The commit message describes only FDB entries ('A VLAN-unaware
  bridge reports VID 0 for its FDB entries').

--

net: dsa: motorcomm: Translate FDB VID for VLAN-unaware bridges

This patch remaps VID 0 to the VLAN-unaware FID (YT921X_VID_UNWARE, 4095)
when adding or removing entries in yt921x_fdb_join() and
yt921x_fdb_leave(). It also maps FID 4095 back to VID 0 when unicast
entries are dumped in yt921x_fdb_dump().

> A VLAN-unaware bridge reports VID 0 for its FDB entries, but lookups run
> with the unaware FID (VID 4095). Entries added through switchdev were
> installed under FID 0 and could never be hit by the hardware lookups.

[Severity: Low]
The commit message only mentions FDB entries. However,
yt921x_fdb_join() and yt921x_fdb_leave() are also the backends for
yt921x_dsa_port_mdb_add() and yt921x_dsa_port_mdb_del():

yt921x_dsa_port_mdb_add()
    res = yt921x_fdb_join(priv, addr, vid, BIT(port));

yt921x_dsa_port_mdb_del()
    res = yt921x_fdb_leave(priv, addr, vid, BIT(port));

That means every vid 0 MDB entry on a VLAN-unaware bridge, from IGMP/MLD
snooping or static mdb entries, also moves from the unused FID 0 into
the live FID 4095.

Before this patch, the hardware treated known-group multicast as unknown
and trapped it to the CPU. The software bridge then forwarded it to the
group members and to the multicast router ports.

Now the hardware forwards it only to the MDB member ports. When the CPU
port is in the mask, the frame arrives with code FORWARD and
offload_fwd_mark set, so software does not forward it again. net/dsa has
no mrouter handling, so router ports that are not group members appear
to stop receiving this traffic.

Could the commit message describe this change in multicast forwarding?
The "back and forth" translation on the dump side also skips multicast
entries.

[ ... ]

>     Signed-off-by: David Yang <mmyangfl@gmail.com>

[Severity: Low]
This isn't a bug, but should this carry a Fixes: tag? Since the driver
was added, yt921x_fdb_join() and yt921x_fdb_leave() have passed vid 0
straight through to FID 0:

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")

Static entries were never offloaded. Host FDB entries installed through
assisted_learning_on_cpu_port also never overrode the hardware-learned
FID 4095 entry. So a station that moved from a switch port to a CPU-side
interface kept being forwarded to its old port until ageing.

Note that backporting this patch as written would also backport the
cross-domain FID 4095 issue raised below.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index fbf3a0cba49b3..46534127d070e 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -740,6 +745,10 @@ yt921x_fdb_leave(struct yt921x_priv *priv, const unsigned char *addr,
>  	u32 val;
>  	int res;
>  
> +	/* See yt921x_fdb_join() */
> +	if (!vid)
> +		vid = YT921X_VID_UNWARE;
> +
>  	/* Check for presence */
>  	res = yt921x_fdb_has(priv, addr, vid, &index);
>  	if (res)

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

[Severity: High]
Is this remap safe when more than one forwarding domain uses FID 4095,
or when a vid 0 entry doesn't come from a VLAN-unaware bridge?

Both here and in yt921x_fdb_leave(), every vid 0 add or delete is
remapped. The code ignores the dsa_db argument and never checks the
bridge's vlan_filtering state. Every VLAN-unaware bridge port and every
standalone port seems to share FID 4095:

yt921x_vlan_filtering()
	if (!bdev || !vlan_filtering)
		pvid = YT921X_VID_UNWARE;

yt921x_userport_standalone()
	res = yt921x_port_set_pvid(priv, port, YT921X_VID_UNWARE);

The driver doesn't set ds->fdb_isolation or program a separate FID per
bridge.

Before this patch, vid 0 entries landed in FID 0, which nothing looked
up. Now they are live STATIC entries in the shared FID. The comment in
yt921x_chip_setup_dsa() describes what happens on a cross-domain hit:

	 * isolation takes _after_ FDB lookups, i.e. if an FDB entry (from
	 * another bridge) is matched and the destination port (in another
	 * bridge) is blocked, the packet will be dropped instead of flooding to

Take a VLAN-unaware LAN bridge where a host on swp1 has joined multicast
group G, plus a standalone WAN port:

yt921x_dsa_port_mdb_add(swp1, G, vid 0)
  yt921x_fdb_join()
    vid = YT921X_VID_UNWARE
    STATIC entry {G, FID 4095, egress swp1}

A frame for G that arrives on the standalone WAN port is looked up in
FID 4095 and matches the LAN entry. The standalone isolation mask
(~cpu ports) then removes swp1, so the frame is dropped. Before this
patch, the same frame was unknown multicast and was trapped to the CPU.

Two VLAN-unaware bridges behave the same way. br1 traffic for a MAC or
group known only in br0 is dropped instead of being trapped. If the CPU
port is in the entry, the frame arrives with code FORWARD and
yt921x_tag_rcv() calls dsa_default_offload_fwd_mark(). Then the br1
software path won't forward it to br1 switch ports either.

VLAN-aware bridges send vid 0 entries down too, because br_fdb_add()
adds a vid 0 entry when no VLAN is given. VLAN-aware ports fall back to
pvid 0 rather than 4095:

yt921x_pvid_clear()
	res = yt921x_port_set_pvid(priv, port,
				   vlan_filtering ? 0 : YT921X_VID_UNWARE);

So in FID 4095 those entries would only affect other domains.

The entries are STATIC, so hardware learning can't correct this.

Could the remap be limited to entries that really belong to a
VLAN-unaware bridge, for example based on db.bridge or the port's
VLAN-filtering state, with care for vlan_filtering toggles? The other
option would be for the driver to separate FIDs per bridge first.

Later patches in the series don't touch yt921x_fdb_join() or
yt921x_fdb_leave(). The flood offload patch ("Support BR_FLOOD and
BR_MCAST_FLOOD offloading") mentions that cross-bridge FDB hits are
dropped, but it only restricts flooding of unknown traffic.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108214450.1662362-1-mmyangfl%40gmail.com
