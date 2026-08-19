Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE673DDDBC
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787128535; cv=none; b=VSx8YR93B5Lc4vvycmIoaHN+D9Zjj9HXRmhXOM/xF6OI48ZjGjCo3K6qApw1w2ELmEIUYxA941exWSUeYpVf7D0a7MKq+UutKoTd6FHodtPxXn8Rc71yGIuxn9N3VnHkPTOCuz25Uyu9c8keQ5VXI/qn9xNdJutqBzAe+81vSnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787128535; c=relaxed/simple;
	bh=lpQQmxTDsK3Yh1ylUB1lp+y7xpJ0X5iJF2Sw0jOAwPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1wYaCH39/D1Anui3/U3anDMhzpCr6K/ixJmhmekZ+y+ksXRWBXlKav0dGKRnAthr79NurQjCi5p4SP5qm/Wtzyug2gAyTxqC2uBEfG1I95EcaGAfRtDMiPJ3IjU1T6QzkTE/4yAfOoZVX3ohbuMIdWUFcAe9KpuxLQccG/R67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=VBnRgE9W; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="VBnRgE9W"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so7718055e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 01:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787128532; x=1787733332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UaQjGKx5D7JBs1VdBUikHnCA2EKV7k9U1yTmwx36B/s=;
        b=VBnRgE9WUwwCS+zYFN2dTfu6cVRVD4voKoaXCzU9sM/9v29vTSJcTryyhIjTeVMqt0
         0Uflt0J+28M8GJHhERgCiJqdr1PP7MHu0i+RmwbnDhOLsk20htYq9ipr4PowUmNeMlno
         ymITCrRPs4DTCixLlNbQBYDrhNGRi+Uj3d8Z/bi+c2tS4Bhn67Yk3PPgDK5a+1EpBgWF
         LNoCh1pkRK5TWdxS1/k11EQUSLpGiz+4wEhLVqJ6dEvOLV1AzO0pvAay+IvXuwqt5Utz
         CeBPqXDxby8VLPjnu8erhC4N1VGSdja0Fe/RwfA1VRZUIprL16EU51COivxh5hqBS/Sz
         yr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787128532; x=1787733332;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UaQjGKx5D7JBs1VdBUikHnCA2EKV7k9U1yTmwx36B/s=;
        b=LKj56cqPkHq3NkCZyefb/7WszLjRp9WyuTF3ZOV6voXsHNi0Eh7md8RrxdqgLnspG9
         tF8bBet0oXDmBQkplTJNzj0qMjjFLWexj6kP4GL+g56fKH7iumU84Nz22FyV1929xihf
         DYWIN0fqy+jUDYVNn+m1nLs83WpBBAs1oAs+ENRZ8mQI9vW2XxFj9bZkOnSDpvajhwL5
         SOKRtfbN/ls8H0crXKTkXmGOXwKq93doTOM9v4+2zcSVwmQjscme0AKwEEePob3Sg5WS
         V9kmXwxEVFN5eztk5/GGNS4O/mwFkYtMN3UMLt6kM4FcK4B2p3j2CDtgzJM1qk2hnJ+H
         9KDA==
X-Forwarded-Encrypted: i=1; AHgh+Rrf8csbfz2ZFWsp1fSUdOwRBcF5L+oREw9CSytdPwZfRe9Q+JDJGg3uyNle40lo367wSw1axZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQMrRO3gTjkW0hRbJ04P6SOq3MSCqHA+DrW6hr2ry/6dlHrYQ
	j0BL8jAWlQZJ8ma37Awt8zUjdE/lRSNPa/E5fvoyMJJliBURSukbeRe1Lkac/UOuZfA=
X-Gm-Gg: AR+sD12dQP+RQZE2Ugh3z8vuyJKZDaKyEGYeMWuAknlzLy5z/wBYsUT8PU0KFd1eHiE
	VxIjfukOHyhLI0NykjQWF32Xtd6eMg3WAdHcvuAJhFDpcgdQvusJQ3GM+4Fm57Op5MgrC2Pc6KX
	Q1uJXSipVzLIsm7cFmpGLuzzVviLbfRlQH2wIpCXWCIgmcqG1X+Ygn9DOMKgGDiLRs4BFklof/W
	1y9n0+K2VcLlg/XxF/UH6eG7cNxaEGBo8vUNLCteZrKYc4FjjYjBBlkKphKHFyOWAgQV9OUvfLm
	v1xbEldrGFmfy+tw5xeYYJoTbxtMSesq9hp1SBmw2fW5orFFp+xSXxgPguGzLuufCsF13q/Tkp3
	XRBONyslkoj9Bu+hGUB+uT22EpfJIXqyLx1L0uuBF9MJUZzc9/fipS7Ar59kSQRvHhzGRqQXpy0
	v/iA2nvr2c1DY7+Dwqp/1vDwjxM70V/UAo0okXMsTaIcrpLeREq8as0NPUyqEfXUP70gIrVknrf
	U4l6GprQf81x7N4ySc=
X-Received: by 2002:a05:600c:6990:b0:499:900c:9c69 with SMTP id 5b1f17b1804b1-499aa1ba0acmr52580625e9.9.1787128532150;
        Wed, 19 Aug 2026 01:35:32 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0dd620sm40297395e9.13.2026.08.19.01.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 01:35:31 -0700 (PDT)
Message-ID: <1ebd9c8a-5b7e-4ebb-9c7d-5b2b2fe4a675@blackwall.org>
Date: Wed, 19 Aug 2026 11:35:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] bonding: fix u32 overflow in compute_gap()
Content-Language: en-US, bg
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260818-bond_overflow-v3-0-e05d4dbc2fd8@kylinos.cn>
 <20260818-bond_overflow-v3-2-e05d4dbc2fd8@kylinos.cn>
 <d75e0db1-e129-4a9f-a103-889827948de1@blackwall.org>
 <80d704a8-aca6-44f8-8933-eb0cf14ecf3b@blackwall.org>
 <bf56ea5d-a0d2-40f9-b8d5-73d8c54ca32b@blackwall.org>
 <aoUP0sLeEhCPxukB@fedora> <aoUQdublxcfZzqzE@fedora>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aoUQdublxcfZzqzE@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2026 05:09, Hangbin Liu wrote:
> On Wed, Aug 19, 2026 at 10:07:22AM +0800, Hangbin Liu wrote:
>>>>> ... this here, as u64_stats_update_begin doesn't provide exclusive access, so writers
>>>>> must do that themselves, so you can't be sure what value will end up, the zeroing
>>>>> might not work at all and can get overwritten
>>>>>
>>>>
>>>> I meant - it doesn't improve on the current situation where it can also happen. :)
>>
>> Ah, yes. I forgot this. The reset_unbalanced_load() could be called on any
>> CPU, which conflicts with other writers.
>>
>> I re-checked the code. unbalanced_load is only called in two situations:
>> 1. To rebalance the load in bond_alb_monitor(), which only executes once
>>     every 10 seconds.
>> 2. !tx_slave in bond_do_alb_xmit(), which is only for multicast/broadcast
>>     traffic. This traffic shouldn't be significant.
>>
>> So looks using spin_lock here is acceptable. What do you think?
> 
> I mean, drop the per-CPU design directly and use spin_lock to protect the data.
> 
> Hangbin

hmm why don't you change the way the reset is done? *untested* but in theory
you could just record the values at a reset "moment" in reset unbalanced and
just use the delta, so it becomes a reader and there is only 1 writer left (tx).
Keep the counters only increasing (important), only record a snapshot at a reset
moment, count current total bytes (sum all per-cpu data), decrement the previous
total from it and use that as the "interval bytes" to div.

Cheers,
  Nik

