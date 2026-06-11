Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FF937B400
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169862; cv=none; b=BmkspNLEHlY088atApXMZRmt+zQuw+/+k2lecKQ0RPLs3IedzsF2Fbmzh/dQfZTSe1AljBX8iByICF8SfVK0jkmd7BiUVt99ur/hCcmsgQRAgilf34eyRdlBuWhl4Yo1bfEQp3D5wtXqrQezTJ/oAFSqoWySbdqGoEd75xhdvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169862; c=relaxed/simple;
	bh=TePx6sAT1Rm99eGMWoZiia/B6i/vV66CziWOWxaFkkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdCw9a5BVymFrPsXNAGDzR9slQx/zOcYBPwObzEIZB5qHDBDJur8RbbKL+1mWyMrbbk98iX9UJ563F9rvOpXKOTpXtJ+z6qITYY2MNGFwV7i0zYVXltGHFMYnU3ysh6rDusQif1dEKK3C+3zZQkSvhM7RvCYMcb4PRADhw9UZ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLkMayuJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTd2jaqu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLkMayuJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTd2jaqu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781169859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+2xaEKiZA3gEu8WbXqmvB4iNhVU2+4QCQa/jHjj52U=;
	b=cLkMayuJk3uLbZ4+LYQdKPEey1IoirQ6Vp4AVRTGgKRP9TPHVYOvTpT7WcVRf1FChg8DS8
	qxSrEblPHcRSv+BhUZl237nKJ8apOaIIcGZHBB78Ev/d6Z6CI7RpCfBBpl6cIs5eUnqK/L
	/2XR7tk19wzeTOT6ALzvQlgXHsk+DCo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-LB8xcY2OMbKvXN9mG2O5SA-1; Thu, 11 Jun 2026 05:24:18 -0400
X-MC-Unique: LB8xcY2OMbKvXN9mG2O5SA-1
X-Mimecast-MFC-AGG-ID: LB8xcY2OMbKvXN9mG2O5SA_1781169857
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490bfd70b0fso77740585e9.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 02:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781169857; x=1781774657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6+2xaEKiZA3gEu8WbXqmvB4iNhVU2+4QCQa/jHjj52U=;
        b=TTd2jaquegp5yUv5/5wXtaycwBPeQ3CG38Od1rELHvlX3PhuKG8AYvbLwwqDkGqFPn
         sADSh6uTQ1xRPA+EqodNhMKXBku6AtHOTAO41ZYbDAdGyJf6EmBEGM9PceHxekbwYUs6
         EHRWB0ya1toGJVqvqDU3h3eiewwzQ5owB8q8UxWIEH5oUotfFZMSFeHoz9DUoShWRxBY
         KYBUBTJxle/QVXkqUuAPiY5D7KqByJJbBdjU2CdkDasC/0mBc9mMTWDuBHO8OQ3tFlqu
         DROjqoBue6Bc6gObWGysFw4hSUmP0J95De1YDZIF9d4U+ynmc+zBoCArizKN21iOLAjT
         cXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781169857; x=1781774657;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+2xaEKiZA3gEu8WbXqmvB4iNhVU2+4QCQa/jHjj52U=;
        b=hsrKD6p0Eb0NldN1tFsDlJslHTg8G7q+CnLLA8oHkmdZ+arG3iQMl0R+iiRC8/BxqA
         A6qSv68wc+AjvmVObrkvSElu7PNlysAMoJ2XdazHvUkaLXHVwAU5EeXqjJDhVio3ik0w
         6deeftn2UXf8zzld20yTuSLAgvsas8LPFpJmLtqKQBQ0Qqf9fxTz9PnPYfadhvgsqS6t
         Vp0IqfKhvnAYPhQPvukPeHZ4PE5MNUfWABP3X6vXZ4+HDiP6inkoCZrFefLTSrLwolUE
         CLtggKiTP1drVwwO0wyhbRmKnXW1EfKBs2FKPg2j6jjOuvD9nNLTZayhuXFel78O70Wg
         YRRQ==
X-Gm-Message-State: AOJu0YyZi0Xsdwslv62A+sdVcLJm0S482xT8mjGpiqvCYlFxUMTboyhh
	M8Rajb+mYRSkusoTuK0TJXNhNxxeR89oaudSL+irbNV+9aNx4o1scPzCccdMN+gVjBjezVmUI9A
	oMWbMD0WDdIRvJrlx1CuNhLXk577GAu9cD/1qQVlRCSBMNQKkPRLSK6uvTw==
X-Gm-Gg: Acq92OHe80B0BXqonpqY3tt+RTH8U4IFJHVHDk1nN/rAnBceMX83tOU+ATHcgi4L/ls
	XOOQImYlOfFepBRCnIJUfxITITCDjwcsFsqsf7YD6p629A2gcwFptbjll58wCy6ba/g8npxqk4b
	aZrZh8s05uBD/bAfxCppubyoxdXuUcKEW0MetZ5IgMTfsbTTZtMbc9nP1lIDIsEF0hg77kIARmy
	ZFp8cM9DJ68yc0p47MPI6pxxHD2TLvxjEDqEfcLBik1xhTgsXQgGtCd2bY6Kt9rF17sbNMSZwof
	05nqzQKLGIpLIj3sDgv8hdHxvROsynO+n5jy6pKfrcUAg120+quO3AMH0xWLwM71g9T2AIk5m+Z
	pvX24ed9gJvN1kXMdkI8tYYMwE2X/I+foEc4bLM/ERcchRD4tZQ6DB1ficBkCsO0/2w==
X-Received: by 2002:a05:600c:4e0c:b0:490:bb45:79ee with SMTP id 5b1f17b1804b1-490e5379dbbmr28531945e9.0.1781169856843;
        Thu, 11 Jun 2026 02:24:16 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0c:b0:490:bb45:79ee with SMTP id 5b1f17b1804b1-490e5379dbbmr28531295e9.0.1781169856414;
        Thu, 11 Jun 2026 02:24:16 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d0475asm78210765e9.12.2026.06.11.02.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 02:24:15 -0700 (PDT)
Message-ID: <03073247-c4c9-4e31-b8d0-2f03c9bbaefb@redhat.com>
Date: Thu, 11 Jun 2026 11:24:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] net: phy: at803x: add RX and TX clock management
 for IPQ5018 PHY
To: george.moussalem@outlook.com, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org
References: <20260605-ipq5018-gephy-clocks-v3-0-f232d9ca0966@outlook.com>
 <20260605-ipq5018-gephy-clocks-v3-4-f232d9ca0966@outlook.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260605-ipq5018-gephy-clocks-v3-4-f232d9ca0966@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/26 2:41 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Acquire and manage the RX and TX clocks for the IPQ5018 PHY.
> These clocks are required for the PHY's datapath to function correctly.
> Gate the clocks upon link state changes for improved power management.
> 
> Fixes: d46502279a11 ("net: phy: qcom: at803x: Add Qualcomm IPQ5018 Internal PHY support")
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>

I read the above as this device never worked. If so I think this should
probably target the net-next tree with no fixes tag (basically it
enables new H/W).

/P

