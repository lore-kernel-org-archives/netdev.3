Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DA495531
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141490; cv=none; b=d3N2XWkGrt7mBA+EM4sAUPSYa58Oqn1gE/+KZeSWPZnxeLzRv1YyQBi/FNj9GMpB9ofWJ9Lo67cgxyk4OsMr3liSHmaX9grcCo/x4I4H6srrXr0F5K+2Q4xOy+yhJb8G9jAMi7v5V+sE2PMLMzb1KEVD34t8Sp0IjA3njwOGwWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141490; c=relaxed/simple;
	bh=77LXYXgJoDGNgKFujHE3OW2GeMjh6O/I1WWs4eD3Qlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLMTMVNxD20ucfbQXrbPIjKZ04ebqSGb0TGWI4QMY4EC5bRq4cEFbfJRqm4o6N7nuKqZ9TTzOkRKyHFFfE0hU9Q8Hk8f7CZItvN/81eULwGOUXApOsIIP0TkYtYVPRv+5Habgif5Aufj87EFjWc5lsA6E4WXlfQW+bwkC/O2kI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=NXoiy4eb; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="NXoiy4eb"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-499db1740f2so23725e9.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1789141486; x=1789746286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qMq+XvZCJh1BRiDCee0lFcd5HC93x9tlqE/S4GTE3zc=;
        b=NXoiy4ebCtjh4lLSsxJDBqyQ4uODvTzkLqHI3g4kf14U8AGKGMACcSWJ/DXjHfROXU
         BAhhFC2MxHfvS23SW4QcQ8BS64t4i/oVI3JhFJkXq4O4YjFWTmrMgIHMEFgflEFzXLU5
         keY346oxUZ4YtSfxdKMGezfVO+Y77FbEOrFKq/ml7xU9hFJ70MXfmFBFHxeweBa7sDLA
         ug0x7AA/7WUCwTmHdQazD29dOtDQuvoLQlR2owzGmJgc7Gicvq0SgEUI1PjXXdZAVcXc
         hSb2kdut/Y/fiIlEcliTtaTfn6rhAXORKHCE+VxKpvjwzdkvvjdHDNQk+q+nmuYvmDac
         xOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141486; x=1789746286;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qMq+XvZCJh1BRiDCee0lFcd5HC93x9tlqE/S4GTE3zc=;
        b=SpaVt0iqQNlbv200qHw7SBZhXblZY07khfd2eRjRxflCx4f/flm/JSvQT8kXxpXMnk
         ouEb0+ia1h6Bs4XnGuvm0dw0k7bGBRC159R1ggI6ZdYYx3KvfPpI+JNUcMPhnivtkBOL
         uTS2aaJrToumQ9i6SgZ/XDsXpnQCNHSa6UPGdy3BuLMpf29bu84bb0bpwCoxrKplSgov
         pGYRCHsKSX3wexAMiorApYCV/4QrbMdAP3X8mbIa4QWVHquD+t/gHIdE3tM0QzDYijr6
         1vErSfOqPZ/gubinVi+500Z5ktbfiVaj9/nPJ8rNerVjmOWHFBrHwfvRnszwZYED+rnP
         dCjw==
X-Forwarded-Encrypted: i=1; AKwUvBzCv4dkqza63GK6Vj9E0rTR96d0BSSDhHXR6BES/aeOGkYEIZj1G+sN/UwFlwB+uep5xGzws8E=@vger.kernel.org
X-Gm-Message-State: AFuF++miOwtqU5X2+k3qHjZLRJotslJfi+SbJKP6AopOcnfgv2OuSE/i
	kyIGz6PCLI66sKuzQ2Gl4NCgDgxjuFhzU8kgnvxIfngEO4891gITeKS+AxVv/ecJwZA=
X-Gm-Gg: AYBFou1Cd488kfmPuzbRY6uDGhFkUvUAguMFAGIMzKWfJRsHiLpicQ2C2eUDfK/bgf8
	QQWkjWrX/kO6CuD5H1XOB3FBWAkwjRQA6yvUD/+I3kLmSlheoT8jlTpcyEXjVSKMMBZR0vw5SeP
	mV4tHnQEnoBGoNh7pj3O/pvwVaJ2v3V8HaDev9B233EDj18VT6UKaUfjwiN9RM100oTVwmw2W+1
	p+1DqLGyz+izxP+0f+uARW5SMfSDejLcGrfZG3d/LNLZD23r9nmOmBDHqAY2xgO5BWkxJmiGInS
	vjG8W1+xW0ge72dAeEkaUCP38Imzy9cQwWlTSOfIkR+shkRjVINBMJGeoTHXDbDntySclQvpPnQ
	syphzA2fQU2CvQk1wyMOhswhtHVugUKqI7Cp6VV4f5W51aSElQgs7Sg+oTf1IfmKo6b5vuMjhKQ
	pgFVo8X2X/t+bz1OPyck/1lu8MQAqO3CJKepRE29c5m/OumokotllhJwm/MGdS+X/sgtlcHNJlR
	8jPIcBvmrFU9lMM9VKI3Q+dpIzheEHaTrkbtcjVRb01ipHoCclY
X-Received: by 2002:a05:600c:b99:b0:49d:1da4:511b with SMTP id 5b1f17b1804b1-49e619a8962mr53370715e9.1.1789141485841;
        Fri, 11 Sep 2026 08:44:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26b7332asm161865175e9.0.2026.09.11.08.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:44:45 -0700 (PDT)
Message-ID: <3a7bd165-cba9-42f4-a761-61a9031a05d0@6wind.com>
Date: Fri, 11 Sep 2026 17:44:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v4 1/4] netlink: specs: rt-addr: fix the type of
 target-netnsid
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260911105103.7771-1-sigefriedhyy@gmail.com>
 <20260911105103.7771-2-sigefriedhyy@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260911105103.7771-2-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Le 11/09/2026 à 12:51, Yuyang Huang a écrit :
> The kernel parses IFA_TARGET_NETNSID as NLA_S32 and rt-link.yaml
> declares its target-netnsid as s32, but rt-addr.yaml has it as binary.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
