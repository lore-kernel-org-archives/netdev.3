Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7433F597
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935213; cv=none; b=m65nWa1iS5JaSg4/4gilEEusspXlNsF+XQNxcQCNg43mV1q8SPsRwWgUQv1yk/AToXR/jtWx54IpSRM5YXILgjS11OTvLZHNEXr54toRgF+vDhGNCRL3fY73iBzX/8HkqimGIB6Jbi12QijuiyyeA/10hOFzMPV5s1pTfLeJVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935213; c=relaxed/simple;
	bh=D/PE8ZY8RnPiyx8T/paabudjZBF3kmlEjdevPzOolD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3TC5tIbuRAHxb6sQcndLqbSj52MxwgseGFZ7jBl9jJWeidELvcu5aUGj21lv6hAsVOKM6sP+69tM3deGFFA9fgwi+X5Wr4F0PfQz12h442kYINBGew/2rLr4aT1Y/TQDGabNGM/PmcN7+WciPw2u+Nv45JMGGPLjQ+Fdv0BRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ArmhzyIr; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ArmhzyIr"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef5b33e73so281733f8f.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 09:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1780935211; x=1781540011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TLJe5H6BQpnEaguXomMfKh3h+/7fa8zGeeZ97E3S4cs=;
        b=ArmhzyIrAJbECLqtDo+ov1/eLDK4VOSARj5vW7caNH6HNlpAMtTU1YJmiLlyjd55sG
         2sc40+9/grvXJz04jaV3ZIDSotq6Lyi2agFLZDscqx1WaVNU42pTcKGfCIUVqSpXFL0a
         tyIzx1tHpD2wS2O6i7umfyo7YHwUHpg5Zrtmh5QTw7bnBJJvvDXiC3HfG1GHLP5vRSLr
         a1ENuPSkP7f+9Crxub+RrxbOyoNgnmKcwCKFs2DYTUc3BzDfuAFkeyzqH+a1o2dMuyvF
         KO7D3/3GM1f0yFUwbLr1P/nQ3cMCN9ECpoBFA6VrPJC042cXWtlHH8dUEx3LxrqIQisG
         sunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935211; x=1781540011;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLJe5H6BQpnEaguXomMfKh3h+/7fa8zGeeZ97E3S4cs=;
        b=XqO1Na/uOiBBlhVstj14HQ91cF+wEN4FMT2a5YFCbYIld0N/jRMXoMvsvUmF0aU8Ix
         SNgVD/xLWFd7LzYUDXhWdUyaks4AWs4llL2P5I8AFfWR+zP3eVq22A24URL8vni554w7
         Wv10P6oUatiFbYv5+amDm8ZAFH/98RLU6/2B+FMrlb7I770j4Wh1593S0Skx5gH/g9tH
         qmmnhLBDGH1dQhOuT+yC1ChR1k/ww4sFGgv6roGt6Vr0ExKq4y9h8EpupCjexhPQdAGr
         8iG+W1Ojd7goROjX4pOdDYuWctpjdhr4s/pEb9YXYWaExjmdcBIkpwhG4+6a6pBqdiJz
         LqFw==
X-Forwarded-Encrypted: i=1; AFNElJ+UVLndEOBd6w5E7LN7R557uDD8TahpDvn2e0uBN9Rq0hFU2AqgotLlhrrTcFtt1/ApZY62Ed8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KdqVTK8m8ud7HBKFKvDLDm7SbewK4GzjmtG0vdFPSJ3nmyiv
	P7v88MK7kOYxYFeFUuLUDSIivxxg7Gk+z2IvGm3xVAJjvuy0Ef+wvOXLNeFMjsleU/V8p25iuHp
	BCmH/jlU=
X-Gm-Gg: Acq92OH98xcAVaV4R19zzyHpcEeRbMvxntSpt0UlPek1DiX96DGnED6Ak0WATZiYFdl
	07QASGE/r5MkF4p4/xSLznQJQmInhAWMdBwbU2Y9gfct6e63VtytrZ2Mr5ZSae2a5MKbB6R4XJg
	IMDBnMb6CgNZg6W8LydMqlTHAc2TnDn8bWTN9gV/iS/KwZFnKHBFbcKH5BXnsk7uHcguWK+TcXT
	9BoXL+S+hySx/2reCNj1dQDL+Qz0RohHsLsxVb6Ag7wYBEaIf8o5pvb6fhFOVSoYPk4Hav5/qgO
	LaJWHn1Dl9SAMgnwz/7/lV+oTAgdE69Taascse/OMfvcV+Jp9P7snRMWqQ++U+qmSLghKXYFiZE
	XNxyV2n30sLRhup+0oZ/x/1bpQd1fomCkxTZsPPo0BZRWbHTLW9VMQyM2JIoXFnuhlv136wzaNi
	e8gawjfdziiAQ6SsOIDhNSZEewVAbsqp3/7iqzQRRDB6K9gmpQYs9uuB26Sr0FVJ+/fDgJ3b6D+
	bWwzeneaLyVms0=
X-Received: by 2002:a05:600c:620d:b0:48d:1021:e5d1 with SMTP id 5b1f17b1804b1-490c25f597emr117734565e9.3.1780935210683;
        Mon, 08 Jun 2026 09:13:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f368e9fsm52404957f8f.37.2026.06.08.09.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 09:13:30 -0700 (PDT)
Message-ID: <3e2536d5-317d-4d0b-b489-e77f5be9bdaf@6wind.com>
Date: Mon, 8 Jun 2026 18:13:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net] ip6_vti: set netns_immutable on the fallback device.
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Noam Rathaus <noamr@ssd-disclosure.com>,
 Steffen Klassert <steffen.klassert@secunet.com>
References: <20260608155918.787644-1-edumazet@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260608155918.787644-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 08/06/2026 à 17:59, Eric Dumazet a écrit :
> john1988 and Noam Rathaus reported that vti6_init_net() does not set the
> netns_immutable flag on the per-netns fallback tunnel device (ip6_vti0).
> 
> Other similar tunnel drivers (like ip6_tunnel, sit, ip6_gre, and ip_tunnel)
> correctly set this flag during their fallback device initialization to
> prevent them from being moved to another network namespace.
> 
> Fixes: 61220ab34948 ("vti6: Enable namespace changing")
> Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
