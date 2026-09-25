Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D64854EB
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329979; cv=none; b=mY8ujPJBMMbHsr7HL6wf/tWGMnAPgfIW2S+lYvpormRPXg1/V6bcEAZJxYo/hRSNtrJsbgO2hePgpvtGW5EqsKjq8KgxvZJ+HeYMf0ioHCFaxOpuwDmu8Or7cLqRUAWoWqvuDJfW6jCiIvZHWpkqeYbE6r4mzqCgYCQ+Bt6OqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329979; c=relaxed/simple;
	bh=nvyA3TDTbhtrxdFzEjqfVphfihD1nWdpT6xp1d3CrP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sg83z1n4y228jtQXPM03oOdNRsplNo2xqLC1SHG2Z1JbnGsu482Rt1lWgWjUk7BqKS2bUEaEtv+oykbcRVrz8aElNeiKIl/dqehMI7cFBiCCh30VwkKwE/YDJ1WmdGusnWWxcDaaJcLUcGSIX9Ed71qUlq+qIOG+uH0T+qw2FbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvSr9cB3; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvSr9cB3"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48583cb7d44so55029f8f.3
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790329974; x=1790934774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wnKtVfuA6DDtxDljFMt/DQAZ8I6CllqSJuo16Cr5Xvo=;
        b=fvSr9cB36vtc62nWqPWi5GwtqeyaqXo5+12p1oMlSp6oVN8Ha1/2Dkq+hhSD6Zq63w
         t7JB64usB4P6BEoQF7mehPiqyGz6ePx/WO7tm6jIrxvL3R8dgCfHaI9a8Mpfxa6AK8Qq
         kTMpNS94C6UtgbxQAjpOuhKcYQ2PS4PcG3jVJj1VD6WerbO+uVlnxvDFjUrm7Pi95nHv
         tdC6wb4QkuH+Uk7yruyYfD8voNJKk0YMPECNMBpTc1fAcdi2iIwK7V3+L9VPIB2IzaUW
         +7VQ02CjQaTZ/f2hwsKvE7HOgAm7KuoqX8ORqstjxnFrcfJ64vkrEc86tvdfMEUd4GZk
         9lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790329974; x=1790934774;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wnKtVfuA6DDtxDljFMt/DQAZ8I6CllqSJuo16Cr5Xvo=;
        b=HmlqPk2kiKJI7ttH6gAQaAS6u9UlJ1nfWp07HhcxKlV0h3i2S0pLyLvglT01duGlRP
         UVM188x6G/InKE2EHBpTRbZq+/VNrgqO1qegMqKQicGCyEhlBYyMbDWjM80qqd39xcTj
         4vJzEI6EVVeS8Knvh9H/AKCWtY9ZrW78mV+Dsk8srQ+UBdUg2VgE4p3m9UZit87bbdnm
         San+pZq3PK0Rpy1o8/0Ihk0xpXwXBKyEKKI5bLoeMTEgEmt08ulj5OzxMoHaRZ4fdj8J
         /Qeqk6RGDTMs+cH40ESUu+Iv3D87dls2hrfJvWe0BgOG9h4vlzcDiMkpLXvZyLfuua9F
         U3kA==
X-Gm-Message-State: AFuF++mUoMAE2xDmmavhRP+iXjvcZ7GK3GUsl1xDAPteZJh8nDtKgT1z
	FeDMWwo8PiaZDhlFbqq8tYUGA4Wik9pXY1/49gUL1JcsKy385qCWDcdf
X-Gm-Gg: AYBFou1J71lOVXrLeMZI9DtL0S8eln3Uin4VJBFa17CaSi2LD2upC/FnW5N4egAyjsj
	6N4KMAztx+qUc8/jbQ9f8e0liI7Fb4htT8PvQF/U7E0aQi+cZe4RXZ8AZyDJn8v9m5RGBgjayuu
	nkrzPrwmhNe1uiL+5rSmdj3pjomtL/cWdBweGyrq56Bg1hwFIPn6j9b3I4LQxTdf1RQDVY/7aeE
	zAYTPz4M6EFl9IOuiGlEVZzMitmDpGk18Wxxgw+J92ssnnQ8uB1zOUtIKS/ba0mrgcfdqbs2zhR
	nNBEgXn6nelhH8wNuVfZNnap4llcflKe3mHJ77scDDArx6IAORre9mne5Wy50xWVvwUK5u43Mzo
	shCI8lXyKSIzvioXw4KtTX63KzdkYBf1XxQdOaGoTmTQ1QYP3bIsuv/ePaoKPoSty8BcpGHYiyl
	XwsFEN0vFa5yAicOrf/QJanQKwJi/bHt9vs0StFCPYssBR7gN84SqKPFr2Via1CR1QJ1cGDDykH
	jIganPi12d0Auu1t5Nfe0WPLkYDJj5B1s5erHhEAJdJL3zoH7/Wx5FrcvuReyThDVQvSmro7pue
	AjI9TWFrjYSQuGO5hC+AVE0Ludbo9GTZHKl2PagAjgDPzCRAFNbQbUJcgxuC4kGBR453TZcAPXw
	nm+H0WRMiR5ESHuvH6Q4=
X-Received: by 2002:a5d:5d0d:0:b0:488:79d9:ef3a with SMTP id ffacd0b85a97d-4887a89f181mr3916537f8f.2.1790329974230;
        Fri, 25 Sep 2026 02:52:54 -0700 (PDT)
Received: from ?IPV6:2a02:3100:5dd2:bcfc:4dfb:2ac9:70ba:48bd? (dynamic-2a02-3100-5dd2-bcfc-4dfb-2ac9-70ba-48bd.310.pool.telefonica.de. [2a02:3100:5dd2:bcfc:4dfb:2ac9:70ba:48bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355c65sm5863049f8f.19.2026.09.25.02.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 02:52:53 -0700 (PDT)
Message-ID: <21bfa8a9-c488-49aa-b2a1-4d282fd51c42@gmail.com>
Date: Fri, 25 Sep 2026 11:52:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: hsr: unfold GSO super-packets at the forward
 entry
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 xiaoliang.yang_1@nxp.com, skhawaja@google.com, liuhangbin@gmail.com,
 stable@vger.kernel.org, sdf.kernel@gmail.com
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-4-xiexinet@gmail.com>
 <20260923104346.ur63K3h2@linutronix.de>
 <2cf54664-c07d-471f-af6d-4b70e09626b4@gmail.com>
 <20260925082954.MYDugnDU@linutronix.de>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <20260925082954.MYDugnDU@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/2026 10:29, Sebastian Andrzej Siewior wrote:
> So you disable GRO on the interlink port and still receive GRO packets?
> Or is this performance related where you want to keep GRO enabled on the
> interlink port?
I am not trying to keep GRO enabled for performance. The difference
is between a physical interlink and a veth interlink.

With a physical interlink, TCP data is split into packets before it
goes onto the wire via TSO/GSO. If GRO is off at the receiver, this
interlink RX path needs no extra segmentation. Patch 3 is indeed
unnecessary in this case.

With a veth interlink, there is no physical wire:
TCP -> prp0-peer -> prp0-int (interlink) -> PRP

A veth pair is simply an in-kernel memory pipe. When a large TCP skb 
arrives at prp0-peer, veth does not trigger TSO or software segmentation,
it simply hands over the intact skb pointer directly to prp0-int.

Turning GRO off on prp0-int does not force prp0-peer to split it. I 
confirmed this with ordinary TCP traffic in a VM, with GRO off on both 
veth ends.

Patch 3 splits that skb before PRP assigns sequence numbers and adds
RCTs. Each resulting frame needs its own sequence number and RCT.
Ordinary non-GSO skbs skip the segmentation path.

In addition, if GRO disablement fails (e.g., buggy drivers or
hardware-fixed GRO_HW that cannot be turned off via ethtool), Patch 3
also acts as a fallback defense for these edge cases.

--
Xin
