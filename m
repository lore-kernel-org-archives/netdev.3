Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05A157487
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473182; cv=none; b=AAputBasD9j5i7PBbK7VCa6WdyU7lCpE46KAt6V6EJBj8ItrlWNqPHx8vaZcOeEqd0B2916LY5RRs6dmZ8MmXtIFx4dM4Nxvkee5ByExvyAhrikXVd+KjmAB6pskCYdgCBmiEgAk6OJISXh34RcjAiVcIaIPlGqC6XnUaDGe5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473182; c=relaxed/simple;
	bh=nsLsKqzm4vgXThV+6cvbSCiuntKEAWXh0kwXGoVbcBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSHY0sKFKTZMp8OfG58DPxnV289+h6MXIi56aTXJ6iPfROzwRjOJ1JOkVKWYSnsgYcJNF+B0a6ZzhT7EXj1OPjIEsJEVrfLMMHlDPM3Ky1QUcNdrdetNAB9CM+NdskVO874pCFVIBQgLKCXgpav4Y/F1uG/xHsexK3njPBrgIbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=i1oyNu9z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="i1oyNu9z"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b64c8311so6674895e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780473180; x=1781077980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YpNoa/wsdC4dk5pVcZHO1ymEZVv8WPK8bduLM58x4k=;
        b=i1oyNu9ze/Z6I1uum5H86GRZoHib1evKhEWTVFk85bBbPIi8pvp5BAsSHyIVTUa2T5
         IvE8NX+bECXLjn/oza7lUWc/jSysfO1+NdVVYsNXLHqao9v0F/aHQ65QJjeALFP5H/US
         DidninBeJx4mwT25MPfnmXCdPSzFkV6vWbDNuI5AnOFvLAD83QJ/YMNP6GS7wVDpsAXc
         F/s+7JMhFSHrB5gllynHpe8rEnPoQQayoMhISMr44Tnz6g2hKYQaEkpkx7bNBWQzJZ52
         b/lP0CAsopHwamZCNGbMTJ4QAGhpa19DI1vlBFJFd5H4nvYKxYT+amKAqwTiXEot0t7s
         Hcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780473180; x=1781077980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YpNoa/wsdC4dk5pVcZHO1ymEZVv8WPK8bduLM58x4k=;
        b=IvMWiVj4zXzjkwk8Q3MG/QQuTxQrRdMsISSDKGAUFxuasPAYMshd8MFRXF4Qolltjp
         fkuqbTIaCoZnBEyOUBUJGa+n4Tbhamxar3HZ+SwDMLV10kfKENCzc3ckNzqH6ZzQQfIr
         +Hm/9cqg6FcFD6u9bYYR1q8//Q6VCyWQQ2VctHsFEXnuzaMobAO4ivawFqNinGRVqNlY
         TQVbhretPiI1vP0AFr5sQktRi8T0gvjS8m/FHTYyONps+l0txk0xVgkBXf7VQ1+B4GXL
         NFEkS5G4Jdq5P69DydAQC1DFRcLyX6h61pO3YlfbWWWkv0PB3lGs/1PLzCkY39taxBjn
         4l7g==
X-Forwarded-Encrypted: i=1; AFNElJ/cquF9HN83VmV8b6WRMUMGIR/aJOf/WKSma6CrzABXjgUJBErMCKBtUFTl1fQ3ZRFfy6crBN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfEa+QS2eq9EEpHbssOlWs0PuB77p8+/Sx9uWc+a6KtngGOgtN
	GW7GnEQ/+dpIS7T8gqWvh2ca1K6DXrlWR2uQZrbMfWs+6YnR5envtKm+2vEqCwEbSWxcRIaVs+n
	GGfJQ
X-Gm-Gg: Acq92OGSusjXwOTr0xos5Cgs2tQ5tL2aTJTq0PXxnE2q+fAhlq61eBnKRvB4504UPPc
	ZqPiuifxbvPW6en4glrhgF/W9jx8aTGnCHHxME8QgvYVpT3fvKrLqfPIShlCHPxAQjvS3+c7EOB
	NShNiufra/mDd0JOrjSgkfxcy1E3Z8kK4bk1Be8wpdFvU8mj7kD3hyFsbX3xnr2GPA5uV2puD81
	ZWZoa9tWjAyMLkN7GmuUTvEt9F4Q0Nj0lSTIh+ilcgE4YfTR7N1ujafaAlAxpa44yKDTSUuxdRF
	qNfKk87o56IcchIJoWk8nGGoThPkOrfwDScKsAW4Roa+lzqqt1dvERCJYdnbTYytgdvfa6WbA4L
	7Ql3YxfHHU1KNeEVlm+BPdU9mAWxgNI6Oo9ZLo33ZWxcZjUegG2tqCgcLrrLIbzifSP5puZdyiI
	Scl86jJ8oT8U5Wn1dZiELufsJGh68dKknVxzmwniS68nd1PfAVYdjvQRO4yppiHNsVV1Gxcdhu8
	So=
X-Received: by 2002:a05:600c:4e52:b0:490:ae52:499c with SMTP id 5b1f17b1804b1-490b5ed4620mr36511455e9.21.1780473180328;
        Wed, 03 Jun 2026 00:53:00 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm5686677f8f.35.2026.06.03.00.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:52:59 -0700 (PDT)
Message-ID: <194492fc-a6ac-478e-878f-d8a175c16c8a@blackwall.org>
Date: Wed, 3 Jun 2026 10:52:58 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 11/11] bridge: read p->flags once in
 br_port_fill_attrs()
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-12-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-12-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2026 09:20, Eric Dumazet wrote:
> We might run br_port_fill_attrs() locklessly in the future.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_netlink.c | 41 +++++++++++++++++++++--------------------
>   1 file changed, 21 insertions(+), 20 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

