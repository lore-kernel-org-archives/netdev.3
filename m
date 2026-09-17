Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04BD3264FD
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789635395; cv=none; b=taHCDj//HAGrSEE37IdhNsf/Bv35sIYLrBcLPvBiXoW3pE/M3s4lSJ4HKrqiTcMtDdx8OZJqz4KwiOsY3znBgOgMp/495BxxjVUzl04/hXLp6jT9K2EH4TUftzUkFLVNXgVWV4R/pxoQmWgkGNpq9wgzjf8d7uTI1RUJNggwyOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789635395; c=relaxed/simple;
	bh=/KSe7cZO5PFhL3uVEQXUNu/Vt1B0LJGNU7PJaXjyxgs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Hq0HMVVQC0q1652BqqLHqqWbcn4XQwGZUokDw2NRqrhT6RF0coFy9K+MW6qqm3CIRwGIj3wuX1PTDf4G6jVLTYIWMtF1BjPdHAClfdZDFXfF/OIQTwc/nQQQ0A3/isUgAT4BL0FxUHZuA+dJ6ZAWWkEkbm7JnVDP7qr9SsYLcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqvYmAiY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqvYmAiY"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c20ce3c118aso83821666b.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789635390; x=1790240190; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DtQxn+34Thhy2qtjMzseU4wTyfS4Tx7PRGmA35sQ6Ss=;
        b=mqvYmAiY71xlFwbpnqJ62ZANIvynaR/0kXxnv2AvYc0AfJbm6+uP6hxth81Xngoneo
         YrXOvfhaHOowy4s3ZTbNRu8tO6crTsOabFGlJPE6xKhmP0D+EKLi+e6XIh/Oji/hzHyl
         YNmBkEUTpyNKK8zGP3KHB/PlfkUp6y/AdiJOmL7j9tFT2X2Er1l3hUuA9u5+U82fLVyI
         3ZiSJhs6cGMK3KXDHJuCB6JWFiGWk/srIHIJP7quggV0TJF4C2Cpnj3NJKP9d52/pJKU
         Z1R63A1Aww5+Pq4wTXFhtSaLqdMG5EpOqG3FXTx0PXDyUiB/T1qLVd5/eTjthtXr4SEL
         CQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789635390; x=1790240190;
        h=content-type:mime-version:user-agent:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DtQxn+34Thhy2qtjMzseU4wTyfS4Tx7PRGmA35sQ6Ss=;
        b=1RWNqbEwTcNmZbGWljsvR9YJr5LxoVRm4ZWNPrA9W1R6aPtJXCns/KPmTutLMODyJF
         CAxfr/Q/8AJstjDzUDkU6OAfYHWovcoUNlTRxoD84RPsnZjLJYvA+8HEmpwl1erF/5hs
         E16hqEeCN7RHAZFV4QOX440Wd7WCTPdSGztiv7hmkXdqDmWOtbToTI9jJNRrnWUwk5ER
         2D2Mc15Nyt8NNU8wM7xK7HHWHACRGf02dzWmsAh0yK6rCcgCNIM4BJyqA7dTXaVVAPJy
         5xkHXGPYLMWFitM4Pql3ME/G0zItbUuKkXcrb5A1pVus8ekUI0h41cr2n4DfxU+O+LK1
         SMQg==
X-Forwarded-Encrypted: i=1; AKwUvBwbC+I6DWGsIP++WyLzW+Zesfbe6ZDKr6XoaoIuJo4MQQbBlmJpKYCYVaI28AyHJ+m5SAbz4ys=@vger.kernel.org
X-Gm-Message-State: AFuF++mJ9vfqF6YIg05jsEp2Aar2pusJgzhAOMQ16d3S47MUj/JQSF5c
	d2IPS6AyEbL25laWUcp6J+8K1U2ooOsuVYTbdMfS+wzrX5cqErbE9WAm
X-Gm-Gg: AYBFou2XC8IqI8xMjLDQ1FhecJOukxlb91p2o5+rclgo1gO2PmZWtA+SaS/Dt56JJB3
	JOQR2nS8EyoCr2rSr7deVKI+uhvxyC48lQutgNs5haNx4tj+y278QLShBLDKcXB8XiFbyFqfT4A
	HFTNINUg0cVF24B5r1xDR6rA5DHEoYdf7IfXInx7Dig3IfLkCFlkrJjhWq9vpFU4fbBu8yctXH6
	9fnISWvdOXcN3ZTjG2MMx/aHwsX+8F6EEIAFAWY/qJI1J0N40T8JRSW8iGShP0PbwIxGkTmJfiI
	+4Bjtdr5wDBsAErBJ2kXtD2GwLdCq46+If6Mx0ERdaV4L8i12aUKplYr7SZdF30ys/t3W1DtAY6
	sSTA8NdaEUZePd2lvciWFkFXdyi8jvXbJBXdV3BodGRe1MNcyLBXY9FOMnZ018kRzvDMbddVbdz
	4uhMllV1NwiXMtY/7xqI+8NcmdWr7MUGJIuCRARV01+dXm4NBdH512AdseJIWaPUPdovyE8gNsZ
	rFQBGMmwD+AVK6xTcY=
X-Received: by 2002:a17:907:9289:b0:c25:f7dc:2dc with SMTP id a640c23a62f3a-c29f54eb1e0mr189544566b.29.1789635390220;
        Thu, 17 Sep 2026 01:56:30 -0700 (PDT)
Received: from imac ([150.228.9.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1cf66150sm3363027a12.0.2026.09.17.01.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:56:29 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org
Subject: Re: [PATCH net-next 1/2] netlink: specs: nlctrl: fix the policy
 attribute numbering
In-Reply-To: <20260916021516.1701760-1-kuba@kernel.org>
Date: Thu, 17 Sep 2026 09:56:10 +0100
Message-ID: <m21pasp87p.fsf@gmail.com>
References: <20260916021516.1701760-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> mask and pad are declared the wrong way round, giving mask 11 and
> pad 12, while enum netlink_policy_type_attr has
> NL_POLICY_TYPE_ATTR_PAD at 11 and NL_POLICY_TYPE_ATTR_MASK at 12.
>
> The kernel emits the mask for every NLA_POLICY_MASK() attribute, so a
> Python YNL client parsing a policy dump maps it onto pad and throws it
> away - 30 of them in ethtool's policy alone.  In the other direction the
> 64-bit alignment padding, which the kernel does emit on architectures
> without efficient unaligned access, is decoded as a u64 mask and blows
> up the whole dump. But those architectures are rare.
>
> The generated C parser is not affected, it keys the attributes off the
> uAPI symbol names rather than off the values the spec derives.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
