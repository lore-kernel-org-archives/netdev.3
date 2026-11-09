Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208656;
	b=Eka/ZM3b95UjKja2bI9JRW0qxAeqjqJbW4omnkrDDDZOW5AS0/km7YVrDCEquQKRHpWi
	 4VvKPw9YptYBUqgIZGkYEZYBZ7mhKv5fFBTeGysGM2ABaJDYKhLeDyWkazDTpL9QWQxZO
	 zCxyabxrDTjCKA3vV2+cW50rCIhogdb5x7qV8tQvHS28d//bCT0zuwtMNTpd0o9lml+8K
	 NYqHeLEHXzUwXvz90o6YqyCTHLAjaTke0SSjJaVXps5NQ7NkE30S5L53d+S1fUfBDFn7r
	 3i9QUI2842pJFbNrrNio5KhQNz0vU6ABE6iLM0+S7eKI/ZM3FROSpuxk2lq7Iowsh2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208656;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=OQmsuoo1ZrhJ2krA7x9g4TLAy5xS6aBrhwI0OCqB08QqV9FzdNcFR44upGyolGrk1Utc
	 626rBDrziW2alf05svF5nmDmzLVbteJwg38+vS7X1lna5Asu8eroQORJDtgS5Hkcmz5QK
	 R15927cJXz9SzT9uEx4oNc6pvEKfY9gb7O0ZkdOMdY6BSUZq5PUIYWEtetAzrcc8BwLAd
	 b2TgVIFRbuGw19YuogJU+OCreHtlkibP+mcz0lczvxUCD7UE4qwlwterJypODnzB1/cnO
	 CL8Fc6wniKdsyB9EGCaY7baeDVm4MF7ZtTMDcNQc2FdiCcd3uEo9ltLcSFuozr8r3pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxEqlnQ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3F606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxEqlnQ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73DB1F0089F;
	Mon,  9 Nov 2026 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794208655;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OxEqlnQ6vzECaA4yCnEbZ12WFHAe13+IpDGnGq2C3xzYkUqIr/Ly203kFMOWNFxy3
	 FUYX+QS+n47c94ENWmbCGDOQl59+dz+jrptsZR9g0d7B/jn2CiEj0owcJnJgs2TWw4
	 w7I9LZDHAFEstmtw7far/l1sNeVuYisXEgx3E+N4+uEHXfILMCsTvEEOwj3B7BOOcs
	 ait7fffatkgRVQN4IQO9xxJHtO+5nEwBq+fTxLN5OG7ikBWkPkVyBoQuLRp5yCn2QZ
	 YPY3z7Pbd9fXv+5t71PMsoNgnToKEmTiuvKJaqgQE3T7luqrPI5WfMGxFB9bHgPOd4
	 cjJOgNVw1ZRqg==
From: netdev-bot+sinfo@kernel.org
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: netdev@vger.kernel.org, akiyano@amazon.com, darinzon@amazon.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next] net: ena: set admin device pointer before queue
 allocations
Date: Mon, 09 Nov 2026 07:17:34 +0000
Message-ID: <179420865444.488859.3137456836373315308@kernel.org>
In-Reply-To: <20261109071126.87125-2-thnkslprpt@gmail.com>
References: <20261109071126.87125-2-thnkslprpt@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
