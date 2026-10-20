Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792491769;
	b=NgajIoTNk/0E8rT3+biyRDnJ8lXlzN6BA+skn1TyBbEYMXXNZ4/rXLf+8uPD3HTHH2lU
	 v6lguPIk+iHBMLBi8F4h6dEPK7W5peTocYzRfM3XZlEk8PXk9wGrj2Tpc1m0OAREUYiTy
	 zM6JH5DLzRLynIoXCJIX4FulPH1ajFBiheurHUkJVRDLZN9Tzptg4YxTvMwNxymi0WArO
	 nIYOL7ROTalt7dXdDTEKjLQsLYghf+pCDTjBI8ElmSvpknUZsMU4wfASOhlGp8uhvrjuK
	 nY5sX64+42XXAF+RoHoWvU9MHLwHq1/Gm9jjZOzVgUKDls0KTD3YOEZoiAij51OAWAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=S9TtwUeUO8Ss4JzAEBBTdeSudHe8tk94C0JNHQu/04g=;
	b=tTrvRk+llrYWGGjx6SliVFwapxh3KPb5hlXKSJEp4eN7e/bV24eMA8OrV2wyeTKYhz0W
	 r2kary2PZ4lUsHZd7FCWj9AEjlPrk2QwpYxacpUVSWwaw+JEVZkmoeacBdMhnbOEQbKN8
	 l1ULa8ZLPQB1MOqbBEtuufHBV/DtzTBBbsOLT+OYKYLTdXf8l93aVkdH82Ozww8kKiJnw
	 s6OlFjZ1D8vMpdGjk8SHVHyhGzQHTR8cwLtHs8P8iaVGBbGZlhoaUqLU9rhNdATpasTYy
	 aCq76hVytZe+vthv7X86LJ7RFy83eYWcQagMjshHwFM7e5MahC4xNJodn0stbbUTzIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mAeXLhva;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543CF606A326
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 543CF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mAeXLhva
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba3b1199f6so3010337e87.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792491767; cv=none;
        d=google.com; s=arc-20260327;
        b=KrLu3FhVatkojU0DljQ9UZ25jez1sKfpDHNPMy4T5nnQ/0UfGy0qi8SpeWkMLjfaQk
         9ABO/vGUWCQ3eipEjbNZJwX80AqaiDGqbz6zpc8bxwLVKbKR6HG50wapY0Csx2QgzV0m
         8Bu8JVVKlDM5MEnRYWs9OuxIYxeCQ+AzxiVaBqG4U2sIZ8mxG6QS5ZEeE06zX14gX+SW
         /vaRRwESBTdhdRiSqscR5ZFw3dUMoHTlM+nP6u0kj10R9CIHavxIUIhnBwEqP/h5dSJ+
         Cb4YNpInK8yd7grXyjeGcHvPGwx+m6sik/+9qzcuLApUgQyxAGxm4Jqju1PifyoPXbd5
         ytqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=S9TtwUeUO8Ss4JzAEBBTdeSudHe8tk94C0JNHQu/04g=;
        fh=Wwc9JLQD8J7FLxykRGWCDO7OQcjqxBCqwOl46zHZekE=;
        b=ZAoUpPqdDDS3GxFW3ERlBSY2VVYa0UknGGJPxgJuuzw9Fq7mXgx/cNAnrf+qrZb7gW
         owj0C7VwWF+UOCQJGn5gxLYAkg2uNjlT9NDwWZhD0bThWgYtxEBXJzRqgAbr6600TjZQ
         BueUnt2mm6QH7jaQwo1syABS9wkM0tCNmOesfGiZAVhjVbmFhzmgPw4zX+1Sb1qtu+Md
         nAzkb+pkfcs0uhiQ1zqgPa2qz6u0OReKFbgU/iWWpLU8+v5clq2PIzr3kkFRmCGfWeTz
         zysQkwNGZNO73R1/r00yTbDBA6JLgsIfTuhk9Bm9o18xIWq5ipCbdaIjEwK/iPVH3gYh
         uIQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491767; x=1793096567; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9TtwUeUO8Ss4JzAEBBTdeSudHe8tk94C0JNHQu/04g=;
        b=mAeXLhvanluEkjo1PmluJSdlXstt4qTX5kS5IyN69H8ESLCM0C7Pxty8hpRlpRnXnh
         zxeHwIv8Esb+BwfrRoTbcsWwm1Etpst+Ydbo8/xnUYBmplXhjqDcuALWUSAO7N51DJys
         AyzhaaO1KuNv3pjCLqNsGCU1jUY3U1ygEUEZ3bpIT2riyBOBtdi0QBkSZtm4x8vjxpgA
         dRxD5+Foy1UvYXzADUJkVEcbG3jKtRWlvN8Q4dEO7WaREbcuJssfS5MVYKXpnojR0ivg
         YCQxSQIcVHj4A38duEzGY55qQQvuZTDH11WNXolbWDWqrPtYQ/5Oglpu5UG3KINeNR9f
         nu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491767; x=1793096567;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S9TtwUeUO8Ss4JzAEBBTdeSudHe8tk94C0JNHQu/04g=;
        b=ieFUuGL8B5EyDwQ0hpffi6wsYCJpNMjqq04t56IFKIZwjc1icqmVozFPEALc99wLTu
         /KbzWOuMmSP/y9V3UBie96Xm1aSyXAzAH7kLlxFy8fhnq4sdNd9Qxw4bzm65Ei0l3TuK
         gj6ttJ2pAzMOLC8tpdTarpWbRI1Ywi4oFHjvKLKWY64qqMzni/RwhpzzKWmx1p4qK4E5
         xu1HX2G6TAOt0u4aSOHMreLQH9NgB8bau0AgMtbEGZsi+/GoUYT6GdMmT5U3cQf8y4Dc
         tss+h+xT5rkDaXdnAHzVfouH9Ssl01MzVQVpgpR8t6Vhny1TpQKqGhdpJEYBFViPYWHR
         7CkQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8p8iKRu+9/XzBkCMEyZIcVQq3hSa4KvAgSvNb3ikHFVI47HF3I4O5IhjN0ZQIaHvk7kOpvrc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7HHCllrKYoj7B79FI5L+IPGrnzaBzoCB6VesrwEO6RXso+21c
	PH5YxWT/ciub6XCPlx38Jh4hVj7tekI48iw46ditmtoUsd37CpQmj3dFtdGU74A18l8CJ8w9+HE
	GNUCL4JaBuwWGCUQi7/pohV4rTZFb9TQ=
X-Gm-Gg: AYBFou19+FD/Se4hRSP17UYsZQ24dWAfwxLDyyaETg60zltxFEE75Nqff5hgeOI8Soa
	LH9DhZstZjQFvSCWsc2ljKAvPcWnRJCFFvmExNuTKhIynUKBqsUg+3wrdvO0RTcmz6O9o/pnAUg
	8u1gJLeP7Dt+Fbz66OwwuMuAXVdhoDfhugEMabkNgCQi9Lo8O/U2mcoMPFfgUyI2Kst6tk6lLxW
	ovuVt56p4tz0dwsbVOvKUUxaK6MjT9GtpiAaPsXAJjRNtcafgquWiqsRQ9s+z5VJm4J1h8Ca3on
	7WqvTJwjLUkJtsqnx53bOC8YEu8cd+X76ULmbtNLpLagTKyM4pPZw41MjSak+x/fniAbMo0fN6g
	skVO/4xa2xJ1lZKZ8QfIQCxlZeuuMDcUNK+HtxIY8Jw3/cEzO+mJwBdc=
X-Received: by 2002:a05:6512:114a:b0:5bc:f280:e7ca with SMTP id
 2adb3069b0e04-5be509ef7d9mr3121213e87.7.1792491767173; Tue, 20 Oct 2026
 03:22:47 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261012011707.3378-4-sigefriedhyy@gmail.com> <179185709988.434549.15422498299449004512@kernel.org>
 <CA+7S2v+LHUWXQMD-cYPEzT5-f3Qhw_vz+LEssQH_A_oqDKtnnA@mail.gmail.com>
 <8dcd9564-e9a3-4b00-93b8-3cb023d68047@redhat.com> <CA+7S2v+rWYvz9xKPEeM6=3HPz3o7TbX2uRfRKk95f9Y60HnEiA@mail.gmail.com>
 <976d815d-a9ec-4fa0-9b16-8e55695706c2@redhat.com>
In-Reply-To: <976d815d-a9ec-4fa0-9b16-8e55695706c2@redhat.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Tue, 20 Oct 2026 19:22:37 +0900
X-Gm-Features: AclHuK-kxJ7GesuN76pq16qYPFjVn7o8AWFRCTQQtoJTT6S63wPtOHkARgKHwik
Message-ID: <CA+7S2vLWvQd7GrnwB+B+DiqAgST8EjfWwBKzJXtjGRBPVgmOBg@mail.gmail.com>
Subject: Re: [PATCH net-next v11 3/6] net: add a generation counter for
 dev->mc changes
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev-bot+sashiko@kernel.org, ajay.kathat@microchip.com, 
	aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch, 
	claudiu.beznea@tuxon.dev, davem@davemloft.net, dsahern@kernel.org, 
	donald.hunter@gmail.com, edumazet@google.com, idosch@nvidia.com, 
	jacob.e.keller@intel.com, kuba@kernel.org, johannes@sipsolutions.net, 
	kees@kernel.org, kory.maincent@bootlin.com, kuniyu@google.com, 
	nicolas.dichtel@6wind.com, nickgarlis@gmail.com, sd@queasysnail.net, 
	shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com, 
	vadim.fedorenko@linux.dev, willemb@google.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> To clarify: every I mentioned in my previous email was about possible
> follow-ups - not to be included here.

Understood, I will send them as separate patches.

> My understanding is that there is sort of a pending/implicit question
> from Jakub on v9: why are you doing this? is does it solve some
> specific scaling problem or is 'nl is nicer" thing?

I think the motivation question was on the v5 thread, and I replied
there as well.

My original motivation is to simplify some userspace hardware offload
code I am working on, and to finish moving "ip maddr" to netlink.

RTM_GETMULTICAST already reports IPv4 and IPv6 group memberships with
IFA_MC_USERS. dev->mc is the only part of the multicast state still
available only from /proc/net/dev_mcast, so every consumer that needs
the full picture keeps two paths: netlink for L3 and procfs text
parsing for L2. The offload code above is one such consumer. iproute2
is another: "ip maddr show" already gets IPv4/IPv6 over netlink but
still parses procfs for its link-layer entries. The iproute2 change to
drop that is ready to follow this series.

Also, compared to procfs, the dump provides a nicer API: it supports
per-device filtering, other netns through IFA_TARGET_NETNSID, and
reports concurrent changes with NLM_F_DUMP_INTR.

Thanks,

Yuyang
