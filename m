Received: from lan.nucleusys.com (lan.nucleusys.com [92.247.61.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFE2392C2C;
	Fri,  4 Sep 2026 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.247.61.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534618; cv=none; b=XcSDEk/nriz83k87N4h8K9ljw3mRQfv3/ctPz/FrzZK44dwCuLVxaP/gH8uZdt5KJig1Yo5CYcW3NhgACJycXtAD1Dvmy78xV6hifORpWhO7ZUFVBtfTKmFHxhNor5pK4At2VRYa9laET7NpPph+2fbDdwLhOZP1sSvsciSY314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534618; c=relaxed/simple;
	bh=B4O23lhK4/4JBgLCjwaCw2ARTipscO18DKez0cXjtLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj5ISubV1Z08B3sxcGd4MKhs9TwExevODCYlBFMC/gJ4XuYDFontlA9xQDEKr/wrEsSs8L2Esot6FP9sXHtsGSzRqRrxG3LSEaggQ1FIGKsT0bh02DPg6nWXdwxIcmBuCswQeCpcSEx+3tqtSZ0HN81JGHyLxeaY2IcW7C6Zkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com; spf=pass smtp.mailfrom=nucleusys.com; dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b=foJU1Ks4; arc=none smtp.client-ip=92.247.61.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b="foJU1Ks4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nucleusys.com; s=xyz;
	t=1788534111; bh=B4O23lhK4/4JBgLCjwaCw2ARTipscO18DKez0cXjtLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foJU1Ks4xTDm/6sQenxuBHpH8VaQUj1XVzOtsYuLqniFpdY3JlfZsIqMdG9TctdzC
	 k4Fg0aHkRzy6WrcKCJPNlq435bY4e/7rjyP47aZ3qLZKcB7MTz4TB/IOfK+VijZFtM
	 XxCF6ywWjTA4lu1dncUr4sbiTPSvkYeDgp76lfYIIUr51ZcbURuRtXJDvl000ulYMF
	 BkYTCkwA8IA/YsDqG+uhwmM8HrL+Ggcapg9h5J7vZqOd4fxGzoqCbMxtvaGP9aRhD7
	 IusdXmRx9RwsmP6q1v+Rk0Mqe3xGNrIvwd6P9ZmVl2qj329BmT3+Tq6HxUzFLgaAh+
	 rrGVeibO3lO/A==
Received: from carbon.k.g (unknown [95.43.149.250])
	by lan.nucleusys.com (Postfix) with ESMTPSA id 0D2A53FA70;
	Fri, 04 Sep 2026 18:01:50 +0300 (EEST)
Date: Fri, 4 Sep 2026 18:01:49 +0300
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
Message-ID: <20260904150149.GA21082@carbon.k.g>
References: <20260720100902.155605-1-marco.crivellari@suse.com>
 <20260720100902.155605-6-marco.crivellari@suse.com>
 <f972b514-87ef-45bc-8258-db199a4cc0b8@suse.com>
 <20260825151812.4aJyFUgE@linutronix.de>
 <31b46916-dd89-4ae9-89b9-9d39e29e8e69@rowland.harvard.edu>
 <20260828094318.bOajNBno@linutronix.de>
 <b6cf44a1-d2b1-443d-8efe-c596ef89cc2a@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6cf44a1-d2b1-443d-8efe-c596ef89cc2a@rowland.harvard.edu>

On 26-08-28 10:10:01, Alan Stern wrote:
> On Fri, Aug 28, 2026 at 11:43:18AM +0200, Sebastian Andrzej Siewior wrote:
> 
> > Therefore the suggested change system_long_wq -> system_dfl_long_wq should
> > not make a difference here: it is a different workqueue and it is unbound
> > (instead of per-CPU) but given the usage it is unchanged but more obvious.
> > Also its usage recommendations (use this for long running items) is the
> > same.
> > 
> > The plan is remove system_long_wq from the tree.
> 
> The point Oliver was making is that the driver shouldn't be using a
> general-purpose workqueue at all.  Switching from one general-purpose
> workqueue to another ignores this point; it's not the right thing to do.

I read this as "this driver should switch to its own work queue", correct?


		Petko
