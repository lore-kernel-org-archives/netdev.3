Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2DF3CF05E;
	Tue, 31 Mar 2026 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943326; cv=none; b=N/sAfHFApkkc/2CyfkdDB1NWbcX30SaYNYPs+0UgpLZPIer95LVWWb4RPG1pu5qWp3yo+XEQkun9d3vlYcXBAyQW4pXlv5uVVAb3Fp0xTKtmVaQTmsjtO9Ef5iqSVQcu7AlEBPp0xLLIpPqUfKUrVk5DBCAKS/4sCR/smWN1Zvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943326; c=relaxed/simple;
	bh=/t67qqd21VFdjg7fVhZEzL4bAAFMUvic+guZoUhEwns=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvXkaMLaDQE23UWTjroTvPhna4qQgQD+TpTOIKZrD9qL1L5Qgnfbbg9f5q8uBF13NNIhcGHYmvcX8f0Z6l7WyksEKCyC9XLWwZVoBjvq746pgmCiTnAxt3h8e7BxTnd37jSURt7ajqRoQcpF7Di2kO9/mOShNFXPviaKrwwnWRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=bameE7Wr; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="bameE7Wr"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EAA8C207E4;
	Tue, 31 Mar 2026 09:48:42 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uLFMNqg3sQp4; Tue, 31 Mar 2026 09:48:42 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6913A207BB;
	Tue, 31 Mar 2026 09:48:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6913A207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774943322;
	bh=Pmkr6rvdYjCnnfLoVpV7BYGjRGhM4jnaqReV3hgO0uQ=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=bameE7WrQnhpnhdGAEZSPtCVxg/mE6+nBhERnbNlGHPKxP6ILVUA7uCzGKv0t9Jlh
	 nrgYoKyiQvJ9j9RUAv1q8uuIywYM4B6RuyfjI7VbUagXeh7GWO1+9W8b3EuTH0ziGp
	 5YlSvBuCD0ppElBQDjG8TNmMvhUqdjzFFjFW2fNwY1rlDfYdjyToKtZBznAmk8+QWb
	 K+5yLedsubEm2WrLeB6dbbdHy/m/uRzIcIh39pwDcqH1lbnCpKy7em17HyO/oirKfh
	 IjbG91Y59/VwyX3RtBDFgflpqzH9i2e29xI0Kd0vs5kCW9gn0D/Fk0Hzy9anP8ysvf
	 MID+DezsEQqRA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 09:48:41 +0200
Received: (nullmailer pid 1485646 invoked by uid 1000);
	Tue, 31 Mar 2026 07:48:40 -0000
Date: Tue, 31 Mar 2026 09:48:40 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Keenan Dong <keenanat2000@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: account XFRMA_IF_ID in aevent size calculation
Message-ID: <act8WMTZ73-2xXrj@secunet.com>
References: <20260326123639.94056-1-keenanat2000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260326123639.94056-1-keenanat2000@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Thu, Mar 26, 2026 at 08:36:39PM +0800, Keenan Dong wrote:
> xfrm_get_ae() allocates the reply skb with xfrm_aevent_msgsize(), then
> build_aevent() appends attributes including XFRMA_IF_ID when x->if_id is
> set.
> 
> xfrm_aevent_msgsize() does not include space for XFRMA_IF_ID. For states
> with if_id, build_aevent() can fail with -EMSGSIZE and hit BUG_ON(err < 0)
> in xfrm_get_ae(), turning a malformed netlink interaction into a kernel
> panic.
> 
> Account XFRMA_IF_ID in the size calculation unconditionally and replace
> the BUG_ON with normal error unwinding.
> 
> Fixes: 7e6526404ade ("xfrm: Add a new lookup key to match xfrm interfaces.")
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Signed-off-by: Keenan Dong <keenanat2000@gmail.com>

Applied to the ipsec tree, thanks a lot!
