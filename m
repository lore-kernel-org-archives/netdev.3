Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141580;
	b=LtoVTU1L/9WhLQoSMJma8I8UFT5NOdvPiqdRE6TyPGOPf5C3Doc5u5qITjvv24DFqFlO
	 xo5l7nlInIcoF8aK7fzzG+91ISmIAQwNtzVuvyito8iGbuEE+kiOY4LoObkJpj59p4je2
	 kO9t54oBeU85npkIUpUwGzNcD/JT0/m6/8jl+gKMY6qWacNvEOGIlJt7CPIDTcCJVM/LO
	 PIt+7QKp98rKmGm9GZ7PkuernvVRgh1EbGlesoebd5BNd20St8Iv23X+C6hkalHxSQqU9
	 MlDPnhp+p33qaVuM6EAVepwNTMe54/QGBKRTtrVC33U80pSAtqwUK/3/MMyeO3WPzLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141580;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cE5SNQq4qGeHUET1exc6Xlp6HOfT51McHiSHAKQvJmI=;
	b=o2HCFa0sJbzBBahh5cALQ8503BpNMszB8l0k4cYPYNfav7tL9/kw5COMr/pKPanLl1nP
	 Y5KD05QudEUQ6pi+IylbXwLL5/BHwP1YUe8VuFdc4H8kN5hpuiu4xoYEkM1lnRFbu3JnQ
	 gyUe9Gn6TTzPMVcNnUy50KLFbV0JW1a49GE2mN9v17kIn2f9JvO4/ngUn5yoIEoGNQD0v
	 7dJt/SAydLDlLeXYqhM9aNp+dqqD+vH1M0QgyVsB0yY63aMmyoBqopyL+lcvduQrBRK0Z
	 jlO/Tlujo0X49mGsR/W1NyVem8F502oVSFxkiVsnOrlWlxjXkWyGo2wLaq/fuoolDrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+8TqzK0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D2606D81F;
	Sun,  8 Nov 2026 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+8TqzK0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513181F008A4;
	Sun,  8 Nov 2026 12:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794141579;
	bh=cE5SNQq4qGeHUET1exc6Xlp6HOfT51McHiSHAKQvJmI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=T+8TqzK0GL06yK7r8aVl92sSwvYvtruEBf3/iFh519TgrTvDVxn7wunEEbpVM5tCf
	 /Jbkf9CLUJiIdYaJMvADJVPA3K/PkHr0jAzzZDdoGAzP/0EONkS6RsoIKYETQUyU3D
	 k8CNssmjQf6BwjMVrGWmWYZa6UGavxOq3sx3txPymOX6MbhoOte7yD0X4+UhVbMxvI
	 TJ4Kh0uVDEH/1ZpceJfx6h5ZSlbC/2nPVO+YPlQdPXfdE5Jb5N4Nu7RKEdDmSITutz
	 M1+Q/tn9q+IJFjWhcyK61M5ILVOSLIMuLv3YdlMS+q8UbraUr6xP2kmJTlUkHnp4Pc
	 mFEyS9h8vRGBQ==
Subject: Re: [PATCH net-next v4 8/8] net: dsa: motorcomm: Support BR_FLOOD and
 BR_MCAST_FLOOD offloading
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 12:39:38 +0000
Message-ID: <179414157888.994134.10786248378014024940@kernel.org>
In-Reply-To: <20261107121631.1040612-9-mmyangfl@gmail.com>
References: <20261107121631.1040612-9-mmyangfl@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The flood offload stops trapping unknown unicast/multicast on
  bridge ports and relies on hardware flooding, which obeys…
- [High] net: dsa: motorcomm: inverted dsa_is_cpu_port() check in
  yt921x_userport_standalone()
- [Medium] The patch deletes the setup-time programming of
  YT921X_FILTER_UNK_UCAST/YT921X_FILTER_UNK_MCAST from…
- [Medium] When the switch has zero or several bridges,
  yt921x_bridge_flood_set() writes ~(u32)0 to both…
- [Medium] Before this patch, all unknown multicast from user ports was
  trapped to the CPU (FILTER_UNK_MCAST bit set, ACT_UNK=TRAP).
- [Medium] net: dsa: motorcomm: wrong port index passed to
  dsa_is_cpu_port() in yt921x_isolate()
- [Low] yt921x_bridge_join() adds yt921x_bridge_flood_set() as a new
  failing step after yt921x_userport_bridge() (learning enabled) and…

--

net: dsa: motorcomm: Support BR_FLOOD and BR_MCAST_FLOOD offloading

This commit lets the switch flood unknown unicast and multicast in
hardware by clearing a bridge port's FILTER_UNK bits. That happens only
when the switch carries a single bridge, all other members have flooding
enabled, and the port is not in hairpin mode. The setup-time FILTER_UNK
programming in yt921x_chip_setup_dsa() is removed, and the registers are
now recomputed on bridge join, bridge leave and port flag changes.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index e41fe4859bfe4..5fed5b5a2feb0 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -1232,6 +1238,96 @@ static int yt921x_userport_bridge(struct yt921x_priv *priv, int port)
>  	return 0;
>  }
>  
> +/* ports_mask is optional */
> +static int yt921x_bridge_flood_set(struct yt921x_priv *priv, u16 ports_mask)
> +{

[ ... ]

> +	ret = 0;
> +	if (count != 1) {
> +		ctrl = ~(u32)0;
> +		res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
> +		if (res)
> +			ret = res;
> +		res = yt921x_reg_write(priv, YT921X_FILTER_UNK_MCAST, ctrl);
> +		if (res)
> +			ret = res;
> +		return ret;
> +	}
> +
> +	ports_mask &= ~dsa_cpu_ports(ds);

[Severity: Medium]
This isn't new in this patch, but yt921x_bridge_leave() still runs it
on every leave. The loop in yt921x_isolate() is meant to skip the CPU
ports, but it tests the function argument instead of the loop index:

	if (dsa_is_cpu_port(&priv->ds, port) || i == port)
		continue;

yt921x_dsa_port_bridge_leave() returns early for CPU ports, so port is
always a user port here and dsa_is_cpu_port(&priv->ds, port) is always
false. The loop therefore also sets BIT(port) in the CPU port's
YT921X_PORTn_ISOLATION register.

With the code as it stands, that bit is not a no-op. The CPU port's
isolation is no longer the ~(u32)0 from yt921x_chip_reset():
yt921x_userport_standalone() writes ~dsa_cpu_ports(ds) to it, and
yt921x_bridge() rewrites it from ~ports_mask. Setting BIT(port) there
blocks forwarding from the CPU port to the departing port until the
next yt921x_bridge() call rewrites the register. It also goes against
the comment saying conduit ports should be controlled by tagging
completely.

Was dsa_is_cpu_port(&priv->ds, i) intended here? Or is a blocked
CPU-to-port path harmless because everything sent from the conduit is
steered by the tag?

[Severity: High]
This isn't introduced by this patch, but the patch starts depending on
it. The comment in yt921x_userport_standalone() says conduit ports are
skipped so they keep the one-way isolation from yt921x_chip_reset(),
but the test is the other way round:

	if (dsa_is_cpu_port(ds, port)) {
		ctrl = ~dsa_cpu_ports(ds);

Shouldn't that be !dsa_is_cpu_port(ds, port)? As written, the CPU
port's YT921X_PORTn_ISOLATION is overwritten with ~dsa_cpu_ports(ds),
while every user port keeps the ~(u32)0 from yt921x_chip_reset(). A
standalone user port is then isolated from the CPU port as well as
from its peers.

The comment this patch adds here says FILTER_UNK_UCAST and
FILTER_UNK_MCAST don't matter for standalone ports since all packets
are handled by software. That held while yt921x_chip_setup_dsa() set
FILTER_UNK on every user port, because unknown frames were trapped via
ACT_UNK regardless of isolation. With that write gone, a standalone
port whose FILTER_UNK bit is not set (the reset default at probe, or
the value left behind after leaving a bridge) passes unknown unicast
and multicast to hardware forwarding. The ~(u32)0 isolation then drops
them before they reach the CPU port.

Bridge leave has the same gap. yt921x_bridge_leave() goes through
yt921x_userport_standalone(), which never writes the departing user
port's isolation register, so nothing resets it to ~dsa_cpu_ports(ds).
Once yt921x_bridge() programs user port isolation the way its comment
describes, a port that leaves the bridge would keep forwarding in
hardware to its former bridge peers.

Should the condition be fixed earlier in the series, so the FILTER_UNK
handling here sits on top of working standalone isolation?

[Severity: Medium]
With zero bridges, or more than one, this writes ~0 to both FILTER_UNK
registers. The setup code removed further down in this patch wrote:

    ctrl = GENMASK(10, 0) & ~cpu_ports_mask;

Doesn't ~0 also set the reserved bits 31:11, which lie outside
YT921X_FILTER_PORTS_M, along with the CPU port's bit?

ACT_UNK is TRAP for every port, including the CPU port. Could untagged
frames with an unknown DA that enter the conduit port then be trapped
back to the CPU? yt921x_tag_rcv() can't map the CPU port index to a user
port, so it would drop them with the ratelimited "Couldn't decode source
port" warning.

In the single-bridge path, ports_mask &= ~dsa_cpu_ports(ds) keeps the
CPU bit out of the update mask. So its value depends on history: the
reset default at boot, or 1 after any zero-bridge or multi-bridge event.

Would YT921X_FILTER_PORTS(~dsa_cpu_ports(ds)) be a better value to write
here?

[ ... ]

> +		ctrl = 0;
> +		for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
> +			struct yt921x_port *pp = &priv->ports[port];
> +
> +			/* Hardware never floods back to its own ingress port,
> +			 * keep hairpin port trapped: the software bridge does
> +			 * deliver a flood there.
> +			 */
> +			if (!pp->hairpin && !((flood_mask ^ ports_mask) &
> +					      ~BIT(port)))
> +				continue;

[Severity: High]
With one bridge and the default BR_FLOOD | BR_MCAST_FLOOD, this clears
FILTER_UNK for every non-hairpin member. Unknown traffic is then flooded
by hardware, which obeys PORTn_ISOLATION. At this point in the series,
does anything open isolation between bridged user ports?

yt921x_bridge() selects only the CPU ports:

    unsigned long targets_mask = ports_mask & dsa_cpu_ports(&priv->ds);

Its own comment says "Block from non-cpu bridge ports ...". The ~ seems
to have been lost in the earlier patch "net: dsa: motorcomm: Remove local
cpu_ports_mask". Before that patch the line was
ports_mask & ~priv->cpu_ports_mask.

yt921x_userport_standalone() also rewrites isolation only when
dsa_is_cpu_port(ds, port) is true. So user ports keep the ~(u32)0
written by yt921x_chip_reset(). Separately, yt921x_isolate() tests
dsa_is_cpu_port(&priv->ds, port) where it looks like it should test i.

Before this patch every unknown frame was trapped, so the software bridge
still flooded it. Now the frame is flooded by hardware from a source port
whose isolation blocks all peers. Any copy that reaches the CPU carries
YT921X_TAG_CODE_FORWARD, and yt921x_tag_rcv() calls
dsa_default_offload_fwd_mark() on it, so the software bridge won't flood
it again.

After "ip link set lan1 master br0; ip link set lan2 master br0", is
unknown unicast and multicast still delivered between lan1 and lan2?

> +
> +			ctrl |= BIT(port);
> +		}
> +
> +		/* ACT_UNK is fixed to TRAP for every port, see
> +		 * yt921x_chip_setup_dsa().
> +		 */
> +
> +		res = yt921x_reg_update_bits(priv, addr, ports_mask, ctrl);

[Severity: Medium]
Before this patch, all unknown multicast from user ports was trapped. The
software bridge therefore received IEEE link-local groups
(01:80:C2:00:00:0x: STP BPDUs, LACPDUs, LLDP, EAPOL) and consumed them
without forwarding.

Clearing FILTER_UNK_MCAST here hands unknown multicast to hardware
flooding. I couldn't find a reserved multicast (RMA) trap programmed
anywhere in drivers/net/dsa/motorcomm/.

chip.h defines YT921X_ACT_UNK_MCAST_BYPASS_DROP_RMA inside the
ACT_UNK_MCAST register. That suggests RMA frames go through the unknown
multicast action path.

If so, are BPDUs and LACPDUs now flooded by hardware instead of trapped?
With isolation open they would be forwarded between bridge ports. With
the current all-blocked user port isolation they may not reach the CPU
at all. Copies that do reach the CPU would carry the FORWARD code and get
offload_fwd_mark.

> +		if (res)
> +			ret = res;
> +	}

[ ... ]

> @@ -1322,6 +1422,10 @@ yt921x_bridge_join(struct yt921x_priv *priv, int port, u16 ports_mask)
>  	if (res)
>  		return res;
>  
> +	res = yt921x_bridge_flood_set(priv, ports_mask);
> +	if (res)
> +		return res;
> +

[Severity: Low]
If yt921x_bridge_flood_set() fails here, yt921x_userport_bridge() has
already enabled learning and yt921x_bridge() has already programmed
isolation. DSA doesn't send BRIDGE_LEAVE when the join notifier fails:

net/dsa/port.c:dsa_port_bridge_join() {
    ...
	err = dsa_broadcast(DSA_NOTIFIER_BRIDGE_JOIN, &info);
	if (err)
		goto out_rollback;
    ...
out_rollback:
	dsa_port_bridge_destroy(dp, br);
	return err;
}

Would this leave learning enabled on a port that DSA now treats as
standalone?

yt921x_bridge_flood_set() also keeps going after a failed write. So one
FILTER_UNK register might be updated while the other is not, and both
updates were computed with the joining port counted as a member.

[ ... ]

> @@ -2301,14 +2422,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
>  	if (res)
>  		return res;
>  
> -	ctrl = GENMASK(10, 0) & ~cpu_ports_mask;
> -	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
> -	if (res)
> -		return res;
> -	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_MCAST, ctrl);
> -	if (res)
> -		return res;
> -

[Severity: Medium]
With this write removed, yt921x_bridge_flood_set() is the only writer of
YT921X_FILTER_UNK_UCAST and YT921X_FILTER_UNK_MCAST. It runs only on
bridge join, leave and flags events.

Are standalone ports left on the hardware reset default from probe until
the first bridge event? Ports that never join the bridge would stay on
it for good.

There is also the leave case. dsa_port_bridge_leave() clears dp->bridge
before it broadcasts:

net/dsa/port.c:dsa_port_bridge_leave() {
    ...
	dsa_port_bridge_destroy(dp, br);

	err = dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
    ...
}

Take "ip link set lan1 master br0; ip link set lan2 master br0; ip link
set lan1 nomaster". yt921x_bridge_leave()->yt921x_bridge_flood_set(priv,
0) sees count == 1, and ports_mask covers only lan2, so the cleared
FILTER_UNK bits of lan1 are never restored.

The flag reset that follows, through yt921x_bridge_flags(), returns
early here:

	bdev = dsa_port_bridge_dev_get(dp);
	if (!bdev)
		return 0;

yt921x_userport_standalone() only resets pp->flood and pp->mcast_flood
in software.

The new comment in yt921x_userport_standalone() says FILTER_UNK is
unrelated "since all packets are handled by software". What makes sure
standalone traffic is still trapped to the CPU in these cases?

The same zero-bridge configuration also ends up with different hardware
state at boot (reset default) and after the last bridge goes away (~0,
all trapped).

The commit message says:

  This should cover most single-bridge usage. Other data paths remain
  unchanged in terms of behavior.

Does that still hold for standalone ports?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107121631.1040612-1-mmyangfl%40gmail.com
