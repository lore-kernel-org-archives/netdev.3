Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8523ADB97
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491402; cv=none; b=rAoI7Ik2S7Tz0sgyQg5TK0vDhda+ZAPiwQXB7AA11OXXqf+sqWGyrPL1wLyPgOb/X4KC/Nyb5LwlCrB8/uAw4BY1YTImYAfCFGDYLZGXxeCnnNwJ+iSKy+yVYENc0vvwgcwd72IIUPZgkk1rX0V9Ah2vjpyM6ipOX3yyOe3Z4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491402; c=relaxed/simple;
	bh=PJeXGJbp9bmMua+V+2udmhgB2sjQ4Rc0lDCDtnAgHeg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V+p/KCRL7gRrysS/XRyiJ3t4CaSIDWqFkD2twX0vtcNRMPApFUmQwQESLFrnT88R7kpAF1vhkm/MJLNZqSRHT7mGLVnfcYiuW29bmpq/vprCpDXgs6v4OTvPEQO8DIlJMQVMuSwqUfl26palmy0r3oAl6YFQPsDzwsZibFq5uIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/k9eqGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/k9eqGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1BE1F00A3D;
	Fri,  4 Sep 2026 03:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788491400;
	bh=VajyRu3Z3n05mfyWB7t/Q4zuDCf4u/gHjtZ6TMVlXag=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P/k9eqGozw/9xBr3l1aOyrMmRSnaBpcMbuLFCLZHg+IwJdBuCMbErg9MLXxQevXXv
	 5XVNrlVzGD/2vOD47z8PLjNk7g7+DXSnotiuZLEYe4NSDGgxslcsUC+arsgg0G7Pd3
	 xNXyf/00sN3G6b2lKVub42PXi5rvyF48dM/Wy5nB4RLMwd0j9d1U7o3mXlfPUqd7FL
	 7USqBaDjM2fYvuWKar+uvX/f9qR+PUX0oIL/R5Yc0AY0kzZ6a4kfOwge/zcOQPUII1
	 j7t2GaRFu1M4RiRBxmszmICninLRNtvMeUKpgfS9bexH9QHZL4RWDTrl30p67ZgxL2
	 mO1rod7II5l7w==
Subject:
 Re: [PATCH v6 net-next 09/15] ipv6: Replace &nd_tbl with nd_table(net).
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 razor@blackwall.org
Date: Fri, 04 Sep 2026 03:09:59 +0000
Message-ID: <178849139948.4131868.2733291067982297494@kernel.org>
In-Reply-To: <20260902203722.926528-10-kuniyu@google.com>
References: <20260902203722.926528-10-kuniyu@google.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 1 · High: 0 · Medium: 0 · Low: 0

- [Critical] Calling `nd_table(net)` before `inet6_init()` executes
  results in a NULL pointer dereference during driver probe.

--

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
> @@ -17,26 +17,27 @@
>  #include "fs_core.h"
>  #include "diag/en_rep_tracepoint.h"
>  
> -static unsigned long mlx5e_rep_ipv6_interval(void)
> +static unsigned long mlx5e_rep_ipv6_interval(struct net *net)
>  {
>  	if (IS_ENABLED(CONFIG_IPV6) && ipv6_mod_enabled())
> -		return NEIGH_VAR(&nd_tbl.parms, DELAY_PROBE_TIME);
> +		return NEIGH_VAR(&nd_table(net)->parms, DELAY_PROBE_TIME);
>  
>  	return ~0UL;
>  }
>  
>  static void mlx5e_rep_neigh_update_init_interval(struct mlx5e_rep_priv *rpriv)
>  {
> -	unsigned long ipv6_interval = mlx5e_rep_ipv6_interval();
>  	struct net_device *netdev = rpriv->netdev;
>  	struct net *net = dev_net(netdev);
>  	unsigned long ipv4_interval;
> +	unsigned long ipv6_interval;
>  	struct neigh_table *tbl;
>  	struct mlx5e_priv *priv;
>  
>  	priv = netdev_priv(netdev);
>  	tbl = arp_table(net);
>  	ipv4_interval = NEIGH_VAR(&tbl->parms, DELAY_PROBE_TIME);
> +	ipv6_interval = mlx5e_rep_ipv6_interval(net);
>  
>  	rpriv->neigh_update.min_interval = min_t(unsigned long, ipv6_interval, ipv4_interval);
>  	mlx5_fc_update_sampling_interval(priv->mdev, rpriv->neigh_update.min_interval);

[Severity: Critical]
Unlike &nd_tbl, which is a statically allocated object that is
valid from the very first instruction of the kernel, nd_table(net)
reads net->neigh_tables[NEIGH_ND_TABLE], which is only populated
once ndisc_init()/inet6_init() has run.

Both of the new dereferences here are on driver probe paths that can
run before that point: mlx5e_rep_ipv6_interval() (via
mlx5e_rep_neigh_update_init_interval()) and
mlxsw_sp_router_neighs_update_interval_init() take
&nd_table(net)->parms and feed it to NEIGH_VAR(), so a NULL table
turns into a dereference of offsetof(struct neigh_table, parms)
rather than a benign zero. For built-in drivers, drivers/ is linked
before net/, and both the driver module_init() and inet6_init() are
device_initcall(), so the driver can win that race and oops during
boot. Note that ipv6_mod_enabled() does not help here: it only
reflects the ipv6.disable boot parameter and returns true well
before the nd table exists.

The same concern applies to any other conversion in this series that
can be reached from driver probe or from a netdev notifier that runs
before inet6_init().

How do you want to handle this? Either nd_table(net) needs to be
safe to call before ndisc_init() (e.g. by allocating the per-netns
slots earlier, in a pernet subsys registered ahead of the drivers),
or these callers need an explicit NULL check on the returned table
before touching ->parms. Please spell out the ordering guarantee you
are relying on in the changelog, since it is no longer obvious once
&nd_tbl becomes an indirection through struct net.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902203722.926528-1-kuniyu%40google.com
