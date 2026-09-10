Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C837C0FC;
	Thu, 10 Sep 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033142; cv=none; b=AEpqc+YZxIuHOukEt81fok3Lhpa4tUknc3ZBpa5GWdWmEB1HTiKW+ADHpqUf6e51vA9Op8xb3koIKLQaTKMDefsAUFqQUz723oq7sn4X3r7whlzwvQzfImmkYfeXkRKfmQkEymWdDBIcgy1SdrSWsEps8IrD643LCH9Y4zTZgao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033142; c=relaxed/simple;
	bh=68XybTNj3cJQ7yEujcaD41b/4HNkQOFY/uhqLj63p5Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U470RYH+z3hU+1g/hw0l/gpe9VkJLhUkGpVYq0Fh4mamQ0UtbqNyy2WgVXCGQWrGNCPxamDNS0+mrC2GdpdbQYXko2AGoPr5Nc3I24wEklxiGTp5u0uMo1jOMJqyqecIB0LTCS4dovqZ2/xNtyHOVycRJUTlp+8D0p0WzOpOrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEVJ6VKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEVJ6VKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527FC1F00893;
	Thu, 10 Sep 2026 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033140;
	bh=3sei66XT5JBIPPH+jMZrHNpXFoN6yzwTNAqSdo0ioPA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SEVJ6VKEgzdhIUm2NqbExlO4SZzVD5+DgZlzJB22iJBrHnw7bDDQMLDhaJwcp+Lq3
	 7QQA6RweR1PlVz/Go4IeVXus+mSn4LNq4DuGWyxa1s5tZ18Cb2TzvSvrUA0qQUM/xL
	 fo4jtXdUD/A3Th8ThdNtcC9i8t5X1VozzcE3QaX6EQ0OMmiEOLQ0nQkIspBPx8n9SI
	 Eozw6RnoTZu7T1h7GFPy5ln52rbE6gyQMhXQZOjG3o8TSy6uXHnp59wr9vzt1aaeb3
	 TXFP9OTbrtQXCQ2JsJKZGoo7d4RajTbsoKgmsLijWKPFJsbY+umdRzDLaqUIPrzNe5
	 CNqu+LFO5k4Bg==
Subject: Re: [PATCH net 2/3] vxlan: vnifilter: account VNI node and per-CPU
 stats to memcg
From: netdev-bot+sashiko@kernel.org
To: alishmery18@gmail.com
Cc: netdev@vger.kernel.org, idosch@nvidia.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
 andrew+netdev@lunn.ch, razor@blackwall.org, roopa@nvidia.com,
 linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 09:38:59 +0000
Message-ID: <178903313988.219967.7088700680184392395@kernel.org>
In-Reply-To: <20260909092645.3105263-3-alishmery18@gmail.com>
References: <20260909092645.3105263-3-alishmery18@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] The commit message's quantitative model of the per-CPU charge is
  wrong/incomplete.
- [Low] The commit message states categorically that 'try_charge()
  reclaims and then invokes the memcg OOM killer rather than returning…

--

vxlan: vnifilter: account VNI node and per-CPU stats to memcg

This changes vxlan_vni_alloc() to allocate the struct vxlan_vni_node with
GFP_KERNEL_ACCOUNT and to switch the per-VNI stats block from
netdev_alloc_pcpu_stats() to __netdev_alloc_pcpu_stats() with
GFP_KERNEL_ACCOUNT, so both allocations are charged to the caller's memcg.

Both comments below are about the numbers and the failure behaviour
described in the changelog, not about the code change itself.

> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index f18ce0e1e741..3d6718ec3f55 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -703,10 +703,11 @@ static struct vxlan_vni_node *vxlan_vni_alloc(struct vxlan_dev *vxlan,
>  {
>  	struct vxlan_vni_node *vninode;
>  
> -	vninode = kzalloc_obj(*vninode);
> +	vninode = kzalloc_obj(*vninode, GFP_KERNEL_ACCOUNT);
>  	if (!vninode)
>  		return NULL;
> -	vninode->stats = netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu);
> +	vninode->stats = __netdev_alloc_pcpu_stats(struct vxlan_vni_stats_pcpu,
> +						   GFP_KERNEL_ACCOUNT);
>  	if (!vninode->stats) {
>  		kfree(vninode);
>  		return NULL;

[Severity: Low]
Is the stated cost model for this per-CPU allocation complete?  The
changelog says:

    "plus 64 bytes per possible CPU for the stats block. The per-CPU term
     is the one that grows: 256 bytes per VNI on a 2-CPU host, but 4.2 KB
     per VNI on a 64-CPU one."

Once __GFP_ACCOUNT is set, the amount charged comes from
pcpu_obj_full_size() in mm/percpu-internal.h:

	size_t extra_size = 0;

	#ifdef CONFIG_MEMCG
		if (!mem_cgroup_kmem_disabled())
			extra_size += size / PCPU_MIN_ALLOC_SIZE * sizeof(struct obj_cgroup *);
	#endif

		return size * num_possible_cpus() + extra_size;

For a 64-byte object on a 64-bit build that extra term is 64 / 4 * 8 =
128 bytes, which is what makes the quoted measurements add up
(64 * 2 + 128 = 256, 64 * 64 + 128 = 4224).  Would it be clearer to state
the obj_cgroup metadata term alongside the per-CPU term, since the stated
formula and the stated measurements otherwise disagree?

Also, is the 64-byte figure architecture independent?  struct
vxlan_vni_stats_pcpu in include/net/vxlan.h embeds a u64_stats_sync:

	struct vxlan_vni_stats_pcpu {
		struct vxlan_vni_stats stats;
		struct u64_stats_sync syncp;
	};

That member is empty on 64-bit but carries a seqcount on 32-bit, so the
object is larger than 64 bytes there.

[Severity: Low]
The changelog states:

    "try_charge() reclaims and then invokes the memcg OOM killer rather
     than returning -ENOMEM, so the request does not fail gracefully, the
     caller is killed"

Is that categorical?  In try_charge_memcg() in mm/memcontrol.c, when
mem_cgroup_oom() returns false (no killable task, oom_lock bypass, an
existing OOM victim with MMF_OOM_SKIP, or task_in_memcg_oom(current)),
control reaches:

	nomem:
		if (!(gfp_mask & (__GFP_NOFAIL | __GFP_HIGH)))
			return -ENOMEM;

GFP_KERNEL_ACCOUNT carries neither __GFP_NOFAIL nor __GFP_HIGH, so the
charge can return -ENOMEM, vxlan_vni_alloc() then returns NULL and the
netlink request does fail with -ENOMEM rather than the caller being
killed.

Separately, when the memcg OOM killer does run it picks a victim inside
the constrained cgroup, which need not be the allocating task, and
memory.oom.group can extend the kill to the whole cgroup.

Would it be more accurate to say the add may trigger memcg reclaim and
then either a memcg OOM kill of one or more tasks in the cgroup, or a
plain -ENOMEM?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909092645.3105263-1-alishmery18%40gmail.com
