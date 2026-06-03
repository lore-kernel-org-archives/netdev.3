Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25D3939C0
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472649; cv=none; b=knP1XOGyllu6eldTSiiJnSSkxTVJRhczN8bDd0e8Bsew4Uy5EFUzI3vtSdBJJIhHvmBxcfqd2uiLWxHbJnQNMwQLrzphiWvxh58ffpk2hAp4tqf3Qw3d2JMw/d0qLiBYM+m/lBfuAWRer0Yto5LI54UWu+/zbAvxV9syR/KBlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472649; c=relaxed/simple;
	bh=mfifGihAo4w6JJC8KvC/Ih+T/x/zNLuPgP/1TDLr/Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1o7uFobdKFpOZl0Eg8nGey3zSCwrs5scnvgF22KWOnflKfgiK1XYZ6sfzdm1uu/J5fxbSJkCrVflgAx5ASeObE2VVdyJ2D/n+L8rCUoSnnLOUsP+SGqfkCngzg8b+EzJOTe4HJYkYBYU07x/ReXbchDVfUCktk0/lyFNGidAoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=C9Z4dDxK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="C9Z4dDxK"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eee266c6cso4665038f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780472647; x=1781077447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aF9TN5NMNmQd7euFhlOqll+BVjmvjyy0JM3fs3q+cd0=;
        b=C9Z4dDxKSJB7oL7fvkU2M6fYJruvnLsH3WSfTP9zajL9AIJRYPNkRwHtoeUdI/8xBw
         AFExhOxLsOhxucyYLdbbZI/BuibRWBOtRiIvzGF4Ei1+rGLWtAYgIcfI7bHgU2jrrLZX
         Q/Pom7ge86YuTtbOukr2TwFrzN7PvwejuiczcsjQVTtC+EtjtT8VyeDPZirpwZs093pe
         zN2Y7nHpnxdmB9d6JdVvcIa6odXKq7D7EgcH5fQq5taBr9KVJG8OvDb0YDA4/ZZBnalu
         xSxiBoc5VS0TDcCx3TDoLi+0An11EvOXwVUnejAMwon1xJPAJ57Kh0HeiyPMFZjt0Ahb
         iXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472647; x=1781077447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aF9TN5NMNmQd7euFhlOqll+BVjmvjyy0JM3fs3q+cd0=;
        b=hTJ2wOPQNfr6lLq5H8sGnug1a/g3kdlrjM3Z8cD4vo0sC8CmAdavalu7jG7b8SEEnA
         yUHJBjEXleS581YhxFqDy/HoeCyV3Vx1sT5b1S/wVkF4IHsdzi7HPk+gqMJj1pY/vh7i
         sKj6/4ezUaGTKLvZr4tr44EsylzzUtCIwbI4wnBHX1hF8PAuxZ4EBabqLogWhWmLchzw
         hL+L4GzXsQ55p6HQ6fPp6ew848EO0bqHju5OIqYGUhHei+e3QjpHwgARD4hDkU8KLnKM
         o244NH4jiTpfpB7BAe0UKBCdV1oSKhGP6K8VqOAGwLxQD5SmFaoLnvqofL7GD/CZ81gI
         zukA==
X-Forwarded-Encrypted: i=1; AFNElJ+jl/dCxh/6y3aojUDpxwfWqGBfYAOgIwwtOXzYptE93sDGBzB++4WxQ4m9XEPxDDAtneU65DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTtDKFlY+2ZEXkGC8/pCl953kFZR+0rezU4BIjqKfc/UiXpSrj
	sOdhUy6gsuhEr2Ogx13323CgDofEXs0PKyYv4sBhUtJta7kn6sbrUa6LPQkcGRczC8k=
X-Gm-Gg: Acq92OHToN3Zl/KVqgjU3FE2m0ddbokrg2x+fsoJgdi1kXm9BcKvVut7n1UwCAGdVyG
	6xzHIPAt1eYrdvUyxqdOHafDGwZz+BV+XMrbLLmlE6YzCWyJWarw0tm/49IBb+N86BDxMnmlJrJ
	DpqILJXbA36oons9JnzysG8rDPCdLPM2v8jXoyjJfwoYB3R7mnULlcLcAhYDap0wojgrqR5nNK0
	kPlM4t145ezQJ/LWjgIo3RGwxPbXDmEB1q+YRPXLKzefyZq5fD5U/SUFxKyI2y5LZadl7VZ0Wg3
	zaUCcHhmYMyfgX8gjNmUaaaktHyyLZQnPmCrkQVZUyvH8uT5Obl6f8gyrCGlQJTFK73xJ51jHNy
	wC29LhBy/6peG08zOZjTvbglCqH3mAohuxDFAUpTFGO/CLB8Iwwh0OgrqVYsZbFQ/4EeV5WQ6Gb
	6bUEBS/U66IOgSpEEzeEQqZhG2vG17i5xDhD1K6gU/xQnqBtIS6XHQI8fMmFVEehTR
X-Received: by 2002:a05:6000:60a:b0:45e:f4f7:7cad with SMTP id ffacd0b85a97d-46021980b94mr2628110f8f.39.1780472646494;
        Wed, 03 Jun 2026 00:44:06 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dc294sm8488649f8f.7.2026.06.03.00.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:44:06 -0700 (PDT)
Message-ID: <320bf57b-ec91-4aca-bf57-de8d8d9cda30@blackwall.org>
Date: Wed, 3 Jun 2026 10:44:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 05/11] bridge: provide lockless access to
 p->path_cost
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-6-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-6-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2026 09:20, Eric Dumazet wrote:
> Add READ_ONCE()/WRITE_ONCE() annotations around p->path_cost.
> 
> This is needed at least for sysfs show_path_cost(), BRCTL_GET_PORT_INFO
> and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_if.c       |  2 +-
>   net/bridge/br_ioctl.c    |  2 +-
>   net/bridge/br_netlink.c  |  2 +-
>   net/bridge/br_stp.c      | 17 +++++++++++------
>   net/bridge/br_stp_if.c   |  2 +-
>   net/bridge/br_sysfs_if.c |  2 +-
>   6 files changed, 16 insertions(+), 11 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

