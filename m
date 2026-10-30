Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380119;
	b=N13BWH1d8QM7qguGT7sjqJSlb2lJV3E7voAJmOLzR+SAPXPkqsEFPScin7R5dq8dhm+B
	 +Sl7ceChxX5S5GmjuGVhePX33Vlf8uM95ucHnjEpZbEGJoHkgmrzRPcEwFzDwMVST2pBX
	 fUF7EopL1udJM+RMvJscYaLLQkpId365rLe7Fg9OoyxDmE7dA/UsxkK197EB0vaCT6kTw
	 sOovhgmslg13LnJCy6m2wgdmAtiCvW9pNzHVI11ocZ2LvU2NaSgXwHe3yF8yMZyNN3Dbq
	 OtEuk5M3QuQF3gUIEfANVWyZmzKLy6rmfuOacu9mzfqoLNUVk2jXCwhWYLF9slpWOhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380119;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5QPxXc2iT5IOfiNRxRgY0SNb9uFL3f4Z0lDxWCP0+kU=;
	b=4u0ar0vbsqACJj40W1lrpphtF/BIG+zwjZCeyI1G939zw2zEDF81/ekefM/k+g5bhYg2
	 pxn3Yrxk+x9K0UxuF5Cn9rhCRv5bEU3ZDrYKKAMuIWo3u07vuwoSQgJbccwQ5MLL6YkYK
	 oZt3tz42F4Kn7EimLIDeVWFSOeAbd5rpJWFdFmzOD+QQxrM84tlPlSy8ztKptZR2kdWDv
	 XmZbAbmvineG4wFt+hrTzW6ht2NSfPi9DK81K627a/Zz5Xu984Y4e0ZyEB6wi8K+sxxfK
	 RWokk2jKOW9VUZbKuzk0QyTfGIAnRPOfooKFL2ox8F63XA7kYcD5EiueZ4ZKl50eyfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mgmvo52N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984F606A330;
	Fri, 30 Oct 2026 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mgmvo52N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8132D1F00A1A;
	Fri, 30 Oct 2026 17:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793380118;
	bh=5QPxXc2iT5IOfiNRxRgY0SNb9uFL3f4Z0lDxWCP0+kU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mgmvo52NKv45K2oTpEQQ3xKvYbQ/Xnoxa3RMV4qsMIHtWfpBImK4HXg7bidr1jNDt
	 D/kwvH6hfOZZpwd+W4Ec8s6vptHEy5rWnsR9c/DgYYOKo1l0K0zSQ/9VmNkGzMWjh7
	 9o3CdnqSP6aBZ2qP10ZIJBJIUArfPV69djJugv5em4jWHsiGpA7ul2XmozWYqVXsue
	 C+c6f+4uYRrCTSfYgZ1kg9URkaU3RzEoBwuZq6H28rqRxorW3WgDIANexqLbduxtY/
	 eX/wEHsh7Cmjn1HOdfZKkqknJkTKcVxYon5giHD9WYAx+CvLVvRj+3WALl/00JsImz
	 nw4QgxOPrZZJQ==
Date: Fri, 30 Oct 2026 10:08:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Nicolai Buchwitz
 <nb@tipi-net.de>, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: try to force agents to disclose info
 for fixes
Message-ID: <20261030100837.0f4e7d3d@kernel.org>
In-Reply-To: <20261030164758.GD2673734@killaraus.ideasonboard.com>
References: <20261029153459.2257998-1-kuba@kernel.org>
	<9A74CA14-D4C0-4252-A3E7-256F9626B513@tipi-net.de>
	<CAMuHMdVJVxpX6OLVpE9K9CDY5q61A2rFGf7FpUjs7xpFwReEzA@mail.gmail.com>
	<20261030093418.2fbf0999@kernel.org>
	<20261030164758.GD2673734@killaraus.ideasonboard.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 18:47:58 +0200 Laurent Pinchart wrote:
> On Fri, Oct 30, 2026 at 09:34:18AM -0700, Jakub Kicinski wrote:
> > On Fri, 30 Oct 2026 11:58:17 +0100 Geert Uytterhoeven wrote:  
> > That's already in the existing text?
> >   
> > > Which is true for anyone, not limited to bots...
> > > 
> > > Do we really need "different" guidelines for humans and bots?  
> > 
> > Looks like at least a half of the commit messages today are
> > bot-written. With the existing guidance the bots don't add
> > the requested info by default (presumably since they don't
> > know the information). If this patch doesn't help we may
> > need to add our requirement to coding-agents guide.
> > They seem to be reading that one fairly reliably.  
> 
> Is there no way this can be tested without being merged upstream ?

Of course it was. But I can only "test" something trivial like asking
Claude to do X. I can't tell whether the random free-model-using
or completely hands off bot will pay attention.

> Tweaking documentation in semi-random ways in the hope that some of the
> changes will have an impact doesn't seem to be a good process,
> especially if it's to work around defect of tools.
> 
> And unless I missed something, I thought there was a general consensus
> that documentation should be written in a way that doesn't reference
> agents specifically, as the same behaviour is expected for all
> submissions regardless of how they're generated. Has that changed ?

We're talking about a patch to maintainers-netdev. Let me experiment,
please. 
