Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60253F44FC;
	Wed, 16 Sep 2026 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546871; cv=none; b=TQUpA3pLvSdQbHkG3NjECPfp9kvcGOvtZQ6iRm1SEYA/+65cWeadXVkRYjNc/0Xe0Z3/VLfkRV79GQudUq55ZhSWRIE6FoM6Qc49uArDVHc9B28dMqLjBpsUbmeZZSG5DJU8sHO5qvt/4ecVkc0fQpg/aAs+KQMiIt1kfCSQ354=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546871; c=relaxed/simple;
	bh=ix6laa1fKv2LFzkSRvr2rCnc+C4gK0RcvvSc9hf8WMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgTgsjE6FQt49Ez/g6XMt8KvhKZ9xScLMn4bbn04DYtAHoLXqKlxcJodi2XPTB+oLKim3Ck6v27Hm2YgsaDJQZdRZrd7tUxefAOTxeR/+bdSHHcpYYZlP6fZukujPTOF6aN8z1cQzQwb5VpLoVlDLzo2iZQ3GAVq4vEVQEIKThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=rr1Uyzd0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ha6rUjAP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="rr1Uyzd0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ha6rUjAP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DCE67140021C;
	Wed, 16 Sep 2026 04:20:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Sep 2026 04:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789546852;
	 x=1789633252; bh=UDg6j9mrNyQqsYJm04DMtPrMhfBRlvBun7iipLIlzG0=; b=
	rr1Uyzd0LiQ7IrIdneM94F8+BDZxZrj7gj9vknOAlJ2lPtWkIom+O3r2uS7VNQVO
	J60ApCH+TOenX+oXvQXILCglVGuqFdtXmoadWGw8zhtGQxLlcgTmcucaQr2Nyy1S
	0AhvJggnxsLJni27YKIOoC6ZomQvdhuHa6EkCePEp6HoX5efiGztblVzR+jAFmm5
	Q0U7nQvPtz44nWT+7P9XwM8MhejYyY2XvZBxci/7nMhKc0DNFCPbvUiNKcEZNMiu
	CwjbRtVpwCVHT+W6DjYd94nnYT4qZQ8CNWnKh8gV3CFOWjkN+iBcWybeCL94j2rv
	Prk/zkhpKzFu4VZojTDlEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789546852; x=
	1789633252; bh=UDg6j9mrNyQqsYJm04DMtPrMhfBRlvBun7iipLIlzG0=; b=h
	a6rUjAPyKE+E0e1NaTEXilEtmYWYsjQLlzANWs7gPUqtsDwLEroE1VtZ4nSu7hw+
	OO9vKsbBf4eridM+afR2wRfy2eGNPYUvlBXXpjCskxYn5kiIW+EFXBh52/YlHWgE
	qGCACiD0kk4QY4et0v+gv9ARuxfJ727L/aMp7q3BHhNTyem6KhMlH7sAJwyFCW9L
	rmO2kwse82NixoN04OMy4G1623cAJZoPL54JOVVYrMbTpXBbpEHLiDCTzVV1hAPm
	qqyR1FVye3rSL/DwxgPBsijkR0jDBGMtWAU4WtkgNDy3OBj2kXFI6aRYYXntXPzq
	RwTqHwGRIBmNAn5hOzczQ==
X-ME-Sender: <xms:Y1GqapcYaEc2nmjd9kLbpBHzVKDasiVaaenT-s5MBCH40Ei92uJDPA>
    <xme:Y1Gqav-9xifvD5wHyFto0jUQEg3LjlOvy9e5xJRGSQROEuQ0ppTW7spRj-Geyd-Wl
    00s6BovIXPkWpQg0u6GongnWxwQ6_pmfQZVQaHrJIYR3jTij5LPuq5E>
X-ME-Received: <xmr:Y1GqahMfBRJwjNg5nfGcq3oDbaNpnYm7Hr39msZ9GpVM8x58jWvsOqnc4sHjSH-EkpxDIsE5v4GLD3wGjY88Fts-fFgkINI>
X-ME-Proxy-Cause: dmFkZTEZ/FnrnXrU0dEbJjONYhhQwSshApZlhZstejMN6Z5IZDCVI7roXM0j3CI2q2k1PC
    2hTp4NJu7GUVxuvGfqN77iOwSeR8geeg9ly7q/IijxwIN8h5Ah66sqbbTT4DuZOOOOxCk4
    Rx6ch++MK/g7lhXzhIzX8oTl0t4Siqj/nNxWuwIQHjIK0hX9uNLPpYYPYTInwnXSVc7eBQ
    U3VtcvWJoDjXAUToMAlziBp+EK6pbvyPXd6f9we3lbAjVAUJbeNQwo5H94J323XkPsVWaA
    CT5UzxCzKEZdrUjTailj/lt7nCELWJiqFb/z1z3icU8AyNb2S3j1dtmiLpz8y5xFWtXBpV
    IBAp1csKjbf+qVECC1rLdWqTRl0be5kQpXktBHieFqvJtSUeIlPPAhJmJarCBYFNEeM/i1
    yEOcv/+zMLk33OkY0dmdTpVAkRNCOSC0tET3OrAimKK+1mFPPVd2H+xJJExPoGugSK8TGK
    UtigDus3oM4GmBVM5GEOOIp2jq8Dcm0e7X9t+fcN4bGEUqWeYXpvpjYiWviDXjHV6lWtx3
    Qj5KbwDTcq2PjfXHs+mvZgXGZyBCo171ib16j6PFlbPQeq0kRYihYnt64+bGNyKvSjxYh1
    nSJkrh6QieW8Ecu9IvmM4Tcljt36Py24LcdiAzZDvj/SjUiKt57OeJJmk9gg
X-ME-Proxy: <xmx:Y1GqalXkt8eCJNLLfZhAV9F5tSXgOMh4tEJsTaaB27Xcznc1A2ABJA>
    <xmx:Y1GqaphVgxC5cXkEIOamR_qX6u_wyxCLb-YLTC4YvVrN2c0j76YsfA>
    <xmx:Y1Gqal-46MJGu_4c0mGVa0KPYvhsDVu0znPAIGdVYkfhI9XXQXQqnA>
    <xmx:Y1GqagTk9YHyzcLF2XE-qwpePbGH3VB6P8Kxj-NDMvn-Vnd2IQf6sQ>
    <xmx:ZFGqakW_7fChfta5fkhU3U3noDdREZX9zb0hEbmzvcNQSD8CLgc18ccM>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 04:20:51 -0400 (EDT)
Date: Wed, 16 Sep 2026 10:20:49 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Jakub Kicinski <kuba@kernel.org>
Cc: paul@pbarker.dev, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, sergei.shtylyov@gmail.com,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/10] net: ethernet: ravb: Remove gPTP
 control from WoL setup and restore
Message-ID: <20260916082049.GN1991210@fsdn.se>
References: <20260909173027.2201560-2-niklas.soderlund+renesas@ragnatech.se>
 <20260915015434.881057-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915015434.881057-1-kuba@kernel.org>

Hello Jakub,

The LLM feedback (except the one for the already existing theoretical 
error in the error path which I will not try to fix in this already big 
series) is based on the LLM hallucination on the commit message. I will 
try to rewrite it so please the LLM.

On 2026-09-14 18:54:33 -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: ethernet: ravb: Remove gPTP control from WoL setup and restore
> 
> This removes the ccc_gac special case that stopped the gPTP clock in
> ravb_wol_setup() and re-initialized it in ravb_wol_restore(), on the
> grounds that ravb_open()/ravb_close() already handle gPTP start/stop.
> A few questions about the suspend side of that reasoning below.
> 
> >     This makes the special case to stop and start it when resuming from WoL
> >     redundant. As the ndev will always be closed and re-opened when
> >     suspending and resuming the system.
> 
> [Severity: High]
> Is the statement "the ndev will always be closed and re-opened when
> suspending and resuming the system" accurate for the WoL path?  In
> ravb_suspend() the WoL case returns before ravb_close() is reached:
> 
> 	rtnl_lock();
> 	if (priv->wol_enabled) {
> 		ret = ravb_wol_setup(ndev);
> 		rtnl_unlock();
> 		return ret;
> 	}
> 
> 	ret = ravb_close(ndev);
> 
> So on a WoL suspend, ravb_close() (and therefore its
> "if (info->gptp || info->ccc_gac) ravb_ptp_stop(ndev);") does not run at
> all during suspend; it only runs later, on the resume side, from the
> ravb_close() call at the end of ravb_wol_restore().  Does that make the
> suspend-side removal something other than a redundancy cleanup?
> 
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> > index ea1c7e536791..36173a09e2fd 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -3182,9 +3182,6 @@ static int ravb_wol_setup(struct net_device *ndev)
> >  	/* Enable MagicPacket */
> >  	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
> >  
> > -	if (priv->info->ccc_gac)
> > -		ravb_ptp_stop(ndev);
> > -
> >  	return enable_irq_wake(priv->emac_irq);
> >  }
> 
> [Severity: High]
> Following on from the commit message question: was this call also doing
> gPTP interrupt masking that nothing else on this path does?  ravb_ptp_stop()
> does more than unregister the PHC:
> 
> drivers/net/ethernet/renesas/ravb_ptp.c:
> static void ravb_ptp_disable(struct net_device *ndev)
> {
> 	ravb_write(ndev, 0, GIC);
> 	ravb_write(ndev, 0, GIS);
> }
> ...
> void ravb_ptp_stop(struct net_device *ndev)
> {
> 	...
> 	ravb_ptp_disable(ndev);
> 	ravb_ptp_sync_irqs(ndev);
> 
> ravb_wol_setup() clears RIC0/RIC2/TIC and writes ECSIPR, and only
> synchronizes and wake-enables priv->emac_irq.  It never touches GIC/GIS,
> and it does not synchronize ndev->irq/err_irq/mgmt_irq.  The GIC bits are
> armed from userspace via ravb_ptp_extts() (GIC_PTCE) and ravb_ptp_perout()
> (GIC_PTME) and are cleared only by ravb_ptp_disable().
> 
> Since the WoL path also skips pm_runtime_force_suspend() and
> reset_control_assert(), the block stays powered while suspended, so a
> programmed compare/capture can still fire on the now-suspended non-wake
> line and be latched and replayed by resume_device_irqs().  ravb uses
> SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume), so that replay happens
> before ravb_resume() runs.
> 
> Can the replayed interrupt then reach ravb_ptp_interrupt() while
> ravb_wol_restore() is resetting the block?
> 
> 	ravb_interrupt()/ravb_multi_interrupt()
> 	  -> ravb_ptp_interrupt()
> 	       gis &= ravb_read(ndev, GIC);
> 	       if ((gis & GIS_PTCF) && clock) {
> 		       ...
> 		       event.timestamp = ravb_read(ndev, GCPT);
> 		       ptp_clock_event(clock, &event);
> 
> priv->ptp.clock is still non-NULL after this change, so would that push a
> timestamp read from a just-reset GCPT to userspace, and RMW GIS/GCCR/GPTC
> concurrently with the unlocked ravb_set_opmode()/ravb_set_config_mode() in
> ravb_wol_restore()?
> 
> Also, does the remaining "/* Only allow ECI interrupts */" comment still
> describe the code for ccc_gac parts, and is the PHC (/dev/ptpN) now meant
> to stay registered for the whole suspended interval?
> 
> The restore-side removal of ravb_ptp_init() does look redundant; would it
> make sense to keep the suspend-side masking and synchronization, or to
> spell out in the commit message why dropping it is safe?
> 
> > @@ -3204,9 +3201,6 @@ static int ravb_wol_restore(struct net_device *ndev)
> >  	if (error)
> >  		return error;
> >  
> > -	if (priv->info->ccc_gac)
> > -		ravb_ptp_init(ndev, priv->pdev);
> > -
> 
> [Severity: Medium]
> After this change, is ravb_wol_restore() the only place that drives the
> AVB-DMAC through CCC_OPC_RESET while the gPTP PHC is still registered?
> The reset and config-mode re-entry happen at the top of the function:
> 
> 	/* Set reset mode to rearm the WoL logic. */
> 	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
> 	if (error)
> 		return error;
> 
> 	/* Set AVB config mode. */
> 	error = ravb_set_config_mode(ndev);
> 
> The other opmode transition sites stop the PHC first.  ravb_close():
> 
> 	/* Stop PTP Clock driver */
> 	if (info->gptp || info->ccc_gac)
> 		ravb_ptp_stop(ndev);
> 
> and the ravb_open() error path:
> 
> out_ptp_stop:
> 	/* Stop PTP Clock driver */
> 	if (info->gptp || info->ccc_gac)
> 		ravb_ptp_stop(ndev);
> 	ravb_stop_dma(ndev);
> out_set_reset:
> 	ravb_set_opmode(ndev, CCC_OPC_RESET);
> 
> The reset drops the GCCR TCSS=ADJGPTP selection and GTI programming that
> ravb_ptp_init() установ establishes, and priv->ptp.default_addend /
> current_addend still describe the pre-reset hardware; the clock is
> unregistered only later, by the ravb_close() at the end of the same
> function.  Pre-patch the ccc_gac branch unregistered the PHC in
> ravb_wol_setup() and re-created it here, so no registered PHC spanned the
> reset.  Should ravb_wol_restore() follow the same ordering as its peers?
> 
> >  	if (info->nc_queues)
> >  		napi_enable(&priv->napi[RAVB_NC]);
> >  	napi_enable(&priv->napi[RAVB_BE]);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but while both functions are
> being touched: can the NAPI enable/disable counts get out of balance on
> the WoL error paths, and hang in napi_disable()?
> 
> ravb_wol_setup() disables both NAPI instances and then returns the
> enable_irq_wake() result without re-enabling them:
> 
> 	if (info->nc_queues)
> 		napi_disable(&priv->napi[RAVB_NC]);
> 	napi_disable(&priv->napi[RAVB_BE]);
> 	ravb_write(ndev, ECSIPR_MPDIP, ECSIPR);
> 	...
> 	return enable_irq_wake(priv->emac_irq);
> 
> ravb_suspend() propagates that error directly.  On the restore side, the
> two early returns above skip the napi_enable() calls when ravb_wait()
> times out.
> 
> Since the WoL suspend path never closes the interface, the netdev stays
> netif_running() with NAPI disabled, and a failed suspend callback leaves
> dev->power.is_suspended clear so ravb_resume() is skipped.  The next
> ravb_close() (from "ip link set dev X down" or unregister_netdev()), or a
> retried suspend re-entering ravb_wol_setup(), calls napi_disable() again:
> 
> net/core/dev.c:napi_disable_locked() {
> 	...
> 		while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
> 			usleep_range(20, 200);
> 			val = READ_ONCE(n->state);
> 		}
> 
> 		new = val | NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC;
> 	...
> }
> 
> A completed disable leaves SCHED|NPSVC set and only napi_enable() clears
> them, so does the second disable spin here with no timeout while rtnl and
> the netdev instance lock are held?

-- 
Kind Regards,
Niklas Söderlund
