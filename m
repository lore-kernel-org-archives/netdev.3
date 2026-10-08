Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90504447813
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463552; cv=none; b=CJgn+drrQP1hnYag0WWDoUotLEhGEma2qhhtr/NXFzjLmWYRrLS7aWEoN2bVrCjBxS3C1GTVqtVzx0XK597cqjc5AZnYLJlzjaF3MNWKpG2Ex12DT4vurPYH0Lw0Pov9F7YkX52vMAJMBJ9uQ0i4QaRB9dByJf6YAv6MiId+Fbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463552; c=relaxed/simple;
	bh=T80pmibn7aSi6N9hDzJvCBDoLXDCN4HDH9fhrQVJ60g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sGKNHwR7PbknnJ1Zr1rWTrxP/JlEaBJGrMZ8Soait5k24hVMHCdc44u4fFz5wjb8ACORqnVHwnlhu/lGP831Wim3LAtyciKilgXJsw2FSZjzIt3xQ6tKgrPkwIrQX4W4+qXb4Z6PMI5pCq6adms5FI89r98H+G5ysvrepRwHPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRCX9r4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRCX9r4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E703B1F000FF;
	Thu,  8 Oct 2026 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791463551;
	bh=ZCAoLYZlSrLohEk+mBrzJi43HvKosm2TxiN/tMhp9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SRCX9r4ER3vgNI60/NRpEZT20E+eJ1txhYLymGOx8rlDnhjWITY+vnCS1dWihGd0Z
	 78zybZO5vgocCWCa9VeAu9HaEfawaNWaUS3sxuDeic3/XSLFaF9QFV1pTKQdDKWJNc
	 ctsiDTuia1yLCtG9QCsOL56SrL6m5pPjL+yITaFT8cYaFDin3JQxE87tuew1xBYIK7
	 +FqKMwwo0F2iNs4Fah3ABacbFaGMsfoqpzXV5CTLhsS/MlcntQVgzqg6v9EOIt16AE
	 ahYYHvT0rhNwuqTIK4YUSz57jcsblkiiqbDHn8BjeAVtTfJ+GUTEzk86v952yTc2g5
	 Q/nnMdVp3efpQ==
From: netdev-bot+sinfo@kernel.org
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec v2] xfrm: espintcp: reorder operations within
 espintcp_init_sk
Date: Thu, 08 Oct 2026 12:45:50 +0000
Message-ID: <179146355044.2527009.4376228772474260256@kernel.org>
In-Reply-To: 
 <41fee34088a7ae150f255493b40f54ecbdc300df.1791462408.git.sd@queasysnail.net>
References: 
 <41fee34088a7ae150f255493b40f54ecbdc300df.1791462408.git.sd@queasysnail.net>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
