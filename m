Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766FD364028
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225557; cv=pass; b=IDsGALJNayuDGmoJNrtMZsAh2oSroF+/DqK/UggzIeWM6NHgMrToODH2kGkkOjQjHK3j+WlsIZP6/6n51ZvML3UDcIwffKPmfRs4me8vFwMXJkj+Gq6/c9mzImt5UPx+mHlD3lxTjKkTsLCEGvYCIp78sBX91kPdU8KsHVq2pJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225557; c=relaxed/simple;
	bh=dRq13dIqCuSaM4iNQ0cRPp1DLqd59r8XSwr/72LefU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2v8RkkP/y0cQQescocvX4bBpkuRDPHLfcjw+1k7vicILv5EpTV552ASqAmyFXyva2OX7GE+wP52bhHklVPF9pKq6huegn9FLWpG/z1HLyaUA37CpAZ14jVxQ29Hp5Y/JVgSc1kenDVS02piSLAupTPkrKTpESVaFlhQzfkKb8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=jP0Jy0ma; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="jP0Jy0ma"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so2130815a12.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 04:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787225555; cv=none;
        d=google.com; s=arc-20260327;
        b=WkChQAEFm9DMn4P2v0K5vijwx9OOoWT6QrXnz0SZfdPfY+SFLhful1mYoO0xmlL+Xd
         5+FfBs37ovPP2+R8u21MyTv/t1BQW9jMl+ELF00RVgSceEYssKa8NEgT1eCqMUYe/FB0
         O+dkcXqCWyy3YOUiYn1dG+n8eeNrKe80ZaZo1lmEVxFnN2GDZESBUNu6MlckLmcuKy8U
         eY/t6pJeXC8w4CoWOdsDGmnpXyDjiGsfQC/BfyKMdE0+RF7uuYogai7U7D2XsarxfysJ
         EOWWFlozIIEigp1akntVDvvYAiFpW76XfzB+fSblrntbEXjGXonX46b3d3J0P/I7VPrT
         9OUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=seOEiJSDW+vAuTWTVWJYpz2fC9mswqQWGaXYVjMOQ2U=;
        fh=Mo4jABy+Qqpu3ugugQfCi9Eaac8e5YZFLy7xCFbdG2c=;
        b=W3CHxn2a7SyLYxjM8hvvc/lDzehy4niguNgIFmXSHOyRDg0uxxB6at25+dXxHaDrHZ
         NFgKHHRzqZ9/2uilKgplwBoywphWGvw+2vYtGBmv/pfimcGpT6vpOhoIAWM7nnBtry0+
         sbb2EaQyPvBU/0HpD4DLcAtRIKUOEMFGeyVK8P4wmlI7kjTHj20myh8VHQwv6qq2uzDw
         VS2ST3xKduWjCjR1v/bX/bnKg1xJU3v4MAkOtWqqKvIwAtf4mbhvios+HKa/0ju2Bq/5
         bKiS8EOpVJVtw2D7nE6BtJsLdiKXgHe9YGWPLHNIurCPZaF9mElVw/7KdxSRsoIvf4S3
         6C5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787225555; x=1787830355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=seOEiJSDW+vAuTWTVWJYpz2fC9mswqQWGaXYVjMOQ2U=;
        b=jP0Jy0majf0okDi1rCkGZ0saSaWFBdy4ZXzEpGT9uK3sKlz25lxEUWQE4L1gcfYanf
         Y7QEGGQiuvBH7wjhoeFAz7tTi5cmVpZ3KbafT8SFpaIGjFjuAlinaFoLGuqcs+ncgPu8
         kW+6xvpJ9GVuLpqIKjq9dSm6iESdiYE1JQpGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787225555; x=1787830355;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seOEiJSDW+vAuTWTVWJYpz2fC9mswqQWGaXYVjMOQ2U=;
        b=K/Mfh9U6qc1ALjzR4Z1fABs435d2enQc7PldwD6hqVXS71hHyjhLMP57fKz/xeKoxO
         bT6A02tVpBUYA2omA+TYX3XRvk7xxAKY1e+Xlat00tOx23UrOS+Eu7/UIgsX+RuwTv/I
         tipwJCYqjeicp+IzH2OciMPHPHaQ7/X35P8cGsYYy2fbSaTBtMKm+ggsT1MHtcgaMIHK
         XTt2w53irVMosULcLTJ/XjNWnbfiKNMmP8AqTGzRVTdRv4fFRr+Wh6V/4ZsJtKAHlkQm
         dXJmnQp7SMsvlI6TA6lcPGo/zEg3Upi6kO7TRuyyeLVtGDIFSnmyF/Vd49+vTM+UaaTl
         QRyQ==
X-Gm-Message-State: AOJu0YyW/kdmHPSP/Fgfy0UQEkkAt9NbQOUGtA9gQgiqMdphWGOTShVG
	cNNDp99eMPnV+QOBjyJw2igB9RHJKY+s/nWUgngc9P6Hdjm+XQP2sOpFLxTWccrmN/HGvy+KI8v
	QGyVCdfQOqB3LxHT58K3mDt924iHYESMOcwUngWDH
X-Gm-Gg: AR+sD13uDVz8AOBVD7wqzUH9+TLPYMR0I1SIFvKfhWpzzAj5chDVu+JeotlY+wjQVUR
	8K2QmqlclQwKnxRP4rcAGZazXVqCinc83N65ysz11ZbdPhyEyrcozvVtPun2p+IO1U5tFYp6d/0
	ruV4HwLAm04V4rP8OE36u4PbX4BeKXQe6nwg2dcSmp+M+YyQchx7mYUf2yGZA8OG8jUWTbOZ3tR
	RvpiWmWJW5JTMyO2MyEcwblQSxxE2OOMOkwEyoeN/UtZd03mXc1KHKdqbNvBPEoissTHNzU+2/K
	90kCjdh4p59TSfjz0fe+5PGCGtefmdL7hv3rnL+x15iCTA==
X-Received: by 2002:a05:6a00:3a23:b0:847:8449:2ba6 with SMTP id
 d2e1a72fcca58-851d386377amr18669802b3a.8.1787225554720; Thu, 20 Aug 2026
 04:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819204210.23722-1-fw@strlen.de> <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
In-Reply-To: <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 07:32:23 -0400
X-Gm-Features: AcwNN1XLrJdPEHnzO7V4-rA3ehiOFgxI3nMvblxZLSOwP1UP8NxJpLMKRdpArgE
Message-ID: <CAM0EoMmaXyX+SMMLzE=6pka3p8a1EFatDX+L171XE6qGfTP+kQ@mail.gmail.com>
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 7:09=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Hi Florian,
>
> On Wed, Aug 19, 2026 at 4:42=E2=80=AFPM Florian Westphal <fw@strlen.de> w=
rote:
> >
> > This series removes skb <-> conntrack mapping after pedit
> > altered l3 and/or l4 headers.  See patch 2 for all the details.
> >
> > First patch makes tdc.py work for me, second patch is the actual
> > fix, third patch has test cases. Last patch also removes the mapping
> > in act_nat.
> >
>
> I apologize for the delayed response in the private exchange, but let
> me repeat my thoughts here...
> As you said, the munging can be done by an ebpf program (at different
> attachment points, not just cls/act using multiple helpers).
> In your commit you say:
> "Packet rewrites are still possible with BPF. However, unlike pedit,
> that needs privileges in the initial namespace."
> That's only true in the default setup, but with BPF "token delegation"
> it no longer holds (will be reachable via unshare -Urn).
>
> I have not tried to verify what i am claiming since we "last talked" -
> but could try it out when i get time (weekend looks promising).
> If what i am saying is true then you will have many places in ebpf to
> fix, which is not ideal.
> But even if not true, you can still do it with CAP_BPF - which leads
> to the same outcome. Unless we are saying as a general rule we should
> prioritize where/how we fix things based on whether they are
> reproducible via 1)namespace -urn  vs 2) require root permission
> (assume this includes CAP_BPF)
>
> With that thought in mind, the question is: is there a single hook
> entry point where this could be done?
> Example: nf_conntrack_in() or nf_confirm() as the choke point which

sorry, my brain wouldnt let it go: nf_confirm() looks very promising.
I was tempted to create a patch and test it but i dont have time right now.=
.

cheers,
jamal

> catches all? i.e check the protocol consistency there and if there is
> a mismatch you call nf_reset
> I understand the dilemma: fixing this in both pedit and eBPF will
> penalize only those hot paths as opposed to this approach which will
> penalize all of contrack users with no interest in pedit/ebpf - but
> otoh, I feel like this will be a good defensive mechanism for
> netfilter for whichever new creative change in the kernel which could
> be used to make similar changes.
>
> I could experiment with the single choke point approach on the weekend
> - let me know.
>
> cheers,
> jamal
>
> > Florian Westphal (4):
> >   selftests/tc-testing: pass mp_pm via initialiser
> >   net/sched: act_pedit: drop conntrack on network/transport header chan=
ges
> >   selftests: tc-testing: add act_ct test for ct reset handling
> >   net/sched: act_nat: discard any conntrack entry post modification
> >
> >  net/sched/act_nat.c                           |   1 +
> >  net/sched/act_pedit.c                         |  21 ++-
> >  .../tc-testing/tc-tests/actions/ct.json       | 168 ++++++++++++++++++
> >  tools/testing/selftests/tc-testing/tdc.py     |  27 ++-
> >  4 files changed, 208 insertions(+), 9 deletions(-)
> >
> > --
> > 2.54.0
> >
