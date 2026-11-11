Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388181;
	b=ISaI+cvEl6glPQ2ryf3xlWFDXIeWcYlMd9WUeuXZA85wpO+ldMKKRZFobCtbhJQeb6zV
	 B2TpKagp6tT21XCP8N52BAna34dkRfQMS4lyVLsIPGq+o2KYqp+lKWufi2zdO5qOT8L9A
	 6ltfqd8bcCT/0zGyGhiatqR3bYFrjJ3sYeNwd+hGYbStGDKC+ru6+V3TDqcufLlziiyV4
	 WPvxgD+wHage8DsmOZsfN5siNtBECj5UHbF9GRQQA7aKvQFfTPKJbe3afRt5lNAKgtfou
	 6mZl1ifHtbxQ8gBmEBQQaNB05jZyfMoNo3/5xs/eoKERW5tqon5/DqPv72yu+Wv5qdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388181;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=JMnF4PCYPlIbkJ1oxYQongigJralZxvOfmyUW19HLtY=;
	b=X2qI11mTjjrSqe7cO2cMz2WEdcdvZyAbPWSJ7V2o4x6cu7Zfbpj9lob+aa/A7cepKhbM
	 j8mmg+fdO5NGYhaDT/iFidlRK7QyG0QF3IBZfjHiwtRmSd3wUyMT2Cl2768OcAiDfwTtW
	 AnO5LvVCnQcDHtJH8PuVCYSnFp3vDPYWlDzJLC1AYegd40M/tjyKEcXIwaOK2tqKeI8SS
	 HKu6wUuvamhAg6bflUiDt75BzE6Sn6sBzYmrXnV8KXQ5Xj0zrj9aWAgvkKpsGp3jpw548
	 2FMmcBlMBkQ4tOdXRg8qcopUEVcK+zmdxjcj8EEflGqsQTzMIf81Di1KcSSoxDlY3Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=np6JyC4g;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA25606A334;
	Wed, 11 Nov 2026 09:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADA25606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=np6JyC4g
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 9CDC3207B2;
	Wed, 11 Nov 2026 10:09:33 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dTmcJfnknn3b; Wed, 11 Nov 2026 10:09:33 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1C10C207AC;
	Wed, 11 Nov 2026 10:09:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1C10C207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1794388173;
	bh=JMnF4PCYPlIbkJ1oxYQongigJralZxvOfmyUW19HLtY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=np6JyC4gwPXiK0leSmE7U1RXD9ZKRE240QTweBOZiiPZYx1K6ItrrKYFw5dKYZIWA
	 lwTSXlE99t5EX2MY+FkqPtSsJ8gSGtpStj2VurRwRxZ3Rb8onABufuFiNnln1zZSdI
	 wLemyMvB73//2nRZVYcl59zCHRW1WQQqskosuls9/Y/+38lmwhbxx6ftT1QKUCoCt9
	 rWhYho3U1asaMdU/XFoRLNpiCf1CPQHtz+R22XI30kPA9n7/HOHnJJwF+fMEPFSByI
	 chsBTEhmWoz1M2n8gUkaQEUMlPnJs7iFJaF5r2f6yteOg0hlWkDDhjtjBzRQZrws8n
	 ZGoYaOTr/1z3A==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 11 Nov
 2026 10:09:32 +0100
Received: (nullmailer pid 1103798 invoked by uid 1000);
	Wed, 11 Nov 2026 09:09:32 -0000
Date: Wed, 11 Nov 2026 10:09:32 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Cen Zhang <zzzccc427@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<baijiaju1990@gmail.com>, <jjzuming@gmail.com>
Subject: Re: [PATCH ipsec 0/2] xfrm: fix state lifetimes in xfrm_migrate()
Message-ID: <avQwzAEyN98FXtCP@gauss4>
References: <pm-xfrm-core-objects-candidate-0027-v3-cb1e033bff1976f510c9-0@gmail.com>
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
In-Reply-To: <pm-xfrm-core-objects-candidate-0027-v3-cb1e033bff1976f510c9-0@gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

On Sat, Oct 31, 2026 at 12:14:53PM +0800, Cen Zhang wrote:
> xfrm_migrate() keeps the old states in x_cur[] and their successors in
> x_new[], but it does not hold a reference to every state it later
> deletes. An SA with a hard lifetime can expire and be freed by the timer
> and the state GC in that window, and the following xfrm_state_delete()
> takes the lock of freed memory:
> 
>   1/2 The success path drops the lookup references of the old states
>       before it deletes them. Delete them first.
> 
>   2/2 xfrm_state_migrate() returns the published successor without a
>       caller reference, so the rollback deletes states it does not
>       hold. Take that reference before publishing and drop it after the
>       migration commits or rolls back.
> 
> Both windows date back to the initial migration support and are reached
> by XFRM_MSG_MIGRATE and PF_KEY's SADB_X_MIGRATE.
> 
> Cen Zhang (2):
>   xfrm: keep old state references until migration deletion completes
>   xfrm: hold migrated states through rollback

Series applied, thanks a lot!
