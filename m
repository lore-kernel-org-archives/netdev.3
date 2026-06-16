Received: from oak.phenome.org (oak.phenome.org [193.110.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC63DA5D9
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589767; cv=none; b=OrNV/VIIcHvZeeiYzYFA+tHawoVQJmrPCF+4L0FpHM09nH/Xw7MlbFlSDeop8Gm4ZKzaVCQlB4Sd6jfu++GGRxqv1FYXxVle0nD4KSvDG9J2QBEcl/l+xKIKbnqcgPZeb96jjOYRdUh5wQJA7tkcvBzApJTWf5SHmk5sF/cS6+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589767; c=relaxed/simple;
	bh=B/Fo63KqjMlZIKLkWIeSni1oYyYInJEcJ0WTJoaHWs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVKmOhNdD+vu0TvE6AonumdVAwX9JzqR9qhkkBbE1kPt1XY91DsDjtRsl+YAexcqlNz7S8ofpMlDTSEaEmErchz0DmUPiHZiAL+Ejup25G83Z4ZOhMKfub64wnSyz2y3SeG6uObPMG2N8U37l/y0jGRgXTOtSHAADV7DJsRb6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org; spf=pass smtp.mailfrom=phenome.org; dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b=ouNpQP8W; arc=none smtp.client-ip=193.110.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phenome.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phenome.org header.i=@phenome.org header.b="ouNpQP8W"
Authentication-Results: oak.phenome.org (amavisd); dkim=pass (2048-bit key)
 reason="pass (just generated, assumed good)" header.d=phenome.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=phenome.org; h=
	in-reply-to:content-disposition:content-type:content-type
	:mime-version:references:message-id:subject:subject:from:from
	:date:date:received; s=oak1; t=1781589273; x=1782453274; bh=B/Fo
	63KqjMlZIKLkWIeSni1oYyYInJEcJ0WTJoaHWs4=; b=ouNpQP8WFmG8oa44RlMy
	+tnuysg+KCF/3WLOX6SfUCymb8Fck9QJdB+MQXzlCQN3pMbR/V2XXVfKLosqISYW
	e8vuWzZFkQAs65wSwKepnW/8+GFiLWZSoXObRHukD+wpIUeWY9DPjAcpBnA4Wp5K
	EXa4O+hNG9mL6JwnlhHZEZ25P8oXiJdpPyoS5azZjOSgu2cytVQ8fHk+7i9LjCYR
	hkYExBz2Ksusti6rkv1mNlC9Z9iN6JQEKGqfxo3mhmPz5Dg9hF7hBNavq+Ki2HNn
	Cv71JPKz92eBQV5Dk3vQ+RUhap9WhFs0INjL227vuUUVu5wjlF31/n8pklMet9il
	oQ==
X-Virus-Scanned: amavisd at oak.phenome.org
Received: by oak.phenome.org (Postfix);
	Tue, 16 Jun 2026 07:54:31 +0200 (CEST)
Date: Tue, 16 Jun 2026 07:54:29 +0200
From: Antony Antony <antony@phenome.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Antony Antony <antony.antony@secunet.com>,
	David Miller <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Subject: Re: [PATCH 0/18] pull request (net-next): ipsec-next 2026-06-12
Message-ID: <ajDlFUhMfJP36qA8@Antony2201.local>
References: <20260612074725.1760473-1-steffen.klassert@secunet.com>
 <20260613131552.2562d433@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613131552.2562d433@kernel.org>
X-Mutt-References: <20260613131552.2562d433@kernel.org>
X-Mutt-Fcc: ~/sent

On Sat, Jun 13, 2026 at 01:15:52PM -0700, Jakub Kicinski wrote:
> On Fri, 12 Jun 2026 09:46:16 +0200 Steffen Klassert wrote:
> > 3) Add a new netlink message XFRM_MSG_MIGRATE_STATE that
> >    allows migrating individual IPsec SAs independently of
> >    their policies. The existing XFRM_MSG_MIGRATE is tightly coupled
> >    to policy+SA migration, lacks SPI for unique SA identification,
> >    and cannot express reqid changes or migrate Transport mode
> >    selectors. The new interface identifies the SA via SPI and mark,
> >    supports reqid changes, address family changes, encap removal,
> >    and uses an atomic create+install flow under x->lock to prevent
> >    SN/IV reuse during AEAD SA migration.
> >    From Antony Antony.
> 
> Hi! There are some Sashiko comments here, please follow up:
> 
> https://sashiko.dev/#/patchset/20260612074725.1760473-8-steffen.klassert@secunet.com
> 

Thanks Jakub. I have fixes and testing them now. And I will send fixes soon.

The comments didn't click until I realized xfrm_user_state_lookup() only
keys on mark.v & mark.m, so distinct (v, m) pairs collapse to the same
masked value. A lookup key of {0, 0} matches a source SA with mark
{0, 0xffffff} (both mask to 0), but reusing {0, 0} as the migrated mark 
turns "match only mark 0x00" into "match all traffic".

Fix is copy from old SA than from old_mark passed along. This also pointed 
more issues.

-antony

