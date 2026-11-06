Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951482;
	b=lRfxFlHhcLSWkSTNFiCJ3jKXajYGnm4CLjydRROirjRXBBHkEZISz1Xd7mOMY6TIUGPh
	 +SuE+qME/rh/4qacfX/ibu+FVsfduPcTH9D7mfYIlSSei5XsUJH2BWN1coAYcesLX4EwQ
	 Q9Um40vhRIndCe/0zQOLzgM4aClQoFQDUVP/VedRqKEc79HmGMqccOQLyKE1SNyQvHJOM
	 XGTLpekQ7eM4SadggYTYQu23hSoas5GLVdc6y0se8zyiNI2lO8GCrnmmMZsFOnIpENF34
	 0cMQCgLnyDNkrITepdlVxO0PGmOHRpo/JaLetT/SdF+gtj9QlF8CZdPujIorCNLMe6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951482;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=ZHr7cnKxJ5lZjyr/KeuRcLqoFP/w9L5fnd5tVVZvABY=;
	b=g8CSdEl3tGuJbM0HnDCY2rzmpnqUXsAqcH2RzxmRu+picashM/qNni5IIhGy2gpkU6z/
	 JgCuarBfMH9Zx52tEapErycnRL9L6yVv4W1k9azMYJSzc/AA+Xr3Ia4obfh7b5chPgzjc
	 rYkkGxNKo7I2Ktk2Xu1jbkcML2wgAiDdbuo0H631gJ/98wz0zUbgpfipRNwl4A6huriIl
	 ESwU14DHLkW8Jrf1yg2sONdg5xSqEOchezLn8/a2kRdU15VKbtdjddL9JwwDwtN5BNXLr
	 +fUswKRVJ9JMOaZ6pgsfBPPVwBXaQL4kdkgey7tlwrmScfxxzlB9tKWwkDlIHeZybQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=zG3tmDTz;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F59606A326;
	Fri,  6 Nov 2026 07:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0F59606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=zG3tmDTz
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 46E2F20870;
	Fri,  6 Nov 2026 08:51:20 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NBNz1GUpEhDM; Fri,  6 Nov 2026 08:51:19 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7A79A2074F;
	Fri,  6 Nov 2026 08:51:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7A79A2074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793951479;
	bh=ZHr7cnKxJ5lZjyr/KeuRcLqoFP/w9L5fnd5tVVZvABY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=zG3tmDTz6wF4lMqixwlVM5xP6/ewlFBU2tcncbhm+Ok851o4sCZST/2tI31u0cpCM
	 oUJOx7Fup94LhjtX2xLC2R1dOR3iZgYaPr/L8M2h8cRL9l+dCjQ4/7MWWY2j3sKk71
	 gpPWUmkM8z5+iKZ2S/PgSAL3hiVlOORYALLZUh6mLTFieVPAhGWRVNbd1fkkCFurph
	 LurDBdOIvLNeUdzTNKXIoLFKZSLQh1DKV/P1Jp97ZQo27QJ90lSpjwSQJwgY2pIrMM
	 Wyarm4zPiRac0RvVC0KKCoe8v8BE1ldsl7lkJst6W272xY40iNnwKsB7I10MRgQkCt
	 SrPS2P+N6Mslw==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 6 Nov
 2026 08:51:18 +0100
Received: (nullmailer pid 3072074 invoked by uid 1000);
	Fri, 06 Nov 2026 07:51:18 -0000
Date: Fri, 6 Nov 2026 08:51:18 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Kyle Zeng <kylebot@openai.com>
CC: <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David
 S. Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
	<outbounddisclosures@openai.com>
Subject: Re: [PATCH] xfrm: serialize SA activation with state deletion
Message-ID: <au2G9iC524N1gOjI@gauss4>
References: <20261030042353.74606-1-kylebot@openai.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261030042353.74606-1-kylebot@openai.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Oct 29, 2026 at 09:23:53PM -0700, Kyle Zeng wrote:
> xfrm_add_sa() publishes a newly constructed state and arms its lifetime
> timer before marking it VALID. The final VOID-to-VALID test and store
> are not serialized with state deletion. If hard expiry deletes the state
> between the test and the store, the store resurrects the unlinked state.
> 
> An input lookup which found the state before it was removed can then add
> it to the per-CPU cache after deletion has removed the cache entries.
> Once the remaining references are dropped, the cache points to freed
> memory.
> 
> Take x->lock around the conditional transition, with bottom halves
> disabled as in xfrm_state_delete(). This preserves DEAD if expiry won
> the race. The same protection covers UPDSA when it installs a replacement
> for an ACQ state.
> 
> Fixes: cc01572e2fb0 ("xfrm: Add SA to hardware at the end of xfrm_state_construct()")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>

Applied, thanks a lot!
