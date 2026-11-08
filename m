Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141576;
	b=bVdufDjT/VMSSEyHacDTgoEUv6EYkrng+68QDa0WOVjlO+2XP/tJorpELGcC50ylPbrp
	 CKOcjuRXIO8hsJui4cCjfkxA/gEH8Z/foK2v0XJYO8FmKLoutaim+wq9jy5JPYRsk62sa
	 4+QCRx3zGvWgb8l/zpDXK5/LaXT2glo5OJucAKh4srHcYZBJnp9+M4XiUTAA6CowUjpTh
	 xiSXMeAZDkn1Jk/ND8ZBpIWePeh90+UHVzs2o4HadU9h64lnxrWAGhKekC3i9jrbPox62
	 ZoFpmyHRk6OdeEnSASpW1Vpi0u2izhzeN43lNq0Rb8+afjdx1NnPHGmNZrxygaaUn2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141576;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fVkJdK+00MkJV4NbGv2dMB+LMu86jkz1yjQW6+PFtyc=;
	b=ff6NjfHYPxt9wcEayTMI/TSVKOoh88M/76s7KThMfUSv7s9zPr3DvsY3omCcP2KE8qNZ
	 Kn/mBNQLSzQDKhwYMquQ421heQ5ecY+N1WfbKqKVR/Vta09+hRGsjJ9w83h9GPEvjtFzz
	 Xs96lA669vHsV4MwOmiZVf5zSLBwyaCiJdocRD0KxeL8Zg8eqyvXZmsOlQJTYQV7znpRQ
	 Jex+pccGwhZdxfLV0vlXcoSduvNhrqpjrbRH2d09D5U2n73P3u1JwCQgdSVzqHudsOP6N
	 w0b44HcVi6k2m40EwyDp5CqVHUoDKPA8mqewFnGZdV7lJ8gxFsmrQXSDvy+7+L3789w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yxhlpt4X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148B606A334;
	Sun,  8 Nov 2026 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yxhlpt4X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE431F008A1;
	Sun,  8 Nov 2026 12:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794141576;
	bh=fVkJdK+00MkJV4NbGv2dMB+LMu86jkz1yjQW6+PFtyc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Yxhlpt4X5scqej+TDtun6+oJ2M2xKOjkmo2ZAXMILvFMEmyoslEUTyGGzLMOxGZZA
	 BoWA6Jxb7gxsyvo5yzU888MIMln7pOYHLa16kSN/gcqRmjb9S+2t8/25346F02qVXX
	 l6ZcujTLza9vvZJfYxDCTDrK8+7sSZSIoGRMGzueH3C7D0TUkG+6sXYa0R4+GCCvOc
	 C9D3Jby2ZBToYds9ks+UQtYb//OVBtIqqvF0IVi+vab6EJEXyb8Op3WIxGQaA6ozeA
	 Vu3zIaroV0RQcteEaCMvRXIqHBgWqUJgXwWKhULQ0FNk2gsrMO72prVPWkp5olJZbY
	 auUrb+SQ5ZP5g==
Subject: Re: [PATCH net-next v4 5/8] net: dsa: motorcomm: Isolate all ports
 during chip setup
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 12:39:35 +0000
Message-ID: <179414157559.994134.6681169684211048832@kernel.org>
In-Reply-To: <20261107121631.1040612-6-mmyangfl@gmail.com>
References: <20261107121631.1040612-6-mmyangfl@gmail.com>
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

- [High] yt921x_bridge() in drivers/net/dsa/motorcomm/chip.c computes
  `targets_mask = ports_mask & dsa_cpu_ports(&priv->ds)`.
- [Low] yt921x_isolate() in drivers/net/dsa/motorcomm/chip.c loops over
  `i` but checks `dsa_is_cpu_port(&priv->ds, port)` instead of…
- [Low] The commit message says every port is isolated "right after the
  hardware reset", and the new comment says "Block all traffic as soon…

--

net: dsa: motorcomm: Isolate all ports during chip setup

This patch writes ~0 to the PORTn_ISOLATION register of every port at the
end of yt921x_chip_reset(). All traffic is then blocked once the hardware
reset has turned the chip back into a dumb switch. It prepares for the
isolation refactoring later in the series.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 8ab499611fbf7..32701f9e687fa 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -2264,6 +2265,17 @@ static int yt921x_chip_reset(struct yt921x_priv *priv)
>  		return -EINVAL;
>  	}
>  
> +	/* Block all traffic as soon as we reset the hardware since it now acts
> +	 * as a dumb switch.
> +	 */
> +	for (int port = 0; port < YT921X_PORT_NUM; port++) {

[Severity: Low]
The commit message says ports are isolated "right after the hardware
reset". The new comment says "as soon as we reset the hardware". In
yt921x_chip_reset(), though, this loop runs after the TPID check:

	res = yt921x_reg_read(priv, YT921X_CPU_TAG_TPID, &val);
	if (res)
		return res;
	eth_p_tag = FIELD_GET(YT921X_CPU_TAG_TPID_TPID_M, val);
	if (eth_p_tag != ETH_P_YT921X) {
		...
		return -EINVAL;
	}

The TPID read can fail, or the value can differ from ETH_P_YT921X. In
either case the function returns after YT921X_RST_HW has already reset
the chip, and no PORTn_ISOLATION register is written.

yt921x_dsa_setup() passes the error up, setup fails, and .port_setup
never runs. The switch keeps forwarding between all ports, including the
conduit, and there are no netdevs to manage it.

The behaviour here is the same as before the patch, so this isn't a
regression. The TPID check doesn't depend on isolation, though.

Could the loop move to directly after the yt921x_reg_wait() on
YT921X_RST? That would cover this error path. It would also make the
window on the success path one bus transaction shorter.

> +		ctrl = ~(u32)0;
> +		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
> +				       ctrl);
> +		if (res)
> +			return res;
> +	}

[Severity: High]
This code isn't part of this diff, but does yt921x_bridge() undo this
isolation for the CPU port as soon as a port joins a bridge?

Earlier in the series, "net: dsa: motorcomm: Remove local cpu_ports_mask"
changed the mask computation in yt921x_bridge() to this:

drivers/net/dsa/motorcomm/chip.c:yt921x_bridge() {
	unsigned long targets_mask = ports_mask & dsa_cpu_ports(&priv->ds);
	...
	/* Block from non-cpu bridge ports ... */
	for_each_set_bit(port, &targets_mask, YT921X_PORT_NUM) {
		...
		ctrl = ~ports_mask;
		...
		res = yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port),
				       ctrl);
	...
}

Before that commit it was ports_mask & ~priv->cpu_ports_mask. Is a '~'
missing in front of dsa_cpu_ports()?

Both yt921x_bridge_join() and yt921x_bridge_flags() OR the CPU ports into
ports_mask. That makes targets_mask exactly the CPU port mask, so both
loops visit only the CPU port.

There are two effects. First, the CPU port's PORTn_ISOLATION is replaced
with ~ports_mask | BIT(cpu). This removes the one-way ~0 isolation set
here and in yt921x_port_setup(). Untagged frames from the conduit can
then be forwarded to bridge members.

Second, the user bridge ports are never reprogrammed. They keep the
~dsa_cpu_ports() value written by yt921x_userport_standalone().
Hardware forwarding between bridge members is never enabled, and
pp->isolated and pp->hairpin are never applied to these ports.

yt921x_userport_bridge() clears LEARN_DIS on join, so the switch learns
MACs. Known unicast is then sent toward the peer port, where the source
port's isolation blocks it.

The tagger only sets offload_fwd_mark for frames the hardware has already
forwarded. So the software bridge doesn't reliably recover these frames
either.

Running "ip link set lanX master br0" on any YT921x switch takes this
path:

  yt921x_dsa_port_bridge_join()
    yt921x_bridge_join()
      yt921x_bridge()

Bridge flag changes reach the same code through yt921x_bridge_flags().
The line is still unchanged at the end of the series.

[Severity: Low]
This one also comes from "net: dsa: motorcomm: Remove local
cpu_ports_mask". Is the CPU port check in yt921x_isolate() testing the
wrong loop variable?

drivers/net/dsa/motorcomm/chip.c:yt921x_isolate() {
	...
	for (int i = 0; i < YT921X_PORT_NUM; i++) {
		if (dsa_is_cpu_port(&priv->ds, port) || i == port)
			continue;
	...
}

The original check was BIT(i) & priv->cpu_ports_mask, so this should
probably be dsa_is_cpu_port(&priv->ds, i). As written, the result is the
same on every iteration.

yt921x_dsa_port_bridge_leave() returns early for CPU ports, so the
condition is always false. The CPU port's PORTn_ISOLATION then gets
BIT(port) set on every bridge leave.

By itself, that matches the ~0 policy this patch sets up. Combined with
the yt921x_bridge() problem above, the CPU port's isolation state ends up
depending on the order of bridge joins and leaves. This check is also
unchanged at the end of the series.

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107121631.1040612-1-mmyangfl%40gmail.com
