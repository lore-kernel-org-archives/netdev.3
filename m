Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F345424D64
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130120; cv=none; b=Cf3rNX15byC5BfcmFBSg+jMGPjeJOZxa6WuT1daIC//F949vT5WpYHyOLAdtzOBgD3aeKoJ2LVF0uOarKVQX6pS7swbsT1tpxcHYpFcnqgzEqRgVyXTodVsdth36ELWSKEYgB89YF5cWDZQSS7UUY0ex13FpCBSEqK/t0gB2JHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130120; c=relaxed/simple;
	bh=qbLrM6PLrNeKxQQOTH7JHbQXbbIE+zf85AT7ZT/+4y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiPGCVywBrAjU8N3/4VvOUotPKu++c0qZGVtvQqkAPHGxRquNicuw/ZF7R8w4NinTRQSwoSrNUnfQZf05KD5BVRglwCuESRBSDsbgWcNA/39D4m9KUJORb/UqBmHDSoEcVoshH3JFQkrKEhCPn9mAUov/B+7HEyOH5af39BHqQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRbtrHwA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRbtrHwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425AA1F000E9;
	Wed, 19 Aug 2026 09:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787130115;
	bh=SXNsoD/tX2+QDTeO9Gg1jZS1H1/EqNBb9GNa2MJc4z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MRbtrHwAjMoImaVsUiz8rasiCCVw1QUjbg2CXwW2LFb80Gu5XAoVi6V3gwZ7lQhTl
	 uazTzFj+phyGoK/je//qAszcPqUvbI+oymUKnU1EKsyVfCtCpG2na/74Lg8JIALjym
	 Sk2gyxZgNQkj/FbWRbijHRvl7+yknlyNvF7c90AHjQj0Cv4gMXjfD2deeXyC6talKA
	 wUhrg5FCwu7Mpkr6SD3AQsS5Z4ULSb5y/i2mikjxs9JeutWKoPYyVWrrlcH3YHpgG3
	 K79DxzrMEmjnfFd53Up1PnlIKNWEoiDo0aaUQth74RyQuBDOkg/LcpGaaHyO/owpFO
	 rPf2t3cMIDydQ==
Date: Wed, 19 Aug 2026 10:01:51 +0100
From: Simon Horman <horms@kernel.org>
To: James <aslan.jnn@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	netdev@vger.kernel.org, Thomas.Lendacky@amd.com
Subject: Re: [PATCH net] net: amd-xgbe: support receiving packets with bad FCS
Message-ID: <20260819090151.GO265046@horms.kernel.org>
References: <20260814100916.GL265046@horms.kernel.org>
 <20260819023602.10387-1-aslan.jnn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819023602.10387-1-aslan.jnn@gmail.com>

On Wed, Aug 19, 2026 at 12:36:01PM +1000, James wrote:
> On Fri, Aug 14, 2026 at 11:09:16AM +0100, Simon Horman <horms@kernel.org> wrote:
> > FWIW, I lean towards this being an enhancement for net-next without
> > a Fixes tag. Rather than a fix.
> 
> Hi Simon, thank you for the review! Apologise for the late reply as I was
> unwell last week.
> 
> My rationale for targeting `net` was that the driver currently accepts bad
> FCS frames by default, which I believe should be an incorrect existing behavior.
> The `NETIF_F_RXALL` I added is intended to preserve access to that behavior
> only when a user explicitly requests it.
> 
> With that said, I understand that exposing the `rx-all` control may make
> this better suited for `net-next`. Do you prefer that I respin this as a
> `net-next` patch (when it opens later this month), or do you think the
> default-behavior correction justifies keeping it in `net`?

I do lean towards this being for net-next. But if you feel strongly
that it is for net, I won't push the matter any further.

BTW, net-next is currently closed. So if you do post it for net-next you
will need to wait for it to reopen around 31st August.
