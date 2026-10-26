Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792987093;
	b=tvvJBQfpIiMy/1wHQe//9fPAX22bbY7T9imGhrBWgVuhGFBo7U5LqtdfdNQ8SVcvRVGj
	 uBHsBungrA7vKj80dcnsLHuWbTMQXi2/rLHht63Wuz1wlSWhwUTkmJg7b3nhKEaHIpvQs
	 dB24j5ftc2/6/zC8eoP6EShZhvXfQUlTqFcZAx+bqSi29NRQuW7SxeurFdEjLpMArhTO0
	 kuEVjNSVj/x6lZByVCDtaY0aPR8gxT40O5r6Xbklw0l4MtTFa2HqTuaSn2530Nivi7OBN
	 zsRQABOlS/8otBK/3qohpGOz4wOTbGVs72kCoG5vxUWkXfHk4EKm+obkvedOOvEZ2Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792987093;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=lxPgjT5PfaKtXn8WuAIdpROT9VM6CuZDdJxKH4cFlAS8Zc15eyBh6Gmxv8V3evFxaGNz
	 wTjcBJokf8XEa/cEmjV+wiDUnvSurdWGkwQHfFrkKLIFqSOdmnNipO7fJ1ZB95HdunmOa
	 eKGR3q4EojP2QQqLD1jxUCoaSgz5B7b+Ymi9BtzOqBaYD9w98v8B2IUqxivmfnNyusX+G
	 6Cotf+be2x5quRx/dMeYgQJPRftVMB3kcD+V7gQmOP0NEdoyWRfRxN2COmjoBSgVSMbgX
	 DcLMVvBW569xTtCgX7PBk8g3EXfdecNaZQAAxgs7XTnu1tS8kP5uDsJ59J9aF8qeRVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0dwnkth;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D90606A31A;
	Mon, 26 Oct 2026 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X0dwnkth
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1D51F01825;
	Mon, 26 Oct 2026 03:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792987092;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X0dwnkthi5o6g+wKBBXOsq0i7b0qhG6dv7W+8VuGtXwKh5BxTyVWb6n6uMgRjKWdv
	 HCCwG7BS+hYary/pIvUgEAp8zm3Xoy4F2nn5arJIs/I7kEaYakuE1V9RZJ4GfZh4Xv
	 /Osui+KX6nDRsSxTT6u64pPdXFI9vCHkxHm6jHOAYS7OSuaV45qgk8kk/0Q+VotRLv
	 mcVyeI/27fcnITZfgbJ3nLeU4iNIHYSoavdhTga7XWDdQXIVUOkpUi1kz+OWnLAdtX
	 9EAx8JMr+x1Od9uDEgF/hAzcoUd+aaRzBuZ0vXiKd6fi0UW6Blh03EwR7q264Hp8rX
	 v2o6g5Cua/9Xw==
From: netdev-bot+sinfo@kernel.org
To: vmukunda <vmukunda@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: 
 Re: [PATCH 1/1] octeontx2-af: Fix npc_delete_flow counter read for cn20k
Date: Mon, 26 Oct 2026 03:58:11 +0000
Message-ID: <179298709117.3327.9736793219665353595@kernel.org>
In-Reply-To: <20261026035140.666684-1-vmukunda@marvell.com>
References: <20261026035140.666684-1-vmukunda@marvell.com>
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
