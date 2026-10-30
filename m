Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334582;
	b=ebYbvOrD8fRfbBqmrgNqsfmDnCbWYllERgtG0Gx84bmGUqnhbyi+9CLXNcouMcljp9h+
	 xTvRel5gFw6z24WFuas9/XqLP8gCfAHudy6sRCLPYg0ijt9/ZwGGOoC0Tr7mF/Mv8eKU4
	 rrWaNBy1eYixGBbvxGKB20ewRuZQu+hOi+HCkluJB3w62yeYVCdHcaV8ULfyxAnhqF/cr
	 sG0odEfXlnT3PcvZ0z+Xeu4tPHMVbIDwKfrwyEQUSoCMkqva3Yv3Ue2odbGmP/XzoCye3
	 xXGbXHJbCyPviue8b7JCvHKrccE79B1VQGQ59/jNElji1C/xiFr59qhVMtz315gf5eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334582;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=Zau4mPpAG9t6s/CUSj05rZC7DSRcV1l7jiUlTG3jchMAQGUwX2wzgmYjOpL3DAJvJ63D
	 PUDgvke6UT/BQorkoJ+1Ru912LyvDKKFfDEiG1dBhxSR4u8ckV7PyqYJPX4ZPDTzeTPyN
	 PnBjXS5BBtQFRYD/QQSuxu5GC80nW5OnZZ3ROjDMegRKLm1OV9rR1dtORUAdnW44BkXm/
	 24vAXm1z8omPw269u03ODK83LQaPjtZSzxewg96TDqTk5inBiMHIdbfzlgLtWXFAN6s4L
	 oX44cMkAkZGXY8D5NBA19FSCzjs9M0Bu+puR59MvBStDTenDAAfErMDn7szOWHkE22A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNqypEZ6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2722B606A31E;
	Fri, 30 Oct 2026 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNqypEZ6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716781F0093A;
	Fri, 30 Oct 2026 04:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334581;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hNqypEZ6fG5hYVca7eDJ6iMtGqQ8z5fv3vHx80i5SNk24LF1WIUpaZESjHHtTlMPq
	 AzKmvCVbKYe+yQmie95R2P/Bsr79YkI7XMGHY+3xzEA1ivE3gKe4Myyki8I9Mqp26x
	 V0cIcfJGavlBHLLG6/uuCDStkQISOmz7P0Pn3XRTWvIwjgOUV+tMrd2ARRO/awOUy0
	 nDNyZ1yrIDtiibhy2gv6wtwuxt6OoS6fH36SqXK3so8JAf8HobfgqxnyUZZFfq0xkj
	 Xeycqj1sb8xyusVJAO9u7yqj+7QQEMWm+PgzL8sADyHpqoR8/GctN0ntfng2xR22aX
	 TVLrnlLLR/8kQ==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com
Subject: Re: [PATCH] mpls: reject headroom that overflows skb header offsets
Date: Fri, 30 Oct 2026 04:29:41 +0000
Message-ID: <179333458103.3327.13553496515894121369@kernel.org>
In-Reply-To: <20261030042246.74144-1-kylebot@openai.com>
References: <20261030042246.74144-1-kylebot@openai.com>
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
