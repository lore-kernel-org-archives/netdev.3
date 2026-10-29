Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793307960;
	b=Noq1dg/yp+73ana2IwLjXIuKLgzkck/FvLExQZwqYH6WL65Bk/XgCVv7b+Qfro7t5fYd
	 h0K5vpOncyJuI/f6ILY4Da3dt4V7PEywrGNPDiX89HoXuifIZaJC3RxwxwkA53Sqxnrma
	 jeITNpa2w6cRr8EhgvVacm93t7k//CJk38el3ka+fzCOUkYfOWyaRsT/2iSDgsRZbc3mT
	 x1ls2rf3kzxu5Cf0XvSxbQwzMqI6XbApMJznGOaxcvCzCtEY09BKwdqejr++DFnGPJDry
	 HKZXL112bA1DqdRAAJZsLzbNm0Oe9t9OScq9irTX3VWN3Fz+LGebh1RdRy+HqJtCX0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=QzZgEsssnoB+AuxdvMsdWQqxuT55/Gc/aLq/H/rR214=;
	b=OEoykUIcrG/zZtqqdtFPLC6UHhfLEF3vkMZbiISsZMgdbnO3Mo/OvWzrcFKIopZ796Rb
	 SrBfzLovFDVI5kUiTdYpKBWkUaLvOiVHdZYsI+M36cS05KUceR/Ub4TKHp+FSqWh1eBAo
	 HIFgh9RTFHIjCL5YJLvw+lgg2NCfu0vOmjHlb8DRdqZOFYpmASj+hwh9uCwCjHtShfgkW
	 MZ/TAg+XuCheYEE4UMurmZX86I7sy4I/3yeRvAMnry94YlhLFBOxZS08HUtgjzMNZyGjN
	 /Fm7T2UBxGq0WhkOoWUE2gcMS0oMVZsUPY6FsIT0L0GclWdOqFWo8kq/PKi4TGehmiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ieee.org;
	spf=pass smtp.mailfrom=ieee.org;
	dkim=pass header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=Zi7cShPe;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E3B606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E3B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ieee.org header.i=@ieee.org header.a=rsa-sha256 header.s=google header.b=Zi7cShPe
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6e560e00a86so7014eaf.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1793307959; x=1793912759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QzZgEsssnoB+AuxdvMsdWQqxuT55/Gc/aLq/H/rR214=;
        b=Zi7cShPewJupg0DQM/embdHavmZ4kuaSu+2PkEY2z+RdlRD5fdmPsmi6zu6QM+xvfr
         x1UieGDMws3XfrLND5nBfrpDVoDRbkGvcRpqUgbdM4ZLZvCZVbGLMXY0CFd2jFdINA6i
         AhjR39SWqMrSFYU9nY7SZaH97+PLD9ZBHE5hM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793307959; x=1793912759;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QzZgEsssnoB+AuxdvMsdWQqxuT55/Gc/aLq/H/rR214=;
        b=F8nldF8A4AfnAqReSwAZORUWWPMh1qW9cQvIrQvrP14LBa9XJsq1gkfEGWVFsMTM91
         s74hRilswGDmyUDXBiJNLaWZrjX+ix31gmhn7WO7VDlDMNY1qcv1jA5bEb4bSEj6bJaz
         UN39l+/i6K0+K0BzJy4AWPNMw9XcNr2iWRe4uS1uM7NyWSBWt+RE8KrwXaKsn4uxWuhx
         uAOlHRBgilmiUhGDqNwwi8Xe2/83hF9UWwcVNht7c5Z+Jr+tX953Qn7nWrHiRhTPXKhT
         4AmqUZgSKmQHwb6q8LTvSDGJFP9Yyryj8rL6Lw3gOKjnU/NJA3chWZdhWB68wXzdKC5k
         6yVg==
X-Forwarded-Encrypted: i=1; AKwUvBxFqwRefsko2hivgl/BEtlovpXHgRi0Wm2g+gLuzDygniGjDb71h0JjgthZZs1N2Kr2U1dZyYU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrI9sQKr1Tdv++0AjWvnC5HASqTNtrsWHLglMB1Sw3yIvL2TL5
	8KZ3RHGddxqaV0EZCSHVqPtPAeSbmoXsWQ7XWQM1BNSGX2RPiGUHeUMeultv2riULQ==
X-Gm-Gg: AYBFou15zvcoBooKLWZgSbHaWMfMrygJ8amhP4OzxwdXrKA/elVC/1YdCYQgzqGtDkU
	8C10+HxfLosXSYMjADyiOu1TAeo7ef3XXKWdfNzLMij39z2tOgp5FIPifyjMP8OagXuoN1gPC/L
	YffTNajNJU+n/oGgcuXD3e+gtLU6ADeQi3lW0P7LyXqXvN/f72mFkaZsGmLtaAc8y2YO7IRKCNT
	1ndkWPrpRK66xwV7QLbqgbhroQbDcgoTqKfik2DzIls3ZU3iER5+g4tc/Os99ZaCLiRU2TponEi
	OmncJ9l0eMOdrihN1sIPYsrWugbXb7JpGO4rLsuUb8reI2s7ea6UM79DPZdgEiItSCmozH7jlLQ
	R0/9uJrPk6dmkHf5qHpl782ACCjyZP7M/vJOz6px6pJXrTMgv9xi3kQ5f28Q94Sf1zUinCrf8Qu
	bChdCYQ0FGk2J3KOaHT7q5ogVVYIuDmucqPkA+7N4VBSB0mSdVHJvoQHsQfLLV+5UcwCzaGHWEr
	D7wx/rAtsogX8mVPNhEza84l04LmlM+6y903mLafr4+oAYY3lvaUcFjGU9z+ZN7VSOtvycLCWMU
	vgVHC4W1xnbg23fG0Tu1ZuJI
X-Received: by 2002:a05:6820:1505:b0:70b:a287:72b5 with SMTP id 006d021491bc7-714f23fc465mr372599eaf.20.1793307958727;
        Thu, 29 Oct 2026 14:05:58 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-4a9049af7d1sm442982fac.12.2026.10.29.14.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:05:57 -0700 (PDT)
Message-ID: <f9fdfc77-8387-47fe-ab0f-3d5d9c542185@ieee.org>
Date: Thu, 29 Oct 2026 16:05:56 -0500
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ipa: Drop unused qmi_elem_info arrays
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20261029111059.85020-2-krzysztof.kozlowski@oss.qualcomm.com>
 <97e9474a-f491-4447-b128-e4a5687056ab@ieee.org>
 <a9910bba-5a4d-4eae-905f-4e576b03e112@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <a9910bba-5a4d-4eae-905f-4e576b03e112@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/26 2:17 PM, Krzysztof Kozlowski wrote:
>>
>> Did you find these by inspection?
> I was going once through all these QMI arrays through multiple drivers.

What I'd really like to do is define these things in "source
form" and have the C files containing structures like this
one be generated.  I'm pretty sure Bjorn has a tool that
does this (maybe he doesn't want to use it though).

Anyway, thanks Krzysztof.
					-Alex
