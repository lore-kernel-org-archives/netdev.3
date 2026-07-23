Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC203546DE
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792290; cv=none; b=k3sqBrrC2vDdT2Qrfn6K6s0CQZWpG89Wb1A5QyJBwNklyoQN+/Eqv36pORwtWk1Th6l37iYyQrMSagYCdmD1EO2+OvUKYYRwuZeY6jnaCKOQZ6AxljQ1kTgHQX1uRRK5gIF+RrJrJWzC3C0TTZO/5bZKYiyi9BW6HlvOM1Vk9Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792290; c=relaxed/simple;
	bh=pmOq4uU5Le0DpsWzSlHhyYooYrdutpnReMvKkQMQJAc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/Bp513jXe46aXB74nGY0JKjYsY7O25KW8S1hQqN9n+DaaTGGwTOnDXaldTvS/a4M8ZpOXw5CWuKcO8YpX19k4qLtGum3hLHX8+pKfYpLhBhhBouhAwpkiWIdhxbPrfud4a8jpNVJwAtoZUJ3nPNbpXPLHyAx1Ox/8V+UCbpmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=qha0yK9s; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="qha0yK9s"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 00ACC20844;
	Thu, 23 Jul 2026 09:38:05 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GTBGwSL6uced; Thu, 23 Jul 2026 09:38:04 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2EF972080B;
	Thu, 23 Jul 2026 09:38:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2EF972080B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1784792284;
	bh=/fLA1L4q9wvpdNFRnaRzBwR6lqyasTVgP3508B1SjS0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=qha0yK9s/DobO2mRDFk/sLjBSFMCPlhkZD81MRhCEh9vGg/64cM4f0cXxU9f0+Sga
	 dkfiEqlzT9CaKLC1lew7tK04wNOSxIRv2/bmsYpnb9+2xWtIqHBI8noOMvM9+0WSad
	 PQwiYpqq/b5JC0NgsI8r81czB5K3S7LfOBYDEUm9FS5qLd+5YE/yminOduOcu3DoQ/
	 xV1T5Rs30XrgF6HB0ShQrLVovIaDRKpAY79byRjeEaGUwL1g+d2pGpwBFzCVVykYDQ
	 SmMQKvK1nUMLwHYCIWcrYTvHt/I8jiLvfRZnH2QJZ+QDb5703VZZPlEjjAnQwibhi/
	 SZtlBC0aCMhCA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 23 Jul
 2026 09:38:03 +0200
Received: (nullmailer pid 1131547 invoked by uid 1000);
	Thu, 23 Jul 2026 07:38:02 -0000
Date: Thu, 23 Jul 2026 09:38:02 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Ren Wei <enjou1224z@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <sd@queasysnail.net>, <vega@nebusec.ai>,
	<roxy520tt@gmail.com>
Subject: Re: [PATCH net 1/1] xfrm: drop ESP-in-TCP packets with no ingress
 device
Message-ID: <amHE2sGqclwnSYIp@secunet.com>
References: <cover.1784312563.git.roxy520tt@gmail.com>
 <0695ad081ad2abe6bab142be361ac4b52595fa6f.1784312563.git.roxy520tt@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0695ad081ad2abe6bab142be361ac4b52595fa6f.1784312563.git.roxy520tt@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Sat, Jul 18, 2026 at 03:12:50PM +0800, Ren Wei wrote:
> From: Zhiling Zou <roxy520tt@gmail.com>
> 
> ESP-in-TCP receives records through the TCP strparser. handle_esp()
> restores skb->dev from the saved skb_iif before passing the packet into
> the XFRM input path.
> 
> Queued TCP data can be processed after the original ingress device has
> been removed, for example during veth or net namespace teardown. In that
> case dev_get_by_index_rcu() returns NULL. The XFRM IPv4 and IPv6 input
> paths both expect skb->dev to be valid while building the route lookup,
> so queued ESP-in-TCP data can dereference a NULL device.
> 
> Drop the packet if the saved ingress device can no longer be resolved.
> Such a packet can no longer be routed through the normal XFRM receive
> path, and this preserves the existing behaviour for packets whose ingress
> device still exists.
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> Assisted-by: Codex:gpt-5.4
> Reviewed-by: Ren Wei <enjou1224z@gmail.com>

Applied, thanks a lot!
