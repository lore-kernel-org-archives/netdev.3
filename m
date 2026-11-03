Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722393;
	b=CxT6slyDxAfjGczCZKyVq11eAI2zu/XE9bgu6gooAfQfXPRjT/OydvN3aBMMv4aOD4ma
	 tbCj0eQOzjROz+CsmWrRTqkSvc8ny8yzWTBG/SbBvNpip6ZwJrX4oKOkDklXNflOxJ7Jp
	 f0b5L9LgZfZ8uPukg/Bya7H47oW3FTuWxkC3DZrgu5MlCjFFjtMhHJQCIxpXb5Tozb+0B
	 q7bUMysTeT4zZhCjP5MwKHIYzDeAleATyIhMKol3ZECB7Ts6+4sejezfOjgDjGfg29OGf
	 MMsbfQJIZBIZDeZBLCBqMwRIC9KFbE1Uv6do5u01GEMbkBNf20z2TlcqLNPy2gxg8Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sXDOGbebjk6S3dDV88xPL87kUcW9/Te6jZxMcOYYfdM=;
	b=F9LhsbH3dqxVryibSz9o1w5XvmiXNjsZhvdfJOQjXuyP2mUcLDRnCIJmKCYHmnfhroyt
	 wNrl0WEVLkwrKHnrEP8g0prMoWe40D/8V6tuIsl9G4FztshCx8IWV56oi3Cy8uKMZp+NN
	 EdxNOsoa03EZH9WV0kgoJKZexGUpgVlmpL30aymCYsXRGaIQ0yO0c9Btclu963nqhlaw4
	 cslCt+0wFYnBine5Gs0N41OKEFVAXpOSR51Z+B1MjpXIIKg6DCoQ+iBWYcBVIFcu+B5u/
	 B8sP//EeCufOXWt7VYNbv8LiWmuZpG4OWNyZ1U3ancrugCLGMVTBtOkqAigUEfBGpPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NgBNskAq;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE7606D829
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 16:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BDE7606D829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NgBNskAq
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1931ff67a29so9012467c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 08:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793722393; x=1794327193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sXDOGbebjk6S3dDV88xPL87kUcW9/Te6jZxMcOYYfdM=;
        b=NgBNskAq/L9xASzeF88VEjMvv3QASUCE+1S+IssEXtw40//SrfyfePtkryhvBb4htB
         GViq1TG8PGuI1ClnXAiYvCTui4Zbc/Z5FjDalHhaualZq4Z+wb2sFbXuUc6CJiTs/xNf
         k/q9PrmKXQtMNqs57Zy2QiYH+IJkBGWHhgw0ubI6p1Ldr4kcTS1BEkfnHJGK+un9kS8y
         dxRbHT5jutLsVKvx+BZ2vOI4VwdDessC7D4fGsSZGZV7iQSB1wE/xOcqDX2DEyILGeVU
         z5Eu2G2BcsJ/M6Xwj/lj6UIbQvrv/6L2EJdDFmgo02u99tm/LcaMvpLd/2Z0d0pg1ESL
         ZISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793722393; x=1794327193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sXDOGbebjk6S3dDV88xPL87kUcW9/Te6jZxMcOYYfdM=;
        b=X9M1XvkDkgZJMxU96INIUAjQ9XJj7n6iRrlqxgjNLNP0m4NQqOeXmUOK1Eh4th0cdK
         8AyUodPSOGkMFHNX/8AB5XhAmdBU8If7io5VjBUeZ9ZdAzFBC56zf+7LeieNUteemPI4
         s+8vyguuZu5yKsReZCZXKejQIGFoA1eq2muhNaD64jxtKb3WS2yGQ0c8NGSmD+MH/Ta7
         5By5OVK0oLc1p2krJz2GxbXsAMjk8cWcv/roC5270c99digQSTxMSZcNnI/89uKuSm3t
         96NE+V78+d0OX3IlM81Dbmn3YqCH3EQb+cBLPR49GCKjyktRxWMbvJdGWtl0ik3DB/b2
         CMcQ==
X-Gm-Message-State: APuU4Z90c3zYmJmnltwgFHHyMoJHmB1BxOkfA4cj8D5dnoaMfIpQk3PF
	5A2CatVr+m7zYDFf3/E2MndhFGx67lskuVU5nBXCRZvYgPorwqbX5ZxRJHAiEg==
X-Gm-Gg: AYBFou2pLbUJBEByv/g4J1lgcy7qjFjRPynHdgg4h7HsHRmE3VaGU3Aw2fm3O5lZrud
	yyt9cYwPf3ufi2J7mCL59fWKOPqnrULkyrKDqWDUdhR3b9N5Go+aAmXkOEMsXk1UFRtl1hFfPa1
	cpy7a/1F/XGRvfeXALl6iDoXk1IPD+WAFqB/90F8Ms7o0MWRj+b1yec6mFtfjeyJ14nOVyrzWXp
	TSR3sZlozGqOCeNM8NluKHX27rwG5GTX5hPtwxTAEKwQ8zJDha/52GDPl8hXxrlmZ2f6of6yuRH
	Lb3APPbAP/uP5Ypp7sys/SWnfbahKzWb8D8/I3T0GSwlKQuUofq09xBUtn/F2i9YSeMpKn9bn8G
	hs/ALVJb7vIcp7X/OkbmLQQ0xhf66R+P/MlJqH0gzxeEs7x2cafoBv8mazpM50ToZpOMFgo/UU5
	ipr7QfCHxqkjCynIdnE3QCElHE3VkDXZ7pTkpXk4j9lWbbqP3Z7yEuNL27veOxR5AhgFFgTTtAd
	YAqjLu1/MqpGQyUONBFhpjNM4uCiGLhe9RIGNdiTURoswqX44bt8175hd77LDKz75mRMzCQNeVE
	ywuN7NjwVQh7hiMhQombHzIwsgcYZFm3N12vhJ8i2A+M2p0ydogWpyNYTwRupP8JPJbyWDUkAL1
	XabrPtWGVB+PaKtF/2dHYGF/C6wO8LtAwZ2tC5NzTl7rTVQv0kdxaHmJ3EYDk2wn6qznRVEMwMQ
	==
X-Received: by 2002:a05:701b:42d2:20b0:1aa:6c3f:2f7b with SMTP id a92af1059eb24-1ac5b3fdef6mr21692446c88.24.1793722392314;
        Tue, 03 Nov 2026 08:13:12 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854da78sm58231978c88.6.2026.11.03.08.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 08:13:11 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: netdev@vger.kernel.org
Cc: netdev-bot+sashiko@kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Florian Westphal <fw@strlen.de>,
	Mat Martineau <martineau@kernel.org>,
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: Re: [PATCH net v4 2/2] netlink: Check a group again if it was released while joining it
Date: Tue,  3 Nov 2026 16:13:04 +0000
Message-Id: <20261103161304.56981-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <179372164415.488856.15554879847164426558@kernel.org>
References: <179372164415.488856.15554879847164426558@kernel.org>
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

The deadlock is fixed by my separate patch:
https://lore.kernel.org/netdev/20261102120929.4077030-1-anilkaushikwireless@gmail.com/

Anil
