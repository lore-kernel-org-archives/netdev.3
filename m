Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762D283FE5;
	Sun, 30 Aug 2026 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788117848; cv=pass; b=Oz/idUiJIjQsDhm026Jv2dXjgAeXjztvAyiERVvIe7JLBoqd+DUSkfusblEDqoJonvq4nWov0cls0mnyRMBKUDxgJOOTBtw3I6/LOqoHVUmJAAyZiqg1a0eJoZNEFuRKSRSasuOCb0OXlDw2n0HfsZbEXKj3V4qZWU2BmkjTbos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788117848; c=relaxed/simple;
	bh=cafKovKonKDC6hVfLDOvclmhUB+Qzsj3q7UYI75hoJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPuFhYCOmeBhT/YmPqpiF6MxTXFQsRaeRBWf6AR19UjOTp5Afbq9HyNQc4jp8C6mdIU6usJ2WoRIHhjXfgII++UdqlRtrzLMotbpcNSm+EvjGu7DdPbMrkLwwyxpETFLGlmMW9YnXZSkqzc4pCoZcWRTElwOVonJiMVwh02JWfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=gL1xu/rp; arc=pass smtp.client-ip=165.173.182.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="gL1xu/rp"
ARC-Seal: i=1; a=rsa-sha256; t=1788117841; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mUG88sgryoz8qQasnhSsEYlJ1KfRKkB/Vy+sUH8+FB+45xqQKJFYotZjDmsYi724riKd530i8jlF0O8wG8PchdgA4Dxlf30H8SctVFpDp8TxJh19YBuQm1E09eoeo4zvKDnUbv1nTStWc4VtxhuGR07Y3YRlWk7Vyj65Np7pn3A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788117841; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x/IuvBM0fyN81m81e/0lHfg1Jm0ctFD8XtKlrDWR4AM=; 
	b=DG7HCSrpM/QlDKgj7r0PNX5Z/xFzpx7EDcdU0w0dlbSBPW5t+AbYJyXXtzu6Jp1COK/s/IM+HtSkyrl2yrhH1luwfPYtv2FAfllYRQoXAsuH+7zbzq9QcSOeEj0xdjewGbtQq5wAI4nnjzv61l2H3uQh2rteay8k0zmFxd7yy6E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788117841;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=x/IuvBM0fyN81m81e/0lHfg1Jm0ctFD8XtKlrDWR4AM=;
	b=gL1xu/rpdMhxh8YGthDKiLap/d+Kti1xhmvwIpQfIYBSQRz5BZSftdmw1vjj0KjN
	loPzfm89kG5OuuGLJxJAipMhvi6G4VOXqSk75+I7/0a84JaOkRWyWzZVJkuWaebmlv+
	CsjN9/tINpWdvNZMlPoSdHq6GGfjXizU6pP0Ui6A=
Received: by mx.zohomail.com with SMTPS id 1788117838159432.42891456736606;
	Sun, 30 Aug 2026 12:23:58 -0700 (PDT)
Date: Sun, 30 Aug 2026 19:23:43 +0000
From: Yao Zi <me@ziyao.cc>
To: Giuseppe Nespolino <g.nespolino@gmail.com>, Yao Zi <me@ziyao.cc>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: dwmac-motorcomm: RX dies after long s2idle, only wrapper
 SYS_RESET recovers
Message-ID: <apSDPwF49Z1Zd0kJ@pie>
References: <CAKx9m6PywVwkirvkAtz144c-yg71c2+OcNYOTM4Bjtd8dF2PaA@mail.gmail.com>
 <CAKx9m6OsGKGKGxPnjwy8U-bDyvXVEK-dVNmvP0ZqSL-t2Exsgg@mail.gmail.com>
 <anziUH_cC1LXoB1x@pie>
 <CAKx9m6OMQKufDpqGJewG1OyvZGBKGimSxxxGRDGWgFicSRoTGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKx9m6OMQKufDpqGJewG1OyvZGBKGimSxxxGRDGWgFicSRoTGQ@mail.gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/288.103.78
X-ZohoMailClient: External

Hi Giuseppe,

Sorry for the late reply.

On Thu, Aug 13, 2026 at 11:12:40AM +0200, Giuseppe Nespolino wrote:
> On Wed, Aug 12, 2026 at 09:14:56PM +0000, Yao Zi wrote:
> > This is quite unexpected. I found enabling OOB_WOL_CTRL blocks DMA
> > interrupts because it's the default state after resetting, without
> > clearing it, the MAC is non-operational.
> 
> That fits what I see, and it explains the asymmetry: the write only takes
> effect in the window right after a reset. On an already-armed engine,
> writing the DIS bit back does nothing, which is exactly what I measured.
> 
> > Have you tested the idea? We always call pci_wake_from_d3(pdev, true) but
> > from your description, broken RX only happens after s2idle is active for
> > some time, right?
> 
> Right, and it's a fair objection; the wake is armed on every suspend, so
> it can't be what distinguishes a 30s cycle from an 18min one. I built and
> loaded that change here but haven't been through a long suspend with it
> yet, so I have no result either way yet.
> 
> > From my own testing, with OOB WOL enabled, both DMA TX and RX interrupts
> > aren't delivered. So TX behavior when RX is broken might indicate what
> > has happened.
> 
> I can't answer that from what I captured: between my two snapshots no
> frames were transmitted (mmc_tx_framecount_gb stayed at 98), so the frozen
> tx-0 vector count proves nothing. Worth noting that TX packets do leave
> the interface while RX is broken, but that is expected even with TX
> interrupts dead, since stmmac cleans the ring from the coalescing hrtimer.
> 
> I've instrumented for it. Next occurrence I'll force TX traffic and report
> the tx-0 vector delta.
> 
> > Anyway, please try figuring out state of the DIS bit when the problem
> > occurs before sending the patch, which would be a strong reason to
> > perform a reset in the resume hook.
> 
> Already captured, from the last natural occurrence (s2idle 14:43 -> 15:01,
> 18 minutes, on AC):
> 
>   OOB_WOL_CTRL (BAR0+0x1010) while broken:  0x00000001
>   OOB_WOL_CTRL healthy baseline:            0x00000001
> 
> Identical, and motorcomm_init() had already run at resume and written that
> same value. So there is no software-visible state left to correct: the
> register claims DIS is set while interrupts are not being delivered, and
> nothing short of the reset recovers it.

Sorry for not making me clear. I mean the state of OOB_WOL_CTRL right
before motorcomm_resume() sets it would help, which would prove whether
it's the case that some firmware or internal hardware logic
automatically arms OOL WOL after suspend.

> I'll send the reset-in-resume patch. One design question bef
> you want motorcomm_reset() followed by the eFuse settle delay and
> motorcomm_init(), i.e. the probe sequence minus the MAC addr
> would you rather keep resume lighter than that?

I'll prefer the former. Please fold the call to usleep_range() into
motorcomm_reset(), too, which fits in the semantics of
motorcomm_reset(), so your fix is simpler.

> One disclosure, per Documentation/process/generated-content.rst: this
> investigation was done with an AI coding assistant. It drove the
> register-level diagnosis and the experiment design; the measurements are
> all from this machine and I ran and verified them myself.
> 
> Thanks,
> Giuseppe

Regards,
Yao Zi
