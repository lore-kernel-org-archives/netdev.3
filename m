Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBECA3D3CE5
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791523204; cv=none; b=FUFhV5ybe8GCeYkeN/qrOhKcOP5CLVLMfktCJeU0s645icZmzP+yHqQ0uf36RPv1bkMv/1PfjPyK4RVKvOOdmcZRbSlM9+THCRU7C2BpzzzDCRg3598bgGFsFqtCAgp49UklFnHHABn1Ca2oMj9GF5uD9RvFruOIT4SQP1x9DcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791523204; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rVkXFePruh4kY86W+X4dAGmHQ/tjCvJAeZH5f/bWmYsibf6/qVaY6VBqNJsmAeheIg1MLqHtegRDqHly4rlD3TAhxJqXMeikw7zK/HCnzTI/4MHAGqdUQn/scR4XPlFRLNKYXLSJ/rB0xd87IegGu4hUGOTlRE+QWQJFzQfSHDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA+WS2+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA+WS2+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E641F00898;
	Fri,  9 Oct 2026 05:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791523203;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RA+WS2+DEP2jtxZAb3RHW2/n61YhK7JCzHfj5/rv9cQP+N2ep5pdQQ+tqq0QWKBnd
	 w5PijXgX5CppMGzbKzo57RIjfUcrvLWY2nYAj4Db4rLTGTlY6uoHmpf2h++lkplIme
	 8+JwJgOsvl5bxxMW1WJwzow+nmKIqx1w1JYRQ7VkQxmcWDIUgtBEgugYB9xc2Tq8Ql
	 3c0hNo68bIEbExXX4UztDcX9g97+MUivRnPPucgcsmi6QLPlByFowvCTsBavK+EUT5
	 Q3q2Bq0OMFwaQrVcDCdEkapDw3KJbG970aP332nSN4exA/1FZBw0OE9e5Y3B6n6RcI
	 bL35ukUqEQftg==
From: netdev-bot+sinfo@kernel.org
To: Alexandre Cassen <acassen@corp.free.fr>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 netdev@vger.kernel.org
Subject: 
 Re: [PATCH net] net/sched: act_api: take tcfa_lock for hardware stats updates
Date: Fri, 09 Oct 2026 05:20:02 +0000
Message-ID: <179152320223.2527009.4527077790513335157@kernel.org>
In-Reply-To: <20261009051703.3615846-1-acassen@corp.free.fr>
References: <20261009051703.3615846-1-acassen@corp.free.fr>
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
