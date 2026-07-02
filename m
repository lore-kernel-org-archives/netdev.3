Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27273D3D18
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978923; cv=none; b=YiFpa1QGOyNv/i6iyVum84HAh8eI1QtkIIWqoP7UYcUCTv1731mDKQqZ7AVjU77cnechHBTeCSziV5keAazlgcEIT9yoRCkET5zlXk/wAZsmhNDeHDJiqMNfzyMhIaXE5G38lM8qnAG0GwVUdxY/Gf5W/l4dwcmZ4eEKH3IIXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978923; c=relaxed/simple;
	bh=SnuOiQtgm7dR+1ORHl8nG6MjP3UwJJoomVDWpxG4P4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLOA3CfxRE07aCopsu6go+vGeM2JTa0hfekX5ol1zp78OCTXOF1IZmb6z0n6NbA609YzW2bsshub81e4LrG/zcWLDeLi5UY0ntlsZgtuxMsQcoVldjrosYskLALbAlbOjuz3gvCaC0h0u5mdeBGM59Mr2AGAyUfSiGeMLxfhhjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAKHjo0X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ejjDzp0a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAKHjo0X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejjDzp0a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782978919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgCsMHap4DaOERPe6xwC6m/dCS4pygrWoOhS3xaJRuo=;
	b=cAKHjo0XN6EppoHF+9jkXjw7F3YaT9QVSwSH2A1gXy9WpI/3n+P8A9eQQQ/2TzjZ4iOxsZ
	uVdoeSdpt6yXGCd4KGiw3ALOnkSi3am91muLzrYfgwpR9IWopInGjhDAJa1FLqaEXDER+B
	Bk8GsBIhPYWQxYk1OH3JN9mGRvWKwmI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-3NfSlZlDNquvic0nqVMVFA-1; Thu, 02 Jul 2026 03:55:18 -0400
X-MC-Unique: 3NfSlZlDNquvic0nqVMVFA-1
X-Mimecast-MFC-AGG-ID: 3NfSlZlDNquvic0nqVMVFA_1782978917
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-493c1bc7a70so14582505e9.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 00:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782978917; x=1783583717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GgCsMHap4DaOERPe6xwC6m/dCS4pygrWoOhS3xaJRuo=;
        b=ejjDzp0aig2Jz9viZrhr0U4gZYz/hiTqnDK41f7P6DAhneaUxtgSSIYE7c3Fzh7ycD
         L5NthzP69f2fZaGVb/Ys7e4975v4q51l6UOADCIzGDuoQsfVxovWwgsRFuEjEo5oCsE+
         4XasdsD/GzouaPv3ZMKybM9syaw6dR6X9G+Y2riHqhQWiDqq7T/ZCtSLLVVP3XxUq8Qq
         N85mUuBYDktfoWB9+vH+H2STIinq2puc7kyF18t1cd/rDHJxa8fUbnd4Bkd+2AgmrQUU
         pFfr1vr7f1Xxg4mMzWalYJuCpAw8FSknJuCsbYq9hi1HWtxxO6CO7LR3B9gpazODmAP1
         PcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782978917; x=1783583717;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgCsMHap4DaOERPe6xwC6m/dCS4pygrWoOhS3xaJRuo=;
        b=gBeZ1XsPNK0wJAwwgAMeB8AvXcmPJQ8pTE4NmAp6PWXtUibji9PHCiNZYxBF1gqmky
         xb4ysO3ovhtQ4WjbRXYp6gVuXiQnpH2kF5V+69nU1+O1PVj5Nol2mJX4xPsxc6rSgz2t
         KfCNmcu3j/dSRtvMzYsZq55Ms7D7gXlRM652MyIno0oD1RjcJQ86dUOqJoDDcRnTovS8
         YZko/8i2lxGo/sMNE7kEnOJRZcONeIfRinUObJFYXDX4HBhhh5/gRahyoFxJgNRJRPTC
         oJ3n1v8S++TxQmT2S1smu4qkk6/pCZgFtItPvz2Cj8ioMSM/2f5zpYPZYIx8B4E8xIWp
         Dxuw==
X-Gm-Message-State: AOJu0YyzzblcEd5UH7qFb+GZN2kPs+CblsLBn/UExKavL7nw+OXcznzm
	1pIRnJoI8AdQT7LE5P/OFNwB32MOFXK4wjWZMVhYuAi+zoT+KKbZuwhxWvrqbjKgiIirn1nWSSZ
	siiSTqeyKbtdvnrKBO7OUnUmCW7D1xmx5TtXGV6isTfZ673TCN0KiUBAMNQ==
X-Gm-Gg: AfdE7cnuFX9qth2iWNKdzBzz9SqWHtqQaEgh7mzD8GfpXh6kB9ZcSlHF3iJ2fHWBpcq
	KfmRqA2xpEbovExSUlJEgtr2lMiXhvKm0AEz1lOiCC2VuejmXTj3CAQt+VIkV412muFUZz9eElO
	8IZuRU3tgP0RCEHvyjIXn8MQwtfzQ0/OCZdL3wnkSfiQYSPArSY5lo4DH8b0TWhYhI7p8NzA6mH
	dzJa+h7MRRehIIRg7B9It07b5jRnlL+93SIEKMoJIIWR89NxrKFAskmdVsEb3O7Ka77RlKHwhE6
	eQcOMh+V0uH0kbnhQythz+fIxJK1PjeiuQCGvWgTYhgeqllhB71+1dV/8OxKoVLz7lNO2KiW97s
	ZVHWJsYBaBuyEBSz5mPGKB8vUYGlblKaTLIygQ9NUj5JqA7tRkHcR7s6jpGckW/OlInWEHzNFG2
	X3RgxzkGaAYQ==
X-Received: by 2002:a05:600c:34d4:b0:493:b84f:9c28 with SMTP id 5b1f17b1804b1-493c2b3ceaamr70724605e9.4.1782978916808;
        Thu, 02 Jul 2026 00:55:16 -0700 (PDT)
X-Received: by 2002:a05:600c:34d4:b0:493:b84f:9c28 with SMTP id 5b1f17b1804b1-493c2b3ceaamr70724465e9.4.1782978916390;
        Thu, 02 Jul 2026 00:55:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dde1ac93sm6530376f8f.28.2026.07.02.00.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 00:55:14 -0700 (PDT)
Message-ID: <4a4fd25c-9df8-4de3-9229-cd4d5f2b7ef6@redhat.com>
Date: Thu, 2 Jul 2026 09:55:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 15/15] bnxt_en: Add kTLS retransmission
 support
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
References: <20260629184921.3496727-1-michael.chan@broadcom.com>
 <20260629184921.3496727-16-michael.chan@broadcom.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260629184921.3496727-16-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 8:49 PM, Michael Chan wrote:
>  int bnxt_ktls_alloc_tx_ring_stats(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
> index 1c935e0d413d..40b94bbf5a38 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.h
> @@ -43,6 +43,8 @@ struct bnxt_ktls_offload_ctx_tx {
>  	u32		next_tcp_seq_no;/* staged tcp seq no */
>  	u32		kid;
>  	u32		pending_bytes;	/* staged payload bytes */
> +	u32		pending_fwd:1;
> +	u32		pending_ooo:1;

Minor nit: AFAICS the above field are touched in fastpath. Using a
`bool` type will likely yield better code.

/P

