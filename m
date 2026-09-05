Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E922233956;
	Sat,  5 Sep 2026 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636558; cv=none; b=pQVBFgca1xgbDAO7h5UfTu0PozHk32rwEqR4nbY3Ba/g6tFwY2uNUHRJhU8WU59T3TXxN0nYy8IcgSmBGmuqZxPPg0szP7IGOUheAW9AGMy3TpsAjdkZLR6LRFl7zTcjd0hRMji45vPxn2BqZpnOZ2+WW8N2E+r1wb1vs2YDQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636558; c=relaxed/simple;
	bh=thnuPuvUw6sctQ7uIDS4vEzexRXGoln4K5XRrrAql1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHhX6sGRSBy2/vS1qdscUxRje1Y1s2hfC7CaRFs42a/zRMe6MTYUva/iU8HOK1fFarZRQJHwNRHAO2sqpdqVhLZUeLUihD48PK7fkd2llr/eCzsIYVx748BYli0oxlkLQtbQJj/UK6mn2sICYDE3FWjfqRQHZUO/TpWtDeBGrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YV5jN0zB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YV5jN0zB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=4KWu7PzxU4mkanDyWKCYcDPziDlSOLKCu7A19tMVymU=; b=YV5jN0zB6WsXzQbq/QcUf+wZJO
	W5JdWxkDSrJxlVpQGaCoWEGvAXGfYBhjcj3gDaVyB+jdBcHbSrCJm5e8zvvos38QmLzaopZJUyRLG
	TvyYhcv38wmp4EpCXCkuNQNo4OxteQj1OsfLAIUXT6Gw7ksSc6A58vfhGOUSyvOOGcAVDXgKRh2HY
	yI8rnoLRl9nt/wtwG8geedGmhgjGVUcwZ4iu4QF9YU4N6lnTF+Bg2HYowbHsP4ZeZBPZ8Tg+hQOqi
	YeTb0wgDWCTyI5TcfDoeUDyhEnXRgeT25NIsh//UstGnS0UxkhbiRmuBzdXWjVJnoy7Fgx7uf/XPB
	PW50TRgg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2w4e-00000004Msa-03aG;
	Sat, 05 Sep 2026 19:29:12 +0000
Message-ID: <4ccf8187-325f-45c6-be1b-ca8cad1f98a4@infradead.org>
Date: Sat, 5 Sep 2026 12:29:11 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec-next] docs: xfrm: Fix the two aevent sysctl paths
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260905104625.43722-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260905104625.43722-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/5/26 3:46 AM, Karl Mehltretter wrote:
> The sysctls are registered as xfrm_aevent_etime and xfrm_aevent_rseqth
> under net.core (net/xfrm/xfrm_sysctl.c). The document calls them
> sysctl_xfrm_aevent_etime and sysctl_xfrm_aevent_rseqth; those names
> appear nowhere in the code but in a comment in net/xfrm/xfrm_user.c and
> were never the proc file names.
> 
> Use the proc file names.
> 
> Fixes: b8a99520f78e ("[XFRM]: Add documentation for async events.")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
thanks.

> ---
>  Documentation/networking/xfrm/xfrm_sync.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/xfrm/xfrm_sync.rst b/Documentation/networking/xfrm/xfrm_sync.rst
> index dfc2ec0df380..27e3d151b11e 100644
> --- a/Documentation/networking/xfrm/xfrm_sync.rst
> +++ b/Documentation/networking/xfrm/xfrm_sync.rst
> @@ -120,12 +120,12 @@ in case they are not specified.
>  
>  the two sysctls/proc entries are:
>  
> -a) /proc/sys/net/core/sysctl_xfrm_aevent_etime
> +a) /proc/sys/net/core/xfrm_aevent_etime
>  
>     Used to provide default values for the XFRMA_ETIMER_THRESH in incremental
>     units of time of 100ms. The default is 10 (1 second)
>  
> -b) /proc/sys/net/core/sysctl_xfrm_aevent_rseqth
> +b) /proc/sys/net/core/xfrm_aevent_rseqth
>  
>     Used to provide default values for XFRMA_REPLAY_THRESH parameter
>     in incremental packet count. The default is two packets.

-- 
~Randy
