Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439649;
	b=vpRlDuQ1XYVNcHm9eNywg76SRbYjPbf6P4vITImCI4kSEYsaz6UI2RYJT2NaVCdHcfBk
	 meLFqSe9XHyjC0SmQtI0rw16zF+Dsk/71qmqZFbFAiwmu6cIEreXrigkaKc6lRaL/fi++
	 e7l9C6bYLgchVWaQm9XG9ENHBp3F81hhjQAlBl31EEfUweXSJ8II3ln32my1l5mIKpsix
	 USjJ3weQSbgcwcnv9+AeEJNfFgPb0FVXAojXebHywBh9NU26NSE0O4DG+Vck6PM7dqvmg
	 kEKpWnG0+AJMoiu8DwSdxZJTZYMyXyZzlWUMXtXQxoR48/5Zl0Lvjfsrw7jGsax0Q8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439649;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=G5WuFuEES8MD0TwCU0hx7gZjN7t5uSU/GhN2lmcIFSZP1GTHnOMDsKXqVe0Y2v4RIZUe
	 j3vnsLipAf8WMQaR7c2rJ8QZ7O2D2egp8xucsY4HrBau1jahkRK9LC1C4mK2lC4V/hdr7
	 ImfsIufF3Cafp1N06cvHOyUdilONIPdEabEIfXxOttyeV/oYnHcvrivREptkWLvVvjrzQ
	 AVGAgAWQMW4yaYSEEqCzvU6d2qTLubAKLDlzSrlAZYHGsiL+vxUsSMwyDVH0Aqwnc3eGg
	 YxqmAhzR97b5UIIad8MVEe1qulWxj27H+a+8/ht2UrRDpL4YG1eEkeJF+CJ0qsBXJ8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHtEdtJO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BC606A8A1;
	Wed, 11 Nov 2026 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bHtEdtJO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2DA1F00A07;
	Wed, 11 Nov 2026 23:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439649;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bHtEdtJOWtmP8OA24tCHtVzLz42WsNioD9HY6hqvTJTqKpR2m49FJ1VD24SGNtzsF
	 8rm5Gd1XNfCKgAf7Im5cAIIjs5a7PGTBHPeFveQXs0D1s3zyZQMnwVrOxc4SLo8LYk
	 gi5VH/534Rf9rdfuMx/7hac557s/VHHK1B2u9b4jE1TLNxnG6POmn5lC5VIxjwe9dP
	 jiOrZ0rdh5IdYbUdRP2dEMSHEXRBwql92hRfsGXBsJDh+hVaot/HelMx2LlsvjpVj7
	 euGW/PLovZWd40SJ+kkjY786duzX7rmMsC8uKEU3GWCQ7jhfJhGok/JGde72DF69WX
	 vcElD9GD+99Og==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 0/2] xfrm: fix IPv6 atomic fragment policy handling
Date: Wed, 11 Nov 2026 23:27:28 +0000
Message-ID: <179443964800.2168702.17280818098554954153@kernel.org>
In-Reply-To: <20261111231853.2504833-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261111231853.2504833-2-Jeremy.Jean@oss.cyber.gouv.fr>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
