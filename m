Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093453CB55E
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791532215; cv=none; b=PQ0/d3HkVqq0JwmqBtBkBIF8I8oxs0MU2iTXC5b12DOmWiE0LH6RNaFtB2oMwnJjtz3bXRz63T3YgWC0U141IP8SaMQPv/BI6BidE6ECPSDTGCkLhd4rvMiA6CnfszPVzEwvF1aWeN9/iBmY0dfp8BJx3jER13YrOIB9qxkceUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791532215; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ivd6BBsKt2Y2OhVBfKrX9u8XV91IUoPupEggsAPwwy2yXakLMvQfO4t4B2jdZtjuf6h0ZqHu3xUMyb7+bcO2Rvpb5YDAYPgZFxJWNZMabUnFASLGSy+qGsbWkpAYEjNFJz7ze+ymMMR3pMVyWaTU8hpaoEjNkSKxy1UadCMG7fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJB8P8X9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJB8P8X9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E259A1F000FF;
	Fri,  9 Oct 2026 07:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791532214;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJB8P8X9U55JfTpc11N1KctJ8zaSMln6+JKXv8NQDY0rSsK6h7V/q0Z9f8U3RqffK
	 j5km0ZVbqkh7WNVF4WHGqchtoPMg49PGj2jqFpU/8pJVxdzNUZuOBEkTJU30MHb8Yv
	 TnzeMaqobR1kff79/hU5kLgcw9Rqw7B9BVkG5pgRJaTXOkdCKTl7b9Qrxgqnw689dp
	 EV2nPSAEoCoWyq4HNHXGuDflUWJ1qo6u1QxMz40N3V8nOAUxjau4pqyjtsOqkGaR3m
	 gHQapZFUphgmt0egIWd7PqhFTBPZfobE2O18c60GDPrc7gBW3iFHa0xcGcip8pPb3d
	 OzgggHKMkNStA==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Baul Lee <baul.lee@xbow.com>,
 Cen Zhang <zzzccc427@gmail.com>
Subject: 
 Re: [PATCH net] ipv4: use RCU protection in inet_netconf_get_devconf()
Date: Fri, 09 Oct 2026 07:50:13 +0000
Message-ID: <179153221344.2527009.10357629258604832185@kernel.org>
In-Reply-To: <20261009074405.727999-1-edumazet@kernel.org>
References: <20261009074405.727999-1-edumazet@kernel.org>
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
