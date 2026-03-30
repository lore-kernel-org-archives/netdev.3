Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24053A8FF6
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857563; cv=none; b=bArcT96oKO7ONEZeDpt2AdYgHVB3gdrsQWHGXoPV4gEVk1HcK8Bdmcnw4fpFgAbppc5p1jKUkt+Eox5E2uKQdpMs7Xg0gThzUlLAnZIdTC3TC7f4bzgqth1bo1j1lIcF0gpTjxAJ/sXTuCOdbgJ9XWeRpuzoQrkY2jjqRmCHGSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857563; c=relaxed/simple;
	bh=k6JUuhq42SSwIgVxyv7fWCOM8fhm0hvAp+G2ZzzZ9Ko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdukylnOYlKLwoTllXh91dTdKzPzfnmzrvTsf63hk77+5CZjzMLzzFN5jzGb8FLBvwYaIT5VeoWmpEf4rRxqhKuxgB4LgYsUZx0g8CBs5vZHpp/nKiu7iBIjp4u6/QswLt9xkB3GMTwc1VwfnRmWwam8pQ6WDdqcSufOXgNEilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=0mCZxl4Z; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="0mCZxl4Z"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439d8df7620so2923332f8f.0
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 00:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1774857560; x=1775462360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y35FqnBB++fiJjPiIxMgwhz88Bst+PlLvtoiYEI+bUs=;
        b=0mCZxl4ZaqKtIpnZGqEQ/DTXTNdGzumdnUuwy4ECpbYFzp79oePxMBMjhfMZKON8K1
         uH6ncjMNkKFKWZ40QBrVeud9U1BdtRiMTBUWrobZ20WkG6aErtq/PK4LbsGoF3wurl89
         ZAceDXXBU03MAvQ3+6aUJ2zyeVQ7N+BrbV1MxW2W4fIHIPi+kbmb+PXVDtWHot9yx1ts
         cjqypIYuJu585odUccCwFOPEgyCuSYObisUY6oGM7bNI10a4dnR8ytNjuzJuqKWpPDBE
         CL9wBUHkfeIH0uuKitwnZYBOP6iC6zickBdd2HiepwXDjo6JLMooAvlnNIMtHiTzqdKJ
         jokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774857560; x=1775462360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y35FqnBB++fiJjPiIxMgwhz88Bst+PlLvtoiYEI+bUs=;
        b=Q3jZ8mITBqxYY6yU0IL9qVfbYxuJSBmD5u8nORt49BXqN0FXCb2F+JibVQAL5OuX9q
         2VMnz68Kx+i+qosu+fIYNc2JYfhD1xGnuYgs/UpYXV+R5lbQEVKf95EilXWtCQIO8dSk
         DbecgLne7IRV48L9St/63KET8pUzPSkJmar0uN6/ZCA6uj9epnMjdK25dBQ1vMEfYSGs
         I+vzvom8s45dMIrhnPvHyuv8JJaJz7C5rS3uoRPmQgAR13wASoVzwCEC9RCSy5Lr8fxD
         oSQdtN0fjiOkfQLhJcXeB9812CCDDMOkok//61H81xFcrjc8gSIXym6EjSkrUtUJoUTs
         cpjg==
X-Gm-Message-State: AOJu0YyIZ8dIJssIZFFBPNg+qpkraim9b5kCj0dt8tMbL8VmUFK0BQf+
	Ne3J2Xrywtwe58QYntxNDaEnXvn/gq7ftfBaOLWJ+JZKpOWd2w8KvjuINtbli0PJVsw=
X-Gm-Gg: ATEYQzxNLlHd5i7v2dpKRMxVePtKEf6hvmcx2Nkj9Poe7rHT0yaC5KPiBb1o0bPPdUo
	T6xt5Lu0Irl2bkTCmy9KQ+jKIYiGJALj0U2ZxkpXi/Mb3OoLBOBNV9TY9L1xQl5ofBZOLpdg5AB
	nYs08haNfCv4eWjA9l46Yag1PC/f/3zbtI0rHUvh9WjWNqrEIb6m7GdnqAVhD/5c9t/1qxYWyaL
	mO9NzHufhesYltqeYRkdiO1xyybl+UCgsJHXwF9ixdJYJV+eewZAhlIi6r0sKeRoeBoJDQZqNDY
	xdDAVhPCeA/KtKbwYMe2PeUa+icBQUjZZj7b4no9NsvAwxYCPXGwsNmy3rVTuHICNXIGQ+XNuLy
	A5EhjwrVzFrlVYXKlt+vYc9MzglJohY6UHN7DwbT1s/xibtaiofaG3ugH+mAbbZT8o5pssfHJX5
	7neeWUSbM9PIIHxJJ2h/XkDw1y/jqf+g+lthgfqK0NpRXYj21L
X-Received: by 2002:a05:6000:2f8a:b0:43b:47ee:4586 with SMTP id ffacd0b85a97d-43b9ea4aac1mr18960326f8f.29.1774857560274;
        Mon, 30 Mar 2026 00:59:20 -0700 (PDT)
Received: from ?IPV6:2a02:810a:b98:a000::ae46? ([2a02:810a:b98:a000::ae46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21eb95fsm18840598f8f.12.2026.03.30.00.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 00:59:19 -0700 (PDT)
Message-ID: <5cf41f14-e694-4b06-8b82-1d98238758d4@cogentembedded.com>
Date: Mon, 30 Mar 2026 09:59:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: renesas: rswitch: Fix memory leak in
 rswitch_phy_device_init()
To: Ma Ke <make24@iscas.ac.cn>, yoshihiro.shimoda.uh@renesas.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, niklas.soderlund+renesas@ragnatech.se,
 michael.dege@renesas.com, yury.norov@gmail.com, geert+renesas@glider.be
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260330073541.2871414-1-make24@iscas.ac.cn>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <20260330073541.2871414-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> -	phydev = of_phy_find_device(phy);
> -	if (!phydev)
> +	tmp_phydev = of_phy_find_device(phy);
> +	if (!tmp_phydev)
>   		goto out;
> -	__set_bit(rdev->etha->phy_interface, phydev->host_interfaces);
> +	__set_bit(rdev->etha->phy_interface, tmp_phydev->host_interfaces);
>   	phydev->mac_managed_pm = true;

shall be tmp_phydev ?
