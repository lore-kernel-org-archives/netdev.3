Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9723D4137
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473096; cv=none; b=dbz/B5twPRrDzZblsL9lllNjbr1fhm69AGyDgvi/43lC0PB5KdgW20OZtLbQ051fPemI4wKGHiqn8YGOciFG5nm2rFNwNK+EbRs0OZ3iqsztPcAZvLVPcTPNiGsG/qg4E/+pDSHARObTYkvJI/7kj8RTD+SAL8i4caKOTSSYj8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473096; c=relaxed/simple;
	bh=ZuLED0Ldzvye/L9+gEmWQaF91j3p5pd5GZQj7/eVbYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVJzCFwhYPexXTHO0X49YPMo8lL+4Rjq7wNvEVYUvXC4jF/2pio0FQxEw5rXWC6XbX6QuLXYNm1+m2k0XVG+MMRt7I+EqLDOtz9fb+hOWIqxCKYVyS/vdUWYkBaH3sdk1Z+tM0tzb6mYuxI2nGG2hQ2ESSozodeaAbVMmhPGelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=BnMvgGCm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="BnMvgGCm"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef779c1c2so3290748f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780473093; x=1781077893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CmddVBMrPeoo0t/W727VNbH37OLZ2lXshuJ7s7TKLd8=;
        b=BnMvgGCmQgXEe05DBYl2ruCI1rdCY0Hthsl+3Eo0XP1fbniHPI5P9785CZwGu3CJk6
         HCnvtzH0lCskmbCrBaGlW0Gy1VeWBAf85Q2WjPamPGBFBw0ybHgg+AyBWthLppiFXwB5
         HDHhuxDYaOKnGsRy5qrq0ij1MmOH4KlnTHf8WwmAmVxBq2XZ8XwJ7a0OlAXlLFZb56ON
         eBUipW2yCEaQAUknU6S5w2GrtFt6gp4k/ObGGK2q8PT+BjSKHJOtB7MSPUFwqwO6kzDx
         o28IksP1RabvTxFwuWpcINW1639tM/IKgMqkmnrgT/Mms455X81lwndgaKwsHGEEYSCf
         6D+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780473093; x=1781077893;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmddVBMrPeoo0t/W727VNbH37OLZ2lXshuJ7s7TKLd8=;
        b=NHDn7IuVM9tG9gyO+tsFpZfJSw96FAvY7Mf5jtTnhCoC3zV6bFcAgRayQLcdlwYNfI
         2zSslqaaPHuj6IRyeDMo0NsKpmx2sZxI1zGES7LVlV0d6mtFXZuSfXBIypE61sXEPsza
         guR/s7WHCmaem5qYjKnqiCUghpYfbazaHyGQVA0QEFk0WPoY1PJjwbiU0lPZNAguzcli
         2YnnFvb3WrTc0hSpcZDIkonhPFA6rUYTADJMC+srKX7U6iNgd9NmHIX8X/E/w9xuoq6I
         a7dz/fHAxScqSlNw/bncBb60O3JZOxAafe3/EuI1NVKk7+BSNeuoQYfVzE7HLLovgoJT
         OS3w==
X-Forwarded-Encrypted: i=1; AFNElJ+xcB82Upbkh723vqCYAkGsw4ndSxTI5fr30iXSu4+bzmVZyVnnueG0kEm/Ml+LuKyfr4kt2+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL0n2aRSPBWSfkcxwXXyCh0wnDYE8Ya1EYnWZtMw45o0HYAORE
	6CqIVAQQpqA07iUTa/fPFF071BN2oFsFOjU2PdmXTeDyn4dcsoqwLsGUCUJYSEh6Lik=
X-Gm-Gg: Acq92OFmKKxnCJgoscusmhFH95KYDGer8h0rDlCMJ8Or6JJvHA1Ap8D1BriSTV8ct8M
	N5YQJ0xcxrTWhY+lk1sXGWj4GF4924MB1wOpps939wKJF0zYiNB5OULvZUeAv38F7f1j98OOTS4
	x+Lc8Ufs7Vtwlxd7+rRKRDQssXw7FWl0eKWYD3dEuUnlBOGwiSvQF0x9SfuzT2D1olQNe9UXwVC
	tL43f93Yqj1kifethTWXe06hPibR4itdfzyxlwJ+MqkR2eLdEkusdnNjiDTBRpbsg2ja9hTPUKx
	mDDh6+EXXK4Ra2qnr5Y5d0p7ujR4uCotMbzZ5XMrFjJEawHGLfr03M3HpaGiJzzS8JFgsVA2LlU
	JclIX5nJNlNbO8aoLlWcGQk+Nm7Fp6Q1NIRpRAJu3lJym46YAUB+svgg4kFH6P7qn+6cdhMZcJL
	pHSC9A1E+5ZVqXFckjSWUR2n5qQEJIr87ebBh9sgFvY9dvOXY8hGB4fUAm7iQVfAnE
X-Received: by 2002:a05:600c:4e52:b0:490:7136:ad05 with SMTP id 5b1f17b1804b1-490b5ed4829mr35404595e9.31.1780473093386;
        Wed, 03 Jun 2026 00:51:33 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7a52be7sm10259875e9.5.2026.06.03.00.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:51:32 -0700 (PDT)
Message-ID: <b223e5cc-ee4e-49e3-8bd1-933380fa9080@blackwall.org>
Date: Wed, 3 Jun 2026 10:51:31 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 10/11] bridge: provide lockless access to
 p->config_pending
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-11-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-11-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/06/2026 09:20, Eric Dumazet wrote:
> Needed for sysfs show_config_pending(), BRCTL_GET_PORT_INFO
> and upcoming RTNL avoidance in "ip link" dumps (cf br_port_fill_attrs()).
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_ioctl.c    | 2 +-
>   net/bridge/br_netlink.c  | 2 +-
>   net/bridge/br_stp.c      | 8 ++++----
>   net/bridge/br_stp_if.c   | 4 ++--
>   net/bridge/br_sysfs_if.c | 2 +-
>   5 files changed, 9 insertions(+), 9 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

