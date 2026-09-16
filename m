Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF248FF83;
	Wed, 16 Sep 2026 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577414; cv=none; b=cmDXAnokw6OvtnMKpInNhkKF5J46HnZbtIwJXvkrPGfZ4/2JWzJqkbapgvgu646i54a4d5VVMA0KeFeOj5wrMRCDod3g1keSNIg2x/hZTFl83wd3g2KkrO10kAM9phjAr6fNrJCRb2IooD97lmNaLctn9nli4A/85MtBsBXlrzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577414; c=relaxed/simple;
	bh=PvE5gwnvrLjj+qizyD1DjjC9DOL5FxPeN+s/O5bRng4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ni9mhj4Vf6O0Wc//fCkEwfQCDBOqnWB2+5eJ2iCxSnDryUzfOqlEJeZGlg+9LooyevYe76SdqPveWMPgW60tQfDLWwmrWbHPn+k+7bKT2bmwwHQoJXktiIVNkeljXGNRpX1JO07wsT0ckyiYZ3Bit+B0idnQzZhFvnDRgC6zqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lI8q8aF2; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lI8q8aF2"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GFfcxx2321380;
	Wed, 16 Sep 2026 09:49:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=OtcixqO2RGVkz8SaQj6eeRl
	wDrXL4L52OxV9Lu8ANQY=; b=lI8q8aF2kj4hyFIjZnyiWXcpJtJME/6sAdyA8BG
	balFlfPefelc7++da3EcRbmp5kZZJ290M2WKyE8GYbGNab8HooKNneirxE3LieBa
	0wuABWR5aWc6Ph0VvvtKgHzbL4GsqlHnda0A9O8eIFhFa91loZ2/D9fLYx10m8ft
	o77NBGwB1ewjpbK9VEiEGnIw5kZ+MUnHFQOG8HZs5XfYTMWh+Lw1WdUWPlhEg+tr
	yifjC2+CYf0+q7V35tRco8gEkWSauEZlgGgdRa3eOYAYfBRChcaA8Lik+Fo7NPl1
	J8+XUTOHOGJi+1DAvSrcj9oubC4RhHR531uQIWVCu6x8K2Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gqeft5arj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 09:49:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 16 Sep 2026 09:49:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 16 Sep 2026 09:49:37 -0700
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 3B8923F70BA;
	Wed, 16 Sep 2026 09:49:32 -0700 (PDT)
Date: Wed, 16 Sep 2026 22:19:32 +0530
From: Nitin Shetty J <nshettyj@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gakula@marvell.com>, <sgoutham@marvell.com>, <rkannoth@marvell.com>,
        <sbhatta@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <bbhushan2@marvell.com>, <horms@kernel.org>, <hkalra@marvell.com>
Subject: Re: [PATCH net v3] octeontx2-af: Fix rep link state sync and
 workqueue races
Message-ID: <aqrInFMnvs4K48+3@kernel-ep2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIzMCBTYWx0ZWRfX442R3iHeNYhR
 iocSV5+F4PNsNYsvUGjqthJjTO9wZ4QCGgCIFcbMtd7eJyLBBswd50ggAmTbOAX0PDqdXKtekFL
 Db304eQMF6/366VB8jzdmLVHNzQTyv4=
X-Authority-Analysis: v=2.4 cv=cIV1IVeN c=1 sm=1 tr=0 ts=6aaac8a2 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=9R54UkLUAAAA:8
 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8 a=CTFQr-jT7tHTmo-U8y8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=YTcpBFlVQWkNscrzJ_Dz:22
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: hWeE5C8-zKupUh2wbCzOhlYm7sYzQZbx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIzMCBTYWx0ZWRfX62PoMdSiCysp
 64xwVsj7H0XyXGJeSsN0mLSHRGVYAwzWLVlutg/+63zZp+33UGYRpw8duNOdMuPAsFhkdjvZkx/
 RiXVWAWR+uyjljKmssg1NwgOsbPr8HqMg3iOTJej5hfX22xnjPEWW5M5OgwotgUMf050OjziRxt
 226Twz+0rNgxSm0SpDiSYc43PXt6XvfaZ6osDYMstBPAFvfuYYOWYsSwA157wuTTXZBMPirmoKF
 w5dAKsVNYTxwzxTWSinSw6yyXp9RMUEhsumvpzy++Rh0eHeVaP1roNo/V54nBwo/7ht4hlrpZ+M
 8GYOk2okDnF2ydf1GUoGN3keTQkw+0PytjmdAl/JGKFF42z0k+k+jUMn4ko1+R1M2mTABAVdUlK
 IheApH5VLpwxbar/U6plHb1Ml696DGTdtY+cfzvuKEgKWR9dsN+Xix9wsGR1SX7SblGULoeBiBt
 lLYF6bnrNljUqNdtZZQ==
X-Proofpoint-GUID: hWeE5C8-zKupUh2wbCzOhlYm7sYzQZbx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01

On 2026-09-09 at 04:21:15, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 10 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 2 (1) · Medium: 7 (1) · Low: 1
> 
> - [High] The new authorization gates added by this patch
>   (`req->hdr.pcifunc != rvu->rep_pcifunc -> -EPERM` in…
> - [High] rvu_mbox_handler_get_rep_cnt() now truncates rvu->rep_cnt /
>   rep2pfvf_map to RVU_MAX_REP (64) entries, but every consumer in the AF…
> - [Medium] rvu_rep_open() and rvu_rep_stop() in nic/rep.c now return
>   early for every VF representor (`if (rep->pcifunc &…
> - [Medium] The new teardown barrier in rvu_remove() only flushes
>   rvu->afpf_wq_info.mbox_wq before destroy_workqueue(rep_wq), and its…
> - [Medium] The representor PF's own TL2->LBK link enable performed by
>   rvu_rep_pf_init() (rvu_rep.c:445-451, rvu_switch_enable_lbk_link(rvu,…
> - [Medium] rvu_remove() decides whether to destroy rvu->rep_evt_wq, and
>   clears the pointer, without holding rvu->rsrc_lock, whereas…
> - [Medium] The patch introduces a lockless publish/consume protocol for
>   rvu->rep_evt_wq (rvu_remove() uses WRITE_ONCE(),…
> - [Medium] rvu_rep_install_mcam_rules() tests test_bit(NIXLF_INITIALIZED,
>   &pfvf->flags) outside any lock and then calls…
> - [Medium] Draining the representor event workqueue after unregistering
>   interrupts causes mailbox communication timeouts.
> - [Low] In the first-time GET_REP_CNT path, `rvu->rep_pcifunc =
>   req->hdr.pcifunc;` (rvu_rep.c:504) executes before both -ENOMEM exits…
> 
> Pre-existing issues:
> - [High] When rvu_rep_install_mcam_rules() fails (the new err_disable_lbk
>   path still returns err), rvu_switch_enable()'s uninstall_rules label…
> - [Medium] rvu_rep_install_tx_rule() first calls rvu_rep_tx_vlan_cfg(),
>   which allocates a NIX TX VTAG definition entry and programs…
> 
> --
> 
> octeontx2-af: Fix rep link state sync and workqueue races
> 
> This moves the representor event workqueue creation from
> rvu_rep_install_mcam_rules() into rvu_mbox_handler_get_rep_cnt(), adds
> sender and bounds validation to the REP mailbox handlers, and makes LBK
> link configuration take rsrc_lock.  A few questions below about the new
> validation and teardown paths.
> 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> > index 937b085582b5..dc4e1fa900b7 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> > @@ -3721,6 +3721,20 @@ static void rvu_remove(struct pci_dev *pdev)
> >  	rvu_unregister_dl(rvu);
> >  	rvu_unregister_interrupts(rvu);
> >  	rvu_flr_wq_destroy(rvu);
> > +	if (rvu->rep_evt_wq) {
> > +		struct workqueue_struct *rep_wq = rvu->rep_evt_wq;
> > +
> > +		/* NULL the pointer before flushing mbox_wq.  Any mbox handler
> > +		 * still in flight will snapshot NULL via READ_ONCE() and return
> > +		 * -EINVAL without calling queue_work(), so no new items can be
> > +		 * added to rep_wq after flush_workqueue(mbox_wq) returns.
> > +		 */
> > +		WRITE_ONCE(rvu->rep_evt_wq, NULL);
> > +		flush_workqueue(rvu->afpf_wq_info.mbox_wq);
> > +		destroy_workqueue(rep_wq);
> > +	} else {
> > +		flush_workqueue(rvu->afpf_wq_info.mbox_wq);
> > +	}
> 
> [Severity: Medium]
> This teardown sits after rvu_unregister_interrupts(), which has
> already disabled the AF-PF mailbox interrupt (RVU_AF_PFAF_MBOX_INT_ENA_W1C,
> or cn20k_rvu_unregister_interrupts()).  destroy_workqueue() calls
> drain_workqueue(), so any rep_evt_work still queued now runs to
> completion here, and rvu_rep_wq_handler() -> rvu_rep_up_notify() does
> otx2_mbox_msg_send_up() followed by otx2_mbox_wait_for_zero() and
> otx2_mbox_wait_for_rsp() on rvu->afpf_wq_info.mbox_up.
> 
> With the mailbox interrupt already gone, the PF's reply is never
> processed by the AF, so each of those waits has to time out rather
> than complete.  With a non-empty rep_evtq_head that is paid per
> queued event, all while holding rvu->mbox_lock, which stretches
> rvu_remove() out by seconds at a time on a path userspace is
> blocked on.
> 
> Would it be better to move this block ahead of
> rvu_unregister_interrupts() so the pending up-notifies can still be
> acknowledged, or alternatively to stop rvu_rep_wq_handler() from
> sending anything once removal has started (a teardown flag checked
> before otx2_mbox_msg_send_up(), or draining rep_evtq_head and
> freeing the qentries without notifying)?  Note the same question
> applies to the qentry list itself: nothing appears to free the
> entries that are still on rvu->rep_evtq_head if the handler is not
> allowed to consume them.
> 
wiil fix it in next patch version.

> [Severity: Medium]
> Is flushing only rvu->afpf_wq_info.mbox_wq enough to close the
> queue_work() window the comment describes?
> 
> The same rvu_mbox_handler_* dispatch also runs on
> rvu->afvf_wq_info.mbox_wq via rvu_afvf_mbox_handler(), and that
> workqueue is destroyed much later, inside rvu_disable_sriov() ->
> rvu_mbox_destroy().  For AF-VF messages the dispatcher clears only the
> func bits and keeps the sender-supplied PF field, so
> rvu_mbox_handler_nix_lf_start_rx()/nix_lf_stop_rx()/rvu_nix_lf_teardown()
> can reach rvu_rep_notify_pfvf_state(), which sets
> req.hdr.pcifunc = rvu->rep_pcifunc and therefore passes the new -EPERM
> gate:
> 
> CPU0 (afvf mbox work)               CPU1 (rvu_remove)
>   wq = READ_ONCE(rvu->rep_evt_wq);  /* non-NULL */
>                                     WRITE_ONCE(rvu->rep_evt_wq, NULL);
>                                     flush_workqueue(afpf mbox_wq);
>                                     destroy_workqueue(rep_wq);
>   queue_work(wq, &rvu->rep_evt_work);  /* freed wq */
> 
> Should the afvf mailbox workqueue be flushed here too (or the VF mailbox
> torn down before this point)?  The qentry that handler already kmalloc'd
> and put on rep_evtq_head is leaked in that case as well.
> 
wiil fix it in next patch version.

> [Severity: Medium]
> Can rvu->rep_evt_wq become non-NULL after this if () test?  The
> producer, rvu_mbox_handler_get_rep_cnt(), now publishes the pointer
> under rvu->rsrc_lock, while this teardown reads and clears it with no
> lock and never re-checks:
> 
> CPU0 (get_rep_cnt work on mbox_wq)   CPU1 (rvu_remove)
>                                      if (rvu->rep_evt_wq)  /* NULL */
>                                      else
>                                        flush_workqueue(mbox_wq);
>   mutex_lock(&rvu->rsrc_lock);
>   rvu->rep_evt_wq = alloc_workqueue(...);
> 
> The freshly created workqueue and its worker pool are then never
> destroyed, and a REP_EVENT_NOTIFY message processed later in the same
> drained batch can queue_work(&rvu->rep_evt_work) on a workqueue nothing
> waits for, so rvu_rep_wq_handler() may touch rvu after
> devm_kfree(&pdev->dev, rvu).  Would taking rsrc_lock here (or a
> "removing" flag checked by the handler) close that?
>
wiil fix it in next patch version.
 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> > index a2781e0f504e..69b260fdd52d 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> 
> [ ... ]
> 
> > @@ -95,8 +101,17 @@ static void rvu_rep_wq_handler(struct work_struct *work)
> >  int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
> >  				      struct msg_rsp *rsp)
> >  {
> > +	struct workqueue_struct *wq;
> >  	struct rep_evtq_ent *qentry;
> >  
> > +	wq = READ_ONCE(rvu->rep_evt_wq);
> > +	if (!wq)
> > +		return -EINVAL;
> > +
> > +	/* Only the registered representor PF may send REP_EVENT_NOTIFY. */
> > +	if (req->hdr.pcifunc != rvu->rep_pcifunc)
> > +		return -EPERM;
> 
> [Severity: High]
> How much does this gate actually restrict, given that rvu->rep_pcifunc
> is whatever function sent MBOX_MSG_GET_REP_CNT first?
> 
> rvu_mbox_handler_get_rep_cnt() still does an unconditional
> rvu->rep_pcifunc = req->hdr.pcifunc with no check that the sender is the
> representor function (PCI_DEVID_RVU_REP), no capability check and no
> rep_mode gating.  The PF driver forwards VF mailbox messages to the AF
> verbatim - otx2_pfvf_mbox_handler() only rewrites the func bits and does
> no message-ID filtering:
> 
> 	msg->pcifunc &= ~RVU_PFVF_FUNC_MASK;
> 	msg->pcifunc |= (vf_idx + 1) & RVU_PFVF_FUNC_MASK;
> 
> So can a guest VF send GET_REP_CNT before the representor driver probes,
> become rvu->rep_pcifunc, and then satisfy both new -EPERM checks?  From
> there REP_EVENT_NOTIFY with req->pcifunc pointing at any other
> CGX-mapped function passes is_pf_func_valid()/is_pf_cgxmapped() (those
> only confirm the victim exists), and rvu_rep_up_notify() then does:
> 
> 	if (event->event & RVU_EVENT_MAC_ADDR_CHANGE)
> 		ether_addr_copy(pfvf->mac_addr, event->evt_data.mac);
> 
> overwriting the victim's AF-side MAC and sending a forged up-notify to
> the victim's PF.  is_rep_dev() is just a pcifunc comparison against
> rvu->rep_pcifunc, so the same caller also gets representor treatment in
> rvu_nix.c / rvu_npc_fs.c, and the real representor driver is locked out
> afterwards because its GET_REP_CNT now returns -EPERM.  Should the
> registration itself authenticate the representor rather than trusting
> the first mailbox caller?
> 
For the guest VF path, we can check req->hdr.pcifunc & RVU_PFVF_FUNC_MASK
in rvu_mbox_handler_get_rep_cnt() and reject with -EPERM if set,
so a VF can not register as rep_pcifunc.
Full PF authentication is a larger change, we'll address that in a
separate patch set.

> [ ... ]
> 
> >  int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable)
> >  {
> > -	struct rep_event *req;
> > -	int pf;
> > +	struct rep_event req = { 0 };
> > +	struct msg_rsp rsp;
> >  
> >  	if (!is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)))
> >  		return 0;
> >  
> > -	pf = rvu_get_pf(rvu->pdev, rvu->rep_pcifunc);
> > -
> > -	mutex_lock(&rvu->mbox_lock);
> > -	req = otx2_mbox_alloc_msg_rep_event_up_notify(rvu, pf);
> 
> [ ... ]
> 
> > +	req.hdr.pcifunc = rvu->rep_pcifunc;
> > +	req.event = RVU_EVENT_PFVF_STATE;
> > +	req.pcifunc = pcifunc;
> > +	req.evt_data.vf_state = enable;
> > +	return rvu_mbox_handler_rep_event_notify(rvu, &req, &rsp);
> >  }
> 
> [ ... ]
> 
> > @@ -334,19 +344,22 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
> >  			continue;
> >  
> >  		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
> > +		pfvf = rvu_get_pfvf(rvu, pcifunc);
> >  		rvu_get_nix_blkaddr(rvu, pcifunc);
> > +		if (test_bit(NIXLF_INITIALIZED, &pfvf->flags))
> > +			rvu_switch_enable_lbk_link(rvu, pcifunc, true);
> 
> [Severity: Medium]
> Does moving rsrc_lock inside rvu_switch_enable_lbk_link() serialize
> anything useful here?  The NIXLF_INITIALIZED test is outside the lock,
> and the flag is set in rvu_mbox_handler_nix_lf_start_rx() and cleared in
> rvu_mbox_handler_nix_lf_stop_rx()/rvu_nix_lf_teardown() with no lock at
> all.  rvu_rep_install_mcam_rules() runs from
> rvu_devlink_eswitch_mode_set() -> rvu_switch_enable(), which holds no
> RVU lock:
> 
> CPU0 (devlink switchdev)              CPU1 (mbox NIX_LF_STOP_RX)
>   test_bit(NIXLF_INITIALIZED) /* 1 */
>                                       clear_bit(NIXLF_INITIALIZED);
>                                       rvu_switch_update_rules(false)
>                                         rvu_rep_update_rules()
>                                           lbk_link(..., false); /* lock */
>   rvu_switch_enable_lbk_link(true);
>     /* lock, writes enable */
> 
> Doesn't that leave the TL2 LBK link on channel 63 enabled for a function
> whose NIXLF was stopped or freed?  The new err_disable_lbk rollback and
> the new rep_mode loop in rvu_switch_disable() can lose the same race
> against a concurrent LF start.
> 
Yes. this race is still open since rsrc_lock isn't held across the
test_bit(NIXLF_INITIALIZED, ...) check and the subsequent LBK link
enable/disable. Fixing it properly needs broader lock coverage across
that check-then-act sequence, so we'd like to take it up in a
follow-up patch.

> [ ... ]
> 
> > @@ -366,30 +382,37 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
> >  		}
> >  	}
> > +	return 0;
> >  
> > -	/* Initialize the wq for handling REP events */
> > -	spin_lock_init(&rvu->rep_evtq_lock);
> > -	INIT_LIST_HEAD(&rvu->rep_evtq_head);
> > -	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
> > -	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", WQ_PERCPU, 0);
> > -	if (!rvu->rep_evt_wq) {
> > -		dev_err(rvu->dev, "REP workqueue allocation failed\n");
> > -		return -ENOMEM;
> > +err_disable_lbk:
> > +	/* Undo any LBK links enabled above before the MCAM rule failure.
> > +	 * Disabling a link that was never enabled is a safe no-op.
> > +	 */
> > +	for (pf = 1; pf < hw->total_pfs; pf++) {
> > +		if (!is_pf_cgxmapped(rvu, pf))
> > +			continue;
> > +		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
> > +		rvu_switch_enable_lbk_link(rvu, pcifunc, false);
> > +		rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
> > +		for (vf = 0; vf < numvfs; vf++) {
> > +			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf + 1);
> > +			rvu_switch_enable_lbk_link(rvu, pcifunc, false);
> > +		}
> >  	}
> > -	return 0;
> > +	return err;
> >  }
> 
> [Severity: Medium]
> Does this rollback miss the representor function itself?
> rvu_rep_pf_init() enables the LBK link for rvu->rep_pcifunc:
> 
> 	set_bit(NIXLF_INITIALIZED, &pfvf->flags);
> 	rvu_switch_enable_lbk_link(rvu, pcifunc, true);
> 
> but this loop, and the new rep_mode loop in rvu_switch_disable(), both
> skip anything that is not CGX-mapped, and the representor is a separate
> non-CGX-mapped function (PCI_DEVID_RVU_REP).  rvu_nix_tx_tl2_cfg()
> explicitly allows the write for it:
> 
> 	if (!is_pf_cgxmapped(rvu, pf) && !is_rep_dev(rvu, pcifunc))
> 		return;
> 
> So after a failed install, or after "devlink dev eswitch set mode
> legacy", does the representor PF keep its TL2 nodes pointed at LBK
> channel 63 with all matching NPC entries deleted?  Nothing re-evaluates
> it either, since rvu_rep_pf_init() leaves NIXLF_INITIALIZED set on the
> rep pfvf.
> 
will fix it in next patch version.

> [Severity: High]
> This isn't a bug introduced by this patch, but every rule-installation
> failure now routes through this return err, so it may be worth fixing
> alongside.  rvu_switch_enable()'s uninstall_rules label does
> kfree(rswitch->entry2pcifunc) without clearing the pointer or resetting
> rswitch->used_entries, and rvu_devlink_eswitch_mode_set() has already
> committed rswitch->mode.  A following "devlink dev eswitch set mode
> legacy" reaches rvu_switch_disable(), whose only guard is:
> 
> 	if (!rswitch->used_entries)
> 		return;
> 	...
> free_ents:
> 	...
> 	kfree(rswitch->entry2pcifunc);
> 
> which frees the same pointer a second time.  rvu_rep_update_rules() and
> rvu_switch_update_rules(), reachable from NIX_LF_START_RX/STOP_RX
> mailbox messages, are gated only on used_entries as well and then read
> rswitch->entry2pcifunc[entry].  Should the failure path also clear
> rswitch->entry2pcifunc and rswitch->used_entries?
> 
will fix it in next patch version.

> [Severity: Medium]
> This is a pre-existing issue, but does the new cleanup also need to
> release TX VTAG definitions?  rvu_rep_install_tx_rule() calls
> rvu_rep_tx_vlan_cfg() first, which allocates a NIX TX VTAG definition
> entry and programs NIX_AF_TX_VTAG_DEFX_DATA/CTL, and only then calls
> rvu_mbox_handler_npc_install_flow().  When the MCAM install fails the
> returned vtag0_idx is dropped: err_disable_lbk only touches LBK links,
> and rvu_switch_enable()'s uninstall_rules/free_entries labels only
> delete NPC flows and free MCAM entries, while VTAG entries live in
> nix_hw->txvlan and need nix_tx_vtag_free().  Do repeated failed
> switchdev enables then consume the hardware VTAG definition table?
> 
Yes. since it is exisitng issue will fix it in separate patch.

> [ ... ]
> 
> > @@ -443,35 +466,92 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
> 
> [ ... ]
> 
> >  int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
> >  				 struct get_rep_cnt_rsp *rsp)
> >  {
> > -	int pf, vf, numvfs, hwvf, rep = 0;
> > +	int pf, vf, numvfs, hwvf, rep = 0, cnt;
> > +	int ret = 0;
> >  	u16 pcifunc;
> > +	u16 *map;
> > +
> > +	/* Serialize first-time initialization. mbox_wq is WQ_PERCPU so
> > +	 * handlers for different PFs can run concurrently; without this
> > +	 * lock two callers could both observe rep2pfvf_map == NULL and
> > +	 * double-allocate the workqueue, leaking one permanently.
> > +	 */
> > +	mutex_lock(&rvu->rsrc_lock);
> > +
> > +	if (rvu->rep2pfvf_map) {
> > +		ret = rvu_rep_get_rep_map(rvu, req, rsp);
> > +		goto unlock;
> > +	}
> >  
> >  	rvu->rep_pcifunc = req->hdr.pcifunc;
> 
> [Severity: Low]
> Is it intentional that rvu->rep_pcifunc is published before both -ENOMEM
> exits below?  On either failure rvu->rep2pfvf_map stays NULL, so the
> fast-path guard above does not fire for the next caller, which re-enters
> this branch and overwrites rvu->rep_pcifunc.  Meanwhile the failed
> caller already has is_rep_dev() true, and its pcifunc is consumed by
> rvu_rep_install_rx_rule()/rvu_rep_install_tx_rule() (req.vf =
> rvu->rep_pcifunc) and by rvu_rep_pf_init(), which sets
> NIXLF_INITIALIZED and enables the LBK link for it.  Would assigning
> rep_pcifunc only on the success path avoid that stale state?
> 
> > -	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
> > -	rvu->rep_cnt = rsp->rep_cnt;
> > +	cnt = min_t(int, rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs,
> > +		    RVU_MAX_REP);
> 
will fix it in next patch version.

> [Severity: High]
> What happens on a part where rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs
> exceeds RVU_MAX_REP?  The map is capped here, but the consumers are not:
> rvu_switch_enable() still sizes the MCAM allocation from the uncapped
> sum (times 4 in rep mode), and rvu_rep_install_mcam_rules() still loops
> pf = 1..hw->total_pfs and vf = 0..numvfs with no bound tied to
> rvu->rep_cnt.
> 
> Both rule installers take their VLAN/index from rvu_rep_get_vlan_id(),
> which falls off its loop and returns the identifier of representor 0
> when the pcifunc is not in the map:
> 
> 	for (id = 0; id < rvu->rep_cnt; id++)
> 		if (rvu->rep2pfvf_map[id] == pcifunc)
> 			return id;
> 	return 0;
> 
> So for every function past the cap, does rvu_rep_install_rx_rule()
> program a rule identical to representor 0's -
> 
> 	vlan_tci = rep_id | BIT_ULL(8);
> 	req.vf = rvu->rep_pcifunc;
> 	req.index = rep_id;
> 
> - and steer that traffic to the wrong representor?  Their state events
> are dropped on the peer side as well, since rvu_rep_get_repid() returns
> -EINVAL and only the new warning fires.  Since numvfs is an 8-bit
> per-PF field summed over all CGX PFs, 8 PFs with 8 VFs each already
> passes 64.  Would rejecting such a configuration with a diagnostic here,
> or applying the same cap in the rule installer and event producers, be
> preferable to silent truncation?
> 
the cgx_mapped_pfs  and cgx_mapped_vfs are programmed from firmware.
max cgx_mapped_pfs is 8 and max cgx_mapped_vfs per PF is 3. this is
well within the limit 64. will fix it in next patch version.

> [ ... ]
> 
> > +	/* Initialize the wq for handling REP events */
> > +	spin_lock_init(&rvu->rep_evtq_lock);
> > +	INIT_LIST_HEAD(&rvu->rep_evtq_head);
> > +	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
> > +	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", WQ_UNBOUND, 0);
> 
> [Severity: Medium]
> The consumer side uses READ_ONCE(rvu->rep_evt_wq) as the gate for
> touching rep_evtq_lock, rep_evtq_head and rep_evt_work, but the
> publication here is a plain store with no smp_store_release() and the
> reader has no acquire.  On a weakly ordered machine, can a consumer that
> is not serialized with this function by rvu->mbox_lock - for example
> rvu_mbox_handler_rep_event_notify() reached from an AF-VF mailbox work
> item, since rvu_afvf_mbox_handler() does not take mbox_lock - see
> rep_evt_wq non-NULL before the spin_lock_init()/INIT_LIST_HEAD()/
> INIT_WORK() stores are visible, and then run spin_lock() and
> list_add_tail() on uninitialized state?  The same ordering question
> applies to rvu->rep_pcifunc, which now gates the -EPERM check.
> 
will fix it in next patch version.

> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> > index 49ce38685a7e..8c2c98403507 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
> > @@ -12,11 +12,18 @@ void rvu_switch_enable_lbk_link(struct rvu *rvu, u16 pcifunc, bool enable)
> >  {
> >  	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
> >  	struct nix_hw *nix_hw;
> > +	int blkaddr;
> >  
> > -	nix_hw = get_nix_hw(rvu->hw, pfvf->nix_blkaddr);
> > +	mutex_lock(&rvu->rsrc_lock);
> > +	blkaddr = pfvf->nix_blkaddr;
> > +	nix_hw = get_nix_hw(rvu->hw, blkaddr);
> >  	/* Enable LBK links with channel 63 for TX MCAM rule */
> > -	rvu_nix_tx_tl2_cfg(rvu, pfvf->nix_blkaddr, pcifunc,
> > +	if (!nix_hw)
> > +		goto unlock;
> > +	rvu_nix_tx_tl2_cfg(rvu, blkaddr, pcifunc,
> >  			   &nix_hw->txsch[NIX_TXSCH_LVL_TL2], enable);
> > +unlock:
> > +	mutex_unlock(&rvu->rsrc_lock);
> >  }
> 
> [ ... ]
> 
> > @@ -229,8 +236,20 @@ void rvu_switch_disable(struct rvu *rvu)
> >  	if (!rswitch->used_entries)
> >  		return;
> >  
> > -	if (rvu->rep_mode)
> > +	if (rvu->rep_mode) {
> > +		for (pf = 1; pf < hw->total_pfs; pf++) {
> > +			if (!is_pf_cgxmapped(rvu, pf))
> > +				continue;
> > +			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
> > +			rvu_switch_enable_lbk_link(rvu, pcifunc, false);
> > +			rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
> > +			for (vf = 0; vf < numvfs; vf++) {
> > +				pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf + 1);
> > +				rvu_switch_enable_lbk_link(rvu, pcifunc, false);
> > +			}
> > +		}
> >  		goto free_ents;
> > +	}
> 
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > index 0f5d5642d3f7..ef47e7e21901 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> 
> [ ... ]
> 
> > @@ -459,6 +465,9 @@ static int rvu_rep_open(struct net_device *dev)
> >  	netif_carrier_on(dev);
> >  	netif_tx_start_all_queues(dev);
> >  
> > +	if (rep->pcifunc & RVU_PFVF_FUNC_MASK)
> > +		return 0;
> > +
> >  	evt.event = RVU_EVENT_PORT_STATE;
> >  	evt.evt_data.port_state = 1;
> >  	evt.pcifunc = rep->pcifunc;
> 
> [Severity: Medium]
> These two early returns in rvu_rep_open() and rvu_rep_stop() skip the
> RVU_EVENT_PORT_STATE notification for every VF representor, which is the
> representor-to-representee link state propagation added by the commit in
> the Fixes: tag (b8fea84a0468).  After this, does "ip link set <vf-rep>
> up/down" still affect the representee?
> 
> The reason the notification does not work today looks like the missing
> handler on the VF side - otx2vf_process_mbox_msg_up() only handles
> MBOX_MSG_CGX_LINK_EVENT and answers everything else with:
> 
> 	default:
> 		otx2_reply_invalid_msg(&vf->mbox.mbox_up, 0, 0, req->id);
> 		return -ENODEV;
> 
> while the PF side does implement
> otx2_mbox_up_handler_rep_event_up_notify().  Would adding
> MBOX_MSG_REP_EVENT_UP_NOTIFY to otx2vf_process_mbox_msg_up() be the fix
> instead?  Neither the commit message nor the changelog mentions these
> two hunks.
> 
I agree this should be properly handled instead of simply early return.
will fix this issue in separate patch.

> > @@ -478,6 +487,9 @@ static int rvu_rep_stop(struct net_device *dev)
> >  	netif_carrier_off(dev);
> >  	netif_tx_disable(dev);
> >  
> > +	if (rep->pcifunc & RVU_PFVF_FUNC_MASK)
> > +		return 0;
> > +
> >  	evt.event = RVU_EVENT_PORT_STATE;
> >  	evt.pcifunc = rep->pcifunc;
> >  	rvu_rep_notify_pfvf(priv, RVU_EVENT_PORT_STATE, &evt);
> 
> Thanks for looking at these.
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903074840.2373506-1-nshettyj%40marvell.com
> 
