Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB03C4B87
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247415; cv=none; b=HxG2Q/zaeWD2wC46ssRHs3XRqI4zI+oqnCYd7kjS2DjX6M1uabywaASjzsThOseFAOwTS7aaMr03pM6QLDUgjAwXQErlkGkT5CW3FjPYXn3soicMecXvO79gmkOr5OC0iaRr559ndr1z8XXZOizfQuffm8VNZQRf/SyWu2C8Hcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247415; c=relaxed/simple;
	bh=vRnBca00tyeZKK1fwXf18bbC4/LTulGT8DBbhVrqJUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agAO0t6w1sh4I4Rb8nX4gK+jr400MNTqTlu4PyLEZ54zAY/dvr1MS6P1kUCAXIQ7XQy5TXbtG/pVBoCwdLhcxBLHPzkEYbr9r73gZy/i0oLObrWR8LpAQ3nVZE/ANR/CGQOClEJqPaLCiBg5jPKrTa/csKNgyzF12D7weJdKo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cm1dKHj8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4YmUT6p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cm1dKHj8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4YmUT6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785247412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44/b/tchI/kXTVmC+LeNLesnctyWoFMi/+uiRQ6TASo=;
	b=Cm1dKHj87oJsNK69fb8hWDL+vOKwVpIbUwKLwaf3FYiFiXXaCGSlWIW0k+eZwNm/q0XTZg
	A30rhnskgB2kpmcLwVk1quBEAaeN9aCHSOCrdubFPHyWGtwGLzuPukWl2Z8XoHl7GTYhre
	pwBEiY2osBXZ5ND92Tprh9YVTK+Rq/4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-POA7L4hPNPOdnef7-RBd2w-1; Tue, 28 Jul 2026 10:03:31 -0400
X-MC-Unique: POA7L4hPNPOdnef7-RBd2w-1
X-Mimecast-MFC-AGG-ID: POA7L4hPNPOdnef7-RBd2w_1785247410
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473ac08a6a4so3042013f8f.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785247410; x=1785852210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=44/b/tchI/kXTVmC+LeNLesnctyWoFMi/+uiRQ6TASo=;
        b=L4YmUT6pQ0XeG6iU6LCnWHfgIxHOxiKbiojjRdHA5UXRBuacH5V4oVjlJVR91HKxNb
         Ok10+5tovHMLjfeyE6sPIDgmvh0gKE7VRTWU4oXeLR3QCrsSUgfi6HH9C7CiN012GKo8
         gkpltkuySOP5m2vaeN70C7rT1HmOqRakXXzJve6tfgMaBHXg1VjdYnYLcxd3CCLVU/ph
         FCdohfH7Syxzr865kVlb8ZDRlhd2/NMkWBQ5cduFi65Q+RYm2p3CLHVDySRvmOwqI6BZ
         2j9XL5wsZPxsbc3FQd8Re5+zZaYnY5k9SEM89yo0Dj9kmf8rAlh8ULOjR5+JVYruIei/
         LLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785247410; x=1785852210;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44/b/tchI/kXTVmC+LeNLesnctyWoFMi/+uiRQ6TASo=;
        b=qykDcZeCQwFYdBday4PcNdAJ65Qp9GSDkV1yB9Yav1Y3J8moI1MeG5G09UMHw8VKm2
         nZ8y3mPfi45qdufYjaIBijMWQzBR1i+HtKETZqhaXXQWWaCEUKAKMCpKAo6DHe6ha8FM
         GQUlK6jKvOGCdVHsPdDzwHgsDhGHzFwNDt2vES6lA9R2rVuSOc1UHJHZBFXuy0vKtpUy
         iVJLoa4+IpUWj58UDXLwYZdaniQtYCikfymqpGZz2ar6JR7kcLytQZgI/+fXIDvIZUBk
         bgpgcTi/+XRmK7GKoSWhUSNgmxR9AD7021wItffXUFCCbZtiFggeNRdp06GZ+7Vzc/1d
         pwLw==
X-Gm-Message-State: AOJu0YxIyEqr5sz/JRn3WzQNa61HjC6gmaP/J+kJ1wVtQ//tTWVbvYIg
	WrsRQr68BylEQyYhs9UxdOHeiolmtY3x2fr/NFkkv/Ax81ci3V6CYqO5O2LP/nrERYqxBvDTZdD
	Affh7Dj5tekGv5XSLSeuBkRFv6s468ywmmmk+gJtcIB4Ha2RQOQjw2fT0dg==
X-Gm-Gg: AR+sD12sNXLVKZEtP5yvis+VOCwrWUz0ThjzS20DZEmfyHEb8Y/guCQQf0BCVz7Mct4
	XSv0RP9RBoYe32oXcQh02aOQcNMEtrXvHR4SmwR37tv0Ik9v7iInJahA+V5e7meWNe6VKe33QzF
	G53FeTeIQpOSjb3L2i0DmVgkh4z/2a9iju81GvYwDcW62ZCiMTgTPe/neK1aqET/HqYUuabV48o
	/32X+WTTUk5H77XILWtzIR/7DkjeWj6SFoFLJRqSGG2QHE1L+lM6aEMvcKH11bHe+yfWK6wFh1k
	XGD5mHeV1wApXTDay/T/ii7/Rs/AEZL7ZefaMUDrjM1JSy2Hlx+lecqIP7ZrrUarpd82KYhBcve
	xqW+V6kZnC7DqT6vkjpPXburA3QfddXziBUz/eDNZ6H3JQklyYB1Kbu1YoqoUXIGQBrqd8Hn31X
	QpEw==
X-Received: by 2002:a05:6000:2085:b0:47f:6dcb:3737 with SMTP id ffacd0b85a97d-47fb1ecdfd7mr3048008f8f.29.1785247409994;
        Tue, 28 Jul 2026 07:03:29 -0700 (PDT)
X-Received: by 2002:a05:6000:2085:b0:47f:6dcb:3737 with SMTP id ffacd0b85a97d-47fb1ecdfd7mr3047931f8f.29.1785247409495;
        Tue, 28 Jul 2026 07:03:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bd77a9sm55496191f8f.14.2026.07.28.07.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 07:03:28 -0700 (PDT)
Message-ID: <a4bda84e-3041-49b7-8863-e09862b2739e@redhat.com>
Date: Tue, 28 Jul 2026 16:03:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/1] net/sched: cls_route: fix fastmap use-after-free
 on filter
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, john.fastabend@gmail.com,
 jiri@resnulli.us, zdi-disclosures@trendmicro.com, sh.kalluri129@gmail.com,
 victor@mojatatu.com, security@kernel.org, stable@vger.kernel.org,
 Santosh Kalluri <santosh.kalluri129@gmail.com>
References: <20260723105210.817079-1-jhs@mojatatu.com>
 <3914dd5c-77c8-4f96-8bfc-986f0a00f722@redhat.com>
 <CAM0EoMn6sLJ_OMXY8-B4RE3r9XunFB=OkHbYJ-c-VBpADyO29Q@mail.gmail.com>
 <da0313c5-1060-49fb-a1a3-72197eda4d8e@redhat.com>
 <CAM0EoMkRMOBmrGW3fAcxxhTxcLaP44zr4m5Ds8G2VFT1CissNA@mail.gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <CAM0EoMkRMOBmrGW3fAcxxhTxcLaP44zr4m5Ds8G2VFT1CissNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/28/26 3:12 PM, Jamal Hadi Salim wrote:
> On Tue, Jul 28, 2026 at 9:05 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 7/28/26 2:37 PM, Jamal Hadi Salim wrote:
>>> On Tue, Jul 28, 2026 at 6:34 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>> Since there is already a
>>>> synchronization point for both reader and write while acquiring the
>>>> fastmap_lock, I'm wondering if something alike the following could work ?!?
>>>> (completely untested!!!):
>>>
>>> Your approach has some holes, example misses the most dangerous part -
>>> destroy(), etc
>>> I will mull over it and see if it can be fixed to handle all the
>>> issues. I think it's possible i just need to put time to
>>> validate/test.
>> I would appreciate that, thanks!
> 
> See attached. Untested (compiles) -  addresses my destroy() concern
> eaerlier _i think_ (unless something pops up in testing)

FWIW, the changes LGTM, thanks!

Paolo

