Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497B2F7F13
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270914; cv=none; b=FXLcRbSHBFFj2tcj4XzmQ5NbFU0JsTics+5kko71dciNdT8fJRgOcUsFdpBKUADLPbs+S4qOVZ8sg88JEHKYR9TcVHKyFfB52SmkrSyE1PKjHT4vfBoq1jtqDAJd86Z4rkQQqVYoLHgWxVHY3aKz9GLqjIJGW9MsefSdBenqj5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270914; c=relaxed/simple;
	bh=XiAe0wDCBN9qIUiFZ3EJ1wWVBsPwkuZutUn9x6/loiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmcYlaHuyQ2ez6AyC2q0l8sIpxJVQ2cZcTF0eVNknKbYvDmEXJva/TAvaeWphD+A3yxrmsPpbdJuWS5/ui94mqfYPwMyZUvN0KZ31Bw5ypju8m8YxcTFcryRMT8eJ/0+gWigZ/vNh7Q8NA6JGq28/QN/LAwYM8D++pULierrVJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxSE2xkg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sXgweYcV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxSE2xkg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sXgweYcV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788270911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IELIuy/lgZ0/Bts5xLgNTNmtKkiWPFF8haP0FPUICg=;
	b=NxSE2xkgYLom8H7fdVVKbAUL2/od2R8WNIiDqZw8BhYf8h2nh4RDUaXzp43wwvmlduGDxZ
	i3vfaZpN74z5IsbcMGO8h7aTCyQ/BcYO4d6b5mmp0xL/8AMEOH8/FzG/F89/5lVb6ANKwj
	rulatCyGR0yagUJU3B8+q5EBmwmWvIY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-fhbdV0siOLC7_-wptZyQ8w-1; Tue, 01 Sept 2026 09:55:05 -0400
X-MC-Unique: fhbdV0siOLC7_-wptZyQ8w-1
X-Mimecast-MFC-AGG-ID: fhbdV0siOLC7_-wptZyQ8w_1788270904
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49b7c1dc61eso33543795e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788270904; x=1788875704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0IELIuy/lgZ0/Bts5xLgNTNmtKkiWPFF8haP0FPUICg=;
        b=sXgweYcVpWptJnLhwOZfS5Sj97ZlQJthKjJfb494toDFqnLOCkkhUekIF29if1ue+f
         gq6IVjRIO+cxqYUjRGvPGCQG8kTD6ITbgsBmSY2xJLfpEPcYEVE/EqLi7WRWiHs6r3D4
         YEuFG6q1Y3SDy1cX83tiW0Kkz4xzumgG2UIEwXbQGo8rhfK35gz6V9g/sUwhcM6QDLKs
         5ZfXMss4vvPfPsp0VRcBQW05mlk9auhz5015RL5WDC8LIxxIgCfq4CMPHaQfc29uvtoI
         RadVB2JDwkbVJgjzFDxwa8B9jkEr/smcz5FfvJf73dmAY+PHn8g0EZhNs+CMkUSXU3oD
         0hEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270904; x=1788875704;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0IELIuy/lgZ0/Bts5xLgNTNmtKkiWPFF8haP0FPUICg=;
        b=rQkARXZJ4JZpnwtCbQ14ukW+IVnIlcU2Hkws2qIXPTMCgEOS91CnDAy9PO3W0TmSYz
         2q9+N4ljuPxNd186fI6D21YFbrCUtENCDsLcWaN/L++swWHxWEneW3OaOhRHSexm5Rio
         TxYkz4NCX2rC8jnXTRHeumBy7+QJTVAznosuvIjNljbIxTsstKxI5o+FjEJDK3TwnfS4
         kgkgMgY04GA090TAO6o4TF0TRsVq/DUGsaGMd/m1bScdwv71Q4FN9VoISS1ApBml0SWp
         mfZPwp/bBa300+BwAB3htTr3TBJfjgPCyl+s6r+1h/Ok6MY9xvGE9heK0X9vKleqdlUN
         Z5nA==
X-Forwarded-Encrypted: i=1; AHgh+RqMh2YF9qk6V4+b7wiCOmZKiuyo3mtEN6f5GYYWPQ21nDVbXToYYPiSHwoMvKcJSGIUwwS2NNs=@vger.kernel.org
X-Gm-Message-State: AFuF++mMaNaQNm2hMppPnoC7OC1BdHCkQkwe7nmRp37gTSBjXgKmFwvP
	vAkaIrSbDlfWKT4ienHgwC37sCFUB2rOP4Ll9wNFexDzY3xyjiEzEn5VhX5CVYnt0kyba/gtmOi
	lOEUhd9YAtqsEYTja9ndZscmCgHbaydQTsIKVDepe1iymFYaWBcPoHTZLEymxvD6jIQ==
X-Gm-Gg: AR+sD11vi+xu3S7F9l35d/3vYOwO1KeXzwjYjTsyCOgirZjnW6UDvRF+4i7y/sKdhFP
	jebPV5yr3YjNs7A7voTHpZ73CNY/s2Q61jjfcaGHUl12Q1GgWJB08y1vXdmA7vGjcRVMlLDFLF6
	MBejtJWxrUr6Oyw58DuPaF4RMW5sXK1ZQ8N+A9S6fTIFkKC43DIOkgxLe96dbr9qw0mJhlY/WPf
	o1zRjnolXTPhlA9dAN75bBUlllu9m9VWNhODEzfXL2/6ZFv9e2y843opL6pASbUMcXO8airt7aZ
	jBLjP2xaRqH8c4hRyMgKu/B+bsZ0teDrp8YilJpyMQFYmM3vIpo5u/KyZ+XVShrGotaHd6aEmbA
	tUeITdcMd1E7MESZ0acLyC1CFXmjdRNmWCXeTyr7lgEZWcO/fIVBg5CFyVguVYtPiF83F0Lh+kw
	==
X-Received: by 2002:a05:600c:6215:b0:498:952:e276 with SMTP id 5b1f17b1804b1-49ce013df76mr88286905e9.8.1788270903173;
        Tue, 01 Sep 2026 06:55:03 -0700 (PDT)
X-Received: by 2002:a05:600c:6215:b0:498:952:e276 with SMTP id 5b1f17b1804b1-49ce013df76mr88283725e9.8.1788270901957;
        Tue, 01 Sep 2026 06:55:01 -0700 (PDT)
Received: from [192.168.188.218] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cd8b9a2efsm185097015e9.3.2026.09.01.06.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 06:55:00 -0700 (PDT)
Message-ID: <55aad0c8-6409-4c4a-846a-141ba12add4d@redhat.com>
Date: Tue, 1 Sep 2026 15:54:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix use-after-free in pskb_expand_head()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 syzbot+22c4f9a7026c86bcc3b8@syzkaller.appspotmail.com,
 syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
References: <20260831095952.3385596-1-edumazet@google.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260831095952.3385596-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 11:59 AM, Eric Dumazet wrote:
> pskb_expand_head() and pskb_carve_inside_header() decide whether to drop
> the old head gracefully via skb_release_data() or directly free it via
> skb_free_head().
> 
> Blamed commit replaced the check against dataref == delta with skb_cloned(skb).
> 
> However, skb_cloned(skb) masks out the upper 16 bits (SKB_DATAREF_SHIFT)
> of dataref using SKB_DATAREF_MASK. For an skb with nohdr == 1 or a clone
> referencing a shared buffer where only one regular reference exists,
> skb_cloned(skb) evaluates to false even when dataref is shared with other
> skbs.
> 
> When pskb_expand_head() is called on such a buffer (e.g. during bridge
> flooding, generic XDP, or VLAN tag insertion), it falsely assumes the head
> is unshared and calls skb_free_head(skb) directly. This drops the underlying
> head/frag reference immediately, while other clones or references still
> point to it, causing a use-after-free in subsequent packet processing.
> 
> Introduce skb_dataref_bias() and skb_data_is_shared() to accurately test
> if dataref is shared by checking atomic_read(&skb_shinfo(skb)->dataref) != bias.
> 
> Use skb_dataref_bias() in skb_data_unref() and skb_data_is_shared() in
> pskb_expand_head() and pskb_carve_inside_header().
> 
> Fixes: 3e24591a19bb ("skb: Drop "fastpath" variable for skb_cloned check in pskb_expand_head")
> Reported-by: syzbot+22c4f9a7026c86bcc3b8@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a954e27.4d659fcc.734b4.0046.GAE@google.com/
> Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=128e9f5a0f85a51215b1
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/skbuff.h | 13 ++++++++++++-
>  net/core/skbuff.c      |  4 ++--
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 421f6fc454511ea6c7b83d5227481840a7c4bcc0..efeef148e1ba50cbb0d480975dc6c3c59acb98c7 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1295,6 +1295,11 @@ static inline bool skb_unref(struct sk_buff *skb)
>  	return true;
>  }
>  
> +static inline int skb_dataref_bias(const struct sk_buff *skb)
> +{
> +	return skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1;
> +}
> +
>  static inline bool skb_data_unref(const struct sk_buff *skb,
>  				  struct skb_shared_info *shinfo)
>  {
> @@ -1303,7 +1308,7 @@ static inline bool skb_data_unref(const struct sk_buff *skb,
>  	if (!skb->cloned)
>  		return true;
>  
> -	bias = skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1;
> +	bias = skb_dataref_bias(skb);
>  
>  	if (atomic_read(&shinfo->dataref) == bias)
>  		smp_rmb();
> @@ -2019,6 +2024,12 @@ static inline struct sk_buff *skb_get(struct sk_buff *skb)
>   * If users == 1, we are the only owner and can avoid redundant atomic changes.
>   */
>  
> +static inline bool skb_data_is_shared(const struct sk_buff *skb)
> +{
> +	return skb->cloned &&
> +	       atomic_read(&skb_shinfo(skb)->dataref) != skb_dataref_bias(skb);
> +}
> +
>  /**
>   *	skb_cloned - is the buffer a clone
>   *	@skb: buffer to check
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 966af3beed94d0a9f0387cec70b5297eccfcf19f..f4c0645f98d3f2f0c8765403e0184769e928d7b0 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2331,7 +2331,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
>  	 * is not we can just drop the old head and let the existing refcount
>  	 * be since all we did is relocate the values
>  	 */
> -	if (skb_cloned(skb)) {
> +	if (skb_data_is_shared(skb)) {

I'm sorry, I can't wrap my head around the above change; I have similar doubt WRT
the sashiko reported one:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831095952.3385596-1-edumazet%40google.com

that is: I can't see when the new condition yield different results from the
old one. Could you please describe exactly the bad layout and were/how it is
obtained?

Thanks,

Paolo

