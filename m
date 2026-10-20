Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527655;
	b=Ir6b4J9qZunlWtjYDzAeHXFS+1ah25CK2av2EQ701Piv1mBSBQFNdH9Ciqt/XGZkBKqF
	 zKMa49khtml13iv2VB9Sa/T0JQvs2/dq2EKRtN+Yo3y3ZbqgxXBnEun+SYMuxhv56/R9k
	 Iy1TFSckAdJlwccMs8nJl1uNtCvUYVMNOGBbHJwmG6zuWLxODgRqWJh2z/7A6N+ETHyzi
	 mhWTJQHP9Nnc/QkN35oHLGpV/65t8HSx6BnmIne5Km4f7nsRUN1wIS2AcQuXKwhXShbBf
	 XWsArL21sfJO3ZBA3YqDUY6wXIqeyI4OJd2Xihh6BWlVaqlf1OvgFKmFxbz7QsB+msg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527655;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pEfq2xYr5sUyjnjSouYaJq/VgMZlx1DwIohg/se+j/M=;
	b=0xrDQUEfehtHiFfrn/1fWlu4t3uhsTmEDEOESrvTsiaD9928YJ2VZIhSliPkOJdoJm0A
	 ec4xUJlxCbEQPGt4VCqKiifH7P2wlsLi2lTsn/om7bJ0IKnk15gkm1iybCVHFcWUCmVQF
	 HgjTvyKpoWgq8m7IQZM59uzBpwn/SW3fq5a6RTPuSl8LkDaH+VIc2+F9PfiufeMX+sebf
	 bBCbEV+B50hRrEanlM8sc0oP92MQVs7uSYkrsUcrzb9BMmB7+Cs79E7Ym1I9wNZlt+mRm
	 uHfDtJphtLwBKx91MTQc67DOvRxoO4vKFPkbbfmDj91vV7/cinbMjC2UFA3COkwXoNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARyVV3pA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628CA606A31A;
	Tue, 20 Oct 2026 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARyVV3pA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798271F000C9;
	Tue, 20 Oct 2026 20:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792527654;
	bh=pEfq2xYr5sUyjnjSouYaJq/VgMZlx1DwIohg/se+j/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ARyVV3pAIyYmSbOPxlNI2QxgDn2FnHyCYm+aLOojTw3BnrWZBCsOw6e/IgqLNWS1K
	 DoNqJxp0dmPb1Cc9RoWXbhi9KEjr88l4tuGINyZjJAHAlew1WKKqVHH3XTt+MZOEhm
	 ITBA5d4ennG1cZwqRmUGyAWm/i/W9+zTsab3vIVczF6y1WZ2qXAv5MFqlLlMKOGGEK
	 UaUFQCVz/KYLQLYZ9ITaGpwYGUDZ3/EVfP8EI6ak8ENzmutaE95bQLIn5F795zW5BR
	 nvTfL/Rf08h8JYD0qFLcv2VtMZq+z2/djrNHwMLgFtRIUG54gWjZn4bZnVoMA5biCF
	 xvYozqK3v/Ifg==
Date: Tue, 20 Oct 2026 13:20:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org,
 steffen.klassert@secunet.com, chopps@labn.net, herbert@gondor.apana.org.au,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/3] xfrm: fix vti tunnel device use-after-free
 across async crypto resumption
Message-ID: <20261020132053.4db3201e@kernel.org>
In-Reply-To: <179242534145.3290.3021737362277964895@kernel.org>
References: <20261019153247.89957-1-q.h.hack.winter@gmail.com>
	<179242534145.3290.3021737362277964895@kernel.org>
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

On Mon, 19 Oct 2026 15:55:41 +0000 netdev-bot+sinfo@kernel.org wrote:
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

Please include the answer to this question in the cover letter.
