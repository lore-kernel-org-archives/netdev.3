Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656223B4E88;
	Fri, 28 Aug 2026 09:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910204; cv=none; b=Y71UUNdEFAv5YkF5GUeyMeUWk7/7hfKH9PrhhOi2DMEJtwa+Pt4cksAfSX6KPlxoLHf5EstUmEOAjSJ8+Llttk2OvZw5X+PnlILRg3MSfwgtXjJ7GIs8PCYgJJSVGNnw2AIHwUWpv/KB15weu3ZkWtqWU0BMjVFwrKChj7l60oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910204; c=relaxed/simple;
	bh=hfeoNiAXpofN56qgXyvfF/HSqnz59+ctNIfUn3H9PtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz4ATo9aIdNGPl4rEcc9px833ZvGtfbHv7qv5dQEbCzVTdEVQ/rnuFGweiuAoqolCyD447SwpgQ341VRNOqEYoW8SZGlzTgvzn1zkduTOot5i9QPiRBmDiYrI0b3nRBsqdM1g6qdaIrXURPWjsRbsPkkk23Qe1WPktlXcw7E0QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=45o+Yljh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J7SSjOvo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45o+Yljh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J7SSjOvo"
Date: Fri, 28 Aug 2026 11:43:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787910200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pjRHFhHriioVeDp+1zYDfvO+9D3/XP/DtK0lE0wEdBg=;
	b=45o+Yljhyc3s4BUwME1WMOaYN9eCn7pyf4yobL669RIzcBYx+SfQ1wLLfU6yE2h+hxItjf
	C4f+B0YZtQVz3cnCqOvHqGm2GwDWjs70GbluAcXc1KOugpwD/QbpItO2TJBEBkOSezf47R
	cYddf5TFsQUHqF/Bg9N0x9G3dccYdWVrO1myP2YwcurMmcVban6fRs+J8IVSz0cKfhuPJz
	xR9Ackm9tEATPULMf6imMQdPrgbkx35+uAtW6fCrdmA75A/eFp51ttYJTGYiUX5tnmHp9s
	t5x3l0TOdYIvTQppNR/qZyI0pn+An6p1cz022T40uDNGtIoUX6PmQXVhHskEtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787910200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pjRHFhHriioVeDp+1zYDfvO+9D3/XP/DtK0lE0wEdBg=;
	b=J7SSjOvoFsBHMldr7g2u9ONRUja7c8TygPTZx8/uOsiCpvh6b+U2t5PEBF1mIR0KhltRim
	KcBFeJE3RXQBOEAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20260828094318.bOajNBno@linutronix.de>
References: <20260720100902.155605-1-marco.crivellari@suse.com>
 <20260720100902.155605-6-marco.crivellari@suse.com>
 <f972b514-87ef-45bc-8258-db199a4cc0b8@suse.com>
 <20260825151812.4aJyFUgE@linutronix.de>
 <31b46916-dd89-4ae9-89b9-9d39e29e8e69@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31b46916-dd89-4ae9-89b9-9d39e29e8e69@rowland.harvard.edu>

On 2026-08-27 12:01:02 [-0400], Alan Stern wrote:
> > > These drivers have their own work queues because they are part of the block layer.
> > > USB devices can share a device with a block device (storage & UAS) and
> > > USB devices have common, per device operations, in particular reset
> > > and runtime power management and disconnect handling. Because these operations
> > > can be necessary to complete block IO neither they nor anything
> > > they depend on can use IO to allocate memory. That is they need to
> > > perform any memory allocation with GFP_NOIO or GFP_ATOMIC.
> > 
> > This is a networking driver. It has nothing to do with storage and UAS.
> > It uses USB, yes.
> 
> Ah, but a composite USB device can have both a networking interface and 
> a mass-storage interface.

okay.

> Suppose you have such a device, and suppose the disk attached to its 
> mass-storage interface contains a swap partition.  Now suppose the 
> device is being reset, and as part of the preparation for that reset the 
> networking driver needs to flush its workqueue.  This means waiting 
> until the work routines that are already running have completed.

The individual functions are usually independent. But if the USB core
would reset the whole device it would reset each function.

> Since it's a general-purpose workqueue, you don't know what those work 
> routines are going to do.  One of them might try to allocate memory 
> using GFP_KERNEL.  Suppose that in order to satisfy the memory request, 
> the kernel decides it needs to write some pages to the swap partition on 
> the USB mass-storage interface.  But the mass-storage driver is stuck; 
> it can't do anything until the device reset finishes.  Deadlock.

So you are saying, the USB-storage device is in reset and we wait until
the networking part finishes its workqueue flush. That flush is stuck
behind behind a memory allocation which waits on the storage device. So
any URB passed to usb_submit_urb() just waits for the reset to complete?

> That's why USB drivers have to use their own workqueues.

While this does make sense I don't see how this is related to this
patch. The pegasus driver uses `system_long_wq'. This is a system wide
workqueue_struct and is not limited to USB or this driver.
This workqueue is per-CPU meaning if you enqueue the work item on CPU3
it will be executed on CPU3. However pegasus uses a delayed work item
and the timer can fire on any CPU so even if it is enqueued on CPU3 it
could be executed on CPU1.

Therefore the suggested change system_long_wq -> system_dfl_long_wq
should not make a difference here: it is a different workqueue and it is
unbound (instead of per-CPU) but given the usage it is unchanged but
more obvious. Also its usage recommendations (use this for long running
items) is the same.

The plan is remove system_long_wq from the tree.

> Alan Stern

Sebastian
