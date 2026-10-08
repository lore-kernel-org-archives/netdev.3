Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3B145A1F;
	Thu,  8 Oct 2026 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419953; cv=none; b=df1CI77547vcX8ktphdQ2Kn9K3kF7DSRS/JP3M0uIxqcVKWmVrbMTYqxbZMhPeDIxyNjbODirdMUift9V/uvFkIG2oQjTqXm1FjM3wYf21L9P/x6OUmjYGUdWfccu8AylZmPmYa4qb7HC3rvQOjKg44aJ4tUHRQrVwMY2eGIhn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419953; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OSF4/lKqOD59LrHPKh23nopnu/YFRelNFCJvMnUoKLE84RHFwOdtuDKdDmhP4s/hSTi4Bk4cMGyeztgv75AQxC1Pm39a1j6O/IE9MISXGR27JDaFvJKivlU+7uRCWs2WmXSBM7c5J/K/2EjnSaVZ+OuOAEnRk+6G2kUAgxrRWNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtigR7BG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtigR7BG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21211F000FF;
	Thu,  8 Oct 2026 00:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791419952;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QtigR7BG3YGoarUlJeZ9Wt/u1CXtIO8Qxjz5grNBCW9PbP4Qp8Z4Q/ACquHfbyvfY
	 BkMYLgsEZTOgISFy/jVoLb9sYQ/LfHFCEPpwPWhs5ae3CABU6+j38NztzbEzIdH2vf
	 658ZuClb5rMs1kzf9GvSJOd40EqdYawyL4oNS2X9Ra8oqKozts1rHqNDSHZr3p1N9R
	 u1CJTG9cMiETBxeWn9kPvjnxKs3W9VCXIW4dKd5DtFRB4YKblz9nFNV+4w7keEXSgL
	 qcGyci4+1r/yZDS0AYtf6IQ1G/Tq9SdhJv6yvn8K/5qeRMp1DhP9TyMU31VJy5b6Nh
	 J2+gVbqooNvCw==
From: netdev-bot+sinfo@kernel.org
To: Omar Ramadan <omar@blockcast.net>
Cc: Taehee Yoo <ap420073@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net 0/4] amt: fix relay tunnel keying and
 unauthenticated-Request DoS
Date: Thu, 08 Oct 2026 00:39:11 +0000
Message-ID: <179141995124.2527009.16759719486523759711@kernel.org>
In-Reply-To: <20261008003606.3666617-1-omar@blockcast.net>
References: <20261008003606.3666617-1-omar@blockcast.net>
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
