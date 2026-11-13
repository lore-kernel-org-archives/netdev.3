Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562523;
	b=ccttr7hgyh1gGcsxlYJ0V2ulPQZsdhy+PmbrECsvBDy3EKgcM7E8fxgP7mIh7k199fLk
	 hL4SLi+myskMjFqsXNAwz28QE1Hn+OTXs3a5wO6SjkwauTmd02NiScav7MPsyilF6KrON
	 derb6AKBOZ48Qehys1CTcrNNhpyPNeSka1gjLp3CzkZ3RKwZRI6pJFGwPpitbELIne+TI
	 64jApWI0X/pLOie70NU/VdtDDwItTkIUas0WOLoWrG3ieF7vw3paswmgLvp7+Zfu2VwWq
	 UbLkUDolOOSObtyxoNMHPydh+v/UYtLxf6X+tJ3ap1u6a+whzlZxdp/xVNMKdiuIEeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gnLvgp87noxCI6o2SU7GNRgwOFA/uTrc+4IjpRWHEeo=;
	b=F+biX4rSza8l0nYjJTXLsXp9hVbvcloUlWmJpQMBQ7JUeWzJSimePhYELB95dPmQGg4L
	 TYuP+Js+NQaAI16Jz2QIQ1ubxMRlMUAYecZVmmRfdUSNEt7gbpTA6F/Pg2SVZ73o+QI1F
	 F6/Jx1eBsZvZhrVO7w5uR7b4FfXvN5FIteJyfHHpZglR4CxEvIc2KQI6wHKrlhqOm0Z06
	 hxIKaQ/ZHqruX9DjSrT0Gu+VPeJPKQgnTlI6WGHGt96raTwa8f8umLUIUwcVNgXqTJoUc
	 P1N4pe6OYIAMlyTdCHcwTnSSxYLI+xB/1bqDSstqihSLM+8z055YzFylvzjWNLPfJvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=F15ivl2r;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01624606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01624606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=F15ivl2r
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2072b9832so10270385e9.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 01:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1794562521; x=1795167321; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gnLvgp87noxCI6o2SU7GNRgwOFA/uTrc+4IjpRWHEeo=;
        b=F15ivl2rsRq1uyCNLPZLIvMKF1rBA3c183PLoklgO1HA/kUAchjNnFuKdbxIrTG72Z
         5L0umYELTb3JOqfiHrLAv+TA1jjTt8fJAGNbAoFMJiNA4AChiGGMPw3ZL9XoFFT07MQp
         ZVJjnlRBXvkD5qf5PEWLEQb36ugl9FdLfF04sgwTrrbOYopZ0kJRm6o667MBRSu1zLd4
         +CQ2terEOCeRWWuSRudkkvZgy9ZmhCuKjJU5nb/Y2uAR96bYaYiQsLRbSTslYAbbAfN6
         FI/9pDcmkDRSqTPQmD5sp27VCpD6nI5rb3y+Jahofq9BvG1dnoty002gMXhePUZkCQVA
         LyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562521; x=1795167321;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gnLvgp87noxCI6o2SU7GNRgwOFA/uTrc+4IjpRWHEeo=;
        b=mgkXLoqP48G48nXMfWP1vq8EalDr5jAFpZHAwV9jiK65wPzL/hscV84/w4gqJbOXvy
         hkK5Ty9gnJrAAmAWkxzwAcI6BVRVHFxTR7BiqN1K8jMPQPIUCD6L8l6uxjM7n5aMXs8L
         0qNdPK30HtH3L7VfslYgKXdGhi2mnf2hFdAYlrTsaGs2v8poVp+888QMiHoYeWTJ1ewG
         kImJFJkM/89BOcblVVuD41FXP0ob9/huHRt/bItYMRDPiwG1JTPNbFz6IWV5jbVe+S6R
         M+W6B3z+1LBmX8PlAyRrq3xx4CrLJK5V19tDzTjcogxbkRqanjf1BjFTTgTv1g2sLArb
         vmcg==
X-Forwarded-Encrypted: i=1; AL+hErHu2fwJdDeLo0buo42ZEONm1Ue060h2w0cHge81wlUnOcXKbCsVi6c0KC5xFw+2j/Et4nVVk48=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rR4qVaU8F0gYLCsl+6ialsUNNllq9QSNf9iW+4A/kwT0pV8G5
	naOSuExBP+/Ej2SGLVs1mMn08NcH2HMdOUUufyYQN7RsdeGr7R2typn79AboGtqpYqw=
X-Gm-Gg: AYBFou0YNvGnDrBedKOqeF2V3O9juCn5jqy0bU4QuwyfDuytgobIaEYXToBNQCJWXjd
	6M3IThGu6/AT0WxXTNbW5KdFleKGqO21EZNApI9jGdd/fRGuPNlYHZq6UtOm4837VmXqqUWe9sI
	Sxg3BtIWVswfQANuByol5aIGNAL6H/889KKlKPykDq8fSqwgLYYNw8yKVDULPT9kJkbQ8BH1hUy
	nbzEmp1YT8/WqAjMQR9XazmURPrCvNUF0qesXBBs7PoOhUaVHveaU5jrdaHu6X/pcaJmKHFe8Wo
	EgCR4v1UwiRCsHTknrOFZwpTzc8mtduYwm6Klwupe9S5KZJ+EF05MoHoqS0lUafxr4Ri/BlWb3G
	CsIpbstEII7ZaGrDEpOsVvfsR1AcWU/BqNbmx+9aGdc2NZh4/xqHsu1HEwWWHZ/9v4wl9XGusGd
	wO+Xt1jW4yCVk2MIlnsrgi0u5XECvfqs2h3oS3uo23e3+MXr/GU/0lgivDxh7nvI1sXCMHCnSG6
	rF2RMGMUoUpeqqZe48eLRaUh+NCw17j+1AGOH2ycRRZubPhfqibQqcBpgrNQ9k3eQ+wjcsyhym4
	LbSiT60sTSkGY8y8b3LYu4AIddpijovc9/DaHaIEadorU0iPRgEnWwEhAYw=
X-Received: by 2002:a05:600c:6a0d:b0:4b9:f90b:1c4d with SMTP id 5b1f17b1804b1-4bb4e2d5f2bmr88546915e9.5.1794562521369;
        Fri, 13 Nov 2026 01:35:21 -0800 (PST)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60116323sm4068585f8f.32.2026.11.13.01.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 01:35:20 -0800 (PST)
Message-ID: <3eb2f85a-c262-4e42-a763-528edd403769@blackwall.org>
Date: Fri, 13 Nov 2026 11:35:20 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: bonding: Add a test for 802.3ad
 with coupled control disabled
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 aahila@google.com
References: <20261111171947.2816258-1-idosch@nvidia.com>
 <20261111171947.2816258-2-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261111171947.2816258-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/2026 19:19, Ido Schimmel wrote:
> Test that with coupled control disabled, a port in COLLECTING state
> receives packets.
> 
> In this mode, a port only transitions from COLLECTING to DISTRIBUTING
> state if its partner sets the Collecting bit in its LACPDUs. Therefore,
> keep the port in COLLECTING state by clearing the Collecting bit in
> received LACPDUs.
> 
> Also test that ping works once the port moves to DISTRIBUTING state.
> 
> Use VRFs rather than network namespaces so that the test could be run
> with a veth pair or a pair of physically connected ports.
> 
> Output without "bonding: 3ad: Receive packets in COLLECTING state":
> 
>   # ./bond_lacp_independent_control.sh
>   TEST: Receive in COLLECTING state                                   [FAIL]
>           Packets not received in COLLECTING state
>   TEST: Ping in DISTRIBUTING state                                    [ OK ]
> 
> Output with the fix:
> 
>   # ./bond_lacp_independent_control.sh
>   TEST: Receive in COLLECTING state                                   [ OK ]
>   TEST: Ping in DISTRIBUTING state                                    [ OK ]
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   .../selftests/drivers/net/bonding/Makefile    |   1 +
>   .../bonding/bond_lacp_independent_control.sh  | 144 ++++++++++++++++++
>   .../selftests/drivers/net/bonding/config      |   6 +
>   3 files changed, 151 insertions(+)
>   create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_independent_control.sh
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

