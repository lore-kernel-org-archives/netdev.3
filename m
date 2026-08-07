Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F763345751;
	Fri,  7 Aug 2026 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096100; cv=none; b=pVL1j0KsQ1Ekt1tLBk93gu8OHls/k7vr6PS+q9dex42DMIKxRt6VTBV6Ty6tNtySUJduT2xeoacjZ8821aQPpezeG8dqQqIG38tl3YJGvvnRGk4/EPNVKRKBgVjnzYGCyjbMm1A3is7wHahScWkT8ziVGxiLw/g+qI6bMS5qowg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096100; c=relaxed/simple;
	bh=IXvRd1y4b48Oo60pQFCvHUsywDov9i+9wTDweMF1vTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXU6Ylpz/KKhCmKUOk/Jz+biB9liwyA5iatC6ivNWSao7sVXbS3BcXAuN9uEZMbXK/94/Uro3sf9/H/mhyvMPGajYOEBIhBk4/ur/Xg+hTeG+tBD8yny0gxvdI+057wTLFP8CdTzOWTO9pSVan3IP8foC+xIYlw5jjha0MpB1RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knivurrQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knivurrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCFD1F000E9;
	Fri,  7 Aug 2026 09:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786096098;
	bh=AW33E80lknEAv8v0r775GgAwWNAX1oZOvWCqyqartLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=knivurrQhafdcRlrChQwEO5LFQPvczKmhPzWpdci2AmGDLImL8jT/++GMr+CG6rKM
	 qMWeUm0bfgb8BflA59/vNsRqW4+EVP+C4/eCjtgnT4j5G8exerS0m6ItP8BSowvi/C
	 TSIElANcN5E1X40swm/xYdMCafj70H5dKYLv6zbXTH1tivnqk63Dg4DStYPS9UTkvM
	 zScx8OrtTOC9R5DHyvBPvTqbyM12KO0CDZ02oqadG3JhWaG66ysTRhsK1A4SDwSyhd
	 PBO+IwwgJP01UWmJ4TWCWUfZvQmzZwJdo4CnSB/EtZFI7sjBvN3LiepWtjEcRSnpSP
	 xaYCNYDoeTsOA==
Date: Fri, 7 Aug 2026 10:48:14 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	yangshuaisong@h-partners.com, ningwei15@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: hns3: use txqueue parameter directly
 in ndo_tx_timeout
Message-ID: <20260807094814.GI51943@horms.kernel.org>
References: <20260804130933.880552-4-shaojijie@huawei.com>
 <20260805165236.606858-1-horms@kernel.org>
 <4fd1475d-8800-4402-862d-f8b12d48424b@huawei.com>
 <cdfb3eb1-2b11-4162-a875-7e39a356b2b0@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdfb3eb1-2b11-4162-a875-7e39a356b2b0@huawei.com>

On Fri, Aug 07, 2026 at 03:31:13PM +0800, Jijie Shao wrote:
> 
> on 2026/8/6 19:39, Jijie Shao wrote:
> > 
> > on 2026/8/6 0:52, Simon Horman wrote:

...

> Hi Simon,
> 
> I'd like to note that the actual v2 implementation differs slightly
> from what I described in my previous reply:
> 
> 1. The netif_xmit_timeout_ms() re-check is kept, not dropped.
>  After discussion with colleagues, we decided to preserve the
>  existing behaviour: if the stall has cleared by the time the
>  callback runs, no reset is requested.  This keeps the semantics
>  consistent with the code before this patch.
> 
> 2. The "no netdev TX timeout queue found" branch is also kept,
>  now guarding against txqueue >= num_tqps.
> 
> 3. The bounds check is changed from ndev->num_tx_queues to
>  h->kinfo.num_tqps in this patch rather than a separate bugfix.
>  The OOB has not been encountered in practice, but since the
>  validation is already being rewritten here, folding the fix
>  in avoids an artificial split.
> 
> v2 will be sent shortly.

Thanks for the notes, and your earlier response. They are very helpful.
