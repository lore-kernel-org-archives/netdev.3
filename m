Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944542F6F6
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425380; cv=none; b=AxS7Ah2GC/3+6/t+9fm4IbevF8ajPa15YbrYpL3EhMQC4qhUbNWqZ45mZ576WYX22cSSgLUOQmfkzSesxlLRq5NZa/h4kgszAUgAmt4zYqER1aO600MEPQw/TF/njfoyEjoRo1Ma/aEGB7M6KdDKtRocYOT9EQ0i2n9VA8XuT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425380; c=relaxed/simple;
	bh=Xt/Z9Zwlj/rz+qSsCUIUDeO80ZZNXL8FMXj4zdHj9XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4JO2P2nAQNdELQuwkHDQpXTwwYFNP3yIEKYouYxpRiOshFSNh6zx1wornWJ6kJEfYHNwkgCGn06lTI3QqZ0AufPFCt1+wxChA28UXBq4M6EXmrgYCiGli4JW4qgSk5n8mgyKBk2SR26my3nYl5qR2qFxL0j9nv8ROVfLWcxGDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2Z8wtrl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2Z8wtrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841741F000E9;
	Thu,  3 Sep 2026 08:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788425375;
	bh=uOxSQ347v0s0OG5HhPOMZl7y5C1NCdb7KWoVBKqgWsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L2Z8wtrlBVHgYe2KoU959jP2K8Ka1yLxEsIvaaMuOihO3FhcyfTFeSO8HJECv1cdZ
	 +ULJm7mMDEJfKAcGpSQnQnHvFYTWEzg23hXUBXRbKT9B3RPHKM8lPsXO2jzGrULM3L
	 RbVFlLHs+dy0P4JmScIWRhHZ4mwHr+iEil1/oI4S1ylpWrEy6pqCVgkdBOo4SYjdVc
	 ccp5meHPc+amb8+ETD/9RAskWra10EPXi6EokMBvZ/D57vW9Siv9VfAx8r6tlhUrJp
	 c+2Y+Ok9MlNmxscZNkJ+sZThn3XFzje8GYZkYaxRXAa0ca/3f6iTHCQuvCnJZk2oEk
	 97+LD2CU4c8Zw==
Date: Thu, 3 Sep 2026 09:49:31 +0100
From: Simon Horman <horms@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	linglingzhang@trustnetic.com, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [net,v4] net: libwx: protect ring accesses with RCU and NULL
 check
Message-ID: <20260903084931.GH396647@horms.kernel.org>
References: <4353E83B1147D652+20260830070624.7410-1-mengyuanlou@net-swift.com>
 <178840489278.3394541.1727945751975594257@kernel.org>
 <D5E0F28C-A809-4194-B4C9-7C4EC77F9B73@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D5E0F28C-A809-4194-B4C9-7C4EC77F9B73@net-swift.com>

On Thu, Sep 03, 2026 at 12:16:35PM +0800, mengyuanlou@net-swift.com wrote:
> 
> 
> > 2026年9月3日 11:08，netdev-bot+sashiko@kernel.org 写道：
> > 
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider:
> > 
> > Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)
> > 
> > - [Medium] Commit message premise is unsubstantiated and the single
> >  `Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")` tag…
> > - [Medium] Ring pointers are published to lockless readers without
> >  release ordering.
> > 
> > Pre-existing issues:
> > - [Low] The loop bounds of every newly RCU-protected traversal
> >  (wx->num_tx_queues / wx->num_rx_queues) remain plain, unannotated…
> > 
> > --
> > 
> > net: libwx: protect ring accesses with RCU and NULL check
> > 
> > This converts the wx->tx_ring[]/wx->rx_ring[] traversals in the libwx
> > statistics, error, VLAN and PTP paths to READ_ONCE() plus a NULL check
> > inside rcu_read_lock()/rcu_read_unlock(), and switches the ring slot
> > assignment and clearing in wx_alloc_q_vector()/wx_free_q_vector() to
> > WRITE_ONCE().
> > 
> > A few questions below, first about the changelog and the Fixes tag, then
> > about the publish side in wx_lib.c.
> > 
> >> In wx_update_stats(), wx_get_ethtool_stats(), and other service tasks,
> >> the ring pointers wx->rx_ring[i] and wx->tx_ring[i] can become NULL or be
> >> freed asynchronously during queue teardown or channel reconfiguration.
> > 
> > [Severity: Medium]
> > Does this premise hold for the service task paths?
> > 
> > txgbe_disable_device() and ngbe_disable_device() stop the service task
> > synchronously:
> > 
> > timer_delete_sync(&wx->service_timer);
> > cancel_work_sync(&wx->service_task);
> > 
> > and the ring slots are only cleared afterwards, in
> > wx_clear_interrupt_scheme() -> wx_free_q_vectors() -> wx_free_q_vector().
> > So can wx_ring_tx_pending() or wx_detect_tx_hang() actually observe a slot
> > being cleared or a ring being freed underneath them?
> > 
> > The PTP aux work is similarly quiesced by wx_ptp_suspend() ->
> > ptp_cancel_worker_sync() before the rings go away, and
> > wx_get_ethtool_stats() and wx_vlan_strip_control() are reached from
> > RTNL-serialized callbacks (the latter only from wx_set_rx_mode()).
> > 
> > The one reader that does look unserialized against
> > wx_clear_interrupt_scheme() is wx_update_stats() reached from
> > wx_get_stats64() (ndo_get_stats64, e.g. a read of /proc/net/dev), which
> > before this patch dereferenced wx->rx_ring[i] with no NULL check. That is
> > the hunk the changelog does not call out. Could the message describe that
> > path specifically and mark the rest as hardening?
> 
> > 
> >> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
> > 
> > Is this tag right for most of the hunks? git blame attributes
> > wx_ring_tx_pending()/wx_detect_tx_hang() in wx_err.c and the tx_ring loop
> > in wx_update_xoff_rx_lfc() to 22d95e93c05b0, and wx_vlan_strip_control()
> > to f3b03c655f678. A stable backport selected on this single tag lands in
> > trees that have neither wx_err.c nor wx_ptp.c, so the patch cannot apply
> > there. Should the tag be narrowed to the wx_update_stats()/
> > wx_get_ethtool_stats() change that fixes the user-visible dereference?
> 
> I think it is ok. 46b92e10d631 is the earliest commit that involved this patch.

I think that the point the AI is making is that each of the patches -
46b92e10d631, 22d95e93c05b0, and f3b03c655f678 - introduce code that
has accesses that are serialised by this patch. And thus this patch fixes
each of them.

I did not verify that is the case for all three patches. But I did
verify that f3b03c655f678 is the oldest of the three patches, and
it does introduce wx_vlan_strip_control() whose accesses to wx->rx_ring
are addressed by this patch.

My suggestion is to either have fixes tags for all three patches,
if the AI is correct. Or choose the oldest one, f3b03c655f678.

> >> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> >> index 122c4952d203..9e2cf794f81c 100644
> >> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> >> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
> > 
> > [ ... ]
> > 
> >> @@ -2893,10 +2906,13 @@ void wx_update_stats(struct wx *wx)
> >> 
> >> spin_lock(&wx->hw_stats_lock);
> >> 
> >> + rcu_read_lock();
> >> /* gather some stats to the wx struct that are per queue */
> >> for (i = 0; i < wx->num_rx_queues; i++) {
> >> - struct wx_ring *rx_ring = wx->rx_ring[i];
> >> + struct wx_ring *rx_ring = READ_ONCE(wx->rx_ring[i]);
> >> 
> >> + if (!rx_ring)
> >> + continue;
> >> non_eop_descs += rx_ring->rx_stats.non_eop_descs;
> > 
> > [Severity: Low]
> > This is a pre-existing issue and not introduced by the patch, but the loop
> > bound itself stays an unannotated plain load while the reconfiguration path
> > writes it concurrently:
> > 
> > wx_free_q_vectors()
> > wx->num_tx_queues = 0;
> > wx->num_rx_queues = 0;
> > wx->num_q_vectors = 0;
> > 
> > while (v_idx--)
> > wx_free_q_vector(wx, v_idx);
> > 
> > The count and the ring array are two independently updated variables, and
> > the same pattern is in wx_ring_tx_pending(), wx_detect_tx_hang() and
> > wx_vlan_strip_control(). Since the counts are zeroed before the slots are
> > cleared and the rings live in a q_vector freed with kfree_rcu(), a stale
> > count inside the new RCU section resolves to either a still-valid ring or a
> > NULL slot, so the visible effect looks limited to a partial statistics
> > sample or a skipped register write, but it remains a KCSAN-reportable race.
> > Would annotating the count loads be worth doing while the traversals are
> > being touched?
> > 
> > [ ... ]
> > 
> >> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> >> index ed5aad7857bd..c227e9ab8a4a 100644
> >> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> >> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> >> @@ -2191,7 +2191,7 @@ static int wx_alloc_q_vector(struct wx *wx,
> >> ring->queue_index = txr_idx;
> >> 
> >> /* assign ring to wx */
> >> - wx->tx_ring[txr_idx] = ring;
> >> + WRITE_ONCE(wx->tx_ring[txr_idx], ring);
> >> 
> >> /* update count and index */
> >> txr_count--;
> >> @@ -2217,7 +2217,7 @@ static int wx_alloc_q_vector(struct wx *wx,
> >> ring->queue_index = rxr_idx;
> >> 
> >> /* assign ring to wx */
> >> - wx->rx_ring[rxr_idx] = ring;
> >> + WRITE_ONCE(wx->rx_ring[rxr_idx], ring);
> > 
> > [Severity: Medium]
> > The v3 posting used rcu_assign_pointer() here and v4 changed it to
> > WRITE_ONCE(). Does that leave the newly added read side without ordering?
> > 
> > WRITE_ONCE() only stops the compiler from tearing or reordering this single
> > store, it does not emit smp_store_release(). The ring is initialized with
> > plain stores immediately before the publish:
> > 
> > ring->dev = &wx->pdev->dev;
> > ring->netdev = wx->netdev;
> > ring->q_vector = q_vector;
> > ...
> > ring->queue_index = rxr_idx;
> > 
> > /* assign ring to wx */
> > WRITE_ONCE(wx->rx_ring[rxr_idx], ring);
> > 
> > On a weakly ordered CPU, can a reader doing READ_ONCE() under
> > rcu_read_lock() see the non-NULL pointer before those field stores become
> > visible? The NULL check added by this patch does not cover that case, since
> > the pointer is non-NULL and only the contents are stale.
> > 
> > reg_idx looks like a separate hole, because wx_alloc_q_vector() never
> > writes it. wx_init_interrupt_scheme() sets it after the pointers are
> > already published:
> > 
> > wx_cache_ring_rss()
> > for (i = 0; i < wx->num_rx_queues; i++)
> > wx->rx_ring[i]->reg_idx = i;
> > 
> > and wx_vlan_strip_control() feeds that value straight into a register
> > offset:
> > 
> > j = ring->reg_idx;
> > wr32m(wx, WX_PX_RR_CFG(j), WX_PX_RR_CFG_VLAN,
> >      enable ? WX_PX_RR_CFG_VLAN : 0);
> > 
> > If wx_vlan_strip_control() can run against a freshly published ring set,
> > can this reprogram the VLAN strip bit of a different receive queue? Note
> > that switching the publish back to rcu_assign_pointer() would not close
> > this one, since reg_idx is written after publication.
> > 
> > Publication is reachable on a registered netdev through
> > txgbe_setup_tc()/ngbe_setup_tc() and the resume paths, concurrently with
> > wx_get_stats64() -> wx_update_stats(), so the statistics readers can pick
> > up uninitialized per-queue counters and export them to userspace.
> 
> 
> Switch rcu_assign_pointer() and rcu_dereference change a lot.
> If it is ok for READ_ONCE and WRITE_ONCE.
> I think there is nothing that needs to be modified in this patch.

Firstly, I apologise for not answering your question in the v3 thread [1].
I was on a short holiday. It does seem relevant but as we are here
it seems best to discuss it in the context of v4, so I'll quote it:

    > > - struct wx_ring *tx_ring[64] ____cacheline_aligned_in_smp;
    > > - struct wx_ring *rx_ring[64];
    > > + struct wx_ring __rcu *tx_ring[64] ____cacheline_aligned_in_smp;
    > > + struct wx_ring __rcu *rx_ring[64];

    > > Does adding the __rcu annotation here cause Sparse warnings in other parts
    > > of the driver that still access these pointers directly?


    > > For example,
    > > in drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:wx_get_ethtool_stats():
    > > —- Rtnl_lock protect it.

    > > ring = wx->tx_ring[j];In drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_xmit_frame():
    > > tx_ring = wx->tx_ring[r_idx];
    > > —- Fast Path / Datapath

    > > in drivers/net/ethernet/wangxun/libwx/wx_hw.c:wx_vlan_strip_control():
    > > struct wx_ring *ring = wx->rx_ring[I];
    > > —- wx_configure path

    > > Since these accesses don't use rcu_dereference_protected() or
    > > rtnl_dereference(), could they generate "incorrect type in assignment"
    > > warnings from Sparse, even though they may be safely serialized by other
    > > locks?

    > To slove these warnings cost a lot.
    > Should I use rcu_assign_pointer() and rcu_dereference()?
    > Or fallback to WRITE_ONCE and READ_ONCE.

I entirely agree that adding correct rcu_assign_pointer() and
rcu_dereference() (and other?) updates to the code will be a non-trivial
change. And this is why I suggested, in my response to v3, that change be
deferred to a follow-up.

But I think the central question is: what is the correct approach?  And my
concern is that while using RCU is some work to implement it does seem to
lead to safe access that can be reasoned with in the context of normal
Kernel locking schemes.

I'm not convinced that using WRITE_ONCE and READ_ONCE, as implemented in
this patch, gives us that.

My overall feeling is that in the long run the driver should be converted
to RCU, including all the call sights that had warnings in v3. But as that
is a lot of churn, and not without some risk, I suggest a minimal
conversion for net (as was implemented in v3) and then follow-up with a
full conversion for net-next.

If you really want to stick with WRITE_ONCE and READ_ONCE for net then I
think you will need some memory barriers. But I still think that in the
long run an RCU conversion will be needed, which is why I feel this
approach is a dead-end.

[1] https://lore.kernel.org/netdev/86BE7746-4418-4B69-A6D6-091EC9418E70@net-swift.com/

> > 
> >> @@ -2245,10 +2245,10 @@ static void wx_free_q_vector(struct wx *wx, int v_idx)
> >> struct wx_ring *ring;
> >> 
> >> wx_for_each_ring(ring, q_vector->tx)
> >> - wx->tx_ring[ring->queue_index] = NULL;
> >> + WRITE_ONCE(wx->tx_ring[ring->queue_index], NULL);
> >> 
> >> wx_for_each_ring(ring, q_vector->rx)
> >> - wx->rx_ring[ring->queue_index] = NULL;
> >> + WRITE_ONCE(wx->rx_ring[ring->queue_index], NULL);
> > 
> > [ ... ]
> > 
> > -- 
> > Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/4353E83B1147D652%2B20260830070624.7410-1-mengyuanlou%40net-swift.com
> > 
> 
