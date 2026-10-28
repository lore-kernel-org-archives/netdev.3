Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793183116;
	b=2r50/g6cZCPxEVlKDiA42k2b3qYoAbQqxxQ1YUB/6H8KJxqT1O+8EDX66bnnaAjc11sz
	 +6PMDCOrxqBxT1fBFPJMurhnTC3FlwCc+a+0R5FKNRN8thLI3o7w74urcMv8fZ02ZRIAw
	 wt5mgPodWjdQdL2cYIXuEstNjHLxAJeh/vKdv4jENIT5Heldvbb+PcUvpSwu4sO/AGj7y
	 9qJIJYUBGE6YvGSkM5B4NyE63vQ83mQCYIJFrlEiUiIJxk1FUdsJLIzw1uIlL0Ho7C7N1
	 gve4oN+qHcp08zjViuYu9aSxzIOLZ+foKizI8JuFvaMXcMzhjf0h9fpFJttqk26K5Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=TGh0Xk9YEQItGiDKc5Y7fxCdxmOovuxcBUNkmB6HYPaT1OFXfUTNNtpX1+9QWXqWN9On
	 WZMtkIpkMKwskApCThlRy1qvgwTWGO40N7znPkD4GC/PHYKw0eFQB/iRFgyR47DyD5FnI
	 WC/e2EX62PVbwzKVwJ8XAQSn4SoDOtYSpymuiASU53496fKcP3wPGKvU/EL2OTg1jSxcw
	 j/FZsw6IncgfmlQ6qYpgkRKUt49Ucy9doYJlsOdfetE8yYs1T1kxuxrmkrkGaGgHSflWO
	 ij6r7DCd0LRLmD5ptbeZnM8+pPA9/I1G92ozSnN49YcpnQv/aPZ2rUWDxKb4g+bA7yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yfw0j5P1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73A606A31A;
	Wed, 28 Oct 2026 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yfw0j5P1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B5E1F01825;
	Wed, 28 Oct 2026 10:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793183116;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yfw0j5P1u81H93gf0ytvjdCqrOo5trvtcPWZg+crJLHUHwuROw5DmEPgL/RbcZkUl
	 E+aQMKUzPSnswLDKABwcyYAL5hUXjnlxa7f4pbyB4D39GGIwbnou7b3QluTqnZtU1A
	 qUI3zhI3pHLUeZF5hvm/iPK9+y+ySfvc1/og+WOPZyRjeLNZdgqnfKMh1epLjFvaBO
	 DiOx2WzSYNrjvVKrLEhYQ8UNNlvIVhWMIYdfnDm20JaLy+e+0y/UNqYn6DQs/6oOY2
	 egoVzSJxfooo1QL5WCB5Q8IrRtbHHB8TbvAXN+bF+upF/uSvWkbICD7ADLwPtsOkQK
	 7+KHF1duM+U5g==
From: netdev-bot+sinfo@kernel.org
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipa: Fix double free of the interrupt structure on
 config error
Date: Wed, 28 Oct 2026 10:25:15 +0000
Message-ID: <179318311520.3327.14794092372073592903@kernel.org>
In-Reply-To: <20261028102327.28263-2-fourier.thomas@gmail.com>
References: <20261028102327.28263-2-fourier.thomas@gmail.com>
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
