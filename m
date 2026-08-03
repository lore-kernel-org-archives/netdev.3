Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201DD3451A7
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776110; cv=none; b=eUc8GLG4b+pFSOvfCN9UdDb1Cu8Xwe2f6yk+XiB87+i3j+gqIap4/y1DAPW+gPRfiA/ZZZzRL23El0e8FsZ62aYW0yN2oZwYmrIjDVbH5SmCOoU+mKuNnbXiwpA+fdboBTCnNpKFZdb1DYozw7U30KGcLDl1V0d8MgLFy83KiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776110; c=relaxed/simple;
	bh=Bl2pe78URcd9ZE3Dy8IPpVzatiGe59ftG2oHfhzILKo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYb1xZVL8acOGyoxs3tz2feCrxCJWO9QV+AYXPh0FB3KYXz90xmqUurCsL8jFGGw+T1QZX6u7B4+YYKFkUv6I9Z82NmsqXqvS+U5N00+wHhNhyBvZjoMe6qM03CCJ0c4YRw4oohnmAYfHL8NW6WU/mp8azU8gCoSsP70AQgZJ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ZXWhe+TV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ZXWhe+TV"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6D7DD2068C;
	Mon,  3 Aug 2026 18:54:59 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tiE2h0heeIJq; Mon,  3 Aug 2026 18:54:59 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id E60A72067A;
	Mon,  3 Aug 2026 18:54:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com E60A72067A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785776098;
	bh=sKNXtv7SE2Bo+hOC3o83Cp5bup5szlMBSs8A0VgDa88=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ZXWhe+TVX0VLXbHWnm1UbsIlihoRjQm5G3piuSa8rF0bcB00RcYkyoHFuNWC2zSMw
	 P8PNVU7cAG88gFVI88JsES+Ye5DeuXDJHN3lNsVqLjfKfu9U5pPwDGoippyoCHdz8k
	 z8/nS0/2seFkLLYJEsyPz10z3ggBXRFsAK30rVsGKUBHKopzKfaauTCOvj3W3zWTpf
	 fBkuQNcBPTaXDV7jBfmjD5/GVx6/d1oKvssUuuXcEM+mnzuEjWNozMK7+c1wIbYYWf
	 RZjUYI8+oY6ykXX5KdoNsjBUi4zv5vZjn16kDICbjmow6sVFBVO7UCPQAmO7qJyqcR
	 LEwC4SsKz5k2w==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 18:54:58 +0200
Received: (nullmailer pid 2442231 invoked by uid 1000);
	Mon, 03 Aug 2026 16:54:58 -0000
Date: Mon, 3 Aug 2026 18:54:58 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: David Miller <davem@davemloft.net>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/8] pull request (net): ipsec 2026-07-29
Message-ID: <anDH4o5N4-VRowu_@secunet.com>
References: <20260729065035.1591985-1-steffen.klassert@secunet.com>
 <20260730191720.2b585d44@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260730191720.2b585d44@kernel.org>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Jul 30, 2026 at 07:17:20PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Jul 2026 08:50:10 +0200 Steffen Klassert wrote:
> > Please pull or let me know if there are problems.
> 
> Sorry for the delay, patch overload and Sashiko found some issues.
> I haven't had time today to investigate either, so I just sent them
> out as is - LMK if they are not real but AFAICT both models said
> the same thing here.

I don't know why I've not seen this issues when I've applied the
patches. Looks like they were there already in the original
submittions.

All I can do for now know is to revert them and send the pull
request again.
