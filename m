Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793320113;
	b=lSmwljvyUiB5HMLdSq7LXP7M0USRTUKOrbaIsnfmyTIWjJ/F5vKP56k+Bn0XACLF4AMO
	 tCbq7azxxvpEIHSxhQLKQjK6xHWfI1UbH3cpRTCO045tA8Z2d9+mkZjU0YOtKhtD2Jigs
	 Hz8oCbyal6rQ6ws6N5ewt1BEx131dLeg2GuaVP18w2rqt746R3GrhY6I0PTFgprRIeUsn
	 4dfpjDGQn0N8hj2twHtjUJAGZaaJIcaxycr8tyhyIkKZCAFAwUh0Z1MlM4oxiVwDtqh8P
	 6f5HFf8NG8GcoVhIr73yXsG6rB/iu+NBFaLKpCyAJ/5e0G1sUrU9ZkCcZEqbt+TSmCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793320113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wpGAv65gBuWPBCuFkdizu+JJRhLdNC6Zx1Lfa+fJFHE=;
	b=KRVkaRtsYHCuefe2tofMG2bsUlndfEeH9UvrGqdbvHyAqOSIUcdT11/tIvKawnQFWn1V
	 ogCbwWb7j0Z9I/uVA8SsDpWEcdn+7KYoVCBS4UJMTq1fR3cVq8zxeuVm2KWcY3qp1bJCs
	 CisSKCFdGwSg7x3gNBK9FRLkpFsFNabCJ9OQkZ8jAOMMeRjPm//rV2a/nHsu/Y7f7yxti
	 s9s6ae5JO6RV+v8R2aHxefvFFLN6kK7fZLz+OLsCnbKWayEbiam6w5tPJZhF7hJJJ9wne
	 T/Duow3GYA17W3i+ckjjDbshfcWnmmTY8qbJjmPbZz/K1IWriE2SfzrKaGG72yk5KzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dr+a7CLo;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0647606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 00:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0647606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dr+a7CLo
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48afbd2c386so70538f8f.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 17:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793320111; x=1793924911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wpGAv65gBuWPBCuFkdizu+JJRhLdNC6Zx1Lfa+fJFHE=;
        b=dr+a7CLoWz+kVq4WbPNah6tfR/D2whkiYNfi69dXlaN/mfWhaxYzFJFRtKHB4b299m
         6aRRBge28ZkbfW8WbYfAq6jdnTQzlLHdyIZsqeVm8gXdu2HIpofQPg2zJn5lWeR97FFe
         DxQj8jpgN7scHkVRY2rWnZcZbZKQ8xJjmwz4czQLYyCkKIeteLO416hwQMHHe7vcpwvh
         wFUAcmMxzn1EiVJ9b4uCSt1wpzeDXcq7nZwTysa14ZsJnOlvv1+N529lnkz0IwHzfEXw
         HosGIG5cPkv9fuYAZS7J5ih2IMTslMroyVVWw+lWZJvlSwA4PLT/aU77OT5Wv+PIS9s3
         Vpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793320111; x=1793924911;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wpGAv65gBuWPBCuFkdizu+JJRhLdNC6Zx1Lfa+fJFHE=;
        b=skPsiv+CZNOjBX0nQ82FyYJnXzNv2v+M14K95XjSVBKZxXOsde2V3bgnU4sRnGUsXo
         DKwpwhP8lt5xVYU33jez1EssSc1lxvCM0xxO9UT5YoTuTv373qWwVc2DGnBDsg8c8JMZ
         e8uzVJ1bod0/tP1fn+keVCfMk2iW3yzfGM2VHY7erQoG/fIRLJzwCVjlGvIOhrAtF+bu
         OpH8l/FIdGh9B2u1IhsCDGZsB8w8Wv9khzl/mXPKzsKa8JWEpQF9YjYar/zfQ8iv5Evc
         t2zHo8vil77EUy1yg/CpQ22gDoflTzLp39KDG3aNFdTOthwSIkmOVSmVtrxxMuBmnK9y
         q3VQ==
X-Forwarded-Encrypted: i=1; AKwUvBxb7U4+JYWsV6o5ZZYwagCgdngdnNBan1/7f1tcboLHHbxiN5MYimuGhyXrJqr/M5VHJ5p20Y0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgLZTTq49fwYaog+LAtWU6QbJOExRmnwWnypJSvQhmviAl2E+6
	KAbvgqixFIGMpaPXab7hAh6PBGjxFuqZ49v7Dw8jY6AVwXSY0I5urikRYcz6L23YsiI=
X-Gm-Gg: AYBFou2HkHfMAN9FzZ7z1qDchPYdfVzZZICVcQpDyXtQTTfNAktFEmOrnVSRqciIJiH
	8dzUEQ7GbyyW5/bGeHjVOclx1SnKE6OetgaTuHF7eBQDZmHdKTgsymIh3E+BvPO9rV2VdifHemU
	wSVUCJYj97jzbRnDC4baZAc7RVNYJcSYoWN1fUZOfZM76xc4SDTqtT1giBMgPXRBs9XacCYaWQ1
	coXXEGDIUOuh2/HHcUVodIKT/3GvaxHaCyJBFFZhJnlDvgg5+ry01/AuN28x6iyZRIhre3SvbXQ
	NjE9pWgr05khLl3ojeRMrklzIa8hzVP2oNoeZflLlOQmEsXGjC4T2xiJpnw57ZDvQv+wT9syFnv
	F8cnZjOtvtZaZZEbGJUlZ2BhjXSAg08lfzsn+TaHGsQuGKviQl+Dt7YT5I4KdgeCKIXUZLyHwGF
	fXTVpywtuju42GVCpMuqWyChQgT2q159xChQSqRzz8KX9yExoy2DR4WyzkH0aT5uvtjSOs4KyqP
	jz+gb9lkmbDetG5UxZ6I+WmLF/Gb9MLYHpsf6kFaV4ysO8UPIzSSFjxBBq+/QLD1Y7OB6ncwDvW
	TU2T/ma4DoHcYLadEsc38Lcr3l5tX1h8CTAXL3VS
X-Received: by 2002:a05:6000:238a:b0:48e:44d:5a9d with SMTP id ffacd0b85a97d-48e6e4fc4efmr2200732f8f.45.1793320111301;
        Thu, 29 Oct 2026 17:28:31 -0700 (PDT)
Received: from [192.168.18.21] ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba53d7sm70205f8f.53.2026.10.29.17.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 17:28:30 -0700 (PDT)
Message-ID: <9c36dafb-0299-42b7-8945-080360e7e49b@gmail.com>
Date: Fri, 30 Oct 2026 03:28:28 +0300
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
Subject: Re: [PATCH net-next v2] netdevsim: reject port addition and clean up
 ports after a failed reload
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 syzbot+88435e204734072bf39a@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261030001444.289973-1-omermetekaya0@gmail.com>
 <CAHS8izOAYwGR_ukmXNq8V-wOVDxGu0TWET1tjGa_nXG99LFUmA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?=C3=96mer_Mete_Kaya?= <omermetekaya0@gmail.com>
In-Reply-To: <CAHS8izOAYwGR_ukmXNq8V-wOVDxGu0TWET1tjGa_nXG99LFUmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


> I'm so sorry, I don't think I was clear. Currently net-next is closed.
> I should have said wait until net-next re-opens and THEN send your
> fix:
> 
> https://netdev.bots.linux.dev/net-next.html
> 
> And yes, normally fixes go to net, but the volume of fixes has been so
> large that non-critcal fixes now go to net-next.
> 
> Let me try this:
> 
> pw-bot: defer
> 
> 
Hi Mina,

Apologies for taking up your time; I will resend it after November 9th.

Thanks,
Ömer

