Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368451;
	b=yKvOulIzGeVXNfB0SschmKthBkfGTG0kLBHHWGDU/HZlg2l5EKftcDiOhLxBUfMwlnRR
	 9V9/M6ZBamBWcKblnKvLhzD+AUKh8ANB3POjBoa0Jj6tJS5Pc1PWHQbwP2Rg9NaNwlD3U
	 2X2iprQMqwp6O+NcvmBksKvWAtWl+bTDMmq3DWTDs4KDvDUKakMRq5LETg2+5CiksKwd3
	 7K47LfeTKQL2EEZoFygNreAp++jtx0Mo5hfXTghHqkFKJWWBCyFsi9WeQb58mxPlSziR0
	 eahS0NgIQOlIz1YDSzmLZkt5ZLGOkO0JdEBQQvLJSPuL87Qa2g/gM23O7pcsvbf6vKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368451;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=4dWqDqSvsSF3Mr9nbVG5qdWtfg/wm4domx8Ps9b4zYcjL6YAKFt285YOgq+FYUWZmzLb
	 3ezNb0VDaDbmYpCqJd9q27A37zEsEDkbKKZjoqTlGlDUThvqWKV3U5owhyWtbNWXQCyOe
	 ZuvvUvEhQlR/qtaOAqTJCOwNFPHXEplkROI4hXQnBA14i0Mue9mWk8N2p4ioz20YyPn7H
	 ZgrG5dHylp0yPyPsSAHwn9+Ww5M1taKOEVAOBxoj4Vp7Mgzi1zZpYc8XpXm+vNMJzDttN
	 ZxI7H6eqFVjhovA8QvWNORytpwbx3Zrp6Ln/HLTYLIh1yORgdwrmWhBVdsjk63T2gPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NKx/QtNx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4473606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKx/QtNx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8351F00A02;
	Fri, 30 Oct 2026 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793368450;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NKx/QtNxvaXy4LF6+fqiasc92+h/amu3roL+fgyDve6otOFQYnqXZG5v+Xg7EThoA
	 E4nLppR+Qbs8ItR3sYnI+qRLhxMyH3u8aaJ1jWTOiWx1TW0ZzA++YgGWO9XeH/I635
	 oaVFj4eIazCYm/aTltX3BEG5qT3EyE5ISwn1JHnn4TMryLuSoyqNpl210hLGOPyMZa
	 rLZpLux1Xlz04qmUnN2B64NEGY0Pbv4TlYaKFVhqwpy05HQhXEWPCDwhwfUMzSzx9E
	 z61m1qG9BY5nSd2+ONdhm3ZcO47xTREt8erSzfsSMMeH6Bd4Nko67ZZ6Z+VXb1lYGw
	 oqRGwVKk7uurg==
From: netdev-bot+sinfo@kernel.org
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+a079f084653164a652d1@syzkaller.appspotmail.com,
 Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH net 01/14] batman-adv: avoid WARN_ON for orig_ifinfo
 allocation failure
Date: Fri, 30 Oct 2026 13:54:09 +0000
Message-ID: <179336844924.3327.3891347335688345941@kernel.org>
In-Reply-To: <20261030135105.2555887-2-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
 <20261030135105.2555887-2-sw@simonwunderlich.de>
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
