Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304784;
	b=u6E1ViicJ9YvJIhE4Kfmfe81nNDgM0hvrmw6+faRlB53GTwgY5yCazaI7POOMnTv6m2o
	 /8X7VrO1qr1lVlk77C/ZQxDSDlHDA4vtFmlSMq+OXlJcvpwNhR3fuvs7sqFNHxdLbOZSN
	 tos3eQSs2S5U29Sa+8R6j5fh3D2Vnx2WkqcdPMXtpRBui4ooERA7fUkXskhKZzMbzmqTw
	 yvPSxX7I2DF+GUouquB4u6Lq5NrnpRKicn/4iZzCcc6zP3Q2J7e93nJHjbndoMpmbMqIO
	 MvxjFLk/nWTmvOy6HLm6JPMIpJsSr8oYx0lTDfor6LWQRPu4uGdCcTkKOnjsEpJ65Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304784;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wJOySXG09dMXLqdSSIWuOhORrXWnSA3N/YtRXqebW2s=;
	b=oPor6EBCvLxXU9xYLkKobYiNQXRILXQP/A2QDZ03aiJM9YOelq5F+DppdPwKCVXXn3Wt
	 q4dV9WOWwQ7dn0uuSns0V71JE1UsLZX87JPtI1W9U8oGvsKBziw6KmDxp4v7xKZOHuIAc
	 rwqHzvIEABAVsWqU6fz6aZlYJ0RN7YbSA+PDmxVhSNBojKiM1fumvqwAxsXvjaejqWMbP
	 axQzbyzKXXrkod8kqM/0/FpQLtra6PtAe1pRguwLW5WeoKw8FFrRwhSTRnvgGk0eny/gV
	 wbXZlQFQ1ciFHsqy93U+jLKY45QZ/ZaB6L1gviZaPCSsuQi9O485ELuJWG0zqnR+tWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sr8AcXcQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pwVcifKi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31265606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31265606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sr8AcXcQ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pwVcifKi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794304782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJOySXG09dMXLqdSSIWuOhORrXWnSA3N/YtRXqebW2s=;
	b=Sr8AcXcQs/idA572AS4kHK5mkBfqbzDUhsVXooXETEkLQUhNdhAjrrhn1qTbuC+1RLV99Y
	3t9yLwAtfBq1GB52cSdNh84FMArl5mXWzx0Qsvx8gDze9t56Fu08T5o0AUqJnET7cvToqF
	KOJIb4WneTE/JXNiB/eY8Nt9kDXrIBo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-FqDBtkpRNLS1JXW2WX_m5A-1; Tue, 10 Nov 2026 04:59:40 -0500
X-MC-Unique: FqDBtkpRNLS1JXW2WX_m5A-1
X-Mimecast-MFC-AGG-ID: FqDBtkpRNLS1JXW2WX_m5A_1794304780
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so17729625e9.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 01:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794304779; x=1794909579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJOySXG09dMXLqdSSIWuOhORrXWnSA3N/YtRXqebW2s=;
        b=pwVcifKi5R717WwYht+A5NQ+1KUnmZZJM7aqfetEvTH5Jax/idjFuxSMvglmNksLc5
         qZ+o51ofJXR3ufizsYt/C7nPTmwEl5oCWtcWbEN3A9LXFI6DVFOvlOPwFR+mBvniQya5
         FSiS4c+4lqeC28O3zL0RAFbiutJU+k9EgRX+J+gY1GUIvC3QKDKyqVeLeEAmNFCPMhR1
         f19LqChJ2gvWqT+L73lAiEV9pwoWUh17PA45v/hsBSZWsTlzckDM2mCjzTvh0Q8mAEBi
         /Pqz1/V3OfyDAW0OxAoPyHcnvGqyWjD5dxd4HBiISoxV/cUcDU8GJ9VIricHnmaHp0nW
         bIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304779; x=1794909579;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJOySXG09dMXLqdSSIWuOhORrXWnSA3N/YtRXqebW2s=;
        b=iNCvvyJO5HAB8DsIzj520wBEwfbw6cJ5jB49KwX5Y4dUnnnBftOY+Z9BoznZh4D1MR
         vBBYDhk3mcdNnaUCIEsKHeyCYd/C40R7oPPHnMNNTHazcjRs76lf1agZVlEbtBGjqQq0
         qDzITMAWE6GU3NfhtuhIqegHT05w7ORK7ZkMcf5LTI9T/EcmdH36Retr5oYqaSZ7rW0g
         WxJNukuOD4Ga9uCS0gAwHaF716R11LA9fjc9fh6ct5Gn5TAW92V4BU9UJEwWT0Ln9TY3
         HsptMkMP5P2yhJ3n7JY355gRXKHthvxmmynivQdfkCbTyr2b364+f1+HCWYDup+vSvfe
         AiIA==
X-Gm-Message-State: APuU4Z8D1o5TmJJL8WTJx8cxQsEiJX8//XtQIBBF/BdES5kxk450/lws
	syRM2WvZGjEtq2dDbtU6VcfuJ16gSPuNJKKuCp1ybA/W3hKR/9PfFf2ItVHf518f6qxAI3n6QRo
	irOsxxS4x/dxEQKlttuJ+KiMtCPYxq6AJvY21HRaNyoRFpyyOHDRyT0nrKA==
X-Gm-Gg: AYBFou0PnDfGvL0AD0szz9Wf/tmX70j8OJHkVmQbRSxNmiQ49WXduBwLA9fUtiqrfvL
	vW7J+e5Q3T93l2hgU57YUWZf3YeMOiqB0H+NYofJ2dx0KVdE7pf8b5lsJpB8+RFNLxNR86O6LHQ
	o+LqhO05iE/0oXciPEn1h+uGAPEpz1ZFgMJR+tQ5aeHkmh/L56c6Ff79NTA4Sw3GNNS/fpsSsNa
	adzZMrGiakryqaFDGzM3fZFvPSPrgRwxRJAqUJGyFMCIan0mp8FVl2+GDxckwLsa+3+O19M1qWt
	L9dFA5tTbTFzi6wbSP/4OMLqx7LwtlcXgpCN5Laqfzr4bZn+HpECyn0DRLwUK5TDA4OjLDwzsi8
	Gaqa1QkH1eUQ0Vqgq8JWjGf+xSKwdws11Hm97CJ9C7QLHsnneeSAOBA5nNRn6/xdn5swbaE9Suw
	ESHucdbIpgdkC2DviZqG/WdpXlIGSgDzYoIQYgh1vvmvt4
X-Received: by 2002:a05:600c:4e0d:b0:4ba:cd:f45a with SMTP id 5b1f17b1804b1-4ba0234ee12mr34932625e9.14.1794304779702;
        Tue, 10 Nov 2026 01:59:39 -0800 (PST)
X-Received: by 2002:a05:600c:4e0d:b0:4ba:cd:f45a with SMTP id 5b1f17b1804b1-4ba0234ee12mr34932105e9.14.1794304779321;
        Tue, 10 Nov 2026 01:59:39 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba022fbf75sm44329265e9.0.2026.11.10.01.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 01:59:38 -0800 (PST)
Message-ID: <c3e7afde-65ac-48e2-a89b-9fc1ad42aa87@redhat.com>
Date: Tue, 10 Nov 2026 10:59:36 +0100
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
Subject: Re: [PATCH net-next 2/3] net: add SO_PASSCRED_THREAD to get a
 thread-specific SCM_CREDENTIALS
To: Andrew Halaney <andrew@amutable.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Willem de Bruijn <willemb@google.com>, Arnd Bergmann <arnd@arndb.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
References: <20261102-halaney-scm-creds-thread-v1-0-0b4d75dbf35f@amutable.com>
 <20261102-halaney-scm-creds-thread-v1-2-0b4d75dbf35f@amutable.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261102-halaney-scm-creds-thread-v1-2-0b4d75dbf35f@amutable.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/26 00:12, Andrew Halaney wrote:
> diff --git a/net/core/sock.c b/net/core/sock.c
> index e7405be8941f..6b443bd44581 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1586,6 +1586,13 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>   			ret = -EOPNOTSUPP;
>   		break;
>   
> +	case SO_PASSCRED_THREAD:
> +		if (sk_is_unix(sk))
> +			sk->sk_scm_credentials_thread = valbool;
> +		else
> +			ret = -EOPNOTSUPP;
> +		break;

AF_UNIX supports custom setsockopt since commit
de1c489b57c11fabc766aeb6777ed5b0038fa3bb

I think it would be better to move add the af unix specific ones
into net/unix/af_unix.c.

But that is IMHO more suited for a follow-up; the series LGTM,
thanks.

Paolo

