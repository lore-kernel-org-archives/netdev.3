Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222D6353A8B;
	Thu, 23 Jul 2026 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832322; cv=none; b=mzVHzW0/wpKRVns8dzuFPfWWDXu+mSZiXeB/ybryvyDdKMPtLpc99Haxl0qo+cv4NLRxHha7ANX7/frCkaxB56P9BTJRrB7Sp4BXsGikiCebSMW+lUFzFVe7v+GeyIYr/ODRkQRPU/D4nf26fY6h4zqTSXxg8H1+TKSsecaM+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832322; c=relaxed/simple;
	bh=WnDPQYziqx3J80TQFZKl+PMIfEa0dSRo+xX6DztSa5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jl11029axs9wdAxaWvJwEGtRsvzNyOScgmV28qecOmZi2fvSicGAWj9vPz/DPUl2Hv7Z5kSGGqPcmLdCVsloKPHvPKW+LtsD4JqUKURH6KaQPFvQdnIHl4mElGOoxA3EgmsE37M3MSb3mRGo+yYUzNtz9Na2gj1BDUdtWSFjoEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQsceufa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQsceufa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A811F000E9;
	Thu, 23 Jul 2026 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784832306;
	bh=cLbaZ40ZP5QXte/qtz7CjpRivFZSjx0thkSotDU8BCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KQsceufaN0W3u9m64Q6V/F1IEwiLd4a/zgMV7ywyhps8k4z1rbUb19XwuQxYn+DhM
	 OM73pL7gmDaYY4L9yEAunTXxsdx1G/QYKvqVWtfTMW4p3IcoPWHAbULcQRB4j2Zzjo
	 efb7jO63p5rQ63RCTfzGGiDaGnZTe/fxX93yy7i1oMzlkh9B4Z97xgkxYK60sOqNGO
	 D1NOiuMwRZ8jJBHgVNqoHQgN7g3mWCWqIUMI9LcGpvPZ3SOnReJRUFoZtT7VFgHKL8
	 jz1QQIFLYdHYYDT2pGav62EBBGomis3yVZYtCyRkW8iFQNaeJAQLrgbWYjelgWHQo8
	 lEMomrO2JTWfA==
Date: Thu, 23 Jul 2026 11:44:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bcodding@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 svens@linux.ibm.com, brueckner@linux.ibm.com
Subject: Re: [PATCH] tls: don't abort the connection on signal-interrupted
 sends
Message-ID: <20260723114446.2400c063@kernel.org>
In-Reply-To: <0c91c243a9b1b92e33c3d8fba386e6e141e2d605.camel@linux.ibm.com>
References: <20260720090940.1334523-1-maxbr@linux.ibm.com>
	<20260723092630.1a1c9b4e@kernel.org>
	<0c91c243a9b1b92e33c3d8fba386e6e141e2d605.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 20:38:27 +0200 Maximilian Immanuel Brandtner wrote:
> > > +static bool tls_is_non_restartable_err(int err)
> > > +{
> > > +	if (err >= 0)
> > > +		return false;  
> > 
> > This doesn't belong in a helper for classifying errors.  
> 
> So you would prefer if (rc < 0 && !tls_is_restartable_err(rc))

Yup.
