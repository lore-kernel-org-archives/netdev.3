Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581611;
	b=s8KefGm0SyoMQy76jj+taPHeuIiW4IMCHM5W0ZSNHqsItpCE96Cem0RytLx0td56Fv+F
	 wsoLrjL1hVmJMRNdmeU4reG8y8PIzwRyc1lb8Nod1bz8vn2Zdf69JKYqOSrqm9pPuTMoM
	 Z155VNv3ZthbdjdfMGI9DMBSYTIBteaft5zSvbAcDkt4Bb6razme1BPKKpT055UCnupb3
	 0okiWmj5IAHF018YAwdyX+Kuqjss4d/ohGiw4X/UN6iRzHBWD0XjpOxG7n9Bo45cfncJq
	 HhOvxWay+BoR8dCG/fktQ8/Xh7o6oR82Zvcza73ihQGCjfitIndTdcAHgIpDstKDMmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581611;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=w5qHsNBL65JXSuGYZcD4Ld5r7zaKVLOfeXV37O/9Nzs=;
	b=qVZxTH0MHat7CtGkbYRgWg02WbygfUhaNV6pwTfK6gltmCL9Wc+4beUIK6IoBcqznRsk
	 pUBlECFUd5jbQxF0hpUtfA2mtlPBBVih0r3erCcNJj7eJMhVwpArh8Jlq3SvuU/9A533b
	 JU9IPU957TUxRFBbh/44pK45e6OhJ5hOk3iScZQ5xoc2vgoSNrnFWhJdlObjFB4p1yu5o
	 nED0Nc37AWg600w1vewuq3MwoHW5Jy1ZoS6/m0zNz907QjLLuMWegU1NT/hYyBLWd2/Lb
	 kQKaH3jgYGWhUs6HJBlPfo+NV9YEfkD31kde9v15GfYxwDz33q/681BnEPDCAbQWVtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BWRgO6LZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XwTvSYB4;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97900606A320
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 11:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97900606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BWRgO6LZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XwTvSYB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792581609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5qHsNBL65JXSuGYZcD4Ld5r7zaKVLOfeXV37O/9Nzs=;
	b=BWRgO6LZFei8+iDbqTXT1QpJQN06VdsZleBWZTpPbmXnVeM7qjT84iEb1V/Pqg2NcSp9hG
	3kfDwMuouDQnGM43bwXQq7d4PWQzz8zFhmYbhLlbfs9mAwLDL80Xfjs0e5HFkkJ4QFYo0x
	Vm1XcNaJjfZUIP7YrtzAkwI/VEpJCpQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-wLY1zr-5OdqRQ8U5AHuAwQ-1; Wed, 21 Oct 2026 11:20:02 +0000
X-MC-Unique: wLY1zr-5OdqRQ8U5AHuAwQ-1
X-Mimecast-MFC-AGG-ID: wLY1zr-5OdqRQ8U5AHuAwQ_1792581602
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-990885654b4so134153241.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 04:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792581602; x=1793186402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w5qHsNBL65JXSuGYZcD4Ld5r7zaKVLOfeXV37O/9Nzs=;
        b=XwTvSYB4U+h/1fZUmyzfm0Uyywv7yMCGHinDDSATd80HdYXOPuR5M/WMmqXN7SlRm5
         Tq1YcSPP2zKDrEiLmrbfgT6Ubu4dzuWXd6Cpbjundlh3k07YAcWqbEYOzGAh/6ONmtb0
         1hE9kjxCyKoWwulReIWyw4vj+TPydcq6DHspY9A2nBnYz+rr4GtUWHSqiUGRqrn8+drs
         UynU8UMa6N2I4rDdEMxWRpb8GDqRFK0bQyfuGvwWwi9x37dLZa05xsT8oGvTItW2ZKVJ
         BRbmGeG+X+L7CWrBGgzcteQMYJLR+EBJFeButojohegGCShCyA6TaaoUcsdD232WYb2E
         VGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792581602; x=1793186402;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5qHsNBL65JXSuGYZcD4Ld5r7zaKVLOfeXV37O/9Nzs=;
        b=Bb6Odktn1LrOXGCcJ69lA+YsCw/rL+FC2AzMTyJsuppGSUzIk+WBgzxJvbHd3SsrWT
         6ncI3yDXmJpJBcdkyGyePANR0AAMcWG+vs6wfuIvWkI0IHC05prWhOOkvEX4Lv99+xpc
         jOoIlpcQXvX9jmUY3NbDigzWBzvAti7HWqI4jDDi3L1+6Etv6/UAj4FLQT7y8sY+EA/s
         zg4hfMKP9QxHek6zjcBuQCJliBH4nzmeEtDMBNyZ41yhvY7GAnN47SsiAZOsrByNtNgb
         BAaeeNrohVy7xPtC7ZILk4PZ9fRZP7XGnjABV5EEWErFN/PMFxRBafGKfwxgDYxZvID6
         vNyg==
X-Forwarded-Encrypted: i=1; AKwUvBwPJzTvCoiYSL1qGyNWLzVt1C35JsA0/DZXDewRjbNrKdYinbbz66lBqNKBcvbcVAqw1AF+ans=@vger.kernel.org
X-Gm-Message-State: AFq9FYKXwxqysyvtX1oXvkQpAxnNodB+3OBn54x9435jrhr5iry24oAn
	sRA05I2iyiyM43CkTzwlkb+o+YKGzuMLSK7P0TiNbUem9Jyycr7/0DQ89ctUxv9idIFHvU0SVaR
	pwTQ16Kb7aEGQkLOoqpnlewJG858vppM3JT7/DNBELy9Op2dL0PdxDFwB+w==
X-Gm-Gg: AYBFou2mlBxC9cGdnZIhkqMPmBDLBwV2gZAbuyLZ4aTHEwsOs/1oquvyVpS0jxELpQH
	bzIHWCWDPlU2gVz+vsudq08vfJvoa3sM1w4KGUTfr+EGV+7rg0+cDS2o7ol3yYZMizOuWwyl3q6
	xbD1W6MqpMpPyESvSed6D9sc4n1MCGLmJnFR4Htp6PSgPWtK7fgYYYukmt6Tk8+9g+3poRDkva8
	1yqrzsQfTy0rxsPRygg5RmHvBWIguioMHujcD2fQBtgWcB0GVQSXcC2YTrR++/bZuWHUpQxxVx6
	GKsXvy6hN1l4ZKrafLR8QjF/P2ky3GrMzE8YKH4/hWXkZFv/sWCc6L110wagZPi/X90mIYLUIzH
	s7AJcrH9XbqvgzRmr07A20b2jBBJVtG/6mbms/O0pM8q/ZMxYpHqCHnGCe2YveI1wEvOXGsXRbQ
	==
X-Received: by 2002:a05:6102:1492:b0:7cb:bbcc:e52 with SMTP id ada2fe7eead31-7cc922532fbmr613450137.0.1792581601755;
        Wed, 21 Oct 2026 04:20:01 -0700 (PDT)
X-Received: by 2002:a05:6102:1492:b0:7cb:bbcc:e52 with SMTP id ada2fe7eead31-7cc922532fbmr613440137.0.1792581601238;
        Wed, 21 Oct 2026 04:20:01 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d12049e1sm2688668241.12.2026.10.21.04.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 04:20:00 -0700 (PDT)
Message-ID: <313fdacc-a8e9-40b0-a125-2317ffaae79d@redhat.com>
Date: Wed, 21 Oct 2026 13:19:58 +0200
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
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-21
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261021102756.1900679-1-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261021102756.1900679-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 12:24, Marc Kleine-Budde wrote:
> this is a pull request of 11 patches for net-next/main and obsoletes
> pull-request: can-next 2026-10-19.

This is a bit tricky. We are already into the merge window, we should
defer all 'next' material posted after the merge window start.

/P

