Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE143921ED
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748625; cv=none; b=U1LqlNImOMW51GWyHDmB91ZHzwPyPCmrNfFz7MjOlSRnLA/RRuyb3U80R9s8V5oU9kWWKipf+ScqF0VtLbsx13yI2/wyy99U8d8Vb9sLIO6brYkj0LzjMR7YVBTHq64jXSwK2V9+5m/ZlReaSAm0hzvuA/xRjBjOuyrM6GU6fmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748625; c=relaxed/simple;
	bh=bIA/4286zBliQQLF1msK3HEmYIXsy17YN22huk5/dSU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJ1AOolTR9m6wAYFyH9LZwzp1TwR7YNFW5cqDWoqFhXdv/S/U8edUm20RfriRqEg+YF00+P7U92KWg3sChSo9HlgF09wYlsms8Tioux9GGBrE1D/p0httYoxqfyLFzh9TaCsKPtwWzcv6YffgQtchvNVA1UL8KOEQUMgtiIwIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RN6JVAga; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RN6JVAga"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EF753201E4;
	Wed, 30 Sep 2026 08:10:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5gy-vrchGzk0; Wed, 30 Sep 2026 08:10:13 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 15453201C7;
	Wed, 30 Sep 2026 08:10:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 15453201C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1790748613;
	bh=vGUas1gJ2n72uZgLXpR08AA4GN20V7xYHxD1pSZMpxY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=RN6JVAgaRrmpicWrm7Uq+fbnQ1BV5tDpOFl8k+evNY+gjGzCZlO0Cork+RGqIdvu+
	 4P4KdR4DMoXb6dFPBuvlibDlSYcd+KkrKOelwcgrFDtrQMP0PIBrYUsnoOPzvEEhaT
	 TYD/0d2CW2ab8ovh08A8e0zr4IFvartRYvyoZa0T5GX+LSCLV0BM4qoR5D7DoOLi6L
	 7bEPQk4vFmrw+eQoW8Iij86Lcb+jiXgLCimPyI8hXGS4O6ppeKYK4kynE+waUxmTYZ
	 syVyV+RjNUmMUovvfzapFzpL+xZn2Q68uamUP7T8DGvL++sWq+cp8LKWKUouJlw0Ru
	 +J+qqoefbE5aw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 08:10:12 +0200
Received: (nullmailer pid 3766538 invoked by uid 1000);
	Wed, 30 Sep 2026 06:10:11 -0000
Date: Wed, 30 Sep 2026 08:10:11 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Antony Antony <antony.antony@secunet.com>
CC: Christian Hopps <chopps@labn.net>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec v3] xfrm: iptfs: fix pp_ref_count underflow when
 sharing page_pool frags
Message-ID: <arynw0nTgPsIHCUR@secunet.com>
References: <xfrm-iptfs-pp_ref_count-underflow-v3-1-9266ddaf3129@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <xfrm-iptfs-pp_ref_count-underflow-v3-1-9266ddaf3129@secunet.com>
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
commit a719ecd0c8cfff38a8b6302ad3d654603fe9e7d1
Author: Antony Antony <antony.antony@secunet.com>

xfrm: iptfs: fix pp_ref_count underflow when sharing page_pool frags

This commit modifies xfrm iptfs packet processing to correctly track page_pool
references for shared fragments. It introduces iptfs_frag_ref() to selectively
bump the page_pool reference when the destination has pp_recycle set and the
fragment is owned by page_pool.

Link: https://patchwork.kernel.org/project/netdevbpf/patch/xfrm-iptfs-pp_ref_count-underflow-v1-1-5fb363833d41@secunet.com/
Link: https://lore.kernel.org/all/xfrm-iptfs-pp_ref_count-underflow-v1-1-47b319c6d2f6@secunet.com/

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 6920940a35b49..229f84ac6a31b 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
[ ... ]
> @@ -449,6 +450,20 @@ static bool iptfs_skb_can_add_frags(const struct sk_buff *skb,
>  	return true;
>  }
>  
> +static void iptfs_frag_ref(skb_frag_t *frag, bool recycle)
> +{
> +	struct page *head;
> +
> +	if (recycle && !skb_frag_is_net_iov(frag)) {
> +		head = compound_head(skb_frag_page(frag));
> +		if (page_pool_page_is_pp(head)) {
> +			page_pool_ref_page(head);
> +			return;
> +		}
> +	}
> +	__skb_frag_ref(frag);
> +}

Does skipping net_iov fragments here cause a reference counting mismatch?

If a devmem net_iov fragment is processed by iptfs_frag_ref(), the check
!skb_frag_is_net_iov(frag) evaluates to false. This bypasses the page_pool
reference tracking and forces the fragment into the fallback path, which
increments the dmabuf_binding refcount via __skb_frag_ref().

However, when the destination SKB (with pp_recycle=true) is later freed,
skb_frag_unref() calls napi_pp_put_page(). Since netmem_is_pp() evaluates
to true for devmem fragments, this erroneously decrements the pp_ref_count
instead of releasing the binding refcount.

Could this lead to a pp_ref_count underflow and use-after-free of devmem
buffers during IPsec packet processing?
