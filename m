Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE5C2C0F69
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910669; cv=none; b=qspvy8K7d9R1JVzM4L8HMgqa4z/cmY33GKHyYqHvT8mTk4iaXGQDqdQ9kLYA3iq439PNF0tZnFL+knfJUlT1ov/uCV+XRuICMuKiz39Kfz6hkQl5yVWvu7VhZZ/L3o8QlCvhEdJrJk/Gq3uE5mr3HVrPZhRJeDq6YKCClzdPwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910669; c=relaxed/simple;
	bh=1+3D37Chte5WariihTF70sFkKmTig7m4u3ksibpfj8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9X7ZTb62j8htFEfw1ymsRX0Nvz4O5m3wwQOPZsHcNau35+2qaPBQggg/LkRulJeHjSltc/Alg+Oya1AwMFnXGTpxSmfIy1KOJDWsVzC2Uc3prC0g/zXKOCuym4N2Td3/bZZbYvE5nzaElc5KReXoxWcB6HMbJicT/31Wei/JhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=awJ01a3u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbyPfswm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awJ01a3u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbyPfswm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773910667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6v/FwhAYeX6H7aDSM+UJfiH1F7An30WbQRpblD/0TJA=;
	b=awJ01a3uIpJhGnV6VSmNECTWne/htwDU4vBTklfh0nFOqPf8wb6AjxZrZ96JcH3EfQzseR
	J4vQhIjMKTGGRuAwEg37Ddzws9TxCeHYWf/lm8sDW40DRIonIsRJUIqb+9hgv6i4Ph937a
	0IIOwuwo+Gww9avnIT0KdgfFq3HfxtM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-lgtsOOV6N9K9FABDbIP8wQ-1; Thu, 19 Mar 2026 04:57:45 -0400
X-MC-Unique: lgtsOOV6N9K9FABDbIP8wQ-1
X-Mimecast-MFC-AGG-ID: lgtsOOV6N9K9FABDbIP8wQ_1773910665
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4839fc4cef6so18490625e9.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 01:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773910664; x=1774515464; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6v/FwhAYeX6H7aDSM+UJfiH1F7An30WbQRpblD/0TJA=;
        b=dbyPfswm4vjvf1VNXz2A1wda6ajiRglQLXKygyp4+/SMRnQ6aGKfkR/MYJQQ9UQQD7
         h/fhkNaB6gGdZdo6IckmSGwaVly4r5Hqmwijbh5unweW85BCDwChkZg21N67qQiQby3+
         qVNfjnGV+6UvE62QPSjDWZjKK8HV+Nf2/kcoznZUQi01/ox5szBYdzWyMUhjIKGGu0UM
         Wm9WVZ958ltYuhHg0OJ60ZaBbEjtcqUnYEik3VdMGwDqtDzA2afhL5LccxIJQu1Em9Gw
         90abjDPEOcvkEDnbjq0VTo620mYaoizZXx7fT/wPWko9ez0uaSl4HaKGhisCYkwyjW7p
         io8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773910664; x=1774515464;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6v/FwhAYeX6H7aDSM+UJfiH1F7An30WbQRpblD/0TJA=;
        b=rqiLQ3XwcicK++4QkQvCK66nfO8qK58Bbrnts/ZSR6/zHiBCp7EIOZUTRrBfczQFY5
         AvH4GHTOx0NyOX+K/YKaxqpX8flKPoN2ll5nZIXJalpEYKJzCfdF/91oNBH5cwnO+CcK
         dHxsfRTRCUEg/DhxG6hvNdolTnLcSqsVvfVh6fT5gKHzUy3rSVyb6CGcv9bG7xYL49d9
         1rFw4/G3wxw47AGtcL1ZofGXFP7UgbkbbH5t2JAPOaczIrQ1uJ+OJSTtci3/8m+WTcrJ
         0ZIbc5zDHy9EN/NmpscrL6phsDelWPuLoVvvTxBn3vJrjX8aXHklUi2J767h32wEH/lA
         XJrg==
X-Forwarded-Encrypted: i=1; AJvYcCXJxuTg5m31trmw4knMI9yyxqtFcBAOskuTIfefpuf7IoRprDFCe0A+cTJ/+/Kw4BCVxTZUqVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7wbSXrSV9qEcI9eDOTasW7VBZnqMtMfoxhk8Z7WqATh34/Re
	JXY6Sb0D//WDnyPCQViOIrNXo+ESPSh8QO8596X3n3LnbvSn3aBG601D3m4t/yOE9hksXmIt1Xi
	qZt/Qk7TncMg2OFp7n4j0SYZF9ZpbpxCB8xHL7Uw1uMTCdS0uJB7tY2+G5w==
X-Gm-Gg: ATEYQzwrCkbODpugeVd2LsfCFcUJxi4lkmyagxheQZ7BAEyioCNluMDIi6J/Nwa+DoB
	S1eCqvNk+7/6yhuV05MFL8CxtyXWWv7ztUBfZspjhyxr2XEtyeUEXMRVsgmgXEs7jmq5dGueZvM
	pADWlsxxAVV3XQ1b04Wd8JWs5TNOctarXLU6EJMxialRD8dOT4YXsBtR8YeOdj2nwH25vfwzX6F
	/K5lkIQBxBpX1EgFuMOERS6SA/icS95vQbbCf5XjIsh1Ddw9A5lF8OGWci3HAZ0grHNNRqCY054
	yieo3uIemZCTN1t04SNsxU66pmv3LgJ4SBAoU3xL3EAmursJVnfbBPNhB6f3PRz1J1FQtNS7g83
	eG1WlJlYkuXrV6RpeCdQEB6IQewTwuewzz96Mr9Z6XVxVix1+BVq2GXZZ
X-Received: by 2002:a05:600c:4fd6:b0:485:3f58:da2 with SMTP id 5b1f17b1804b1-486f8b6ce01mr41013155e9.16.1773910664502;
        Thu, 19 Mar 2026 01:57:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4fd6:b0:485:3f58:da2 with SMTP id 5b1f17b1804b1-486f8b6ce01mr41012815e9.16.1773910664112;
        Thu, 19 Mar 2026 01:57:44 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c4aa85sm41879665e9.12.2026.03.19.01.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 01:57:43 -0700 (PDT)
Message-ID: <fe46d64b-1b12-48b6-b663-e7d5122b7b8a@redhat.com>
Date: Thu, 19 Mar 2026 09:57:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] net: dsa: mxl862xx: implement bridge
 offloading
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
 Cezary Wilmanski <cezary.wilmanski@adtran.com>, Liang Xu
 <lxu@maxlinear.com>, "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
 Avinash Jayaraman <ajayaraman@maxlinear.com>, John Crispin <john@phrozen.org>
References: <cover.1773591297.git.daniel@makrotopia.org>
 <0cf66a043eff3585270785a35e821e9a44afd6b6.1773591297.git.daniel@makrotopia.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0cf66a043eff3585270785a35e821e9a44afd6b6.1773591297.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/15/26 5:20 PM, Daniel Golle wrote:
> (struct dsa_switch *ds, int port,
> +				     struct dsa_bridge bridge,
> +				     bool *tx_fwd_offload,
> +				     struct netlink_ext_ack *extack)
> +{
> +	struct mxl862xx_priv *priv = ds->priv;
> +	struct mxl862xx_bridge *mxlbridge;
> +
> +	mxlbridge = mxl862xx_find_bridge(ds, bridge);
> +	if (!mxlbridge) {
> +		mxlbridge = mxl862xx_allocate_bridge(ds, bridge.num);
> +		if (IS_ERR(mxlbridge))
> +			return PTR_ERR(mxlbridge);
> +	}
> +
> +	__set_bit(port, mxlbridge->portmap);

AFAICS mxl862xx_bridge role is to track the above portmap, which in turn
looks like a quite generic information which could be easily tracked by
the DSA core. I'm wondering if it would be useful to move implement
tracking there, and remove the mxl862xx_bridge entirely.

/P

