Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710678;
	b=2tU/FRkM3HnO2Wz8B+tarkksoUfkiJNBRp2rk6RV+7YssN8JWpeywmasJ9Y3N4eqDO8D
	 jPMcHRRY+0xRJaFySf5PJU16uhS7Vc/ov4TF7lNSGyO+Nrgrnla4QgsWV/JJUap0KeQz2
	 XZPrZnuJ9X+V57z+T4MhkH4hz9hLm/ydd00b3tNE7q/Vffc5b3qKRB3uYOMbkmrFsTGLx
	 BLX/X9+ahKAVHE8y6Nnlmo+D+uwmqW4eR9JFPUbIa1AE3ojEQ2Hu556jRUNkFNssKrMYB
	 KsvANxtit3wGz5KlK0n4Ma6p0AEPuw+ffDVJhUW5nkNhaqtP8nGg0O8bS8JvXCd6Oyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710678;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	b=RgDzfPCEyzMERLYOf2gK2I9m55r2Kfu3xC1M2BXIPrtS4AG0PERe3hqRuZbi+JJRlcUB
	 icWPqNM1aaSJDuX9jtz4M8oFLvCQnuZ9yAXblaNPhL/3ldeCQS8GVXkYNeOlqBb8dUo/F
	 S6LTtCXUlcyMRlXEqJTa4OHpIr0GBm6zBC69l54Wy0Rc7CeOOcUKN/61Sx9bE/5EyaiSf
	 wTta/X7IIoBL5pqDOnJKYB3X1BxqGioE310r0/He86sQHB1p3LgTeYx4uvUPoJ2cMOceG
	 ZToBtojnDeDAEKdN/DlAPUMt2v6U/IGYau7M82tNIOT2yEoxSS7FPw4CxvxTR1iZeNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRisK+5p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6A606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRisK+5p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0951F000C1;
	Tue,  3 Nov 2026 12:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793710677;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iRisK+5pP2UrVoInOHeveYqhDtIybigMbQji0qtGGyW1M8NXOD2glkwOgkcLUZyaN
	 IdbydmAUgG8/V6ZiwlAuaINbHCjDdk0XGpUCCLXf9vJrPQRCIFKTjnf3CAXQji2w/r
	 sJ+ZoRGi3sRwlObOs74z0MwHCJi5FNmHBOBGcUPCjVONYs2KMrmeoFFuta2JIFvRPu
	 Znp8PbXpKBtP/QeXIwYSevD1PSa9DkH+a8I94BeVOLGmThICn66+AoiHmG+9WYyVa6
	 OiBTdr6yPHh851xy8kreFJPWYQ0Qyq/t55YlmSp3GwfiIAmBlmRwZcpKuNmbkoMfPU
	 rWnAG9zUJhxIQ==
From: netdev-bot+sinfo@kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: netdev@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 1/2] net: thunderbolt: Stop queueing Rx buffers if
 allocation fails
Date: Tue, 03 Nov 2026 12:57:56 +0000
Message-ID: <179371067643.488859.14324571824995570678@kernel.org>
In-Reply-To: <20261103125621.1111198-1-mika.westerberg@linux.intel.com>
References: <20261103125621.1111198-1-mika.westerberg@linux.intel.com>
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
