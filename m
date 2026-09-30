Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2104756B8;
	Wed, 30 Sep 2026 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808887; cv=none; b=bXEbUiRt3742E9clnWxyrPkVMnm+igfz6acyQdhV5NVf8LsiegPEn8dUDLm1a/JxcMao9u/+yJhy9s7ahgbhydZMxKhIyAu0fBdo/wDjwvayGtlvOorAgB3xboglxxaj/DEOFqsyUUy+5Eg4GDRkyrdC7WmXDP4XccEh0iAH3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808887; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDmiLhZ8fMJ1xD40zu2Z6WD6gkRsWfx5igoe0mwR4xrUiuoPU/aQ8LmCYlXzmS8H9z5+YdNIqYcgmoc8Jkt8D9dUvsY1isUHab1/cdLo/EDh7nvloM8LhFVO3Hd1JRbVmHvBdoxiLTzIA6BmmG6YEOx7wcxvfn8BNlpmbOMrqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRqyAjak; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRqyAjak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2B91F000FF;
	Wed, 30 Sep 2026 22:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790808884;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aRqyAjakbYoiMdqHFBSaLx9IAeSoeUCZ6CWcwaOnwjqgRVW62yjo0dcDXi4iysSgI
	 9YexgTzZ0wj/57nluOZkPXgwQwq0N44kRbtRKHU4wrGgQApBzAj5YnksoLlVzWDtiU
	 kMocGl4njiXwR5HzUn2TtwsB638A1awsABVsq0ir5tnaGGVkF49wfg8tf1owjjx5F0
	 QOXrJlV0loOJFZMAAR5UbfK+HhBhPtq3AGVCI+ukTLKf+lgxQsenDOkaqOF/JXDxC1
	 7oJUj7b1hNnDaZN8CNUTHa+NakNTrwD+kMuAEL4Xe5Ox9fgS2HE51FuxpdOFvOPgHj
	 XdSJM8QhqpR1A==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?=C3=96mer?= Mete Kaya <omermetekaya0@gmail.com>
Cc: oe-linux-nfc@lists.linux.dev, david@ixit.cz, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfc: nci: fix out-of-bounds read in
 nci_core_reset_rsp_packet()
Date: Wed, 30 Sep 2026 22:54:43 +0000
Message-ID: <179080888379.31693.9678596349950606516@kernel.org>
In-Reply-To: <20260930224940.725976-1-omermetekaya0@gmail.com>
References: <20260930224940.725976-1-omermetekaya0@gmail.com>
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
