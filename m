Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275234;
	b=MfDga57nug5+BHE6G+L8MnbuSdKEv1w+h+KiSmHrz9y0+Zzv5qyqq69soFFRJ8/rIHIC
	 qPq3SZciLXGFHd8TlzHT2XQgjvwUQzSFgNN+Jv15B+/bTXZLm2s6mmJxhXRyiHoyEXSt6
	 6GP3WfVJs2qC8u5u/Vvjg0hZMF4ztafPvl5HMBiX9Cy1oR8gFrIcpkbR+aDD8VgRmN2Y6
	 ERiGCzgqQICEcae718SPXM3SXbeuiojUFMUr/M9QlOGErV5pzqenTogBRBDgJJYkGo4aQ
	 u5IEmVZadU2VZFJR80g50kzvSgBOVms3euokhrpAbEUAqZRMh3IBxqwJnypWSsvi3Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275234;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=uiB5CX6SbDNNbgC0+8PGZVLff5sDTap/tEnkGLg1G00=;
	b=a9lam84R08Ir02Pf/uVmx56E6AYwEo94PgKw0F/R7M/c8NiPLvzl+AEfidNcRNK9xMAE
	 Q2PrPdemGiwRxDhnfHOuurywXocvOgE2tAuq5R0zWhK7F+EhU5O2CUgakka/DeBo99c/5
	 ngVz7XaJn8EJBum/oSk2fHC59k4K2SzwHJIOdVY6sYrTs4QZY5r2bwjsCRIsLAZmgMsv4
	 V3n8w/9SHcLHTpp/AjIpPxrVE20JpvTeD7Fbpa8lHx8Wro2GzVuaG1EIWCbQ//4/qDyaw
	 vfqR/2QULEC10XshaRwfwQVRw45ihNAfYKxVwz0tgZytde9qSRuRbzdOWx+QVvWIkIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bGf4jmD6;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AP6Tac1H;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814BC606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 12:00:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814BC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bGf4jmD6;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AP6Tac1H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793275232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uiB5CX6SbDNNbgC0+8PGZVLff5sDTap/tEnkGLg1G00=;
	b=bGf4jmD6g0KzB6Tk/05biQR+sIUODRA1h+GwcqKteCYSLmkwUvEHZf5+F7MU/B8Ia9vcdU
	ClyL+dh2llB3W1Kt3W5tzHUe0BoT4JbeqgxhISeTnoVxfJOpMICGVEua0N4RrHTrK8/ch9
	JAotkCIm8X8aqcEVnRmfZHCTXDYxDBU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-l2FkgUtQNp-CNqvcnh2tBw-1; Thu, 29 Oct 2026 08:00:31 -0400
X-MC-Unique: l2FkgUtQNp-CNqvcnh2tBw-1
X-Mimecast-MFC-AGG-ID: l2FkgUtQNp-CNqvcnh2tBw_1793275230
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b02d63407so1470395f8f.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793275230; x=1793880030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uiB5CX6SbDNNbgC0+8PGZVLff5sDTap/tEnkGLg1G00=;
        b=AP6Tac1H1jD9vbLbfALdUjM8bFhF5dSGnOl5OwWCZKCwT9ElRcZ40WkpUcSLmD9vSs
         xy0o7BbqJem41pjc0Ncd0xbCfZvtl5v0zuPfvcIhh+swJW7IhAhcUhZyXO56QJZREnId
         mlwOhaJ4XR0pinBxXKekCZFSFY2Nq/iFgZuR24RcrkWTSGLguL2CkZjSFgpW6bUgMWJW
         Cbwz/6UEH9Ulry3BlX6IFV+rhYlvgL5EbwLAXoL/hoUKM7BDtoORt1WzmK/qIgsI1xt1
         m4RHKqC6Wplq526UzwG6lQywztLWX3ys0xqcHgGuR7PDkjwpNJwN5p3r6rUtBHs3tauI
         hiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793275230; x=1793880030;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uiB5CX6SbDNNbgC0+8PGZVLff5sDTap/tEnkGLg1G00=;
        b=CnT0JJwqaV1Ewib7juFdfe/oIWLZWfV2A9A1Nz86Y/3kRqQXGJ+kWZo40QqRLcfy7o
         ChSHVMjgkYCG9qfpJNGHwAFRGJ0f+BIgNtpzLgjp4zm5rqA5zBQXkM61wfFxlMKbKDKH
         Z/i8d4dUzz+ACjBYntw+mI6AOETREw/4ydg14xgR6X8xIEo5cLiJjNkAHLzzd0/Mz5v5
         HY8kWswBKQCz9DMi1VEj7kDnOKXh8d3XW9d1rJKBsPje7DLLG3Dyvqzigpht10vYtmaq
         876Y35fWKe5UlWmAOw+3+ICrEGnI1K5nKq+iUNktBTpRY6d9QEeQAkR4zRNomgW7KJ2/
         Mppw==
X-Forwarded-Encrypted: i=1; AKwUvBwVYh8L8Evi9xVTblFQXORcr+iRn8NEGNHxMQyzR6mMeYByVJsVwcNZ6iwswJ9Lk3k0GoGQmR4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZWy/g5ygloSEewEqhO24oysKHokyTy7hXnnsD6DRW2B3SiQ2F
	n9R7qCbc0r7V2Z3Wmmm4VYPk4Xjo0FTj8k+F50nVDig53JkDGGLqnJfBEnZcH66LN/WOdDM2YKz
	q8jO+A5TOCRLguhP/sHPcnlErkgoxZcFaOaRS7QW/x4GlGF4CwUPSN1PU0A==
X-Gm-Gg: AYBFou0nY7zgxbfr2VRYnbxn2nIzdxgo26abKWgLKxyZCMMcf1s8WIsRVu1erfGyZGC
	rXDthleI58vEZ0EESXvZYc+B0I20dwiKGYb6Gut8oJtLqk5EkPBTV0/dPEsImfizZp/zk1YZMi4
	xHussI2lItel3nX2Cdn6hR6OkVL2bmYEVraDQH7q6WVngTpBK1SGdnvmdp/JbayUeVl8jV3+u1w
	M1CCsSQrw2Htvk0zETUBATVqPlsGAQ7Een8ecsbCy5FZppR2Cja2U+vfZfjrVkLuMZZ2FcVkud/
	/HuIaxUF/eLZW7q5ElWVlM6YhgGHE/7vCwT/eCOhY98Ni1dGtr9WaFBVIrs6RuFhvVUWZBOCUjq
	BeocLa3kht7y8bAnLVWQd5cBtYd10Zi6KaMOif8XF4c6FPCZZN/IEe3Fr7hq3cUdK/7PXO1S/eP
	SqK1wtrZBbo2d/jvEwrJ0HUqAohwDGKkKJTMnLVQOJ6P2rp7k=
X-Received: by 2002:a05:600c:4593:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4a966d361dcmr120368035e9.21.1793275229693;
        Thu, 29 Oct 2026 05:00:29 -0700 (PDT)
X-Received: by 2002:a05:600c:4593:b0:4a7:76fa:87e9 with SMTP id 5b1f17b1804b1-4a966d361dcmr120365055e9.21.1793275227533;
        Thu, 29 Oct 2026 05:00:27 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ece5e4asm33255784f8f.59.2026.10.29.05.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 05:00:27 -0700 (PDT)
Message-ID: <e291eaa8-c090-41a7-8e8e-9f86e58723b2@redhat.com>
Date: Thu, 29 Oct 2026 13:00:25 +0100
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
Subject: Re: [PATCH net] mctp i3c: Fix locking in an error path
To: Bart Van Assche <bvanassche@acm.org>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Leo Yang <leo.yang.sy0@gmail.com>, linux-kernel@vger.kernel.org,
 Leo Yang <Leo-Yang@quantatw.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>
References: <58aab766b8ce35d1a7ff38880853cedaec244bf1.1793044759.git.bvanassche@acm.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <58aab766b8ce35d1a7ff38880853cedaec244bf1.1793044759.git.bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/26 20:59, Bart Van Assche wrote:
> If netdev_alloc_skb() fails, mctp_i3c_read() jumps to a label that
> unlocks mi->lock although that mutex has not been locked yet. Fix this
> by jumping to a label that only frees the skb. This bug has been
> detected by the Clang thread-safety analyzer.
> 
> Cc: Leo Yang <Leo-Yang@quantatw.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Jeremy Kerr <jk@codeconstruct.com.au>
> Cc: Matt Johnston <matt@codeconstruct.com.au>
> Cc: netdev@vger.kernel.org
> Fixes: 2d2d4f60ed26 ("mctp i3c: fix MCTP I3C driver multi-thread issue")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/net/mctp/mctp-i3c.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
> index 4e857dd5df64..59e7bf56fce3 100644
> --- a/drivers/net/mctp/mctp-i3c.c
> +++ b/drivers/net/mctp/mctp-i3c.c
> @@ -112,7 +112,7 @@ static int mctp_i3c_read(struct mctp_i3c_device *mi)
>   	if (!skb) {
>   		stats->rx_dropped++;
>   		rc = -ENOMEM;
> -		goto err;
> +		goto free_skb;

Why the additional churn? Just return -ENOMEM, no point in freeing a NULL skb.

/P

