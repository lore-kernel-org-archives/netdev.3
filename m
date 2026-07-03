Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E430D3F2
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783051126; cv=none; b=QMa+j9OkBwLaB9IGfLZk6gmfxsEv99tg/dY9NIZupLAeSNFtYRGAXs1GH+bS7ZggBtVqeHTX10YZ2GH9Xc1OEYtpMuJE2+4pkp/aBtcGiF0HHNgUEBK3AIIW6Ivtait7UABpes16+gnJ0PAYfCBleYlmFJ6Z5znSmd5a13naRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783051126; c=relaxed/simple;
	bh=Ptmdr3m3TN0HVotuHSov19ADnJAk7vXm3Hbsa6mfsjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vmt4My8X/To49Hkw9JEl/pNDeQxobOxwBnhbTE2eQrhEziX28jp8+42Omssd393MBlhXtaYXcjbvIS4HYehXVYHTLcYW6uHS68CXpiAQnSgmn2iOilbbYwV+GORF8ES1ZWfYt+aCBFXU9XNXo0GRdfOEo2N2jxhQiOgU/PruGhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5D911602A9; Fri, 03 Jul 2026 05:58:28 +0200 (CEST)
Date: Fri, 3 Jul 2026 05:58:28 +0200
From: Florian Westphal <fw@strlen.de>
To: Xiang Mei <xmei5@asu.edu>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, netdev@vger.kernel.org, horms@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
	kys@microsoft.com
Subject: Re: [PATCH ipsec] xfrm: policy: use hlist_del_init_rcu in
 xfrm_hash_rebuild to avoid bydst poison
Message-ID: <akczZMzVg7l6tUnU@strlen.de>
References: <20260702185805.615241-1-xmei5@asu.edu>
 <aka5pwAGGI56QrrS@strlen.de>
 <CAPpSM+RshE2OFZCJjM0mRumWt3cixu9QBNh+rmS0z=AKPR25LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpSM+RshE2OFZCJjM0mRumWt3cixu9QBNh+rmS0z=AKPR25LQ@mail.gmail.com>

Xiang Mei <xmei5@asu.edu> wrote:
> Agreed, and my patch hides it instead of avoiding it. The problem is
> the prep loop's guard is inverted:
> 
>         if (policy->selector.prefixlen_d < dbits ||
>             policy->selector.prefixlen_s < sbits)
>                 continue;
> 
> That skips exactly the policies reinserted via the tree (prefixlen <
> threshold => policy_hash_bysel() NULL => xfrm_policy_inexact_insert()),

Indeed.

> locates for the exact ones instead, which never allocate and get
> pruned again at out_unlock. So the inexact bin/node is allocated GFP_ATOMIC
> after the hlist_del_rcu(), and that's the failure the WARN catches.
> 
> The reproducer lowers then raises the threshold so those bins are pruned
> and reallocated during reinsert; failslab just makes the failure
> deterministic, OOM would do the same.
> 
> v2 inverts the guard so prep prepares the set that's actually reinserted:
> 
>         -       if (policy->selector.prefixlen_d < dbits ||
>         -           policy->selector.prefixlen_s < sbits)
>         +       if (policy->selector.prefixlen_d >= dbits &&
>         +           policy->selector.prefixlen_s >= sbits)
>                         continue;

Much better!

> I checked the new patch on the reproducer, and the crash can't be triggered.
> If you agree with this new patch, I'll send this as v2.

Please do, thanks!
