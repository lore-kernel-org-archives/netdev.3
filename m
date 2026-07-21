Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74C746C4C9
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649708; cv=none; b=SUYjEo8hwInd93qCYMc0rWkPHWJZgL5Yc5teyDKmfhFjLxskPXhWaLO6NddxVRnFgUyydakdSiOV6tabu5X5+kiTgJ8dtcZTJSW1/pa1rD1Hc9CRikAOTVk7gDJreNAoDYIdvNd9HbJR8B57tuWxIKWQOEY0o++UUSe/IT9CYTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649708; c=relaxed/simple;
	bh=Yw7gXVTpHGxoY7yJEfIsDmK02NOZo3M96XvsnBu4N3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrEz/hwF30AydikupiSI9+Mc0jFST+OsLJ1hC4zSlf/nmjp1RlUVmfNpaXufRE/dh6nBf+l+fQk/3Z0UKFs9CKyJbTw1os+bbGqvjqYBDMr8fXXv3TsDf76s1cDBTEAVcKvbNdMKySVA7UmczAEkQ9pE6TC6VvDzsOtxiTMhkCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0PYrRUR; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0PYrRUR"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c04bf4711so7061771cf.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784649706; x=1785254506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CCsMWHiy8lvPYOE+m0FXhgzrH3sURDkHCgMUoZjYcmg=;
        b=Z0PYrRURp/Vur1z1THGf/K4iA+z3IhJIo6jdpyikFyRbG7wmL87+FF+ch8VtXFvZq+
         BRuS/vGg2HMCsQ2P5RGbSlpJy6bnIFjuv77+HG8YY9hKszZ15rqbfHHtKNm2+VZSkjPu
         DdIMlIJoPiBtY2uTn3aA33nuYLW/48OQdH6KWeg1sEi8AqmX9X0yj+JRUfGl/O9pzczE
         IG5/ay4Kw/kbVTiN1weLSa03iC/o2BikVHnQOiI5yZFdcOoHqOLiErBDfGC5pp1XA2J9
         pnTu3IjQ/pSj1L+/3F7Tyy1iRZtkBF1QakcyVZARY0n+3jNwA2BMrW9eBnUY3Y+yOs++
         Fcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784649706; x=1785254506;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CCsMWHiy8lvPYOE+m0FXhgzrH3sURDkHCgMUoZjYcmg=;
        b=dOMqJdEcitDTO/yrHvMA4ifahvJ5QiMXUiYupoWhyP9LXLuWX5ODzom6FjCZILQVOQ
         NfMDvbzMboWCyXX7BMdOeIZ3KdsoODX850OCkQFIdVPsK2uxQ3MB9lpecflqnQOdzN0q
         Yj26PNBT+0hyqAk/slbdLQYLv3ezuH06PzEZRaVSuKwZAOnZ2ERqRUXHZQN5CAKG3wsq
         Uu7igvaB+2bHa+U/nFmpzIiEVC2JaVIrsKkSw66XuvCCwAZFcrPHF/8LjS/dV/Ni4/bz
         a7hvfiGIkzRfebSVJHqowZJ0u2NmFe856n6uxfGXiyIhyWuA0Go6GpuIOvWW+K4See6x
         jmdA==
X-Forwarded-Encrypted: i=1; AHgh+Ro7qWDR6piJ3Ws96Nediks9vWci0I4Y2CG5xyxYAH0cD8EAGNKArEwGe8rj85wWqRr0J3+0CqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDQMLtA9IE5y+HrPFrDYSTJ/gArIvjteOQcIRVfhX1n23Z1a/p
	OJKJRuPipqcN8jKVRYneyqTAGDZSGNzq4NTU3cjaX3O4iPTBsNXq8SNo
X-Gm-Gg: AfdE7cn0+posarpOMJM1x+Nz+dc3cenkcVsH9xEBzOs2sTC45GSgIfQPINVqbNLPpXQ
	KoLvY3Z777zuEgHHjujPkibrD8sIPnNoV/zUIxmBbD/d76rsF5lgf+181D3rJC+hQQu5vBeOo+Q
	ihTzOSdoXnEI8ZRo7w52YO830iwDTArnXvBZSJe/3rWqyJjvYYUad7o/PS5gguAeB8GowPMgyQ4
	+g9S6VNDaaWDhk4zJzpc+vYORTg7FzmpFxmqi3Dopu7JS087nxpfx5iHtMU6087R6Db3IH8RgQU
	XcgPA4EiFXAH0ovqMVFqjEpGDYWuwRU05SStlaWJfOEoxX/Ro/PePb+1wK5jag3Zmgrhjttq+YF
	ldcm7/NF1PJ7hTYAbQBbvSgwXJw9IyXF8oBLSVr1hQfA3Ksgf458zARRava4w9E5r1yHnF6zRPL
	AFnYTaVr64P+fZYN4rFn4nhwZZEfQMdSYUag==
X-Received: by 2002:ac8:5d49:0:b0:51b:f98f:ea5e with SMTP id d75a77b69052e-5213a97367fmr190789071cf.22.1784649705533;
        Tue, 21 Jul 2026 09:01:45 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:9e60:fa04:7d21:c1b0? ([2620:10d:c091:500::2:19e3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-521500c552dsm100014701cf.28.2026.07.21.09.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 09:01:45 -0700 (PDT)
Message-ID: <3e4b1552-57d4-42ad-a244-a91b74b8dae1@gmail.com>
Date: Tue, 21 Jul 2026 12:01:44 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] packet: use a consistent hard_header_len in send
 paths
To: Qihang <q.h.hack.winter@gmail.com>, netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org
References: <20260721084935.12312-1-q.h.hack.winter@gmail.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260721084935.12312-1-q.h.hack.winter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/21/26 4:49 AM, Qihang wrote:
> packet_snd() and tpacket_snd() read dev->hard_header_len multiple times
> while building an skb. Device reconfiguration can change this value
> concurrently, for example through bonding device type changes.
> 
> For SOCK_RAW, packet_snd() stores the first value in reserve, later
> allocates headroom using LL_RESERVED_SPACE(dev), and then subtracts
> reserve from the skb headroom. If hard_header_len decreases between the
> reads, the skb can be allocated with less headroom than reserve, moving
> skb->data before skb->head. The subsequent skb_copy_datagram_from_iter()
> can then attempt an out-of-bounds copy. Hardened usercopy catches this as
> a kernel memory overwrite attempt.
> 

Wouldn't there be a similar issue in the SOCK_DGRAM path with 
dev_hard_header() calling skb_push() after packet_alloc_skb()?
