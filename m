Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F492FE066
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153276; cv=none; b=VKyFkjPVs1XhX7tQ2DMZagTJx6pl2I9B6WOd9etwkfjRbyTDxcuetnp0JuV+WDf96D7aEmYzLqz2xqXiOaZ2/a0ulg7On/fgTUInGHIe+eyQP7LZ+Ulqi61qCTFcWpNRJicxteif6kOYFLSdo1Q7gR/8LxP8VzufWDG6G26Twws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153276; c=relaxed/simple;
	bh=xqDnncu2jsUTbyCC32YgYTNAVOM2JL0oO0VMlx4bNKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pb76tWBy3KtFWwPE6frv2Q17KWjL+iVWsJGjKF2kiTSPBznMhz+b7rJkCapqKnz9PU0tybPeVM5yg0u39rOQ06SvoK8vyhr8BYOfdyhDGukUUFcRXwYYQ1PEUbo0lK3ZfyWK8cS6PJ4FIlTribXeIg769aXBEivp2OnhZS4vP5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HZe3qi5F; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HZe3qi5F"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so4519105e9.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 21:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1781153273; x=1781758073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+qwaMhJ36VTYK4elPJaLtEFKf/SNPJj1VDBVUArjG2w=;
        b=HZe3qi5FAkVJfV0tsnCcAoO4OM2UdAXbAqpOBFWpk+GatPmoYx+4r34SmndWuqs/hJ
         b2MhUw48QnYHbggwjifW0TDO3XZ72BbPeQqiIbc1EHJeIneTWNYJf55+SUR52y4S8CCg
         qivxJ/c9FtlR42sDxemrT8dJH6P04tayGA+YemBzcoa0B/eZG6zSKil9svoVB+xbXNYZ
         ka2KKMVXH/MVRV0sQ9yxbD8g/N1lh2IoOv4NTGFV+Z2TOZ1o8UHqXtXBPbu3Uru5+Dwt
         HhZ4k+gcLbAHOmNkj4uQvOKKMnh/uC3hhYHZzPnNUcfJ2xxtKAbhSBsQXZFDxbjs1kwb
         1dmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781153273; x=1781758073;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qwaMhJ36VTYK4elPJaLtEFKf/SNPJj1VDBVUArjG2w=;
        b=SrkySWTxVhGxcl8m7f9aaCj7cYCMHIFtQk2/nMBCIM7Q1Fuk06I2updgjf3YATERk4
         xTujyyv6blGlj4pHbJfI2zJgVwggRjbv4WY+Hx18693yp+r9QEDUsiWMklO/XL6NSUN/
         7rxzQ61POZPgKLxLaYcHz7Gast8PM8BMFd8zcDHwbHLiTifuE8N/R1ap8x3OKWpj1QY+
         T3rYQXGhlEGTxfw8mVEistMgz6Cmkokm4qS68jnT7gkt09oPlTWAHS/5f57d0mrfC5ly
         sFMPaSINcjhOCKNTXETAyOz3qxXLoUi00o8B5QbtUpXsWdaS3LCatfl83ii8OHrwRs4I
         3MTg==
X-Forwarded-Encrypted: i=1; AFNElJ/skLun0VUcOV6ciEfmuaWjHJ1WVXlEEqSTahxxwKqD/PedQCFjn1ycVIAPbe30+vM1J39C/S0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7kkzqBnVfM8jttTWCNs4qMb5Xlxi+IA6YIJA1t0OiveXt1pEt
	+bvXPbEeAxzWUthnQ8NvqJ++msryqolfdYaBlkHTlNQEbBoVfvlU+Ro57VSHV1B4YIX/ng3HcEh
	xwMAE958=
X-Gm-Gg: Acq92OEVeeKUGJ1pB9+p+BivYymQjMVVrrXIA/yEMNMjY2SyPuLxibsl2PI6vEIFJeT
	Xfg9C8XdEC0MsVAgLujc+TJDD3pYp2r+hHA2i3CJgoiwdGkcEuRSoscybalTcPq11etWCA8ms4F
	szEAxsspVj9S+sPy8UCHdr0sHneeVCfrZxYxT2RXTkzOXPlG+/7hhQ/3ixZF1il41EtADrG0y7E
	4u2HCajP67Lwrn851zej9x6rVoRd+HI8mGEXtg0doRDSdmEMpW5zW6aaNsYXXAibOH+bf9hwodc
	Iz7JG5ofinv43JTtLldsvJvTAJnrIxU+qCR4qIU2na0ScSRq3ijmQ4MUNjxf7zybBghcoPwwFWJ
	tNPgcieJWeDglYX/5xzDQIWzXDOYFkgn6CrmSKuQ+AiQL78bJ4tE3GKFM8PUeU4cNiE1zumlwim
	vOPeuzIdhX+L7121YP0ZUbMhqUgsPHMIGKe5a1BCGHyYD0uAOArmmTW1HOv0+/9WUGQkzZfwJ7Y
	Ao=
X-Received: by 2002:a05:6000:2882:b0:450:ad00:86aa with SMTP id ffacd0b85a97d-46067c153dcmr1111063f8f.15.1781153273509;
        Wed, 10 Jun 2026 21:47:53 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4004sm77401565f8f.9.2026.06.10.21.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 21:47:53 -0700 (PDT)
Message-ID: <4e9939c7-97e1-4ced-b356-b6150f0c17f9@blackwall.org>
Date: Thu, 11 Jun 2026 07:47:52 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 4/5] net: bridge: use atomic ops to
 read/change p->flags (II)
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260610161836.1275531-1-edumazet@google.com>
 <20260610161836.1275531-5-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260610161836.1275531-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/06/2026 19:18, Eric Dumazet wrote:
> Use READ_ONCE(p->flags) in br_port_flag_is_set() to keep its ABI.
> 
> Use test_bit(), clear_bit(), set_bit() in:
> 
>     net/bridge/br_input.c
>     net/bridge/br_mrp.c
>     net/bridge/br_mrp_netlink.c
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>   net/bridge/br_if.c          |  2 +-
>   net/bridge/br_input.c       | 12 ++++++------
>   net/bridge/br_mrp.c         | 20 ++++++++++----------
>   net/bridge/br_mrp_netlink.c |  8 ++++----
>   4 files changed, 21 insertions(+), 21 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

