Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793435101;
	b=PjUK+X4t5d7BJqSElQQNEfvGuU6ZFK3vLxlrTpntbV0sSPsntJIVubfU7cFaRYvkbaud
	 Wb65Tex0PXBuEx/nOr4smCqqkLzqlKkpLm5Rsn0LijQP+NlU08TDsLOec+ykSci9Y3je/
	 1CYwqavSHrWmwhH3kfSmmYCj7unToE6WVQPfFAvG7VVxclb2EGViTBMZyYPWhu0k+5hMR
	 NqSFvtG6hvJ2X40LMLQRyY93HSBf9hEzBegzjirUNdsL7S+799aZ9IIDKR/RN40x5uXoi
	 0/aWo7vSVSu7Pq/fcaF3JY09k1PKvjTp0WA8ou0cIyJv1z42OCvAuqNVr6P8WkqmmTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793435101;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=RVgYJ6Inq71jVwMwWlAjbceK7N40SmsV5MFDy9UQh4j/WqCZ7A84gARMLoJ4nUyFOfXC
	 MOVdf0gAC4rxLzXh6whXIWOVUFWySCJScbnHf2xISklvSQFbeShe6S+Sc2wziqkGrxW0g
	 TxQlIequVDX8Zhl1JcazJ6TL/CMJo76YhlqQJK9nqDlKPFtohJ1uOm0GjstZKKNEX08Aw
	 1q1ix4qZ5mee5of4lrvLMEu/AjJdMPBA0j1WtbXdtt0Q6JdWr/1p5t+BQRRYhphEE08LF
	 +bpXSx6InmugJCmkHKY0H7fchnTT+MTX7qpfLxalkzaEUvTEx33aqMotWgr9uUAfkgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuxZGzzJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8772E606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuxZGzzJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F7E1F000C1;
	Sat, 31 Oct 2026 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793435101;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GuxZGzzJ2P12fnHXYKjtmqBRLlXOzdfc+CfcxQe+yqw9EHfB3zSnctI3ctHgXjE4n
	 YNT7FnarZ9IR6UPenbbHXmSfPuju50Cu6briRJU8Es2cauScASFoZmhW4E1vC9Jt84
	 JrvuXg0my7CNfwrPVF/eb/xdfLOtsRjHGiSAq75IjPREWxEzj+4IHcXOUgCUUnR4xL
	 A94IkWaKd6x1+QnXFtUFpSfFO008QTx/7LcbNmhVo3Bmg2/lZuPk5v0C/HNX48vzHV
	 yYiCtYq/WGk6l8s4/0Dwz0tNpRlWmnS11e6h3iaqz+UQXHEzixoCaMXNdn7hqrN7la
	 PchgdoYAGy61w==
From: netdev-bot+sinfo@kernel.org
To: memoriaru@foxmail.com
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, johan@kernel.org, kuba@kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net v4 0/3] net: dsa: mxl862xx: bound FDB dump walk and
 validate BRIDGE_ALLOC ids
Date: Sat, 31 Oct 2026 08:25:00 +0000
Message-ID: <179343510012.3286.11131587555804022012@kernel.org>
In-Reply-To: <tencent_4510E934B092EFBACA56C572150338051B06@qq.com>
References: <tencent_4510E934B092EFBACA56C572150338051B06@qq.com>
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
