Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D843304D
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887982; cv=none; b=nZWzO7WVieTaECLuzZjvhc5FDVcAA4KKNQPGZl4z8bp0RW4amRcUafW30/DG9W8Q3zaN1xqz+T9xm9qDJiIokA85mDcaUOUDlaIYSGLqENXy3R2BRqwKZ2ozN1/wCF1kMtJqrNfNJjCy8EAUyRBqmBGdrtmkdv/8PLKQ77mnvco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887982; c=relaxed/simple;
	bh=Yh5EoZ8L8sCNFwRaMZG6NLakXRXnXBmJAd8ORRiLTdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2AVCfpnXb6MD8Bf/z0cxt42gAiAFywkj63jlgAhwSObD4YNSC1x5Ke70yIq1ZQ9/r9XRoEfLJcM2NEGmjW95vRHbw6QF/UhkFNuj1bdblIyoRTXehda+2PBnNDF4Hhvt0RROKkESVHdeWWTqh+N6q2fN/FEwaOcNfVm60Vegl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nc80WKid; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZ8uc8Rx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc80WKid";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZ8uc8Rx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791887980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Stt8E8LEXRbDbMmCU9sSGK8Uotc3Frs9Dr0f6bzYxJg=;
	b=Nc80WKidpOn0KZPEoxLbyOJyTpj7Q1VEhJAas7QIRSSLDCeTgdfz/uvE2zAwRRlRzL2N64
	3pja+vk24lkAQ+F9IzvynfhDmJDShnWwK3y9FKTI7YCgzm1KtzypOR/COeAZalnuDtJJ60
	pRTC4zidNM5WoPnr/fHgSn+7rZv/1Hs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-CLExPT6DNGOkbkjisckz1w-1; Tue, 13 Oct 2026 10:39:32 +0000
X-MC-Unique: CLExPT6DNGOkbkjisckz1w-1
X-Mimecast-MFC-AGG-ID: CLExPT6DNGOkbkjisckz1w_1791887972
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1813fea7dso44166915e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791887972; x=1792492772; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Stt8E8LEXRbDbMmCU9sSGK8Uotc3Frs9Dr0f6bzYxJg=;
        b=JZ8uc8RxmfE/3MAoa7etih6Z1NoMhNSQeHNY8oamZgyMHfX/xVz4R0rxSKjW1AfbLf
         Dn71UjnqxRbfomwuyCg26YlIszmzSxF8jbKVIpjUmIvj8MzBgLIyicGoupMPwWJVIbdK
         Kd1v1wXglylX4FgTrEgPUAkNriIYfEyI/9ePw4q2HMmFuiJhcwYe4C84kHt244wpxPHC
         OE+9sRVi2h01NCHcbFcmW8IO2cu10XOIrIJDYqjdRe5Gc0BXHHr5BZTu2tdsWqiE4V1R
         vdufGsvY2BxBXXwoOCCREr1t/e6gGcV8wL6kjlGdPUJLBZgdq50vwn2llfxbizvBv/Cz
         hx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791887972; x=1792492772;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Stt8E8LEXRbDbMmCU9sSGK8Uotc3Frs9Dr0f6bzYxJg=;
        b=cIs3gthO6pGTyxjFmVYhT+wm1xm7+cy9Omj2RBzRoqm+UrP8bidz4gmGqR2W3MhVws
         u4JjTX20HFkaZr27r6yNPIIcn1HyN0jbpjGuT77IA2IHCmuRKIYI4kgrr319ldpMCdqE
         aUa7V2OENGgHc6D7JW9omYInC7sJOGB/mSuSVaStlebJaK3y1BNGrr+xQG7s8i5t+Gel
         kpRj5UUCaLJNCroiDOFYb/0S0LywoH0GXuVuBG7CE4zK3S7i+3qCdLWyrqZWCeuE6+aR
         DsS6BR49QbQ2aI1yKZK4PtifrbUBk77dne3JqMFiv2nC4n5O6Yvf8whkPrtXIAUg3PqQ
         nL3g==
X-Forwarded-Encrypted: i=1; AKwUvByMYWCR4DOlNGw7C1X837HDYIzzWxa9YoWmYMTL/Zup3XmgcUIN1hM3QaAjVXNkUq2axiJiYQA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBCzeAQWj4uVMm9QvVcUr6XxWucmoS2JtUJlmampiyquXLbp4c
	+AV6Va4BWNN4jXrSU2g+2Sd0sohjbewQkv3CWrprv02q6l46F1fwa798rMN5DBS+DqSp8/Jvciw
	Kih2o04fDCcabagDHNn7mPd6xen+EuXrKzbPgZCAa5oE8LLfIM+2eSaarKg==
X-Gm-Gg: AYBFou1nYhQRjcpnFM/icS3HJUFYcUr2SZFNExYCmknwBDaJxTx3oU/8hgKKrabDshz
	Zx3qEllfmmpy2CBu+XrrfJZM7j4BPdt/Fb/r3M4QvFvIVWlVBB6uoM1xSSC144b6KGUDGaRe91U
	RW9uWrLKae4bbyobIUuxSNnNZqUykXK0U6lC+XQ8n+u7hI102vR6E9KGhuAeZADrPwXJn34sTHv
	Nnq4dsO+ogDracIskE/k4PcK8QAyN8a8r2Tcse7UR6SFVkT7y/zck34cwwHxgaFya8n36i6x+UK
	qO+1F6yoUJ27Lgy5YFL02ZWxJXsBqbcwvgL8sfXhoKhOCgcDVVkFW/QgBx89H8oRyCJycoMdIFo
	dbYT5/obXVJoqm+UIH8tiITM/9JSZlmzmS4Lbpjt+uFhHNSbsamUBAOK31eJnoob6/oCxSEY5KQ
	==
X-Received: by 2002:a05:600c:8105:b0:4a1:775b:5eb2 with SMTP id 5b1f17b1804b1-4a18e48362emr231673395e9.13.1791887971565;
        Tue, 13 Oct 2026 03:39:31 -0700 (PDT)
X-Received: by 2002:a05:600c:8105:b0:4a1:775b:5eb2 with SMTP id 5b1f17b1804b1-4a18e48362emr231673005e9.13.1791887971189;
        Tue, 13 Oct 2026 03:39:31 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967affsm3971206f8f.1.2026.10.13.03.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 03:39:30 -0700 (PDT)
Message-ID: <d19cbf9f-a5af-4fe5-9c20-eac1365afb92@redhat.com>
Date: Tue, 13 Oct 2026 12:39:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] net/mlx5: HWS, fix reformat release and meter
 offset
To: Alexandre Cassen <acassen@corp.free.fr>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Moshe Shemesh <moshe@nvidia.com>,
 Yevgeny Kliteynik <kliteyn@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20261007143830.1733583-1-acassen@corp.free.fr>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261007143830.1733583-1-acassen@corp.free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/26 16:38, Alexandre Cassen wrote:
> This series fixes two issues in fs_hws found while offloading one tc
> rule with its own encap and meter:
> 
> - Releases L2 to L3 tunnel reformats to the pool they come from.
> - Makes a rule select its flow meter within the whole ASO bulk.
The actual impact is not clear to me, but given both looks broken
from the beginning and Linus pressure for smaller RCs, I'm tempted
to move this to net-next.

If you disagree please scream it loud soon!

Thanks,

Paolo

