Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715039448F
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420491; cv=none; b=QqJTs3GNt85BYA/p7Ti+YIbNngKgiHm353RaTauasjHl8AN0vZS9LIcvs+ytw0Ysfi4HUqU4H+3KBkJhuQ5Wc2ZSDKkiDCr4jI2P4HAtzb1F/jyErB/YLueOlu7N3watg5ZPIKl05TtpYzu+wW77jeO35rvGS8o+8NSzEn6nx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420491; c=relaxed/simple;
	bh=5N23kZg17Uv7Cz4yV45WfpYVVL69fausX5a9IS5rPSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJbv15MidNKlWGinQX9L8AoxmkblNuDVfq4PzS5yv5jsoztK8Iezlo3RGn+aQLnNckUpM8Ui1K+ZijuwBV4npjWD1R4dKyiC4NvXOVHyGpCG/JOTUd8tS2bX1nZP3r9i4u9HemkrV5tXEbj3kIC/xPaEvbBwjmyiKA5yjTe2zdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LQTKlVMQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LQTKlVMQ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48433fad54aso1297944f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 00:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788420488; x=1789025288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FeZeHnjIdwq+MQ17MHHapFhQUcjm9i7LeAcv2NoV3wM=;
        b=LQTKlVMQ9JPxLU9HfUh2CsHOkWUUwFRdlOw0KIYKf4pBH7pV3vs7r6+IuhltcL2lv3
         gUF13/3g1k5GbaPtFm3vGHMvV7ExfweeumCXdshE7/HIxQN/QPEL28inXiT9s5UAsyr9
         6vn5kRi91Ql2+3MeihV37cixKI/pdUTiA5XwHsNgHc4k2gg4itgtt4OIAbFEzeizZW9q
         DsMaPgZTXmmgtEzIwchEQVjtuR3AZxgR7EkGXQ9VdZUvPiCr+a17l5VAv01UGhIpHLtu
         N0FFjY6NBNgKGNukgu+y0SauaxoP+QcgVFe6Nh+70IG5v9wTEuxlM9Loc2gFihUCo6Px
         ZZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788420488; x=1789025288;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FeZeHnjIdwq+MQ17MHHapFhQUcjm9i7LeAcv2NoV3wM=;
        b=AEufqZQHpvChFcF5eHKfg4eCVEjeONqzeiy9Nbi+30wHHP4dFPWuFFzS29nLiK6+Sy
         wAyXUqshz6Gb4qeRA4KW7y//tBmIRV4jpvkx52u7TzcvEZubXVxeD7h8Hg8lBfE/7weu
         i5nspJHMXjfhcKLPckGJEuVVpr7v3UQqjKQIPccUAFyXoY1ifLiMusCGt95md9rveXUl
         P5Jh+IqU47RfL9pw5zQycy6vLSLYd03C5u/2gkVV6dQAI9W95fXEk1CIkQ3Skqe4HHQj
         3Xa8P9t0mV4i5SQOqyPyFZu2l5+SMjau9pVXvsrbDZkPojwRC+nTtlk20IWPDeiCBSQJ
         pT+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzigaF9Ki1cFLiAkiFVW/YcFXo6mODLmk3jRr/7IEtMeCp917xPRIBcW4N2VH/sbIeleEqppmY=@vger.kernel.org
X-Gm-Message-State: AFuF++nUYyBjt0LtmSS6UxRUceo4fCv6mhnL1c89KEJgCfoD6dBXPZfi
	SREOuXQHLyvcYfP2g0XuaZqg6UlVDKgj1zSicoJswyCH2o2qiO/1mpwmUn/2LhSKJWA=
X-Gm-Gg: AYBFou2BqIN36A8y2xpyTeeqfZqB0aozvWrLtK6SgySRktO7NKB+hBfV+VthRVIsplZ
	EDMKgy40OWSyNyCR+RziPXV0SRE0M24rPU6ik59k+lKvh455sdqkP8VDxcsIwfbLMe6aYohJXNd
	x8W+pgl+rW1wE0Mga9bB3UwmN64xqGX5PLxleCd17u77ts4j8TG9V8yChsKEF8gxaKQXgm6/323
	uuz+UBGvaFw+tqDN4JpvtaR1hBnCvUNtBFdmYU29IfkxXibgfj5r0jbJrizZ5lHG3pMlyRKjx8y
	BCnaShAHaKGfovawe1j+TP+SLbnUXVEm6h5JX3w1q9mBlaiF9+VW7UfLM9ShmpJMmry+2cdVWMv
	WTjlSYnWeBS1Y5MSvkkw0VVT7m6hDWOf/M6RNhWsrh95UvrElB1qdJQNkbIh2y1TDgz5rLXqhan
	oF4SnTYO8nARONlWRs07wThcYSr+YXq2al0HRofB5rWyo4TVEEVywREmV0ucIxykH65qQBOSV8j
	SSK5ZDPtRitQ7DDqVXFQPnT3HbMBA==
X-Received: by 2002:a05:6000:491a:b0:482:ea08:8c97 with SMTP id ffacd0b85a97d-48488e0392dmr19224377f8f.2.1788420487735;
        Thu, 03 Sep 2026 00:28:07 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cf550sm11790785f8f.37.2026.09.03.00.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 00:28:07 -0700 (PDT)
Message-ID: <238aa513-0c61-4b84-8305-a46d9b527467@blackwall.org>
Date: Thu, 3 Sep 2026 10:28:05 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/1] net: bridge: use option bits for CFM/MRP frame
 handlers
Content-Language: en-US, bg
To: Zhiling Zou <zhilinz@nebusec.ai>, bridge@lists.linux.dev,
 netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, henrik.bjoernlund@microchip.com,
 horatiu.vultur@microchip.com, vega@nebusec.ai, zylzyl2333@gmail.com
References: <cover.1788417901.git.zhilinz@nebusec.ai>
 <0345b9d5aa60ba416f6738ff1b87140f0a749cb8.1788417901.git.zhilinz@nebusec.ai>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <0345b9d5aa60ba416f6738ff1b87140f0a749cb8.1788417901.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2026 09:56, Zhiling Zou wrote:
> CFM and MRP register a global br_frame_type whose hlist_node is linked
> into the per-bridge frame_type_list when the first MEP/MRP instance is
> created. Enabling the protocol on multiple bridges therefore inserts the
> same node into multiple lists. Unregistering it on one bridge then
> corrupts list state belonging to another.
> 
> These handlers can only be installed once per bridge, and they are
> uncommon. Track their per-bridge enable state with net_bridge option
> bits, which already live on the Rx hot cache line, and dispatch the
> matching handler directly from the receive path. Check both bits
> together first as an unlikely case.
> 
> Remove the generic frame_type_list and br_frame_type helpers, which
> have had no other users since CFM and MRP were added. That shrinks
> struct net_bridge by 8 bytes and drops the list walk from the fast
> path. When neither protocol is compiled in, BR_CFM_MRP_OPTS is 0 and
> the compiler prunes the branch.
> 
> Fixes: 90c628dd47ff ("net: bridge: extend the process of special frames")
> Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. CCM frame RX added.")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
> Co-developed-by: Yilin Zhu <zylzyl2333@gmail.com>
> Signed-off-by: Yilin Zhu <zylzyl2333@gmail.com>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v3:
> - Always define BR_CFM_MRP_OPTS and keep the fast-path check
>    unconditional. Read br->options with READ_ONCE().
> - Drop CONFIG ifdefs around CFM/MRP dispatch. Provide header no-ops when
>    the protocols are not compiled in so the compiler can prune them.
> - v2 Link: https://lore.kernel.org/all/a43fdd12ad2fbb708c090dc4ead60f3e4aa8c0ac.1788159904.git.zhilinz@nebusec.ai/
> 
> changes in v2:
>    - Replace the per-bridge br_frame_type object with net_bridge option
>      bits.
>    - Dispatch CFM/MRP handlers from the receive path. Check both option
>      bits together first as an unlikely case.
>    - Cover MRP, which has the same shared hlist_node bug.
>    - Remove frame_type_list so CFM/MRP do not affect the fast path when
>      they are disabled in .config.
>    - v1 Link: https://lore.kernel.org/all/7198fe2845c30c60c6b3833dd78cead8c5966931.1778378864.git.zylzyl2333@gmail.com/
> 
>   net/bridge/br_cfm.c     | 11 +++--------
>   net/bridge/br_device.c  |  1 -
>   net/bridge/br_input.c   | 35 ++++++++++++++---------------------
>   net/bridge/br_mrp.c     | 13 +++----------
>   net/bridge/br_private.h | 26 +++++++++++++++-----------
>   5 files changed, 35 insertions(+), 51 deletions(-)
> 

Thank you for following up on this, the patch looks good to me.
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

