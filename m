Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EAB3A4F50;
	Tue, 25 Aug 2026 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671097; cv=none; b=jFfQPN5yqtAuPfrKDSKtNN8YqfWBVrs2ytZZZmE/3N6GriEQK+R7FF567rJht9rtRCigXSsFAgAHEEtoDivy49cbIppDdclvgvugG+RfSDsllqxzGNItbx0p9kwOie+rSyJEJ4DlyrYFGo56TWtSO5+XMRowCyliFAkgesf2inI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671097; c=relaxed/simple;
	bh=npgZoPCsvXA/jh1+JnEqd3XtEC+lPaJtAyQSWuC8u5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=my7BMHGrbD77TMmK+yE2mg33nI48b3xVu5CoG9LRpVAcHHxvW+895nHzJ9Jdj79+vVUfyrwlqQVYcea5npL1MyD/crUnOqn3ZkvWbrItz1+JdMvgRYR5g5RZ0JjQXWMHXmBGGODk/5lmnaY3RFS3O69mkAomwzJWdB6aOY5mLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gq82Z/Ly; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xKGYC7H5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gq82Z/Ly";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKGYC7H5"
Date: Tue, 25 Aug 2026 17:18:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787671093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dsJ1+OuR6QB2L873ffkYbq+WpmuwWk6zhvfXZRn54n4=;
	b=Gq82Z/Ly4X5NfZjO5d14YPENObGXO/r8C63dmMoomYrGB6B6fn/wInoYaAg9tpWdCKOdWp
	3JoWytu7x+WenxFF+AanPcE/MJe2GhpVDXJmDRvxhXLlJgwLU4DwR97RI9t6sUE7ucuTmm
	2QyfKj4kt8yle/lGtaTsT6YhhBQBq4KYajWzQJheT9ZACKpzV6T7ikfrQDlltkSMbHy5Jl
	DRiXpb0rBuOJzUDbyOSBRQFiTjT9BXBi7/pz3++PEkl1d5OC/PhE0anEtkank01kYbGs+3
	iyZp0avaNMzmpDsI5pvK/jlBYyvkcaZ6awFEb2/ttKaXn9pR+i5cIDixLr+wLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787671093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dsJ1+OuR6QB2L873ffkYbq+WpmuwWk6zhvfXZRn54n4=;
	b=xKGYC7H5LxToZ4FZKXekev9IczdRULeVZye2c2mzyGOPFfFYVy32GvW6mYRcNCl0OCIB6b
	IfpXD7UmkprSTJBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Neukum <oneukum@suse.com>
Cc: Marco Crivellari <marco.crivellari@suse.com>,
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
Message-ID: <20260825151812.4aJyFUgE@linutronix.de>
References: <20260720100902.155605-1-marco.crivellari@suse.com>
 <20260720100902.155605-6-marco.crivellari@suse.com>
 <f972b514-87ef-45bc-8258-db199a4cc0b8@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f972b514-87ef-45bc-8258-db199a4cc0b8@suse.com>

On 2026-07-22 10:29:50 [+0200], Oliver Neukum wrote:
> On 20.07.26 12:08, Marco Crivellari wrote:
> Hi,
Hi Oliver,

> > Since the workqueue work doesn't rely on per-cpu variables, there is no
> > obvious reason that justify the use of a per-cpu workqueue. So change
> > system_long_wq with system_dfl_long_wq so that the work may benefit from
> > scheduler task placement.
> 
> these changes are problematic, although they look like a good cleanup
> in first place. But the test you are using to determine whether USB
> devices need their own work queue is incomplete because you are not
> considering the reason they allocate their own work queues.

This driver does not using its own workqueue.

> These drivers have their own work queues because they are part of the block layer.
> USB devices can share a device with a block device (storage & UAS) and
> USB devices have common, per device operations, in particular reset
> and runtime power management and disconnect handling. Because these operations
> can be necessary to complete block IO neither they nor anything
> they depend on can use IO to allocate memory. That is they need to
> perform any memory allocation with GFP_NOIO or GFP_ATOMIC.

This is a networking driver. It has nothing to do with storage and UAS.
It uses USB, yes.

> That is also true for any operation on a work queue they need to wait
> for to make progress. That means you cannot limit your check to per-cpu
> variables. You also need to check for such dependencies. In particular
> any usage of flush_work() on such queues can deadlock, if you use
> common queues.

It has nothing to do with per-CPU variables. In fact its
queue_delayed_work(,, CARRIER_CHECK_DELAY) usage already ensures that it
can be executed on a random and not on the submitting CPU.

> Please refrain from making such changes unless you have fully analyzed
> the dependencies.

Did you refer to the wrong patch? As far as this patch goes I can not
reason why you assume Marco did not fully analyze the dependencies. I
don't see anything wrong with this patch.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> 	Regards
> 		Oliver
> 

Sebastian
