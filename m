Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433C28B7EA
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893147; cv=none; b=QyjkFQI+On0vLkfBpJejK89TDCzKX7KGsfn4pw32UCKTkAjwtXi8GS7+BwN0QsOGl/EAZSImyjzuALwfiioTPFkimTuWWZfncvdYtAIDnFs/4A7h7argH7KAuXiVBMyNs27Im/DgiEY0tBOlw7Tx4WuB7mw2W8RCxFMIGQ2qgOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893147; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MJhTiExvC5btKkaZGILoM6Vsq/codmDEQ3xd5QqdLTBr1UdgQy1xSnp8KdhKSgQDCN6FbVJIyWqP4f3rOnGrRkq+v9HnpvrB7gI/dFHrtD5ltXt0IN2zOWLMWNtr5VeED1QsuS/A3mRBsgDnRybMgyOI8WJgnMRpkPYjlAqNTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OS5GTJm3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OS5GTJm3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25381F000FF;
	Thu,  1 Oct 2026 22:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790893146;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OS5GTJm3GIOrDmZm4MihkTlNp65ud0J6AxF3vc3XwLXwxD1p8nW84kf78sb4NRmQv
	 7d1efMX07Jff6DhjNi2MkLabY/K9h+GdRQeuTFRq73/06bkiqvOOLKxPxtKBZJRg/P
	 7RfDMqNqldGogtS6BmLH9qwrLfMbGPbaX07/YuORqX8cJRdzx1cWEyUX2IeLosfWEM
	 RjtA9+CZ1b5z5VyAoU3M+WLmUuRxd8ApSemkJFCE0WuRkxiRtvpYIahsBHcGtrnRqH
	 Jmh0VdagTqZtUzjTet4kPK/febzsqWygFugaMq0Z21fsVwjUebTPdBxRwzT1/klu/P
	 ad9NZr/elRNLA==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>, edumazet@google.com,
 netdev@vger.kernel.org, Xinyang Ge <xinyang@anthropic.com>
Subject: 
 Re: [PATCH v2 net] ipv4: free inet_opt and ireq_opt after an RCU grace period
Date: Thu, 01 Oct 2026 22:19:05 +0000
Message-ID: <179089314514.1402591.12516832232538534095@kernel.org>
In-Reply-To: <20261001221253.2964024-1-edumazet@kernel.org>
References: <20261001221253.2964024-1-edumazet@kernel.org>
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
