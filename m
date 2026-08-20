Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4343D503
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 12:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787227800; cv=none; b=OsIEZGafgpoIiuu5f64OLW2jdWIK5n53rgtRihEpYtSEHQPmwDHE7FmlCOPgzLCVz4dKv3T990af3pjqS4wMcboJ1fmkqVPAC6wAesTVFeDTc5GXJLbEw+6kvMnRhXth3JvfBJwl2auJ2orHQb+nG70PLt6VeUyBtYgX8q5LGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787227800; c=relaxed/simple;
	bh=11OT2Bo07i4VhSxw6ZHo0Q5a/iTMM4FMy39qMeR3SLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWETvXoA+/8q+xOo4VYzOtTlegBfOtfZq3n6/hSgdz/tZIIKikXpMaL69bOkCgEm9KUmkxtIYajqcPS3HcAraTNpXjcvhARN+4fmz1scQWCTk3foFNmLN+Nq5QWc3vVVxYFSG+wTJ+lYU8hQOvzn0cnNVmA16FhUIq+8AIrU3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CCA6360232; Thu, 20 Aug 2026 14:09:55 +0200 (CEST)
Date: Thu, 20 Aug 2026 14:09:55 +0200
From: Florian Westphal <fw@strlen.de>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
Message-ID: <aobuk1osK-Lq-aMk@strlen.de>
References: <20260819204210.23722-1-fw@strlen.de>
 <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
 <aoboL020DIcOn2lx@strlen.de>
 <CAM0EoMnvz6A_v65s=jcdw5nxL6N2+yd7ZBvp78mtt7edkPe-sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMnvz6A_v65s=jcdw5nxL6N2+yd7ZBvp78mtt7edkPe-sw@mail.gmail.com>

Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> Example: If the ebpf one could be reproduced with unshare -urn would
> it have been fine to make the fix sit in netfilter?

I don't know how to 'fix netfilter'.  We would have to remove skb->nfct
and re-parse at every turn.  Is that a viable option...? Don't think so.

> > And that doesn't solve BPF (can sit anywhere) or OVS (no idea here if
> > its affected or not).
> 
> OVS is very likely affected.
> I saw your other email and you are the expert, but I am itchy to try
> the nf_confirm() approach.
> At minimal it should fix the PoC imo.

As I said, I don't see any existing function that could be used
to add the required re-validation.  nf_confirm() is the last step
in the pipeline, its way too late.  nf_conntrack_in() doesn't work
either because you can install matches earlier than that, e.g. via
-t raw -m conntrack in classic iptables, or via 'hook prerouting
type filter priority -2147483647' or something like that in
nftables.

The only other option is playing whack-a-mole, accepting the original
proposed patch for nft_ct, but I can already tell this will not be
enough and revalidation will have to be added everywhere.
