Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A376057C70B;
	Thu, 10 Sep 2026 18:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064387; cv=none; b=dkQsvvqxMHCY9wxq9He2hokph9nBUvDf4eK2ND6ZP4VCN1QPq7DctVXHyeso/xLXq3qJg4/xRBXtq9eURa+jk2Z7cGfPzltKdql+j1Tklft5kaT8hdP732bmOsYNY3UHh/Oh18K2+fvf95TSvYlXTnwtx+FJRnUMOrULI4CDTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064387; c=relaxed/simple;
	bh=Wm0E5ah+MA1MyRpzutggAQR5xjYV1YlcRUsCSqG4BMw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JL4tOMJ4RDw8L2th74ZmEqFEI6fmMqiWEM+5azaS+DmDyT6FMoYOpnJDLDVYtPNA7xPfcSHXEZRROa57EBz+4EEkVzW2IDewroK4lUOx5x/nU7eKVQxQ/PSTHah/aIKbw1AL96eIhevijPJaUkQrwplfYO9QcmHeZyWv9VOSw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JW5qyr9S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JW5qyr9S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B15A1F00893;
	Thu, 10 Sep 2026 18:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789064385;
	bh=nAuGqCXdKkGYy2JdRmdZI8sx06V0d7dOi1z+iWwPFAA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JW5qyr9SeKFcq1AhLlBGayVIEvFJH+0Nl/TKh9z0C2xHgewuwQu3ykBXcBubWeDw8
	 vvGeac1KSjx47xn6e8JIGoIDtUvrvzzqCJ+pJbwAdarJPsbmEPRuvtihrrKmFvbvdT
	 v454Ex0ZswjhaVsKv2edE6IPbvgf1lmYcY5amiMB/zf4B4zlBOD81my7tZSX2gMCFH
	 M1V6KW3m1sEIbHyHa5qgAbdaTkpHG80PRQupnSft+Z+1DU/B3Iu7cWDdmBbf+i1XY8
	 TR/qeh0O53zxxWLTggyPTarDG8HwXVe77QO5Yqs5G+jPeM3jJmFDB3H6lZ/MsSvann
	 MfD/lAqcV1oWA==
Subject:
 Re: [PATCH net] net: clear stale traffic class mappings when num_tc shrinks
From: netdev-bot+sashiko@kernel.org
To: norbert@doyensec.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kees@kernel.org,
 kuniyu@google.com, alexander.duyck@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 18:19:43 +0000
Message-ID: <178906438394.219967.1407792738957504620@kernel.org>
In-Reply-To: <16E3A318-5532-4B5E-8D03-86D21B463A2D@doyensec.com>
References: <16E3A318-5532-4B5E-8D03-86D21B463A2D@doyensec.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] The patch keeps the 'tc < num_tc' invariant only at a distance
  (scrubbing the source arrays) and never validates it at the point of…
- [Medium] netdev_set_num_tc() now zeroes
  dev->tc_to_txq[num_tc..TC_MAX_QUEUE-1] and the out-of-range…

--

net: clear stale traffic class mappings when num_tc shrinks

netdev_set_num_tc() lowers dev->num_tc without touching dev->tc_to_txq[]
or dev->prio_tc_map[], so stale entries naming a class >= dev->num_tc are
handed back out by netdev_txq_to_tc() and netdev_get_prio_tc_map().  The
patch clears the entries the new num_tc no longer covers before publishing
the new num_tc.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index ecfbd72d5d1a..e63e36a7c4d4 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3145,6 +3145,8 @@ EXPORT_SYMBOL(netdev_set_tc_queue);
>  
>  int netdev_set_num_tc(struct net_device *dev, u8 num_tc)
>  {
> +	int i;
> +
>  	if (num_tc > TC_MAX_QUEUE)
>  		return -EINVAL;
>  
> @@ -3153,6 +3155,14 @@ int netdev_set_num_tc(struct net_device *dev, u8 num_tc)
>  #endif
>  	netdev_unbind_all_sb_channels(dev);
>  
> +	/* Drop the mappings the new num_tc no longer covers. */
> +	for (i = num_tc; i < TC_MAX_QUEUE; i++)
> +		WRITE_ONCE(dev->tc_to_txq[i].combined, 0);
> +	for (i = 0; i <= TC_BITMASK; i++) {
> +		if (READ_ONCE(dev->prio_tc_map[i]) >= num_tc)
> +			WRITE_ONCE(dev->prio_tc_map[i], 0);
> +	}
> +

[Severity: Medium]
These two loops run while the old, larger dev->num_tc is still published.
Can a concurrent lockless transmitter observe the old num_tc together with
already-cleared mappings?

netdev_pick_tx() -> skb_tx_hash() gates on num_tc and then reads
tc_to_txq[] with no lock:

net/core/dev.c:skb_tx_hash() {
	if (READ_ONCE(dev->num_tc)) {
		u8 tc = netdev_get_prio_tc_map(dev, skb->priority);
		struct netdev_tc_txq res;

		res.combined = READ_ONCE(sb_dev->tc_to_txq[tc].combined);
		qoffset = res.offset;
		qcount = res.count;
		if (unlikely(!qcount)) {
			net_warn_ratelimited("%s: invalid qcount, qoffset %u for tc %u\n",
					     sb_dev->name, qoffset, tc);
			qoffset = 0;
			qcount = dev->real_num_tx_queues;
		}
	}

During the window the entry is already zero, so qcount == 0, the
"invalid qcount" warning is emitted and the packet is hashed over the whole
device queue range instead of the class range that num_tc still advertises.

netdev_txq_to_tc() has the same exposure and returns -1 while num_tc is
still non-zero:

net/core/dev.c:netdev_txq_to_tc() {
	if (READ_ONCE(dev->num_tc)) {
		...
		/* didn't find it, just return -1 to indicate no match */
		return -1;
	}

DSA taggers store that result in a u8 (ocelot_xmit() in
net/dsa/tag_ocelot_8021q.c, and the equivalents in net/dsa/tag_ksz.c and
net/dsa/tag_sja1105.c), which turns into a priority of 255.

The peer teardown helper netdev_reset_tc() uses the opposite store order,
publishing num_tc first and clearing the arrays afterwards:

net/core/dev.c:netdev_reset_tc() {
	WRITE_ONCE(dev->num_tc, 0);
	for (i = 0; i < TC_MAX_QUEUE; i++)
		WRITE_ONCE(dev->tc_to_txq[i].combined, 0);
	for (i = 0; i <= TC_BITMASK; i++)
		WRITE_ONCE(dev->prio_tc_map[i], 0);
}

Since every reader gates map use on num_tc, would matching that order here
avoid the intermediate state, and should the commit message mention the
inverse inconsistency this order creates?

>  	WRITE_ONCE(dev->num_tc, num_tc);
>  	return 0;
>  }

[Severity: High]
Does scrubbing the source arrays close the out-of-bounds write quoted in
the commit message for XPS callers that do not hold RTNL?

__netif_set_xps_queue() takes two independent unsynchronized snapshots and
only rejects a negative class:

net/core/dev.c:__netif_set_xps_queue() {
	dev_num_tc = READ_ONCE(dev->num_tc);
	if (dev_num_tc) {
		num_tc = dev_num_tc;
		...
		tc = netdev_txq_to_tc(dev, index);
		if (tc < 0)
			return -EINVAL;
	}

	mutex_lock(&xps_map_mutex);
	...
		tci = j * num_tc + tc;
		...
		RCU_INIT_POINTER(new_dev_maps->attr_map[tci], map);

xps_map_mutex is taken only after both loads and does not protect
dev->num_tc, and the allocation is sized with
XPS_CPU_DEV_MAPS_SIZE(num_tc) / XPS_RXQ_DEV_MAPS_SIZE(num_tc, nr_rx), so
any tc >= the snapshotted num_tc writes attr_map[] past the allocation.

Two paths look like they remain:

Raising num_tc is not covered at all.  A reader that snapshotted
num_tc == 1 and is then preempted can pick up tc == 3..7 after another CPU
ran mqprio_init() -> netdev_set_num_tc(dev, 8) plus
netdev_set_tc_queue(dev, 3, ...) in net/sched/sch_mqprio.c, and then writes
attr_map[j * 1 + 3] into a map sized for one class.

The ordering the commit message relies on is not enforced.  The message
says the entries are cleared "before publishing num_tc so that a lockless
reader cannot observe the new num_tc together with the old mappings", but
the clearing stores and WRITE_ONCE(dev->num_tc, num_tc) are plain
WRITE_ONCE() with no smp_wmb()/smp_store_release(), and netdev_txq_to_tc(),
skb_tx_hash() and netdev_get_prio_tc_map() use bare READ_ONCE() with no
smp_rmb()/acquire.  On a weakly ordered CPU, can a non-RTNL reader still
see the new smaller num_tc together with mappings that have not been
cleared yet?

A non-RTNL XPS caller exists:

drivers/net/virtio_net.c
  virtnet_cpu_online() / virtnet_cpu_dead()
    virtnet_set_affinity()
      __netif_set_xps_queue(vi->dev, cpumask_bits(mask), i, XPS_CPUS);

which runs with only cpus_read_lock() held while netdev_set_num_tc() holds
only RTNL.  The sysfs callers xps_cpus_store()/xps_rxqs_store() in
net/core/net-sysfs.c are serialized by sysfs_rtnl_lock() and are not
affected.

Would bounding the class at the point of use, for example

	tc = netdev_txq_to_tc(dev, index);
	if (tc < 0 || tc >= num_tc)
		return -EINVAL;

after the snapshot that sizes the map, together with a release/acquire pair
or shared locking for the num_tc publish, be a more direct fix than
scrubbing the arrays?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/16E3A318-5532-4B5E-8D03-86D21B463A2D%40doyensec.com
