Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1503B0581;
	Mon,  5 Oct 2026 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234602; cv=none; b=KNo8/5KlsYLJXrROfR+mjidryjrTNjdo27P2Dqq838MtJA7Zr8VKBRZ+TlKMomW6Q/cPpuPr8NR1Evf4B4+w+0HYLo4J4n5RDpYfTRJHrS9RUlMMQS3ijiO6QlB9/hYvbuSvHrtQaVF+eb1kx++DdVbkYaVtnbXiot6ZaiicAJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234602; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YOJjr7kWfNviypi9UdnL2iRnbJzZDu0FRIvIwHV1ER24qtxqgvAdxfPCbUrNZUx/lTz8x4yk4jEvw+d0OxSwjZ2//hCRvNIBPb6BOuyyv8QTceA5G/RfYMsJop/5FTJTdj0S+3wF7mdA0sQ/XIIECbDc92Eut4klfGS9zrJuKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEavl4O2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEavl4O2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FDA1F000FF;
	Mon,  5 Oct 2026 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234600;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eEavl4O29Lfh0d9x5/reAG8xs1DVo4Nr8lWZPtHquKwuaFijnU3ujf6Z07v89hRuH
	 JyNEZJI7fH/nB7Q1w6PVDCPoW169sk8FrO56La+WP84F58UJ0o9ptPUKBm41JtDl/Y
	 kIpjNdVAcfqZVGjRMIuHn3oN39qAZn4xKnOkrUxzFzZA0IvhiGnAOSB4oBpVx9YxqP
	 WnKCr/PONK1k2VmnzU2mUW1y+84rLMDnQIGvqXJZCezj44bnn0TC4Mwrc+qLehhAvy
	 zYoQysZekHLnvRhohc7mRUrvRs/TbCWqK6V9Ad+ZN11XBkuUvf8ELlDpGsJJ9izlUS
	 eaQ+ykyyedaCQ==
From: netdev-bot+sinfo@kernel.org
To: Kaifeng Wang <kaifengw@google.com>
Cc: netdev@vger.kernel.org, almasrymina@google.com, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, sdf@fomichev.me, bobbyeshleman@meta.com,
 kaiyuanz@google.com, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: devmem: check uid and netns in net_devmem_get_binding()
Date: Mon, 05 Oct 2026 21:09:59 +0000
Message-ID: <179123459939.1402591.14198806382912674675@kernel.org>
In-Reply-To: <20261005210403.3206872-1-kaifengw@google.com>
References: <20261005210403.3206872-1-kaifengw@google.com>
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
