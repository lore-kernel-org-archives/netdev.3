Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793951275;
	b=qKVKbPBBhu0Ve28x6EaTr5RMAqVIj54zwrkEfL/GGpVPDSeYH//WcH/tZqAjB/LBWrhm
	 9ARjdO5TmSgUxJgF93vxvTu+VMKKt5+D9zAvzhtLGfOjNZ0AmG5nCOlp/J2TubNpSyUsz
	 ZTzTq42RMt1k72TqNNwM2edcCdr98LBinkn0ZoxmbKsIBy649lkHVA+ZiNO0xbpQdKXb+
	 LQLv6JCpS3i5vrBZvPfsufZyyuZCgCq4wKNHxF5iWWd/3XKPKvhU9dHlH79aFSM2EzBQy
	 Uh1s+ApXeVhnon4JuK8ZG5QmIc29kR3el0KVMMxj9mBPuBjhYhDbU2GslNZkTIw6r9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793951275;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy;
	bh=M7E3LRbotPWKmmFgsX76tB+mPSLjTY42TzuESKJJn4I=;
	b=Ui0gHoBIyfv0rDK3si7CwN7fYlammxaFlEGlxksVDATYc3fML3ZortgWOeDQMymWiLeI
	 TlosnEQxUYae+92ixIJRh+c3BNfqXxmQCuJWvpJEIce0YFR0A036afsHdWrbhJ2DOFFmK
	 RwGriMgSj7g7jSiXcK8xg5ZDS2e4KXjlOFQBXcgQOI7B5K0fcfZ09jYZkKbMIsdA8gk0o
	 ZygITvycGIry00O5g+u2gxImLdW/InxTxPWWfcUPU8qUuTjCC+nEcSuMtvIgvckYvg2Bh
	 6+kvWH7JO6pjqAssvzCNm/mcisvH91uqjQ7SHk9zNxdk+Jn+Nv+Q0ReuMuPYCjBdJgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=Z6ijFVVn;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A4606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 07:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED1A4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=Z6ijFVVn
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A4B75207B3;
	Fri,  6 Nov 2026 08:47:46 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xyEfOV409eUE; Fri,  6 Nov 2026 08:47:45 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id AE8992074F;
	Fri,  6 Nov 2026 08:47:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com AE8992074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793951265;
	bh=M7E3LRbotPWKmmFgsX76tB+mPSLjTY42TzuESKJJn4I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Z6ijFVVnXzVJkolzj5cPCgCnXXaCXHSMraRVIRupBrbR8uSUJNiSkrRIqGxQXBJEG
	 1gyrXQe3LuvZD3CNB4YM7enSId2xCxXk+mwg4yx2u06nkXNiGCPpPJd67WhEjonQgD
	 hMmLzRub8lTb4GJu2vzZLv/jeKt8GUZdMCr9se+zPxW+kR9NpA0DFRQUje265kV/jO
	 NiTEOkMaNT/xKanDICb1uvGqhbzgtpJWnSDS4OnOB4GJZ/Bnu4ma1kYPaTUG+8Qt50
	 rbyS/joHG+XD7mbmqcKcT7jtDuWIT1Dk61sV/UJrE077f0AddkpfojEjrvTmSQX8NW
	 LnWuHVPBRf/eA==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 6 Nov
 2026 08:47:45 +0100
Received: (nullmailer pid 3068588 invoked by uid 1000);
	Fri, 06 Nov 2026 07:47:44 -0000
Date: Fri, 6 Nov 2026 08:47:44 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <vega@nebusec.ai>
Subject: Re: [PATCH net 1/1] xfrm: ipcomp: account full fragment pages in
 truesize
Message-ID: <au2GILb3-9bN1i7G@gauss4>
References: <cover.1792692779.git.zhilinz@nebusec.ai>
 <7f2686a7d3d393a0ef9eb7a2a2abe82caa7874b2.1792692779.git.zhilinz@nebusec.ai>
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
In-Reply-To: <7f2686a7d3d393a0ef9eb7a2a2abe82caa7874b2.1792692779.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)

On Fri, Oct 23, 2026 at 02:32:17AM +0800, Zhiling Zou wrote:
> ipcomp_post_acomp() allocates order-0 pages for decompressed skb
> fragments, but on input charges truesize by the decompressed byte count.
> When the output ends partway through a page, the unused tail of its final
> page is not accounted to the receiving socket. Repeated IPComp packets
> can therefore retain more memory than the socket receive-memory limits
> charge.
> 
> Round the decompressed length up to page size when charging input skb
> truesize, matching the pages attached to the skb. Leave output accounting
> unchanged.
> 
> Fixes: 7d7e5a60c62e ("ipsec: ipcomp - Decompress into frags if necessary")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://bugtracker.nebusec.ai/f/13830
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

Applied to the ipsec tree, thanks a lot!
