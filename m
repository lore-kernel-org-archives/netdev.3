Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228106;
	b=LBQGRorICQAnkQnTmBhgfnVMbYrlWF0h4Al+2aCiGP/NHJF/6FNuqMnyQP74mkSdYH1C
	 MNrOd+ou1kylGJdUHTWSn6XZtwoSFJCWFMLWgV2UZLAx31vO9Bs9xa7p0FfHV1tQS48aa
	 dSHnccI6Opt4sPTr4kC1gVPOhKQSytVni5CCyC6iq+dUqQ/P3NT5jPkN7MWe9biWNfzKH
	 jKhb7XMKRRDXveiiWJVFCHguXhFXK0TFgqYkWwNvQUEmkDT1qghwSRKkaE4ZU8vyb7IiR
	 SnXAYUgQXwwHfwT4Gm3SgOhaGrST23uYF5X2HxuyYTqZ4DEgrvxYCyYGTEVQkI2EZ2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	b=iwSmLZd3eryJggufFZABxJ1y7Vsh4ec3ZelB/w6WFp36YRsHDociyq7KwIBVGw18HFVM
	 Uc7XduMpMVy1hg1N52PSzM1Y6sl1MPDgTeWI9ofuwZs3YxD71bDPzivme/qQ1FHL1Hrkb
	 JX+d5SaX6QZOwPcUULq+Nj3ApumeJDuAQYjsEctW6gBdM8ZkuSr4+UuX/dKsm6DY1lTN6
	 nbH98Hq464KWZau8z3e5G9svTFrsTZ41klw+y0BmowesXJ9bigN4Uv3XK2svpRf/DHR2y
	 H67AODfZlelsOyOzORccHi5JIaUJvBmtXAZxjPFL71VLWb59riGqkeGdFtutQQbLHWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1MA8UE1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EF3606A322
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1MA8UE1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDCB1F0089F;
	Mon,  9 Nov 2026 12:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228106;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a1MA8UE1uyeitbKUDenR4u+xMiv7H3KpRNmPKJj3+WKiy47ijle2+T99N0ISBeG02
	 qh5D+ndj4nlbnL6b1bCKiKh2l8m4xc1ADsrxEl9TkFwIplTC9FzcfGjil4UsDOnZ6M
	 AE7i98s9ZgVJVQXqI7h9dIckGNcGr7bFiBI+0QYocf+/lncGWkTilhK7IJ6Dkb67XQ
	 0ke4YeNvIwP2reuQ1cr0ENq9Z+mL+BtUGOq/NclbdGkVvj7u8A04QjJTF+yBk42TG3
	 JzpBbSwfR7bFaTJxmay8xrV0HNPqUVSVoUg0lIR8fEEzTylKCiamb7Qw5uHAlINELR
	 bLcxkiwSoEiSw==
From: netdev-bot+sinfo@kernel.org
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Arthur Kiyanovski <akiyano@amazon.com>,
 David Arinzon <darinzon@amazon.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: 
 Re: [PATCH net] net: ena: avoid double-counting TX DMA mappings on failure
Date: Mon, 09 Nov 2026 12:41:45 +0000
Message-ID: <179422810524.488859.17451781840821419367@kernel.org>
In-Reply-To: <20261109123934.824610-2-thnkslprpt@gmail.com>
References: <20261109123934.824610-2-thnkslprpt@gmail.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
