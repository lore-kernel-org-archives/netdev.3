Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78B4A1DF3
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538979; cv=none; b=ppsWOQdUx9zAM2XALfyCvxtJa4yOjrGqKU8zI4stZpayBFGN9XeNhR/MgNHy/1j74s++9g7tCe0tktToneahB3ScEb1oDVvA91kibEkLb/QyjCeWQFf3nZk+zyJhGDqVnfgwXSRERRXckp8LrX38Eoors5wkTPzWHXB5AbRnP3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538979; c=relaxed/simple;
	bh=ALY1O9tPv0kwiP8hOApzJYIHIqYDvjbsrechk39f/v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkF1cVHTldXJZOpEKGDergNo3g4I1viJv04dUrrrQjKh4cQain1WqpUWOe8eC529CiyoJ7dyv1jyEdDLZ1ZAW9cpMjbZ7emDiGfv4sYZn/S+JVrgB00Z8zV15ED5RI49lp60kfA5T4+PWrMR/noANdDTjTCbgXiv6rBxABcj0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UALXc9n0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UALXc9n0"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c315869241fso713114066b.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 02:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791538971; x=1792143771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87sDAQaZgbuZUIRnkfj95yPvO1LFq8s/STt1FfRjdWI=;
        b=UALXc9n0rd0+LHCUqo/dxG4XIcJwjwfe33hweiqjLpNZSP8wMAoKSctx+0d0ZfUoR2
         mw+qisE09jrKWuQ43p9clba3fHlWo/fH05P8bkZcmTih6mKj8Aq5hGrZMQ4RsXeWeZEz
         sV0ZlhXAVYcNoagK6rL4CBPUn76t6zasveHVQdg2voVhnidqJF04aImHkTlmw5S1x3K4
         xdaN41/BPN+E57acyRQDLnALC0Y3a+hdscUhw02mX3sGuiGlwQ+X4vHUkvvA8J/ygJKq
         oqcvWonX9Jlz9hrfhqNpvkEN2DiLhq6BxcnkNDtzW9Bl2yLgK8omeo7mwe/83parWnjf
         Z1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791538971; x=1792143771;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=87sDAQaZgbuZUIRnkfj95yPvO1LFq8s/STt1FfRjdWI=;
        b=kHp8s6pxog+ANlbnwI42tsgzTvm7R0QqH6g/SMjKeR0AmPFdM8ZgT61qDaV3Ijvwnp
         Ak8OSpsV/3ZXWfoUHN6/gvfZnW8RrvGb20ZFybFAo74aJZeiLmaFZyEHe0YeLMgeSrs4
         1m++7T56x2KoX+rD2iwgQ+iEbVVoS+2iIS599ibYqtUyePos+qrWxc5ubsgcL5+HnCL9
         sbPvYJZGjXImNETxIyJGApXik99/KfNTyXK7pzCAR016Yi0mqxZACVOIvxGT6biBYsMR
         SmmmBXZP9YbW5JMpYjYR/csbfjs8EHou2G8XfkDROLu2HBGYNvqBET5Va3dr1WXrqfwx
         AEVA==
X-Forwarded-Encrypted: i=1; AKwUvBx6ipScLyg0W6W3INj6YFurIVSetILiEdgQ/vlmLtw+MOXkd813ngbCDxR365lA6ciRX6VnGbA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwVe+2Qj/Jg+Ik1tfDXylTcwxXZzlhcohoHtdfePpS1FLaHMdq
	NPTMKpBrng/velYUcjj1xLkYtWbRt4CXe7HQ1Xx5YtV341dsv1SNmKcm
X-Gm-Gg: AYBFou259hdqbTcCuuLVcez9fwICa6UR1gziF4wdhRi47aC7G+Kd/gbmEw0gWdbdqxJ
	ZOMJr6i3mOTEbky+3U59rnEs4DvxL2rOqBGVgInQZ6AeFUSl84xlsA2zEVZ/ISJS4vWUJdZgbKj
	y9hMiVb4qAyuiGefWzl/RfHU8p/oaFvAHXsVrrkrzcsqi7n7qXOnP1n/NHTAR3vBC/SWxaV3A3d
	rnHnD2ap43HV6Pvbq45iqcrqPnrmHjKXjOJ7jX6LwaAuM88oDNTYDI7e0sxmkP0isTbBQBXTUXd
	cYgfDInER4jhAh3FLzlp8nTvebiYBSwrCEdI2BvGdDjDd3YmYXfo89F/zYsUCYDsVVKLfGmyX9g
	jjvFVnC/KR5JJ1XNe8KX5opsQqHtAyy9LUBuO5HHBm31mlE+5zmwtmqnGVvAUPK1PF6wVj4V1wP
	sc5+zQ/LaygaHZezTZWeiYKykH8yO7AsD0VAJ9TiNtzrWKlS7dTZf04hACXakRHHorqXf0tdkEh
	iH2YWWAp2vU640XKLPyvscAm3/u22ow4iomFXC3chv884xTJrm6kKOHKy6VwUJrAAM3CXtWlSiU
	dbJ1GeI/tl5jU9JxYJEqOB/n0+QNFEHqP5cvsGen6FRLw2sO3JUzOyiBuVDZLmbxaNqpaHb8ODZ
	edorbq5OBctnnD2ov5a7X7vW4iDLqRCfpow==
X-Received: by 2002:a17:907:9620:b0:c29:5172:6151 with SMTP id a640c23a62f3a-c31aa02998amr127473466b.45.1791538971338;
        Fri, 09 Oct 2026 02:42:51 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a97654e6sm71202366b.7.2026.10.09.02.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 02:42:50 -0700 (PDT)
Message-ID: <6d9c9501-70d0-4e1e-933c-eb5a45bef97a@gmail.com>
Date: Fri, 9 Oct 2026 11:42:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] net/sched: taprio: fix RCU stall from replayed
 schedule entries
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261006113335.241564-1-krystianmkaniewski@gmail.com>
 <20261008091732.7794253a@kernel.org>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <20261008091732.7794253a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/26 18:17, Jakub Kicinski wrote:
> Could you restructure the helper to avoid reading `entry` after the loop,
Thanks for the review. I will prepare a v2 that fixes this. While
reviewing the patch again locally I also found a few lines over the
80 column limit, and v2 will fix those as well.
-- 
Krystian Kaniewski
