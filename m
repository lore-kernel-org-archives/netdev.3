Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4DB46C827
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153253; cv=none; b=gwj1A46LKlIt9sn4mWps51HqNEO8UJh2S3dQkg1EHe/Ej/6JSwsLWWamOTLlO1U5kZ4w8cmqq5q0s9v34jS3fIvBaJ/j4duez3VcHSKWjPsvH+Rjr00iyB4aDhjxS0l2BDua71UmYA2N2bI63W8mNRLK1gGYg69u4AvUaLkXZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153253; c=relaxed/simple;
	bh=Xt7Ar0Z9qghEr4doSJBVv/+mwlE2B0uXGNimXF75FwI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P0GtRx5R2EgLNTtQlClE3i95/A0d5PzSyXcZq4SGcrxREzI1Njqu4mpHVTo6j9KaVxFfmS1QGuCCMWkcmWA7axarETmqQE+k0SWUxnqYMt21NwMOtIK0/GDkf+GobnNH3+uTSVwqIarjlEJP6l/Cfdz5AaiAnKNELjEWl3CynrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V3QADrNV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hF7zAdEI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V3QADrNV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hF7zAdEI"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792153250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xt7Ar0Z9qghEr4doSJBVv/+mwlE2B0uXGNimXF75FwI=;
	b=V3QADrNVdGKuNfI8sJ4taCpBUAnXU/XUgcMIKDOpiekZv/Pn5mLqKnh8PVyufg7ZF3cmZt
	THekaMdWQz1Rppgm6Wtgwr7+VmnKBboObqrDYCj+Ks5ts3uuu20RBV0z5c19Ci4SuSf5Bt
	mCl2D38J8LBbAubuQNAeySEYb1uT2THOGazeewFjFa+QrpDR5o2vObm3T3O76PhKYtlUfM
	E8XEhUuGnbO7V3O6h7a49TJsIRemYQy51tW4egGRBGFIsFqNSj8Ncijm+tH5xuWu/2Jrrj
	wnr1rpAFE5V/uDXRvtJpLCwUodxTXBIJP6OFJX19QdE+Bxgku5zfxMKA4RYrpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792153250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xt7Ar0Z9qghEr4doSJBVv/+mwlE2B0uXGNimXF75FwI=;
	b=hF7zAdEIb0kMRJV4D65LC37K/cC8jK0M2FFNEUpF3arRxyGMO5LbRuQEsPFnioitp703Sn
	tcn6m9Ff064uJlBg==
To: Carlos Fangmeier <carlos.fangmeier@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: prevent kernel panic during XDP program
 and XSK pool transitions
In-Reply-To: <20261014222628.3206770-1-carlos.fangmeier@gmail.com>
References: <20260605-main-v1-1-aed15b1cf1af@gmail.com>
 <20261014222628.3206770-1-carlos.fangmeier@gmail.com>
Date: Fri, 16 Oct 2026 14:20:48 +0200
Message-ID: <87bj8tn8f3.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hey Carlos,

On Wed Oct 14 2026, Carlos Fangmeier wrote:
> On Tue, Jun 10 2026, Jakub Kicinski wrote:
>> This still looks racy. Please look at other drivers
>
> You were right. The intel drivers (ixgbe/i40e) disable the queue pair
> as a unit around the pool swap rather than gating TX piecemeal, which
> is the pattern my patch was missing.
>
> Kurt Kanzenbach's series "net: stmmac: Fix XSK crashes on stm32mp2"
> [1] takes that approach for the XSK pool enable/disable path and is
> further along in review, so I'll drop this patch in favour of it.
>
> [1] https://lore.kernel.org/netdev/20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de/
>

Well, looking at the Sashiko reports, it needs some work though. I'll
put you on Cc for the next iteration.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmrSFqATHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzguCVEACLB7jOw+qZLfQSYOAtNqEc29oYtngT
l1rUQ+qQJ1DeG2b8+amNpn9NJiun5nuxQh+wwQcZP6JkzxMIaKDH8BoVwWRyufbj
GPyBHtBlwAo2X01owNOeTsBXaLatuPo7NK41YBXCAW8nm/TXxaqR9geHeJUmd2KR
yi645Hjd1Rl4B9AQ70XtdthLdmzL6oYkhVac8Vq6s/cjT1D4eSwBG4eUqUVbBhjA
IDQmdmsy9alMkt2jfBDCTDEifa6OyrYLz14tOFhrhHQDVb6cT76Ijgrvu7jSc0sP
8rpj9e58getO+a5TS3bZNDPTMhm+gKCz3fqplNmkW4lbrVI4X3Ea65Bw/t2kAXtZ
gBgBEofRffZ0ASVpfrXWfPxZCYJZyKjLruNW2CmyyNGG1BTw3Gmm95Nt03Vlpz3K
SCkyTbDHXuo2GKcM2ZWm4fv67vbYKkDG9SWI35F6PjyIptyW/fuokF8t/uGGfQBz
h84bZ0DJ5G7WW3+UcIHCVKHHaixrEAn/660FY5oHhOtVasVinNupd1Dj7fmjp+/8
y3+qxnZZTMudzLAGmroNt2J52jOB2dz6uvLAaFqHNhvgXrXpIHxL6VZqgkfXD3V/
LJ60E7R8Yh8WUrhB710jXBr2vGtDo14p+L91y3N0VWt3/6qR8cBNd9CJUM9YzJ9g
dT1uy+Enk8gQrQ==
=SP8V
-----END PGP SIGNATURE-----
--=-=-=--
