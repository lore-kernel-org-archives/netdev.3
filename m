Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793092041;
	b=ADi+KF4UbQSfG2OiM++rvPBwORcIfl39sujiBFD6KBxMT6haKefP832VstwBmpszYTkN
	 hLrDyv60NERv0cy+LTwJSdeYTsXNtEaRzR85oEmjRuj0XziBp5YvUP1og9oYhW0EPmuwb
	 HatFExGQMywsfs0s323DwwQjtG/qAXwPK+2z9Qjc4jNddbdcDPflms75VlSQQ3/6xdZty
	 k9sMWqF0+MTP4Pr7FJxRgmsOX/Ws5M+xjqmmEzWpR0ToV5Yk8pY1bdY1P75GdiqyKEqhr
	 /XJZE54BRDppdBtWr6P62N5dMPI4XRC6eGKbfc8pj4eN+U9mPaWy3w1QTmt2Kufuwmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092041;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=CvG9nuygN0yktJ32UyxWM2+If6+E11EHBfx2QJOffRY=;
	b=kJbm6+dCbTe4uTidM8zAzKC5+2mEyQS0wITkK28Vc59p2Xsn0VPhxB1dpebspzuDTsA3
	 5ITu++o03/SOd2c9u1k7XX/CBKAE1kOrWWG5hCw4ZLxuBisROqtjEs0MTo2/jyeqMOFly
	 rGJoejlw5r5WKCut4mz8FK755Gk/HZL/0ijk/dwYPMzEA8FWnPVSusAcJLuGr4e/Ds9FP
	 9ktF7GVZB4svuaynoFZv/BDcSmuDLSxYIQYg8d+0uiNhnba6wRsR7vm4MZDy+ni9IDzds
	 mln8amrnnH70VY87OSZDvfDRKkWuD+QkCR/z8VepBpiOFTtX78YZmq7uyQ9MJvddMVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IWMnAgtZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZGH3OXvT;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9172D606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9172D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IWMnAgtZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZGH3OXvT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793092039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvG9nuygN0yktJ32UyxWM2+If6+E11EHBfx2QJOffRY=;
	b=IWMnAgtZBibjGWiVemPH0LYVfbX21tcYOqtX0zb2IbBLG1/PiXp60/yLYg9VAnvxm2+gk8
	LLX3H/tU433xLjYsQM84MeKwUCdCBuBj9GDXq1kIXoTT/rrpn0UdfG9lnX+pX5lHa8N8YD
	RTOAPMy7cqL2zYrS/LTXLdgjWsXsYzs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-jMbisS9hOhCPVcHPP3-bsg-1; Tue, 27 Oct 2026 05:07:18 -0400
X-MC-Unique: jMbisS9hOhCPVcHPP3-bsg-1
X-Mimecast-MFC-AGG-ID: jMbisS9hOhCPVcHPP3-bsg_1793092037
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a77c1cbd15so10205555e9.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793092037; x=1793696837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CvG9nuygN0yktJ32UyxWM2+If6+E11EHBfx2QJOffRY=;
        b=ZGH3OXvTbDPuFQS3PLOceC4AkGEYOj6E0wYTqriuirsATNGRSAm4p+UWN0rulZxVrM
         PiP+jOgS6xpKIKWSyOSDFvU+c5g5oKaKWzshtwwcKUTV6LxzQlAkz0FQE33sWVGhsf+Y
         kbsbGK3AVei8YLlWayK/qqjivSnI29T9TSyfmicGXftowA4hXqzAH7vvuVuvMugyiZyL
         UH5eUlWz/JQORgtOfN0WNofCyeklipg9cG9n3/QfgvWfiwExYWZ/FoTi7f0OQq43NJFn
         K7w57jsXLQ+CKfC49fIvKIFguOShYpCBkiFA2AV25mTFODtmWSHeziN2cEAQoCGdlHMe
         qUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092037; x=1793696837;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CvG9nuygN0yktJ32UyxWM2+If6+E11EHBfx2QJOffRY=;
        b=mST7p+Pkjha+yffd9RaGRJTnN0Kle93hNyHv32nB9ZdknxbX0g5PNdNrtqlPptEBqb
         Gzb7kv5LwrW6cdpN2WdejhFpd7nutIhVMWU4qGwWejZHtG7y7RdCsJkGC1AUG8kOTPLa
         57VlYHVFgqzllag8SU9OyVMrSmvIFrYbuAGN/iChH0+zCHoY7WBrvJNGDVubqpmNFzHk
         rebbwqrHz+nBrbkkn/R1Ltu9AptXyQ9H4DygN/b7rGN4mBhy5ylqFoP9ASRxOrFZVLdO
         fHsdTfyz32tQ+M8Lq0lcGOGQAzq+2JjjRZPe49YsPgWCBqpZ8qlJYeoO6WUVCryASd29
         GOKQ==
X-Gm-Message-State: AFq9FYJVxgERyBM5JtyVv3ZmmQTW0Xcf+WH6JcWUoWlEjK74lnJc40Wk
	S8jrQlBYjVzemh6KS1l2g+SO74fMpaG/+GgKP/DAxbAFjfhwDnF4EsdWfNfoygpzqTayq9M21hJ
	4vqmc2pvbbDVvq8z/RgHKkkRn6zDjtMCDza7znb94459VzhVcfY+wURqAMA==
X-Gm-Gg: AYBFou3daoQauuqQbEEB3Fril7i+DRPuvXNYKHgWcyl6NeqQY4nkHDwPoaklc52zPBV
	QX6cXGeKbaH4PZB37e/yzm5nuTwXXfcjb1krPqaiqNQT0cPw6yXzOgnXgkn0HCEgGEXPZRqzEWr
	EmcB6cE1WiIQuysFriO9UcdNgsn1G8YXLjwIB/yzg+Q+eoKn8GO5r6JTCY2IrtPorVk8xl5XJem
	7cuQajN8yH+8nJWZFgAmpdhq3HWz2hLEeCswOI4PndFur4wh6Rq5h4r52Tipsx5MKB+Ki+FuQE3
	B2OxDBa5zg/t749NekY1jQ3+OxXMNk1YJQvfsPikBo8unfhy47JJYMwjXwHp1ngGfWd7fdtrsP5
	yjgYYOuOZ9/xm0YHcH5Dy988cPtl5y54XmHmbTKvopJ+OQeeGM4dqUFaROdguHw4Z9xm49G3E4g
	==
X-Received: by 2002:a05:600c:620f:b0:4a1:e672:5721 with SMTP id 5b1f17b1804b1-4a35ac9956fmr157313805e9.13.1793092036770;
        Tue, 27 Oct 2026 02:07:16 -0700 (PDT)
X-Received: by 2002:a05:600c:620f:b0:4a1:e672:5721 with SMTP id 5b1f17b1804b1-4a35ac9956fmr157313435e9.13.1793092036309;
        Tue, 27 Oct 2026 02:07:16 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5698f1sm250416975e9.8.2026.10.27.02.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 02:07:15 -0700 (PDT)
Message-ID: <0f7f68bf-d02e-4bc5-accf-5f89a599d37f@redhat.com>
Date: Tue, 27 Oct 2026 10:07:14 +0100
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
Subject: Re: [PATCH net v2 2/3] rxrpc: Fix counting of in-flight transmitted
 packets
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org, netdev-bot+sashiko@kernel.org
References: <20261020201258.290827-3-dhowells@redhat.com>
 <179262720290.3135.1509720869529893686@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <179262720290.3135.1509720869529893686@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/26 02:00, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Incomplete in-flight accounting: if a segment that is already
>    soft-ACKed gets retransmitted, its tq->in_flight bit is set again and…
> - [Medium] Behaviour change on soft-ACK reneging (ACK->NAK flip).
Basically sashiko says that the accounting looks still not perfect. Is not
clear to me the new status is good enough.

Side notes: sashiko comments on patch 3/3 are not blockers, but you should
revisit the commit message in case of a repost (and do not include patch 1/3,
postponed to net-next).

/P

