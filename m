Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38B45518E
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247436; cv=none; b=urwtlvMMYlLlhe3+TK4BD8UWFLrx+0nRb93uJDcuKMUF2wobg1uYf2AyIa5VSxX8ZVtbiAxZ+i7dJdnGmvRTV+eaAmiD7VDfjpZAbNK9dO4OrLcE/ITQCwVsxgOLjqV9vMHpLdnFtAeMP4ioepCBQn6wYgCRu01SpBEqi4jNcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247436; c=relaxed/simple;
	bh=RKq1hs36OjpYh6mw1KYDqL8GrooKFxhKDwfXsUdy4M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhXtP/ZS9BqmCSO1OCcZNvE/nFreoy/TPBYWuyUcyYesWnOQ02N9D4pYeLRISS2OPOyIB9k9USVDpXDDEV3O8lLKw8t/P2Taf43g1iPh4mHZdB9xA6410juAZcBuSTA8lvVzSc1eI+dfD9GIxNmBsRGlXTMiBKdil157WnNjhO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2160660424; Thu, 20 Aug 2026 19:37:11 +0200 (CEST)
Date: Thu, 20 Aug 2026 19:37:10 +0200
From: Florian Westphal <fw@strlen.de>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
Message-ID: <aoc7RqoGX09plRrt@strlen.de>
References: <20260819204210.23722-1-fw@strlen.de>
 <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
 <aoboL020DIcOn2lx@strlen.de>
 <CAM0EoMnvz6A_v65s=jcdw5nxL6N2+yd7ZBvp78mtt7edkPe-sw@mail.gmail.com>
 <aobuk1osK-Lq-aMk@strlen.de>
 <CAM0EoMm8G9FaZZfctYKsm4Rkd3RVmVxkWMp6zJ1Gbxge5hdp0A@mail.gmail.com>
 <aob8wQn2EuI2N-BO@strlen.de>
 <CAM0EoMnLj_5HQrxSWPhJcks1bedi_OMEr6-_=q2+c_cWDn=8Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMnLj_5HQrxSWPhJcks1bedi_OMEr6-_=q2+c_cWDn=8Cg@mail.gmail.com>

Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > Yes, e.g. what if pedit inflated th->doff?
> > nf_conntrack_in() checked that this was fine, but now the pipeline
> > can re-neg on that.
> 
> True.
> So my question to you then is: what about BPF, OVS, future thingy? Are
> you going to fix each individually?

I see no alternative?  I mean, what are you suggesting?
We can apply the patch from Kyle, that will stop the reproducer.
But I can tell you that we'll need hundreds of followup patches
all over.

I mean, we always relied on IP stack having checked that iph->ihl is
fine, the ipv6 header is complete, etc.

And that isn't exclusive to netfilter.

My best suggestion is to remove skb->_nfct and reparse everywhere,
but I will NOT make such a patch, IMO conntrack and netfilter might
as well be axed then.  Hey, would solve a few bugs.
