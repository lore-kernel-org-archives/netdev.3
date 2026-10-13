Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FD739FCC8;
	Tue, 13 Oct 2026 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883247; cv=none; b=lnE4ygk+QKAgkvfsFgxypdfn3WGrOR5TPfL2N4InKFx8jIbmQ7Dqam0xaA3+Up0ey73v/wpxcugb9jg9e5ornkQymaJ6irWN5roqsb4bF6cjpwu3yy1gTYyj8u0QJYJakKoeYQ0Z0R/OmEOD5QpPfsCqnM2NrkYOtWHnctJ+1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883247; c=relaxed/simple;
	bh=vIA/3RR0vIKG8eq+CjJ3MePklgD7LDevQ7H0MXSg4Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0nTs6iW1GOLHGMLK9iFlvJuhRWnMHk1sEq4diqdelNo8C5goW8fKfv9lOdZabwr9Cq0IdDXs2U1ropTEv8TzeU7txydpqoPH6yuPFyBGT9eDlln7Q/LIsdo+mWb/rlo5VIhOfEC39L4D7YPwDyl8QJ66g4dh4Q0lPT4K8y6uoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AerwlHK4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nr+gS7PN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AerwlHK4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nr+gS7PN"
Date: Tue, 13 Oct 2026 11:20:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791883243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z6FY1icZ3uxfpHeqlpgjn58h/Q4e8qj86vKcI+UHaQ=;
	b=AerwlHK4D5jmmDUizPaSj2aKqCv3RC1ffu+IBrRB/sWlOY+VNP/A9KKSn+hHrtEV1tSU0k
	DC24keC5I6rXyTa0ZrQJqYrgWtr/9k4Q35eqOsgMmWMnh23CvGlFxVpu2qPkcXLhsxIQgK
	MGTC04oqziF5rmqLNYxk3m6Zt0DLheHSbz4xksvnVCF0tM+R4+DB9CCs5a2rxEHsWMr2b/
	bMgIxqiHGWfhTawVnA0ryCHXGb3KBCskRlMpDLaPWOAnAguYJsdn+obsRyad5yMqnu3eWR
	qHbYQsQ9I0wGZ0x3Cj/Os57MUYLAh+an4Vw31Cl6cg4xlQacknaYUXOQseqHQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791883243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+z6FY1icZ3uxfpHeqlpgjn58h/Q4e8qj86vKcI+UHaQ=;
	b=nr+gS7PNFCHvZIllXiG1Z2VEF3XKJLcZdYJ1Zrlz/hxNfEL/t7f1ebHIK9gecTJ7p20xAA
	rrocqjQInFBIyHCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Oliver Neukum <oneukum@suse.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	=?utf-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com,
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in preemptible
 context
Message-ID: <20261013092042.drwtxbGU@linutronix.de>
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
 <20261007200049.079aeb75@kernel.org>
 <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
 <20261008094338.301a75fa@kernel.org>
 <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
 <2026100910-petition-embattled-94cb@gregkh>
 <20261012194902.aEq58Q6b@linutronix.de>
 <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>
 <4d3a6c5c-7516-4bab-ac0a-3cf4d7a034a2@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d3a6c5c-7516-4bab-ac0a-3cf4d7a034a2@suse.com>

On 2026-10-13 10:54:09 [+0200], Oliver Neukum wrote:
> On 12.10.26 22:26, Alan Stern wrote:
> > Today you fix VHCI, tomorrow some other virtual HCD will cause problems.
> > 
> > Should we document any requirements that all HCDs will have to follow
> > and that all completion handlers can rely on?
> 
> Numerous corner cases. For example I strongly suspect that unloading
> the driver for the HC will always complete URBs synchronously.
> Please do not do this.

Sorry, I have hard time to parse this. The expectation of the USB driver
(was) that the completion handler is invoked in interrupt context.
Therefore BH is disabled one way or another.
Are you saying we should not have this behaviour documented/ expected
and assume preemptible context because "rmmod hcd" will complete all
enqueued URBs in the rmmod context?

> 	Regards
> 		Oliver

Sebastian
