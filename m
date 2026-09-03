Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBB4402BAB;
	Thu,  3 Sep 2026 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420912; cv=none; b=ptwN4pASUdYUHRMpQzM9CDm2XmnzgTObHAGmF1+Yzc/XIRlVp1ZlXuVEwhkoMcxTa31C8HGFEeQpCBPdkh1h+beY1LkBzIqm9buOtXY/+GAZc3SACv+QNY0kbFIw52Da/RVbyJ0unpZ7w9e6V7ny5+SoJJ/dtSsmCcxR5FR1hPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420912; c=relaxed/simple;
	bh=y6Vy9A6wVPLLPALeOj8WWs+XDRSs8mCIOs7Co2Kv4bI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrALxW8MD8c3unTceGE9QXzmWsRkT4ZQNiVU45ZJa+r8NI7vKF9Tes2udxdDe/1obrQHeOwOJuGXy/63ZdFp5T1MrEIJd9sClGRIJnrlKSyQTqnzNM2ULL1xpqKdI3Rrxz9o6pY51li7Z13KwEKVrn2apywXYfBi2lSo4SY43BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=x98INcOd; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="x98INcOd"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 882BD2058E;
	Thu,  3 Sep 2026 09:35:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wr7H04nmi7FM; Thu,  3 Sep 2026 09:35:06 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8778D207E4;
	Thu,  3 Sep 2026 09:35:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8778D207E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1788420906;
	bh=qLkK7xo26NgXVWEASB3FlJ++J8k8espZ4kCXrwapU+0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=x98INcOdGLyxR7j+ex+miCEttT+2ZCjQeYqXpbMyXPHXFqc2Q5FhTQ7dKlO8Uu+pN
	 x7ojNuaiTaZwozxAdCr1r8oi0/YxndZfGSmc5KjfWUhYibr7I9rMtgs4XQunzflsD4
	 CUjwJqVBdDY30XuRPZC7T1fe0n8Gf6FdO/mVU/LA7JnOL4u+urUoLh770A5xRWFgGF
	 owIyYGUvVnFNypI3OOYRnetaXJaVRSXJ28dkqGVWWIV1glpjCQsjpnIIvmXCMv/wH5
	 kPUeGsGPFj/JoTkeKE4WTxH7N2kEiQSvU8WiGI05YLxCNXfFqu1iuIT4TRWUxj3R3F
	 0+c45vzw15DyA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 3 Sep
 2026 09:35:05 +0200
Received: (nullmailer pid 1407955 invoked by uid 1000);
	Thu, 03 Sep 2026 07:35:04 -0000
Date: Thu, 3 Sep 2026 09:35:04 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<AutonomousCodeSecurity@microsoft.com>, <xmei5@asu.edu>,
	<tgopinath@linux.microsoft.com>, <kys@microsoft.com>
Subject: Re: [PATCH net v2] xfrm: hold net_device reference under RCU in
 bundle creation
Message-ID: <apkjKMgkC35QKnHq@secunet.com>
References: <20260826201745.43267-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260826201745.43267-1-blbllhy@gmail.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

On Wed, Aug 26, 2026 at 04:17:45PM -0400, Cen Zhang (Microsoft) wrote:
> From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
> 
> xfrm_bundle_create() and xfrm_create_dummy_bundle() read dst->dev into
> a local pointer without taking a device reference, then pass it to
> xfrm_fill_dst(). A concurrent RTM_DELLINK replaces dst->dev via
> dst_dev_put() and frees the old net_device, causing a use-after-free
> when xfrm6_fill_dst() later dereferences the stale dev pointer.
> 
>   BUG: KASAN: slab-use-after-free in xfrm6_fill_dst+0x82c/0x860
>   (net/ipv6/xfrm6_policy.c:86 netdev_hold())
>   Read of size 8 at addr ffff8880142fe588 by task exploit/153
>   Call Trace:
>    xfrm6_fill_dst+0x82c/0x860
>    xfrm_resolve_and_create_bundle+0x21d4/0x2bd0
>    xfrm_lookup_with_ifid+0x485/0x1640
>    ip6_dst_lookup_flow+0x19b/0x1e0
>    udpv6_sendmsg+0x1443/0x2dd0
> 
> Fix this by reading dst->dev via dst_dev_rcu() and keeping the RCU
> read-side critical section active until xfrm_fill_dst() has taken the
> required device references.
> 
> Fixes: 25ee3286dcbc ("[IPSEC]: Merge common code into xfrm_bundle_create")
> Fixes: a0073fe18e71 ("xfrm: Add a state resolution packet queue")
> Suggested-by: Steffen Klassert <steffen.klassert@secunet.com>
> Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> Link: https://lore.kernel.org/all/20260820200245.44312-1-blbllhy@gmail.com/
> Cc: AutonomousCodeSecurity@microsoft.com
> Assisted-by: GitHub-Copilot:claude-opus-4.6
> Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <blbllhy@gmail.com>

Applied, thanks a lot!
