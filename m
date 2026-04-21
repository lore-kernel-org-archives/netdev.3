Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13821FB1;
	Tue, 21 Apr 2026 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757701; cv=none; b=RgdvhRHKSm3XJWo96rm4ivmvM2qFRgh7n9GXAg48Zkqp2i1LfgfaTT8nD1b75jIoT6b/rFS04aB7Vt4s+WCtaYz3WJQe5IJnEQE13mVj4/+i+SUFSbX9BJ27i8U04eZTutSD7TeUQ4ptKLgf4HWS7o7hAcp/Gwd5LcxAOwFzUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757701; c=relaxed/simple;
	bh=G+mQCHbtmTDChDG60HSgjhm7Jt3JbYhMxvOe5JNL/GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0GWTWp1sO3dBojV79ScNUqhsn+EhV2bu4/Hj2y7CpSepTx+6ETlsvT4REbsjI1rryzqGFZtSZLLcsPXDEkmE/LDjfXDy47YVlbLl4YU+RGH35LRqKjVvXVX8JnQWMlSnOhiJuz8S89zDn1cTrQ1ns2+MAMnfAYpReId9LhOzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=18vy0XGq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="18vy0XGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E83C2BCB0;
	Tue, 21 Apr 2026 07:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776757700;
	bh=G+mQCHbtmTDChDG60HSgjhm7Jt3JbYhMxvOe5JNL/GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=18vy0XGqdzRIJt3koJc0y5snOr+VYhd+PH6emVmmhh4pe0WP1wzD9YOHo2xN7iyjZ
	 leSP1OT5xq9Pc4zQlVQQ4GjhM3zk29s9noBS+PME/jFbFjSFq/MeKAYkQeShZHDhmc
	 tbAnBi+DgPTLcO8A6lrYHsP4vw1ALqY9kHl7ALlw=
Date: Tue, 21 Apr 2026 09:48:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org
Subject: Re: [PATCH net] ipv6: rpl: expand skb head when recompressed SRH
 grows, not only on last segment
Message-ID: <2026042116-subsystem-fascism-33f9@gregkh>
References: <2026042024-cabbie-gills-9371@gregkh>
 <20260421045510.1546375-1-kuniyu@google.com>
 <2026042140-drench-pursuable-37fa@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026042140-drench-pursuable-37fa@gregkh>

On Tue, Apr 21, 2026 at 07:50:45AM +0200, Greg KH wrote:
> On Tue, Apr 21, 2026 at 04:52:52AM +0000, Kuniyuki Iwashima wrote:
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Date: Mon, 20 Apr 2026 21:32:25 +0200
> > > ipv6_rpl_srh_rcv() processes a Routing Protocol for LLNs Source Routing
> > > Header by decompressing it, swapping the next segment address into
> > > ipv6_hdr->daddr, recompressing, and pushing the new header back. The
> > > recompressed header can be larger than the original when the
> > > address-elision opportunities are worse after the swap.
> > > 
> > > The function pulls (hdr->hdrlen + 1) << 3 bytes (the old header) and
> > > pushes (chdr->hdrlen + 1) << 3 + sizeof(ipv6hdr) bytes (the new header
> > > plus the IPv6 header).  pskb_expand_head() is called to guarantee
> > > headroom only when segments_left == 0.
> > > 
> > > A crafted SRH that loops back to the local host (each segment is a local
> > > address, so ip6_route_input() delivers it back to ipv6_rpl_srh_rcv())
> > > with chdr growing on each pass exhausts headroom over several
> > > iterations.
> > 
> > How could this occur.. ?  Did AI generate a repro or just
> > flagged the possibility ?
> 
> It generated a reproducer which caused a crash which made me have to
> create this patch.  I'll dig it out of the huge pile of mess that was
> sent to me and get it into a form that I can reply here to.

Ok, got the reproducer working, and it turns out that this patch does
NOT fix the issue, I should have tested it better.  Let me work some
more on this thing, sorry for the broken submission.

thanks,

greg k-h
