Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792658860;
	b=I0AtzaJ0M+Ek7u40SldosJNXosOH0hT0UrCTMhJT63+mqHz018PVElFNUNm8ABanad4X
	 o2tUzpoOoUGDyKiR60555v2yOvFviv7uTf1l4GjmlgyTQKG5h0v9uU/sts6GZF7ECwU2L
	 Pbnh+IujD8Ipq928J8RqPNqq/S6HnDZdUvx9cN7e3In43hdoLifTRfMpbGYmg5A8941+G
	 5conC5omW8FvzMYBJ+7maPtYY9uZpv/wXJcFHfIJx4Fh6n2+DNrShBxtWu0Fjjly2IWWj
	 lp+xZcJlCo+BVcBo29z+4SNggwzfHyPUB15Ud4hYASYhTbHrzRlGajL4r9/x3e1YfjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658860;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=mFcT8ynUspRshuu6UYRBD2zWkX7djnBDh2i/XBIBseQ=;
	b=L9ZT6klj1MCIn9FASW8ND2alf/pHohYvWM0FF6p1LrpYqzlUDBS/BRL7WfCQfjGPB+f6
	 I/MiYX3L1SYlYKi7Nnt+jpARTwUIZtiTo+dgMMT/u59ym5nb7O8L+0fiTato/1QAje8Z2
	 Ef6KnTSPPn9mydDOKyrDXBcG7roDAfjnjk9PtcwcEt9EPGdjwLkUoGVY0sE257bHvuL4A
	 2mXWfFo9oZBRPQJ5HGxdb7ZrUD4pkHjYB9wnb13nKqMiTwxhZmmr0pr5CeEyGX4qQLsba
	 DU9JUDwjUfnCPJ0Az/6K8uXMjkuuDiSzVPcCV4YegvgFrBAjydNQ9lfuqePPRj0BHbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=of3iFkb0;
	arc=none smtp.remote-ip=91.218.175.164
Received: from mta0.migadu.com (out-164.mta0.migadu.com [91.218.175.164])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC22606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDC22606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=of3iFkb0
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sMu3IWjrwgmguHZeMLeSL9UAeHI88QWMy6Gn0eL/DbM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792658856; v=1; x=1793263656;
 b=of3iFkb0TCdfG/Fv8ZK5wnbi0IiAN86UdO8U3fSumBjlhGae9zyIjP1iXHt1+a8TCEKa5VJJ
 48MumUUZ6cExwudTJ5V6kmSZc1opJ08gjJT1Vch9Cuek1r4DZsjyIrFYhWYiiHFltovNmfkdyoI
 cJOsakrcaTZneOSnBDM3SjJc=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1bfdb275568c8b4d;
	Thu, 22 Oct 2026 08:47:36 +0000
X-Mizu-Trace-ID: 1bfdb275568c8b4d
X-Migadu-Flow: FLOW_OUT
Message-ID: <53109958-a182-4ec0-b7b4-e778b357ec50@linux.dev>
Date: Thu, 22 Oct 2026 16:47:30 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix frag_list leak in skb_segment_list() error
 path
To: netdev@vger.kernel.org
References: <20261021161858.761205-1-edumazet@kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261021161858.761205-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/22/26 12:18 AM, Eric Dumazet wrote:
> skb_segment_list() detaches the frag_list from the head skb and moves
> its members one by one to the skb->next chain. On error, err_linearize
> frees that chain with kfree_skb_list(skb->next), relying on the members
> not yet processed to still be linked after the current one.
>
> This does not hold when the current member was shared: it is replaced
> by skb_clone(), and __skb_clone() clears ->next. If __skb_linearize()
> then fails on that clone, the remaining members are no longer reachable
> from skb->next nor from skb_shinfo(skb)->frag_list, and they leak.
>
> The skb_shared() error branch already relinks nskb->next to list_skb
> before jumping to err_linearize. Do it unconditionally right after nskb
> is added to the chain, so every error exit sees the remaining members.
> On the last member list_skb is NULL, which still terminates the chain.
>
> Fixes: 53475c5dd856 ("net: fix use-after-free when UDP GRO with shared fraglist")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Cc: Simon Polack <spolack+git@mailbox.org>



Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
> Bug discovered while reviewing at Simon Polack upcoming patch in
> skb_segment_list()
>
>   net/core/skbuff.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ab178af02a2262d65175daff7f093c85eaa09c92..beddbf6812b9f387672c7ab5f0a1c07ab9bd0806 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4734,10 +4734,13 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
>   		else
>   			tail->next = nskb;
>   
> -		if (unlikely(err)) {
> -			nskb->next = list_skb;
> +		/* nskb may be a clone with a NULL ->next: keep the remaining
> +		 * members linked so that err_linearize frees them.
> +		 */
> +		nskb->next = list_skb;
> +
> +		if (unlikely(err))
>   			goto err_linearize;
> -		}
>   
>   		tail = nskb;
>   
