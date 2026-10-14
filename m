Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2553EEAC1
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005778; cv=none; b=BGFZBwGdv8uff8RLDdrE5MEw8VLZIPyBVWBR71UsjKwMtpE8uU4FpaRpmH4iFeShWoUE0Q1osdzTIOcj8NU+Tfj2ZCcCuikETChzaYuuyJOCURusvtdV2FAGPlKLp6s1Zayls39pFmYULGSEsjg8j2Q/5IvluG9QszzYyHATONg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005778; c=relaxed/simple;
	bh=k6hKy/iiYeC/tEylC9tyq/YIA9SjKP5IbxcHCVu/FJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EADKWJQwYJl/xbAb2uCLvKor18Y7kTKLqlKeoBcfW6ZxXwmqEGa8gBbnXvWB8EZGZ7Vwvtg6Z5eonY2+XEPV3P7icw+9pbEGydj1xKAfzxe9Il3q7i9w7lkLcJsE/r4Ib3BHtR2vRA3SltRYDIXjHh2xquZ6+GLLxlEn+QB9fC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Z7hotjxh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Z7hotjxh"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53397554beaso7906431cf.3
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1792005775; x=1792610575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MGLMFg8/OHrH6F2KqpVf23oCqRTqDJ+Uyk4rdMujuIo=;
        b=Z7hotjxhBazBD4FeCixATp5dqFbxOh2t6H/zXUpcvgYayXw7gTPBAc+y22Pyf936r5
         C54lUeOppLhraWJcVfzgWiPXeiGBg1Qv7FNwG9s3rl6UsegSAjxwzUvrvXd5Pk0/19JS
         +tH+F6DBPbkcBVFOC5oLSTOslUxFOlq9y3gGkp7OG7FRr4J+tJ1ExbIMF/PqP2kmWOg1
         pL/48tFt+6p18OReIxVJ0SLw3AxLqqBjd3eJH1NKs1qGFoGzcdvcX4Vt0idK0EOR9aL+
         0F04DEJl8bAeVvpjzvrCrNXDZ3lDYPJKug69vh7fs7vwm1/j+orbd27uEttTOsY9CM62
         Gs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005775; x=1792610575;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MGLMFg8/OHrH6F2KqpVf23oCqRTqDJ+Uyk4rdMujuIo=;
        b=g2aOqqcp2KDTVm9MMdw5pYGATemMKkfU4HBQnGG4pAMIigc16tOmU1gYUAM3/x9pOO
         VkfJ/IOp/m+o5AOUBh4ya5amRbMj4s5IJBdNqK1O/PP7d1X1k3WXOoRk9rfboyemp71l
         OLNd6GSYI+S0Z90pwfTYzE5l6EDqd5lzjBFrlf64Ni3IVnVOSPu3sAlB/X6+REFor2n4
         +phj2DO/Y1B177jn9Uiuv3V0io1HDgs/o76MSdHeSVLskQWjoXPlUnkM9oQwFLBMwhnd
         wMPrg1M0zv2Q3CgqiM9R0nUjW/hy84Ppo/JIDvclSaf+9qS8HUA0EZEJXeoBes8+73o1
         uaMA==
X-Forwarded-Encrypted: i=1; AKwUvBwHXfpd3xgL7v8qVZA5O4bsiiBx+sAYv46g5euXtTJFv0yVbxBnZ28moVENLR7Y5crZaycZ5aw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK4sTpu6pYE4ZN7HYY4P9esFioNzwHLG0AnP7xf1lbYa/zTLPZn
	Nt8FVC4bQ/N83VI9/D54diEZkBwX2ccVldqJHQC4Zhqc6s+9eow+flH2VRJBdRwaOQ==
X-Gm-Gg: AYBFou2isb58Jk/ZAYOAip2CXpQDXcc9ZxHSb6AaFQZ4KsGRviMQlYFg5xoVVzHSr62
	VwNElx0Di+binlLEkXDYbBgP99v7ggAqvM7tKBUM/p2Aw+q/v7yR5QaHHoJMz+mY9X8ZNp48+NM
	WHgR8XKTgtaaNJUyQsym2jV9MFTbz4J/gLkf5pp9NBmKzQ6TP1R1Z3nuyqnOYg6yNnZExQ7PDxc
	Wadq4ESv3VPG04rnoHQ4TTGJ6PF5AUjN4VYcBsg/TM9bIIfkpPXQYiTr+BNGiAThpRear8pS1Zj
	noz7WKifEX/c9a47Q1UMu3qexrt3OhXIXKp532qFigEina4pVsxNq8dZVojDpMjBAJPgZJO+R+3
	DgcuS1nfOk0R2GJWXS1YaE+1yZaoE6HkE9j2cBOyjqIvSqP6o/tBCAlrhV0d0dILeB4XZyyYXr1
	B5BfGe7KPDv5sPNmsIcHz36ZdmmflZfRRdAnvwTgfXV72QD8iJrFvU7vCI8JoOxh0n9n3jaf1C8
	5tgxl5PPnP1i9NBaRe6tiIaJxu6vnLvBeXgFbrHOQ==
X-Received: by 2002:ac8:5f0c:0:b0:533:3d83:c20c with SMTP id d75a77b69052e-5359fae8d7dmr290066141cf.23.1792005775330;
        Wed, 14 Oct 2026 12:22:55 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5361284b1e4sm4745731cf.31.2026.10.14.12.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 12:22:54 -0700 (PDT)
Date: Wed, 14 Oct 2026 15:22:51 -0400
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
Message-ID: <89da3b1f-60e5-4f18-9592-3d6d7175c437@rowland.harvard.edu>
References: <20261007200049.079aeb75@kernel.org>
 <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
 <20261008094338.301a75fa@kernel.org>
 <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
 <2026100910-petition-embattled-94cb@gregkh>
 <20261012194902.aEq58Q6b@linutronix.de>
 <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>
 <20261012212527.5sFqlGYu@linutronix.de>
 <41af30de-4725-4913-9ad8-54d1dea2d4b8@rowland.harvard.edu>
 <20261014191141.GxlJhR1e@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014191141.GxlJhR1e@linutronix.de>

On Wed, Oct 14, 2026 at 09:11:41PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-10-12 22:09:25 [-0400], Alan Stern wrote:
> > > > Today you fix VHCI, tomorrow some other virtual HCD will cause problems.
> > > 
> > > We don't have other virtual HCDs, do we?
> > 
> > Well, we've got dummy-hcd.  And just recently there was an RFC post with 
> > a virtio USB HCD implementation.  It wouldn't be surprising to encounter 
> > other ones.
> 
> dummy-hcd is timer driven (so BH). Without looking at virtio I would
> expect it to be interrupt driven.
> 
> > Also, don't forget, URBs can complete in several different ways.  
> > There's normal completion, explicit unlinking, unlinking because the 
> > device was unplugged, unlinking because the device or HC is going into 
> > suspend, and so on.  And there's a difference between URBs sent to 
> > root hubs as opposed to devices actually on the bus.  Not to mention 
> > that in some cases completions may occur synchronously with submission 
> > or unlinking, even though they usually are asynchronous.
> 
> True.
> 
> > > Do you want to document it yourself and have me do the VHCI bits?
> > 
> > At the moment, the only thing I think we can actually guarantee is that 
> > completion handlers will be called with local interrupts disabled.  No 
> > commitments about process context vs. interrupt context vs. BH context 
> > or anything else.
> 
> "local interrupts disabled" as is local_irq_disable()? If so, that is
> not the case. If it completes in BH context (due to HCD_BH) then
> interrupts remain enabled.

Yes, but we can call local_irq_disable() before invoking the completion 
handler -- if we decide that would be a good thing to do.

Otherwise I would say that we don't guarantee anything.

> > Of course, in special cases you might know more about how a particular 
> > HCD works.  But except for platform-specific settings, it's hard to be 
> > certain that your driver will always be used with that one particular 
> > HCD.
> > 
> > If this is okay with you, I can write a documentation patch.
> 
> Sure. The kernel doc for usb_hcd_giveback_urb() says BH or caller's
> context. I think you need to clarify that part and once we have tha, we
> can proceed with the drivers.

What do you think?  Should local interrupts always be disabled, or 
should we offer no guarantee?

Completion handler routines will have to be conservative, so if we don't 
guarantee anything then they will need to disable interrupts themselves 
whenever they require it (for example, by using spin_lock_irqsave() 
instead of spin_lock()).  The core could save them this extra effort, at 
the cost of unnecessarily disabling interrupts sometimes.

USB isn't a tremendously fast bus, so the overhead probably doesn't 
matter much.  Which tradeoff do you prefer?

Alan Stern
