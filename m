Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731FB383338
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288183; cv=none; b=ofpSVUn8jPQLPflRfD8ye9Tnyp+980g7W+k5te/CcPCiO2L9ld3zNkWhTFikrTFBqeonZcjM34hqVVO7Un3qysQBV0cCTH6xv075gktT3UyCPaNktAsyDTmOfhsIysrKB1WkdvNLF+xtA5KIv9LAKXfkNh94egE9mg7KMximkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288183; c=relaxed/simple;
	bh=kJHBC7zOJdFr54Q1tOf/VVgkT3wW/KkqDJx6n438ZAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q81nl/tEUWbi/9r9pwWT88ALYp+JZf7Jf9iLMHeIk1/YOX2Z4INInLqqpqO+vuUh1bIYNvkz/ReBeGKjohZPlz6VdSpaSK97/p/hv1ICPZ9XlkhwSfh7bUgfBy2JwK+pNlZejI0B3AKQrxoh6uLvR0zdKk9GdeY8JFSXyhut7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsJklsM9; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsJklsM9"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-396669329fbso20349981fa.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781288180; x=1781892980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C79CBR33drE1u/8t77KlECapusXxwvj3erPrWmd11zE=;
        b=BsJklsM97uWb5/Yd/LKpJ53g5+L83kZNY2cQoltQA3/UI3ntneSswSqg20EEGvg26o
         sl1YBOxujamZ/frUn95glStwnHfJsGSATnWOb8PkGT5T1t3Ezo4PyC8A8HPChzQBafHB
         Nz0h7LSjO0PJ39HnxynYCqovKQA7PN8gFjY0Ul5/kJBVQQJZmJrCIXXqHk69Zin5b4hG
         zOsu0rYChmIYMLJMKx9d1P7z1uFO608krapDzpW+OihYZeAmq1XtwRWWTBUl6up+uIVg
         jkVXd58MtVxUtAKwok9fzwlE2ouQtrmOs3taJizVP0ZmzquGI1cfp1NfF8xcJ1gSjI1C
         iwxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781288180; x=1781892980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C79CBR33drE1u/8t77KlECapusXxwvj3erPrWmd11zE=;
        b=KRghT7kIPUM4BJfnmvVuK/NR51x4eP6hxlk2O8PtnGG7II/VjSsAHTtKv9Sn1/m/+i
         0Y/NI4e6+CSqi1Zb9dc9N23sxnRV2x3D07nQ+Gsf84se6zNMlvwdUbhiDTSJzlKIClFY
         m0RkQFEP6jkn2jwMO/qTUKmho0HJyB9NGzNsDyo6xYC7Y6B6NLjtG9KbyDJU/LnKo1xZ
         Q2DmCOYkEI1tx5lvrsI9FVMNdWO1GrtamuA3hXBXKCMQVDEprFFr9affoUmX1HqChDom
         DGHHi2Fy1Ggpcp4qgkbXmO62tTxaayY6mXwEsqoxg7vTLPtgN3TfiDQymU0Ld6tRWVhV
         iYqQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WxATVzPg+n44MnDofxgbA4zoyxMiMg4LAADvfLw46Oj2OxyV6J2H8/mJrMd5Py5ybMmrGNbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFGwbGonNVPOV3o2CmRSVW7lzXc0WYDpJLf7fLpcqpJW4Oe8fA
	cQWyIOsWiSYNn6hBnNPzj15pfOCEy2S3/1vseDQlVmvSfcM5DyJEUbtZ
X-Gm-Gg: Acq92OGNK5MmMOO6M5Mlm7qVM/UKW2ueR4YtRscpa3awBJzIrw8hbo+zOPUPjP5TqHa
	J6YpHuTYysQhsE4N/O52TXURqd7sBWRZ/OnWGWZyyDXkJeWy+XClwJHijck0SpoRHHApmKWR+gO
	jbe8MUgkd+sO1Pb9QOIkkvWv8VP+al1dqg54CgBYIbQIu3eeN59HQOzhKFS3RdJ39DJemnHDNRa
	uKUAphwMSKGJz/dr0BWJeg4Me0yVcs7qtd4kXRAvy1NyPdH0qKyym+nZew1gMSQ8pcqIS2QGZr/
	fi7n+pz5H5EDUD8oxx+EmyBox+QKiRtqcl9qrc27hEdOOPGNUTl3i+zdzxOX3fMMqG+uCMHJrNr
	YCLTRczaONGlgXlmzvsD6r74O4Yoo91Ditew25MC6QXe7nSybJE3fhdFefIL30mU9BKj0vUvEY2
	nM4k7T3yMq/AS6fWINKphPg9bbgKJ/cqCSReH4kovipF2XICPhz8lBRF2PM1vFt5GYoBbAK3k6C
	+RIA1fQ9AGESw==
X-Received: by 2002:a05:651c:3253:b0:396:a647:76f5 with SMTP id 38308e7fff4ca-39929b48892mr11943051fa.5.1781288179270;
        Fri, 12 Jun 2026 11:16:19 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:742:25a:e03e:6c9c:49d8:2fee? ([2a00:1fa0:742:25a:e03e:6c9c:49d8:2fee])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39929c29687sm7844271fa.4.2026.06.12.11.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 11:16:18 -0700 (PDT)
Message-ID: <44f779a2-74dd-4488-8338-4cb9e2dcdc59@gmail.com>
Date: Fri, 12 Jun 2026 21:16:15 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 2/9] net: ethernet: ravb: Move programming of gPTP
 timer interval
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Paul Barker <paul@pbarker.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se>
 <20260610102432.3538432-3-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20260610102432.3538432-3-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/10/26 1:24 PM, Niklas Söderlund wrote:

> Commit f384ab481cab ("net: ravb: Split GTI computation and set
> operations") broke apart the operations of computing the timer interval
> and programming of it. However it kept the programming of the interval
> in the RAVB main logic.
> 
> Having split the two apart this can be improved further by moving the
> programming to the gPTP initialization function, as the first action of
> the gPTP init function is to wait for the timer interval programming to
> be acknowledge by the hardware.
> 
> As an added bonus the interaction with the gPTP registers for the
> programming can then also be done while holding the gPTP registers lock.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>

[...]

MBR, Sergey

