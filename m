Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C1385D7A
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 04:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788409072; cv=none; b=UXD34lDrp/d4FAiPSvre0GYJJFy9x/Q7BG/97JX80MH3FdhhWjyAN4v2fGcbhZkjGKUHx0xtdFsvVMJ3nG2+sqcWSl2imoh5IDWll1DbCQ+3D8UNkKRPVPVppIvwd6JqAr4BmcUlwbkqQ+0ofJ3abMXHN5ErIJRez1ztqlKm1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788409072; c=relaxed/simple;
	bh=E6sy0OJ++kMi7XCWCSPW5SFZkU9rOYf9Gf8LkWxG+T4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QLGk8Laih0O8aun2rwPNI9WJZ7OsK2PiHm6e0vcAZmVbnysVU0fb7fNg+i8C/+mXA/KgwuOiXuUlV2IfV2vQlvJoi5KwJq2nk5sDI+7fLGVtU4tPT+oi+IIOFr7vvnZCXhJeCX7f4jOU2MQX3/FGMyudlw4c0IGH8QWV57SalVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz5t1788409009tce5dbdd7
X-QQ-Originating-IP: elLdVUiO2FN26SSVM5AFuYTJKBL2T+23OMs9Z2k3FHQ=
Received: from smtpclient.apple ( [36.24.189.66])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 12:16:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15239468176350961932
EX-QQ-RecipientCnt: 10
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [net,v4] net: libwx: protect ring accesses with RCU and NULL
 check
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <178840489278.3394541.1727945751975594257@kernel.org>
Date: Thu, 3 Sep 2026 12:16:35 +0800
Cc: netdev@vger.kernel.org,
 linglingzhang@trustnetic.com,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5E0F28C-A809-4194-B4C9-7C4EC77F9B73@net-swift.com>
References: <4353E83B1147D652+20260830070624.7410-1-mengyuanlou@net-swift.com>
 <178840489278.3394541.1727945751975594257@kernel.org>
To: netdev-bot+sashiko@kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: N53RqJBrSkZRokhNEJck8ljeIBgUn+dsoqs77a/zV47k2BxX3lrJ8HWe
	SCKPMXXZ4X6xWsA7wvVpvGDnBXrMbEdorCRjy3ar9HX9WDA2GIqFkTyoYtszlJ1w4dAnt44
	pRHlW8B80/5jqNVXrS+sozNZLNKkOOXbuOrs8gnx4BX9hNwlHld+ixVwy+zzCmkguQgZca7
	6CskLqyuqACLOc30R/cIdlW2bCsS5WZqfAijrAQpxly6nAvfM15znnY0/Kg8wkdRMFzZFaK
	6JbuSDGD8DHZ4Es3OboVZ7aBHyCA51I9qM6WUCnk6lhGwwbQjGywzuIbnTgIWQNxKkPfbE7
	Jw7uUQxqwMI66HkX7ASsEgqYLrTds6d0CIo8k5UEfTYj04DIH8liHYBjzr0uh+XREou8LUI
	JtcOPLsIjuuBCaC0TpLsfhoyaA/SNWJRR4j0IJp5xUV0A5d0xLdRo9U8Z+N2ReGPo8z3gmT
	4pwV2W5C0tSoYwV384+a35Ww9IRL2v+gfB6VyT0+y34qZNVeNi/aH8prSdhLOvNll5PVSrc
	dgzSYGDFWnY0qVaNA2T5cadZINQVrOST29Csv0X2+BNNDJqZxba/UmPmVhA6bpjM6FyFWnz
	rCu4Wa3HkgpQUJuFGwFgYL3L/fX3/cSDXvGlEhYzMOAipmyEm/KXQa4d94OkVl+zip4PnUd
	5b0Gsrq7JmX2O5KA3i4+0OwYz9A+pc2zzxtyRjA/TnonD2Ir79scg4A2tD7Qm97fy4IrN7t
	zP8H+gYDM4wn+XY3YA+lpb4F1IovUvbbdxI49yPIydp7ZLfZf2D+aorS8Gc7CnHJpLUWueu
	qkAzDKSZbrWuguITaNFLCjvOdsVX+dMeWZHW5Om+Wr68XAbobd9MUOYIOH7rbViTN5Jfzpn
	0txleCjJbQlRCP4+nEGKSL0aHTyjx6XAXi7D09d3sHoC6s6xBHIcdFZn4jqhhMpiXKf/07y
	6AcG8sOwe+rOsdJ7OsUyxrIww1WeO29W/aBCMdq/cKwXjeT1GY/5GIFnC+pwXrJ81WWOoy4
	dutIu+G/e3JvfYYPoXwKvEx64LDiM9b/WM4SFlS26Ufw1BB85eCu7c8aaOIkSCF6Jo2qESv
	kWaxNS2Rv24
X-QQ-XMRINFO: M/715EihBoGSwgu9LMBgP9mevsIRXYYrjA==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B49=E6=9C=883=E6=97=A5 =
11:08=EF=BC=8Cnetdev-bot+sashiko@kernel.org =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0 (1)
>=20
> - [Medium] Commit message premise is unsubstantiated and the single
>  `Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")` =
tag=E2=80=A6
> - [Medium] Ring pointers are published to lockless readers without
>  release ordering.
>=20
> Pre-existing issues:
> - [Low] The loop bounds of every newly RCU-protected traversal
>  (wx->num_tx_queues / wx->num_rx_queues) remain plain, unannotated=E2=80=
=A6
>=20
> --
>=20
> net: libwx: protect ring accesses with RCU and NULL check
>=20
> This converts the wx->tx_ring[]/wx->rx_ring[] traversals in the libwx
> statistics, error, VLAN and PTP paths to READ_ONCE() plus a NULL check
> inside rcu_read_lock()/rcu_read_unlock(), and switches the ring slot
> assignment and clearing in wx_alloc_q_vector()/wx_free_q_vector() to
> WRITE_ONCE().
>=20
> A few questions below, first about the changelog and the Fixes tag, =
then
> about the publish side in wx_lib.c.
>=20
>> In wx_update_stats(), wx_get_ethtool_stats(), and other service =
tasks,
>> the ring pointers wx->rx_ring[i] and wx->tx_ring[i] can become NULL =
or be
>> freed asynchronously during queue teardown or channel =
reconfiguration.
>=20
> [Severity: Medium]
> Does this premise hold for the service task paths?
>=20
> txgbe_disable_device() and ngbe_disable_device() stop the service task
> synchronously:
>=20
> timer_delete_sync(&wx->service_timer);
> cancel_work_sync(&wx->service_task);
>=20
> and the ring slots are only cleared afterwards, in
> wx_clear_interrupt_scheme() -> wx_free_q_vectors() -> =
wx_free_q_vector().
> So can wx_ring_tx_pending() or wx_detect_tx_hang() actually observe a =
slot
> being cleared or a ring being freed underneath them?
>=20
> The PTP aux work is similarly quiesced by wx_ptp_suspend() ->
> ptp_cancel_worker_sync() before the rings go away, and
> wx_get_ethtool_stats() and wx_vlan_strip_control() are reached from
> RTNL-serialized callbacks (the latter only from wx_set_rx_mode()).
>=20
> The one reader that does look unserialized against
> wx_clear_interrupt_scheme() is wx_update_stats() reached from
> wx_get_stats64() (ndo_get_stats64, e.g. a read of /proc/net/dev), =
which
> before this patch dereferenced wx->rx_ring[i] with no NULL check. That =
is
> the hunk the changelog does not call out. Could the message describe =
that
> path specifically and mark the rest as hardening?

>=20
>> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
>=20
> Is this tag right for most of the hunks? git blame attributes
> wx_ring_tx_pending()/wx_detect_tx_hang() in wx_err.c and the tx_ring =
loop
> in wx_update_xoff_rx_lfc() to 22d95e93c05b0, and =
wx_vlan_strip_control()
> to f3b03c655f678. A stable backport selected on this single tag lands =
in
> trees that have neither wx_err.c nor wx_ptp.c, so the patch cannot =
apply
> there. Should the tag be narrowed to the wx_update_stats()/
> wx_get_ethtool_stats() change that fixes the user-visible dereference?

I think it is ok. 46b92e10d631 is the earliest commit that involved this =
patch.

>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c =
b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
>> index 122c4952d203..9e2cf794f81c 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
>=20
> [ ... ]
>=20
>> @@ -2893,10 +2906,13 @@ void wx_update_stats(struct wx *wx)
>>=20
>> spin_lock(&wx->hw_stats_lock);
>>=20
>> + rcu_read_lock();
>> /* gather some stats to the wx struct that are per queue */
>> for (i =3D 0; i < wx->num_rx_queues; i++) {
>> - struct wx_ring *rx_ring =3D wx->rx_ring[i];
>> + struct wx_ring *rx_ring =3D READ_ONCE(wx->rx_ring[i]);
>>=20
>> + if (!rx_ring)
>> + continue;
>> non_eop_descs +=3D rx_ring->rx_stats.non_eop_descs;
>=20
> [Severity: Low]
> This is a pre-existing issue and not introduced by the patch, but the =
loop
> bound itself stays an unannotated plain load while the reconfiguration =
path
> writes it concurrently:
>=20
> wx_free_q_vectors()
> wx->num_tx_queues =3D 0;
> wx->num_rx_queues =3D 0;
> wx->num_q_vectors =3D 0;
>=20
> while (v_idx--)
> wx_free_q_vector(wx, v_idx);
>=20
> The count and the ring array are two independently updated variables, =
and
> the same pattern is in wx_ring_tx_pending(), wx_detect_tx_hang() and
> wx_vlan_strip_control(). Since the counts are zeroed before the slots =
are
> cleared and the rings live in a q_vector freed with kfree_rcu(), a =
stale
> count inside the new RCU section resolves to either a still-valid ring =
or a
> NULL slot, so the visible effect looks limited to a partial statistics
> sample or a skipped register write, but it remains a KCSAN-reportable =
race.
> Would annotating the count loads be worth doing while the traversals =
are
> being touched?
>=20
> [ ... ]
>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c =
b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>> index ed5aad7857bd..c227e9ab8a4a 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>> @@ -2191,7 +2191,7 @@ static int wx_alloc_q_vector(struct wx *wx,
>> ring->queue_index =3D txr_idx;
>>=20
>> /* assign ring to wx */
>> - wx->tx_ring[txr_idx] =3D ring;
>> + WRITE_ONCE(wx->tx_ring[txr_idx], ring);
>>=20
>> /* update count and index */
>> txr_count--;
>> @@ -2217,7 +2217,7 @@ static int wx_alloc_q_vector(struct wx *wx,
>> ring->queue_index =3D rxr_idx;
>>=20
>> /* assign ring to wx */
>> - wx->rx_ring[rxr_idx] =3D ring;
>> + WRITE_ONCE(wx->rx_ring[rxr_idx], ring);
>=20
> [Severity: Medium]
> The v3 posting used rcu_assign_pointer() here and v4 changed it to
> WRITE_ONCE(). Does that leave the newly added read side without =
ordering?
>=20
> WRITE_ONCE() only stops the compiler from tearing or reordering this =
single
> store, it does not emit smp_store_release(). The ring is initialized =
with
> plain stores immediately before the publish:
>=20
> ring->dev =3D &wx->pdev->dev;
> ring->netdev =3D wx->netdev;
> ring->q_vector =3D q_vector;
> ...
> ring->queue_index =3D rxr_idx;
>=20
> /* assign ring to wx */
> WRITE_ONCE(wx->rx_ring[rxr_idx], ring);
>=20
> On a weakly ordered CPU, can a reader doing READ_ONCE() under
> rcu_read_lock() see the non-NULL pointer before those field stores =
become
> visible? The NULL check added by this patch does not cover that case, =
since
> the pointer is non-NULL and only the contents are stale.
>=20
> reg_idx looks like a separate hole, because wx_alloc_q_vector() never
> writes it. wx_init_interrupt_scheme() sets it after the pointers are
> already published:
>=20
> wx_cache_ring_rss()
> for (i =3D 0; i < wx->num_rx_queues; i++)
> wx->rx_ring[i]->reg_idx =3D i;
>=20
> and wx_vlan_strip_control() feeds that value straight into a register
> offset:
>=20
> j =3D ring->reg_idx;
> wr32m(wx, WX_PX_RR_CFG(j), WX_PX_RR_CFG_VLAN,
>      enable ? WX_PX_RR_CFG_VLAN : 0);
>=20
> If wx_vlan_strip_control() can run against a freshly published ring =
set,
> can this reprogram the VLAN strip bit of a different receive queue? =
Note
> that switching the publish back to rcu_assign_pointer() would not =
close
> this one, since reg_idx is written after publication.
>=20
> Publication is reachable on a registered netdev through
> txgbe_setup_tc()/ngbe_setup_tc() and the resume paths, concurrently =
with
> wx_get_stats64() -> wx_update_stats(), so the statistics readers can =
pick
> up uninitialized per-queue counters and export them to userspace.


Switch rcu_assign_pointer() and rcu_dereference change a lot.
If it is ok for READ_ONCE and WRITE_ONCE.
I think there is nothing that needs to be modified in this patch.
>=20
>> @@ -2245,10 +2245,10 @@ static void wx_free_q_vector(struct wx *wx, =
int v_idx)
>> struct wx_ring *ring;
>>=20
>> wx_for_each_ring(ring, q_vector->tx)
>> - wx->tx_ring[ring->queue_index] =3D NULL;
>> + WRITE_ONCE(wx->tx_ring[ring->queue_index], NULL);
>>=20
>> wx_for_each_ring(ring, q_vector->rx)
>> - wx->rx_ring[ring->queue_index] =3D NULL;
>> + WRITE_ONCE(wx->rx_ring[ring->queue_index], NULL);
>=20
> [ ... ]
>=20
> --=20
> Sashiko AI review =C2=B7 =
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/4353E83B1147D652%2B202=
60830070624.7410-1-mengyuanlou%40net-swift.com
>=20

