Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794163008;
	b=EYaI/SqF9cbNLuYCIxuD/mKvKsTlUy6/ganiIoBaaqcxvo5tXQR+Ax4lAkiR/ZoHO15Q
	 NZwKE1etkNGoZPTcarpFZcNuURX16Ww8hjxC5ndZBbSce0qogZC+dW9RRPZr5ezm2GZov
	 sXnifG7rOYwJEEkXmwQdc85GMhjhgLOtUUGFt/eKswwJjfrePG2K3LXkzq26PrOSnt2Uc
	 gaC+LjPsv4XsutvMDcfBfjJdHCVbasnVj/cPq8mim+fijEwOouTeWgabJBq8HFKf8QSP4
	 ftY3eXWzo8jqLnb8yYGNEyhzdVl92Vwo8FrRGy1+rH59dXj76N738BvSc/TPUz2Id+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794163008;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=Ytu2jB0c/MjnAyW/zZAJhT/FQl/snStJ8uD5T/23JocqWgsq7l2LO/iHngRHRcp6ftZo
	 OSeBm1gPZwcfwCkX1MBEx+ki6NCix4UW8A8vXpIgjjkKq1EyM/JUbUykcmB2d7nXnCCcb
	 BTKZbkM5VECAxpYrnwaIAhaJ+L6sAZVdPl625UQisPox+P91fsZY9dkCMMGuI8jeVj1yp
	 0EagnqCiTuZyPhEwOqDYVa1nnc118po7gmW+kmnrhSMZ2ipLRZ2VDn/cCoZnEvkNx5MwD
	 GfC+PO8rm5u1fbwAKr5vNpALfK4Zl4c3dQz5KgqpZQFDRoHJPxf9yMolUKmh2RpYfxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YslKVkgq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B8606A31C;
	Sun,  8 Nov 2026 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YslKVkgq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACBF1F0089F;
	Sun,  8 Nov 2026 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794163007;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YslKVkgqsdNruVtxSDkSzdAIQCUhgF+M5YuKKQHLnUCfflZolUbYK8V5Xd1q7slF2
	 VUOoJn/EK5iz+Vglat0HSjQ2MXPnEaRRvjBv79+eo7M/3QV03jGVpdl+ER0Ebk6G5e
	 pLhk64n0g6+rypWuPdSvufYYy42MgYygPGaa0R/ASUv5hq89gz7v8oCshbJLFOgQH1
	 l2m0s+qwizjYZ5LC5wTvxEliCdXfEsi/WWeRlJC4AodHV60ifemx+FoxUytav/4Ofn
	 anV60SvhZn19t/UX0PrazycY/GYRbbQALGbyq5QhlE3xempLUnRyDFn4iUgAYfw9Cs
	 3VDfeWLYbHiJQ==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: dsa: motorcomm: MIB fixup
Date: Sun, 08 Nov 2026 18:36:47 +0000
Message-ID: <179416300704.488859.6471400688518871527@kernel.org>
In-Reply-To: <20261108182931.1542638-1-mmyangfl@gmail.com>
References: <20261108182931.1542638-1-mmyangfl@gmail.com>
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
