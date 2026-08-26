Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0333B0ADC
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729657; cv=none; b=ZMrG33EBfZP6qHHAJAlKRPI96kMK+1Cj/oHud/N2m7v5SsWwJhTjoMcx1lPvcorzy0XjFmvAKuE/AfBt8T4nmOLWxxR7RTU/q3kszOpRNvalO6ZwmcoEjZa+FB3JDzK+JsR1kX/8VZJbHDrGidtOmKgARgZc3AdHdW5Q/w/o8tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729657; c=relaxed/simple;
	bh=crT3oVnhlOSF8MK4A9QTRjuu+YdP5f/ggkya5OL7ebA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qThPWBGk7ujysNdmXCpzPyRFEYWfoCpUznTX7/4Kf14GLQi/0j+p8d9KLpGwd49jmfkRseZ9zmcNVVAb+h86WnbMDvg3eUiZPStWehfAvy6mY9w1eD7cIqSEisRQBHp3di9xOTcsS5MAmU1zH7IKNiT8o5X839Hg2e34PJUO9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=XU3PsAos; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="XU3PsAos"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c197eaaab00so99696966b.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 00:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787729653; x=1788334453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oyoB92oafE8TgjnoFJos6/bCIEhx3ezLRECkRzRrBIg=;
        b=XU3PsAosE5fBX3sHeVQZn8CwfdK+PkK6T2kJyH/ncI+7zNk3XAucPm45eB3TcJGb53
         3H8PkVWFkg91Oawy/bz3F0UjpeOVsssPpbbJaRpUpj39bP5yM032jznzaE8DJ5gPOE+H
         f3+Farh2AIS56LX+FSp2n8/16B187/oI45VPGhyXBb7/rCFi7c8LUiwKgO3+pJrcQ1Z3
         D0qh6AQJXkm+sGM+OWW4z17smKEGDJc47kvwx1rT7mqMm7kye536d4QBRHn+HYRVxAY7
         cdKVEyKvfpOw+a/tNF8cdC6Y1HVv+NCOrqxxCv788+v6V1eHr3Aedkh85dB/Uyb7allk
         ZXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787729653; x=1788334453;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oyoB92oafE8TgjnoFJos6/bCIEhx3ezLRECkRzRrBIg=;
        b=Y1S675BYNYJ/uW4znyMNBsCi+Np3ZG2LEMpLQJ9DqlcQH5XU+dZ2+UAoqdOwfDCIvt
         pfz8KxRN2s7SJedXYzIl0Few+CgDT1FYr9BB/ggIBYsROuCG9TbfDzMgknEbhGHNGKlO
         ImjW+pV//nbGFxN3LyA6GB3/Gg+SgRYg3JDkEgR+Gzd2gOM2R1WWl0B7qTGzDM84Pg7o
         VAGLW0X9DeOEBumOErBgERP6h79LenEHy/rvi6ShN1kUo+5SoobZrMlhH01IKgOHCaSZ
         UFwZejCI/tZNwLiHpyiyEvrs1sDodDRA+a7W7E1XH+CNvWWcu8OdbhkO0Mm5u/NLSnIT
         3gfw==
X-Gm-Message-State: AFuF++meJihHlscJlLEOQuZJ7iLXz6k4Gvsn7gv25Lwtbn2NOWCYVMs3
	0PVz10oYbsNXhTlHFhk2IfHZjQ1SkwJu6Oq1Y1p5lTu8aZY9whp5FoXP9WRWtjzn6do=
X-Gm-Gg: AR+sD10iZKDqqRD5ZWvH2ahGoKsA546K8SrfsGb5uwhENXG3X3dlgq6lFPrLN+5aHB/
	V7MJoNbCmZ4ezrAye7LBh4ymFHUr8rqeP/a4RQbZTtXG75TTfcSE3yVmFolHFarj8+VxSFNzy8B
	cZh3oGYRtqfyMvp0HXtNqKgFXETpPyQ+zho2vFRgipE7NIo8dWEk0QbB01CqG+vWYdQYulVy494
	pWRFSMPN1TF/z7D0zNUVwc3YZ/XRazRwtCv/ljAMekbOF/b64APmLaCEcwFz+coPQGMJeKXdLzl
	JmQL5gktQdUpWt94HphYaLqxe3qSsxVHaBKU4TncIRWh0oQwfcR6FokKMHGarxW52bQK2KlIAy+
	0Cxpg1XhsQtKJZ2Ltn9YiGf1WEwpoJdjSrPg0XZBDCkqb7m3etFL3mPaMjj/sSLOfmX1F85JF0j
	o2pfP6pGUt+EfqzjuxSJYbWWxO55fzNnvJ1A9PSySeaAvJ+XGmUhAU1N0zgLOe0k9TPDqOwxk4Z
	pBvDwv3lGF+NLNPvTQS
X-Received: by 2002:a17:906:f5a2:b0:c20:88a6:8210 with SMTP id a640c23a62f3a-c250bc072a2mr525330166b.9.1787729653099;
        Wed, 26 Aug 2026 00:34:13 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d62easm357931366b.6.2026.08.26.00.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 00:34:12 -0700 (PDT)
Message-ID: <3b77ed31-549e-4bb6-a7c6-b4f65dbdf784@blackwall.org>
Date: Wed, 26 Aug 2026 10:34:11 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/2] bonding: convert unbalanced_load to per-cpu
 state
Content-Language: en-US, bg
To: Hangbin Liu <hangbin.liu@linux.dev>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260825-bond_overflow-v5-0-7a800de133f1@kylinos.cn>
 <20260825-bond_overflow-v5-1-7a800de133f1@kylinos.cn>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260825-bond_overflow-v5-1-7a800de133f1@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/08/2026 04:01, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> A later patch widens the bonding TLB tx counters from u32 to u64. The
> unbalanced_load counter sits in the transmit hot path, and cross-CPU
> synchronization of a u64 would introduce measurable overhead. Convert
> unbalanced_load to a per-cpu counter first so that the subsequent
> widening only touches per-cpu data local to each CPU.
> 
> Introduce struct unbalanced_load_stats to hold the per-cpu counter,
> and move the aggregation into a helper, reset_unbalanced_load(), which
> sums all per-cpu instances. Use the delta of current total load vs
> variable prev_total_unbalanced to calculate the loading.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
>   drivers/net/bonding/bond_alb.c | 37 ++++++++++++++++++++++++++++++-------
>   include/net/bond_alb.h         |  7 ++++++-
>   2 files changed, 36 insertions(+), 8 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

