Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6F36B937
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427161; cv=none; b=kXOANBNHOL6J3Bj9sul9LVzcMSrzqe/xPVpcBRDAzAPKZxDH8sw2g/t4mvk315mACzktN/e/bw2neGfawGAklRmDAqTJwEDFjhlEpgxCkJ9ltJAo2I+NhmEuUKwYWHd5NRY9fWmUWOE8jOe4ovHCA0lP6Mcvo7yAonUjhr00A64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427161; c=relaxed/simple;
	bh=pPLmA2nPwDDP1sV/vbltRX0Da1O4ROgctVT0KKyHNEs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=E3DCOczVlfMHazXY57t2bRtqMGEd29l65L0iTfrrCFfOef8xedC+/Fny3E24nzIPtkBJTRP/ykS+wqvjjTMZlz3LF/sVR03780QYfpYnytIHrf5up6ADhmFds2a2J3BAqUhj32roXIrxd2pyyY7k4Hj1seDpW3Yp6PiLGPDQeGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz8t1788427093t96cab5f0
X-QQ-Originating-IP: o2xHLL9ydspNC4r0LaaNBlkEDi3GucSDTo5WqwPk06U=
Received: from smtpclient.apple ( [36.24.189.66])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Sep 2026 17:18:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15758588636277576062
EX-QQ-RecipientCnt: 11
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
In-Reply-To: <20260903084931.GH396647@horms.kernel.org>
Date: Thu, 3 Sep 2026 17:18:01 +0800
Cc: netdev-bot+sashiko@kernel.org,
 netdev@vger.kernel.org,
 linglingzhang@trustnetic.com,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E7C6807-3314-4DA2-8491-945EBD619418@net-swift.com>
References: <4353E83B1147D652+20260830070624.7410-1-mengyuanlou@net-swift.com>
 <178840489278.3394541.1727945751975594257@kernel.org>
 <D5E0F28C-A809-4194-B4C9-7C4EC77F9B73@net-swift.com>
 <20260903084931.GH396647@horms.kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: M6Pq6l2cVyBBWKJkn+E3pn1tdChbTvWIimngz6hx3SNTpWoGswLSFs7z
	cjAtzLqihqbd5rtTutZVFxmUl+gjWDwP02n8odvVvENHtiRUZutORdcMdH5Lcy4xKIu3Y8Z
	XxaNx5UteSaLJJJYM9TKBEXQCXi9fhsVA8sqe6aBRfI+xtTGlg0YjolKz5E9ZwBhbru9q2C
	Yp9k3S3YDRj/bXlfp/tblE2eikBh74JccaUdNwOifjLHOFDJoojx/2YC4SEwA7sNuastZa7
	JybSiVccIjfAbPPkrgGGvJkIsKvfrhf/qQAgmswq3V3MtSUR7kAiOumrA2pFVqiRG3vRVQ7
	NAceBjCpYVrYGL2GL50Q2y35pL3yD+PL5p8RrFACOsvEGzh1PvHhJ9gxE54Ose6QmQdfYdG
	1Cnn0AUnzAeSWrz6eA+HS5X6DP6jZM/EmsAbkiueeLjTrzk1pDxBXvsaSTuYbLU9ErSZzSt
	yqCIpawrS5gFdYuqibZ5vXTPPjHn0HO7mE0rpLZHTdI6DlTE1Vf+7/CNx6fQ3mpD6GD8HRI
	sA/mlUCvasNZb7VIn+Po1G9aSLYH7VS5ZrB6Fw3J/qAU2J5hJa2umxGAmdNpUgA/YAXLo1U
	XeuSr4NYE7GRB7bZCUpMkz+sNo2v8o6UpsJaAM1kXwzHdh8pdy7RPuHTi1SvAWjlTnI1xAG
	+Vr12FFrveAPQu2WA3qxfj+LjX9LO5ot+riSN+5hMUxJpzOZvbUYcgwOfkrySGPumM9xL7p
	f1hP8dGc9X58Mrdx4luu03q6mOli+vYoltxrsj8bYCSOxkEyHbe+m8XxRtd6o6ODRZ7HWjl
	U+AFJwgORtek9SYImO+A1Kb+TguDD71JhrRzv9XThrsBNPC/VWNQblaY7YGwI2RR/Xp1oiu
	DZbHLOn/9w4pyoKA2OPqPxYVKqDjHgoRcveDBXlEyWsyPsiTlvlQ32PH9m8ms4S6M8H9Xvw
	OmY+6uNjJ1Zqr5QLPVIy8/6/4nLM7tOQKdWoPv32F8qwcOE+4A1NHJzkQwIrbAU8IadFLii
	ZdxRNMy8ZK+ypoKC6+wtE5nJS/sc8dOTdcrhR4kjqFdZoVRGE2UpTx1qLCibXFF6xkMyfXH
	sJa57ukbhy+hr6MClzhRo+RHzwri57CjzcZSXcAnM2JV3rp/iej2YWTta4wJgQl0j7mV/IW
	NlHv6Bl467bN/Ng6q1HIdtP5eQ==
X-QQ-XMRINFO: M/715EihBoGSCFrzuBLBPKcYWAdd9boasg==
X-QQ-RECHKSPAM: 0



> 2026=E5=B9=B49=E6=9C=883=E6=97=A5 16:49=EF=BC=8CSimon Horman =
<horms@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu, Sep 03, 2026 at 12:16:35PM +0800, mengyuanlou@net-swift.com =
wrote:
>>=20
>>=20
>>> 2026=E5=B9=B49=E6=9C=883=E6=97=A5 =
11:08=EF=BC=8Cnetdev-bot+sashiko@kernel.org =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> Thank you for your contribution! Sashiko AI review found 2 potential
>>> issue(s) to consider:
>>>=20
>>> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 =C2=B7 Low: 0 (1)
>>>=20
>>> - [Medium] Commit message premise is unsubstantiated and the single
>>> `Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")` =
tag=E2=80=A6
>>> - [Medium] Ring pointers are published to lockless readers without
>>> release ordering.
>>>=20
>>> Pre-existing issues:
>>> - [Low] The loop bounds of every newly RCU-protected traversal
>>> (wx->num_tx_queues / wx->num_rx_queues) remain plain, unannotated=E2=80=
=A6
>>>=20
>>> --
>>>=20
>>> net: libwx: protect ring accesses with RCU and NULL check
>>>=20
>>> This converts the wx->tx_ring[]/wx->rx_ring[] traversals in the =
libwx
>>> statistics, error, VLAN and PTP paths to READ_ONCE() plus a NULL =
check
>>> inside rcu_read_lock()/rcu_read_unlock(), and switches the ring slot
>>> assignment and clearing in wx_alloc_q_vector()/wx_free_q_vector() to
>>> WRITE_ONCE().
>>>=20
>>> A few questions below, first about the changelog and the Fixes tag, =
then
>>> about the publish side in wx_lib.c.
>>>=20
>>>> In wx_update_stats(), wx_get_ethtool_stats(), and other service =
tasks,
>>>> the ring pointers wx->rx_ring[i] and wx->tx_ring[i] can become NULL =
or be
>>>> freed asynchronously during queue teardown or channel =
reconfiguration.
>>>=20
>>> [Severity: Medium]
>>> Does this premise hold for the service task paths?
>>>=20
>>> txgbe_disable_device() and ngbe_disable_device() stop the service =
task
>>> synchronously:
>>>=20
>>> timer_delete_sync(&wx->service_timer);
>>> cancel_work_sync(&wx->service_task);
>>>=20
>>> and the ring slots are only cleared afterwards, in
>>> wx_clear_interrupt_scheme() -> wx_free_q_vectors() -> =
wx_free_q_vector().
>>> So can wx_ring_tx_pending() or wx_detect_tx_hang() actually observe =
a slot
>>> being cleared or a ring being freed underneath them?
>>>=20
>>> The PTP aux work is similarly quiesced by wx_ptp_suspend() ->
>>> ptp_cancel_worker_sync() before the rings go away, and
>>> wx_get_ethtool_stats() and wx_vlan_strip_control() are reached from
>>> RTNL-serialized callbacks (the latter only from wx_set_rx_mode()).
>>>=20
>>> The one reader that does look unserialized against
>>> wx_clear_interrupt_scheme() is wx_update_stats() reached from
>>> wx_get_stats64() (ndo_get_stats64, e.g. a read of /proc/net/dev), =
which
>>> before this patch dereferenced wx->rx_ring[i] with no NULL check. =
That is
>>> the hunk the changelog does not call out. Could the message describe =
that
>>> path specifically and mark the rest as hardening?
>>=20
>>>=20
>>>> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
>>>=20
>>> Is this tag right for most of the hunks? git blame attributes
>>> wx_ring_tx_pending()/wx_detect_tx_hang() in wx_err.c and the tx_ring =
loop
>>> in wx_update_xoff_rx_lfc() to 22d95e93c05b0, and =
wx_vlan_strip_control()
>>> to f3b03c655f678. A stable backport selected on this single tag =
lands in
>>> trees that have neither wx_err.c nor wx_ptp.c, so the patch cannot =
apply
>>> there. Should the tag be narrowed to the wx_update_stats()/
>>> wx_get_ethtool_stats() change that fixes the user-visible =
dereference?
>>=20
>> I think it is ok. 46b92e10d631 is the earliest commit that involved =
this patch.
>=20
> I think that the point the AI is making is that each of the patches -
> 46b92e10d631, 22d95e93c05b0, and f3b03c655f678 - introduce code that
> has accesses that are serialised by this patch. And thus this patch =
fixes
> each of them.
>=20
> I did not verify that is the case for all three patches. But I did
> verify that f3b03c655f678 is the oldest of the three patches, and
> it does introduce wx_vlan_strip_control() whose accesses to =
wx->rx_ring
> are addressed by this patch.
>=20
> My suggestion is to either have fixes tags for all three patches,
> if the AI is correct. Or choose the oldest one, f3b03c655f678.
>=20
>>>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c =
b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
>>>> index 122c4952d203..9e2cf794f81c 100644
>>>> --- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
>>>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
>>>=20
>>> [ ... ]
>>>=20
>>>> @@ -2893,10 +2906,13 @@ void wx_update_stats(struct wx *wx)
>>>>=20
>>>> spin_lock(&wx->hw_stats_lock);
>>>>=20
>>>> + rcu_read_lock();
>>>> /* gather some stats to the wx struct that are per queue */
>>>> for (i =3D 0; i < wx->num_rx_queues; i++) {
>>>> - struct wx_ring *rx_ring =3D wx->rx_ring[i];
>>>> + struct wx_ring *rx_ring =3D READ_ONCE(wx->rx_ring[i]);
>>>>=20
>>>> + if (!rx_ring)
>>>> + continue;
>>>> non_eop_descs +=3D rx_ring->rx_stats.non_eop_descs;
>>>=20
>>> [Severity: Low]
>>> This is a pre-existing issue and not introduced by the patch, but =
the loop
>>> bound itself stays an unannotated plain load while the =
reconfiguration path
>>> writes it concurrently:
>>>=20
>>> wx_free_q_vectors()
>>> wx->num_tx_queues =3D 0;
>>> wx->num_rx_queues =3D 0;
>>> wx->num_q_vectors =3D 0;
>>>=20
>>> while (v_idx--)
>>> wx_free_q_vector(wx, v_idx);
>>>=20
>>> The count and the ring array are two independently updated =
variables, and
>>> the same pattern is in wx_ring_tx_pending(), wx_detect_tx_hang() and
>>> wx_vlan_strip_control(). Since the counts are zeroed before the =
slots are
>>> cleared and the rings live in a q_vector freed with kfree_rcu(), a =
stale
>>> count inside the new RCU section resolves to either a still-valid =
ring or a
>>> NULL slot, so the visible effect looks limited to a partial =
statistics
>>> sample or a skipped register write, but it remains a =
KCSAN-reportable race.
>>> Would annotating the count loads be worth doing while the traversals =
are
>>> being touched?
>>>=20
>>> [ ... ]
>>>=20
>>>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c =
b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>>>> index ed5aad7857bd..c227e9ab8a4a 100644
>>>> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>>>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
>>>> @@ -2191,7 +2191,7 @@ static int wx_alloc_q_vector(struct wx *wx,
>>>> ring->queue_index =3D txr_idx;
>>>>=20
>>>> /* assign ring to wx */
>>>> - wx->tx_ring[txr_idx] =3D ring;
>>>> + WRITE_ONCE(wx->tx_ring[txr_idx], ring);
>>>>=20
>>>> /* update count and index */
>>>> txr_count--;
>>>> @@ -2217,7 +2217,7 @@ static int wx_alloc_q_vector(struct wx *wx,
>>>> ring->queue_index =3D rxr_idx;
>>>>=20
>>>> /* assign ring to wx */
>>>> - wx->rx_ring[rxr_idx] =3D ring;
>>>> + WRITE_ONCE(wx->rx_ring[rxr_idx], ring);
>>>=20
>>> [Severity: Medium]
>>> The v3 posting used rcu_assign_pointer() here and v4 changed it to
>>> WRITE_ONCE(). Does that leave the newly added read side without =
ordering?
>>>=20
>>> WRITE_ONCE() only stops the compiler from tearing or reordering this =
single
>>> store, it does not emit smp_store_release(). The ring is initialized =
with
>>> plain stores immediately before the publish:
>>>=20
>>> ring->dev =3D &wx->pdev->dev;
>>> ring->netdev =3D wx->netdev;
>>> ring->q_vector =3D q_vector;
>>> ...
>>> ring->queue_index =3D rxr_idx;
>>>=20
>>> /* assign ring to wx */
>>> WRITE_ONCE(wx->rx_ring[rxr_idx], ring);
>>>=20
>>> On a weakly ordered CPU, can a reader doing READ_ONCE() under
>>> rcu_read_lock() see the non-NULL pointer before those field stores =
become
>>> visible? The NULL check added by this patch does not cover that =
case, since
>>> the pointer is non-NULL and only the contents are stale.
>>>=20
>>> reg_idx looks like a separate hole, because wx_alloc_q_vector() =
never
>>> writes it. wx_init_interrupt_scheme() sets it after the pointers are
>>> already published:
>>>=20
>>> wx_cache_ring_rss()
>>> for (i =3D 0; i < wx->num_rx_queues; i++)
>>> wx->rx_ring[i]->reg_idx =3D i;
>>>=20
>>> and wx_vlan_strip_control() feeds that value straight into a =
register
>>> offset:
>>>=20
>>> j =3D ring->reg_idx;
>>> wr32m(wx, WX_PX_RR_CFG(j), WX_PX_RR_CFG_VLAN,
>>>     enable ? WX_PX_RR_CFG_VLAN : 0);
>>>=20
>>> If wx_vlan_strip_control() can run against a freshly published ring =
set,
>>> can this reprogram the VLAN strip bit of a different receive queue? =
Note
>>> that switching the publish back to rcu_assign_pointer() would not =
close
>>> this one, since reg_idx is written after publication.
>>>=20
>>> Publication is reachable on a registered netdev through
>>> txgbe_setup_tc()/ngbe_setup_tc() and the resume paths, concurrently =
with
>>> wx_get_stats64() -> wx_update_stats(), so the statistics readers can =
pick
>>> up uninitialized per-queue counters and export them to userspace.
>>=20
>>=20
>> Switch rcu_assign_pointer() and rcu_dereference change a lot.
>> If it is ok for READ_ONCE and WRITE_ONCE.
>> I think there is nothing that needs to be modified in this patch.
>=20
> Firstly, I apologise for not answering your question in the v3 thread =
[1].
> I was on a short holiday. It does seem relevant but as we are here
> it seems best to discuss it in the context of v4, so I'll quote it:
>=20
>>> - struct wx_ring *tx_ring[64] ____cacheline_aligned_in_smp;
>>> - struct wx_ring *rx_ring[64];
>>> + struct wx_ring __rcu *tx_ring[64] ____cacheline_aligned_in_smp;
>>> + struct wx_ring __rcu *rx_ring[64];
>=20
>>> Does adding the __rcu annotation here cause Sparse warnings in other =
parts
>>> of the driver that still access these pointers directly?
>=20
>=20
>>> For example,
>>> in =
drivers/net/ethernet/wangxun/libwx/wx_ethtool.c:wx_get_ethtool_stats():
>>> =E2=80=94- Rtnl_lock protect it.
>=20
>>> ring =3D wx->tx_ring[j];In =
drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_xmit_frame():
>>> tx_ring =3D wx->tx_ring[r_idx];
>>> =E2=80=94- Fast Path / Datapath
>=20
>>> in =
drivers/net/ethernet/wangxun/libwx/wx_hw.c:wx_vlan_strip_control():
>>> struct wx_ring *ring =3D wx->rx_ring[I];
>>> =E2=80=94- wx_configure path
>=20
>>> Since these accesses don't use rcu_dereference_protected() or
>>> rtnl_dereference(), could they generate "incorrect type in =
assignment"
>>> warnings from Sparse, even though they may be safely serialized by =
other
>>> locks?
>=20
>> To slove these warnings cost a lot.
>> Should I use rcu_assign_pointer() and rcu_dereference()?
>> Or fallback to WRITE_ONCE and READ_ONCE.
>=20
> I entirely agree that adding correct rcu_assign_pointer() and
> rcu_dereference() (and other?) updates to the code will be a =
non-trivial
> change. And this is why I suggested, in my response to v3, that change =
be
> deferred to a follow-up.
>=20
> But I think the central question is: what is the correct approach?  =
And my
> concern is that while using RCU is some work to implement it does seem =
to
> lead to safe access that can be reasoned with in the context of normal
> Kernel locking schemes.
>=20
> I'm not convinced that using WRITE_ONCE and READ_ONCE, as implemented =
in
> this patch, gives us that.
>=20
> My overall feeling is that in the long run the driver should be =
converted
> to RCU, including all the call sights that had warnings in v3. But as =
that
> is a lot of churn, and not without some risk, I suggest a minimal
> conversion for net (as was implemented in v3) and then follow-up with =
a
> full conversion for net-next.
>=20
> If you really want to stick with WRITE_ONCE and READ_ONCE for net then =
I
> think you will need some memory barriers. But I still think that in =
the
> long run an RCU conversion will be needed, which is why I feel this
> approach is a dead-end.

Thanks=EF=BC=8CI will switch to rcu_assign_pointer()/rcu_dereference().
And try to solve warnings from Sparse.


>=20
> [1] =
https://lore.kernel.org/netdev/86BE7746-4418-4B69-A6D6-091EC9418E70@net-sw=
ift.com/
>=20
>>>=20
>>>> @@ -2245,10 +2245,10 @@ static void wx_free_q_vector(struct wx *wx, =
int v_idx)
>>>> struct wx_ring *ring;
>>>>=20
>>>> wx_for_each_ring(ring, q_vector->tx)
>>>> - wx->tx_ring[ring->queue_index] =3D NULL;
>>>> + WRITE_ONCE(wx->tx_ring[ring->queue_index], NULL);
>>>>=20
>>>> wx_for_each_ring(ring, q_vector->rx)
>>>> - wx->rx_ring[ring->queue_index] =3D NULL;
>>>> + WRITE_ONCE(wx->rx_ring[ring->queue_index], NULL);
>>>=20
>>> [ ... ]
>>>=20
>>> --=20
>>> Sashiko AI review =C2=B7 =
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/4353E83B1147D652%2B202=
60830070624.7410-1-mengyuanlou%40net-swift.com


