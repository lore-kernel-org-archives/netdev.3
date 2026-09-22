Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B136566C79
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790094085; cv=none; b=HJQezBQPqFOSdOSOpd7628DOD+FF/KM3IMdNtMh9RwSjsd7eWx6KrhPvd62D5XncO36BtzNUnnerPIKO7vwxIhWmrLnseaRXc304uHgIclkdcARWqRPRS/HBwdDkpkjtDP0UXRHMSfHkjfAvkrC1t9kybBsCiR2EIJHw1kcdvYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790094085; c=relaxed/simple;
	bh=tJtLQV+bO7Nva/4XSyhPEP2Zi7kZ4Kp6hcrD36xSWPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgChWf6D8718KBHsS78iNGP1H+G/SN1d9T3lHhCYYaR79NzhfMf62lrN2EIZT+1ihbYvHMCvZpk2Mg8Jvos6RwmO9+l4AhhXv+9tNM9Hdus7rv/H5kmTfQOEW1MN1OZGZked7R7e6bVvjf4UCPbQ3T+6p1I3wtRM9X2C1+QEI3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O+Jifje3; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O+Jifje3"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-5c5f23666d0so1057e0c.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790094077; x=1790698877;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4ojZrMQFLGqpJPvFhPFzqOHSZKQtuJ5kORK38PdRnJk=;
        b=vKV+CG0PneKuz6WeAKKY2EAAWOQRX6C74+3An2WKhZB9ulXTUHYvHbBMksMpvKW5ny
         wiRqwU5ybrpZXsZ/cj0i9EspQ901mt5MelqAv5mYOZvIW/xs7/0xw/lCerCHv4ZVwP8n
         lSxP373reKd7tz7/ZWO1qIuWsev1KkaeMC/4FXA5NOQNo5+d+lGyhEMSNyuTQWZ0Ti4N
         PRVhbVbD0iDLwS+GNsJNA1FunR06smeYcptgSpqahyijFgxQsV5AZSNvZUBB5HSvAIV1
         ocmtzwFp51EimEQn5/ll5X9gox8hJ7X2IF3vGMRD05rDfbwNrJifKRf2jnqsZpGPK6aD
         66SQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3SFJNDd91UBKGhxfHGeZwNZ+6UUrvSAecrnZhty8zIuGNIcMBhljBPRbH5RGZHrYzugIw3CM=@vger.kernel.org
X-Gm-Message-State: AFuF++n7FXzltQ++WvqM1IUdo5ejw6H9Od3gSXNGACxxQQ5WJjrhh32m
	xDeHaMNqfKy/vjBRvZRwAPfp7LJDmQWPLaO9F1J+OauI+WRZVg33l2ck8WoQ+JlWnU/tf0AFpZI
	o1HAT3zoOS81YuBV1PYKMOiIxYTYyHtFdyO3yr9643nMlpQ4CzzGiS9BRJ1wdHFk2twOPpbCbW7
	B3u2Mv8Tj89ZGKrad2cKb/Mf1jGNIbWRW7Y2M0ah8iS+iJvpCsB3CyaOcfR5aQIXddiBQB4Ewbb
	CDJA8HL4Q==
X-Gm-Gg: AYBFou3/r7QxkpIlZTOVyYEW+hRIGNiYI5T5FOVdyhbhlX6dZ9fpOmDLzZSuQ2XiRHK
	MnawR2kNb1ogp3hsUw878/XAHhyBeXfV1pFr6HCMjzsP2YdD3yy7z/af8x3Xh5C+wD3+i/RHfcl
	kjrbw0iFo4zljZrWVD8X9iv9fAZMStsZMKnDyBLXTDVlyF42rVYR3UTX1xCGz37+RWMGZNQJA8f
	tVy9NI8nuoaAAfyLOhtqd2RuxLNNAP6Lnoqu2rTP0yf074/aDn0x//LbzVWHU2MhcBaQ9j4Zofp
	CZcZi1XEaB+F4xmY783rWTMSRo196H6agSgWNAWIS5rzQAmrxsOxDvs7508pQDxlpqEKMbI/Ncn
	hTpK3wOyzGYp27omXFhGwUmX/iWpM1k7pIe7DC5D+uswVX2JKm5D3ysR4SJOqVUNkKhiZOAOx30
	6I+b2r2jhmweiXH/pJhsB0SYGsE1bOd4SlM27nA5NKPMM4f3o=
X-Received: by 2002:a05:6122:6d1b:b0:5c9:ee5a:e5dd with SMTP id 71dfb90a1353d-5c9ee5ae6a8mr1886808e0c.12.1790094076922;
        Tue, 22 Sep 2026 09:21:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-98516a80ec8sm30869241.4.2026.09.22.09.21.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2026 09:21:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-85da2b96c35so3031987b3.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790094076; x=1790698876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ojZrMQFLGqpJPvFhPFzqOHSZKQtuJ5kORK38PdRnJk=;
        b=O+Jifje3oNuzjxV0LcjWHN7ivRqsh3BdeEuh6s3pPsRy3fsRNQbtrjMooz6ZdwEOms
         lJ1exFp68eJSauyzt9VGARr/FQ8vf6HDj8q4KBvDFJBAFUr9vc7dbC4vqEreRxrtcbxm
         LPUcg8rCnGpeZV8PtyHj+L2Gin5TDvtPp1xHQ=
X-Forwarded-Encrypted: i=1; AKwUvByiSDqJ4R5LdFCe1rDsnI3vt5cGJBwTQBXyHdofsJGnLYaFSpGOYTCa8ca+CQ1+qFkFmWOgWzo=@vger.kernel.org
X-Received: by 2002:a05:690e:4386:b0:671:3036:42d8 with SMTP id 956f58d0204a3-672d58078ccmr3234d50.45.1790094074916;
        Tue, 22 Sep 2026 09:21:14 -0700 (PDT)
X-Received: by 2002:a05:690e:4386:b0:671:3036:42d8 with SMTP id 956f58d0204a3-672d58078ccmr3201d50.45.1790094074466;
        Tue, 22 Sep 2026 09:21:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:3f50:2990:1945:ab68:117b:9387? ([2600:1700:3f50:2990:1945:ab68:117b:9387])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672c75bbe17sm978519d50.5.2026.09.22.09.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 09:21:13 -0700 (PDT)
Message-ID: <1e8f8d52-e910-440d-9d02-aaed28c94cfc@broadcom.com>
Date: Tue, 22 Sep 2026 09:21:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: add Nicolai Buchwitz as GENET
 maintainer
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org
References: <20260922073140.1471858-1-nb@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260922073140.1471858-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/22/2026 12:31 AM, Nicolai Buchwitz wrote:
> I have been contributing to and reviewing the GENET driver for a while
> now. Florian asked if I would like to formalize this commitment, so add
> myself as a maintainer.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Acked-by: Justin Chen <justin.chen@broadcom.com>

Thanks for assisting!

