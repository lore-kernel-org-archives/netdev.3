Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AB52E7623
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153243; cv=none; b=dWON+zh7vxTjvSMaSQiazhHrvV5PgJnEFvDx4ncClFLqbTIQ5kwTO2UsDBJBnX0dcIPCHnraiIV5lNJUavE4k+ZgagP+1mWSpiKJCJxq24UPn2O47Xlc3ZDSLhl4ziOvE3M7yKjn62wMV9n9xejU6OefCeD5MDeDIZGt+kgYvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153243; c=relaxed/simple;
	bh=OUrdb62a0nMMb9QvwqqUiSHOE1kCrSnciAV7EM98XRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPMohf9NMNcWUtVy5ZyPdEyBTmJUVlC9Pc9IKgv5ZxQ0AJ5q/9PWm70zTrJc5YHZLBV976UtuHokfOf6MRtyRAOnj+YBDiUxgCXLWUrF4DjN68gWQeBwu4Q4K1NRlAv+JUWEGRM9O0ZuUgBdn+EPp58UbEIuUql2g6Q0LS3tKqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=fyrgyYRJ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="fyrgyYRJ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso5113439f8f.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 21:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781153241; x=1781758041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qwF1wQTGmK+lh339LVZG3OxMEeDguBE49+t9jEGriw=;
        b=fyrgyYRJ2UPSu4NaPkYRBRaHAclhSUFy2utGEyHOH8iZyBlrszNjfpZz0ZpOk3THmu
         3XKvqjj4SbN+jFHeWhhIxk+TMbeWu2i/Bp+OSaFr3ne2pYMNm38nGmrr/M4Nqre2zS26
         B1kgzsqQ5aw0vG0P2TX5cPs2WOz0vu1wc712b3L+77Jf2mpXahqTfmUloQDZd4Bpdy6R
         kDHPUCwFT3HESDRRvUtNCjxtkKLM6TyXB3FnKLLh3xuMg/QVUTjMecQvsawUr1dnlmCm
         26VqcwXS8t2UwPF8DgrQ9RHTu5XC9lL8KHqBm+r4L9L67W+168vCyTeIOhi+KdyCol+K
         ueQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781153241; x=1781758041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qwF1wQTGmK+lh339LVZG3OxMEeDguBE49+t9jEGriw=;
        b=oPL0OY+MG9HkjbEy6o33u7tgdvr6vUVbXZ2sVcP3+IUuohBfv62TOAQVHgwFUS19Fp
         3pc+GBplz+LkXjkWSXQj7lfqN4rWJDsT932Eom509qFdant1dSrH36F1Xo3QKsx4ZPkK
         t2qfe/ptlt/x5FmwKm+1iHsQE4RF/ZCsgkUlDsyojdKWQAuJ4GvQBLeSH+FPChyRDr18
         OOLVLR3Kk4MWiAGR91jrtc5MAgefjZS7N5RBNVPGcNGYI7FmcR/fRpzT5q4vvbgqa1o5
         Jt76B3Kb6IjbhFZHAZ4r6cucAnl+pTkrx/Ro87SQx9QPmF9vf0pg0vf8V4m+1gAqWXh0
         RtZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8iGtIqIgKU8TZCTnk1r1pn05+SeSysvh5W2F4ZQoAo2glI+gOjTqXGsHLdG4hXDRCPUOZtcTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDK1yw4OF1SbY392lh5Saxi0LJ7My2ld5SJF4LU7LiAA9kfrD
	TUuEIbvZt6Vwu732qx7TYyt8ZK9qvvc2KmBLqks6AbNpoZqEJVU7hEpG6bI66a6sl8c=
X-Gm-Gg: Acq92OFz3XXNvYJEsHUcky0OQufbd3QqgL7BWJAzuHilBskLsUgfmqzTUAT8Ws1dUU+
	HV9CBnQZNBUfV/7aeUucqhZ4vpVZvFNUtyfJXcoK/LlX0NxzsWOjOW5/VTzv+eEdJrTKAhml8Ca
	oJ+b+kLLTqTVq8zlhIEDIFb9AELiGjiFq9z9tsSqM4S1Mhki8y1J0hx2R3EIsyICT6XcM3l19Kh
	vd3V01wIAJuhgoFbyO/84pK/nTjboCYpfKUhesEznvs2GaEw61HT4SBCnxYyvTw72F7PYF/0zR7
	/w6hVMA0oTeGOalMV4yfZUXxHk/qjbUmmhvkYP61p7N5DM2CQDCKFyGBkq4e3MuUWioYMRThSHH
	vdfsVh1rJlWXn2NyuMQ5eYCIRHD2k+867zJnPfqd53Si+IA1t42dqs1KcmVqYfVHAHbq7NoZqh5
	dHqA8+vKVVoBXoN1IwCLWAzLqrCS4AjeyJMm8boCDY9LvJKim2sqciqNkS/Zgc6X+6
X-Received: by 2002:a05:6000:188e:b0:45f:f142:d55d with SMTP id ffacd0b85a97d-460677c2b22mr1381645f8f.39.1781153241104;
        Wed, 10 Jun 2026 21:47:21 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35eae5sm78772341f8f.33.2026.06.10.21.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 21:47:20 -0700 (PDT)
Message-ID: <34454750-f8e9-4954-ac7f-a8d22522c10c@blackwall.org>
Date: Thu, 11 Jun 2026 07:47:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/5] net: bridge: use atomic ops to
 read/change p->flags (I)
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260610161836.1275531-1-edumazet@google.com>
 <20260610161836.1275531-4-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260610161836.1275531-4-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/06/2026 19:18, Eric Dumazet wrote:
> Use test_bit() in net/bridge/br_arp_nd_proxy.c,
> net/bridge/br_fdb.c and net/bridge/br_forward.c.
> 
> Use READ_ONCE(p->flags) in br_recalculate_neigh_suppress_enabled()
> as we test two bits at once.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_arp_nd_proxy.c | 22 +++++++---------------
>   net/bridge/br_fdb.c          |  2 +-
>   net/bridge/br_forward.c      | 15 ++++++++-------
>   3 files changed, 16 insertions(+), 23 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

