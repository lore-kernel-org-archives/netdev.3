Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141578;
	b=YK4lOdiF5VETZwppI8/dHTTuwGqwYKGeObCaGOwey+2H4teTZ7T8d4KLdicA7QX2VuFM
	 +P5AmPaWaukJ2XuNuYyhFK1yPEygN18DVvc0jTlsZEoa8ND8cFS8cx1hgUhwavirj8sG9
	 Q+A2IPVCmZlGlZiZZBRhRPgALoakjgdw4RUPPtFITKsHWIy9wLSc4kgQATv4IV5XbLtJN
	 vLMcfP3di3vIIJO2pQnsk2qP+ICxaMjivRt5Yxd1KCsIg9Ulajan/VA0WGx37k9ZpHAZL
	 2X7ocIDZk4Vbc8sKw45de7kykqDj41kTCWa3gWS9yFpdBzLNLbHilEhTyLNJePoyMhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141578;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=I1s1PhM2oicK32SyeX3T0R0ctGmp+T+Ox2QSkZMKbMk=;
	b=ED+XTCeSbyHqlKGb+AdnwhpGvOeRceZZhU1SxJkvhCrjL308FsGihbQBovaPackByrm0
	 ZfoDx2MQF9q60kkMjLsfocbZTLRxxgg0IVeGJ8ZpaDSA4RL3S2crFB/3aRUbuPsB9T9Rk
	 6iWQ6u5VOWpV4b8K/z+KDavE6MhHCMTpGIVt9I6QCaqwWjx/Utxg5GPLK84gVbqvvmjm+
	 VvAwT2lYQ+y4bBack0yCYoYx+yOyhDrtAUHxitxc2Ocl+F0rOlikVtzj/mQbh4ZoiB4cp
	 ly4z14hD2vUG8D26UUL7a6ZeI8cYJa/NSSPVREUkovfrjL6nZwCWqWyQbT05e2aNbVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHYeVXAD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC75606D80F;
	Sun,  8 Nov 2026 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHYeVXAD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2170E1F0089F;
	Sun,  8 Nov 2026 12:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794141577;
	bh=I1s1PhM2oicK32SyeX3T0R0ctGmp+T+Ox2QSkZMKbMk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CHYeVXADcKihAaf7y2j65gRy1WboUKilskExqrfWnU3vQMaLTMZXIB0jueARsOwBx
	 IU7PaTECMIQvb5xVJi9SOsW+YnWLOE8+73EebCg3N3+tvaJYn89Koq3RxE9SZbEV+x
	 gKg1WtFvgO1hWrQ89ynFbQtfmUCgCd62mHbgYAavqSSdzeJn9qkunw31A9prbNya/U
	 c2UDyHfXCRzdlkW2pEuR1DFe6jc/MD3tDrAUALtMV5Ocvnwx9iqGRu6Z23N+6/WU1B
	 VHKE60RpW8d2KRBBEDF8Xcj+w1RVc4Q3ViTqf3tP+jxNrw1EVUXql7pBwAv+iVT8ty
	 AGOtkhN0IBnvA==
Subject: Re: [PATCH net-next v4 6/8] net: dsa: motorcomm: Rely on port
 isolation for conduit port
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 12:39:36 +0000
Message-ID: <179414157668.994134.463682835559182056@kernel.org>
In-Reply-To: <20261107121631.1040612-7-mmyangfl@gmail.com>
References: <20261107121631.1040612-7-mmyangfl@gmail.com>
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

Critical: 0 · High: 2 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch inverts the isolation logic in
  yt921x_userport_standalone()…
- [High] This patch makes the CPU port's PORTn_ISOLATION register the
  only hardware guard against untagged conduit traffic.
- [Low] yt921x_isolate() (drivers/net/dsa/motorcomm/chip.c:1225-1227)
  skips with `if (dsa_is_cpu_port(&priv->ds, port) || i == port)…

--

net: dsa: motorcomm: Rely on port isolation for conduit port

This patch takes the ~0 isolation that yt921x_chip_reset() writes to the
conduit port and makes it the only drop mechanism for untagged traffic
sent on the conduit. To do that it removes the explicit CPU port
isolation rewrite from yt921x_port_setup(), drops the ACT_UNK drop action
for CPU ports, and takes CPU ports out of FILTER_UNK_UCAST/MCAST.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 32701f9e687fa..1b05ac29ecd76 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -1170,10 +1170,17 @@ static int yt921x_userport_standalone(struct yt921x_priv *priv, int port)
>  	pp->hairpin = false;
>  	pp->isolated = false;
>  
> -	ctrl = ~dsa_cpu_ports(ds);
> -	res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port), ctrl);
> -	if (res)
> -		return res;
> +	/* Conduit ports should by controlled by tagging completely, skip
> +	 * setting isolation to preserve the one-way isolation installed
> +	 * by yt921x_chip_reset().
> +	 */
> +	if (dsa_is_cpu_port(ds, port)) {
> +		ctrl = ~dsa_cpu_ports(ds);
> +		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
> +				       ctrl);
> +		if (res)
> +			return res;
> +	}

[Severity: High]
Is this condition inverted? The comment says conduit ports are skipped so
they keep the isolation from yt921x_chip_reset(). With
if (dsa_is_cpu_port(ds, port)), though, only CPU ports get written with
~dsa_cpu_ports(ds), and every user port is skipped.

At probe, yt921x_chip_reset() writes ~0 to every PORTn_ISOLATION register.
yt921x_port_setup()->yt921x_userport_standalone() then runs for each port:

  - CPU ports are overwritten with ~dsa_cpu_ports(). That clears their
    block bits toward themselves and toward other CPU ports. This patch
    also removes the ~0 rewrite from yt921x_port_setup(), so nothing
    restores the one-way isolation.

  - User ports are never written and stay at ~0. That also blocks them
    toward the CPU port.

Unknown unicast and multicast are still trapped. However, the driver notes
in yt921x_bridge_flags() that broadcast can be filtered but not trapped,
and isolation is applied after the FDB lookup. Would broadcast frames
received on standalone user ports, such as ARP requests or DHCP, be
dropped before they reach the host?

This patch also removes the ACT_UNK drop action and the FILTER_UNK
coverage for CPU ports in yt921x_chip_setup_dsa(). The CPU port isolation
is now the only guard for untagged conduit traffic, and it is no longer
~0. In multi-CPU setups, could untagged frames from one conduit be
forwarded to another CPU port, or hairpinned back?

yt921x_bridge_leave() also relies on this function to reset the
isolation register of the leaving port:

yt921x_bridge_leave()
    yt921x_userport_standalone(priv, port);
    yt921x_isolate(priv, port);

That reset no longer happens for user ports. This is masked for now
because yt921x_bridge() never programs user port registers (see below).
Once that is fixed, wouldn't a port leaving a bridge keep its bridge-time
value? It could then still forward to its former peers, because
yt921x_isolate() only blocks the peer->port direction.

The condition is unchanged at the end of the series, in "net: dsa:
motorcomm: Support BR_FLOOD and BR_MCAST_FLOOD offloading". Was the
intended test if (!dsa_is_cpu_port(ds, port))?

>  
>  	/* Turn off FDB learning to prevent FDB pollution */
>  	mask = YT921X_PORT_LEARN_DIS;

[ ... ]

> @@ -2302,7 +2285,7 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
>  	if (res)
>  		return res;
>  
> -	ctrl = GENMASK(10, 0);
> +	ctrl = GENMASK(10, 0) & ~cpu_ports_mask;
>  	res = yt921x_reg_write(priv, YT921X_FILTER_UNK_UCAST, ctrl);
>  	if (res)
>  		return res;
> @@ -2325,13 +2308,6 @@ static int yt921x_chip_setup_dsa(struct yt921x_priv *priv)
>  	ctrl = 0;
>  	for (int i = 0; i < YT921X_PORT_NUM; i++)
>  		ctrl |= YT921X_ACT_UNK_ACTn_TRAP(i);
> -	/* Except for CPU ports, if any packets are sent via CPU ports without
> -	 * tag, they should be dropped.
> -	 */
> -	for_each_set_bit(port, &cpu_ports_mask, YT921X_PORT_NUM) {
> -		ctrl &= ~YT921X_ACT_UNK_ACTn_M(port);
> -		ctrl |= YT921X_ACT_UNK_ACTn_DROP(port);
> -	}

[Severity: High]
This removes the drop action for CPU ports, and the hunk above takes CPU
ports out of FILTER_UNK_UCAST/MCAST. Both changes assume the conduit keeps
the ~0 isolation from yt921x_chip_reset(). Does that still hold after a
bridge join?

yt921x_bridge() has:

static int yt921x_bridge(struct yt921x_priv *priv, u16 ports_mask)
{
	unsigned long targets_mask = ports_mask & dsa_cpu_ports(&priv->ds);
	...
	/* Block from non-cpu bridge ports ... */
	for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
		...
		/* to non-bridge ports */
		ctrl = ~ports_mask;
		...
		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
				       ctrl);

In the baseline this mask was ports_mask & ~priv->cpu_ports_mask, which
matches the "Block from non-cpu bridge ports" comment. The ~ was lost in
the earlier "net: dsa: motorcomm: Remove local cpu_ports_mask" commit in
this series.

Both yt921x_dsa_port_bridge_join() and yt921x_bridge_flags() (on
BR_HAIRPIN_MODE or BR_ISOLATED changes) OR dsa_cpu_ports() into
ports_mask. The loop therefore rewrites only the CPU port register, with
~ports_mask | BIT(cpu), which unblocks the conduit toward every bridge
member.

With the drop action and FILTER_UNK coverage gone, can untagged
broadcast and unknown unicast/multicast sent on the conduit now reach the
bridged user ports without going through the DSA tag? IPv6 link-local
NDP/MLD/RS that the host sends on the conduit netdev would be one source
of such frames.

The isolation registers of the bridged user ports themselves are never
programmed, so they stay at ~0. Would learned unicast between bridge
members then be dropped by isolation after the FDB lookup? And would
broadcast from bridged ports be unable to reach the CPU?

This mask is also unchanged at the end of the series, in "net: dsa:
motorcomm: Support BR_FLOOD and BR_MCAST_FLOOD offloading".

[Severity: Low]
On the same subject of CPU port isolation registers, yt921x_isolate() has:

	for (int i = 0; i < YT921X_PORT_NUM; i++) {
		if (dsa_is_cpu_port(&priv->ds, port) || i == port)
			continue;

Should this test i instead of port? The baseline was
(BIT(i) & priv->cpu_ports_mask) || i == port.

yt921x_dsa_port_bridge_leave() returns early for CPU ports, so port is
always a user port here. As a result the CPU port registers are no longer
skipped, and BIT(port) gets set in them. Those are the registers this
patch says should stay as yt921x_chip_reset() left them. The extra bit
moves the conduit toward ~0, so there is no visible forwarding regression.

The wrong variable came in with "net: dsa: motorcomm: Remove local
cpu_ports_mask" and is still there at the end of the series.

>  	res = yt921x_reg_write(priv, YT921X_ACT_UNK_UCAST, ctrl);
>  	if (res)
>  		return res;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107121631.1040612-1-mmyangfl%40gmail.com
