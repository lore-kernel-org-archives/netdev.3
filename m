Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588652;
	b=t1qTj+zXehZxW4+OWy69QFu9oMfZiR6ZSMXT6CLs5SVzngu3H6GeoMa2MKzIMzn6C/Sr
	 1M9da8DlQxd9vMkxQDuL1NaXyOVLEscPKSCX5UWTWLdKF+qKek4YuzzPKyzruR/Fy7Z8l
	 3P6dUM6wkh0F2xDadC4YV8kNIdGA7yW3xgo+ukfsXxLQPZij8f882v/b8vhwU6cR6h2He
	 NoVzKgJ1JA74DVk+VxmiVqSX1vKohiZENHAWjs4AtLfFcJ5N+nxk1L1WDO7UUfhK1LYhb
	 5sKhBdILbYwlSgeBPQ3Ug6uWYI5bwkxjQjTWdknAVAwmv2D+EYhKmqAnOw1nPB9VAww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588652;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=31RV4AzXCiOH03RZ476fgvMqieB8iJVjkSkupYACOAY=;
	b=oPOtue5bHpnzcT1QiTpaOUSa2MYVA3gN2trMzigZEJmoqdU0R8FLgN1v7LE+JKQHGPyT
	 xx6EIW6yaGXXSc/iyGMlNbAw4snfY3hgHtZobFQZifMZ1eVtDwvHZo7MNsUhioa3Dgn6r
	 J2vji2YiiZph4zGxJQDjAeCxHyimGAjJpzSG/ILNK0YgQrfwx9uj175cW3xL26kmyqO0/
	 2RQ6xDy6WoiBnmFKOOABnRiPqy07iDbx5Ny7WrBIf4oCHtg3YIGDV1ycw/KSuc53hoBaF
	 eF1JzPeD72x4AZl6MWkW3dr6c9wbeuRYTYpsVEtC0yXKdjeczl3xTYAP6xX1zR4+wrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yz9Kp7Ap;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eg76vGkN;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5C606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBF5C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yz9Kp7Ap;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eg76vGkN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792588650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31RV4AzXCiOH03RZ476fgvMqieB8iJVjkSkupYACOAY=;
	b=Yz9Kp7ApJfYacNAjlwfAHBJWZbV//mi1e+pHSrR7Yn3oFgpPHTn29jcD6prwIqmhY121Wd
	LZvrAtfJcdGIcPaNnxoJrzbBBW13Rg/cGmCERxdcPZXz0yK6vCnwWe7BpodGb94VEOWyv5
	4yC8edN1wX2gue/xSdW9alzsn4+eMwc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-qyeb9ZwnOOOcI2dH82wYDQ-1; Wed, 21 Oct 2026 09:17:27 -0400
X-MC-Unique: qyeb9ZwnOOOcI2dH82wYDQ-1
X-Mimecast-MFC-AGG-ID: qyeb9ZwnOOOcI2dH82wYDQ_1792588646
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49953abe51fso5689025e9.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792588646; x=1793193446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31RV4AzXCiOH03RZ476fgvMqieB8iJVjkSkupYACOAY=;
        b=eg76vGkNw4/4tmAUmpwQfKsWcJKDPn3FZ5VkoB7bkN8F9dBePT2+Tcug68IOmR8SLl
         7IIrmOIoflIf/bqHlKxDsZ48pzDV8Oy/ugWsKsnV8wyn58tTbPbTbETArHghMnhKe6Tg
         gXtF7i/vn3jrBdso38DiswmFc+zSoMODXm8BNT7eamcxwXg3CE7EYNXRj5kqC39iBlLS
         UU90I4LuSPB9u2A7HiKOZaQcx7jWNJfYbnaDNHq3KtHV1A+BqKDMtsSDGq7AnOKCGVUO
         Jl8eVK8TcJuWh8oZmVgaIMUg1M3UhWb9eosY6JNGr4vq0Ul4oZtFmclPqtKJXDDQK0Pg
         0k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588646; x=1793193446;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=31RV4AzXCiOH03RZ476fgvMqieB8iJVjkSkupYACOAY=;
        b=Ihv8C3uBCm88zuR1MNq5CDP1+e+zzPtHy30WVBl8/XAzxqnrSNdfeAYvJp2lQV2Snr
         Bi8WI1juHpv1ePgfN3XXxLOYjwZH4et9MRKDQg81aECvDGabGDej+6/XJVxxDgIER88h
         ZsEtoxz3HdDdS8C6R6wJ99E1ltqJVGa4XMOEeoGyvXzMsYjvTZRjC9JMcRRKy9VKf5ZS
         m7zq9wTur0GKI/GyuRHyjtm5YVNfpqnC542GliOpvU1zgeOfBnpoPfwyslWZ5aeLQUAQ
         MdXDlJMx/EnP2h50CFT6DG+ov8lunv3waUgc3sk/aY92c/47cntiTHqqeQRN/+lIySbU
         TpWQ==
X-Forwarded-Encrypted: i=1; AKwUvBx97UrkrBhmkmiXkgZZUujBBWxa2CYkoIj08KZTxx+sM5l/T4KWfdXZ7x04tbo/VaoNLJj8EFQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDCfBL7YRGzRo49dql7G7j4j9C/VgR/7IpGBsroGow9LdbfK5O
	fyEo6jfoJNBSPhejCXS+x8K2DbTUFU3TQZG/qnIHc4H4xp616MBfk5xY0FLChaguJ6yOvT4BZ2B
	yAPe3D3sGxg4XXKPclAl74ui7JUs3MoQqgTIv6kpOQA1iFHW3D3OflNcmvQ==
X-Gm-Gg: AYBFou32BFBpAr46M7/k958XOoQZhmGkprsPe/tsd+9PM8+25brRhdtW9SE1PY73M3m
	CX/20TacLRZ1D9QN7wjbEt/Rbvl9WqD+96wNwsazGIRp7ffFphOu7le3EE52qZLTvfEwviWEmCT
	MNE+C5oucmCzw/Ajr57hBtVDWxzWjlBDUFsNrD1BmAit8sS1VPK2z7LoiDpViGuN4Ke+IxokrFq
	iocEpIZempZVctCocEcuPigDFuNvCBpmRM7xBrGvnFwT3ptTSJDh70f3dGAp/cCGjuWXsoOaHq+
	GszbQmMmSsIeaMzPTvnuUH3jWk9ExJwfn9sCRVz5KIZB3cMV/mhkDA7eWoFs6S+VIA3Jb99hs/1
	PlEFpo54n/EtE6HTJncvu1uF2KRjceJW3diw5bPY1dA06R/AaWTRx9jHSBBNK09s84OPWyJ2mUA
	==
X-Received: by 2002:a05:600c:b86:b0:4a1:90d7:88a8 with SMTP id 5b1f17b1804b1-4a1fdd32c79mr43546755e9.25.1792588646313;
        Wed, 21 Oct 2026 06:17:26 -0700 (PDT)
X-Received: by 2002:a05:600c:b86:b0:4a1:90d7:88a8 with SMTP id 5b1f17b1804b1-4a1fdd32c79mr43546185e9.25.1792588645813;
        Wed, 21 Oct 2026 06:17:25 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc10de99sm49144505e9.1.2026.10.21.06.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 06:17:24 -0700 (PDT)
Message-ID: <c67725e6-ee8b-42b1-973e-534814712ea0@redhat.com>
Date: Wed, 21 Oct 2026 15:17:23 +0200
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
Subject: Re: [PATCH net-next v5 01/14] net: ethernet: cortina: Keep shared
 free queue parent-owned
To: netdev-bot+sashiko@kernel.org, linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, mirq-linux@rere.qmqm.pl, mhun512@gmail.com,
 edumazet@kernel.org, netdev@vger.kernel.org
References: <20261015-gemini-ethernet-fixes-3-v5-1-b5c9e2f7b8a3@kernel.org>
 <179243092325.3135.5534691456764566511@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179243092325.3135.5534691456764566511@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/19/26 19:28, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 (1) · High: 2 (1) · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] At this commit, gemini_ethernet_remove() calls
>    devm_of_platform_depopulate() (line 2689), which destroys the children…
> - [High] net: cortina: MMIO access after pclk disable in remove

This looks relevant and legit.

@Linus: please note that submitters are expected to address the AI comments
on the ML.

/P

