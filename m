Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A42DA759;
	Sat, 11 Apr 2026 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775886659; cv=none; b=cKBHaPdW+vj/ymdI9NnF8Qt9LCmt1HPFOatVQvS9HKPme64IRueObGHR91p4a/WC0yMCnCOu6sqayRhW5sRx2jy82E0BPoQBoXFAjMQFHFbSeOEwQisNgPpceQrG5YtY7Ks7YLlNzNbw9mogKdDhIR5HHWajb0ckK+hukSybb0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775886659; c=relaxed/simple;
	bh=m2IzCTlOiwv+hki4ysKpca9iYxi/gwC2i0nMU9NVt6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0gh6JqRQlvX1vgdXbjEKLS7tS8i0HUFaj1oNthyqt5IOlhkeBUFR0PpC3NA1JajowB6jWVPZiVtUvFokFnJGKsUBbJMeatf07pDVUJec7N37RYvYMDSyqHz+YFmq0cXfVRCkP2v45fcDHCG19SSOH0j6AV2NMtSEu2vHYE8L6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iveGdYP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iveGdYP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B4AC4CEF7;
	Sat, 11 Apr 2026 05:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775886659;
	bh=m2IzCTlOiwv+hki4ysKpca9iYxi/gwC2i0nMU9NVt6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iveGdYP9Ilo1rgs/KIru/kWZv+Ts2XetTZYcGTzegxP67OjDtD/Wu9SVaVVTztHlX
	 hkhkFD0bmYrw3Kd9LM2mQbWJR7SkuSja4MJ36vA0fvIJnux9mL7If5OpgsGE4Ch2yt
	 MkUg8+NbSWnS+8q2xu7LcFJ2XMlZEk4tkZ2RGLSk=
Date: Sat, 11 Apr 2026 07:50:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: hugh@blemings.id.au
Cc: Kuniyuki Iwashima <kuniyu@google.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org,
	workflows@vger.kernel.org, yizhe@darknavy.com
Subject: Re: [PATCH net] netrom: do some basic forms of validation on
 incoming frames
Message-ID: <2026041135-shindig-trekker-5d06@gregkh>
References: <20260410145448.38253e3c@kernel.org>
 <20260410221220.1708137-1-kuniyu@google.com>
 <4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5810a7-c792-4d6b-9f7c-6c6b289def19@blemings.org>

On Sat, Apr 11, 2026 at 08:25:19AM +1000, Hugh Blemings wrote:
> 
> On 11/4/2026 08:11, Kuniyuki Iwashima wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > Date: Fri, 10 Apr 2026 14:54:48 -0700
> > > On Fri, 10 Apr 2026 14:30:42 -0700 Jakub Kicinski wrote:
> > > > On Fri, 10 Apr 2026 07:24:36 +0200 Greg Kroah-Hartman wrote:
> > > > > On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:
> > > > > > Or for simplicity we could also be testing against skb_headlen()
> > > > > > since we don't expect any legit non-linear frames here? Dunno.
> > > > > I'll be glad to change this either way, your call.  Given that this is
> > > > > an obsolete protocol that seems to only be a target for drive-by fuzzers
> > > > > to attack, whatever the simplest thing to do to quiet them up I'll be
> > > > > glad to implement.
> > > > > 
> > > > > Or can we just delete this stuff entirely?  :)
> > > > Yes.
> > > > 
> > > > My thinking is to delete hamradio, nfc, atm, caif.. [more to come]
> > > > Create GH repos which provide them as OOT modules.
> > > > Hopefully we can convince any existing users to switch to that.
> > > > 
> > > > The only thing stopping me is the concern that this is just the softest
> > > > target and the LLMs will find something else to focus on which we can't
> > > > delete. I suspect any PCIe driver can be flooded with "aren't you
> > > > trusting the HW to provide valid responses here?" bullshit.
> > > > 
> > > > But hey, let's try. I'll post a patch nuking all of hamradio later
> > > > today.
> > > Well, either we "expunge" this code to OOT repos, or we mark it
> > > as broken and tell everyone that we don't take security fixes
> > > for anything that depends on BROKEN. I'd personally rather expunge.
> > +1 for "expunge" to prevent LLM-based patch flood.
> > 
> > IIRC, we did that recently for one driver only used by OpenWRT ?
> > 
> > 
> If the main concern here is ongoing maintenance of these Ham Radio related
> protocols/drivers, can we pause for a moment on anything as dramatic as
> removing from the tree entirely ?

Sure, but:

> There is a good cohort of capable kernel folks that either are or were ham
> radio operators who I believe, upon realising that things have got to this
> point, will be happy to redouble efforts to ensure this code maintained and
> tested to a satisfactory standard.

We need this code to be maintained, because as is being shown, there are
reported problems with it that will affect these devices/networks that
you all are using.  So all we need is a maintainer for this to be able
to take reports that we get and fix things up as needed.  I know you
have that experience, want to come back to kernel development, we've
missed you :)

thanks,

greg k-h
