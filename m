Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F773F0757
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995583; cv=none; b=dw0Kz/PmS4zcZwJH2/1wpJazykjuMcEMi+3QsUwuw7DuE9Ho0hdFk4+YRCwCVavW58IIQ1DzKYrT1col+TDERKv2x3vkWv8by9o4MslkDm7NnKfhtl91RxQWULFS0nzsBPTo7pKc2VnRqmegEV9QCmXaoJHIo9zxP94fKFgpa/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995583; c=relaxed/simple;
	bh=f5S+i3RVl0cUqmWNDjtmc/b/yyrLqBrgrSpRPlEOqsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uociqh44KNU6SNwEK6qYie73YjMmivtvyFatwm4jo0x9VcwN3R0B63kSz1GWv9ZS1LwTuM/BWLkWM75sp//L1eJJPYv19g6RiDXyENXi7PaZuwd++yplX3HwYJcFOTxZIoMVPaihfg5MenFAGfuaGShfMAFoHad3+T12RdheDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FoU2a38l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AoWdc3G0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FoU2a38l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoWdc3G0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780995581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CPgszwVt4cFE4ELVefG0ZpctOAG18a7ufhv6a2Zqquk=;
	b=FoU2a38lJcL+uRzIBCzKpXpDGFmXs3dYTyND3fT/HHsakKyRDulzVKDseFNOAZmw7fQ/sM
	25tjuQkN6/ZJagigM/3ZqIWsPSVX9gq468b7evnSkv+RK8ywAgYNELjH0HtHWzsvgSd/QF
	QmIdbyNMQ1wPHr5FgHb+CR1IJG8SHcI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-djPX3keJMeexIWL-EMTuCQ-1; Tue, 09 Jun 2026 04:59:36 -0400
X-MC-Unique: djPX3keJMeexIWL-EMTuCQ-1
X-Mimecast-MFC-AGG-ID: djPX3keJMeexIWL-EMTuCQ_1780995576
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4601c9b630fso2114944f8f.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780995576; x=1781600376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CPgszwVt4cFE4ELVefG0ZpctOAG18a7ufhv6a2Zqquk=;
        b=AoWdc3G0VQcGsD3QMYITfXL22mZxSwJxsoDXmxZ+nqkzBQ1EuMhmL8rXQHYv4H/3mv
         AocrqB1XTAX3Fr8Y/L+/93F5KlpTqnrv0L0/dh+AVzlbQYmrWc7OAGmaT6oFtzc3FzzG
         QwA2NzIvyAPd6isRqSJlIc3oLj6ozCFTvD1ZkbgZpfGjGKzrbqkijlsuWkwWmOA20uLq
         LKGQIdhG0l/sJ9KN5GozJsDjv0Cw7QvbsK1uSx9OB36jGhvTo1/1Nas/xkdRT2hP05qq
         3Ko23kOVtTP46E/0Z7zV/JfsEKbjFYwn62rTqqvx4vEHc3fOMkUlyWkBWk6mtrDsSGN3
         nteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780995576; x=1781600376;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPgszwVt4cFE4ELVefG0ZpctOAG18a7ufhv6a2Zqquk=;
        b=GzNI/5uzZx3bXMWv3XyfiZxw00Yx+5Nk2b4Enwu3C3y2K3beG5bC/8a7Pig+H/8B9w
         FeJZFyxvkfunM6oqo1iDnQXqF4nmoMqcYx3oZ/CpAg4M3UnAbFrSA5fuD3vFoA1WXl+q
         Pjh6fgtOnWWC19QHO9JEp8q1umMXv5sgr7NOpk6vRa1LJkf7oK3w/5Jn568qP53p///G
         kpBNTM8ZKGHwxJFRZbzBmgA7eQ1QG28JRxX1cmXJabFYVFFAvEDUJZaTWnxms7mp8BDh
         cJzZgyLoiF9OnqeZa3B4vT+IExWwaPWjChwJ33J2GlGUjKICW9B9z0ErpbDN74WS96c+
         II9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+w0gK+G7Z5NGfUgm8fX9Iio3/ublq85Lb8QrEHGBnrLNjFlSUdpaWZoHN8Giqk4DuBRQA8XUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6bbYCuf9h/PzNGeOOUV2btaWwTFSR2O045Bsm5xUp0x52NoUY
	gH8W8C65251EtUQE/kdA4vR2N+Z8/94f64N8YLegEvNjQvS+7j7L0JNSdDmesJzJtdfZ/OlKAoW
	x02UNLNxZC8AiH1eX1xdu7UWRMVWpo961zUJ9aUxc5J4UP+OTXKa5yxms1Q==
X-Gm-Gg: Acq92OEkDkBT+jpkpnEg+eGglH6CMbGwVOCbo31/RA+owED5EI66mr6eewCAvEMLa8E
	grRbJjx3kZIpidCsN3Gj5i5NCGAzOoJQiMCA4e6dZExFTrPO5rmRcYkPJKeWsa4yxc9fmiYjNI6
	0n/hAhk1skkKr9UigLKAZ8c3tnHQ3Fn2Gq0JKBo43xQ/YQ/eGequjId3xqu/XCXrlUbwkWhPAwe
	g2WVpa2WNKenGkADkb7YXQFxng0+g2uMjnCd+pxko8bml9Ammw4zy6Pdpf7aLfSSej2PFporvZ7
	+c26wLMR3cfPLjWe24htT5FsnKP9nZ800FL/J8kHvM4/wYaodL5Na9vZC1wVUKtX729MRQOlFRI
	3Ye5Db2XBTatNLTL8NgFlNdNxr073r1AEdiR8BuFiWvrujhRVwEOAXdD+P79khIDoYA==
X-Received: by 2002:a05:600c:4ec7:b0:490:b8ee:d6a5 with SMTP id 5b1f17b1804b1-490c2589927mr315117345e9.6.1780995575645;
        Tue, 09 Jun 2026 01:59:35 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec7:b0:490:b8ee:d6a5 with SMTP id 5b1f17b1804b1-490c2589927mr315116965e9.6.1780995575267;
        Tue, 09 Jun 2026 01:59:35 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d6c65sm455288105e9.12.2026.06.09.01.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 01:59:34 -0700 (PDT)
Message-ID: <4e2fb478-1d37-47b7-9bb9-3553d5ca2fee@redhat.com>
Date: Tue, 9 Jun 2026 10:59:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dt-bindings: net: dsa: Convert lan9303.txt to yaml
 format
To: Frank.Li@oss.nxp.com, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Frank Li <Frank.Li@nxp.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Cc: imx@lists.linux.dev
References: <20260603210929.3099363-1-Frank.Li@oss.nxp.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260603210929.3099363-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/26 11:09 PM, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Convert lan9303.txt to yaml format to fix below CHECK_DTBS warnings:
> arch/arm/boot/dts/nxp/imx/imx53-kp-hsc.dtb: /soc/bus@50000000/i2c@53fec000/switch@a: failed to match any schema with compatible: ['smsc,lan9303-i2c']
> 
> Additional changes:
>   - rename switch-phy to switch in example.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Does not apply to net-next cleanly anymore. Please rebase and resend.
While at it, please additionally add the target tree in the subj prefix.

Thanks,

Paolo

