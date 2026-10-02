Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7B41DDFF
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926816; cv=none; b=N9txz9TnARyzO6DzbNGBC2U/Obi38sKv8oZnMz2mf5pf/3EefkzGTgBBMJ9feW5wKqMvqXSXeHBdCqotgPiuEIf5w3CO9GDSjWXqJmunleOrQf/2766ibnE8vVPRKpDc40TIVbcrCa8SEoMjMjurt6vzG1pCqluSbmqnFiZWXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926816; c=relaxed/simple;
	bh=qd7bX3bHkwgul2mgWclf0ajGDrh+McUieLETrMelZjs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmKxNdk6VgFOdPPo4qcFAV95AJ2iLheGt0qactnTksmJJtZquZYtskBWES8aEsNTTjBSmLGxCENgCbywLfhADoWlXc+F3uZ5xcuP5wYCPX2t4H12ZbAQr8+7l5iuEbwtmO5HHWEYoTVKdUNowpSvMj48tocieqb7xaRyJ/RfV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=S/pHUAlD; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="S/pHUAlD"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 0F83320841;
	Fri,  2 Oct 2026 09:34:08 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tjq1Ixf6FjSy; Fri,  2 Oct 2026 09:34:07 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7E1122082E;
	Fri,  2 Oct 2026 09:34:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7E1122082E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1790926447;
	bh=zeiH+PUS20VRLgsoxoIwx7He8UvtaYUZPkQ7yeUaHg0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=S/pHUAlD1k/IR9jvc+wC1YocYNYQlxluev7KJdVit6ugFfi3yI+aUQ1Paw4t/CgOT
	 bAsiHX48aEQaGNPTnZeap8s/zc8N93tPA+DFDahf0vSwfoWKljF5yIs97gZmElEoKQ
	 Qag2JWKItfgqHmglWEN2WVOJOjq+GNs1CLzb091MeR2U6nIr630R5BFhKFFxopaKTz
	 JSxiKySLlMAfMq9rvxsxmUtAvWjkGz56oyKTgoydJOAlsvNSvBDi4XDk+YouDXWCYo
	 1iTpiEsN9g+TTm5tDm4uaCp0znxcgbjMKOR//Alg6x75p+64rJvq8YgpigFOivo1wt
	 z5WmP4aGpwATA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 09:34:07 +0200
Received: (nullmailer pid 1917243 invoked by uid 1000);
	Fri, 02 Oct 2026 07:34:06 -0000
Date: Fri, 2 Oct 2026 09:34:06 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Qihang <q.h.hack.winter@gmail.com>
CC: <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net v4] xfrm: interface: validate the IP header on xmit
Message-ID: <ar9ebhV0Ibg1x8L_@secunet.com>
References: <20260923084123.10734-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260923084123.10734-1-q.h.hack.winter@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Sep 23, 2026 at 04:41:23PM +0800, Qihang wrote:
> Packets injected into an xfrm interface (e.g. AF_PACKET on an xfrmi
> device) reach the xfrm output path without IP header validation, but
> xfrm4_transport_output() uses iph->ihl for __skb_pull() and memmove()
> and expects the header to be valid.
> 
> vti_tunnel_xmit() already calls pskb_inet_may_pull() before handing
> packets to the xfrm output path.  Do the same in xfrmi_xmit() and
> perform the header checks ip_rcv_core()/ip6_rcv_core() do on entry
> to the IP stack: reject wrong IP versions and malformed IPv4 header
> lengths.
> 
> Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>

Applied to the ipsec tree, thanks a lot!

Please Cc all the maintainers on future patches, I've
amost overlooked this one.
