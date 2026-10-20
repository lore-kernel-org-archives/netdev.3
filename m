Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527547;
	b=4jEqPXS84JMjOoki4gEhFWz8aRrDdAJyFAwkeF8WvDII9CQ3rSCxa3UgsH8I7byQppkA
	 InVNN0tdl++kbl+4wuoi6JknFSGrP/zqxSrpIlIDwmMGC1x99oNEwUlwgt2AtNjlPI2Mz
	 44SJcXl/GBCqo5jN6fRa0GxAWdq2bdgK9QaA+0OLMNv8IcCShAfjZSHNOXsEFHrO59mAz
	 Q8hBZRGhpcBE5vbiKY/XXJiHNdzIBwpapjpxQEsHVUQHWOTXJBPnLrvsSZOLu5ALyLVea
	 K3FmZ8IAI4IvamQaud3oOGlPwyXCo4yiUP3H+/vwMh0+Q2lm1IKbArH4wpUqMTFysPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527547;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=PUdLxbscIb4hly5FxCGssPwA5o7lpefPb0nDYhnwL7I1LxZdQTFQzYAjk7mbYU76YxIY
	 CoBs8iCwlTBSxOYf3VbiSaICpyS/dSMzVqcWoTANKf9ztU2prmQcV1WiUFMBmptP6HmNL
	 dhOrtRX0+xQl9qy85WyGS5LlaGBIW/lNS2MZ/g/wTdEfX9uhqYe/raKh6iDHl8Y3huZMR
	 aLm+N4f0A3hZoQV4UnyE4RbsBWzJUgIgU3hNBs0JEvCEKGrzEy/NwMNpTUqAEoDr29AVM
	 YlMlU9uSvi7eBte3jQhCKxZajpFNf6u3yhSKmp5XWCkziBckSWyzEQ4HyxJzGlShjzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NcAs3Yhp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2BD606A319;
	Tue, 20 Oct 2026 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NcAs3Yhp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93901F000C9;
	Tue, 20 Oct 2026 20:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792527547;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NcAs3Yhp7WxPDTr/j3nSo4Fh/nHEWAagku1bNdhLXMAG/EgSeM7mAWB+PyzEa15hV
	 t4A8h0f2ZIOHjpXHhsdMc2kcxKMgBsZlzOtDNQZL9bdgHBOF0ejnCY7hWFfNlfspMo
	 f4Qv8KJEWonV5vXPC1tpmIfa+WHrgZlPe1eod//Nb5exmBH5ftxD9P9J5qNjtYetwo
	 bc0bbClCdT6gUxrKeESQyAkgDB8W0rXJF0MQuCrPURcgexLw9rqWsc3DcgpMKlNKzH
	 ryU9JJ9SHDOgnhB0BQYh1WDgJNmk+vB+KBtU8CfRFe37KtWtqQpCDh9xncgBTDxTuW
	 wyOR+u7fTM7lg==
From: netdev-bot+sinfo@kernel.org
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] rxrpc: RACK-TLP fixes
Date: Tue, 20 Oct 2026 20:19:06 +0000
Message-ID: <179252754619.3290.14188388324657533897@kernel.org>
In-Reply-To: <20261020201258.290827-1-dhowells@redhat.com>
References: <20261020201258.290827-1-dhowells@redhat.com>
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
