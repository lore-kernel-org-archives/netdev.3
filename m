Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD703019C8
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791037400; cv=none; b=g6GZdTr2TiUZOwwaSs+mT47UGx3tl+2nDFaS5LaUodHD1sylhHySvgLlnDcbgJ6LBjIYWnwSQBVWBMj6Qj40nLy+c+TGho9pTZ3GAY4vaDW9E2DGxy1JFZ35LOfHzVp4CA3mJpxLVdlPeKUzTrfSmYne/KbuIGESe1BwyMwVIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791037400; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TOiXT9P7myMaEetPicslClziyLE1sx4QrnwfIEgO1Yq6eIOdsxAHFsKWBLhWJrHJCLy2SMbxTEJc01dX0vLH0oxr8QkXuC0bvnTgaH9foRvxSPd4B/b/ekUmo5EJOr2DvQVDjUkbV3nyHabv0y3TO9pcez3QAT8A9tIFxAB7AOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIYfWPya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIYfWPya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE9B1F0089B;
	Sat,  3 Oct 2026 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791037399;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aIYfWPya5+jjzcbdUXND29acJOS2oH9/ANHilJeDccteAcrmXPvv/3B2nrO2wYd9U
	 iKc0A1UTqPdcjWOkFuYSAVCMHICfdsHBSyI7OxayDchQncjYbK1Axdws9JzQ/y4q1F
	 bMeY9SqS0PMqRxf3o3iCnpwwBXzvCUT9n/odBqtRcmDmXHFfY3Pa6bgeBMYDcybaax
	 CXTy7ByazxIMvSikjwrfjTZ5pOZf30CB5GjeZvQ9LCt+dV6cp98uhxYvQTJQv2nUPp
	 WE93vdnnvKGBnDm4MjmYny4B3H4plMcLS6tM/6+phGQ0E1ETJI5JfsgL9ivd1o5mXM
	 RFzeGIdwkvOkQ==
From: netdev-bot+sinfo@kernel.org
To: xiaoshoukui@gmail.com
Cc: netdev@vger.kernel.org, jmaloy@redhat.com, tung.quang.nguyen@est.tech,
 edumazet@google.com, w@1wt.eu
Subject: 
 Re: [PATCH net v2] tipc: fix memory leaks in bundle and fragment paths
Date: Sat, 03 Oct 2026 14:23:18 +0000
Message-ID: <179103739863.1402591.1705487825430458668@kernel.org>
In-Reply-To: <20261003141635.33711-1-xiaoshoukui@gmail.com>
References: <20261003141635.33711-1-xiaoshoukui@gmail.com>
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
