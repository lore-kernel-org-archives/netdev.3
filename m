Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9C33EB118;
	Mon, 12 Oct 2026 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791800002; cv=none; b=fh55eFG+JGsiaO99CE5CSYYsJOWMMxp7/oAuJsHyikEHyukNStVVd83D+yIFkqh6bh2U+o2n9AVEG/9TQ11W0WPSYjjCKWll19t9utnLnE2tQuIFVBLXIqhtrbZgqb1YY5acrKwQje+UNsUIFAd8j+p7NHitcx1LGVwjzF1iw1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791800002; c=relaxed/simple;
	bh=M7UGNA5PGreKZ/I1kW0IM7+56hECzmak3/8HkjudCkg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hesi6wdq5bFxB9ec4bIie1W2UEBEKyBOdgnwU8GQwjNHzLIc+pouLnLzdyfS5FR0NQ34VgLkuZGQdmF5Ywdn1YhdHUBS7/SXrUV0LTNUek2OTbrWkt2fwKD1AlAp3aBFjB0SyAuve5rCH7qOGE4SV7f1s5s+j3uioQqbsSZ2viw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=QWhIzUUK; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="QWhIzUUK"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C8AAE205DD;
	Mon, 12 Oct 2026 12:13:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bNzD3IA-k7mm; Mon, 12 Oct 2026 12:13:10 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4B47220590;
	Mon, 12 Oct 2026 12:13:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4B47220590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1791799990;
	bh=x9f2xV5Z7UABuoyrd3nrchqgk0eDmNFMqpZi7H0TCf4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=QWhIzUUK3IRzLwiqtHn7Xbs/t/hbtpex3zkkU+Xdt2zqR5lVkITlQsVrwFkbu89DN
	 vtgI+a4OyHCt5qi6QShevbwB9AsQI6rxpG4ZoV+g9iQsMfDiOxIndWAIOTR4G6Blxo
	 +PnVX8fUbClBqOFGjjJ/2neKVYYAq/hb1FLkBOgCfFiLMsiGEPPC35NzAXcP8uScdO
	 afzTjlHINhXp5PqGit2Z3nvWHYe9WgvRlHnwZIMBGdrXjcp+iNCtZy6ofUBs4R6Zby
	 THomq2qfIZLvo/c8ngtUlT2QQ6T+Wl0vJUkFBk6a4KeiC/nnBrkCP/IlzsWGyAKCS8
	 OTXlUPdreDvkw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 12:13:09 +0200
Received: (nullmailer pid 2458163 invoked by uid 1000);
	Mon, 12 Oct 2026 10:13:08 -0000
Date: Mon, 12 Oct 2026 12:13:08 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Qihang <q.h.hack.winter@gmail.com>
CC: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel
	<idosch@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/2] vti: fix tunnel device use-after-free across
 async crypto resumption
Message-ID: <asyytFvHJGf_KB_D@secunet.com>
References: <20260930090813.73901-1-q.h.hack.winter@gmail.com>
 <20260930090813.73901-2-q.h.hack.winter@gmail.com>
 <179110850671.434549.2584497019282941556@kernel.org>
 <1791424156.460.8ed76b88c7@gmail.com>
 <asySLDyakgLAKVdf@secunet.com>
 <CAH78Gvt0gUELPSeqf348P4-B8E7RH3L3PhFdgVdjfK=WKEpzdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAH78Gvt0gUELPSeqf348P4-B8E7RH3L3PhFdgVdjfK=WKEpzdQ@mail.gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Mon, Oct 12, 2026 at 05:07:43PM +0800, Qihang wrote:
> Hi Steffen,
> 
> Thanks a lot for the guidance, much appreciated.
> 
> Your three points make sense. For IPTFS, the skbs freed without the
> receive callback are the outer xfrm skbs, and it's only a handful of
> places in xfrm_iptfs.c -- a small shared helper would be cleaner than
> open-coding it at each site.  The two xfrm_input changes (set family
> before the early drop, and hold the skb->dev reference unconditionally)
> look straightforward too.
> 
> Would you prefer to handle the IPTFS and xfrm_input fixes yourself
> (Christian for IPTFS?), or should I send them as part of this series?
> Either way is fine with me.

I'll handle the full patchset, but Cc Chris on IPTFS.
