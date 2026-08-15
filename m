Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9737F731
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786819232; cv=none; b=MPJHOI1NlzEA6NV5I98+q0qMRsRhLJmlIwBNFSjclEFBjE20sx3S/g7CteaL1DZp7UELiw0qFCRijgJnUZ7WPswh0cmlt5TUvy6PkQBuQ6btPAjrxqXfMzwZ+1Nn4UXANGNBSDpHUhlB4e1RCVAKZyZQkskl14yfDtdncP1eoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786819232; c=relaxed/simple;
	bh=/ZA1Q8Gwy+uG1UkvNRPO7Wo07xyRJMuxf+VXQgnmgcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ym9AzFUG0QaRNLpRStLQkX1j6QzJDnWpwQDoa/Z2n5pBdDaAEdC4TA3Eo0RjbWPZXSrOnVEqs5M07Yb9kyp0RQQTIrbPj3lLkG0qII58LtyGHFuU3QhwlYiJ1GitAfYsXKyST/JnMibOso0gvWFTIUBfn4qQY7Lvnwt2VTyLkAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5PRZVQn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5PRZVQn"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso3054740a12.1
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786819229; x=1787424029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e4u+82k9vbpFdPR/3zT94ZUUXyCAtcrN9YltYPZ+Ra4=;
        b=l5PRZVQnFCK7yIbLWYne+Ar4vHWyYDwUeYpUVmopEpS68GdqmGnchUeX0R8zwWT+67
         /kcMW8mGnGTWMz58Q7Weq24iZRGytMPJRUHwrIHipi7WLw/+aYdEiIO+pDHVXCuh2NUA
         6ruSrkdsSY++lh3f33QnSQBzhxtlkYHLJubBezW3/zpw/hY5izu4tInlm2sZdLzjQOiQ
         YsMsdeH3fWGbLJZsbB1t8dnsBCIOqjoNcBVRhgrEn1Nmu6SasW9LlB7ntzxd18N5r3EK
         xJRfXyWL72cCpaaUHE9VWWnk7cv3W5If+M2CkLOdPpY/LclVbbv/P5iVotLyceBY8nK5
         dzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786819229; x=1787424029;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e4u+82k9vbpFdPR/3zT94ZUUXyCAtcrN9YltYPZ+Ra4=;
        b=qy8botNxC6gJiOF561nbV0neYuidWQIzLwKFmdFcnkAtkrvMVE9wzwVtW392HnIJsG
         Dam9Ey5mESWB1VFxcxDfSKcCqrWDQxtLSkGn2T8b+O1PQ/hJEjX3bBYkITjSsaVOBvLu
         GV/rqUIPUB4+tSMDj8/GX7hBdxflRJMgYOaexFTYhXY19P/4ccxO4wavyTYpKqLolZRD
         +9I6m1sObcUjz954DnNchZZQMNBVCo09TfjOF9DLjG/clKgnDunZ8DmnNisAjyITc4Gx
         F5IKU/kM8Gj8J0kU6Hkr2O/H6KRzoEivkttfAyVPhcYp0R+FXvlG0F9KkCNQIoNYrcfd
         9YAw==
X-Forwarded-Encrypted: i=1; AHgh+RrLoN0ZRVa9l1RGNZcXC8ue1j9OjnN2IROqhC5AXUDcdl6O0Q5iA+ZZk4bqJ68/HyeOJIdNOqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0aXmfnRQ4iJnaVJBgLj4GqNcy/zloOWpRr/0pbYaXE7yx70yy
	sHqQClqAFsFdOmRGudwM+5EqrWQLHQ9fmDwnCuMKU3PYW0dCP7Xmuyvk
X-Gm-Gg: AR+sD11V30uKwYeHJqVL0j9OiwcjjyPojVonyP6SlEUEmQFNUQs2qIPT/ypEB23hCaB
	wIK6lCGpIDI8A8AGT0OvVnCVzA9mUG0wqv7WAtZt5tib2GQEGAFL5+gRBGa38mJgvsmjT04Q/QV
	H2pBDzQoILotiUAnVXFiMmdfTi9abxlO1Pb5bXS1vPaOtFAvJnW8Drn8udxssc+oFmsuh2Pt1Qb
	IJ0qfoRZJC6s535H3NNUjVj/C2+oqMcYiRR4gByjfyy+fh2JPiYhNsjG8/nAoTOEV9LWvkNcqsJ
	MCNqKqTTA8dIlfvwk+6861L9bGIaS4SRdtnliUrT32OMiZujnyjg4IXje4cE7iKLN6kZ90m8WF4
	8sFm1op+T9L2NfDu134VD7BKvPmxvPcDjtWgEyu1U2KrTQvixWP7nQff1OJMxSi3yr3fynU0fhz
	Ly4C0TUbrpAkl+xVwrfF0N39zAeESC+YmCsqY5Bkd9iY1hrIaMLHpi9MXWXpR+TU4zGUBwTBPX6
	91YnDY30FmW8gwS9GLFIqwVImb38ukMSrdv5xzV/g==
X-Received: by 2002:a17:907:a64b:b0:c16:9043:7973 with SMTP id a640c23a62f3a-c2129c1be2emr652620666b.4.1786819229276;
        Sat, 15 Aug 2026 11:40:29 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:28f:426f:2aa1:8f7:f8a6:4f89? ([2a00:1fa0:28f:426f:2aa1:8f7:f8a6:4f89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21234b3feesm268117266b.14.2026.08.15.11.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2026 11:40:27 -0700 (PDT)
Message-ID: <f5bb5c11-c525-4eee-bd9c-8566d4c04ce7@gmail.com>
Date: Sat, 15 Aug 2026 21:40:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/10] net: ethernet: ravb: Propagate error
 from ptp_clock_register()
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "DavidS. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260811160200.2049987-1-niklas.soderlund+renesas@ragnatech.se>
 <20260811160200.2049987-6-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20260811160200.2049987-6-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/26 7:01 PM, Niklas Söderlund wrote:

> If the PTP clock registration failed the error is silently ignored.
> Before reworking all callers of ravb_ptp_init() handle and propagate the
> error so it can be used.
> 
> Link: https://sashiko.dev/#/patchset/20260610102432.3538432-2-niklas.soderlund+renesas@ragnatech.se?part=1
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>

[...]

MBR, Sergey

