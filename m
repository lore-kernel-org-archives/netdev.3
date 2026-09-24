Received: from mail-wr2-f19.google.com (mail-wr2-f19.google.com [74.125.225.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A2411A12
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245559; cv=none; b=qossYZNhnwFsF83ooxftkBd9CaOMtLr3U87Rqihpp3MLBDVsIR/7qQIrlpvDNSdI2h+3EGx7lZKd2d/qvywFws2RkjS/1UKmMgXttrsfM6dV4MwSR+c3FGY1LhzQ0jGGL4MVhuUgUPy3GhX/6odyTbQnDVqbO5nebRYpl0Fgmy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245559; c=relaxed/simple;
	bh=vNOz10Y52SylWqLAxXpDtRKVnu0yA6ICaPesQyqWfok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqUehxz74jdGA2ti3XsRYHTp9GiuZBuDRUnDLeQ6peECVfbCId8fveX0YIz+nM4zpGrZbEI/D7sj23TBAR9gXAZAWqWvUGSczW9hpoSlwA3aGYiaM9eDjZ9NBahScTaRU5bm10PM7G1bTidhK7z9UaGYZnrXjOcN851vR+SP2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=CZM9yX15; arc=none smtp.client-ip=74.125.225.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="CZM9yX15"
Received: by mail-wr2-f19.google.com with SMTP id ffacd0b85a97d-48583cc7ab1so1063327f8f.2
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790245556; x=1790850356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aH8cj72YzC0YBKtfZhE3DhN84f2mpL6hc+PS7300/kI=;
        b=CZM9yX15XqJzP4RzYUromF1tjo6Iw5gLuDtaUBvD6T2qyZFD/uES6vTpHJkJi/EZVu
         42iYhZm1H+UJzM5m+7b5FOgSAHQrh5169CIxxcBJAJFvpQf+rmisn/Bzb90pvVB9L0Kl
         fY8TVc2e8I5nuIYzlb9Nnmvx8zOiDoyd2+QfP4WE0nEZL8DIB/ALvvqiKDaX4zsyj/MW
         Iai5U8Ox99zOp9gvorqCQ2RSzEhGKngprvVHvA4Q+deTzdsm+/zfJXVe01IzHJiQ8FtU
         5J5gI0fmhPZfWfq5aNHSBV0XJAUu9SHwukXQbGa+V9nL8erCNE5zmtfXff04FnqpwjdC
         o0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245556; x=1790850356;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aH8cj72YzC0YBKtfZhE3DhN84f2mpL6hc+PS7300/kI=;
        b=tLzbQd16QDXSWsICb1iGuN5v/xoVzOVUkmILUpE55Yc05qMAGrQCAQ89CxKg4SqXDP
         VNU00EXLjPDMSVR1ai+rFsJFJuZDe3GOPS9MFd0A+GGn6DbNsAhNRuIhU7dosXlGOmEs
         IxGqA/P3DKPVmrGYe0TYCWw4EugUfR8tOIwxjWHIcdT+Bd7v7lmQjBMer09UjZnf0/b0
         HLPA5v1TApG+UpByZssNs46yCUYZjNAt7NRwbe0tJUrep0PtzAt9sOGVEqYduUz3s/pp
         /iTwvVraCwJyU/dLnY1mdz192bJqyEb0AO4l2BSu427kTcrWSeZ/FmWaN0k0xHEuVLIP
         7mAw==
X-Forwarded-Encrypted: i=1; AKwUvByA8a0/BSqwlbBA8e7r3j6WR8BGvCFoh+hf6plDpT0G9Oyd06sj6bBpXkwpfg8dHpx2cNcFfL0=@vger.kernel.org
X-Gm-Message-State: AFuF++kyWZC9mQMcPBCaikechSP2rbCMZIX9uL4O1tPAoYO2DrgJMDlI
	UBvXprflFWuslqxCatyZhDuOUKE6fHskbN47LNxN4Tibqu73xfnWDu1D0bvRdPY7gIo=
X-Gm-Gg: AYBFou0Ftlm46cgwZrEZds7sfgrN1RW/tTl7GNsQzOGeK84cH98+4yACiTIgDQpXCDD
	U+8HoFIhG3rMZpMcHckU/+m2pDRgtoe+MvObsSpqvyg3ytPlEIv6Wvj5qD1TrAyt2Xfe8ekie8H
	UUgU5nopWnwavrKqvc72/szGvcVSqwAgWdgWOeUjp75QpOyFwQxJS7+w9vX73e6mbrAmuuTYrSI
	ffbubqGsQ5iIWFUTWiL8v5Wz0suBdUa7o+p4CWrAVGoTI++eRrB3cdNthHLUwYZ93I3pf8piAzg
	Kkw8q9yGUufo/QYwACZM1DntMi7d02d8x847qQtPU3uaxVf89k8fBRA7tQZD2Ojl6AJ8pp3/ulO
	auO/uQ7wGfdEzpVa+Eg5mWbzguxr/vde984AbwPZWlmoZX6Su+bOLAnqMJDjlVTh/ZEhKyz3NQ3
	9meJJ4baPFcV+4+TFUE71WOGF28mfrRJo7Pq+L5+v6US5nncbSTOVhbmkdzhiVq8JEM5GtnSWot
	qSJo3WzjmxqkXYxAwLQB8DFxZQk
X-Received: by 2002:a05:6000:4282:b0:486:e9ab:2b86 with SMTP id ffacd0b85a97d-48871759fd6mr3288299f8f.39.1790245555726;
        Thu, 24 Sep 2026 03:25:55 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682673bdsm13504490f8f.2.2026.09.24.03.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 03:25:55 -0700 (PDT)
Message-ID: <392eb8c9-6254-4ae6-ad44-e38af8bb2956@blackwall.org>
Date: Thu, 24 Sep 2026 13:25:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/4] bridge: check llc_mac_hdr_init() return value
 in br_send_bpdu()
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 edumazet@kernel.org, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev
References: <20260924082951.1599377-1-edumazet@google.com>
 <20260924082951.1599377-3-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260924082951.1599377-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/09/2026 11:29, Eric Dumazet wrote:
> If llc_mac_hdr_init() fails (for instance if the port device type does
> not support LLC or dev_hard_header() fails), br_send_bpdu() should drop
> the skb instead of resetting the mac header to the LLC payload and
> transmitting a malformed frame.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Closes: https://lore.kernel.org/netdev/179022851638.2160803.1808206741379444999@kernel.org/
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: bridge@lists.linux.dev
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_stp_bpdu.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
> index 74ec42ba1e7d086cbfde608c93f5fa24d6b4ed7b..21d092f5acbb81f1d0ccd80200cebdbda722f4bf 100644
> --- a/net/bridge/br_stp_bpdu.c
> +++ b/net/bridge/br_stp_bpdu.c
> @@ -52,7 +52,10 @@ static void br_send_bpdu(struct net_bridge_port *p,
>   			    LLC_SAP_BSPAN, LLC_PDU_CMD);
>   	llc_pdu_init_as_ui_cmd(skb);
>   
> -	llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr);
> +	if (llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr)) {
> +		kfree_skb(skb);
> +		return;
> +	}
>   
>   	skb_reset_mac_header(skb);
>   

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

