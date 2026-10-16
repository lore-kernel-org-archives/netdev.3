Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6B494267;
	Fri, 16 Oct 2026 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176966; cv=none; b=SHFC6iBGIfX7L9S5fKZwMin/s+mzJYmoeAo94znpEUqpLypnwJd4OtHgujzW0MQYAQKkhLyJjUCUPktBkhxQHiq7Gi42gLlKOdXjTp6YWcitmjfiaPZOKtlkYbDEdR4pSKR93SdkgocX8lS8XIsNxt4IXr62AKpZ0nRdNlA36Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176966; c=relaxed/simple;
	bh=asA9A46vs199n4x1RXplOlOugr4L24utRaHE5SjhgmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKoenGYcSl+3F8YF009BipSEQvMMWpBhwI6Jz68ZqzVMA6DSJiOQ72RinIgRwwcMqWU+K0GtyptChiY4o4s0UhURpjhmzh/tBSGQ+c8h4igIMQWEjrAGekEsE42Yf7KyK6WtfonEFgT+mNlar/3a3NAYonajKFKUIJ6+/l8vpkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uSS3ml2/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=krPuJ1eO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uSS3ml2/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="krPuJ1eO"
Date: Fri, 16 Oct 2026 20:56:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792176962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KCRwJlfvUgGFGt5eIztvu2jgX/gJgA3sTgM1BXYDUsw=;
	b=uSS3ml2/oOHRT6pM2VT3URgA/AduRuAtJlNihs21xV7Ew8FDDtT0QneYSfbk5C+sCxyXlP
	X6SZK48rHUQtoT8UfYxC0KEEHQc+pxffeOE7R7KhKB5qM3+iLDjADx7p3rhKufWW/RgOwY
	2n00S1K+xCPElNvNCbbXAlp6IJ0EfFnY8bomegRGKKvjwudW1PV2WOu1QcdAHbPz509PUa
	h31kwlEdm1Lj/gffa3yYhv3PBl4uD0fAj3vNKcVAB4KweEq6aY7Ma15dbndy6iMMckocWm
	lUSpjez9HX5Em+je2gd53qgurvBXVWhvT9+R+Bo9Q36s9vnQeNhfTUj/ZnwKVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792176962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KCRwJlfvUgGFGt5eIztvu2jgX/gJgA3sTgM1BXYDUsw=;
	b=krPuJ1eORkm5wBrlBL/ZKmoo8I7Pst9Amj6e9FQWbzMEw9h6taRztTd5HtkFmTvDUcQnFz
	00pHdQ1ZDH0f5pDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	=?utf-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>,
	oneukum@suse.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH] USB: Documentation: Update description of completion
 callback context
Message-ID: <20261016185600.yZTtGfHF@linutronix.de>
References: <20261012194902.aEq58Q6b@linutronix.de>
 <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>
 <20261012212527.5sFqlGYu@linutronix.de>
 <41af30de-4725-4913-9ad8-54d1dea2d4b8@rowland.harvard.edu>
 <20261014191141.GxlJhR1e@linutronix.de>
 <89da3b1f-60e5-4f18-9592-3d6d7175c437@rowland.harvard.edu>
 <20261014220403.R38Gf0pW@linutronix.de>
 <de582feb-a0aa-4fc8-9818-890014de32a9@rowland.harvard.edu>
 <20261015182643.MIjjSTAr@linutronix.de>
 <7494e770-518f-4866-87e2-5a525af3b82e@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7494e770-518f-4866-87e2-5a525af3b82e@rowland.harvard.edu>

On 2026-10-15 14:35:56 [-0400], Alan Stern wrote:
> On Thu, Oct 15, 2026 at 08:26:43PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-10-15 12:00:46 [-0400], Alan Stern wrote:
> > > The existing kerneldoc documentation for URB completion callbacks is
> > > incorrect about the context in which the callbacks occur; it is not
> > > always in_interrupt.  State explicitly that a callback may occur in
> > > any context with no guarantees, and likewise for the status of
> > > CPU-local interrupts.
> > > 
> > > Documentation update only; no code changes.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > 
> > usb_hcd_giveback_urb() kernel doc says: 
> > 
> > |  * Context: atomic. The completion callback is invoked either in a work queue
> > |  * (BH) context or in the caller's context, depending on whether the HCD_BH
> > |  * flag is set in the @hcd structure, except that URBs submitted to the
> > |  * root hub always complete in BH context.
> > 
> > Do you think this deserves an update?
> 
> I think that's okay as is.  It describes the current implementation 
> pretty well, even though it doesn't mention the lack of guarantees.  If 
> you feel it should be changed, let me know.

It reads as it is always atomic. Maybe removing parts of the description
and adding a pointer to your initial documentation would be better.

> Alan Stern

Sebastian
