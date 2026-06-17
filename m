Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74839937B
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693563; cv=none; b=BG54z5hqb0Y3jCkV/P+BN9HkGhY3ScJgxBW1s3kM0Nn5ppuPQhmyTMPnqC8wI97QW2uyTClTGj2XcqXb32zW7cEbZ9IzusBrDAb4kFtCc+dyVJUQEpdScGINZ12T6m8tZqlo/BnrqwDQCC3/B7E3K6G0ZZiAn3cTVXAEggJKR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693563; c=relaxed/simple;
	bh=YyY9jpsaNKXS75fvwj7TUag8j0cDsR9U8p1z1R9Co0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k21k6n4LwnWVjGXYRW13FUM69eOOQLBMYS67cUR1B6jFywScy1pRgrQ43lZKw15DhtvR26uCPM/EMRfITRb0lufOYXuLW4R6g/qP+w39nJE1u7O1EEJpz6ASVXEYD+3e/q6k4GCAPbkis011VNR1E1CtI7KXIFl5+Y1+Uw1GU0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hdOs7TMU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hdOs7TMU"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-460662fcb4eso3838873f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 03:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781693560; x=1782298360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1MmTo75fpeFQ+PCFh9LTD6RH5j2yjpo9VnUV/TR6SfA=;
        b=hdOs7TMUbvJx7ASYvX3P2upTDHgvzbf/FrUHJ0sQK078GNT2m+J7YouQ4rYmjnENv5
         y5w2fNJAig0RLyHFduyMIJvW1qIjYasDXPxsUyDmR3DNvKcai7M7jPwzmR88KLez6kjN
         GmbZJmmweQe0pdN/u1G2aRUOlnu6jD4HSdQEFaFu6wHDhI0PHm/MYzyPCTrRZFvbFVY+
         tvRBv1VZNtjxKjjIlEYzC1mhEfFrg/bBbQtalbv8UazN+0O6bY4Aar+yPUZru3eCG4R/
         q8A5CDYBqzLJY+xtUTPzfhfEReZbNHIlZ+tSEBTLyRt0NDdsSRllq69Ee+VcpNen6Nat
         FdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693560; x=1782298360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MmTo75fpeFQ+PCFh9LTD6RH5j2yjpo9VnUV/TR6SfA=;
        b=D88htaDmE5XYuFgMe9nPMZT6ko5DBzzQmLgAlEDeFC5dK0lYKm45ut28CTZrd4d0b6
         YjrZbPM429TK/pofBgG19e95KOYk16H+LnQcLw2/MrTw1jP2gFqSXW8TEXGBmWwgryO0
         FJNpaJo2nkbz6d7xTvMmjZe6e0eeuOrCubZs/cet3Lkmo1+OslcdTtJkV8T0PvL5HoDW
         rUtbcip18YyFnA9PczgCpTj3FkBWHyvdB2intyk8gh2iogC0Zlm4maSaHfzkIqdKWGhy
         G6vPMmrwQhoOoNK988NwezxFvmTg9BP5dIMlAi8MX6XMvg+Jlxzk+OigP3pnpHXIDXsp
         55RA==
X-Forwarded-Encrypted: i=1; AFNElJ+o/UBlQC4tJFKSC8XWTeTvMcohIaTg9Msk90O6qQTerc+22SY75tkS0sUPrGkHrrK681Rm3+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHnHHM+rJmTNt5reXZd2ATWub65co2bfsQrvfO1TPeZfdoSlc4
	7TA9Dii3sS+5VpBsnzjRJb7MQhVjSfSQ6KBWBoskOGJ5uC0UaRo3brTO0Q7OIgpxmLo=
X-Gm-Gg: Acq92OH1gis8vT+Xkcls6qOFS6ie3lxVSU843tnxYMu3iOISUo8vMv0EdsMMp6MfItm
	S+oqbVYIffCyWCosurKqsnLX8HBKWdXfyCp3UikLB4IxJSiZwshyf1eAEBRS1/6I+o6cDA3djuZ
	/1KdwvvJlP8N8GS2Qt3cGX4pfLMK1Umk9QZ60sFv7J0rUh0iuLXB9lD4e+tXezllWaenx8f5g8p
	B+qvrPemGc66foMPFFVSP2qubK+H44Q7oxEQNNqjlfJ+70EAm4g8ZtCgEGVu6C4Vv6siJWTq3tR
	LNlv0Zixr2hlolsSLL6h8hWN3Yb4EfBOtb8JkU3pU+67QLeDOxo++tRG7meQpIpvNKNOz5h69+Z
	1+4uXX45oHxRSHKsuyN4XH+GNzhkSV23LnEGbr1LFHv2mrivkyqHpbCZDDOd8+ADNN73uDUJ3st
	rmrsQxbLfPmRaelpmCwjZJWniNLb526A4auvtM222aAe0=
X-Received: by 2002:a05:600c:580e:b0:490:b724:507d with SMTP id 5b1f17b1804b1-492333f649dmr37228715e9.11.1781693560228;
        Wed, 17 Jun 2026 03:52:40 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a96d14sm134993295e9.12.2026.06.17.03.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 03:52:39 -0700 (PDT)
Message-ID: <00549bee-3257-4d1b-b42d-bd92ea56f44f@blackwall.org>
Date: Wed, 17 Jun 2026 13:52:38 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: vlan_bridge_binding: Fix flaky operational
 state check
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, horms@kernel.org
References: <20260617104323.1069457-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260617104323.1069457-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/06/2026 13:43, Ido Schimmel wrote:
> check_operstate() busy waits for up to one second for the operational
> state to change to the expected state. This is not enough since carrier
> loss events can be delayed by the kernel for up to one second (see
> __linkwatch_run_queue()), leading to sporadic failures.
> 
> Fix by increasing the busy wait period to two seconds.
> 
> Fixes: dca12e9ab760 ("selftests: net: Add a VLAN bridge binding selftest")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20260616092733.3a31be4d@kernel.org/
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   tools/testing/selftests/net/vlan_bridge_binding.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
> index e8c02c64e03a..d04caa14202d 100755
> --- a/tools/testing/selftests/net/vlan_bridge_binding.sh
> +++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
> @@ -64,7 +64,7 @@ check_operstate()
>   	local expect=$1; shift
>   	local operstate
>   
> -	operstate=$(busywait 1000 \
> +	operstate=$(busywait 2000 \
>   			operstate_is "$dev" "$expect")
>   	check_err $? "Got operstate of $operstate, expected $expect"
>   }

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

