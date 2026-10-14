Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9A72F6918;
	Wed, 14 Oct 2026 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791942014; cv=none; b=dmX53U1LWqroYA4kI7Ak4NpA6yTjEoCpI2P47BHviZ2wpy1bIl3mUcC2pOkPuqH1hmRf9CU35z+ZT1BxNSU4JYuWALB5MDJ1rEXN/+0Gsmbj2if1XpB+vPpvxKYzcUzylUOZeIRmO9xR3htpQ+XKAEk+zq/804cpwlWEhIDWP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791942014; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XqoXXUPdlt6gZonvjG5b00p2tWMp1Q/LdOIfClDG04fA7iYIqUdXGTxu0OJm41N/S4RAfnx1D8PYLKOl8mzmW1Wwxip4PXta8B8xd0jL32uy5i5+bfoldsSnt9hKKppOPqlJ6MG8RszREEPrfqs8RL4KcTGnXZIxOWM0BHgrVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+W62/Ld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+W62/Ld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E22C1F000FF;
	Wed, 14 Oct 2026 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791942012;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+W62/LdnsswkNjlkyQ7I8GGLCKM5DC53f3rZev2bJYa7nmNflLssYNZwQv1MFP1i
	 FH4nsEl1e4dS2gSmwIh0FbBhVsmoflchIs3IWxqzb9XviYcfdlTSDefrdWs6z7b/AY
	 HZ1ToF8IfvJNOVqnuSufu4wjwbtvOjj5DwrubyCIg884w4Ep04edn1NKNUnkKQsIRI
	 46j6Z6HESpHx1ovGbdxoFZvb6oMtegFxXxcRbgdp41xmAw6pwtU30Z+pYkAHN+p7JK
	 OsRme/p407PPnlwNfD6csY52dWSg1lj077dbYH/tis67xxHj5qNVQJ722ECe0XN16s
	 TjM1hGKn9UCxA==
From: netdev-bot+sinfo@kernel.org
To: lirongqing <lirongqing@baidu.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] veth: decide peer queue count from the peer's own attributes
Date: Wed, 14 Oct 2026 01:40:11 +0000
Message-ID: <179194201171.160550.1001715704134094403@kernel.org>
In-Reply-To: <20261014013620.2497-1-lirongqing@baidu.com>
References: <20261014013620.2497-1-lirongqing@baidu.com>
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
