Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95532B125
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379758; cv=none; b=SzLL28uQovBpy/R7vTpR62GqqhRwJE+E9jRrfwObFulGQlUpVZKdbdDImMmjF+oWDQSTPc+wzSaZIXWcSmCAnc/xx/IwV7VxQ3KWj8fU0yDJEmLpc0FWldOA+Zr72WCyAbYuCtmO/SukGhYy+184kqUdxJzEEnmIZR/mpBN6FiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379758; c=relaxed/simple;
	bh=u5bRO0rCYRYZ/LHi1UnfnqKSFPgb3k4ZYQ/mlM05YBc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGfLuWGOTDleHO2sl8ltsyHaQT2w9ndVckMilF01op/FTIYgtnEEHfvHlfwJxlCAtSsxQumNAnGnatDD1v3++g2h9JQOzS8NpMOwppcg7lf/I4k2tCyih2PjBfSqfnrv9H5UQ3C4uMrPp981xwHqh0Y/tKnZLZpWvCH8gW4uZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=dgIIaaEV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="dgIIaaEV"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3935520643;
	Mon, 14 Sep 2026 11:55:54 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z8uofDUg0tfF; Mon, 14 Sep 2026 11:55:53 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A94E5205ED;
	Mon, 14 Sep 2026 11:55:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A94E5205ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789379753;
	bh=J0cfX6HldIg8RyS3ZosAUI3AUvg26gMjkJ448DKp5tc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=dgIIaaEVa00SB3xTaWKBFB4ydGx92uqQcjkvMwNnZWpbgbXAooOsqqhdz6LPjf34O
	 eOYfGDbcI1yU+bRgKQATX4rMeYCZaWh2QuHyo9qpn0XwxRGqZoEOedpzZxZrJzbBlK
	 m1eRltyVhuZ6Kw23jRhoSSt/YjfJOzrCMr9CrfsNuHpYmw/e6PEKCAnN1lqdq6nYtF
	 D+WoX4slqWKhQs6n2c9pdWX6p6eCFoVapyf1TS6V1QfBNUUCzOCD1ld8KwuqVMLk2P
	 gJZbG84pgG1m/H79pnC+nFxee+eMoLSYOMla5Pc40S68g0eSQ0vAUYs8s0Yry5HPm0
	 7eiCYr0JP55KQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 14 Sep
 2026 11:55:53 +0200
Received: (nullmailer pid 1884100 invoked by uid 1000);
	Mon, 14 Sep 2026 09:55:52 -0000
Date: Mon, 14 Sep 2026 11:55:52 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH 09/12] esp: downgrade zerocopy managed frags before
 mutating skb frags
Message-ID: <aqfEqIyNQ4B54fKf@secunet.com>
References: <20260907093020.2228346-10-steffen.klassert@secunet.com>
 <20260908224900.1591301-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908224900.1591301-1-kuba@kernel.org>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

Ccing Author of the patch.

On Tue, Sep 08, 2026 at 03:49:00PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> esp: downgrade zerocopy managed frags before mutating skb frags
> 
> This adds a skb_zcopy_downgrade_managed() call to the out-of-place ESP
> output path in esp_output_head() and esp6_output_head(), so that the frag
> array is no longer mutated while SKBFL_MANAGED_FRAG_REFS is set.  Real
> page references are taken on the existing frags before ESP appends its
> trailer frag.
> 
> > diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> > index a6c18aea7498d..e76db5817e78e 100644
> > --- a/net/ipv4/esp4.c
> > +++ b/net/ipv4/esp4.c
> > @@ -441,6 +441,12 @@ int esp_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
> >  
> >  			esp->inplace = false;
> >  
> > +			/* Take real page refs and clear SKBFL_MANAGED_FRAG_REFS before
> > +			 * we mutate the frag array, so the per-frag unref stays balanced
> > +			 * for zerocopy managed frags (see __ip_append_data()).
> > +			 */
> > +			skb_zcopy_downgrade_managed(skb);
> > +
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the sibling xfrm
> transform need the same treatment?  ipcomp_post_acomp() in
> net/xfrm/xfrm_ipcomp.c rewrites the frag array too, and there is no
> skb_zcopy_downgrade_managed() anywhere under net/xfrm/.

This can be fixed with a followup patch.
