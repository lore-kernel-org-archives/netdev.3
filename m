Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310000;
	b=HpHkb5ZGfwUiz8fqhV2wB2C2Qo5aYipozcffAMXRP/EJgit4273mjh8RhMssi9p0Yo2P
	 3YegOMh/7kViWoeq68j3UAVVP9MOX0OZaktBMa88xJ6iOPK+v3PW3XHwyOmcLt7AL1Vfj
	 NpBl47ZIEBmQi+hd2I35vuL6rVSJmQAIbYYxukgyjDWl8CA4X1rq/p44LtokOElxZ53Q2
	 y+Ybwx3P4gdTAjXGNvHol5Sns5X7wtBfuqF4k8U94zF/8yUnv6T/aJVP0kUudwTYwW4K6
	 EwDcIWIDN6M0LbjROwTpS4gbyY/i7dArK7mI9xabTSij8fLiYfCnjRSoUVUi3dGmaVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310000;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=vCplkEWe36X7Q1at0765rb874dESe2NZ6O5FAdQ985njMUP++uHU5/KhhUDpivdkdPKh
	 p46gLC4WqVlt4/SOaX6lGCMwCbxUb0gAsiVmcuRva5CN9iDk0KJySOYenIsKyBmpEVb4i
	 GuUKH9QpObVlSBB2WRl3ksgP35Ftra8TANF7Y9oFlTJ2oc01QzvlChSQZhMgGEnyOpgMb
	 C3DxURK8su83zarwwF2CKhs2/HTUxtmoM5qzAUCnIrkUUjQLaDKtvJql07/2TLhm0BFmC
	 qTV7h92v+b4qZwBz/W5OF2QoXoFnWWNAPtdkmV885furtWyh0lg6hCU5KiQ428e/hyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsKF8Llt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B71606A331;
	Tue, 10 Nov 2026 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsKF8Llt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18351F008A3;
	Tue, 10 Nov 2026 11:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794310000;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UsKF8Llt4xkylbIUT46g7idN097o5jJoRSy2GgM/dvX7GrZPaR6Cyg1jULldTwOn4
	 3Xdcey3ib0cL6M+Kee6q+mFpNQLSI23Nn+lyjRrZrH8ER+KtxhWQfeZ2mvpe/7jZ4S
	 nd71XOFw5rohMdLNaJjxD2BKMBQlYFbXKSskN1XI1MaJIvgduPJtCKCfTE5LfHY64e
	 eCRcCQCZ1wmKbb8/S6eTEEiJjMC4gEDkv/PeEtRghg7cNgs3FWonfI5cJ88qYjFu50
	 2lTdKRqfh8lIfl1PJE8Nqqx9hNe8r0h2oOLH3DztOMj2c105MyrZWof+Ikj8ANkmXG
	 uBINLtzNRmMeg==
From: netdev-bot+sinfo@kernel.org
To: Alex Markuze <amarkuze@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 0/4] net: streamline skb_splice_from_iter()
Date: Tue, 10 Nov 2026 11:26:39 +0000
Message-ID: <179430999926.488859.4270273148397539600@kernel.org>
In-Reply-To: <20261110112325.3263078-1-amarkuze@redhat.com>
References: <20261110112325.3263078-1-amarkuze@redhat.com>
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
