Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794141575;
	b=qhT3kN+IqOFFh7aX/OfZieAqiRhDH+KvAE5TBbmC7c7317nYRnqDbwzkh9DZvMdDx7b8
	 zbi5s/Ab5TnjM33pux9SUTv5zyk43CeEg8eI+ZXS3OZzWZA5PF3TCFjS6MO6OjZO/gmme
	 wM9NmbSkATTE5wutJtU2JgsmuEF6aeThMJeZcy5RxUvPTHmrCXhZ5alKf5JbjfhKSxpZd
	 uOvbFxOxYreaB1kkjCGDLJl8CdaWbeoeBW8f4HacgiUIeVJ0JF+3CLbwjMKraoWfn3M6I
	 9V55ruGTVlZTtEKP9wM7fvkbW1FQB4nJtmoj8FSaEgW6e/5ziPcivU2flgrwDz/UqLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794141575;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/pLw2UrYqbKh1m0SK5YqZc3gcb89bZNzM43raVxaG1w=;
	b=QeJ2w7cNgFQC2f6p1BSAiGnLIWZuPc2d/CvLVrcCrXLgk6NiMjKLSTZMxtnC6ILRldXy
	 WdEqFJNj3z7kb2+nKjY4AD0Wr63KTXeACalWrq7XCHrZiJFDDIBaCEVOxVdPwnBh/5wqS
	 H2JI5ZB/OTeru8OBX+1vCGMDXRYLNoaAbplMZxAtJd5FBPApqzblzy9og+DMO6S/uq2iz
	 44NG5eOujLwypEIPqsfQ7yG8s4LeB3JY3ahdiej0HxbPTPs/Gqn2cizK9jpSON623O0ID
	 kACcy4Kr+MQi0kyIVgxCi6Asyly3LfMUiTIQXvVaWan1aZkCmztYf+zi6FlrLX/D99A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx4EXMpy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CABE606D802;
	Sun,  8 Nov 2026 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vx4EXMpy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28991F008A3;
	Sun,  8 Nov 2026 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794141575;
	bh=/pLw2UrYqbKh1m0SK5YqZc3gcb89bZNzM43raVxaG1w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Vx4EXMpyqvtw2e8OqtpPRw2XyE+ku4ylCwfzvMAoHkhThlvZKL1kgC7XgLtTf1z/Y
	 ClEpNzWb/gW1YRiZgivwOpVoXgEIhO6nOOtiNcPp/djyCHkWo9++/cY87Vidj/Nnm1
	 X+oFOV2PWCEjagnpE+ci1RznSy6D/IoY5Hwv5Gtcn5csNFbi+DdV82jhMuLiUdSI04
	 RRENbr3Hg1evWWK2cNyL5bynWU2ObGvJF3/qSoMmBEd2miNPZHM5LaC80ZDPTUfpgO
	 TFyZbCQ13hr5RW8g3XnXr45g4ISZ59O9juhv+9nJhkCcCe2unujOoSKxNKL3dBHNYS
	 vTfyYsxF4GPlA==
Subject:
 Re: [PATCH net-next v4 4/8] net: dsa: motorcomm: Remove local cpu_ports_mask
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 12:39:34 +0000
Message-ID: <179414157457.994134.9293623336717341404@kernel.org>
In-Reply-To: <20261107121631.1040612-5-mmyangfl@gmail.com>
References: <20261107121631.1040612-5-mmyangfl@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This commit was meant to be a pure refactor, but it reverses the
  target mask in yt921x_bridge() (drivers/net/dsa/motorcomm/chip.c).
- [Medium] In yt921x_isolate() (drivers/net/dsa/motorcomm/chip.c), the
  per-iteration check `(BIT(i) & priv->cpu_ports_mask)` was replaced…

--

net: dsa: motorcomm: Remove local cpu_ports_mask

This commit drops the cached cpu_ports_mask field from struct yt921x_priv.
Its users now call dsa_cpu_ports() or dsa_is_cpu_port() instead. The
commit describes this as a readability change.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index c51491ef4dae5..8ab499611fbf7 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c

[ ... ]

> @@ -1215,7 +1216,7 @@ static int yt921x_isolate(struct yt921x_priv *priv, int port)
>  
>  	mask = BIT(port);
>  	for (int i = 0; i < YT921X_PORT_NUM; i++) {
> -		if ((BIT(i) & priv->cpu_ports_mask) || i == port)
> +		if (dsa_is_cpu_port(&priv->ds, port) || i == port)
>  			continue;

[Severity: Medium]
Should this be dsa_is_cpu_port(&priv->ds, i) instead of port?

The old check tested the loop index i against the CPU port mask. The new
check tests the function argument port, which is the same on every
iteration.

The only caller path is:

yt921x_dsa_port_bridge_leave()
  yt921x_bridge_leave()
    yt921x_isolate()

yt921x_dsa_port_bridge_leave() already returns early for CPU ports:

	if (dsa_is_cpu_port(ds, port))
		return;

So the new condition is always false, and the loop no longer skips CPU
ports. On every bridge leave, BIT(port) now gets set in
YT921X_PORTn_ISOLATION() of each CPU port. The original code left those
registers alone, because port setup programs them.

If yt921x_isolate() were ever called with a CPU port, the condition would
be true on every iteration and no port would be updated.

>  
>  		res = yt921x_reg_set_bits(priv, YT921X_PORTn_ISOLATION(i),
> @@ -1232,7 +1233,7 @@ static int yt921x_isolate(struct yt921x_priv *priv, int port)
>   */
>  static int yt921x_bridge(struct yt921x_priv *priv, u16 ports_mask)
>  {
> -	unsigned long targets_mask = ports_mask & ~priv->cpu_ports_mask;
> +	unsigned long targets_mask = ports_mask & dsa_cpu_ports(&priv->ds);

[Severity: High]
Is a ~ missing here? The old code selected the bridge members that are
not CPU ports. The new code selects only the CPU ports.

Both callers add the CPU ports to ports_mask before calling
yt921x_bridge():

yt921x_dsa_port_bridge_join():
	ports_mask = dsa_bridge_ports(ds, bridge.dev);
	ports_mask |= dsa_cpu_ports(ds);

yt921x_bridge_flags():
	ports_mask = dsa_bridge_ports(ds, bdev);
	ports_mask |= dsa_cpu_ports(ds);

So targets_mask always ends up equal to dsa_cpu_ports(ds). The loops under
the "Block from non-cpu bridge ports" comment then write only the CPU
ports' YT921X_PORTn_ISOLATION() registers.

This has three effects:

The ~(u32)0 isolation value that yt921x_port_setup() installs on the CPU
port is overwritten with ~ports_mask | BIT(cpu).

The user ports in the bridge never have their isolation registers
rewritten. They keep the standalone value ~dsa_cpu_ports(ds) from
yt921x_userport_standalone(), so they stay blocked from each other.

BR_HAIRPIN_MODE and BR_ISOLATED updates from yt921x_bridge_flags() go to
the CPU port, not the user ports.

yt921x_userport_bridge() clears YT921X_PORT_LEARN_DIS on join, so the
switch learns FDB entries for bridge members. The comment in
yt921x_chip_setup_dsa() says port isolation is applied after FDB lookups.

Would known-unicast frames between two bridged user ports then be dropped
once their FDB entries are learned?

Should this be ports_mask & ~dsa_cpu_ports(&priv->ds)?

>  	u32 isolated_mask;
>  	u32 ctrl;
>  	int port;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107121631.1040612-1-mmyangfl%40gmail.com
