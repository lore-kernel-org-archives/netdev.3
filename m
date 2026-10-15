Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD383161A1;
	Thu, 15 Oct 2026 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088812; cv=none; b=s120bZ6/9zkkgPQygpCFw078kgimX3LpVJ2tJf4cJhYRgTtH0QKlU5/ZuvJ0wm7yX0F4SufNpCXLcI19Qtyf1NTUDU4RgVZQ5C51CdZmZCvwB7qo3uN5Dwx15FleL74IyaABkoTZj3/3YaavUejpvFNTHlEDu5Ha8ca0VhkrpsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088812; c=relaxed/simple;
	bh=jaKT1vd6Nk22cDhUf7YkN9EPXS477pLxkPrSe/hbmfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5VqOlEw12pqFr9QjSpCxuXEhyw/Rm5GFwkrGeEl1Mro0TL4NJpoRbkev50TvXwXPn9XW6DMi3MFWzwN5tKB7w8lHUzOYkJk7lHMzFRXLQzG6pSWiVhmi7AmCZgHf1eB5THyp66ugeHEKgfncc9clgXKcc81acSyMqqNu84TbRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dnkM1QqJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fv7grZ/E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dnkM1QqJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fv7grZ/E"
Date: Thu, 15 Oct 2026 20:26:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792088805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hb2ATapVCir5c7vfUU9dpC0TyRGAFJwwDj7tJXTZnYI=;
	b=dnkM1QqJGB/NsT28efbDEXWp/jcfgTFPSLqJ/wEx7IA/dQalxKIAoRErrlSu4cJb7wjMop
	0VLsk+VLy/jpiwQPT8gy0envoRrZdxlAvIqJV30AgkHBBZ2C9+NcrausiIwp0W+mOEcxKD
	40lfLD/muoqXKBeS6hQbtg+X2+qguhHKvhQ097MetCJ/IawJJJz3vh+orqNKdBC1i4Rj2B
	BxZxqpSaiOt8DOzk0q7voNGh27wpTVWuj1OAfkRXyp4fDSAhNg/59ib4wjdo0fkJ0WkXYE
	l1jkHyFhlbOfZoB7pADwXFeVljkpnvBV75Cm0woJ+QMC+1afXzR3ttiNHg3sLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792088805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hb2ATapVCir5c7vfUU9dpC0TyRGAFJwwDj7tJXTZnYI=;
	b=Fv7grZ/EjV1oRoQ6oyjx0MNSL7Jd+9EWGDTGHqD62blrvcIB8/LfQrAyIc7B0vZ3DMcNJr
	B1NsODpSIXttzBBg==
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
Message-ID: <20261015182643.MIjjSTAr@linutronix.de>
References: <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
 <2026100910-petition-embattled-94cb@gregkh>
 <20261012194902.aEq58Q6b@linutronix.de>
 <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>
 <20261012212527.5sFqlGYu@linutronix.de>
 <41af30de-4725-4913-9ad8-54d1dea2d4b8@rowland.harvard.edu>
 <20261014191141.GxlJhR1e@linutronix.de>
 <89da3b1f-60e5-4f18-9592-3d6d7175c437@rowland.harvard.edu>
 <20261014220403.R38Gf0pW@linutronix.de>
 <de582feb-a0aa-4fc8-9818-890014de32a9@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de582feb-a0aa-4fc8-9818-890014de32a9@rowland.harvard.edu>

On 2026-10-15 12:00:46 [-0400], Alan Stern wrote:
> The existing kerneldoc documentation for URB completion callbacks is
> incorrect about the context in which the callbacks occur; it is not
> always in_interrupt.  State explicitly that a callback may occur in
> any context with no guarantees, and likewise for the status of
> CPU-local interrupts.
> 
> Documentation update only; no code changes.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

usb_hcd_giveback_urb() kernel doc says: 

|  * Context: atomic. The completion callback is invoked either in a work queue
|  * (BH) context or in the caller's context, depending on whether the HCD_BH
|  * flag is set in the @hcd structure, except that URBs submitted to the
|  * root hub always complete in BH context.

Do you think this deserves an update?

Sebastian
