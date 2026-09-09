Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF8F37FF68
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935947; cv=none; b=tpGlvZcB7rFXVDFNvOK30Na9F8HOGWSivEmjROuXc1sgvCHcrvTT4C+Tpzz6Xj2UdgpOKMkqKG0RxQz6p3P3sv7VYbsXVxOwN9s4NDlg4ujVFG6s+Q5WPvOxH6W3n9nWgLtsVW8xY3xe3jm1LpM8mZGIMRtJJiJKUSkl/MW4gdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935947; c=relaxed/simple;
	bh=sZg+krdoyDzBjKd87iKZ5Wnsx6PEBVS+Tjry01QAUvM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRo1yvfbQyODJxxkJV8EmOr5RcuRgoux5InQGWC1By/ropHfylZYnyiZpZ2NgvtZ/8/NuGWzQteXurEyol71bN1ITxNbf++id7e60LTRGHnxJ0N38RpT3SEdYA/m0kVZSMnRrE4A1s7DuTprEAxVkwdk/TwAeazI28yX7LfM75g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Wrv6fHTV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Wrv6fHTV"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 4FD15201C7;
	Wed,  9 Sep 2026 08:38:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e68tJLAuRmvF; Wed,  9 Sep 2026 08:38:54 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B1B7D201E2;
	Wed,  9 Sep 2026 08:38:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B1B7D201E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788935934;
	bh=sZg+krdoyDzBjKd87iKZ5Wnsx6PEBVS+Tjry01QAUvM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Wrv6fHTVqMwsMGOd2DGQSifX5b72xff36RF27Da/MDd2T/A+ogr8HVirj9QKDuPQB
	 E4H4x3J3fI+e9wXIqSr1UIwqB0D7cNMyVn93N+1NGPjDE9sXPl3M+oaYgX+Fn1pK/q
	 Wf7m5Fq30oMf+fO3EMxkrBSstVReuGcFNqX//lA1NEIr/bV91j3O9/7WpzFBVfCs2Q
	 rIGQCdV8xtQsF07wS9AziEX7hv+rVteLH5M+wZcnajGsSXq7kz/c/fkH263i6jrEy3
	 CckUG4mDX6uMc4b4uXWl2kv419TjhBN7S5I4iBrbgbxp8yeZR0Q5zj+gxg4WCnHuh5
	 dSdWos/8g3ADw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 9 Sep
 2026 08:38:54 +0200
Received: (nullmailer pid 152940 invoked by uid 1000);
	Wed, 09 Sep 2026 06:38:53 -0000
Date: Wed, 9 Sep 2026 08:38:53 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Some clarifications on the upstreaming process (was: [PATCH 0/12]
 pull request (net): ipsec 2026-09-07)
Message-ID: <aqD-_cBnIOMEpxVh@secunet.com>
References: <20260907093020.2228346-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260907093020.2228346-1-steffen.klassert@secunet.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

Hi,

I need some clarifications on how to handle future ipsec patches.
Since we have the AI-generated patches and patch reviews things
changed quite a bit and I have problems to upstream ipsec fixes.

I have the following problematic situations:

1) Sashiko found nothing in the original patch submisstion,
but found an issue when I resent the patch with the pull
request. I think this can be solved by asking the author
to send an incremental fix on top of the ipsec tree if
it does not happen too often.

2) How to treat preexisting issues that are not introduced by the
patch under review? I'd say that's ok as long as the bug is
completely fixed with the patch. Is that acceptable?

3) Which severity is ok to accept? Maybe this:

- High, only if the review is wrong?
- Medium, only with good reson?
- Low, ok to accept?

4) Some patches for the ipsec and ipsec-next tree don't get Sashiko
reviews either because they don't apply to net or net-next, or
because of some other reasons I'm not aware of. This is the biggest
issue, I see the Sashiko review only after I sent a pull request.
This makes the upstreaming process complicated and delays fixes
quite a bit. I requested some infrastructure from the LF to get
this fixed, but no answer so far. Any other ideas how to fix
this issue?

I think 1-3 can be solved by an agreement on how to treat these
situations, but 4 needs to be fixed to keep the upstreaming
process working.
