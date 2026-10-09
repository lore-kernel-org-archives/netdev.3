Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE294FDE63
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571025; cv=none; b=RD9Wbme9g5rEyrqjPpAKMwr6/5sPFuqtxoni4odGhoXBOPp1nZQYJEvyysYU8nxaGSZ9PNQgBh3eR/W2bVlknXgtDhme8VquxP9oL5vDlyy05dBijdOe2NEkgI/Mo/wBuqnQvfGU2hZ8BW0ReenJmLVzzeAwXZvFI6QIqQNQnxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571025; c=relaxed/simple;
	bh=V4bv6VzWlmaKy6cyUN9BAsnusU4OQwKEzHekDwMpncQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et59TydXeLvybQ2nnmp6ypwaJ6rGBx0nn0y0/iq5UEhtIqkljoumN5532JTHqatiRNComHTcbkW7Fw1y+sIpKwBkXo2RYaRwEIxG9lzxDw3DybZuPGLybhTatNpLqdnoDBvLJT4c5ww7oVPfKIVqiwHlLVcZcbu1YkH/zBY79V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cov0H26e; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cov0H26e"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so131885ad.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791571013; x=1792175813;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2T5yHfGH1NCV6TzhOONYKnxefA3nlftBZshKhCEnR0I=;
        b=GQgTD+VqVQogcWEua1gLT5cezLQu3V7222X+Y/Z3tlk6JjaCZ892gnegTopGs4dJ3O
         +DY2TzgJSVBMjf8Ib3qjXV0zzQjxrcZ3wX31wlPMsMf6YVImW/qxc5zf+b+bEcVj2zaM
         VfKyVgu4HaUF58HgcHvL3T734jTofPTCpzYDIk4X8KBa6MIxyE2i3TUp/XU1xTdeaNIj
         L7Gqgzxrp5zWySC7fKrwLmrgBwAmq0lGdZInFIcfGgCUGdc0DuMqXtyh8I5GROwjgMb5
         v8N7D0pd5lBZQqy+w6a/Qcu1dJhVgRj0Has3GptE8Imbo9ct3eoLGe/C6pmIQvm9QzKu
         nwUg==
X-Forwarded-Encrypted: i=1; AKwUvBz0JlO6+JN941OEpJo8N85zCkofanYH7VA99j+iDB88oFnczPSG6Ss4btfYTnoSWJSRteAxNOI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJx8BKKcHgOpXguYRcm19U39eOU762e1q8Ud1r0+pHuVfdWtxuA
	8WvTtBptM0oQWAx1gv6DF4zR4TO9HojHgUXfqceuUk5WGd+Uavs242GeTGJ4jYoCaMIlYu5UnqS
	iHwHgvEfAEqtyi7N9YMk8l8L9+87UXXAe9IHMa+K/ERo1mzNkAV+dKhKKqnkCRR0/J0FjiV0CLp
	G/t7E2NOnghrgZ9Z+ZI3PVNd3oYA0OaaJbg6weRTL27FA1IAKI04GX4beh08lpIQBrY0FaKxWIP
	Stiq6qCcw==
X-Gm-Gg: AYBFou0uP1wgzx69Zb+qCxBrFNOhA7qCLOLDjYfiBewIdHr4Edcw+C9vWBJgoAZKt51
	dZTekFV5IOPBvpL/D2mCGLZckHMI0M2FGL17QWNbtUEtu8VAYVDEUKUNz8IokEjXBqTAdOXZw3l
	rAxWkeCyUB24dLBmN5riNgq/PfTOq6uJlNaN3IJsf6tKpdm5vWjTovmq6xIFSOLl3sCJAo7TovW
	coVuSWkLm7DeZNjp50Kp4ceFaSkpT0vjjgJxCiPu9luUgBU3nGXP4tj2XC+z4AJAGa5GP2eIK/H
	0cuCAv7JCy7kImsmbuj7LnzInmSwrYCl6hcq3o6nKJgMDN7Pl1I+aPPpWbWAvsMZB/gjeEB6eM5
	d7WAquTgeEzwfv3mCsuxc4Hm9DGWJ6KZNN37qy5MduQQzx8ZYD9a6BE0b2TNlGEro7OVViyMZQR
	wNTWaUIS3AXzx+KhG4ZGBAooewADuQCMrTvPUb
X-Received: by 2002:a17:902:fc46:b0:2e8:6af9:34ee with SMTP id d9443c01a7336-2e86af936d4mr3909935ad.43.1791571013454;
        Fri, 09 Oct 2026 11:36:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e8419e6bfbsm1233715ad.3.2026.10.09.11.36.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:36:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a6d30f66c9so2716309a91.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 11:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791571012; x=1792175812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2T5yHfGH1NCV6TzhOONYKnxefA3nlftBZshKhCEnR0I=;
        b=cov0H26eXslU2Zvsy02Tb15OC/9W9yhX9Hqfqlt29Fiw8saAhjTkTU1BhfcBuy1Cfh
         k9HNsXywb6oLtvte3yfebUZ8qZKAGaou4afuc2YuKfgE25wi/KPzGcWwiXfK20iVuzau
         J4IIZZS4+RpQq/zU0y6cJ1FMNM8aB7gLx68mg=
X-Forwarded-Encrypted: i=1; AKwUvBwywnPewHwuTO3tndabo0/piBGG/8IL2fzM6kb8AuRNOTE0G0gCddw5ifE/2Wu7GCZrOZx4uHE=@vger.kernel.org
X-Received: by 2002:a17:90b:2d06:b0:3a7:cffb:8b8c with SMTP id 98e67ed59e1d1-3ab3ad0e976mr1513155a91.43.1791571011692;
        Fri, 09 Oct 2026 11:36:51 -0700 (PDT)
X-Received: by 2002:a17:90b:2d06:b0:3a7:cffb:8b8c with SMTP id 98e67ed59e1d1-3ab3ad0e976mr1513140a91.43.1791571011238;
        Fri, 09 Oct 2026 11:36:51 -0700 (PDT)
Received: from [10.14.5.199] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f46dfesm4653252a91.8.2026.10.09.11.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 11:36:50 -0700 (PDT)
Message-ID: <a5782d0a-901d-4965-a5de-5826fda0d9c0@broadcom.com>
Date: Fri, 9 Oct 2026 11:36:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 5/6] net: bcmasp: account for offload header in TX
 short packet padding
To: Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Zak Kemble <zakkemble@gmail.com>,
 Simon Horman <horms@kernel.org>, Ryo Takakura <ryotkkr98@gmail.com>,
 open list <linux-kernel@vger.kernel.org>, Nicolai Buchwitz <nb@tipi-net.de>
References: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
 <20261008210621.1374785-6-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20261008210621.1374785-6-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 10/8/26 2:06 PM, Florian Fainelli wrote:
> When hardware checksum offload is enabled for an skb,
> bcmasp_csum_offload() prepends a struct bcmasp_pkt_offload header
> (20 bytes) to the skb via skb_push(). This increases skb->len and
> skb_headlen(skb) by sizeof(struct bcmasp_pkt_offload).
> 
> Because the hardware descriptor processor strips this offload header
> before transmitting the packet on the wire, the wire packet length is
> smaller by sizeof(struct bcmasp_pkt_offload). The padding calculation
> must account for this extra header; otherwise, short frames are sent on
> the wire smaller than the minimum Ethernet frame size (ETH_ZLEN +
> ETH_FCS_LEN).
> 
> Furthermore, small frames with payload in page fragments (such as small
> TCP segments with CHECKSUM_PARTIAL) have nr_frags > 0 and were skipping
> padding entirely because the padding check was restricted to
> nr_frags == 0.
> 
> Perform the padding check on skb->len before the descriptor loop using
> skb_put_padto(), adding sizeof(struct bcmasp_pkt_offload) to min_size
> when checksum offload is enabled, and re-read nr_frags after padding in
> case the skb was linearized.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Assisted-by: LLM
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
