Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F1E13D503
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785673604; cv=none; b=KTos9HI9GCZxi4rq96YD2dapcVwPFUcGtQfuyygL+d/ZqVZJmrIuSaAp3YCpeSBB8C73yW/N13btxV3+H5V0opkSzh58KcSXLNMQIiz8bQisgEntm5xCpQvSgeYmXC0cJ+g5dFL3XW8ewJWT8REXOKuhRl4sHIk8vCmk1i3ZcBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785673604; c=relaxed/simple;
	bh=GzoXTgtycPrr14JRRohK+X5LqcrEe+6y3sxJXbrD4uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ca3+L6qpAmoDdiFbgWxOTqNUnCySXFKVBBS/3f+QhKsi/38/FIPVk4DZ+SWX5Tp+H9E4ETb7Yw+EbDVL5GEwXo60dsIxJmZMkuq1hntY8n3+vCYHDLyX8hWkMXkeYPXl4vW/QTelM84n1j5AE+EZdSJoqse6kpZCO5/N83Ih96E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pa24+HNk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pa24+HNk"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cfff5f88dbso27846615ad.3
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785673603; x=1786278403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JEYzfjesqzY4vv80ibO0+ZIF242Ka1A8GW29K+EWrpA=;
        b=pa24+HNkVZffOle3mJN2Y3PwJF1GV+8EQkVp7GpKxVtCMYO3w1OHlJy/GcxtFtGbFY
         BP/BC2Hk6I+Bf4QoOVA+EfnWhahZ5gcRRdvsSKOqqdskPLNm7czeH9gKbhrx416eg4T9
         7JN2D9OlwbPeGtZaJdSVd1uUV18rakD9HUXPNZjsIIPDsqNs1efG2FaYldHAR/XXHiPY
         +TMzSzxNMnFoavjHKBAtcfnWzDP3QN6clreif05ayieaSbNm7rRhArnwEadOUVkT65u9
         Is2LzlAlwBmnuWH9MOFHcSQX7zOjLCgNeuDzJIbEkgUUBAqfNbS+boixAvh3PANSXuvt
         Mr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785673603; x=1786278403;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEYzfjesqzY4vv80ibO0+ZIF242Ka1A8GW29K+EWrpA=;
        b=cHUHVBTPs4WFV+0TRCLRRXuwG92KKy3RyyRXIUAoaQmm0SXsxWFQz6KGUj22EDM5Us
         VpYp3r9rL+RUjSwl26tIQMUHkPv7B1zomSXWPBoPjykRlfNHHqg4sPVYhi78P3bOjtjw
         RsGhtaFM+lPnT6OoQ6fICqEUzj3wfq8FhKjatakmX+xzaMtGjcxS+eKphDMg5Y0t39cl
         l6Df2O7E00pkbAosmetZ2PDWVtzwLLzwh9lnxocFUy+CJruE5kmca38erb4MvZh/4MmK
         1gh+dqwDWsbemT+pxUH2chU3oFe/HXDd/s5kcgDKvKQVCdfj35KaDLuTDoC081ZsbkTo
         Vo7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rry/xSPA0pIDgX10dixeExtxUNfU6hTZcT42bfrW8dtCxqjpC7hl3Z+kxo+WqwVnvXK3YqYXMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfZVqQmat2Nb0dM7PQ5P9zG0QZvyQHEGFAsu9ZJ13trX0E2qr
	ldIhOQjFI5PkchIyxM5q33VjsoxWV9GEM9WuaQo/mrFYVuu0zeKsvgdP
X-Gm-Gg: AR+sD11Gh4uDQNjrZAesfabkdy+NQq+kCTROTCJxrew0dcKOqEEEXzJDzKyQTdOGjTL
	HJ+ce7+V4rppWdCIaIKUjIEcYqoEik5WG4/Q2tPGv9jPtXXl6RK3X5c/8HsoJHNwhOeYrcIRDgV
	E3Gu65cp39AwtxsdQkB7UsuGFsoBCdAdh/rqHnPh4bx4iHimH1RxNaJwBJenxxvraqBHfJAassW
	SzuPZg8ZBl62hIL/XaeVEeKbN78EAQ8bCSDU62pykHydbGSF1bJXjfN0NmgZt1hBLykOVbJfEaH
	Q2CFj89+P/oHvFuWYv9ne4CsgK7tkoRnvZUjRUyYihUFHPUXF/g9g46szdEw5AJrog3jr9wNabW
	qFnxshHrbRmJ2AwIEFJoeiCb4EajX29LaWtJphAP0cTCv63Wzfv46JYy4K6wCCDvZhlMA5R2Ojs
	R+9TEqiRdtbPMhMSnMs2WgpvcId8rXY3Wu5YSGWh8RGdQ4yxRSjXAEsn+JlV6rG9J4wx/BoyM09
	AcaGlwt/HsUmwgDwmoEAzMWOpDCazocrCoEQF4ZUhgu5NgJqgHOcmjWakPGmF5vCUmxCMeHG64A
	lay4BIk5QbPhayzcgJ+K
X-Received: by 2002:a17:903:124e:b0:2cc:f5b8:4c2e with SMTP id d9443c01a7336-2d0521cd890mr64490745ad.9.1785673602642;
        Sun, 02 Aug 2026 05:26:42 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:b123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b15d26esm25625075ad.76.2026.08.02.05.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 05:26:41 -0700 (PDT)
Message-ID: <96c485cb-d169-420e-96f2-108ec6ba7081@gmail.com>
Date: Sun, 2 Aug 2026 13:26:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 2/3] net: devmem: return EMSGSIZE on type mismatch
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
 Bobby Eshleman <bobbyeshleman@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Will Deacon <will@kernel.org>,
 Antonio Quartulli <antonio@openvpn.net>, Ralf Lici <ralf@mandelbit.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260801125308.1342897-1-almasrymina@google.com>
 <20260801125308.1342897-2-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260801125308.1342897-2-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/26 13:52, Mina Almasry wrote:
> When a devmem payload mixes with a standard page payload, return
> -EMSGSIZE instead of -EFAULT. This enables tcp_sendmsg to seamlessly
> fall back to creating a new segment instead of failing the socket send.
> 
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov

