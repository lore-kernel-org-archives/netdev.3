Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352596;
	b=ONXvHbWT5YOZ8uj5rLLcDyEk/xvXuUeVDoufVrnvM5TFIvhWNaASopvyUjHpLpArNT5X
	 Ru9DD7P3wo2OVtwFnObVkJ3teBkTFgwigwQnRU8kLbh/SkiYcd+KvAzziKotqXg4UzOQQ
	 my3pdB22HBoU1SYfEv44dnvPgAyDeDhAl9FCYAHFPCc+uhU44aav4LkiXXHpcKIokDN3K
	 nG956mdw8uqf6uV9+ed6/QvUtqDbb/oWl5caFg1LbglMqDNRNU6sMqZlYJiIYUBZSu9al
	 xMQEUBR2MNbIKonSsI2Ap+trWsf1NF0eEuqd2LazjdM+0uuzzpcf82veWGVPB4jOwxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352596;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=Zt7xqCollMVlBrpuecuN2RyGmXtf20NzD9trwFeTdKmiTNX4zbcK8Qr/aFKf3thYWto/
	 WqRFQ2V3a4Af7Eiz8VZNPL2taYtsRuLVE9vWo8RvbzVI8DHixeIOCvCUbHGfUWaXHGszq
	 8B6TbmM615KBpGi5g091DzZHR3TCMK4WxfkmR3Drt16v/GdmQv31QMdwuHjGJlpHjjJBU
	 MPCLsKdbTMQnTNjaL2oPJJjjLTxfMmJ3W/3Ncv/XtvEpmD7sGaEXQSOtBRn0vdKLOAKE0
	 W3stCcgyhR2MNKAfq5Ka9D46vPgF0NfWr1IkdD/jEHk8Ea8fnl8t4b4wBBq8l4EYigw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHlzI92F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9823D606A324
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHlzI92F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA101F00A1B;
	Fri, 30 Oct 2026 09:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793352596;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YHlzI92FmhtlSk75eFfQuVNT6YB25Y59vFs+ZM3I7l4QGlY//Sje1o2UoUju4RkdK
	 vl5dFIxGrjvFUId7E/KDGcnHJk97bDt5gF7ZSl/aAnoohbK1aDJkFNpRUft8M5ox2W
	 t4heGzJiucwbwnQG1SlwUXrkZVUuREKHhe7refsG22a40GN5iCjtR82pIzrgZ+Bdg+
	 84CVd/gVeF3sJfugUzsSSIFgjo4KPeHbgGafXNi5Ut1FjTPJwtHSHMkwqG2kLI6izY
	 VMCBNN1rbJOup9u1wJEbb1VG6YPit6RLPJu0nuXwonQVT9ZxvLWitj6t6TPnkAK3yi
	 SMMRf2+Tdwv1w==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Katherine Leaver <kleaver@janestreet.com>
Subject: Re: [PATCH net] ipmr, ip6mr: queue netlink route queries out of band
Date: Fri, 30 Oct 2026 09:29:55 +0000
Message-ID: <179335259510.3327.1683212245601111309@kernel.org>
In-Reply-To: <20261030092303.2749386-1-edumazet@kernel.org>
References: <20261030092303.2749386-1-edumazet@kernel.org>
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
