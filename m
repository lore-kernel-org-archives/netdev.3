Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBFF2F8E99
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791264553; cv=none; b=c+r5FiPu/gXVA3OQqnJfgs7tZ2d76iFVJOgncW/Jku5A0L1p7NnjAnSpAmvGi3DJ0/r1ygGBQeKdaUtM4D+afziYCHzG39Ih8QLMHEgf4+jO3mkv/FzS0tncxTHIDRlq2aorlmE5o+MKoxSm+34CsxIRx6EVLFU4XBzykLLlhXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791264553; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GEKXyhAdxtIzn0rdiHVtysPN7BxzLq+eUgBIxQIMYKCrusX5TshBOjZ2GJ/NL6X2U2QYEZTw7G/nza98g8qvTeHRUslX82VNQH7Ydp5YUi99o8uLIdg17grTLGz7gtWsn341SrOwyUxA1iiORm+iizTj7y7Du/GCzPGYL30zl64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXPgHrGh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXPgHrGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322791F000FF;
	Tue,  6 Oct 2026 05:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791264551;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nXPgHrGhuQQC/TvKg2P+TEg6u4hXB30WCfmTBROc40oRStTzMtHpLs9oD3qCwV1AM
	 oWWaMqLoATUp6A0qQj9eiLeUARBI1sTsiUTw65z9CWsj9tR6rkTCHBSntu+7GlbssC
	 HSDfEhnKxpQjvIz9VhzbVrk/rSDay1/ZXL+GDLPu/4VrzH/uAD+NSzG7ZlEAgfVqAV
	 ZPmjaj11WwSyLlZkE2hOngXNQBPKHrl4kCs20qZSQcnA/S8iCgCDG3u03zaSFFzHZW
	 Pyw48uEQo/nc6yJMISl9yCJGhHKnri1C5TOfkaTG9SZFQ2GLfE6/a0goKYd79YO+lc
	 Wcs4gFsH705UQ==
From: netdev-bot+sinfo@kernel.org
To: Tung Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@kernel.org, pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net, Chengfeng Ye <nicoyip.dev@gmail.com>,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net v2] tipc: fix several race conditions caused by
 tipc_node_write_unlock()
Date: Tue, 06 Oct 2026 05:29:10 +0000
Message-ID: <179126455073.2231598.10466102165090932182@kernel.org>
In-Reply-To: <20261006052312.30382-1-tung.quang.nguyen@est.tech>
References: <20261006052312.30382-1-tung.quang.nguyen@est.tech>
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
