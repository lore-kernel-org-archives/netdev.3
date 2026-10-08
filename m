Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD56742CAE0
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464793; cv=none; b=gYp7I97D1z1Vnalqc0qxdVfKh1ARkRfytarhboG6XEZXDc6GPAWwgQxrssbGt3U10Hb7nZCWlkMjKiRHiRZM2ccmT6fDmxOa8OiwPxFShVTuEPcFyF0hLqD10f4zg+sIKgET5k893TYfc5p+rf/JPiSD84q0qp1N76NSRYDu7qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464793; c=relaxed/simple;
	bh=6vnqhokiX7SO6XZTDcZeDTQHJyqOMymIGErnnmGNf7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NeBKjswHJhgUdJ5IO/l5p2D1mrRMlAAJLLMg8SVvB3/yN38h+emE8cYWjlr+IEVGZvj0Ddxr8NH/L0pvoGwH6v3qa4Gw8SW+aAncfg1Pu05TNNRnpsMsKUzlqrcYpDYZ2PpOXjRChuPLDRF/Wnz54hJd9uSjJzUkUsHfmR3d5SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBn/9/Jo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mrrs4aQz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBn/9/Jo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mrrs4aQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791464790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+pGjxpL7uAkgFiqKzQQYXYL0BDTLUxKJhue4B/dehM=;
	b=UBn/9/JoCOzGsJbxByl3wUEH2TzcIIZd1sRkoJH0iGxJSP6gAagL09fGdGpZ1g56Kn8Lvu
	hxk/rNoPwDDMEMY+BFq+4rSTrKOY594vgCnf9n5dzuU/k1TgkifwtOzUhxwxcqIUkdv5h5
	CfwhdMc5l5ip+a/u/r2kCGHmhyGxU3g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-tC7jT6V6NIe_WhWydTzo3Q-1; Thu, 8 Oct 2026 13:06:29 +0000
X-MC-Unique: tC7jT6V6NIe_WhWydTzo3Q-1
X-Mimecast-MFC-AGG-ID: tC7jT6V6NIe_WhWydTzo3Q_1791464788
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c437ae7dbso619647f8f.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791464788; x=1792069588; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W+pGjxpL7uAkgFiqKzQQYXYL0BDTLUxKJhue4B/dehM=;
        b=mrrs4aQzOnWNLKxzji1uFgntWAIQh3rfzXtUsfF0EiZ+ZttSDNYzNzcykBJTzm0PtW
         9C/+QiejQPd1TwUgUkr/YyUg4Z/+E2pC8WnEZFhRu4CyLlm9jPmavFG61oyGSukRMsok
         lB5C/orULmnQpSMACcdUXFNHS+cZaNvOjBVu6v4Qe+g8tXO8pv3r/L8izTqEhjrz3af7
         D2IQQp2eF85VZ29ekzL55rEoxy/ArbvQYNTFcz61B12UlA9Dk89/Yp79b8TG5fG4z7no
         0AsuALEInmfx24BFzo+ATQZPCWgNWCgXIr45N8o6jXRAl1KX7QI+Js2VryhcuwFn4Qn0
         o60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791464788; x=1792069588;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W+pGjxpL7uAkgFiqKzQQYXYL0BDTLUxKJhue4B/dehM=;
        b=Ya4ky9FwMimwO63EHnZ11crgrwdJdg81B6Qw4C/XyfKW/r6p5qTHcdobw0NLCMa/Kw
         Lc4LWgZnBgTRwsUH/iXjP8N99ynP2hUeYjSrnq5hFmO8Yr+8ZPQblLw9wo7Hcamg/jgr
         9VNdyvWLTAvYqy7u0CuTxjDO/Yge1f11y7iiT66gDTmK/ZrxEiuXANdMZ6P5L9v+KQT8
         IFtoRx3c21g+3O3xGjiMdrZ+RdaUCFyHVxEQImt3Hkk6s5fng8jNY6d/JiqSD9yvQPxU
         LtvbldM+6tx335QkcKjuvKFqvtMhr+x/gu3JKlskDB4j8citsF8S6OOz9a+taBdnU3ge
         EvOw==
X-Forwarded-Encrypted: i=1; AKwUvBxQbm4u7GZbcoKzrz5QD/20sY0DftXuJBZ6aYpv7/0zpa8Vy2TqXbrRtQbzzWHsOa9C/YFnWZ8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJpxXg/wR9C4kFu/cD4jG9p1LwVnF8cNoP9msCHwyti18U2qWI
	5P1RkyGBGFw1GJujdo1LkwaEOBcmurirPIs7rNK8S0Dykn5bpK+bpKXR2JJDrNLgICbZxcFpxUs
	VbvZIgcs4KWtjqn7hO+9KaTWIQRh/6tFwYn44U24tz0T0ybY+whmXKaW2jA==
X-Gm-Gg: AYBFou2vLrcZej2U5Ev7e3HmmEYK6M6u4fxeJQaVcFfe79P1fk68VZmKdh/0Kyu3lLO
	yKF5lH3PLIPBFJ7dPFhXpwlTNUkMmHgpTDUdzv06610LGAneJolMQ9CTULM/f8Z6rMVGXgvmmvI
	XTKtBx0RPNmLX5euOsvs/4htc+cjd7bilDWvjMu24W9EH7uC3ZsBPpwOsmyOIj564KntdOtzUEm
	ukzR72RqLiheib9qDBHvgyNlkEGlu97PV7dsBxx/epteEkpjPutjpZXtdgEpgwx23ArkdOSx8es
	bFpLZjtZrWDwC8fBy2ef9SHwlUMH3H07TxJzet/aPdEryHFOv1LN4qS2FSAxpapyfTpogC618iP
	ARhn2uwXYR96APmeFTHVo7I1CIfmwaPu0
X-Received: by 2002:a05:6000:18a8:b0:488:7927:9cae with SMTP id ffacd0b85a97d-48c7ee93686mr4981645f8f.9.1791464788155;
        Thu, 08 Oct 2026 06:06:28 -0700 (PDT)
X-Received: by 2002:a05:6000:18a8:b0:488:7927:9cae with SMTP id ffacd0b85a97d-48c7ee93686mr4981561f8f.9.1791464787338;
        Thu, 08 Oct 2026 06:06:27 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71c0b65fsm10853885f8f.16.2026.10.08.06.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:06:26 -0700 (PDT)
Date: Thu, 8 Oct 2026 16:06:09 +0300
From: Mohammad Heib <mheib@redhat.com>
To: netdev-bot+sashiko@kernel.org
Cc: anthony.l.nguyen@intel.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, przemyslaw.kitszel@intel.com, jiri@resnulli.us, horms@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	linux-doc@vger.kernel.org, sx.rinitha@intel.com
Subject: Re: [PATCH net-next 3/3] i40e: trigger PF reset when re-enabling ATR
 via ethtool
Message-ID: <aseUUk5ypWQKx5Yv@mheib-thinkpadp16vgen1.rmtil.csb>
References: <20260917204541.3072415-4-anthony.l.nguyen@intel.com>
 <179002634332.2160803.9163338355195427947@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179002634332.2160803.9163338355195427947@kernel.org>

On Mon, Sep 21, 2026 at 09:32:23PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 4 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The reset request the patch adds is stored in the shared scalar
>   `reset_needed`, which a later, unrelated error path zeroes — so the…
> - [Medium] The failure mode this commit fixes was introduced two commits
>   earlier in the same series by 6f0c883685a0 ("i40e: move ATR sample…
> - [Medium] i40e_set_priv_flags() now requests a full PF reset on every
>   0->1 transition of the flow-director-atr private flag, with no check…
> - [Medium] The new ATR block assigns `reset_needed` with `=` instead of
>   combining with the existing request, silently downgrading the stronger…
> - [Medium] i40e_atr()'s gate on I40E_FLAG_FD_ATR_ENA is published to the
>   lockless Tx fast path before the hardware context is updated, so the…
> 
> --
> 
> i40e: trigger PF reset when re-enabling ATR via ethtool
> 
> This adds a PF reset request in i40e_set_priv_flags() whenever the
> flow-director-atr private flag transitions from off to on, so that
> tx_ctx.fd_ena is recomputed in i40e_configure_tx_ring(). A few questions
> about the new reset request and how it interacts with the rest of
> i40e_set_priv_flags() are below.
> 
> First, a question about the commit message itself:
> 
> >     Toggling flow-director-atr via ethtool private flags does not trigger a
> >     ring reset. If ATR was disabled while fd_ena was cleared in the TX queue
> >     HW context (e.g. after a ring reset with both ATR and ntuple off),
> >     re-enabling ATR causes i40e_atr() to inject FDIR descriptors into a
> >     queue where fd_ena is still 0.
> 
> [Severity: Medium]
> Is this describing a long-standing defect, or one introduced two commits
> earlier in this same series by 6f0c883685a0 ("i40e: move ATR sample rate
> from ring to PF level")?
> 
> Before that commit, i40e_configure_tx_ring() cleared the per-ring sample
> rate in exactly the scenario described here:
> 
> 	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags))
> 		ring->atr_sample_rate = vsi->back->atr_sample_rate;
> 	else
> 		ring->atr_sample_rate = 0;
> 
> and i40e_atr() returned early on it:
> 
> 	if (!tx_ring->atr_sample_rate)
> 		return;
> 
> So a ring configured with both ATR and ntuple off had fd_ena == 0 and
> atr_sample_rate == 0, and re-enabling the private flag could not reach the
> descriptor-writing code. 6f0c883685a0 removed that gate in favour of
> pf->atr_sample_rate, which i40e_sw_init() initialises once to
> I40E_DEFAULT_ATR_SAMPLE_RATE and is therefore never zero.
> 
> If that reading is right, the tree is broken at 6f0c883685a0 and
> 41347643da7b and repaired only here, which makes a bisect land in a window
> with the described misprogramming. Would it be better to keep the gate (or
> program fd_ena unconditionally) in the patch that removes it, and to add a
> Fixes: tag here so stable backporters do not pick up a disruptive PF reset
> for kernels that never had the regression?
> 

Addressed in v5 by folding this patch into patch 1. The series is now
bisect-clean.
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > index ef9d1e78c16a2..79c2cdab0f516 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > @@ -5301,6 +5301,13 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
> >  	    test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, changed_flags))
> >  		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
> >  
> > +	/* Re-enabling ATR requires a reset to update fd_ena in the
> > +	 * TX queue HW context.
> > +	 */
> > +	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
> > +	    test_bit(I40E_FLAG_FD_ATR_ENA, new_flags))
> > +		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
> > +
> 
> [Severity: Medium]
> Can this assignment discard the stronger reset type requested a few lines
> above in the same function?
> 
> i40e_set_priv_flags() has already run:
> 
> 	if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags))
> 		reset_needed = I40E_PF_RESET_AND_REBUILD_FLAG;
> 
> and the new block overwrites reset_needed with BIT(__I40E_PF_RESET_REQUESTED)
> using plain assignment, so a single ethtool write that changes
> disable-fw-lldp and flow-director-atr together ends up with the weaker
> selector.
> 

This follows the existing pattern in i40e_set_priv_flags() -- the
VEB_STATS, LEGACY_RX and SOURCE_PRUNING blocks all use plain assignment
as well. Changing only the ATR block to |= would not help because
i40e_do_reset() checks I40E_PF_RESET_FLAG before
I40E_PF_RESET_AND_REBUILD_FLAG in an else-if chain, so the weaker reset
wins regardless of whether both bits are set. Reworking the reset
selection logic is a pre-existing issue outside the scope of this series.

> i40e_do_reset() then tests the two in an else-if chain, with the PF reset
> branch first:
> 
> 	} else if (reset_flags & I40E_PF_RESET_FLAG) {
> 		i40e_handle_reset_warning(pf, lock_acquired);
> 
> 	} else if (reset_flags & I40E_PF_RESET_AND_REBUILD_FLAG) {
> 		i40e_prep_for_reset(pf);
> 		i40e_reset_and_rebuild(pf, true, lock_acquired);
> 
> so reinit is false and i40e_setup_pf_switch() skips the main VSI
> re-initialisation that the FW LLDP change asked for:
> 
> 	else if (reinit)
> 		main_vsi = i40e_vsi_reinit_setup(main_vsi);
> 
> The "FW LLDP is enabled/disabled" dev_info() in the rebuild branch is lost
> as well. Note that changing = to |= would not be sufficient here, since
> i40e_do_reset() prefers I40E_PF_RESET_FLAG over
> I40E_PF_RESET_AND_REBUILD_FLAG; does the selection logic need reworking so
> the stronger request wins?
> 
> [Severity: High]
> Can the reset this patch depends on be dropped later in the same call while
> the ATR flag is still committed?
> 
> Further down in i40e_set_priv_flags(), the FW LLDP re-enable path clears
> reset_needed on a non-fatal admin queue status:

Fixed in v5. The LLDP EEXIST path now uses
reset_needed &= ~I40E_PF_RESET_AND_REBUILD_FLAG instead of
reset_needed = 0, so it only cancels the LLDP rebuild without dropping
unrelated reset requests.

> 
> 	status = i40e_aq_start_lldp(&pf->hw, false, NULL);
> 	if (status) {
> 		adq_err = pf->hw.aq.asq_last_status;
> 		switch (adq_err) {
> 		case LIBIE_AQ_RC_EEXIST:
> 			dev_warn(&pf->pdev->dev,
> 				 "FW LLDP agent is already running\n");
> 			reset_needed = 0;
> 			break;
> 
> and the flag publication is unconditional while the reset is not:
> 
> 	bitmap_copy(pf->flags, new_flags, I40E_PF_FLAGS_NBITS);
> 
> 	if (reset_needed)
> 		i40e_do_reset(pf, reset_needed, true);
> 
> Since tx_ctx.fd_ena is only recomputed when the Tx queue context is
> rewritten:
> 
> i40e_configure_tx_ring()
> 	if (test_bit(I40E_FLAG_FD_SB_ENA, vsi->back->flags) ||
> 	    test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags))
> 		tx_ctx.fd_ena = 1;
> 
> does this leave I40E_FLAG_FD_ATR_ENA set in pf->flags with fd_ena still 0,
> which is the state the commit message says it is closing? The private-flags
> ioctl carries the whole bitmap, so disable-fw-lldp off and
> flow-director-atr on can be changed in one command while the FW agent is
> already running.
> 
> [Severity: Medium]
> Is there a window between publishing the flag and quiescing Tx where
> i40e_atr() can still post descriptors to a ring with fd_ena == 0?
> 
> The flag becomes visible to the lockless Tx path at bitmap_copy(pf->flags,
> new_flags, ...), and only the subsequent i40e_do_reset() reaches
> i40e_prep_for_reset() -> i40e_pf_quiesce_all_vsi(). Meanwhile i40e_atr(),
> called from i40e_xmit_frame_ring() in softirq context on another CPU, gates
> only on software state:
> 
> 	/* make sure ATR is enabled */
> 	if (!test_bit(I40E_FLAG_FD_ATR_ENA, pf->flags))
> 		return;
> 
> 	if (test_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state))
> 		return;
> 
> 	sample_rate = READ_ONCE(pf->atr_sample_rate);

This is inherent to the function's design -- bitmap_copy() followed by
i40e_do_reset() is the same pattern used by every other flag change in
i40e_set_priv_flags(). The window is a few instructions wide and matches
the existing code. Addressing it would require restructuring the
function's flag-commit-then-reset model, which is outside the scope of
this series.
> 	if (!sample_rate)
> 		return;
> 
> __I40E_FD_ATR_AUTO_DISABLED does not appear to cover the window either, as
> it is cleared asynchronously in i40e_fdir_flush_and_replay():
> 
> 		if (!disable_atr && !pf->fd_tcp4_filter_cnt)
> 			clear_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
> 
> as well as in i40e_reenable_fdir_atr() and i40e_set_ntuple(). Would keeping
> ATR suppressed until after the rebuild (for example holding
> __I40E_FD_ATR_AUTO_DISABLED across the re-enable and clearing it once the Tx
> context has been reprogrammed, or publishing the flag after the reset) close
> this ordering gap?
> 
> [Severity: Medium]
> Should the reset be conditional on the HW context actually being stale?
> 
> i40e_configure_tx_ring() sets tx_ctx.fd_ena = 1 when either
> I40E_FLAG_FD_SB_ENA or I40E_FLAG_FD_ATR_ENA is set, so on a system with
> ntuple/side-band filtering enabled, fd_ena is already 1 and nothing needs to
> change. With this patch, the sequence
> 
> 	ethtool --set-priv-flags ethX flow-director-atr off
> 	ethtool --set-priv-flags ethX flow-director-atr on
> 

Fixed in v5. The reset is now skipped when I40E_FLAG_FD_SB_ENA is set,
since i40e_configure_tx_ring() sets fd_ena when either FD flag is active.

> always runs i40e_do_reset(pf, BIT(__I40E_PF_RESET_REQUESTED), true) ->
> i40e_handle_reset_warning() -> i40e_prep_for_reset(), which quiesces all
> VSIs, calls i40e_vc_notify_reset() for VFs and shuts down the admin queue
> and HMC, turning a previously non-disruptive flag write into a traffic stop,
> link flap and VF reset.
> 
> Could the condition also test that FD_SB is off (so fd_ena can really be 0),
> or alternatively could i40e_configure_tx_ring() program fd_ena from the FD
> capability rather than the current flag state so no reset is needed at all?
> The commit message says a reset is triggered but does not mention that it
> happens unconditionally, including when fd_ena cannot be stale.
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204541.3072415-1-anthony.l.nguyen%40intel.com

