Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0855537DE81;
	Fri, 10 Apr 2026 10:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816912; cv=none; b=g7PbBAeQGrcgOeqGCPZdoYkXMcgA8PEIwhkb+MukiX7SSCB6Uihv21wkyOJKgYvan5tcaAonoDyrTwdP7dt+HsyDlBHpCRO776Fvd1eYkEnSsrn7+1mL2vUNFMWXhM+eboretdPM6qMK6tdyoskXqBYo0ibZR3dFm6zRerL+jbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816912; c=relaxed/simple;
	bh=evFuOJspE7UTTSF9DREpgNuK2GUXs3TlE+bzd02GoWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iC6czD5rIEtP2chR0EeHCjCqrGrnnYlZILr5WU2wvB8xR9D98HDrvZ40dd/EpW7NbHJROwe64wrUXA4mIwI6LU91v8Xfl4JhFyniDRObfVRyLyYzYRtNEL8LCeKCtoWC8AQM2R/p0YOmJCtJxLH7K+R7ITJp3KqbSzjWQpD7Isk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0mpVWo5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0mpVWo5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3122C19421;
	Fri, 10 Apr 2026 10:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775816911;
	bh=evFuOJspE7UTTSF9DREpgNuK2GUXs3TlE+bzd02GoWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0mpVWo5Kh9jZB558akSRe8MfnYkNDX72Fq9HoWXHmthJOzSmgai0TQhA6H+GDj3/
	 HGsPMCXnjtNUB0oL/oP9pr5rcmAXQ+Ql4DpbQHpxJbC/f6agmMckZbRLvT4q7tMk6F
	 LX9jXjrkvzOf9nf1fOJwth/3Hwy3xIzjctSGfb2+pWOwJbiiUEUmYpen4fvFOlgoyV
	 EK5JrSMByWHO5DsobylAaN15SP8v0Ojc3Zw/4fJaCkAVn6+DIu+VKZ/RgXZdBF9H7a
	 7VMY3U03vBVW0yMEAJ/26hYk3j4JJXQDLDBV/kgdJp3ci1WNhqfZhmiEpJfnoepUSJ
	 AHbbTu2pusd7g==
Date: Fri, 10 Apr 2026 11:28:27 +0100
From: Simon Horman <horms@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-hams@vger.kernel.org, Yizhe Zhuang <yizhe@darknavy.com>,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] netrom: do some basic forms of validation on
 incoming frames
Message-ID: <20260410102827.GT469338@kernel.org>
References: <2026040730-untagged-groin-bbb7@gregkh>
 <20260409190328.GS469338@kernel.org>
 <20260409203235.6b9329f0@kernel.org>
 <2026041026-excuse-slashing-c4ee@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026041026-excuse-slashing-c4ee@gregkh>

On Fri, Apr 10, 2026 at 07:24:36AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:
> > On Thu, 9 Apr 2026 20:03:28 +0100 Simon Horman wrote:
> > > I expect that checking skb->len isn't sufficient here
> > > and pskb_may_pull needs to be used to ensure that
> > > the data is also available in the linear section of the skb.
> > 
> > Or for simplicity we could also be testing against skb_headlen()
> > since we don't expect any legit non-linear frames here? Dunno.

Sure, that's find by me if it leads to simpler code than
using pskb_may_pull(). Else I'd lean towards pskb_may_pull()
as it is a more general approach that feels worth proliferating.

> I'll be glad to change this either way, your call.  Given that this is
> an obsolete protocol that seems to only be a target for drive-by fuzzers
> to attack, whatever the simplest thing to do to quiet them up I'll be
> glad to implement.
> 
> Or can we just delete this stuff entirely?  :)

Deleting sounds good to me.
But we likely need a deprecation process.
In which case fixing these bugs still makes sense for the short term.
