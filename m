Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606989;
	b=Ku+krFM/zQWYfnrJfF2rF/le+27cyOmXayOvJJCLib9PwJhPi6yjziSJxFkWPCqu+pPh
	 j6XNjwBr01OFPIyAL3Qy558cDmTXATQ9pd0cbKoiW4+sDlyGejvkBUhQbWzxwHFS1rAOc
	 pSXOy6tIY5eMVI4Zpuf7W89+0Cdt/9Dm3F8wCcRGeBUUzWE7Ca+JJlwkTcV0Hme8VAcDg
	 sprSgQ2vGAB/vhariaeljukk0lo10vBh5IBJx2/baejVcN6jt4HaU6mLWnIf7ksOjz6Lt
	 6mAz800FcUaNgOwWzNVwAl1cKebQaC9mJS7WN74CUNh/B1aGpOtIToITB6YSUs8nmlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606989;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=s8A37k3TP3XfhwYQvbq9nOglgpSzcHuw6aRQeyRKah++qmcfFBsqHlrZTCtGmshd8p5s
	 516t8I8uzEs6fbfC+1nshIzufhrM7LxRxCyUv4bDX/lKlFacD2Q870G/v1xq3Jn6gW5dd
	 +6iOTUs7IY20zn0Yj2SrLcVqbRs90Y/oxpaoqWkF5VHkIvWbwshzZbC1Hw1tXsgsDjif6
	 aCK7PZfgZjQMi1wOtdNWhEvSNa6Mn72Eg1iIg3pnL7iKO8yHeuXZQbmKCgsvTqjXB/n3m
	 JlFqnjDl6BM/ch2fNtNzBFFEzEBde9pxCMY4TEgt3x+3u0ieBSnaaqptyqL4t2PLlfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4wsn2ij;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450FC606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T4wsn2ij
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6C51F000C1;
	Mon,  2 Nov 2026 08:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793606988;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T4wsn2ij3otwsrSVCtkcEnPwuHvRZ5W+uajybO+DnCsgXD+vXohEJbh/yHrAVzQDf
	 mzKm8GZwKH2aU7TxTX0NR9QvfQph5iLHXMsTJo5YKs7MP/IB0fPERczxZt/JB4cwpJ
	 jf9ukdNkuO/NJ2Z6j2Tz5FFDDzklSajQAGxlI90Ya757dj5d2/z2saaeYYl4LAFZJC
	 kMYTskn75WQLRh8Glys4dqhYekRiOwTw+5Jf0CuQmX3D7LXUeIZCsapk6SSoQh1zc8
	 zcC5DjTkzPqqhJ3ILzmZeCHm4LhACXo3WCZhQwXOxFVlsATwPlXoVx2j+XYFpzdj7g
	 3esXL9pfhVaYw==
From: netdev-bot+sinfo@kernel.org
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Subject: 
 Re: [PATCH 01/14] xfrm: retry inexact policy lookup after node reinsertion
Date: Mon, 02 Nov 2026 08:09:48 +0000
Message-ID: <179360698804.3286.12919312656209223593@kernel.org>
In-Reply-To: <20261102100451.2505200-2-steffen.klassert@secunet.com>
References: <20261102100451.2505200-1-steffen.klassert@secunet.com>
 <20261102100451.2505200-2-steffen.klassert@secunet.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
