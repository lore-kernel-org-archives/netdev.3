Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794138459;
	b=RJjFv6jutEhmR9rr3ZX/ATYg6hVTtgpQzfO2EArj+0xO9BAosPSM4f+GQOT7dvn0RdMu
	 qJwxMUZYyn7WQ+smRAG1waR3KzoPv5eCWQWrVX9CvGaSAiwSkgYwnCsPUhhzrJL7Ai4Qw
	 vHlhzVtYAVOtbn2+wY2hzHB0QY90U97fHhSOWQEAett1dgw1U4cb++paFCtlzBACij8xc
	 7Hz0SbQL8tQmvmkS/EzPlFnjRXkB8cL3+MiTInkqawy/2LNnPnc4I8vON8EJw/EqV8V47
	 6bFvWJEuqubUyXwd/7bo9jdQ8zoa6OtFli9UeWynfPzsnNokgZRG2E/EKUAj/6sxtmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794138459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=H6Hvjmx3E6u8slnggZfsBaEM6lqcy8rkOeo4cE7U+mg=;
	b=xMdEgQyVM26CTW5bR05RcuroOOyaQI8dhEp348LB8NJO3l6Tnox9l+SVGqYD7TWA3pSl
	 tCyx9hqZXwV5CH11UMwDfAy1k6ynCflmp8zUMXIh5SCgteQFmLCjhDml1rUOPJZmKJ7DR
	 r8lqO/82B3kuidS6gUvoJVbiZRKpoyWfOvJ8VQ9LGNqTMsftnIykkqkiCt/KyvFwS4jop
	 9wzX4oDTiqmQsamqfipF2lcyQcpn6OFx4bItptGoaPd1ruqFMoETxA0RZpwe0Xe16ksJ2
	 8gdHtr7dVN+rK+YtuJVk4Zp6ZN33tjdipJwlf+4u9vkMnC79hr58oQ/yTspphmYBcpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=xGhIG1Tp;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A980606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 11:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A980606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=xGhIG1Tp
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c4d21051042so7929466b.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 03:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794138457; x=1794743257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H6Hvjmx3E6u8slnggZfsBaEM6lqcy8rkOeo4cE7U+mg=;
        b=xGhIG1Tplo1kH9dcB87zNLRAt3n/9K6PYwIBoLwd1L4PGtDHMoa8ORQHH49CXGl9AY
         KHDU+thupviKWfIb5fg6X0wyKGPB0wQ7sQps9IcQQo1QTs8nRmtX/dxj8AlW/IfZg+XC
         LZ2UmmtM+0M1xXmprmFruUDKQxNtQZU4cczvKKk3Gug42TgbBgxuUJpJki8AwO4mvdtl
         Ni7PzH/PMnw/Uqr9wrI9TqtH13nkEFfPNaLr3M0mJGNQ9afzY7CWJ4R2g2xW6h/r6OT1
         7I2mxijr2UL9YS9ccTF2nIpOnqXrwXBosMfmzJcTAfHNvR/fjqpNC0kSZrzl5Rxy9UnI
         QkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794138457; x=1794743257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H6Hvjmx3E6u8slnggZfsBaEM6lqcy8rkOeo4cE7U+mg=;
        b=0E9f0e6Py3nIpwtUACTfb0oC3yMMvbbvwxefjxsDPJmDwVBFQJL6PVULwpFxwwyLYR
         H0Leh+8tNut0D8pGEoA0P7cGl68ihaebCDdlTAOxhwZRaWqpyfSs2Cu/x0cGTuD7DCIN
         AgU8xmAXXqJz0NV7nFEBbXcTZPkzQJuaX5Mbc1iF7VdpWdDK4X94Qjzbpa0Nld4x160b
         cRTdBIhdP1Gkb37c2BLFLIrRcVWB4hzBj0EVK6ePU+Pla4lH5qhOnZwWWngUTq5VI7lx
         iK+jG3jHDJtXyNSZcuGGysZz5QnHNwALIlitug2+29kXxAzcByxZBI9NMidcj3DqYJ0t
         rV1A==
X-Forwarded-Encrypted: i=1; AL+hErG5ItX+2acuKIjblJ9j+S9yBl33Tyi17inPorAuiYYbmyMVy+9ZOLE7pLeeRSflWgmFpoMqT7o=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nRVgmwQFVgtaiInw9Z45706xoU3PKW5m8LUfdIV13iKSLvmmH
	bE06W6luYjGih6519hiZlzMbSaiCsP8QdfQ2fQQ8ds+q8SJ17kEig+n0riryni7yIw==
X-Gm-Gg: AYBFou1J3PQfn0DZ3RFepD9utpdYgNgx+MLb/8gn/SyG6Q6eDseJk5yieYTAqCjIsAG
	tHG7aB9jsWUOtYpZ7PEPbk7I6GrSIEZqdlgLYGZSowtLFxwDImQQ0Z3FjeNc/52v8mhM7ukkfR4
	TY4IngJVOm7+7weyqgYOOhbKHQcTiQdoSSmttCGIdoVr5L1WEyyb7fYedhSEleLMpg0jdQnEEID
	E1wikrEEYpzWA/cama0eaYcCkQJfusXFE6p8cHCab53G/CfTarI0XgvJ/aakVtn1Tv5Acu0H13X
	DRqz8O6ztgxIHM7LCfmKyfHCFEAVjJoStWJAsAyrjLEujW2Pee3TMfQd6ODWEmV70XMeevsaHZV
	JGFOXqF4IoEEe8wM3w+II9WTthwWCj/z1Nj18BHRlHwYZ6I38uUo1Jo7LantTWhxaU+NhfbkDja
	H/Moshj0VCsWVxz9NpFbvBVnB7N3mJaH8tWzf3ytn1ovS/VSMIoeHqhb61I3frrXLD+PlEDMNSn
	7shk0gBxJLyD9x6+FnzCikBfHfN/Y97ySIK36UPX+9EkMd/iJ50T9nHE9gw+Jctpf1o6mSFq0Ow
	YOpBATcBtSuvK+kIDbMLKyqtS84PGIRAPIYsjPP1hpmjA2POZks3yHxGnTA0kl2AmJlH/6BuVE/
	kPF5cryPLkn3oc6RnW2p+WernvzNAUWffg1lLPieoAbUmyeMtchQyr6OrfDpVoBTftqcB0aKWqq
	9X8Khn3TP1P7GzOO11DjsJ5Wy0RHibu9Z9zAsyAo4jXko3yqpaPxuBW+th/JtspPX4xIs/KYC5U
	4lIhkA2uh7ygdCHqMGZxWuLSW/PVxNQeDOxBJenuN4DGsOhCb7F4LOFfDQlmGAyDzuDl6M3v7UC
	9H53LGb07oI7omZQ6w==
X-Received: by 2002:a17:906:4792:b0:c4d:31c5:e30 with SMTP id a640c23a62f3a-c4d6d7ced04mr87104766b.49.1794138457495;
        Sun, 08 Nov 2026 03:47:37 -0800 (PST)
Received: from Desktop (p54afff19.dip0.t-ipconnect.de. [84.175.255.25])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ed3b32sm490083a12.23.2026.11.08.03.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:47:36 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev-bot+sinfo@kernel.org
Cc: razor@blackwall.org,
	idosch@nvidia.com,
	andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: dsa: fix host fdb refcount when an entry roams
Date: Sun,  8 Nov 2026 12:47:37 +0100
Message-ID: <20261108114737.124573-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794134495.git.julius@bairaktaris.de>
References: <cover.1794134495.git.julius@bairaktaris.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> - How the issue was discovered, e.g. hit in production, hit during
>   development, syzbot report, manual code inspection, LLM or static
>   analysis tool scan.

Hit during development on a Xiaomi AX3600 (IPQ8074) running OpenWrt's
qca-ppe DSA switch driver. A station roaming between a DSA user port
and a Wi-Fi AP port of the same bridge logged

  qca-ppe 3a000000.ppe: port 5 failed to delete 02:5a:0b:a2:1a:46 vid 0 from fdb: -2

3-6 times per address when the two ports received on different CPUs,
and not at all when they shared one CPU (4 runs each). The dsa_loop
harness described in the cover letter reproduces it on net-next.

Julius
