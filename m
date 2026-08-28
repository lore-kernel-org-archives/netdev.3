Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C549470429
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787926221; cv=none; b=BXPn7G5jqMozbsr53KcOYI1o0pl2W9VClXD/xIRMuEzhC8AmjupteuvwOvcv6mMYOesmIMe998KEGzNsIY61c9OfOGFZbazfkcP5Pt73tnyNmxvRuETycQIBsKWjtXCCljH3cKo5KG8Sixmjh9s3LwX6GoB2Sx6nyAQmoegxNws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787926221; c=relaxed/simple;
	bh=ZNKccxZiCzly9I5k80F35B1pc+eR7vQ/qDH/pYuN0m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddBrHjFIq0CGK/laJen6gmAqeZt12EGECbPgPGnO8mWSF1nKQqcmyQY8SaORE9I/xlcslUXVlIGJGZdNVDWX2g8TrgcX/XLeTd1DveywSru9JMtq5hye6h09aDArEn0LqvajQpad8qWrW754zyidS9JWXGnNHe24/d2X6fwoGP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=TvOCVadC; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="TvOCVadC"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-936623c6dd3so148739485a.0
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1787926208; x=1788531008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DMTxMAG/rJvYI6GDoxI7NDM2NcdqW0dm+aSGvfT6mdk=;
        b=TvOCVadC1WTItmA22XmsKcrfeIiy/ML5wGK/co9em10igxF8Yku06eJvoOSCxyfrLM
         fIZPDzlOkzXWr6E4yojYGEar2yz//3QL4Mp4AKxHagEAGXH1pxkXXaNVgyB8uS3MC96+
         i1keVpSBwc8qJIrsDzJlmVsdqxnrWCvYHrp5qXZRWDlE1Epweu4GrJvH0h5k3zVW/Wxf
         lU8YKakaJHNa393oM/EPH9qpc5nHpoy+2igaJ4Exjf65vyi2GYneEQZBuOPj3zolNdBb
         FwOUHD6H+esaqClg4YssScg5kZassGR2pTAWGWuvWF9pgjZj8JOs9RVqqFRo8tYnIlTg
         CEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787926208; x=1788531008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DMTxMAG/rJvYI6GDoxI7NDM2NcdqW0dm+aSGvfT6mdk=;
        b=PIFgNNuf3YeVikCMyH4Vs946sEi6KIKgCryuH+iJ5JeTK+sFahbqCOe0zi+ANf7EB/
         uFw7aJzAnKR3jDWEfc63NqXeXlKEo5QxwUjAUG8XsWMARJ2NBfzGGHWJoZN6b4iIjbqL
         ANbzog8CdczEgqnw+nNN5DqaL/67fuouu1n3vm5wTM4ScIm2vlFjXs1h/MatbpEFHEhx
         ycfi3A2ilcOqelLv3XOsjkswmQTvEx1A/M220iCjBkHwvoibKnQrVPObtdUBnyEhZZDp
         +ETTbKXa3RnjiSnXCtTqSgdWUW01OJJNXMpKU3yKX50foC5PZqD7XkfymBK1X6i3dZBX
         4Qzg==
X-Forwarded-Encrypted: i=1; AHgh+RqLi+ciphrvDcOipTT5dhx+15p/HiStrljNev10NHVIoa2X3z5CHpgnymt0OxxsS1vUmG4ZCvQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nQ0LwJgmRE1JBaMLlwGsOUmDJ/H5SO+9RjlRDhRrvnLuwslFMr
	NsKdBGwmkqNeLQ3PEx+OFprSTwUGlnZwKLNX9LgdA3Rv4iYrG+I8r20BBcMuP/K18w==
X-Gm-Gg: AR+sD12T+ZfVLCAS0FV0PuGptLmlkO/6kRDGGKcLX+AIeT9wpUzRL3DWiw/Q/E1A3jE
	uit727nsgD2widnMXYCcQfohQWJ4gL1OBSzKmFRy68/VJqjaktBkRNGe9zayUO7M7hffH1wFKZb
	HX2fnsUlG6mPo811GtwDvKbmMg/jaAlmmvHsBPH+HoqGWX7tFIctHb7UVQijDBc0u/pVXXpalBU
	thhntEareIG9V404L5ssj2a4qWZU7pKuuCTFYyYZxDw/y/HI103MCTJ38XeeVcn6gnEoLU7ZDsh
	Jo0q1MORBb0hCyZapIOCczVmxFKLulBv90X3zOLUEbDZ73/SebCiuUw51DhY2rvGPeHYn89OhuM
	YQEK6NBIRmCP8TRj/toVZop/9+eo4AWMrmFEiWhvrNlpf+nzmR/mkc5L/fTp3kLD5CubvB1KyB5
	DrX7TgrIoJkCLGIId1hJzx2/oEF0AaLBXqCLu7QfcNXvsiFoNQVTKT/53I8UKc6vN42+hQ2AlxM
	5v6bO8=
X-Received: by 2002:a05:620a:1588:b0:930:9cbc:7121 with SMTP id af79cd13be357-93900131031mr1301468585a.3.1787926205824;
        Fri, 28 Aug 2026 07:10:05 -0700 (PDT)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4460e0dsm15997766d6.11.2026.08.28.07.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 07:10:04 -0700 (PDT)
Date: Fri, 28 Aug 2026 10:10:01 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Oliver Neukum <oneukum@suse.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Petko Manolov <petkan@nucleusys.com>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 net-next 5/6] net: usb: pegasus: Move long delayed
 work on system_dfl_long_wq
Message-ID: <b6cf44a1-d2b1-443d-8efe-c596ef89cc2a@rowland.harvard.edu>
References: <20260720100902.155605-1-marco.crivellari@suse.com>
 <20260720100902.155605-6-marco.crivellari@suse.com>
 <f972b514-87ef-45bc-8258-db199a4cc0b8@suse.com>
 <20260825151812.4aJyFUgE@linutronix.de>
 <31b46916-dd89-4ae9-89b9-9d39e29e8e69@rowland.harvard.edu>
 <20260828094318.bOajNBno@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828094318.bOajNBno@linutronix.de>

On Fri, Aug 28, 2026 at 11:43:18AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-08-27 12:01:02 [-0400], Alan Stern wrote:
> > > > These drivers have their own work queues because they are part of the block layer.
> > > > USB devices can share a device with a block device (storage & UAS) and
> > > > USB devices have common, per device operations, in particular reset
> > > > and runtime power management and disconnect handling. Because these operations
> > > > can be necessary to complete block IO neither they nor anything
> > > > they depend on can use IO to allocate memory. That is they need to
> > > > perform any memory allocation with GFP_NOIO or GFP_ATOMIC.
> > > 
> > > This is a networking driver. It has nothing to do with storage and UAS.
> > > It uses USB, yes.
> > 
> > Ah, but a composite USB device can have both a networking interface and 
> > a mass-storage interface.
> 
> okay.
> 
> > Suppose you have such a device, and suppose the disk attached to its 
> > mass-storage interface contains a swap partition.  Now suppose the 
> > device is being reset, and as part of the preparation for that reset the 
> > networking driver needs to flush its workqueue.  This means waiting 
> > until the work routines that are already running have completed.
> 
> The individual functions are usually independent. But if the USB core
> would reset the whole device it would reset each function.
> 
> > Since it's a general-purpose workqueue, you don't know what those work 
> > routines are going to do.  One of them might try to allocate memory 
> > using GFP_KERNEL.  Suppose that in order to satisfy the memory request, 
> > the kernel decides it needs to write some pages to the swap partition on 
> > the USB mass-storage interface.  But the mass-storage driver is stuck; 
> > it can't do anything until the device reset finishes.  Deadlock.
> 
> So you are saying, the USB-storage device is in reset and we wait until
> the networking part finishes its workqueue flush. That flush is stuck
> behind behind a memory allocation which waits on the storage device. So
> any URB passed to usb_submit_urb() just waits for the reset to complete?
> 
> > That's why USB drivers have to use their own workqueues.
> 
> While this does make sense I don't see how this is related to this
> patch. The pegasus driver uses `system_long_wq'. This is a system wide
> workqueue_struct and is not limited to USB or this driver.
> This workqueue is per-CPU meaning if you enqueue the work item on CPU3
> it will be executed on CPU3. However pegasus uses a delayed work item
> and the timer can fire on any CPU so even if it is enqueued on CPU3 it
> could be executed on CPU1.

It doesn't matter what CPU the work item runs on.  Here's the deadlock 
sequence, in brief:

	USB device reset cannot proceed until network interface's
	->pre_reset() method returns.

	The ->pre_reset() method cannot return until its call to
	flush_workqueue() returns.

	flush_workqueue() cannot return until the already executing
	work item finishes.

	The work item cannot finish until its kmalloc() call returns.

	kmalloc() won't return until the kernel can free up memory by 
	writing some pages to the swap partition.

	The write to the swap partition cannot take place until the
	usb_storage/uas driver carries it out.

	usb_storage/uas cannot do anything until the USB device reset
	is finished.

> Therefore the suggested change system_long_wq -> system_dfl_long_wq
> should not make a difference here: it is a different workqueue and it is
> unbound (instead of per-CPU) but given the usage it is unchanged but
> more obvious. Also its usage recommendations (use this for long running
> items) is the same.
> 
> The plan is remove system_long_wq from the tree.

The point Oliver was making is that the driver shouldn't be using a 
general-purpose workqueue at all.  Switching from one general-purpose 
workqueue to another ignores this point; it's not the right thing to do.

Alan Stern
