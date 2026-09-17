Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4EA39C63D
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613786; cv=none; b=OruxKGxiTwrZ84AsQagxRE54MDufVaKhYqdhsTrTk7lYALVc0BhF1osTC9qG21Jx4uZIZQx+Y45sFvQzfQvyeLw05SFMwGPx4xL5MPTGvqrz7GZqmVlQHSk8g+FTk37A6C2KvsNd9ryr65p4i5SvdfOkQobwYBETMDhWS+rEjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613786; c=relaxed/simple;
	bh=d+FEnsGdatXG69NUChAuzsGkT8GxO/4z49if7c23T1o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=isp8Xyet2k+G4DU3ABMzRJwEoXY1WVt3TmVqcDyDZ+bV61tQUFRY3nQO29y7x9ZM0aLOkQx0MQ+DFxfjNv/ZnRop4igp7NXKn0BTVxy8K7pxtwvsU0gXy1ChJzC9UYkbtYXJBuV3McM8yAqAJ5TK5NyYbcBeCHQ0Q9Dr9jMakXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7caGLYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7caGLYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2BE1F00898;
	Thu, 17 Sep 2026 02:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613780;
	bh=yfEwgPQEr0LQvPXnHjZ2vv4wKRzirihAIiKEyqPWt60=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K7caGLYfxPiNLrkb0sdtP1cjQEh0NVm3tJCqB3T704o9wvvKyjUis83K3TqBKtuHl
	 76nP2UrTEzkBVyC6dUIdB3WGTkg7x8qyYrjmM37T0KxvzJRAsow2ccDyqyxSgfvvc5
	 9OZxjk66TTLpRcD8Cic17l0mdrOAsMoHWAzf4IPKV9WyG+FgWOLW54YXnKDGTfqkWk
	 8WE08GUH2Ud534NakzzK2G04qb5epRcM2/k5H1vbJ6GAFwFOiTNy8nw+JWdtguTz3H
	 658fR87R3J90UgzSOaLlzUhAa4PrU9WY/hbcb/wohe1KJdUT2SqfKx3WJ3kulmaAkF
	 lC93qqEHVdJrg==
Subject: Re: [PATCH net v2 3/3] net/mlx5: Bridge, don't fail unlink of
 untracked/unsupported peer ports
From: netdev-bot+sashiko@kernel.org
To: bsoares.it@gmail.com
Cc: mbloch@nvidia.com, daniel@iogearbox.net, netdev@vger.kernel.org,
 saeedm@nvidia.com, vladbu@nvidia.com, bersoare@isovalent.com, kuba@kernel.org
Date: Thu, 17 Sep 2026 02:56:19 +0000
Message-ID: <178961377985.22033.2002665961346158322@kernel.org>
In-Reply-To: <20260914085430.18694-4-bersoare@isovalent.com>
References: <20260914085430.18694-4-bersoare@isovalent.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Commit message overstates the notifier-chain impact.

--

net/mlx5: Bridge, don't fail unlink of untracked/unsupported peer ports

The patch makes mlx5_esw_bridge_vport_unlink() return 0 instead of -EINVAL
when the vport isn't present in this instance's br_offloads->ports xarray,
and adds a merged_eswitch capability guard to
mlx5_esw_bridge_vport_peer_unlink() mirroring the one in
mlx5_esw_bridge_vport_peer_link().

(No Link: tags in the commit header.)

Only the commit message is being commented on here, so the diff hunks are
omitted.

> This also matters beyond the -EINVAL itself:
> mlx5_esw_bridge_switchdev_port_event() runs on the per-netns
> netdev_chain, and notifier_from_errno(-EINVAL) sets NOTIFY_STOP_MASK,
> which call_netdevice_notifiers_info() checks to skip the global chain
> entirely - so the old -EINVAL silently dropped the event for every
> other listener on the system, including a sibling PF's own
> bridge-offload instance, even though none of it was visible to user
> space since __netdev_upper_dev_unlink() discards the return value.

[Severity: Low]
Is "dropped the event for every other listener on the system" accurate here?

notifier_call_chain() breaks at the callback that returned the stop bit, so
listeners ordered before mlx5's netdev_nb have already been invoked:

kernel/notifier.c:notifier_call_chain() {
	...
		ret = nb->notifier_call(nb, val, v);
	...
		if (ret & NOTIFY_STOP_MASK)
			break;
		nb = next_nb;
	...
}

The part about the global chain does hold:

net/core/dev.c:call_netdevice_notifiers_info() {
	ret = raw_notifier_call_chain(&net->netdev_chain, val, info);
	if (ret & NOTIFY_STOP_MASK)
		return ret;
	return raw_notifier_call_chain(&netdev_chain, val, info);
}

Regarding the sibling PF claim, mlx5 registers on the per-netns chain:

drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c:mlx5e_rep_bridge_init() {
	br_offloads->netdev_nb.notifier_call = mlx5_esw_bridge_switchdev_port_event;
	err = register_netdevice_notifier_net(&init_net, &br_offloads->netdev_nb);
	...
}

A sibling PF's br_offloads instance registers on that same per-netns chain,
so whether it misses the event depends on registration order rather than
being unconditional.

Would wording like "suppresses the remaining per-netns listeners
(potentially including a sibling PF's instance) and all global-chain
listeners" describe the behaviour more precisely?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914085430.18694-1-bersoare%40isovalent.com
