Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B5285CA2
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680240; cv=none; b=Uy72NT7/AicEgQFPf742nOhjv0nrxEdZkNfuM7zYxP1doCWOD7ZJIwS66ix8pFki7DMgm6MedBLXN2ZFos4ZyTAVgC7QjOsXF85I1YSIw5tTFAwaUBxvGt4zUrJc1CSF+cNQ/a9+fRo/YmQ/XG4q42q0PzZ70x0e+wnyMmJfQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680240; c=relaxed/simple;
	bh=hfjcWNuJUVEJgqQCxmPLiTB7SL/cK6kL9Nls1Qqn6KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFCDbf1A3W3702m/0kyAO2WpKyV6ysDcNdfAiQwHkhpYDoTNkuClcqrQAsewOLZOUgdHe5aI1ahMXkcgDqMF+YIY1Fqd6zPADHzRTqjtbrFdrohoNbPl8BQRIbs9k0x7oYLgjRtla9j5/Ami4YL8lXY4doc4eEztDJc23qiaMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=hKSnQ4ty; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="hKSnQ4ty"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486ff201041so26162665e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680238; x=1775285038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kQRyCKnELyMmPKJqIMqI/mkrkiIt4Ei/tLsOxy9g7BY=;
        b=hKSnQ4tyaUn0tXkkZotY6KjUC1Xjd8tzYC1nrGGA11w+6PmHuYcT7D+ZHZOUayKdzb
         G/JQpffWu+V5VX++woK3gdD0MtT5AdL0gbrH1wjm7R7Zx4dBgeRP8ORNBinXc56GBCuN
         KbGYHPe1SQuh8hcCpwsjO5+WKREfRFI0bGUCO+DmEYlWbi9IJqPTIkW119Sy0yLMK4tS
         ZcUkq7lswp3NP2i0VaAQlK2gptg2O3ermjO+l0G4Rd63dENR1OjmwqPrmyCYi8Y03DUW
         M7ADCCVb/voPgcnIisVpunvLJcV6OBvfGmwZVFtCk6eOh+oHjsy9uw/Crle60MqZdzom
         ThWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680238; x=1775285038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQRyCKnELyMmPKJqIMqI/mkrkiIt4Ei/tLsOxy9g7BY=;
        b=iTDf/YBqM7HdngXbBSwjl/49DILYcgjLTrRvuTXVUXPll8CvwKxBGHthyQD0gQdYbl
         e6oGdcQ5w+4jGDa/ThuXzXarj/5GZ/27h8vU7SD27z2VQGU19xbPelhgIfceM8wM/a13
         Z/BhbIFQrm0c5Ehmxk+IKj4WhF906lnjKEbuinpo0YiVGGpa8yPm8eSAXgY0c67rHi6u
         r2ovLIvYmLkykwB7n39RBGptMMjkL4GhT2BNI9PwjJfdqyvdWaiBoQBGWpaOEyQUBz25
         gPIlnhCxR97QHNbrmPTIo/FJORARP0OuGMvRo5DXp1coC2zR/pv6CzomlgIKx/uME2/0
         9H9g==
X-Forwarded-Encrypted: i=1; AJvYcCVZ0K2OQXCFW1qba0xworBg2pfPgAnvMP96mxC0iQ3g/O1p86KYMmlBuCd04ofAqVttaidaG+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3EUJ2Xg4n4SaZVoeClz4icMHAtl8teortrpQZDVFc/VIDpO9
	CeGBD9gpZF2otT69Qq4c3+aUqdrl9H7GQKpNJzqQeeUdbYAwk4PRTYhRiEIQ6kS9/eo=
X-Gm-Gg: ATEYQzzBzPZdJhiDdD9uTurXMvCvGV6HVtQDogQPQk1Jvof5Tde6cksyGuNjErTJOMd
	4E+FOqWHG3frT+w2Ox11wW91yUNUhB/XdZ1mF7iP4dqYeX4yA0TgnAE0+nU1R42eDDuVv/6PjOr
	jv5HgceEwL/rhL5D27dd7cwMN7nS/A7AbaULD8Of+cUDIEvGclPl8GGdWa1CFglvgS8guMqpz9d
	tXFW74qAnL1P+jCAFcuT1HeyIfd6HBhJjyu+883d4h24dKsVge/QlZ/IqyLg3Bqrg3dL9f792nb
	UgUts3cFIsSkzD+vSXCcMWRcZBEGIJXKbh92AFwwXwHAT6Uaj/g9vjV+OE7+lTF+XVsqUcn2YfE
	s9QcgCOGQhNG0PZdiTHULBLVynS+jHGF8/yyr3+tkQi5hzEHBs5le+85Pok9HMENmt3fVECUtI2
	nXTBJZ5k5BSGzEoBPSgByIKT5dXCy5aAKXQP0euKq94P/4lwHtsvEZ0A==
X-Received: by 2002:a05:600c:154c:b0:480:2521:4d92 with SMTP id 5b1f17b1804b1-48727ede0admr86897515e9.24.1774680237838;
        Fri, 27 Mar 2026 23:43:57 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4873069961esm28205305e9.12.2026.03.27.23.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:43:57 -0700 (PDT)
Message-ID: <edad225a-79cc-42de-a771-b1ea6d430ef7@blackwall.org>
Date: Sat, 28 Mar 2026 08:43:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] bridge: mrp: reject zero test interval to avoid
 OOM panic
To: Xiang Mei <xmei5@asu.edu>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, horms@kernel.org, kuba@kernel.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, bestswngs@gmail.com
References: <20260328063000.1845376-1-xmei5@asu.edu>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260328063000.1845376-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/03/2026 08:30, Xiang Mei wrote:
> br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> interval value from netlink without validation. When interval is 0,
> usecs_to_jiffies(0) yields 0, causing the delayed work
> (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> itself with zero delay. This creates a tight loop on system_percpu_wq
> that allocates and transmits MRP test frames at maximum rate, exhausting
> all system memory and causing a kernel panic via OOM deadlock.
> 
> The same zero-interval issue applies to br_mrp_start_in_test_parse()
> for interconnect test frames.
> 
> Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
> IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
> IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
> netlink attribute parsing layer before the value ever reaches the
> workqueue scheduling code. This is consistent with how other bridge
> subsystems (br_fdb, br_mst) enforce range constraints on netlink
> attributes.
> 
> Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
> Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for configuring MRP interconnect")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>   net/bridge/br_mrp_netlink.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> index ce6f63c77cc0..86f0e75d6e34 100644
> --- a/net/bridge/br_mrp_netlink.c
> +++ b/net/bridge/br_mrp_netlink.c
> @@ -196,7 +196,7 @@ static const struct nla_policy
>   br_mrp_start_test_policy[IFLA_BRIDGE_MRP_START_TEST_MAX + 1] = {
>   	[IFLA_BRIDGE_MRP_START_TEST_UNSPEC]	= { .type = NLA_REJECT },
>   	[IFLA_BRIDGE_MRP_START_TEST_RING_ID]	= { .type = NLA_U32 },
> -	[IFLA_BRIDGE_MRP_START_TEST_INTERVAL]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_START_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
>   	[IFLA_BRIDGE_MRP_START_TEST_MAX_MISS]	= { .type = NLA_U32 },
>   	[IFLA_BRIDGE_MRP_START_TEST_PERIOD]	= { .type = NLA_U32 },
>   	[IFLA_BRIDGE_MRP_START_TEST_MONITOR]	= { .type = NLA_U32 },
> @@ -316,7 +316,7 @@ static const struct nla_policy
>   br_mrp_start_in_test_policy[IFLA_BRIDGE_MRP_START_IN_TEST_MAX + 1] = {
>   	[IFLA_BRIDGE_MRP_START_IN_TEST_UNSPEC]	= { .type = NLA_REJECT },
>   	[IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]	= { .type = NLA_U32 },
> -	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= { .type = NLA_U32 },
> +	[IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]	= NLA_POLICY_MIN(NLA_U32, 1),
>   	[IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS]	= { .type = NLA_U32 },
>   	[IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]	= { .type = NLA_U32 },
>   };

Alright, let's limit them :-)

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

