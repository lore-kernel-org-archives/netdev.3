Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71030C618
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 21:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284952; cv=none; b=XJdqVUC27ZC41fvudqGl1XXonlGad9kOYIy52b2J1AR3Xk7AA6Kxg5a+ktIp8VfVGsce7wQaApWWrR+riZ15P03YukV2Jr3FoUydlKI/xHkWCPgL4H0gqoP5sLuXiCY+l5ha/jnF3SEwxk5ur5eALTf9uX9FvbdzFoz3+6zTrnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284952; c=relaxed/simple;
	bh=6kcQ8W/2jwK8APrrep1L/VCX0QLyn6OGdgFMflB0og0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvRzC4TV+F/a/moHRrHvDXTlZVTlVn7o9VqkJmIQD1zTDAvTS0eL/pSDbuxeA1FgYcfDdXbsRYHlW58xZTWui0r2cfG/3h0BgoKvNKS8+zx4ijPL/sv+OziG60nIsDRNq34AuCb1Hb75jDX/aZyGGgkqvYglHzdJwcOq1zqnAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AG4ABhXq; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AG4ABhXq"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482e1b55da8so24467f8f.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790284946; x=1790889746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YSkIisDkYKIIi4WkWWXOgZThDC1sNfe6ebPPfj77RR0=;
        b=AG4ABhXqZcLbcPSU5i6Ywm9QKdcz2UrVVpRM+nSRsIrCNG+tTDLDhC+AtVeb+Izb8i
         8/fEwxBYYFhNsiV4a29FzPLpDx4DsOGD0kZmljW5dByTTI37mtKFnvbryAOtSmIoqUlH
         rtnFTA3zFTF5ZcJPZCaVdG0tNaGX+PBidoMjv1F3MljyVVK9Mi+ih7FAyEnAHpvrVXHs
         pRFd3K+X5t1ZIyxDqv942ksCeYBb/GBr/VGSt7/OqSyn0YxlYMGmrvv/RwxckH4tq76Q
         iDs1YeSUw/WYZ6FBBO50ahLoMtNDYzFYACSUgAttM+L6x7V6xA8ZFBrkmePMfZIhSps/
         F21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790284946; x=1790889746;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YSkIisDkYKIIi4WkWWXOgZThDC1sNfe6ebPPfj77RR0=;
        b=FK5NBAcaiZxAlRCWHBwEZaVbanqapkwwuJwQd8gUOHIcfo7jvZHbKoweLXhdm7UqYA
         127bRl8Nlhq1ddpbbbYTMokUccJtEAEEJPhkX/NgIRrI2AeiWFneTQI0s+v4gkGJAQYg
         wvcznPEx1C2CO6IgwtOAdsWnFthzLMAI0W7nm3jZUQYkEy4NbEP0p2vbKrhQzDHpN9Zj
         LgG8bhf+s+ddDT2Vfw9xdMefiz3rW20Twbdu/Qvzjb5yXO0fjSw1EGPpCidiwTBjaieH
         92IpsT+U2VtdsL7Vr9re1qwmK1IoBN7TNcoY0tdXYzmGu6C3hO1fxk/n+PLNbvuC7DX/
         /5Wg==
X-Gm-Message-State: AFuF++kyOqoT4dZ+y6ez0mhoAaJQO8OGMPQ4vk99VW0K5y1eLCYTYH9G
	KbInMPyXRjUlLFyJfGU/CP3OyKXg2dQ34wF/3anxeGvkCYPTYt9eEw7M
X-Gm-Gg: AYBFou0aMPOQDk5GiC9J19ecytfRIuoWQoIaNlMxS/vfh76oUEVhuT58O49K54snWIS
	vjXckJuUmyrXqlDV9kf79Pqunp46xuNXHagCEg6W4bMuMzW9IcGouuCerPXznvZnFJaFSS2RZdi
	xNk4e0O9/R6N3kBnDS720p+QdicgAF4w4uUDbXbesxnGmzRPtMCaM/gcJlad/beZCorY38KZzKa
	c24sCtxipbPUmHyjswsA8iRsp8xYSa8WhVqgLHhpRXHMl5OK/aqScmUZ/+aAqWnAve3XZyeITi1
	FmcqkXzZtToLRuyLcxbqddSKAqzM2DhS77XU2Qos80XY08utvwSdS0WXjeyOZcFk/WvtqCnD7T4
	FgbrY3+o+JrV0m1rNqkj8mCIyI4eUMqqOBLiJbIyPcaTUMPrscTtXNxSv9zmkiywFOne64On/BI
	KQPON7MhKgjmrmUKazVD1oG00zKxZwNyVlE4Awotgc8ugGfnxo6cRsK5HddffskIXSTk5Qz6nvs
	T94iQ3EOxxSChFuypz8y8spWHaXo3XAVEdN5RTiZYVcZ5Pa+/xRqGP6f7sejUoF4v0aC0zW9tMN
	H9kc2gEwwwgTEHs5JIT+wTadimlXFbsubzEzs8JRC9OaWtlR5TrnMJXT4vH4Fqwc0PxjWGkwEro
	2vFHVVyS8P4M/hS6+cJJg5g==
X-Received: by 2002:a05:600c:c490:b0:49d:1da4:511b with SMTP id 5b1f17b1804b1-49fe67bcb85mr60709165e9.1.1790284946476;
        Thu, 24 Sep 2026 14:22:26 -0700 (PDT)
Received: from ?IPV6:2a02:3100:610f:ecfc:4dfb:2ac9:70ba:48bd? (dynamic-2a02-3100-610f-ecfc-4dfb-2ac9-70ba-48bd.310.pool.telefonica.de. [2a02:3100:610f:ecfc:4dfb:2ac9:70ba:48bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a570sm1809789f8f.13.2026.09.24.14.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 14:22:25 -0700 (PDT)
Message-ID: <798e192b-b10f-46ee-8059-bf8d6db058b9@gmail.com>
Date: Thu, 24 Sep 2026 23:22:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] net: hsr: shrink seqnr_lock to sequence counter
 updates
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 xiaoliang.yang_1@nxp.com, skhawaja@google.com, liuhangbin@gmail.com,
 stable@vger.kernel.org, sdf.kernel@gmail.com,
 syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com
References: <20260809121455.1745-1-xiexinet@gmail.com>
 <20260809121455.1745-3-xiexinet@gmail.com>
 <20260923103725.kB_5-sDD@linutronix.de>
Content-Language: en-GB
From: Xin Xie <xiexinet@gmail.com>
Autocrypt: addr=xiexinet@gmail.com; keydata=
 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
 sNySbH3veZ/55EtlXA==
In-Reply-To: <20260923103725.kB_5-sDD@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/2026 12:37, Sebastian Andrzej Siewior wrote:
> This fix relies on the bitmap seq nr handling while the Fixes commits
> below do not have it. Doesn't this revert the synchronisation change
> leading to the problem it tried to solve at least in the stable kernels?

You're right. Shrinking the lock can reintroduce ordering drops on 
pre-bitmap kernels, and the sender's bitmap does not make reordering safe 
for older peers.

Across ten VM runs per mode against an unmodified pre-bitmap HSRv0
peer, the narrowed-lock control delivered 19,128 of 20,000 test frames
at the peer's master. The ordered-consumer prototype delivered all
20,000 exactly once.

I'll rework patch 2 around a single consumer for locally numbered
traffic, including supervision. Each frame would be submitted to all
its lower devices before the next frame is numbered. An idle caller
would process only its own input inline; contention or re-entry would
queue input to one BH worker.

No HSR lock would be held across segmentation or dev_queue_xmit().
Deferred inputs would retain their core TX recursion depth. This
preserves the original per-lower submission ordering without relying
on bitmap tolerance.

On PREEMPT_RT, consumer ownership would not provide priority inheritance
from queued producers; progress depends on the consumer being scheduled.
I will test this explicitly.

-- 
Xin
