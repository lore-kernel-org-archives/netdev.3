Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0F44BCBE
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791857371; cv=none; b=fe1wwYuKy3BAm0tjg+RzKE8n+E/bPf1Cil6SW6g+iX8VlQ8HNLbB6ZRwotDK3N1dzES50MJicvu81lNf83Qd/qlPrUCUeXovfCaVXGFJMPO+niM1zSqRgSzZvAI4xWdQBMnCQlcQV5lYN5LQZPDr11Kvel105v35SBYQW90DLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791857371; c=relaxed/simple;
	bh=IRWt4VDPiyUkbB43dYlWSBojmDaohCHTINhsRG/H+EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB4Zx/3UUh/FCt/DZJ3G9ojOvb26tIVYGhbr45VeETj+MSyo3F3DdBhoB29gRWV9yPCw0/5uH38wAIl+OwhjZAtuyMK/UqD25HQIxnTpVavxH+rJnEGsRmuVVFU+gPRW+0RbjszOUU27iSLCEXixH5OFmXGPt6USHg37oXSwHKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=mftG+3yO; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="mftG+3yO"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917a9f42283so29475836d6.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 19:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1791857369; x=1792462169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RsCbY8Ip5NFwQBaKeE02VHsTQ9AsJiBilAhhemXl7vU=;
        b=mftG+3yO8z6fMtTp9JbqbRIbK3TuYZP6LL970+gZKBMk5Bx/iAp04UlMxS8MukubMC
         WLDOhiudoLqIBHMuL0rlpqKlne41xzmxsVcSDl0ShnJyC++sIOeXFdZAWhbShkCsuqR0
         SNDPvP9oXnKSNPwsVJcqLUabS3HTAMfBHcZGqqXlfbZKYD0UPAg3YBlpQ+2kJuuW8296
         lrIfPtYP1ddCFd3lDNa90gOr5FLluOpH8nb8DIESNKAq+k4nvjgJHVto5LihF0GPP2yr
         2mgTxoZO0m2DKieNRoc+YCDj/OlW6Iypgan0Kh49kKqt6Fu2Ojz+M7WecB7YghSBzWa7
         OOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791857369; x=1792462169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RsCbY8Ip5NFwQBaKeE02VHsTQ9AsJiBilAhhemXl7vU=;
        b=doFGHIEWPfHwEu5anZ2OsY+D5cyRmGcwKAOrf+kw4dnRtmBiUCcAoG/Lb9YVWec+bb
         uPaeILYiuyV9/wODl+eIvxYmk/dHoSYJyLB2Inp4ppNvbbGoEI41EaV0/XSOZHIe7RBS
         q2sj5BtyHBTykEnU7lUcTMr3rCmSHTTghFHM7IafkrCGx96+6XtzY7JMBXOYGyVTzcpp
         fzNazd6CX+yLUrcAdh6cz1bVs5OkurulDj1zcxCmmviFeqJEbQ8FmqqWtdIRLkHJ8l/t
         0qh+Kh+9vP+DVxRMC87Kl+rrToOS8YsTdXqcfIea8Ji1yoxdLOlDa5VZzYNCfivu0zcY
         EPyg==
X-Forwarded-Encrypted: i=1; AKwUvBxawIjwT5pHuOay16/j52Rxg+vJro94libuxgybPwnFaGt6KYXxGA1C4gXGVYjH6q3Logzs7c4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGuPDoU5UhQrbtZDGxdhjzKC+EDgCcWE6ZhMVbR8pXX2LczIjv
	AX3GARp8dWbsMCaVpkf6qYMcbqJGTcetavGs2nBo69IVXKyb08Iho6whIUScT9NlVA==
X-Gm-Gg: AYBFou0EhrtgKo56q9JfV31zrVQiyy9ttImIXPLR47hnF7Klk1N+4Gktzj6NFu9+q98
	kikjADEA7Bn1+js+2dQ1vrxyRwxf0iqOSSJi5y0hJg48/SxvJMk5jRv5jS2gyDu8BJb1PlO+FBL
	m7DkEuXIzM4eZ1EJc9PT9L2jxr5Gebb1Inhmhq9jytAudK1FWDZaomfJXTYMqVBJbvu6nUNzTxT
	9orHaAsxmB4MnmaPbIAhvITydD0rp+kWibDMPNIpx7Ej/zWod1Kb7+/vHfR7ycAk/0bmlUC9yY4
	0JS3AJP9jgvYZy9p+xzZ0E6VOlX5LO8yI4T4WIl84kQQNQBV0+seF3T5mmx4iLQFRQ/9v3erSMw
	KWOoP/tN2Pp9Vj+CMi1i6pV4EQoxPQHe0RDUe+qowNINIxqIG7Qlgmx2/AY2iGQcnxSIgktm7qQ
	5Hwz9IbGPLSoLsMM+x8u5G12NaxRq8g88A7kcM/VT+Zjwun6i/xMhcT/aisCBTrFVu6lOKViU=
X-Received: by 2002:a05:620a:6e86:10b0:93e:c12c:4412 with SMTP id af79cd13be357-93ec12c49fdmr1181926485a.78.1791857369089;
        Mon, 12 Oct 2026 19:09:29 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::4791])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef50295a7sm131650285a.23.2026.10.12.19.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 19:09:28 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:09:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	=?iso-8859-1?Q?=D6mer?= Mete Kaya <omermetekaya0@gmail.com>,
	oneukum@suse.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in preemptible
 context
Message-ID: <41af30de-4725-4913-9ad8-54d1dea2d4b8@rowland.harvard.edu>
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
 <20261007200049.079aeb75@kernel.org>
 <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
 <20261008094338.301a75fa@kernel.org>
 <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
 <2026100910-petition-embattled-94cb@gregkh>
 <20261012194902.aEq58Q6b@linutronix.de>
 <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>
 <20261012212527.5sFqlGYu@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261012212527.5sFqlGYu@linutronix.de>

On Mon, Oct 12, 2026 at 11:25:27PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-10-12 16:26:28 [-0400], Alan Stern wrote:
> > On Mon, Oct 12, 2026 at 09:49:02PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2026-10-09 13:31:17 [+0200], Greg Kroah-Hartman wrote:
> > > > > As far as I am aware, there aren't really any guarantees on the 
> > > > > context of a USB URB-completion callback.  The kerneldoc for struct urb 
> > > > > in include/linux/usb.h says "The completion callback is made 
> > > > > in_interrupt()", but that is most definitely out of date.
> > > > 
> > > > I don't think so, I think some platforms still have those callbacks in
> > > > irq context, unless we changed to threaded irq handlers everywhere?  I
> > > > could have missed that, but we should still write the callbacks to
> > > > assume that and then we should be fine even if we aren't in irq context,
> > > > right?
> > > 
> > > The HCD invokes the completion callback usually in IRQ context. I think
> > > the VHCI is an exception here.
> > > For the forced-threaded mode we disable BH before the IRQ handler is
> > > invoked. I think even dummy_hcd invokes them from the timer if my memory
> > > is right.
> > > 
> > > > > Drivers shouldn't rely on any particular context guarantees.  Not even 
> > > > > whether local irqs are enabled/disabled.
> > > > 
> > > > Agreed.
> > > 
> > > I would suggest to make VHCI invoke the completion callback with BH
> > > disabled. usbnet's tx_complete() does also defer_bh() which schedules a
> > > BH worker via queue_work(). While this works without disabling BH it
> > > leads to waking ksoftirqd and an additional context switch which we
> > > could avoid by dealing with it directly.
> > 
> > Today you fix VHCI, tomorrow some other virtual HCD will cause problems.
> 
> We don't have other virtual HCDs, do we?

Well, we've got dummy-hcd.  And just recently there was an RFC post with 
a virtio USB HCD implementation.  It wouldn't be surprising to encounter 
other ones.

Also, don't forget, URBs can complete in several different ways.  
There's normal completion, explicit unlinking, unlinking because the 
device was unplugged, unlinking because the device or HC is going into 
suspend, and so on.  And there's a difference between URBs sent to 
root hubs as opposed to devices actually on the bus.  Not to mention 
that in some cases completions may occur synchronously with submission 
or unlinking, even though they usually are asynchronous.

> The other driver is drivers/net/mctp/mctp-usb.c.
> mctp_usb_out_complete() -> … -> mctp_usblib_tx_stats_update() does
> get_cpu_ptr() for stats. But mctp_usb_in_complete() has 
> mctp_usblib_rx_complete() -> mctp_usblib_rx_stats_single_drop() and
> mctp_usblib_rx() which do just this_cpu_ptr(). Plus the queue wakes &
> netif_rx() which wake ksoftirqd.
> 
> That makes two drivers from a quick grep. But I guess it is just
> networking for the per-CPU stats.
> 
> > Should we document any requirements that all HCDs will have to follow 
> > and that all completion handlers can rely on?
> 
> It used to complete in IRQ context. Then you added the possibility to
> complete BH for those HCDs marked as such (except for the RH). I think
> it was always reasonable to assume that it is either IRQ-context
> (force-threaded or not for !HCD_BH) or BH (for HCD_BH). It makes hardly
> a difference, BH is always off and networking uses to rely on it.
> So yes, documenting would make sense.
> 
> Do you want to document it yourself and have me do the VHCI bits?

At the moment, the only thing I think we can actually guarantee is that 
completion handlers will be called with local interrupts disabled.  No 
commitments about process context vs. interrupt context vs. BH context 
or anything else.

Of course, in special cases you might know more about how a particular 
HCD works.  But except for platform-specific settings, it's hard to be 
certain that your driver will always be used with that one particular 
HCD.

If this is okay with you, I can write a documentation patch.

Alan Stern
