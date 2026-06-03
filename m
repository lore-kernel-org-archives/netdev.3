Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388143939C0
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472834; cv=none; b=e9E/xbNsnzXr48n0Uy139PaSodM28+HGIizYltphQn0Uo7eN99lZ6C/o8dVB58D455m3L2QIDXE6qSWz6TuoThge35TBcwXNxkq28/DRcw057chyY2HBS/ahgZifeFy/5y1H8onegiGlsyGxMnW5kBCv77/6z19THwb2BCjvFzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472834; c=relaxed/simple;
	bh=LLDwJaDc6s9a6Nz68cJFBMwNjB4GNEH0kD9M4Oq9nyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPYximXpBUdfC2RQUHYusAMPrHMqls169xDDVymw1x/DqlBsAvmvo3Ca3+MLoI5RGvO6UyH5NVsLhQdmpBiqM4EP+xXMYDH+BA2vcyG19UCvcjhu/2c9XkqerGQ0i4uHQyGqamEX6MdlXKc/sifMc6raTmJCmWaV4ci+fJYQBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=muyzh5uA; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="muyzh5uA"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so8322995e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780472829; x=1781077629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBFxvEW42xmtzPE6sa09zCh9gnUFZTE4bgbf/YfxYag=;
        b=muyzh5uApuvQqydbdeaNmBiwquAF1/S2TFIgYj+1jMbP7PS3rQqxNSw90DaRqs2D73
         6FIFvVYnDxUL7LM6Z8kQCdfVHiNefyBez7fslc0L5BES3DENNfTAreiDSTWjMi6roJHr
         dU/CDSbRgSNgzfpFP1HK7vegrik3qGLFZQpyj73SecCGIVO5NvdHMaUBiBr7XwFZWn6+
         JUgbcheH2BcgkSdtJq8om8SdRpIGnzC8EexwO6Gqx5j07UQXLp7/KmHhsvjaEAPazLIQ
         CuO1+D+sLqYNiz2swbVt/0ptB4Au0P6gdtyO5xPeAKvtYgeZXDnaYK7zPzu9YevHp/ov
         7QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472829; x=1781077629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBFxvEW42xmtzPE6sa09zCh9gnUFZTE4bgbf/YfxYag=;
        b=cdCO+ChugNFyiJQytG2WqIAG80TbyuMfx6vl3LBStm01xMKSKgSaqfEnCQTcGTfIo3
         euql8zHxcNGd5l5PdoLUKFZxqU+6zlHkMhx877aJim6WPFnH3xgpdtYH0XXAZd6ss5Bu
         L8o7IUKMnWzBTmB/hIC20fhRpDeAQ+m0T0p4j+GTnp5oiYjR51BnnoJonTZO4pO11g4Q
         9orE2GiXl3byjxmu7oAoHbtLDzymZ5SLa7f9qjvRXP2WmjaH9/StmHAzntUk9oZ8QupP
         BAY5gFlBdCuvsamlMmpxkqRz1CQwpZwLlCI+S2dzstP3K1nNM8ma/27PRF2KMLL5NXxi
         Wf7A==
X-Forwarded-Encrypted: i=1; AFNElJ9DScyUMRD1GKzlDDihd4dW8LpHIY/NBNsi288j8ICG7tROMnmXlxVnW3fWi+z4DYW8e5EyYck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYqwDKjhNWcHVUQYZQuRwTOs7Q+EZ9jaGEOrofWJaEgZhkVkcR
	A8vdKff/dApNTAda1nCbmw1+WIcB7Q3J74GqpFXSGAqvPN2ISp6U1l/TSVnUd0gw7js=
X-Gm-Gg: Acq92OHt8jNarTOHsMcTrQT0VkBZ2BCcqY6iWsjXmKE/iAgH8G2OBFCNeLiZoZkEGSE
	nM/JcMrx080NSBMc2MIrVlCoOmNuW5snhbLRfOchD++2M/BHrQxJ9rksCGeyNbLz6FuzFfxHq1C
	SgdAteHm+eE4ZGZrFcaDeHE/emfcX0NZdWfqMUVOSAYSCcZcvVn36xu4WjNcIRgUMr3hTowPzoR
	CuAjWSIJaPjVsVk19lGS8jnO5IEAMwoz56ieK+tjV1s4UNQ0O52W5QG3KR8uA3lVrzheA9opQKr
	CnJnhY/4zJDxG/IH4NfQja/bmuBckq6XAE0F9uw8VMLi3yBYwdOXhjggK1w8xA5tubp9HOYJTex
	53/2zG32JuAMG8GQGMkNCeA/jN98sbM93N3AoKGQ60mKkYm4+YNPCD2z3Y6QrBJZETWN1Dr5Dnm
	y2Y0Vw2BkQbDRPzGbT58w97WO+P/W+s7z4wuz7LeFjftzrsK6BKB0WhxdwqsNOtXet
X-Received: by 2002:a05:600c:8184:b0:490:44eb:c1d9 with SMTP id 5b1f17b1804b1-490b60fb00amr30465565e9.28.1780472829518;
        Wed, 03 Jun 2026 00:47:09 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm5943401f8f.23.2026.06.03.00.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:47:09 -0700 (PDT)
Message-ID: <0e125b74-cb45-4a89-8af7-0bf18f8beaae@blackwall.org>
Date: Wed, 3 Jun 2026 10:47:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 07/11] bridge: provide lockless access to
 p->designated_port
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-8-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-8-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2026 09:20, Eric Dumazet wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations around p->designated_port
> 
> This is needed at least for sysfs show_designated_port(), BRCTL_GET_PORT_INFO
> and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_ioctl.c    | 2 +-
>   net/bridge/br_netlink.c  | 3 ++-
>   net/bridge/br_stp.c      | 4 ++--
>   net/bridge/br_stp_if.c   | 2 +-
>   net/bridge/br_sysfs_if.c | 2 +-
>   5 files changed, 7 insertions(+), 6 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

