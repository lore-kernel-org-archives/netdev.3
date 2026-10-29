Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262987;
	b=jpwrv2yefPa/gIGYtZHyI0KJZu8NyO3iUToL0ZnECgJW4c+lc78Hyil0xI1vxIb2sm47
	 F/Ixt1qKiD+YXhxo0H4lieibKmNkCEQK5+dynFK6JDUO9KTFkREadYi/+18ebfj9im9sg
	 KmEeHDecmKIfiRIMpSxOyZDIV1QC6XVKU1ZJlZAK6tKztMYr8SSoISB8JtW/vYYfYbMxl
	 PN6i8Of7dLgxqOs2+9Oz6hk9qxAmbkrUzPA5qDb88ThT9kNF62542kbKcFXwdJa33BD+J
	 nFACCYTlJPNqYZZ0aSd1PnGOL0Cbz6mI+4FgqzqBNasDRa9rtEmKnsxU3c9DmT1KJ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262987;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=jGHh7tdrVyq2AXWUMtXIIJeUPoX3wJOwQpcfx5IJTN5ViYsg44yqaoPH4SQs+UckI16j
	 jVpdL8a7G3u+HYmLS7GI2hykoa0OAqNIYwzve7dRBtsRHzw0euM0dUU39PSoL1o7s7t+v
	 iT0Yzs43KjIKvLa81DzUXEopEnuKrQyZTpCD/xLWkGhfziUE5Gtu3HfRdjy0ieJNyJGZV
	 bDEnBREvb99XmU/c3loIzMUxMYLu4gC8D6P+hmaD8Dhmmr1KH8Yge+CmVxMHHBvqQsnmV
	 MasBALPKNLC+1f5G/d9WFlgxoV1Odp35Qp9m/FqADoTmAOr5uoL0bOJrFaciP6td4kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TLSgdt/j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33A606A31C;
	Thu, 29 Oct 2026 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLSgdt/j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C256B1F01825;
	Thu, 29 Oct 2026 08:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793262987;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TLSgdt/jrJsw0eVhQNNN0d3Kt27CDdGtmD1RYWRbrd8CvvFNXrnyNKMk/KFvBgvnD
	 GvJbJl6eaFpW6rjcQnWRbagc6KqhY0YymgYSm2uI35mCYAynp/M0V7dwFIkrLKGact
	 P6j8WOLXXPlMqmDaJWabX2ROed2hQkgL2EM/AjshGbZRzQu+KP+TS6r5X+tJN4dkwF
	 Btuc6/Ee7NkGKPmFrTx9hvTqJw3Sjw1iz1eP8lncgUPCXwsRifUs5iCgz/Or4IWHY1
	 2K71/HqM5qV4nwY8hehwv5jiqhm5ATCqRCGm77zqK056um0tAwRB8yh/YHhlTzx3ae
	 9T/vMyqMCpAvA==
From: netdev-bot+sinfo@kernel.org
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net,v2] net: ipa: Fix double free of the interrupt
 structure on config error
Date: Thu, 29 Oct 2026 08:36:26 +0000
Message-ID: <179326298634.3327.15347965057111904898@kernel.org>
In-Reply-To: <20261029082100.17722-2-fourier.thomas@gmail.com>
References: <20261029082100.17722-2-fourier.thomas@gmail.com>
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
