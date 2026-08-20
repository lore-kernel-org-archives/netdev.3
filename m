Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB0439F72
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226178; cv=none; b=TOHqhSb+b9xKtBJJ9yBaPtoLElXd8EkWvDOTYYNj37bHu+7392+IQUERTw8sHO58hbgaBHqTy698nmSLChIM88y9CZIi/XC2nI4LmFlLobK3ChCOpG9eW0oV/SR958mAoEwQWE0tRibcpM7XQHKjJAuHwpApjN5fcjYAalR86no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226178; c=relaxed/simple;
	bh=6g2Z8OoHrelqOqHHQ0XMWpPizJh2MIHj5ntuzf4I0eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raVTuhddICy7IJ9y1Zx4/qthh9VKrq96dP19vPT++xIaD2dm6gt5a/3RQ6h1HutOzFz4UUNxGy8V9QnN3RiIe4unRBDWopvj69mYHzDVF4FXZddbk3delzVZidqf8dPWvQL9XNENHskpMY5yh4UFCKUet/fhbjU85Z9POFL9kxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 43BC560225; Thu, 20 Aug 2026 13:42:46 +0200 (CEST)
Date: Thu, 20 Aug 2026 13:42:45 +0200
From: Florian Westphal <fw@strlen.de>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
Message-ID: <aoboL020DIcOn2lx@strlen.de>
References: <20260819204210.23722-1-fw@strlen.de>
 <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>

Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> I apologize for the delayed response in the private exchange, but let
> me repeat my thoughts here...
> As you said, the munging can be done by an ebpf program (at different
> attachment points, not just cls/act using multiple helpers).

Yes, and that is ALSO buggy.  For BPF its even worse because if you
permit arbitrary writes at any point in the stack you will also
invalidate e.g. addresses/offsets stored in skb->cb[].

> "Packet rewrites are still possible with BPF. However, unlike pedit,
> that needs privileges in the initial namespace."
> That's only true in the default setup, but with BPF "token delegation"
> it no longer holds (will be reachable via unshare -Urn).
> 
> I have not tried to verify what i am claiming since we "last talked" -
> but could try it out when i get time (weekend looks promising).
> If what i am saying is true then you will have many places in ebpf to
> fix, which is not ideal.

*shrug*

> But even if not true, you can still do it with CAP_BPF - which leads
> to the same outcome. Unless we are saying as a general rule we should
> prioritize where/how we fix things based on whether they are
> reproducible via 1)namespace -urn  vs 2) require root permission
> (assume this includes CAP_BPF)

I think 2) is very different from 1).

> With that thought in mind, the question is: is there a single hook
> entry point where this could be done?

No.

> Example: nf_conntrack_in() or nf_confirm() as the choke point which
> catches all?

Those are too late.  You would need a new, unconditional sanitizer hook
at INT_MIN, in all of IPV4/IPV6/Bridge, plus additional code in core.c
to refuse installation of custom hooks before the sanitizer hook.

And that doesn't solve BPF (can sit anywhere) or OVS (no idea here if
its affected or not).
