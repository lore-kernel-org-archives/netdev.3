Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6573FFFA5
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407886; cv=none; b=BWv/Bmt7+Xq2kGHyyQO1lHq3f2F2tFu4s8L0WDNiFh7kEzJLOkDVym4emuSvxo1ARaImCF2h3f2WnGMSC3FSJOxj9LIUbxVhA2tdh7BwS0JNaHBYHRVPNnpv/hRvLb2NyVZ3AEucRiESTrobfxD27XhqqlSTWBAykqYm7eb7DXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407886; c=relaxed/simple;
	bh=DaB1WD75GRknJfL9Bf2/hDlK7ZPpbPT2DAN88FkzR6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9xfSm0A2ANlDwzGjl9UTbpU++XXbSvdH58MQoMoSDUSvfsgmoe37WqIgD3l/eWdZReLHHos4u1WSxzzsgfotgGTRytU/o999gaFvxjsD7Bx39303Rlx1wTw1/XPxuOohDsWd1PWmuWQTlW+ecCz2v/Gpxtl5CTe005IvO0nHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QM2cCVon; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t4NLg3c/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QM2cCVon";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t4NLg3c/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785407883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgkmD2MutqWFU16wY7N+FGgugaCx8cxXpzUqUgToMPM=;
	b=QM2cCVongekUrUCni7pY2bWawkJiBhdzHzACX1WC+GioZiYhhMcwP+cKzdo77XOTbWoNSn
	FuCOF6bJJQmW1Zi0NYNpFzZRidt3uy4p7KvGV3w5nQKmWSTTlxZfLrY9ZIKpM3Pc1WwWdq
	A9RTk8/onydgz+u7BZu7EQNdXVJgd5g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-XAG8bcBBMZyemUngkYzDhg-1; Thu, 30 Jul 2026 06:38:02 -0400
X-MC-Unique: XAG8bcBBMZyemUngkYzDhg-1
X-Mimecast-MFC-AGG-ID: XAG8bcBBMZyemUngkYzDhg_1785407881
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso15843125e9.2
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785407881; x=1786012681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GgkmD2MutqWFU16wY7N+FGgugaCx8cxXpzUqUgToMPM=;
        b=t4NLg3c/NkbFPU999xDPDqvni1XnrJU0ZIFWKDAMc5OCntx7bRHEUY+Y8DCZuNHhvy
         Q55J3AGRL7RXHlncl6KWBdFP2doq7x6/c7gNEspCXcwFEXFnpVhpQAFob/lDWzzmrs5F
         YNVWmk52CuQRnm+l+vMHJsKFofsu8Qua3RupcncDpc8PjqWFYhwvbw5LDldtzEjWyJdZ
         JfFZwXcGj0cNtWRG95SVM6GLX6k2aW3psFTcH60/WmsVjczlM9IrjX/Jv8eGh0zL2GN4
         VV903Myr3RZfQ+LhzFSlEqmLZQM1ngU+BuCLW2PLeP6aQftrxoj3i5xD3jR01AJgph7A
         CxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407881; x=1786012681;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GgkmD2MutqWFU16wY7N+FGgugaCx8cxXpzUqUgToMPM=;
        b=h+A28BHVEx+VUBYwZuLml/uf3OJ+vNLF30gKwMoo59iAQ5My1K+prQYOk21/EZVw4d
         OPqdzE0nHwKdg1AhtyETv+K+MtP2lUV1mIbYU35agqa0asebnqHtq0n+LctC380vRVaM
         P2upzW41PwimxFZhwMqVvyEPINQMsYNc8iPj7RARQBCaQrl6HUWRpvVJmZeKfHNxpwq1
         i7IgRKXBEt8UbwCU5NYjZ8XDUd1jL2jjprmDOjlsLIOFjqMCUx1/obj9wL+cga5L5ddB
         kjgNOmh69Xc4p0xGkyxGF8/YCmkRliAqAC5dJX/ptJKbWDc+AEjBZrB7Wx7nJBTrHGNb
         uB7Q==
X-Forwarded-Encrypted: i=1; AHgh+RrAAN7DSLVX7lRpHAXoXvEm1rsfmX/1ijDilZ8Hdq4DgrphN7UQhxMELEQtu53WYbKtJ0pcc+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWN1B1ua+JquVjpTRj+b2S+aYV4sW9DnCiD3hh6R6FaxMZUU2O
	I/FKECWRx4tQmBFE8ue5zZPEylIhwvk3woacTCxEFq4/rBidOLkSodsRFD6FIrTAIqYD1Ft98B+
	Ys/7ULRAEEVwBXyMFQYB9qgbo/pRs0IS5PX/+WHjjW2RhreWI1K8KzrGLPw==
X-Gm-Gg: AR+sD12+nFzZWPMtuPGXUGQdEi02d/eFk9Kgp7hFMjxR1WTlqaOgMt6S+aT4NCCcEfT
	ckDwIngoGi4SUgjsfKNnCo/f2/tbaZcYCykDJ8xheEgvewX3JgTqZx9bEQp6EddrFjUMtn9/A5l
	x1CJJvNpkb+zF5N6r9gIAzhn8SJmau2TukNUl3lmq1tlx2bm30YmLg/r8neM6PxvMzgAkracu5S
	hQeQ6IcI9z9x+o0NpKcA8xr7mklRUg0RdzozyamzV+Yr9t54m33sqdTLmFa/kml9x20p+tF/7zV
	cKiN2EaZQoLMcLlN9xlOk+I2+xALX+O2TwRmDrXlSWh2fQtiVIuS3uzjxRmeZI+M0pwbbjsWYJY
	LXrAUi3Cb3tylTzcE5aJVfB43pLcwHPMIqG35E+lrTNH7EO3ZSRVQE8FGU06flkY/fEuayxo4Iu
	elyw==
X-Received: by 2002:a05:600c:1d27:b0:495:518a:5cbf with SMTP id 5b1f17b1804b1-49800eb3d89mr25890355e9.32.1785407880694;
        Thu, 30 Jul 2026 03:38:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1d27:b0:495:518a:5cbf with SMTP id 5b1f17b1804b1-49800eb3d89mr25890105e9.32.1785407880249;
        Thu, 30 Jul 2026 03:38:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d6f18sm4963983f8f.4.2026.07.30.03.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 03:37:59 -0700 (PDT)
Message-ID: <08ff5f82-c7cf-4d6b-97bc-debe2957331a@redhat.com>
Date: Thu, 30 Jul 2026 12:37:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/3] net: dsa: motorcomm: Add LED support
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <20260726162731.1005803-1-mmyangfl@gmail.com>
 <20260726162731.1005803-4-mmyangfl@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260726162731.1005803-4-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/26 6:27 PM, David Yang wrote:
> +int yt921x_leds_setup(struct yt921x_priv *priv)
> +{
> +	struct device *dev = to_device(priv);
> +	struct dsa_switch *ds = &priv->ds;
> +	struct dsa_port *dp;
> +	u32 inv_ctrl = 0;
> +	u32 inv_mask = 0;
> +	u32 ctrl;
> +	u32 mask;
> +	int res;
> +
> +	dsa_switch_for_each_port(dp, ds) {
> +		int port = dp->index;
> +
> +		if (!dp->dn)
> +			continue;
> +
> +		res = yt921x_leds_setup_port(priv, port, &inv_mask, &inv_ctrl);
> +		if (res)
> +			dev_warn(dev, "Failed to setup LEDs for port %d: %d\n",
> +				 port, res);
> +	}


Sashiko noted that at this point the leds are already exposed to the
user-space and settings can be applied before the following take place.

Also please note net-next commit c82ff94592fb

/P

