Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ACC3CF1F2;
	Fri,  9 Oct 2026 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545488; cv=none; b=X10X9WsF8s4qf/wKJ2WZYFevHwm6zYHfiJSbiXzyZRiOS8XnyZbu/ocP6HWdBjwqNURQoirLsovbJO/PDSJUVGlEfCY6TjfNcxrIHQ0crn2mQ/uUIByjuCyYcx1gGB2MCqt45LkXrzueqRHT3c4FJC10CY6zm3/zD9Kii3Os0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545488; c=relaxed/simple;
	bh=7bqAYquRcaUcKQo1uIX407Awr4Gy1tmU26ypgsoVZx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gusCbaIQRa/wK+X4D/8At+O8vRmW6YLgNtpjTPaDIPRBjlHJvakzD/DC28ZPpRwDXUwZrKFK4KXje2/zxUSMkUQ8ZdJn3GqIEMgMXMVcDBva367crhfKgw92kxitvcnFSeCkeYPCCljY+YJg1zREtsu9BMHtVH9ewBzmRRtHWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zeVbEjCH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zeVbEjCH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990DE1F000FF;
	Fri,  9 Oct 2026 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791545480;
	bh=VixQS6M+aA7UakThv1UpOVO6JZbB9ttcZhFkmNbcDWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zeVbEjCHJi0dShia5MPNZSL/D/c1+6J8y7CeoIGQezCG8kj5Yi1WYuKho36v9sf9+
	 RGYkUd4MIgYIzitdjviqX3LUgfBM6tWHq/pD38q9h+wHaBg6aG7qQpbn5EaMnM9sDn
	 CIfaprWiTgnK2nqNHxdOQ7eMNwvH6evbilne1sDQ=
Date: Fri, 9 Oct 2026 13:31:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jakub Kicinski <kuba@kernel.org>,
	=?iso-8859-1?Q?=D6mer?= Mete Kaya <omermetekaya0@gmail.com>,
	oneukum@suse.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in preemptible
 context
Message-ID: <2026100910-petition-embattled-94cb@gregkh>
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
 <20261007200049.079aeb75@kernel.org>
 <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
 <20261008094338.301a75fa@kernel.org>
 <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>

On Thu, Oct 08, 2026 at 02:03:34PM -0400, Alan Stern wrote:
> On Thu, Oct 08, 2026 at 09:43:38AM -0700, Jakub Kicinski wrote:
> > On Thu, 8 Oct 2026 10:16:02 -0400 Alan Stern wrote:
> > > > This looks odd, how did we miss this for 8 years.
> > > > 
> > > > Greg is probably busy, but would be good to get a confirmation
> > > > from either him or some other USB expert that the callbacks
> > > > can indeed be called in process context.  
> > > 
> > > They can be called in BH context with interrupts enabled.  Is that close 
> > > enough?
> > 
> > BH should be fine on !RT. The patch, AFAIU, is because vhci calls
> > the completion callbacks in pure, unadulterated process context.
> > I'm trying to figure out how urgent the fix is, basically.
> > If it's a vhci bug then the usbnet fix is at most an RT problem.
> > Also if vhci is doing something wrong we don't want a truckload
> > of slop patches sent our way to fix 300 drivers :S
> 
> As far as I am aware, there aren't really any guarantees on the 
> context of a USB URB-completion callback.  The kerneldoc for struct urb 
> in include/linux/usb.h says "The completion callback is made 
> in_interrupt()", but that is most definitely out of date.

I don't think so, I think some platforms still have those callbacks in
irq context, unless we changed to threaded irq handlers everywhere?  I
could have missed that, but we should still write the callbacks to
assume that and then we should be fine even if we aren't in irq context,
right?

> Drivers shouldn't rely on any particular context guarantees.  Not even 
> whether local irqs are enabled/disabled.

Agreed.

thanks,

greg k-h
