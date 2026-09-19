Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBA61DF261;
	Sat, 19 Sep 2026 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777296; cv=none; b=Bwu+OkvEGBjeeJ7yQThHeS0OjX4MNgcx2CA+EwNzu64mE/CjkiQX9i6YkLk0o6GWW55BhqarrHFlxSbP3QpN2r1xBWnIvlMDlvXqHCs2lJ9pkKFXkxq6BUY+z+/lcR7Tlm4Q0nmnqsJzDrhybJfb/QVgMwqFn4HQz5oTts3hFbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777296; c=relaxed/simple;
	bh=1EO/dGRjm6Y4B4HUXDkLZTqawYnOPjV6vOpjR7sIqxU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+OCi6ZGa7Bx5i5wx7khhP+F3xlj4G5PnjkEQRcswCrqPMwY+QC4oU3ZvQQp7UJve7FOD/lAZoMiSok+TymbOamHgvAvRPI03z09/Kn4vVDa1IyBkwR7eGbWwRx04eKOHFjazbX8K5LexPqBH3F/vDJMQ+ew8QKXEsNELEh/+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwi8EhvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwi8EhvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668161F000FF;
	Sat, 19 Sep 2026 00:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777295;
	bh=oCHNE/wb9SG8U8pLhk/HJgT9bIWRhteW83fZeZ5Gcn0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Jwi8EhvUawm+ehv8QMypJXO8verN0uKG/800Nnl0dVJKnUCtWb77LslPV5Ww/jViU
	 OAsrhp5vRlBzt8cUWMPoVfygAmyysPXc4odB3H6rHxqt94HnRqOgEcWVFJks9HzRR8
	 kudl55/V42ZRRw4iTssMkqTiPF8ATJcd3tytjPxEH1nkJ8egMOZYjxrUWBREpYtzo6
	 gcJ3lfYVx4enPPM8s0ZV4w7/40lKX6ayiNDQfUvW3OGTLnQnmnbLTxk2rkn7ykqJ3M
	 UN41GC0WpElrcXC3qxyqcX+9mZOAWfaZejL93XRZbVVPaYi1Yci51qmNPbbbkEiFUl
	 srK+zkF/If3Qg==
Subject:
 Re: [PATCH net-next v2 4/5] vxlan: vnifilter: account the VNI node to memcg
From: netdev-bot+sashiko@kernel.org
To: alishmery18@gmail.com
Cc: netdev@vger.kernel.org, idosch@nvidia.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, razor@blackwall.org,
 roopa@nvidia.com, linux-kernel@vger.kernel.org
Date: Sat, 19 Sep 2026 00:21:33 +0000
Message-ID: <178977729399.22033.3228962563095615567@kernel.org>
In-Reply-To: <20260916193449.2552039-5-alishmery18@gmail.com>
References: <20260916193449.2552039-5-alishmery18@gmail.com>
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

- [Low] Missing Fixes: tag — the concern asserts that because the patch
  corrects observable memory-controller behavior for a long-lived per-…

--

vxlan: vnifilter: account the VNI node to memcg

This switches the struct vxlan_vni_node allocation in vxlan_vni_alloc()
from plain GFP_KERNEL to GFP_KERNEL_ACCOUNT, so the per-VNI node is
charged to the caller's cgroup like the per-CPU stats block that follows
it.

Link: https://lore.kernel.org/netdev/20260909092645.3105263-1-alishmery18@gmail.com/

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index 9a1baca39d8b0..fbff52c450c07 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -710,7 +710,7 @@ static struct vxlan_vni_node *vxlan_vni_alloc(struct vxlan_dev *vxlan,
>  {
>  	struct vxlan_vni_node *vninode;
>  
> -	vninode = kzalloc_obj(*vninode);
> +	vninode = kzalloc_obj(*vninode, GFP_KERNEL_ACCOUNT);

[Severity: Low]
This isn't a bug, but one review pass suggested this change in
vxlan_vni_alloc() should carry:

  Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")

on the grounds that it changes observable memory-controller behaviour for a
long-lived per-VNI allocation.

Is a Fixes tag wanted here?  The comparable precedent, commit c948f51c1654
("memcg: enable accounting for net_device and Tx/Rx queues"), added
GFP_KERNEL_ACCOUNT to the netdev allocations this builds on and carries no
Fixes tag, and the sibling patch accounting the per-CPU netdev stats in this
series does not carry one either.

There is also a behavioural side to it: with GFP_KERNEL_ACCOUNT, VNI
creation that previously succeeded can now return -ENOMEM once the calling
cgroup hits its limit, which may not be desirable to backport to stable.

>  	if (!vninode)
>  		return NULL;
>  	vninode->stats = netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916193449.2552039-1-alishmery18%40gmail.com
