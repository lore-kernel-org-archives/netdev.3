Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506884;
	b=TCuW2ynWQL3UwouyfB96FAu6YoJr1efzAWgVDp0d2vE6umz6appRCLagJQINstqr3KcZ
	 WR/kWjHZwRixw7mYTP7SNxZ1ACHZOs/NoofWyrt94qfZa2vK89qxX1ujhPDydZ+ImWVxd
	 ROHMtRUucCof1fdmxvl8UUlLiTw9Q4JANjZDPj9gnIqpac2TjiMbWL9mVobu2AMxJNbhK
	 viE9QMtwaXVIGJ1B8VaULJRjxK7Zsk9i51eBI66p2aymWiWzaxA3M1BoLwgpQ7Emy93wv
	 sCWP2v8cjIFeqqM0bq1bjH11tNXz/bKtR1kEug5fo+NrvAV82e+F8CKTqoZQtL5lSoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506884;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=qeQyyKUCh5LgF+BdWH5kNfQktIj7QEYv1XrdrqOAmDb08xxxTLmknxv5FiysDqeoDAiK
	 KIPe+O44jjyAJAEUIgF8XBHa9H8YPaV0Lo8guAuOibS/AjZPbm/Y3XdnNqodxSv03Va9U
	 Gg5Ei0qH9uqyEqYq38Luz7QJSDq1E80fbXilt1VdUpgKcIGh+4A5AZFANv09t8xaIa7Fx
	 1ojGQ8hzIRkhf/e/jjICvKByA6RPZJ3dkAwKgwcdw+uoEAJH9rrf7snsSkTYP3WCJQH1V
	 l+zRPKDHSWTSTlS1WemGJBpN8RCkSoIVHd/J4otEHS04Nv84oSnMg3mibF0AXKbvJ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5x6Xp33;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA14606A325;
	Tue, 20 Oct 2026 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5x6Xp33
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072931F000C5;
	Tue, 20 Oct 2026 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792506883;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S5x6Xp335ccl6TMMCJWnQJNiF/iDTr3CoUJEgw64aolvmWvtTduzoe5mRyIkBwD6Z
	 X2RT4TyxrQTzuaA+gVRB/x+X1wUN6iQL8MSPhSjJCwBXtG8OIhTwqUyE4HNPYLDbRr
	 jQCRJqxzW0F912JiloITCBpmFzv1lW2Q6xRKtZ2enRGbk1VqM0ZitKohyQM8uHayR4
	 TU97LpgEusjm3bRBLK9CSDoPXLmUGSh4rR4/tdhvmlpfxooS984QnseVeC1X3lzBLp
	 xSnLnGDHU0erI4PbBj6bUoz1K9sa9qJeMbSr1ptoma70H58v/Y4rzyS0SXGhZk9TYW
	 mtYc5AZZgs0JA==
From: netdev-bot+sinfo@kernel.org
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Martin Karsten <mkarsten@uwaterloo.ca>, Felix Fietkau <nbd@nbd.name>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [RFC net] net: force software segmentation of PPPoE packets
Date: Tue, 20 Oct 2026 14:34:42 +0000
Message-ID: <179250688251.3290.5503767358503525041@kernel.org>
In-Reply-To: <20261020143031.1829-1-qingfang.deng@linux.dev>
References: <20261020143031.1829-1-qingfang.deng@linux.dev>
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
