Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A7C4F68CB
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781163; cv=none; b=FDr95lTmhywz1bnCTmHCZ3ygGD50D9IDr52OtsOmgPggWn+WxYv6ZhMySl+nwRGxEeP4RUPpt0E1HhGPM8CPNmY6pq4u9WwLo3PJP9lRM3Uu+/rFDSzvlZaSDa2jaA3TydWhvElXFduZxoDCCq2vZ6PdDOAS7ytLSOgnwcJ3qyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781163; c=relaxed/simple;
	bh=esQugYG3kbo87OmB6Tc4orWNxtCP0RZuSh8EyOmodCg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MP5z+vHsWm+1D0qhKbbDDaOvXlIjh9Q1+FVV8K+P/8G291BaBEqroQv9oHMPm1VcAVSy7cN9e+JeP6N4SYxJZmRSqPPrFOiTMRXXZl8HkIX54Bpbf3zm+MbdEi4oqz0M+n3gSvkbk+R+pRtDbKrnl5gK2JxjExIU+gn8VqTPvlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO4YKqbT; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO4YKqbT"
Received: by mail-yx2-f39.google.com with SMTP id 956f58d0204a3-6768ac36eb6so420682d50.3
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790781151; x=1791385951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B0KRYG+7S2yJakekYnI3HO544a4gjtX4aS+08z2eEeM=;
        b=FO4YKqbTBgc/05sV+1beIdsxIJs4z9Ev+9AsOXAGritjOKkqgPcvvGs4f5ZGKicnIJ
         0iFI6H8Yu/x0cEDkmpi7gHm+4sjTBnU9aX23XcE5VEOFbW7GaUfkm3gI1Hh7Q2jS5if0
         H2kKIw1yWt3PYlkt1OxigTutqrQt3/XNfDYibx8TrJFK5l1YxnB/N7ZnJZjgsUoevlJR
         ETLPwWn98adNG3mERRfFy8GTcLMh7OErk8cBKWIllXjDuaBbk341PjwQrR/mHVFUhMnO
         +dqYJwd51yf6UVYapD8kFy2G/KOI/NbCvAZTFswl73A1L9Y37oXN7gVkjsM3R12SX3OW
         jmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790781151; x=1791385951;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0KRYG+7S2yJakekYnI3HO544a4gjtX4aS+08z2eEeM=;
        b=cjQl+utJIOjacolrGk7tKiiEUi++F7dkvXMMAy5VksagTTXKo44eLjwuPPeEPXi8hE
         v3ZNQ0ETJk6eEXYg7QyxYr3dHNcHxlz+t5kjdsK+oK0J/IzQdHTILM4c8/KECn4tJzWX
         gxz0M0afAshwAyL7HnQ/ji/PqFpzBQjBrCnDni1ACO4gbxEkFgFEqTpLA3mAsc+F4TXN
         oLHuzLRaVAUvaZZKrBojjifMUTZ0r/3ZW/EtQO6vzSyvlbKNoFa7RWL4cppnj/Sgo4MF
         j3662k0a8SIsZc4cHJJqd0E8eKv+glzvJCLVoWadyhf5+oheabqXLrTO381mEanH14+b
         QgNg==
X-Forwarded-Encrypted: i=1; AKwUvBwTsiZrI0pbgf/04mpLWZ483vwDeRLI9+1cujzOHOhiCKKPzB5o/43qsXnZlVqS4Ls8ZtwJO1A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJauhzKD59+i2e1Vb6C6vXpCQvNwAu5viB97leCNShgYZ4YPrU1
	oRFc5z+54sQjgzwgkwcI/bHleH4wVLnjfoaWbvxTGGEpElhGQ2DjGqHv3NRP6w==
X-Gm-Gg: AYBFou01nMO9r6La3RQ4ZS1FRDEOgDKJaZvxxWQDoLVsIdSLG0SD1lgEeHZtvH4O3eG
	LrzGca4eon9N1uNnmsNJACP662uBG2ShKQaG7Q+VkWtPLeWJVaLm/UFSjGW0o4AallE4KlzFm3J
	rYjJwhzudfQoGaHvtHhm5MlW0GOO7EclCGjbOxImvmM8qPzBS86eizkdgcMv/ccmOjqg5leFH2L
	3hL8LHnMC4i+pFKIq+ZOxnLk06c5Fr/BanTffeK5aDIZr4LGWxS0XgNvp+n9QvZnRnMnPTwfHHG
	Ty6E6LkDn4qq9TEa2KaGBiUaG2U2V1iSnyekfIhz/s4lvjU1P4az/h6n2KaitBg8k/e7AAEqwBj
	6cMa8Far699BgioWj/ttl8LOcYedB2BS9XVHf49TcAgAy+iBZ44ORB0vG5ARGmwQmYKh1WJc6Yv
	w8HyotBvsxHeOf0Cob1SYRQmBsq0r69Fb5yN8e+L3tqX9bfqPYN3UGOOMZIAhKhJQU+Qq/aGqY0
	nf70r7FJ8u4je4Jfv7SyWVEYW04C6LwVQePbQn6IbZMg96VQnOgpD76I0jYEqI=
X-Received: by 2002:a05:690c:e3c6:b0:89a:63da:fa8f with SMTP id 00721157ae682-8ac932204e7mr7427907b3.74.1790781150925;
        Wed, 30 Sep 2026 08:12:30 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ac53e96182sm7395337b3.35.2026.09.30.08.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 08:12:29 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:12:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.1713efd699025@gmail.com>
In-Reply-To: <20260930144018.1174068-3-edumazet@kernel.org>
References: <20260930144018.1174068-1-edumazet@kernel.org>
 <20260930144018.1174068-3-edumazet@kernel.org>
Subject: Re: [PATCH v2 net 2/2] ipv4: reserve one IP ID per segment for UDP
 GSO packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> __ip_make_skb() reserves a single IP ID for UDP GSO packets, but GSO
> assigns one IP ID per segment. Following packets then reuse these IDs,
> either from inet->inet_id or from the shared generator.
> 
> Unless IP_PMTUDISC_DO/PROBE is used, DF is not set on UDP GSO packets,
> so segments can be fragmented on the path and IP ID reuse can lead to
> incorrect reassembly.
> 
> Reserve one IP ID per segment, using the same test as udp_send_skb().
> 
> Fixes: bec1f6f69736 ("udp: generate gso with UDP_SEGMENT")
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Cc: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
