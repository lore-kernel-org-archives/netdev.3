Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793272854;
	b=zRGblHIa3nNdH91R2ujt0a8kYNFVdm0Pp5hlQoamkSw9aJaWCFT2uSbCu9mje9Kp6uim
	 zB6ta2ioUpcebFNmtCnbuxAfltj72LiBiKpcO/Bdxl4MJgsaDsFmew1KPkJ6veFKjfXlG
	 XEyhuLPHhpMBHPmRz8ndZfATVZa9Tg/oUo6pksrWJe8wLLY7fxhAXnRLMwDtR31iV7Ixn
	 yYtd7MMTCZxPmKCqf140ahqiOjjbyHtzbSzZQlT/hExXwnjL+2xaWh6QBLXsLautN3FPK
	 mtbIb3RhgyeCcj5SQ6kcuxnA3EVKsfgt2uPnRlesA6R4EUcy3OjK+Gw3IozXUzc+uLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793272854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=j8Zt37GO6hvBK/VWxNoOISHBNExAaLWjWwQPv4izgSk=;
	b=Moe4hkvLkNY4uVFgjD4TYq0Nz/oQIrYoOrDXi2FhoSgLkIkaP0i5WZsmX3q91YDjaPWn
	 DdvZAtf1DmvHsXds6djBQxyqDXwWlU1oSpu46019s1F6iSsJz61D5qhwL4G5ap0pXNXwC
	 8OkZngsbbK8Aa5V5v2ebBs2nwhkltT+I1lBMxqH/WVM9CJqdHfch4Qmr3psjIx6zRbTFR
	 nd4mpozV/gxA88XFqBv6WvfwiybiN5K91k0cBaUhNARAoKb9La09jg+eLD058FQRiHWVX
	 65Sj4I9MxiUUK+eKxRpA2X8rwb8jHAsoBdF6/RqwsrX6+1zoWK4OVsO/BuUVXf+OU0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qk8g6IaN;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271AA606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 11:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 271AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qk8g6IaN
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so21911875e9.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 04:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793272847; x=1793877647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j8Zt37GO6hvBK/VWxNoOISHBNExAaLWjWwQPv4izgSk=;
        b=Qk8g6IaNzLRC96s45UVqwO7Akh0xDEgB2oB6ShZ3S3dAYnMFYwSN6XIQ868uHVjD3w
         xlEevPfhiO1ASAnLxtEQGJJgjbpXJ5AxBnKiBeurM8yl/wFHElO2uSuaAtHqzLvf+h+D
         zd15rVtpEmpuYzm0wON0ynBdThtALn54vYy15737THserh8ttgQtYd/xsNDfCfYNqV2S
         fgzwTmB3aphkX0C6kAHV/D+5UC8LVvM2pPQtp3K+7IlBziBJS4eEeLcBBW11fzWbOlI3
         sWewwss36PTuCr7WyM0SVmIhkVQJ6EVNkkaKWrzk1Kdy8xbACOcCZ1VHGMxPR0D6LB4L
         AyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793272847; x=1793877647;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j8Zt37GO6hvBK/VWxNoOISHBNExAaLWjWwQPv4izgSk=;
        b=BVwit7gtiT+OvuZogb25LCi6LXgkILBP5iI9TQza1bwddgM0/kAOaQJXGNPHGQ1/lR
         6XPZYdtiWp/2CxgDkA37fp3+ag7B8O2yLU78nsVwvyycXcff8QGXBE/6sT9iJAmxObD7
         1ROf5t2pO0N298EHnbC3EYZuY0TREyevLkMdVAwMHT8yef0HfmZmyo2Jw1dnpYmbStRv
         +elayYPRTGkZnk2xATnPsH6vtw5Ibt/9FqNx+Yw/9wxINK3Wq+n3DJMUFrr23D8LmCGW
         P8pTJkvB7G0bpCST9jb+ilm++rLj8T7gLidqCPxUi8gv0JqZVthG5KBKKIGO6rnfbp9z
         SWxQ==
X-Gm-Message-State: AFq9FYLpgIenf3Dp1Q1MECnzVyitpEZyN3+XIQSlzjK4R0lMw5FOl8xI
	ERsjY3bWqcYY2/dzr2018cNyRLM+F1idE0x9KBR8KCgRVW+shj6waVFK
X-Gm-Gg: AYBFou3XCzYCWKkTbCpmK8aIiK1xqafbWrUNpGGsPqoZgeJPsTatDfzJlSADAHhHatv
	PSeK19wq6OWY9lvR+9YMARu0JiJp7YzCPhLd8xgLwVh2KB5LNjYEV7xTEe1L4h/DzwUrNmuF5xF
	HHltzqZkLA88J/S777gMnt5KYxtTKdalKkM14GbRPa6duN6rmagvTahGOIVeIA98mSb9bLcTAv6
	SgEBXb/DntEKIvoAvQEKAwV19xl2Y7dYDhAtjAxviwVuMO1stLUR9wqDLg+o8ki3yOHNlwiY9fJ
	HZuVFq5EH/ps6oRWaidDV8Dcwj45a3j6uWblIRbKIXziS4N5s0F8IxD21fItFYBr6iV8qhdMn3s
	D3CXxv2Z3KzFbyMeLQ0e35gBGR9qoyFk6f364al2IZ/rEfF3NfJhA9dJoKpE+WJYTIDsqj89gkl
	rOeec6pLOeXaP/NHobdTaUgo1PjQ6N3mjkyHRpBaQMgwGD52rkOPP8oNP5MoWFzEW5bsIqckX3N
	IwwaCzZg3ppjxV2ivCXSBSRjQR+HWfXSjv/mCHTiv6EucQflftP80Z878CfWYon3qSBnZfEomey
	OEXStrjdFMcWp31XC/tc/YWgGWGPRMaptc1GjS0QM/Dzbv69QmTPBOaM3l6MalM/f90=
X-Received: by 2002:a05:600c:8184:b0:4a1:d087:f6ab with SMTP id 5b1f17b1804b1-4a967016ae6mr109930585e9.18.1793272847111;
        Thu, 29 Oct 2026 04:20:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6419e05dsm5345525f8f.19.2026.10.29.04.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:20:46 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:20:45 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Esko Mobius <echoowall@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, Shuah Khan
 <shuah@kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>,
 regressions@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Eric Dumazet
 <edumazet@kernel.org>
Subject: Re: [PATCH net 2/2] Revert "net: advertise TCP MSS from the
 configured MTU, not the learned PMTU"
Message-ID: <20261029112045.5e7d4317@pumpkin>
In-Reply-To: <22077B76-12B0-4DD6-813E-A3968003575F@gmail.com>
References: <20261026-advmss-revert-v1-0-272fa4b7ecb6@gmail.com>
	<20261026-advmss-revert-v1-2-272fa4b7ecb6@gmail.com>
	<20261029101859.6893f1a0@pumpkin>
	<22077B76-12B0-4DD6-813E-A3968003575F@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Oct 2026 18:21:22 +0800
Esko Mobius <echoowall@gmail.com> wrote:

> On Thu, 29 Oct 2026, David Laight wrote:
> > If it isn't a silly question, how to connections in the other direction
> > work?
> >
> > I'd have thought they'd need that ICMP message to get through.  
> 
> Not silly at all. The frag-needed always goes back to whoever sent the
> oversized packet, and only the client side filters inbound ICMP.
> 
> Server -> client (downloads): the server's full-size segment hits the
> 1456 hop, the router there sends frag-needed back to the server, which
> accepts it, learns the PMTU and resends smaller segments. The server's
> send side was never changed by 2640e6419594 (tcp_current_mss() still
> uses the learned PMTU), so downloads always worked.
> 
> Client -> server (uploads): the client's full-size segment hits the same
> hop, the frag-needed goes back towards the client (via the relay's
> conntrack), and the client-side firewall drops it. The client never
> learns to send smaller segments, so the upload stalls. Here the only
> thing that kept segments small was the smaller MSS the server
> advertised in its SYN-ACK, which is what the reverted commit removed.

But that relies on something having gone the other way first.
In general that won't be true.

It is almost worth implement something that retries with the shorter mtu
to detect the PPPoE mtu blackhole at the sending end.
Or even just use the shorter mtu for long RTT connections.
It won't make much difference to throughput (maybe about 0.3%).

David

> 
> Thanks,
> Yongjian
> 

