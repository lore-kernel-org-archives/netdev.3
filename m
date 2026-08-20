Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E55046C4B3
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787232668; cv=none; b=bJOkeLWlnc4gryr8X5Adgva4ry3LNsA7GENqCJG7Tg8w22BhHsysBQLIv8bZqcKkTql3E1WKwpJtJMRlyq7T4MI6rB/BxmyEj+c/JE6fqAXI+1lrRS4e5cK5EeR6/BDcOmopMnwHIy3BwL7RSpls82WUuVJfiGXtl6ni9vDNL3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787232668; c=relaxed/simple;
	bh=zVtdxFqEqywL6PGEnJ2HGiXdl3cEoTFkok7FvBGy/g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMhffmWZhTRExnEtNVdrhDeyl5M5pshJMYPkrIkV7M54ZiKSAvTF+as4GNqUqtTkn9GRrBvdbF9Vr97OEv4TiYFNZvEBaC7LXB16qCQjyPAeWKnUZ433cq8ug9JPbpX4QbgGOwmY6LIth09soXQEprJQa3cgOjd7oyqBssiRkh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVzKqQ/2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2/9MIfl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVzKqQ/2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2/9MIfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787232649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ort91N+bL/imQIUmvLc3Y5JcytXJcx31vDBpNWzpIC8=;
	b=XVzKqQ/2H5Xcd9YKkWvsZWp45kcVSMxRfVSDr5KPMu9taaYZZLnuVzFavni3dAgMuY+3qN
	J8GfyzX1RifrpYVH4rocNcoAWYdh3gLlMgvqYt/WlhecllCBxin2y7/BJgSPJDc4LnlDMc
	vDPd3v5ubycZt19QzZPgdeLEJqlbSrk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-SSOBXxEXOkih-5EvQFXsfw-1; Thu, 20 Aug 2026 09:30:47 -0400
X-MC-Unique: SSOBXxEXOkih-5EvQFXsfw-1
X-Mimecast-MFC-AGG-ID: SSOBXxEXOkih-5EvQFXsfw_1787232645
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso18859345e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787232645; x=1787837445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ort91N+bL/imQIUmvLc3Y5JcytXJcx31vDBpNWzpIC8=;
        b=Q2/9MIfllafph2A+QSUSBYuFYZZ62hCOi2GH8dvHrw05MnVeO4IaASytArlR3xohnj
         tyJobNbq0DXzm44e+M6OOyjfUU+2t5t3V8gOBb/eCtF5utlDPzmBMsIgQPQ4yiwhY/qA
         thwM83yxAs4zXodIVtfZTrZA/4d/gs5sM1uTOrS6g6g2oBb/zABejirQ3V3Ehh8DtIgA
         aR/b22WIDXhebZL9/i0wKDHiODH2tI4CMtih0PRW5O4uWR79By4eYEDXW6ELwA7NdXPh
         SFwlO9hgD+QNzRy7JBxyY8CDDPfMpS0xUfY60rHtGwEBR+PS6lBZtKQfLAVmWmoPin8S
         8p3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787232645; x=1787837445;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ort91N+bL/imQIUmvLc3Y5JcytXJcx31vDBpNWzpIC8=;
        b=GLgEF6Cpm22KWwzoBPznLyhXnreeF3NEBly5wdkH2igED3i4Pt3vYpMgjDsErJlIqQ
         BPxxZPK9QbEL4JRKMJLmbIkbwW5QdX1hEbWF/KluqEIl9NJ3yh+K4OZ2ZcodEMEt4KEw
         upkUp9UkfIxuqW31smF7Fc0pcXujT6V1Ntyc1t6/dcuIDcMCPuiaKclScCY6w0N9QSMm
         1kdhu/823qJ3IHC2VxvHzYEmObqg4xaiVVOuZkwoiiACNyYQ+LKTAdpR+OtiWy1QV2Da
         o08AnNSjZID9I32aGzQfh+axTeNi7TP2FLamIxTNICP52FSOdDLIluW7eoDeV1kAeMSv
         kQWg==
X-Forwarded-Encrypted: i=1; AHgh+RokclSWrEDXRNsyVMHLvB13PqV52YRgPn5RjK+FCi9YRzT5hvkiNii02gu/CZgIUqWoW/d9emo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+tFGTUmCrip7X5nUEBUQF8R4+tT2Zadq+DtKnZJfGM7Htb5Y
	wceCJaGrynELj8ssdEXvGi4ZjM1prfR6As2IjjvR5OGbR2EvmyPnsTUS5kiF5eCE8/WXO0Y44YX
	XeLWNSIuLY+1wqBtvfVTva/ly0/pFSIPSfQ7ioZIGvWgVizqMgXKt74z4ow==
X-Gm-Gg: AR+sD12y2j/qBS9Qcp3v5ldsj3l8+7/0PlVIbwX/Cs+Nv8pnxYjlGA/NzgCMj4a0u1s
	vv0xZ2FKWzqSw5mUu81ry/MJOBtHE4XHfA0HUIx2M/H37nT0DcQvB/7CO/YBqbNpO5LLN6d3JKS
	b89Il7qb9JxdYXtpME36y9adxoJ5pjk/gkJgk8EghWToLvumhDM+bhU+y+lt85bvdCMMqeZGZkC
	XcEWfcQM79X8ahrebku3tvAEGrT7lnvca/tMWcXFnB9Sowh5kXP0kXtfhY+wAqlUV3T3bpWOaaW
	ahQnPsU77Ag6PwNFfJqwWhnPOYjsTjytqv6Olirbp70aL9STKHEj4Wc5BHJdjASeIjQo9pSlPf2
	7K9xc0L3tEDFCv48fWXGucnl52WojZQy3UE3Y0mJBPz/Nfocs7X4cQDSfpplb0CJGbPtbEzUE6Y
	0=
X-Received: by 2002:a05:600c:34d1:b0:499:49f3:77b1 with SMTP id 5b1f17b1804b1-499aa14a6a6mr221961405e9.3.1787232645484;
        Thu, 20 Aug 2026 06:30:45 -0700 (PDT)
X-Received: by 2002:a05:600c:34d1:b0:499:49f3:77b1 with SMTP id 5b1f17b1804b1-499aa14a6a6mr221960525e9.3.1787232645097;
        Thu, 20 Aug 2026 06:30:45 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b2b96537sm41185975e9.1.2026.08.20.06.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 06:30:44 -0700 (PDT)
Message-ID: <a618bdba-c370-4f16-ac09-0f7ceb742d42@redhat.com>
Date: Thu, 20 Aug 2026 15:30:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: broadcom: Improve IRQ error handling
To: phucduc.bui@gmail.com, Justin Chen <justin.chen@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <opendmb@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260820111456.97947-1-phucduc.bui@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260820111456.97947-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/26 1:14 PM, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Hi all,
> 
> This series improves IRQ error handling in several Broadcom Ethernet
> drivers by propagating IRQ lookup and request errors instead of
> silently ignoring them.
> 
> The changes were found by manual code inspection and compile-tested
> only.
## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.3,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 31st.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

