Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695535;
	b=qAX6pDwHw+yhm2Vuyh2SBrXJvpkPjlOZepRX1r9I5JT7nxY4+yFLhutzzqVtE/yvsgEJ
	 tX+thVm7BuLpLTq9wGK63ooHCVjgHGnfUVzjiKsfNR9/eCGKuJSTZphWRECToYXfuBl7a
	 uZg7n5VNsIG8zZ8pevPPngGtbGC8OTjLhtUcL5BhMrBEKqYQTa4jX5kQNJ6ObHZ92McjT
	 92ElthGTN6fSrbyYVSgMzFgTWni6rjX4SWMMoDareG7OkEwTHCbpocAOmgllwSvYvQbuL
	 1EutMlQ20Pyq/flTiFE+woQ694cu7OhhtOjJ/TAjhLyZdSj5WYiowt40dDb+ztB198w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695535;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=P7rCNAJa0SWC+hedMuiPmRIZFFBJmYbJAcz9BWucrSA=;
	b=mHMf+NRr3k9CSZh3LfjQBWNtAENUnN7taqy680xI8LtwNjgaudjjjYf5U2NINzyU45+O
	 bXtYLSzV2iAAsO8AJqVqPOfAv3K+kRuXYbdy7tqZ/3199Bwd1WRv3gH9R+O5kef5Kw4oA
	 mcztf0qyR0eaQRvUulUy8nDil32Aa2TczlGcJkKVqUDMTNssRLgu3jnhTj3t7HEXUMmBC
	 fi4TtQOq4YUyzzAuwmWGwBsG/fkEfR+IAVxkAKlPXI7P+BuSIXdCGLgEgyU/G0tKhFb+q
	 jPGuHH2azQSw20VL3f44433/eMoAFqp/gKK1c4xC9d9gbRSaIchn19A3giPN9PmRLqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NLOZjClD;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=aM+8xW2K;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE01606A337
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CE01606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NLOZjClD;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=aM+8xW2K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793695533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7rCNAJa0SWC+hedMuiPmRIZFFBJmYbJAcz9BWucrSA=;
	b=NLOZjClDve2mmwZBsIwFYoFARtbrFsPeDPJqrppP331zvDZ/KA9J8hMxhraIGTYkBZDRzv
	IENgaVRuOX3vF6t9MsUOSrXZ+KRf1LNN8+VWFtWC7RAK5tfci25OT3gbmo9byq1UZJ4+X3
	xmcWT8ZomQ+6yW+p4zSZnhhVqTeD5nQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-4TxlqfXdMSysbiOSH-zaYA-1; Tue, 03 Nov 2026 03:45:32 -0500
X-MC-Unique: 4TxlqfXdMSysbiOSH-zaYA-1
X-Mimecast-MFC-AGG-ID: 4TxlqfXdMSysbiOSH-zaYA_1793695531
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1fdde384cso27418755e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 00:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793695531; x=1794300331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P7rCNAJa0SWC+hedMuiPmRIZFFBJmYbJAcz9BWucrSA=;
        b=aM+8xW2Kk09QNdXmYlQjsGlRKgc++s76zsgfZ+s4mtC0A4PMK9ST5XEscdQWjKUwEl
         PT3acO1oxauPz48qiDv1Sy9eJC+HOEXE/Dz9/yylfSRQobDrgfkBRggJKISjF3RNqmx3
         6wKNtYIrGLfp2KYRhJegyWBNzCQAKr0sAe8i8JkUXhmXtwod8t70QV08u8//+b/MJ5sC
         MkXjRP3USqahi3EpFs+tgBKL1UzYQVhCIfohj2LywJVv2/KlzJBNBmvPnqKrPC1LzZMx
         7cKJYu8Lf0k8LYrai1xb5dK0fWcTacrFL4aksRIyKSXG4CxbeAndW8jcBZdLWT80iEo+
         p+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793695531; x=1794300331;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7rCNAJa0SWC+hedMuiPmRIZFFBJmYbJAcz9BWucrSA=;
        b=it+i5QbJ3Jc1CY9dZ5xcQZKKrVpSYqIZhhyvUva9rgT7rZjbwOjZaEO3m3IjJzPrQj
         kMHBaD/bxDnvUB/kKFSC4kwkhJMuiOLiM0EcWodEn4+DynTCOJJQjCYOKtHTsjh6Mwi5
         wUwzygPZAKr1jyTWsJHPcOyaPXhCme4pi/gb+FtttLgU0WvzNQZLh96jm1vr2VxE5Wn0
         10dDS+F+pN6Gx2w8lbHOWZ0KnZvIhSKH4bXnLkgTOfRUBOpoPL8B7i7iF/cvFBNkYdjK
         g9chKS08eIy07Zdr1F5mVMiur+Uuxqg8uXBl1YBOhXCUkE/K7++pqIpXBi4M5NvKlQYN
         RO/w==
X-Forwarded-Encrypted: i=1; AKwUvBzfo905XggTgSx4PQapuhT5aGrABtJsyM4F2XLnje1CKAKxR01qpqNZF3sGPzQPK1KF8VX+/j0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Hg4EK3in5ZDwO+DaqEcgpZnMWZ1mM34rkbV+1YGeJl8XB8i+2
	Y2699+xI3MR0mRa+S/1ler5aGanPYIz8YCGCqAisGAslB6rA2VxAFA7pe2Lnt0/W9iMP1QJKda3
	R/2P+s69NY9NxsfzTITzfHCnovOguNTZEeuTCTQ8/wceL2ioF6riFy0kmOQ==
X-Gm-Gg: AYBFou1hKo0uFUZxnjN+tX9mklOp9GSgUe0tGjiwfPtvD5MJqeo3emVnOKbDFL0gLDu
	q9bV3CfkAaHS/03otLYjtxSYjhMotqaq/Tqk9kVmQYTVcqtVvs8WaKQafO9zAvNsSoivr+szz/e
	fiPrXuBUwEHy7T8VMqb5mZnrOvvimUqsxdAyJGALV9CJdJ/ivvip/ZwQLm43jmtGcM7Nk6UBfKd
	NdnIwgL9ew1wk8eGrnLqi7U2wLt/HkuprhoBTERSK3nAekbpuKyrujYmoaYgknNvbAF3cisQSJG
	rvCQkiru5ezzu32xEciihxCIFhuar2JbcmVAWwbdh2teD9JEGyo1OVn/gEC84wUw5dCGETgNtFD
	DGgH7KQZWciIDjplahfZJRbxMCCKzItkdTTMdRrSnXkOBZ7CpNXu2uOMIcrBdER6TGOErLz9m3C
	zrseHuvCkllODa2LmBsx2kqptFm759EGoSb/eCXn++8o0=
X-Received: by 2002:a05:600c:a00b:b0:4a2:180b:3153 with SMTP id 5b1f17b1804b1-4ac185bcc7dmr295995815e9.14.1793695530790;
        Tue, 03 Nov 2026 00:45:30 -0800 (PST)
X-Received: by 2002:a05:600c:a00b:b0:4a2:180b:3153 with SMTP id 5b1f17b1804b1-4ac185bcc7dmr295995365e9.14.1793695530383;
        Tue, 03 Nov 2026 00:45:30 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm81653245e9.14.2026.11.03.00.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 00:45:29 -0800 (PST)
Message-ID: <a555f856-0e74-4579-b35f-9e9c3ed5e8eb@redhat.com>
Date: Tue, 3 Nov 2026 09:45:28 +0100
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
Subject: Re: [PATCH net] xfrm: iptfs: fix skb leak on error in
 __input_process_payload()
To: Eric Dumazet <edumazet@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <20261030083358.2653599-1-edumazet@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261030083358.2653599-1-edumazet@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 09:33, Eric Dumazet wrote:
> syzbot reported a memory leak of the received skb (and its sec_path
> extension) in the IP-TFS receive path.
> 
> __input_process_payload() parses the inner packets of an IP-TFS payload
> and queues them on @sublist, which is only sent after the parsing loop.
> Three error paths inside the loop (skb_copy_seq_read() failure, invalid
> inner IPv4 header length, unknown IP version) jump to the "done" label,
> which is placed after the code sending @sublist.
> 
> Any skb already queued on @sublist is then neither delivered nor freed.
> This includes skbs added by iptfs_reassem_cont() before the call, newly
> allocated inner packets, and, since the received skb can be reused for
> the first inner packet, the received skb itself.
> 
> Move the "done" label before the trim/send code, so that inner packets
> parsed before the error are delivered as on the normal exit path. The
> received skb is then still freed (or consumed) as before when it was
> not reused.
> 
> Fixes: 6c82d2433671 ("xfrm: iptfs: add basic receive packet (tunnel egress) handling")
> Reported-by: syzbot+a3f21220cbbb6e14ee2e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6ae4102e.9c6421ad.36baac.0005.GAE@google.com/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>

@Steffen, do you prefer to take this one via your tree? Otherwise, would you mind
acking it?

Thanks,

Paolo

> ---
>   net/xfrm/xfrm_iptfs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 103cf7c5dbfb..0313a43aa8a9 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -1182,6 +1182,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
>   		/* this should not happen from the above code */
>   		XFRM_INC_STATS(net, LINUX_MIB_XFRMINIPTFSERROR);
>   
> +done:
>   	if (first_skb && first_iplen && !defer && !first_skb_partial) {
>   		/* first_skb is queued b/c !defer and not partial */
>   		if (pskb_trim(first_skb, first_iplen)) {
> @@ -1198,7 +1199,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
>   		if (xfrm_input(skb, 0, 0, -2))
>   			kfree_skb(skb);
>   	}
> -done:
> +
>   	skb = skbseq->root_skb;
>   	skb_abort_seq_read(skbseq);
>   

