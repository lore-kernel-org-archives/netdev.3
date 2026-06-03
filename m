Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8F43E9E0
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506747; cv=none; b=HqLzSM61CefbWbIhrHLKvdSyj1lU4rTSj/W1rZBzB5xRWXLjGAOIgXUuKqodnP27EvSWiToyNYyVY9yDp0WhZn1OrXnAiI+bb8qiw5Y9zvvKkTBIoj1HD6utb8+UdcEfyV4ZP91jzAVGioLKT0xbPOLA8oWGw9wVAJRcllcUFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506747; c=relaxed/simple;
	bh=TN5VN5nZYGpZ0cgk6I+DWPRMt4OBymg3kF+L1ZSTg10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkMI3MCE/QAe/5sMwLmkGmz9OLqwBBZuSw4mYNuTnhIFUTj5cYS/cftcg4UF2rABotdyq2JCLdCOo/5ghr73s4GoCWp5CIxjBPgZbnkde1YSCYabIuCkgch7hZg1xyMoE8zJIPvhCG7GdIiK1IO/EhD93icShuEjTa8gCsDeImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=J43NUAr6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="J43NUAr6"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-46013161068so1931955f8f.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780506745; x=1781111545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WShIXeDXg6osn/1BPpnCqqp3TWGu+yv09MQ0gxlHZ/8=;
        b=J43NUAr6UxcD6FhnwU3H5ssro/H+8XGFqQJSoNhiMs3ztDp8Q8P4c0V4dndmvxoB9u
         HGLYWSSg/r/hz7VWdpSLHoZXMi9kTS9DtnC8iKQWzEpjAIUj+BYzxmxi4S7E5BSmqwfn
         rkkklpjH0ZOVxOShxgYaB4k9F71N8npU26s3nDsEymw6CQ+de50yUol829sxw9znEOKC
         tgW2CPTzcTc+wzz9f3pYS+fJ8gXhWlSeVPAGv2b87BtaKX8qFi/1JAVnIrRzksUXckom
         cGdxPwDy3l3pkO/Cv0IoLx3U0SLmT5DwSOr08RKc8RGcbYpX47iCv4rsl1mJ26oum2Oy
         koPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506745; x=1781111545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WShIXeDXg6osn/1BPpnCqqp3TWGu+yv09MQ0gxlHZ/8=;
        b=A60xT8SXLgOTzpCWd09BRxi5Nq8VFPFS9JJ1NVIu5BJS/Il1UfJm+2isldse8ztpPm
         vBDJ8HllAQOwNNUVWvDlqgqVp/E6HCPzmT8Yz13406qlmngkyw2hvh+COxgmmQEZeBwN
         63vVJjf70dnMFPTYcr7puQOFKK6W/IZVQLu89LTIxjthGHtxKv5MqYGb7o5MueWo5qnV
         SXWZasYgepU5klhCuRBbOjQCqJ2fJ/Ix/J8hCsnF3VCATx/oDghacuZ7hN8Meqo+hRu5
         L7MAhUU2JZQ7GQ5/q76JNbp3cJ57p8lkMmwMZnEDfg/nZLa3uI6sf+Sq4y2HSIMC+LMq
         +ZPg==
X-Forwarded-Encrypted: i=1; AFNElJ8JBjHA+K05nf001PYvPFAFmwmJpQKONHlgLmImwmkLVQwu4DGKDUqIJinwfqpRWdxht4757Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLbfk7m8oTgib2SXNMicDJaivnaDBvygn3FZ15jcz1eY5AOYh
	GjLpEiNL/qQMDVQPXICxRJvd4EeM5NynBc6t23KqFAguwO/TtIPvT3HLYdMPBulc9OY=
X-Gm-Gg: Acq92OHJzcUkb00cvHWSVgTy/pMyvJSDudKBrU8uEl85K7vn0aTy8oEwFqfGM/UUmzN
	8a3okpuK7RD668zon6KfENoDN+pgpI2lzL0EFqFPVNvCrWEHwUzWoltKpco5cu12K1zTIx42xj/
	CCStBCnWuqm2+Xs6oaUOT2ynWh6C9tmJJJDhw4dHCxxHYVIES02wK3NW0PRPrnxqq+Erhv4miv+
	xjCNqHMxnoXi3ZWqFpqunFTobjSFAHiKGZ43tWY5mWfv6Y9JO8rNwd+VqR1QpQ1wHXhlKuztAQC
	+0RNnaBmsvjCEhJrzUbB4Uwq7sriZOhz5Nq5581mes3/Fot6cir0qrdU9dTf0N/NBXn9B3Uk1hQ
	s3s/jLf301WqCszMuRJprT8YYHZGPHWB1Wpu0ygW20u2L6qY5CYxPyOMEqcAFtKn8S6sKBvath+
	wDYSTaUvEESnLpM+YJ2o2Rf9P/OVRsp6NfA6ORGA1SlPFFGL8n13GdqC0AWjr+5vKv
X-Received: by 2002:a5d:5f8c:0:b0:45e:f29d:d42d with SMTP id ffacd0b85a97d-4602181eea2mr6197828f8f.25.1780506744671;
        Wed, 03 Jun 2026 10:12:24 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm8997419f8f.9.2026.06.03.10.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 10:12:24 -0700 (PDT)
Message-ID: <b087dc20-7398-4ad3-9787-efef883d81b1@blackwall.org>
Date: Wed, 3 Jun 2026 20:12:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 0/2] devlink: add generic device max_sfs
 parameter
Content-Language: en-US, bg
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arthur Kiyanovski <akiyano@amazon.com>, Petr Machata <petrm@nvidia.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Amery Hung <ameryhung@gmail.com>
References: <20260603102646.404797-1-tariqt@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603102646.404797-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2026 13:26, Tariq Toukan wrote:
> Hi,
> 
> This series by Nikolay introduces a new generic devlink device
> parameter, max_sfs, to control the number of light-weight NIC
> subfunctions (SFs) that can be created on a device.
> 
> The first patch adds the generic devlink parameter and infrastructure
> support.
> The second patch implements support for the parameter in the mlx5
> driver.
> 
> With this addition, users can enable or disable SF creation directly via
> devlink, without relying on external vendor-specific tools.
> 
> Regards,
> Tariq
> 
>
Need to rebase due to commit d603517771d8 ("devlink: pass param values by 
pointer"). Sorry for the noise.


