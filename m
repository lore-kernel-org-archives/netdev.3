Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470D44163E
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787060305; cv=none; b=q1BNqD2c+raugAYZHAAiWOgOxDGKSQHq6BL6QXUyjZeZr4kvbCFnxVxsnahcjdZOO1H/cSHM+Flo36SOHFPRl8pW8pf0f38zuy2Kh3VyGCuZIcnWgQxD65g6POG35HtDFasvlNLs670jGOJZWxafax2MGOIXJltcHehuZX2Sj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787060305; c=relaxed/simple;
	bh=7d/UxThf+Om3oO0xv+w8OJ5gHmo3M9+tFBsahcTzQE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPLBMK9L1Hf2343ZGTdzg0hkQ95e+8sAdNsC8qCCS23FHVDyspWKoSK0QACD6npwEk5SIoqeic8rtSTHVT+Va6cPZoxdmj5OTgqbnnuhNScIMjH9O8DST62c0tVXpWeRvv4Ay1vwg/syEQwPpwQ7jtj6I2Up0IL8j3O4ZB7xvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FdXnWp6p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=szwimaxB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdXnWp6p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="szwimaxB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787060300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEROnsava3C2BKFmCgTCsJZMtq6m897aTO51jmdGpbE=;
	b=FdXnWp6pnvXF2C1xA/ZaqsuJaHABXC3vU890OigaMDVraCorWJf6QlhxqfZCCUvUDakJ8g
	QKkesPvswZyXo8Cwub7tZQroaMoJQYWOwGKJI+/XHZ98emOdMEKbtVJq78tQiYhzpvNsJq
	/tbLhXpkK2a0QijwgBTIi05PRj5m7UE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-nI2W2dkjOleB1YkRik9nrg-1; Tue, 18 Aug 2026 09:38:19 -0400
X-MC-Unique: nI2W2dkjOleB1YkRik9nrg-1
X-Mimecast-MFC-AGG-ID: nI2W2dkjOleB1YkRik9nrg_1787060298
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a767b782so35523185e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 06:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787060298; x=1787665098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SEROnsava3C2BKFmCgTCsJZMtq6m897aTO51jmdGpbE=;
        b=szwimaxBnCNbXP2wsSm5XDgGnX/oiNzu8NV4YefV6vJIORhrMIGUnwL5uiw7EaN73D
         bcjBuxm9gqQA2bxJRpDm10mUM/7AgX5Iy9aHFBFtPSrg/MTngr3az8fv3M4q9bgkJjhT
         L5far76zRx4l+HcAJcLqAMLaJ5nykK20wJrbVxO1t6/JpvqJguDL0NgE0rTUMH1Z89F6
         gGG5oXCQfGfl+afOZSRZESF+1d6+sGfT0Ans/sbS9dFAJW28Hzz63NxYYU9rHAlcj4OE
         X/zOifRxJxy+wL2ppYwFZw7ZxwfW7fJJwzjcYTW1D08iv+TDki5IWyTcqfBo745IQ7k5
         5CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787060298; x=1787665098;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SEROnsava3C2BKFmCgTCsJZMtq6m897aTO51jmdGpbE=;
        b=ec34A6uLEQv1KA0HUKgL2qLapP8XDpdAm6Z1s9B3Dw2mozhx7bihJKz/7aIN3akA1T
         fiStqjjlhkaYiYMwQ3bo7BfBnx3RYKp4vH3+BHcL4NgYyKngIFqKb6CwDG6Mq7hnxDxT
         Sa4GkO4vPxlGTGaHvtGzieqH+mfLrTOJWl6lfDMm5AvxDBUif3aFROrefNssZ7qZGsGk
         CEjtyKfULII5K2lvnOlLHkONogqPjEt9Azv9goxmanpNQWa5QkriGLXI6pozEJ66y4TB
         nmTJFmKIEHCQGpibzQD+1zUb/gDStQFrSSpfv3+JSEdYdSe8edfN3fLs+6rqQJp1vrEA
         at2w==
X-Forwarded-Encrypted: i=1; AHgh+Rqr4LVkmf+sEY4p9pdv9VckfcmWri6lIuaIsLVSDecWwi8Ry06jMX3yyOK4OwHLi+Kib1XCKWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDckJc29oNd6o1wAqcIMQAIAq+ZwIS063AEujIHkppBJ6zUNO0
	ZFWRU+Vw1Vgts93arGJP3IQG3s0hVhzZI2Ju4xIDgndRxDdnDSwtChbG5AgEmUUh6n9Acx1B9Zz
	KETJC5UhbPfDThVR+V6+Tmi0uapOsg7jYsFhzaI/pZFzewy+LLRF9/u4rzQ==
X-Gm-Gg: AR+sD10mv951m+sd10zkwGbdiNKSkUM6Z0vg/abCs7BkA9mEXXUdNONdD4vtjLlQ+8a
	qvmxaivA+yLTK5wj+AHrVHjhx093hSdMTQSrv1bBz9PM/QTyZ7QudrnF8v9HLmJcLWsvKqWzTZr
	CU801zVjl0ZiZFo4tFgm9a0NCtrxPlf95EHszt0oFvHZnlA418zHnpWIylisB17vrBxaT7hbPCK
	YnZCxwqtRErePYYwXGtvW4NtD5oLiyPnJ4tU+vvZEsyLHoLVM5RyGxs0q9cH3pHFRyzxEAgTBic
	30k6cI7F3tJqcG1pH3AAMyn76nFsnrEYG0eN9cW9d9PJVmK7OODhEOmNGaoYbLwdHTcSI4SFqnX
	P2P2HOaLCGXIDo4gk2GvlrReDr3L9Xj10EabkeOuBdu6gV7tFlL+veYZXHpeFs+F2nqZzXo3iQk
	8=
X-Received: by 2002:a05:600c:4e04:b0:499:9069:c2c9 with SMTP id 5b1f17b1804b1-4999069cf2bmr517922955e9.11.1787060298144;
        Tue, 18 Aug 2026 06:38:18 -0700 (PDT)
X-Received: by 2002:a05:600c:4e04:b0:499:9069:c2c9 with SMTP id 5b1f17b1804b1-4999069cf2bmr517921065e9.11.1787060297632;
        Tue, 18 Aug 2026 06:38:17 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a31396sm12571857f8f.2.2026.08.18.06.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 06:38:17 -0700 (PDT)
Message-ID: <3419e66f-4c67-498b-b42b-30f2ad7bfe6a@redhat.com>
Date: Tue, 18 Aug 2026 15:38:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: Guard for gso_segs overflow in
 skb_segment
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 netdev@vger.kernel.org, Alice Mikityanska <alice@isovalent.com>
References: <20260813174613.2920246-1-alice.kernel@fastmail.im>
 <20260813174613.2920246-2-alice.kernel@fastmail.im>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260813174613.2920246-2-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/26 7:46 PM, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> skb_segment calculates 32-bit partial_segs as len / gso_size, and then
> assigns it to the 16-bit gso_segs field. The division might overflow in
> some edge cases where the SKB is BIG TCP (65536 <= len <= 8*65535), and
> gso_size < TCP_MIN_GSO_SIZE = 8. While normally this can't happen due to
> TCP_MIN_GSO_SIZE, an AF_PACKET PACKET_VNET_HDR socket can generate such
> a malformed packet.
> 
> Blocking malformed virtio_net packets is implemented in the next patch,
> but this patch clamps partial_segs in skb_segment itself for more
> generic robustness. Should len / gso_size happen to be bigger than
> 65535 in partial GSO, skb_segment will now just produce more than two
> output SKBs, all of which will be valid with gso_segs <= 65535.

Minor nit: I think it would make sense to re-order the patches.

> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> ---
>  net/core/skbuff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index c82a1472a5ea..439cbfeb02bd 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4860,7 +4860,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  		 * doesn't fit into an MSS sized block, so take care of that
>  		 * now.
>  		 */
> -		partial_segs = len / mss;
> +		partial_segs = min(len / mss, GSO_MAX_SEGS);

Since on top of patch 2/2 the min() should always be a no-op, what about
instead:

		if (WARN_ON_ONCE(len/mss > GSO_MAX_SEGS))
			return ERR_PTR(-EINVAL);

?

/P

