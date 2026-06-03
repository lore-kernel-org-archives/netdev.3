Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5736F402BA0
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473044; cv=none; b=Ld28EfEnFSKxNI8LmLj9jDQFoo33KBv9WuFg1MMe9mbgZv3xkc4IDK3VGgOsBLtxI4OvO1gmi1O8gUSH2abJh33h0FxUIeTJ9C4s5zSHu77THQaUQtXwZHzHwdN96K/mSDyGsrTV8EfqxM5Tf4rsCRWGmT+cGS1LGP0LrUjU8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473044; c=relaxed/simple;
	bh=DfKZU2lEpY/XWuD80Z8o6lGViXs83jlHA85EQaV6BcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPm17I8I80I+okERhcBaKDHESfa6f86/+GXz04I8iYGPUaRY6yEHeXU5DvdNwXH6IdLtbuBNoP5byBfA2Z1BNtzuBE4tKg+gCjmCFQ58L1TSvVDiPlUBAyd4URpipNKxnI2HhtNooi+RmZe7KYKKqBrXAu+3Sa6//rdizRLwBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HhPvNOcV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HhPvNOcV"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45efb698ef2so2145706f8f.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780473042; x=1781077842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FFnDjQi9nJ9DDSXP3upNDWWSUY1uZfMzeFgACqAkmQ=;
        b=HhPvNOcVRafBqp7ZUjRztSr7BCsq2zsy79K+f3OHCnIkdiKNgOIdXkrdA0j6eJKVHY
         9cxu3j1PpyXR42qI3hvbmGooyzOAihc93pImqcatzP/PAwYPZ4oL3i5zPXvJcNEsKikf
         lJRtZiBekApR04CdwaZKsbP0DqYl/KrSLsAU90vSRsl0OAS93ZZ+D/2BgLCaTaLfliFl
         5A0m+a0iZcXecXthaaKPzsFAHmC4CpmjzwMetl0qBjdorPeb3qYPtEbS60QckqOLKgyQ
         1Sa5e3zl5yLcLPTMyfOXxs/MdySg/A0J5UPZPbsmeN6KStnQwB7A6tIM8zSwvtLvxawv
         KS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780473042; x=1781077842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6FFnDjQi9nJ9DDSXP3upNDWWSUY1uZfMzeFgACqAkmQ=;
        b=FWAuOjz8cnmhVQB3F2sCWNK4iANuW9T7Z3w23H/ggNtYD/5pBDMlQaA5PkmwOb3m+j
         XLj6M8dBCh0Z8f5eYhh3huEns/FCh97MNqS33SNDVtaO/dxEAZK0xkf+m21hYSPmBX5i
         Qr9W89E9RjqJtRLGlGpndL3bRCx4QtctrV6bUI4uFquxlaBUbEjutafwG7khIq2pPWMK
         cqPHRe2k7c3RTPJTTMARBcMzTALYuIqn2Mq9C5WhyTER/wSPAdhrBopEp3NHnhXF5HeU
         JvbNhLeweWBUIyN9ta/N5qiyVi70Q8bJ7xlYuUTwj10GKiE+AOz8CTQG5gZNBLZI0lpb
         wh9A==
X-Forwarded-Encrypted: i=1; AFNElJ/tbt2eBLuxoRwmO49Ummyq9+KSn3MUZesWnWj3kSoifNT4oJI0tIPm/GLI4ph2nn2uE/zTIv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYFMKFNp7M8/z8hQOScRWjez8xi7F5QbCKGNUJ3WPC+KTQ/5b6
	GfrFfidynfSCub0N17T2qSmp5uQHKt+xgLHtxzYNXwGi41nx6uAbEQLvdpZsp5lMz1M=
X-Gm-Gg: Acq92OHoWecQYcgqnIF7lM8DJkdzYgjUFlUIIHdm0hdGbVMr8YsZlFktghRhPmIeezn
	bD9btGdhhw3AKsS4Oerf2RRZdClrZHpMbISKn6h0oGjW9XVRKPHlwxDu3VWgMPfqOCIi1fuybn5
	gpzvEjZRBCc7XlTJ4jfmk6BJRt7sVGz4erQ9VXo6ng2Ry1NtlEXHY/XzYvppBQUs0DBXOELRrWx
	1m7N4Px7cB7PQtjjLv9UbUQa56Bi+hxtJ1o0nn2LNktV08adlCVSiSjbsQPOyqm0uxcp+vvd13D
	YU18HiU78ysUaHUKHP5metmwEQwtSlLpOGg+zTQjUu0CARB9VEKm5rF+sWhTdQvRjArSz8Easb7
	LQffKvA/xfhSvisCStpnvSW1FKEGil2tMon7+hC7T+AVSWcAKp2SvjwGtbe5EPKCwOHT9TT30PR
	krAWnml+8q5F+RcZvu5FZ8lHb+FdlkofUoKMCxI8bB4qQQQOapULygWZoq6iEZ95AK
X-Received: by 2002:a05:600c:5394:b0:490:b0e0:3de2 with SMTP id 5b1f17b1804b1-490b60f9e98mr36120885e9.33.1780473041726;
        Wed, 03 Jun 2026 00:50:41 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e76feasm120928085e9.9.2026.06.03.00.50.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:50:40 -0700 (PDT)
Message-ID: <e20a2bbb-8bbe-4998-8c46-4171f35c2ab0@blackwall.org>
Date: Wed, 3 Jun 2026 10:50:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 09/11] bridge: provide lockless access to
 p->port_id
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-10-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-10-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2026 09:20, Eric Dumazet wrote:
> sysfs show_port_id() and BRCTL_GET_PORT_INFO need this.
> 
> This will be needed for upcoming RTNL avoidance in "ip link"
> dumps (cf br_port_fill_attrs()).
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_ioctl.c    | 2 +-
>   net/bridge/br_netlink.c  | 2 +-
>   net/bridge/br_stp_if.c   | 4 ++--
>   net/bridge/br_sysfs_if.c | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

