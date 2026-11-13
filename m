Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598917;
	b=L75wDogIwWuQv8Tz4bjHIfhZ4ENOWu9HBOTZVMDRdPF/h8wiWtzxthpFLnIXbMbOWZe7
	 NR4MBlhobx89jxHsMLpkH+PXGg6homDmtHHE1zWRfpU5RUhcduPGMGaXuVmMNE8Y+QJSq
	 ENvnCb48FLeMeSdY6rJM0CiGBcMjNXrfUzh5wEwBRB+oQN/oGgdH4oRaDkViivqbjO96K
	 xAU/p+5K/n2O4GScXsoLSyroPjb6mkyXjwGopKEFxE2UaBB8E+t2A25chCOPzyNPaLft8
	 BbgLX8FNOM7fG0CtQY8t1PxSKF9K+Nt8N/bkLtOx9A/apWSXRSk4HpyloZMOol5gEHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598917;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=fWViZp5OE2NtRBePgwR/AX6Mpeo4P9ORdldVMfAYdKzl9Q1h1c1wQ73OdrOXXYP68+UD
	 I4UxNL+taFh5bYrGr8xYeZpturyAjfKwypdN4K5X7UX6k8MzMW8ivrM2+gDhOHlizrXmJ
	 3lNyqmuciFix3gH2CCb5B7dA2gVBmIJS5bQSC6/TY0+TgTkwM8Z5CEsXp1hwCFt2Y9ICY
	 Fz8mG2U+7t3Aa/EfqZXwq8JOVDQEKKr3G+axtLjfwU3zU5zju9hnj66I2OJcibuoItOyd
	 Wq+t7H6ehLdjxZ70tXvNw0SAmjx6DwbCzNsagy7kXKqxchVJkwtscvBicjYCUmerWSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSI5N8J1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C86606A331;
	Fri, 13 Nov 2026 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSI5N8J1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BCE1F000C4;
	Fri, 13 Nov 2026 19:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598917;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bSI5N8J1rJbZe4tb5pSeat802yMzcEktzML74O0vmAVGYXi0rDwU+BTarTYo8UPaK
	 T0xnx/pOEzbOxqAO8M3cxjDpvA2u6dCJCEbY070ivD2F5CXdjO2rExzqaW/k0s5aiW
	 fKpDxI2pHG6JcZMiO7ovGNoXi2ibD3JVze4mBxLShR9Y4xfzCc4eIhTfNpt0CVnXLa
	 /pcMH3iGHhXL02TiN68MUah2vn3d1iUt62R7zkmj/mr9uR5HXdTp+zjy+8/WSkRWs9
	 hJWwb3QpfhMKN63ekxPDqUT5Ffom5/sotSwJAC1YHl2a7lxFMY43kS4Ip63I8mEURN
	 8qnshs73gwFCQ==
From: netdev-bot+sinfo@kernel.org
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Benjamin Coddington <bcodding@hammerspace.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] tls: fix send() returning success after the TCP send failed
Date: Fri, 13 Nov 2026 19:41:56 +0000
Message-ID: <179459891623.2168702.5534679656595552608@kernel.org>
In-Reply-To: <20261113193649.3822306-1-hengyul@cs.unc.edu>
References: <20261113193649.3822306-1-hengyul@cs.unc.edu>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
