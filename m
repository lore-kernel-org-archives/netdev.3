Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12EF448D1D;
	Mon,  7 Sep 2026 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772328; cv=none; b=TqD7YPzCtYOu0okBhu1k3RPJ0NgtrdecEy973Y8HrE2x7r1ABEuqEsFKTRyZm3O56GYP+aGDSGjaiS4MJ9z/ynUBcqENCzKHmmUh5rjnsMYqg7U4CRD2tACWtWiCBFiG9GQca97e3BeQawVcIi7b0XChpdieUkUtfSoDcooEFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772328; c=relaxed/simple;
	bh=ZusEL3lsgLdP6fWCQSIm0JKvq+rgZVBvTczC1OOm1MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyUd3/Z2rGtSteC1S8ddSFaH9fWjmW2fx7kL3OdQHnjR80p9pjZSZgUgvWYpXFUbQ5QYx0CyHZ2KQnexIq3DPPFNUM6Tib68Nz0e3qB1o1k68BAOQscJ5wI3PHVnnSMIyMf0YbtuAP/uJhkWPtYE9/yNj0qY+x9W6wu+/ODlwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q9dTsZMG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4bDT0edh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q9dTsZMG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4bDT0edh"
Date: Mon, 7 Sep 2026 11:12:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788772323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OXHJuH5OBiG6iOq4zyP3h3piKcfc+3M2EOW8DAxaSVE=;
	b=Q9dTsZMG2ggfiN6+gN2DuwoBopDAvsseK+oZAONgHbEvLukxiUtJ6rHIYjwSFzkuzU5Zsp
	AnEPmM104fVUx6q2YRxUMWy7lrRTRD2pVlE3sZY5k4rg166QETNqibaYmFMPkfSABCQhA4
	fJevxvgvP1ByzJJB6Cgp3ox56WITXVD6HoaPaudGMT8rKgrbYGDM1ZovmOfIw+A9iIGlfF
	me4ql6oLhAM6AEjBx6kQWZq3EeO3TokHdxtTKgjQaMg8r61Yk2Mv8zXfynMD2FdpM8WuQX
	/Dm0fovpkBDW0yI6JJd7OByhosSEE9PGvcqALCNYzMbWYh6F7cmOPAHhkcpagA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788772323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OXHJuH5OBiG6iOq4zyP3h3piKcfc+3M2EOW8DAxaSVE=;
	b=4bDT0edh++2GOxOL9lAmt0HpVjPt7aoJVeF0GUXqCVVf5aPBMAt7i/kjiUEO0eFs14KN//
	8BML7//kVv4v1cDQ==
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
Message-ID: <20260907091202.hnFpCqFV@linutronix.de>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b6e6e8d0-0888-4bbc-85b8-ca3bdac88398@rowland.harvard.edu>

On 2026-09-05 12:33:07 [-0400], Alan Stern wrote:
> > Still the wrong thing to do? The driver should do either flush_work() or
> > cancel_work_sync() (not flush_workqueue()).
> 
> I think we're in agreement.  If the driver relies on calling 
> flush_workqueue(), it should not use a general-purpose workqueue.  
> However, flush_work() or cancel_work_sync() is okay on an unordered 
> general-purpose workqueue.

Perfect, thank you.

> If Oliver still has any objections, he can raise them.

Okay. So far this is good to go ;)

> Alan Stern

Sebastian
