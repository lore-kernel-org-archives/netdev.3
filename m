Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271671FFC48
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882121; cv=none; b=inbsdmNsU9XbHGfQAT7CIW/1qO/DWnDvJl9FwdHrtWK3rWBZwHsNe9ttBAE1eMRUAtWPAOYFhwfq2qy2DZodDMWj/gKK5g1WegYJa3I16ZVzdkiFr1OovjUUiH+pTtX6GhbeWJtUMfKklJMOHU7GvxvNNia7nga+ZQE9FCwllj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882121; c=relaxed/simple;
	bh=18af7teQ6GGOCpMJgIzs0axiyfNsKf77QTG/zx6JHq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fd0UHUaWZ8yzxtF5kID+BDbe+noEWPxvGNcz0CAC6YyzvtY2qLzttaC639SBr7ftRilCUgTv0FTA7eQLyfNJ1oi3vIMjJSKjVTWpClPsykrJs9icMmXZy35P5YbB9CkwQB1/9UCfM2bvUOl82/B2mIIqX7lLZMdw3N5KAt1gnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apxK2Bpq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apxK2Bpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2471B1F000E9;
	Tue,  4 Aug 2026 22:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785882119;
	bh=Wve2YHLJ3jpeg8sGpgA6qgpjFFHpdYkGxDBuIVWLn30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=apxK2BpqHvlIJew6/LXE3C5U/N0wPZ3qQg4Nj/maqx4OOWFi1nJwMylkAUZo43K9G
	 zCkZbifwOcOmHiStTZPFZrLzQQOtvd1LlDxIBM9FmWPHvlvxFEHgQ0Voo9wvo4k8h6
	 huJsCzcnNvXV2GiPH+2UGEeNp5foqu37bWYLVXp8rS2IfOGdk/dpX3eLJEum4Kd8pj
	 XKwPgxGeRQ2p57hUtw5j1A6BqmN0XRWUgXwsNrNRKCBmBtIFeCTccuN8ULVyCm1Hxt
	 zuqCpXNL6H/9L37fTa+MFJEhKNluoEIFP8tepgS9YbLjJrZmwa1sNrfKtQB6itESwc
	 uxAG+n0iHLTRA==
Date: Tue, 4 Aug 2026 15:21:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Ido Schimmel <idosch@nvidia.com>, Ren Wei <enjou1224z@gmail.com>,
 ncardwell@google.com, netdev@vger.kernel.org, dsahern@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai,
 edragain@163.com
Subject: Re: [PATCH net 1/1] ipv4: reject RTAX_ADVMSS values below
 TCP_MIN_MSS
Message-ID: <20260804152158.3b15bf39@kernel.org>
In-Reply-To: <20260730133546.GA1761428@shredder>
References: <cover.1784972917.git.edragain@163.com>
	<a2e93ae9003f33bf49b789dbd537f4a6c10f26fa.1784972917.git.edragain@163.com>
	<20260730133546.GA1761428@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Eric!

Welcome back! This patch is waiting on your input, when you have a sec..

On Thu, 30 Jul 2026 16:35:46 +0300 Ido Schimmel wrote:
> On Tue, Jul 28, 2026 at 01:08:17PM +0800, Ren Wei wrote:
> > From: Yong Wang <edragain@163.com>
> > 
> > ip_metrics_convert() only caps RTAX_ADVMSS at the upper bound and
> > still accepts undersized non-zero values from userspace.
> > 
> > A route installed with "advmss 12" can later reach the passive TCP
> > open path. When SYN timestamps are enabled, tcp_openreq_init_rwin()
> > subtracts TCPOLEN_TSTAMP_ALIGNED from the route advmss before calling
> > tcp_select_initial_window(). This can reduce the effective MSS to
> > zero and trigger a divide-by-zero in the rounddown(space, mss) path.
> > 
> > Reject non-zero RTAX_ADVMSS values smaller than TCP_MIN_MSS while
> > keeping the existing "0 means use default advmss" behavior intact.
> > 
> > This matches the existing TCP_MIN_MSS based validation used for
> > TCP_MAXSEG and fixes the bug at the route metric input point rather
> > than adding a redundant guard deeper in the TCP stack.  
> 
> Eric / Neal, the comment above tcp_select_initial_window() says:
> 
> "[...]. We assume here that mss >= 1. This MUST be enforced by all
> callers".
> 
> AFAICT, tcp_openreq_init_rwin() and tcp_connect_init() are the only
> callers that subtract the size of the timestamp option from the MSS
> without validating the result.
> 
> Fixing it there also takes care of the comment from Sashiko regarding
> RTAX_MTU:
> 
> "If an unprivileged user sets the namespace specific sysctl
> net.ipv4.route.min_adv_mss to 0 (which is accessible due to an exporting
> flaw) and adds a route with an MTU of 52, the IPv4 stack evaluates the
> default advmss as max(MTU - 40, min_adv_mss), yielding 12.
> 
> [...]
> 
> Should a similar lower bound check be enforced for RTAX_MTU during
> netlink conversion to prevent this bypass?"
> 
> Do you prefer to fix this in TCP?
> 
> Sashiko link:
> 
> https://sashiko.dev/#/patchset/a2e93ae9003f33bf49b789dbd537f4a6c10f26fa.1784972917.git.edragain%40163.com
> 
> Patch link:
> 
> https://lore.kernel.org/netdev/cover.1784972917.git.edragain@163.com/
> 
> Thanks
> 
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:GPT-5.4
> > Signed-off-by: Yong Wang <edragain@163.com>
> > Signed-off-by: Ren Wei <enjou1224z@gmail.com>
> > ---
> >  net/ipv4/metrics.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
> > index ad40762a8b38..b9b97a0a5126 100644
> > --- a/net/ipv4/metrics.c
> > +++ b/net/ipv4/metrics.c
> > @@ -44,6 +44,12 @@ static int ip_metrics_convert(struct nlattr *fc_mx,
> >  			}
> >  			val = nla_get_u32(nla);
> >  		}
> > +		if (type == RTAX_ADVMSS && val && val < TCP_MIN_MSS) {
> > +			NL_SET_ERR_MSG_ATTR_FMT(extack, nla,
> > +						"Invalid advmss, must be 0 or >= %u",
> > +						TCP_MIN_MSS);
> > +			return -EINVAL;
> > +		}
> >  		if (type == RTAX_ADVMSS && val > 65535 - 40)
> >  			val = 65535 - 40;
> >  		if (type == RTAX_MTU && val > 65535 - 15)
> > -- 
> > 2.53.0  
> 

