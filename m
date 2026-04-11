Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5795326D75;
	Sat, 11 Apr 2026 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775906788; cv=none; b=SS/UCcQPMNF0+w23z6NtvAJyWm4hsxXvApCAWy2SU6oIuLs7n/Psri4OkZlSw4FFBlO4g0FM4bcYeDJf1oZwMzJimD+X+6EGaAZf61+tUXJER+meer0zJl8PeCfiVPbEbRRTLVdee9lcOqaFTz7RCDPk8LbAv3uFL+oxhgM5BUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775906788; c=relaxed/simple;
	bh=nVdnL04IoseIejXejdtyR67P9ZFZfV9suhqWiHwxLaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdIYVbeJ4SA2N+Swbp/JEyw7wAO93upNiUETWSkmNllwEyQbDNmk7HTFO5ttSR29gBzsmzRXjUV5mFzsZy+fUaqzhFpN/21pRiruL8LH7Rcy1qOPWpIh35ZQNOW0NSYlkof6A85J/Jkv8D1pA91fERn+m+UvzpXiPzAlOeEat6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r8MJ8HWg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r8MJ8HWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84EFC4CEF7;
	Sat, 11 Apr 2026 11:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775906788;
	bh=nVdnL04IoseIejXejdtyR67P9ZFZfV9suhqWiHwxLaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r8MJ8HWgI9c4eVV+SFcKgdmIFmKAr92uD0Ej55xbjAg9k9dFif5ZT9zzi3X4dxTKX
	 Y5FuR3J00TIOMAaUR/V+zdq1WfFwNW/C/fPLa4sewNyf92IqboADjpiil8sKeiIrdO
	 6PCoAOhNIImuXJqJ5aKINUJBx+z2PtcjXFyPsm10=
Date: Sat, 11 Apr 2026 13:26:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] xfrm_user: fix info leak in build_mapping()
Message-ID: <2026041120-diocese-boxy-b08b@gregkh>
References: <2026040602-shack-tamale-d8c3@gregkh>
 <20260406085449.266466ae@kernel.org>
 <20260406085859.2e9843ea@kernel.org>
 <2026040634-deodorant-shakiness-a64e@gregkh>
 <20260406103851.59a200fc@kernel.org>
 <2026040745-crafter-awkward-8901@gregkh>
 <20260407181211.5419f2cc@kernel.org>
 <adYgIr5vlORzWqi7@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adYgIr5vlORzWqi7@secunet.com>

On Wed, Apr 08, 2026 at 11:30:10AM +0200, Steffen Klassert wrote:
> On Tue, Apr 07, 2026 at 06:12:11PM -0700, Jakub Kicinski wrote:
> > On Tue, 7 Apr 2026 07:51:15 +0200 Greg Kroah-Hartman wrote:
> > > > > I guess nlmsg_append() would work?  It tries to do some zeroing out for
> > > > > alignment for some reason...
> > > > > 
> > > > > Want me to do that?  I don't have a way to test any of this, I just
> > > > > found it using some static code analysis tools that looked at holes in
> > > > > structures.  
> > > > 
> > > > Do you have any more Netlink leaks in the queue? If you do let's do it,
> > > > if you don't we can wait until the next victi^w patch to arrive.  
> > > 
> > > I do not have any more, sorry.  So is it worth it for just these 2?
> > > Your call :)
> > 
> > These are fine. I would have applied but I think Steffen will take them
> > via the ipsec tree first (LMK if that's not the plan, Steffen)
> 
> Both patches are now applied to the ipsec tree. Thanks a lot!

Wonderful, thanks!
