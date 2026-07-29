Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D2E3603C0
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 06:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305248; cv=none; b=rinHLfuQQor+nDWhArNyiAgZRRdghzlfMcqIaoXt20XZcqveTI0IGpQdUwsTc5KLXjXQN+nSaYZqvmQAsMcEak3qga8r4haKVUcx+/9XjY4I1TJHJmnPxWhpeyIbogA7AVRloZ+4ROfnEIVz1DAmLDmeZCRHC0p4mfll8/3ydso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305248; c=relaxed/simple;
	bh=WH9S+O1RBVY5yke1/iwPxQQh9XAB9sdN1+g1d0KtVuA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBT90NlT5r5J6RoAnVK7Y8IEj9etEO06y3Jpot6qKlCvCqZGizo6eHVAuVWXnNDDLx9al71TJPZ9cvf7/JSxDyaoiA/ITuJpWpxRkofC/92J9l7x7oMxfxE/TrmsDABb01teFLBVPLq+uv15DOFLWTP9buRPAtsneDfu5PoqGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Fyk4vNYu; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Fyk4vNYu"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A714F20719;
	Wed, 29 Jul 2026 08:07:22 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gExHwzQ8ig_s; Wed, 29 Jul 2026 08:07:21 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D2ABC201E2;
	Wed, 29 Jul 2026 08:07:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D2ABC201E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1785305241;
	bh=NAHUqiNgqzGLhDnRjCTi5J17GnvuolrsTspIQZi5/W4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Fyk4vNYuUQXc+klq49OKfHsKQz1D2ybINgavN5T8QVs0MO14T3AweEwnfbukXMXfU
	 gz+N+oCAXOZtNu2YRO2rAWRQJ0nuJROkehQs1N9owQgDqvlSkTYzqrAekSudW5TSFX
	 Cq+7WotBqQrwN4F6ZSHJTTnC7SFv+8FJYyhE3UYn8ubYAbPsEToXo3CPv7IapcUEpe
	 rYNqOqxqXTUILPx7MQW1CKZRrLRGCVhpqdRNYPcY4HUqYuTahOLxiC8IXwe8lu9UWx
	 6HnbBTU+w6A5jNR6BxjFh6Ahw7+PLRnPJZM6E+i/pFSACN1FdjskjAVWpOKIwl4gVl
	 EN9m0NueRzBtA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 08:07:20 +0200
Received: (nullmailer pid 1563371 invoked by uid 1000);
	Wed, 29 Jul 2026 06:07:19 -0000
Date: Wed, 29 Jul 2026 08:07:19 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Ren Wei <enjou1224z@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <martin@strongswan.org>, <vega@nebusec.ai>,
	<zihanx@nebusec.ai>
Subject: Re: [PATCH ipsec 1/1] xfrm: fix xfrm_state_construct() auth-trunc
 leak
Message-ID: <ammYl8rluWvrv7FE@secunet.com>
References: <cover.1784963896.git.zihanx@nebusec.ai>
 <49598e6a475f779e96c58a0d587790694862edf5.1784963896.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <49598e6a475f779e96c58a0d587790694862edf5.1784963896.git.zihanx@nebusec.ai>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)

On Tue, Jul 28, 2026 at 01:30:32AM +0800, Ren Wei wrote:
> From: Zihan Xi <zihanx@nebusec.ai>
> 
> attach_auth_trunc() can allocate x->aalg while leaving
> x->props.aalgo at zero when the selected auth algorithm has no
> sadb_alg_id. One real case is cmac(aes).
> 
> xfrm_state_construct() then treats !x->props.aalgo as "no auth
> algorithm attached yet" and calls attach_auth(). That overwrites
> x->aalg and loses the first allocation. Any later failure or teardown
> only frees the replacement pointer.
> 
> Check whether x->aalg is already attached instead of inferring that
> state from x->props.aalgo.
> 
> Fixes: 4447bb33f094 ("xfrm: Store aalg in xfrm_state with a user specified truncation length")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> Signed-off-by: Ren Wei <enjou1224z@gmail.com>

Patch applied, thanks a lot!
