Received: from lan.nucleusys.com (lan.nucleusys.com [92.247.61.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3FD41DE05;
	Sun,  6 Sep 2026 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.247.61.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788682114; cv=none; b=mKaG5s8NkrF1YxFvudA9P7C/s9FS2XAT+Zk8bIie/yGfHYpZfg/eI+FhV6H52RyGOndEJaCerzZPIlejvhxSgpZjsQpn+1vBV/EtnFNDCkywBG6Eu39TdHksaSJ+hk6DRXIQ0jpJM3GtdAVlGOfkih9Kec02H4rQa6WzlM9HQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788682114; c=relaxed/simple;
	bh=HMKw1qkRvIkC0UDtECn9DQ58auZHhqG8gtPrf4sQSjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZP1m6fEa3WM/zQ/xtWKuotfRbDjEzcktPjTQ9cFqSNMh/qhKZ7SLYyub6T+tukQlXz1phbUsq3y263iNl5naHmAxEULOrKUW8LzDsRJRp5fBrsZbTRERxXtTQUexoLtTMQ3m3w9rVvI5QXA1DOC+Ju1xVTfz6wxRdIMApU93Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com; spf=pass smtp.mailfrom=nucleusys.com; dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b=FkZg3Af+; arc=none smtp.client-ip=92.247.61.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b="FkZg3Af+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nucleusys.com; s=xyz;
	t=1788682099; bh=HMKw1qkRvIkC0UDtECn9DQ58auZHhqG8gtPrf4sQSjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FkZg3Af+k2UAmshiuHnONZBaJ4Spi79eS4zh0eNqc1gXa4yJsTMG/R92oZGNfPhT5
	 miP1DvxznRRioWyEIhHNm8vL9ENzYRfl0uWMlwtvD39IZeDO47Hob9QgjfVj2XEom7
	 Bulrdaxai12QjJQPVSYKrQljnPbpYi8H1H74xcdesaDUW9OZ+uys2ilWT++fDHd1hp
	 E3wVYzaGuseKpKWs9JKe7UQVbK605QwpOnMGl528bJo7/N1jClLIyOPfyH+fqVCs1a
	 /RvqTgwsFpPB9i6VCdDlq4lY+fnkXd/C3qc9f/CxKrUR3vCNGFCaeaQPMM1JzmN5JG
	 hhTDLTEmOSN6A==
Received: from carbon.k.g (unknown [85.187.61.220])
	by lan.nucleusys.com (Postfix) with ESMTPSA id 16F1F3FD2D;
	Sun, 06 Sep 2026 11:08:19 +0300 (EEST)
Date: Sun, 6 Sep 2026 11:08:18 +0300
From: Petko Manolov <petkan@nucleusys.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Oliver Neukum <oneukum@suse.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 net-next 5/6] net: usb: pegasus: Move long delayed
 work on system_dfl_long_wq
Message-ID: <20260906080818.GC6356@carbon.k.g>
References: <20260720100902.155605-1-marco.crivellari@suse.com>
 <20260720100902.155605-6-marco.crivellari@suse.com>
 <f972b514-87ef-45bc-8258-db199a4cc0b8@suse.com>
 <20260825151812.4aJyFUgE@linutronix.de>
 <31b46916-dd89-4ae9-89b9-9d39e29e8e69@rowland.harvard.edu>
 <20260828094318.bOajNBno@linutronix.de>
 <b6cf44a1-d2b1-443d-8efe-c596ef89cc2a@rowland.harvard.edu>
 <20260905150450.2hrac_GV@linutronix.de>
 <b6e6e8d0-0888-4bbc-85b8-ca3bdac88398@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e6e8d0-0888-4bbc-85b8-ca3bdac88398@rowland.harvard.edu>

On 26-09-05 12:33:07, Alan Stern wrote:
> On Sat, Sep 05, 2026 at 05:04:50PM +0200, Sebastian Andrzej Siewior wrote:
> > 
> > Still the wrong thing to do? The driver should do either flush_work() or
> > cancel_work_sync() (not flush_workqueue()).
> 
> I think we're in agreement.  If the driver relies on calling
> flush_workqueue(), it should not use a general-purpose workqueue.  However,
> flush_work() or cancel_work_sync() is okay on an unordered general-purpose
> workqueue.

The driver is actually using queue_delayed_work()/cancel_delayed_work_sync() so
the above is of no concern.

Due to HW limitations the carrier state should be checked on a regular interval
and reported to the upper network layers.  This worker relies only on generic
USB transfers, to and from the usb-to-eth adapter, and as such does not depend
on other I/O.

Failure to acquire correct carrier check does not seem to affect the device's
functionality.  Overall i don't think the proposed workqueue change is
disruptive.


		Petko
