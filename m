Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794610551;
	b=tmVbOdeUSnLJYSdNR1cxQnWXNfXtck1guyluu/co6+GseZkzoSuH45Z0AOSpmmcvp01B
	 ltPqiY/zj4yS9izxUKftHx3ZjdwMpkn9re9QPTsjnQA/zjEp+OY/M4J6Rp6WXHO7RqmcA
	 Y7SVL8vH1JKgEDLObGJ05BvV8Ebq605fzdgndOHLrKGfoOqQzwIvJMC1dADHFnA0QRHSX
	 nlCiRVJ19OhYy5SyMtvBvqwDX1pgg08S1MepLuxT5SoDkt9a5O+sMKYxMrJcO0EJhtfvJ
	 zeR9SmMulFAV6rIvm2TIADXPTOpgQvHVbe8RZQ+hoZtQloyMbRY1dSh4zjvh/4+fHXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794610551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ubHIV78BWdtikOGMl2tBl1TNThY7XLd4PDLG1WQAfwA=;
	b=T7HuW94UBTaExNggh+1s1iZoODKHd8a3IDIHbWH5htK3gKUCPU50bGK61eWJMqDuozWm
	 oT9HsX3+GdZnsXWA3zPIxwoaVnYZnKn4ERDcZhnbv8fkr1Q6YP1KvXo+QmKZbWAWppkZx
	 444Q5T8EhbAxt9eFPpevVH49ZJbgIw9FhGkudPIoL+IqmqO68e2CT7WbesG7zPaGYuSrv
	 kZjsZejX2I5Die3NSmLMcyccZRqRK8Znc4vsstoA+cBLI1qtbGitT4pj5fyL7xzlkA5fA
	 U5PysHZMBKGGt5q5reoFv3mLaEicAPR6mfrbH7IFXpjAh4IXjZyYy6TqAYOKsPS/+IQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T8hARIt+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A3F606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 22:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58A3F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T8hARIt+
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-53c4858eb76so645832b6e.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:55:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794610550; cv=none;
        d=google.com; s=arc-20260327;
        b=eWu0drnqok2ugpXcVkqXoW2qj02SPhEExU45lTEshEvSGmoR01H7IpC0vZHwrQOOcN
         AlophRlb3pM04w7BaoAAYsCK84CyKfzp+vsTDTYlywO3FY3knsBsCSyoXz/biEu9cfZr
         O9toARfYBehVO7N6bXY8YXPGOPnrGwN+nSLA8LO8exLPn6BJc3v1quTPzczZXPRRPFwE
         AWMYT40iJVJDmx5BrGJn0EZlVb+TthDFDfKeqXfdQ8Bd0JmlK4CmDhgMmv81do/H48u8
         ajGJBjFm4Nsx6dM7i1JbF3hYfht/jgzrjZAJ2mjk7ceFyq9+nvYDi6jrLKLojNfazud6
         URvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ubHIV78BWdtikOGMl2tBl1TNThY7XLd4PDLG1WQAfwA=;
        fh=iicKSmV4UWpkSbXjUgnLpPwWmt6paZQPXU2x9FkZ8G8=;
        b=ARcX+pMzGAi9n94TvJY1IKZwaDZyrXoxgIbpCMH4fd06GORcjxtGLCftzq47nuKDHW
         s19v98IQ738yx1zuEUKD69NmiaPeqobgTROZYIYTUEU52+LBIG4h2HZ/lWpiEvNpYUc7
         ToY3DoDyLZ2QfW2B2a7k6OhFvF56AU+RIwjwA918bmPFxIrz6WqfEEEt/4ukzVsna9Vq
         lKz4G7uiPZXdryBv3guFKsRz1Tza/S3OoBusZ1ChCP3zMF8iM5QOvv1pgiu31t4rWo39
         6jTp8upDyOOjrFaUeHP7JwvLTcb8+YvAKxUdih8HVkTp4pb9gIexpaP/A/hMJ/vMX9W8
         Z6jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794610550; x=1795215350; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ubHIV78BWdtikOGMl2tBl1TNThY7XLd4PDLG1WQAfwA=;
        b=T8hARIt+NW/FmW4/v/sit/FuJmA+iWrY0G9FAUkVCaY5ReC4DhU1n+4d5HNCZx/sqN
         p2LpU5HqGTycZUoSsC7EgjFQDuek2CryyOAC9wy7u9eFvv9NnRZz7ppKcqKwwKhZg7A5
         FneRPeENdI/K5C7y69Uh9+xIdnlp7vqaL02jEGjbC2J0urD0pY22a+Crie9SNJi7ytQW
         6bzWxT3AVzJ07bR5nfk7c6kuwFuA1mJX06yXTwaJhJaRyD+8uktkpC2Z0Czw7x/a5Rp1
         bD0O8L2pdnp1fayOogb+nYkGkYhsrWtIoa9hAX48la8jEqyot5Qrd962dcxk8voN4ysu
         Al2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794610550; x=1795215350;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ubHIV78BWdtikOGMl2tBl1TNThY7XLd4PDLG1WQAfwA=;
        b=fgNmLc2P9d6dPLqrzfvlHG4SfTjnS17z/RNLSAY7lBQ938FlEziP7b4R1J8vGK8TJu
         R4ZhEORlT7Ahl7BqaYOL7G/Jam2RJYLum2s2h4ML62LX9/xT3+uK+10xxUnxTm691fpF
         iXlk8aHLf6B5K/UboDs6+yH4uHx5elNRyJoqDjLI7B5faX+ThEyD9Y6dLs6c/CFYOw6Q
         THfigluxC6WmaHh5Yp4S9rNN/zbX37sDlnUul4co+Ttg0JDHk8zt6/pPeKO3tbq1QsH2
         Oyqjd7TBw7Wy1lvWXDRWaXZr6Pi9e/DabVK1oEXcIhywja0X87SBZisEMMLpf1P1ggXk
         Yf8w==
X-Forwarded-Encrypted: i=1; AL+hErE7+Mv1LGUqZoGCGOuUmwXJlcI9k6zb1D0bZtv3D9OBI6R6rCozAENx7trCpUSJ0UNs7Zw4Qrs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xF4/xtJkQEdQZ6bcKWvWlgjTZa5hrDE+aPuILVAvMLgoELhqw
	wGSsPLt0HvJjGEpMOvs+39BQ5Ea8QQM1Pti/GKf0aC5OWv5C3MZohmtUBatSkvb/iTZkc//zX0W
	GWaiDr38LiKONa+o2G3uysckz1AOMIVA=
X-Gm-Gg: AYBFou2N195gXuEPRS3jkDTQ42TKh7zWR4WjTOCfvssz+o1ZB3k0PpM+gZTKLImt5Vr
	wxF/AMX0p5+7Bqr4iGajm+SWXovl98lPmSPrk5PNeY/YGk/b5JuVygIDXRBSpQELz/kklZDN/7P
	VxpRaJ4lzRELUMRSEG9NYbyCv/c8jFvIGlgWrl2OvbnoFaaThEXCE4MQq8lmjO/GE1mX+8XTOnL
	OvDza9ajx0KgqM1dIzGM0BBaJ+gppkJn0TPUe9I+RLarqUwWdIwwM4R8ykz+PyiwR7i8rD5dTWT
	e/s1IHekp+IQ2y1ROFAIhDDytFJhyCw0Mc5kW3Ery0974TTb8l/Tb74tHyldtPbpgEY4giHLGrX
	ykU+c7bmC0NeX8hv2UWa1hEsmA91vLBVqUC9bmVWiG8x+83+udBTtD0No/NCiyyOoFIPvk3kYAV
	TTM5QwBbp/d9QFjDhliS8wpkDu3xWrHeTfYRx5fUY1oka1nH5+mOpV
X-Received: by 2002:a05:6808:244e:b0:55b:f88d:919f with SMTP id
 5614622812f47-56e65317dbamr3590625b6e.53.1794610550183; Fri, 13 Nov 2026
 14:55:50 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106124639.12584-1-dennylin0707@gmail.com>
 <20261112075624.23c04230@kernel.org> <706b09ea-49cc-4801-a24b-b22d2ea7d257@lunn.ch>
 <bc45c1e8-6904-47f7-9c96-512e024c9d71@gmail.com> <20261112113550.016cdab3@kernel.org>
In-Reply-To: <20261112113550.016cdab3@kernel.org>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Fri, 13 Nov 2026 14:55:38 -0800
X-Gm-Features: AclHuK9f-4XUFh-cJPJlk-I0MGZ48DWAeQPY9iTICab41F9Jkn5YSmRgl-29Kew
Message-ID: <CAGEkeHdz3GPv8sd0SLD7zbRBPFfzMrWBSWG7uxho8uOUJAL4fA@mail.gmail.com>
Subject: Re: [PATCH net] vlan: prevent cross-netns MII register writes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, n05ec@lzu.edu.cn, 
	ylong030@ucr.edu, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 12, 2026 at 11:35 AM Jakub Kicinski <kuba@kernel.org> wrote:
> Maybe we can just delete it in -next and see if anyone complains?

Will do, I'll send a patch for net-next.

Andrew, vlan is the only one doing this.

Hungyu
