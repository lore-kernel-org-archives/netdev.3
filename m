Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C258C28135D
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 05:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770874093; cv=none; b=BwyXMceQXEULRjErTono5CVjGS44PDV3hZG67uMatiDqP4TJHuRfJNqYYBdybkHbRzsOioXLQRCdz/WbRbKFdIjD+R7zOCtdd9RJoqqFvBm8IUBqCghzxAGT2TWptX37PJSC3ex9GLUg3VUiSfogZe02nhECUPKZzMa+E2gz/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770874093; c=relaxed/simple;
	bh=KAvHmXBR6Z1t7fykOb+Q8OlteilYCII3PJTMYzVRo6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrmaoDx4t8Z6reilTe996jUtj/sca2ylwwSLqHf4w9JoBOplhh7RN0dvWzzWCHD/HGKjzothTeDkWXOswo4x8aYHNN5VNl+qdGc8kvEJfb31Rr7deCVRog5HsG3/kD251FQSrDkWAgbqq+aA5gO88a0+vT5Gb62kIdK/wZKbjzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rt7pvJ8N; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt7pvJ8N"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8230c2d3128so1313623b3a.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 21:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770874092; x=1771478892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KAvHmXBR6Z1t7fykOb+Q8OlteilYCII3PJTMYzVRo6g=;
        b=Rt7pvJ8Na0KNqUohoPTVe2r0OCXJj13dl+0ZEtTWoGNPUruLSQLRs+MhCzXWmWUWMr
         MPz/dYgUOovub+ltFAXqkZHIsqkkPpJjcCgHrKIB6vGkgcIve3yowA73edAgWt0+jmol
         cbCi1UErdVufvoBLRBGTqI6qS2Mw1u/CwsviuPnV7FwoXIMEm/WWL1Q4LFcM04yPLZIn
         yFBwg6u9w46FMUKMli5z5Y2jwhvd3TMOuNSA+MjePXfR3JWd+iCO3jVwdhmqaMmF2Gy2
         HTjXak0b05lYYKu3z9CTMP3JARAnNQIVnc+wxsQj0B7RsEoP2Nyd3LNgqjM2Lar0B6iO
         UUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770874092; x=1771478892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAvHmXBR6Z1t7fykOb+Q8OlteilYCII3PJTMYzVRo6g=;
        b=s52vZHuPHa/a0bkgCt0yMn7yUv4GgnHHrFTE12Ivn+rjmMBGjSHqS2RGbZyRRxmzs4
         mGlsseRTW6WROppjc/6LhXO7erukQwVbA3WoC3lN7aOtg83zGDfKHAhR1+8AXGA7y/3y
         glqANaeoFA+cDIkbVDCYKlmPwZk7mNJSJkQPRu+pFPj54zfxZRXI1fKN1ohTxQr3Qi4+
         1KXCoOP9ULFlycudhCAV0sntRPXvqhbfXSfTLgOTL5x1VJ9ZRrbJqR9tVp95j4ZKQlN5
         riwHPpe3dbKezPUGybk86KK4gaqst4yYOaHO6WFWf5ul9lWqRFG1cNzMbYXuA3q9RUZE
         hvhA==
X-Forwarded-Encrypted: i=1; AJvYcCXUoKogLGtxME4Wj/VWDhy/ri9A7JBHhIVzOO27NCHlnN+esBMsaY1SvvfQPbDduNVvvmxbTMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYYYgSoXRM7HPPhRbuy41czDVYch/snBP0Kp1kjY4MCVzX1v2e
	rUwii+HCasgPU0o4YYhhFCY/34kUYbH3F4ca19+t5zV38MEZ3rFWsEdJ
X-Gm-Gg: AZuq6aL5B6r75ADylUccUBNpnDADeKyWe/y3bzaFLsFgjunrix9cLyhjd+HemM4+6bt
	ifZZGm7MbDd3pLBTpItySUIJ/T2xbCaEh9wngbTvdaFYfE8zV+BvXDg87z3WJiGJtfV02r9+cIe
	mNg2eWpwOtAdJf8dfEKApYz+85O32RDDRzK6WfoQY76sQLc+POz4WS08+wm+4+I7+g+Tt60sk0g
	/DyvSezFWdgG+zL9EzF+JLzG+pE2zBoi6PseUITdOBOnPHjHtIH0qGc7O1kApK31r55OiOAG+LM
	3BfkLWRh7BiT4u6Dm2k9LvKJwRgj304j52oRFwk3fXRjywe+D5cT3n7JwPCzMqiEQXL4ulkX5YB
	dLC01dKCaGgaWBnIfg4Yj+pwP/S6VhRXqp7iK6rjwR16Ug+f3SVpVx+wmgTUgHoRt1HlBTOI5bI
	WQVRymq/hBpwruxMGPA2ASgojUSzjSDucMgpFgfK7CTaHltVP2l3PVnHcG5gzHK/P2FYZHKj++N
	3iA
X-Received: by 2002:a05:6a00:92a6:b0:824:4a22:ec02 with SMTP id d2e1a72fcca58-824b3042b8bmr1089776b3a.42.1770874091996;
        Wed, 11 Feb 2026 21:28:11 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e368d0asm4119668b3a.11.2026.02.11.21.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 21:28:11 -0800 (PST)
Message-ID: <532078ce-f02e-424f-8382-2b52438a657a@gmail.com>
Date: Thu, 12 Feb 2026 13:28:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com,
 Andrew Lunn <andrew@lunn.ch>
References: <20260210052226.3005666-1-a0987203069@gmail.com>
 <20260210052226.3005666-4-a0987203069@gmail.com>
 <aYsurPBMnzWDZCco@shell.armlinux.org.uk>
 <747b9ab4-6711-426d-95a5-4ce6c8732edd@gmail.com>
 <aYxYRZZkVFz2jHaF@shell.armlinux.org.uk>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <aYxYRZZkVFz2jHaF@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/11/2026 6:21 PM, Russell King (Oracle) wrote:
> On Wed, Feb 11, 2026 at 05:52:21PM +0800, Joey Lu wrote:
>>> Is this register preserved over suspend/resume ?
>> It is not preserved by the GMAC suspend/resume flow and therefore needs to
>> be treated as a system register rather than a GMAC local context.
> That is another reason to use .set_phy_intf_sel as that will be called
> just before GMAC soft-reset in the .ndo_open() and resume paths.
Got it! Thank you for clarifying.
