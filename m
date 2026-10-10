Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BDC23E334;
	Sat, 10 Oct 2026 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791650317; cv=none; b=ptI9NnkXF1N8dQQCpndf1GokLO9g/VJ49pK394/syluRbXTehNPrDMfQ42M28qxJEAl4WKVKI/8sXnAz2j39o7bIHiGDMOJbr8TMTWgUV6BQQED64hEUsSL+pi3T15upFPWzouB5T/0stsDOS2o5ak5RvDpejE/2QteMBX7OVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791650317; c=relaxed/simple;
	bh=zmyqyJ12J6F6aq+EqO4A5h/ASijsOSXeTujEjJqHpQk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiVsf3LALmde8faaeyYFpNp1YYOXXhG0jKOO6gH9scyinXdW9+qX9lt6ZQPaxLWcYv/IXGphznnDIc2PvIBLN80jNns4x0kxUXxAJQK3DWr3F/F3XfVZ+1kjHwNZE+9uUOCoxbHy8tt6Cz6nY+VV84OSlkx7wAkmLCJ8fWhFNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=x3W+O85r; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x3W+O85r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791650315; x=1823186315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zmyqyJ12J6F6aq+EqO4A5h/ASijsOSXeTujEjJqHpQk=;
  b=x3W+O85recqM2lif5hC3VJiWVSFH73pAceNhRogOSbcN6HlKZP4GL8Eu
   tPI4/FDQVVsclPeErcrTnDfh/n/IYy4UE8R6nz/7F46dvXiLMLllzxnxw
   gE12Orw+/JG7sIsDHORlmWx1qRVTmlm7K48f/t4BbYEnQ/6AAQkFqP9GS
   Eq5awahX1G0e+PshUU56m4EI7ABBRm5MhF4hCfIi9HH3oFrZzFnvvVknu
   4yJEY8Eiejoo0+PHNw6MzTz9Jgq58jLEgRbrORvbl7t180g+X3j4fRCBd
   5qcZA01p/DKbBgAb73FWkbEVqAv+tgZoIkEMxUCTuXPOpPI0L5AgSS/xR
   Q==;
X-CSE-ConnectionGUID: xvF4AKphQkeUzumnxEr+hw==
X-CSE-MsgGUID: fPBAvLGjQHmpBDcRPwRGwQ==
X-IronPort-AV: E=Sophos;i="6.27,150,1787036400"; 
   d="scan'208";a="75185089"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2026 09:38:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sat, 10 Oct 2026 09:38:28 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sat, 10 Oct 2026 09:38:25 -0700
Date: Sat, 10 Oct 2026 18:38:25 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Steen.Hegelund@microchip.com>,
	<richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robert.marko@sartura.hr>
Subject: Re: [PATCH net-next 3/3] net: sparx5: Add TAS offload support
Message-ID: <20261010163825.uyiuf6v2kgeq6mhe@DEN-DL-M70577>
References: <20261006-sparx5-tas-v1-3-5eef1126dfd5@microchip.com>
 <179164195818.434549.1315955310783302023@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179164195818.434549.1315955310783302023@kernel.org>

> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 3 · Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] If a TAPRIO_CMD_REPLACE fails, the schedule that was already
>   pending in hardware is lost, but taprio still treats it as the current…
> - [Medium] sparx5_tas_enable() computes the TAS base time with
>   sparx5_new_base_time() at line 595.
> - [Medium] sparx5_tas_shutdown_pending() reads LIST_STATE once (line
>   288).
> - [Low] The comment in sparx5_tas_init() says 'There are only 128
>   (sparx5) / 60 (lan969x) TAS lists, not enough for the whole port…
> - [Low] sparx5_tas_list_state_wait() (lines 249-261) and the startup loop
>   in sparx5_tas_enable() (lines 661-673) poll HSCH_TAS_LIST_STATE /…
> 
> --
> 
> net: sparx5: Add TAS offload support
> 
> This commit adds Time Aware Shaper (802.1Qbv) offload for sparx5 and
> lan969x, configured through tc-taprio. Each port uses two hardware TAS
> lists, so a new schedule can be programmed while the other list is
> operating, and GCL entries come from a pool shared by all ports. On
> sparx5, the last port gets no TAS offload when all 65 ports are present.
> 
> > diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tas.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tas.c
> > index 3637d4b48ad67..ec80bc69371ab 100644
> > --- a/drivers/net/ethernet/microchip/sparx5/sparx5_tas.c
> > +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tas.c
> 
> [ ... ]
> 
> > @@ -17,6 +20,753 @@ enum sparx5_tas_link_speed {
> 
> [ ... ]
> 
> > +static int sparx5_tas_list_state_wait(struct sparx5_port *port, int list,
> > +				      int req, u32 done)
> > +{
> > +	struct sparx5 *sparx5 = port->sparx5;
> > +	unsigned long end;
> > +	int state;
> > +
> > +	/* Do not wait forever for the state change */
> > +	end = jiffies + msecs_to_jiffies(TAS_TIMEOUT_MS);
> > +	do {
> > +		if (req >= 0)
> > +			spx5_rmw(HSCH_TAS_LIST_STATE_LIST_STATE_SET(req),
> > +				 HSCH_TAS_LIST_STATE_LIST_STATE,
> > +				 sparx5,
> > +				 HSCH_TAS_LIST_STATE);
> > +
> > +		state = sparx5_tas_list_state_get(sparx5);
> > +		if (BIT(state) & done)
> > +			return 0;
> > +
> > +		cond_resched();
> > +	} while (!time_after(jiffies, end));
> 
> [Severity: Low]
> This loop reads HSCH_TAS_LIST_STATE repeatedly with only cond_resched()
> between reads, for up to TAS_TIMEOUT_MS. It runs with RTNL and
> sparx5->tas_lock held.
> 
> Some of these waits are not short register settles. A TERMINATING list
> runs until the end of its cycle, and cycle_time can be close to 1s.
> sparx5_tas_disable() can chain several waits (pending stop, TERMINATING
> request, ADMIN wait) for each of the two lists.
> 
> Would read_poll_timeout() with a sleep between reads fit better here? The
> same applies to the startup polling loop in sparx5_tas_enable().
> 
> [ ... ]
> 
> > +static int sparx5_tas_shutdown_pending(struct sparx5_port *port)
> > +{
> > +	struct sparx5 *sparx5 = port->sparx5;
> > +	int i, list, state, err;
> > +
> > +	for (i = 0; i < SPX5_TAS_ENTRIES_PER_PORT; i++) {
> > +		list = sparx5_tas_list_index(port, i);
> > +		spx5_rmw(HSCH_TAS_CFG_CTRL_LIST_NUM_SET(list),
> > +			 HSCH_TAS_CFG_CTRL_LIST_NUM,
> > +			 sparx5,
> > +			 HSCH_TAS_CFG_CTRL);
> > +
> > +		state = sparx5_tas_list_state_get(sparx5);
> > +		if (state != SPX5_TAS_STATE_ADVANCING &&
> > +		    state != SPX5_TAS_STATE_PENDING)
> > +			continue;
> > +
> > +		err = sparx5_tas_list_state_wait(port, list,
> > +						 SPX5_TAS_STATE_ADMIN,
> > +						 BIT(SPX5_TAS_STATE_ADMIN));
> 
> [Severity: Medium]
> Can the hardware move this list from PENDING to OPERATING between the
> state read above and the ADMIN request?
> 
> sparx5_tas_list_state_wait() writes LIST_STATE=ADMIN again on every
> iteration and does not check which state the list is in now:
> 
>     if (req >= 0)
>         spx5_rmw(HSCH_TAS_LIST_STATE_LIST_STATE_SET(req), ...);
> 
> If the pending list's base time arrives in that window, the list becomes
> OPERATING and obsoletes the list that was operating before. The next
> iteration would then write ADMIN to the only running list. That stops it
> mid-cycle without going through TERMINATING. If the hardware ignores the
> request instead, the wait times out with -ETIME.
> 
> On the replace path, sparx5_tas_list_find()->sparx5_tas_shutdown_pending()
> is not followed by sparx5_tas_shutdown_operating(). HSCH_TAS_GATE_STATE
> would then keep the gate mask of the stopped entry, possibly with queues
> closed, until the new list starts.
> 
> lan966x_taprio_list_shutdown() reads the state again on each iteration. It
> sends a list that has become OPERATING to TERMINATING and later restores
> all-queues-open. Should sparx5 handle this case the same way?
> 
> The same unconditional rewrite applies to the TERMINATING request in
> sparx5_tas_shutdown_operating(). A list that has already gone
> OPERATING->TERMINATING->ADMIN could then get a TERMINATING request while
> it is in ADMIN.

Speculative. But yes, the hardware gives no atomic way to cancel a PENDING list,
so the state read and the ADMIN write can always race its move to OPERATING.
Have been working the same way downstream for years, havent observed any issues.

> 
> [ ... ]
> 
> > +int sparx5_tas_enable(struct sparx5_port *port,
> > +		      struct tc_taprio_qopt_offload *qopt)
> > +{
> 
> [ ... ]
> 
> > +	sparx5_new_base_time(sparx5, cycle_time, qopt->base_time, &base_time);
> 
> [Severity: Medium]
> Can this base time be stale by the time it is written to hardware?
> 
> sparx5_new_base_time() returns a time only 2-3 cycles of the new schedule
> ahead of the current PHC time. Two slow steps run after it:
> 
>   - sparx5_tas_list_find() can wait up to TAS_TIMEOUT_MS for a pending
>     list to reach ADMIN, or for a TERMINATING list to finish its current
>     cycle (up to the old cycle_time).
>   - sparx5_tas_gcl_setup() programs up to n_tas_gcl entries, each with
>     several indirect register accesses.
> 
> Only after these steps are HSCH_TAS_BASE_TIME_* written and ADVANCING
> requested. For example, a 100us cycle that replaces a 500ms cycle while
> the old list is TERMINATING has a margin of about 200-300us, but the wait
> can last hundreds of milliseconds.
> 
> That breaks the rule in the comment at the top of the file, "base time is
> at least current time + (2 * cycle time)". The likely result is a
> STARTUP_ERROR and -EIO.
> 
> lan966x_taprio_add() computes the base time after list selection and GCL
> programming. Could sparx5_new_base_time() be called just before the base
> time registers are written?
> 

This one is also flagged speculative. In practice it is harmless: a too-close or
past BASE_TIME only makes the hardware skip whole cycles until it can start on a
cycle boundary. Intended.

> > +
> > +	/* Allocate before sparx5_tas_list_find() stops a pending schedule, so
> > +	 * running out of GCL entries fails the replace without touching
> > +	 * hardware.
> > +	 */
> > +	base = sparx5_tas_gcl_alloc(sparx5, qopt->num_entries);
> 
> [ ... ]
> 
> > +	/* Select an appropriate entry to use */
> > +	err = sparx5_tas_list_find(port, &new_list, &obsolete);
> > +	if (err) {
> > +		bitmap_clear(sparx5->tas_gcl_bitmap, base, qopt->num_entries);
> > +		goto out;
> > +	}
> 
> [ ... ]
> 
> > +	if (HSCH_TAS_STARTUP_CFG_STARTUP_ERROR_GET(startup)) {
> > +		netdev_err(port->ndev, "TAS startup error in list %d\n",
> > +			   new_list);
> > +		err = -EIO;
> > +	} else if (state == SPX5_TAS_STATE_ADVANCING) {
> > +		netdev_err(port->ndev, "Timeout starting TAS list %d\n",
> > +			   new_list);
> > +		err = -ETIME;
> > +	}
> > +
> > +	/* taprio sends no DESTROY for a failed offload, so do not leave a
> > +	 * list behind that may still start.
> > +	 */
> > +	if (err)
> > +		sparx5_tas_shutdown_pending(port);
> 
> [Severity: Medium]
> Is the schedule that was already pending lost when the replace fails
> here?
> 
> sparx5_tas_list_find() first calls sparx5_tas_shutdown_pending(). That
> forces any ADVANCING or PENDING list of the port back to ADMIN and frees
> its GCL range. Several failures can happen after that point:
> 
>   - the invalid state combination check in sparx5_tas_list_find()
>     (-EINVAL)
>   - sparx5_tas_wait_admin() timing out on a TERMINATING list
>   - a latched STARTUP_ERROR (-EIO)
>   - the ADVANCING timeout (-ETIME)
> 
> Each of these cleans up only the new list, either with bitmap_clear() or
> with the sparx5_tas_shutdown_pending() call above, and returns the error.
> The old pending schedule is not restored.
> 
> In taprio_change(), the previous schedule B was already promoted when it
> was installed. On an offload error, taprio_change() does goto free_sched
> and keeps B. Take A operating and B pending, then a replace with C that
> fails. Hardware keeps running A, taprio reports B, and B never starts.
> 
> The comment before sparx5_tas_gcl_alloc() covers the case where GCL
> entries run out. The later failures still seem to leave hardware and
> taprio out of sync. Could they be handled as well?
> 

Yes, but only on a hardware failure. Every error a user can trigger, is returned
before any TAS list is touched. I checked other taprio offload drivers and
AFAICT, none restores a previous schedule after a hardware failure. Also, havent
observed this issue.

> [ ... ]
> 
> > +int sparx5_tas_init(struct sparx5 *sparx5)
> > +{
> > +	const struct sparx5_consts *consts = sparx5->data->consts;
> > +	int i, num_ports, list_num_max;
> > +
> > +	/* There are only 128 (sparx5) / 60 (lan969x) TAS lists, not enough
> > +	 * for the whole port range. LIST_NUM_MAX is the highest list index
> > +	 * processed, and the datasheet gives 24 as its minimum value.
> > +	 */
> 
> [Severity: Low]
> This isn't a bug, but is this comment accurate for lan969x?
> 
> lan969x_consts sets n_ports = 30 and n_tas_lists = 60. With
> SPX5_TAS_ENTRIES_PER_PORT lists per port, every lan969x front port gets
> its two lists. Only sparx5 (65 ports, 128 lists) runs short, as the commit
> message says.
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-sparx5-tas-v1-0-5eef1126dfd5%40microchip.com
