Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B65331A56;
	Fri, 10 Apr 2026 05:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775798679; cv=none; b=NlARJY6mE4r0oTsGarC6IxEgFDS6SevI7hKURxzM+6QoBJa5YoaTAvfLYnCQc05gSXFf/ZBLxQMTBcGbLIoi8bc1arqm+ytMMdbVnzpVJtadn225HxJhpWh/NxnZ6gxSytIQVF3kBUlfvxwSyntieTRJokdiTbQP1Ki5+jAtqdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775798679; c=relaxed/simple;
	bh=f3VDS2U4yNAj47bx0fM6G28chp8B29iQfXBTLcjw7OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwOA6eoecCC+gfH9cTfmm6BA9pXf4vXLZH7Q6EgUdSjh3V5YdG2koXPINQQgenV8qjRsDccqSW/6o09az3ZMNA1vWe5dHCbD1b7irJPBlI9uR0BflDipXqOhhtYTtjOS+yox+kkYEnB5h9Bxk6m9N1jjpvLVNJn9eNwwF1CkL1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1zuOqIwZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1zuOqIwZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4349C19421;
	Fri, 10 Apr 2026 05:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775798679;
	bh=f3VDS2U4yNAj47bx0fM6G28chp8B29iQfXBTLcjw7OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1zuOqIwZMGxFBwP5E3e9xRW07VeSl10ozJn91q11PmfGghSQ/NyadgodrYOhzolzK
	 QtnvisERt4tUw1pHpT8+/LZivmEabZ+f/DBhvEwpsCAooHWccHSlB1CRVMciRDaW4H
	 1T8ShgtHwMLQX0ORnU954LPWYamBq0OA9p2+new0=
Date: Fri, 10 Apr 2026 07:24:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, Yizhe Zhuang <yizhe@darknavy.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] netrom: do some basic forms of validation on
 incoming frames
Message-ID: <2026041026-excuse-slashing-c4ee@gregkh>
References: <2026040730-untagged-groin-bbb7@gregkh>
 <20260409190328.GS469338@kernel.org>
 <20260409203235.6b9329f0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409203235.6b9329f0@kernel.org>

On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:
> On Thu, 9 Apr 2026 20:03:28 +0100 Simon Horman wrote:
> > I expect that checking skb->len isn't sufficient here
> > and pskb_may_pull needs to be used to ensure that
> > the data is also available in the linear section of the skb.
> 
> Or for simplicity we could also be testing against skb_headlen()
> since we don't expect any legit non-linear frames here? Dunno.

I'll be glad to change this either way, your call.  Given that this is
an obsolete protocol that seems to only be a target for drive-by fuzzers
to attack, whatever the simplest thing to do to quiet them up I'll be
glad to implement.

Or can we just delete this stuff entirely?  :)

thanks,

greg k-h
