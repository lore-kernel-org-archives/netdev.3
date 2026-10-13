Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A34A6881;
	Tue, 13 Oct 2026 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923399; cv=none; b=mG/EBKWRSobHe3mimpy/AyYVPK9S4k2vI3SzWWMxv37usC1bhr6f5spWCUQgXcf++YcvUR/VJB/5R50yPy2lmgBYaEDC/b7C2f/sOvZfLVp9Lrlwg+D02KBYn//nUqUHk68oUMHBzWpEURVt4MiDjcm7K3CtwshTsXCyHVNn89M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923399; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BTjZr1MC58VhFacz/QkHZYznUYSA2L08hhlTyUT1UPXdD6p9xOOsCQTx4MnREgN0Tfm05tjbfR1crsg1rMHheZO7x41yc8tWb9NeNxQLRZHyGxPE2MaY6Aw3Oxjqv9bjYzQiFVFVrigchwyXqdK9DitISlvf3yzA1o4WZJL9wQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz1gsIO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz1gsIO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536011F000FF;
	Tue, 13 Oct 2026 20:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791923397;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gz1gsIO4GxuHD0tHyZ5Q2urV94SyU2GmIJja7d2dR9Qr1ZM4TqU1TvB8pa25A3etJ
	 UOpxDElSm0EydOOErCggQA4SV4DAlo0lMek7J8nE31ZlBIuIkOCsqugPzuutxJ7dOa
	 cejwSUwO1sIzzvwgCFJdJWikkR5GNxCbgZyVSaia3QKzAwW0Azp+I3R0IV8P2tTPA1
	 M7Bmz6ffSPvinLL4UC5AbzRoOqudPQajotdeqMQKvv/viRbsG+NvqbYJ5MMOD1C/9x
	 LqpORilVwfdo81eRW0ZSynZaYTIzwjXQh69av9fu14QjK1fVrGdxtrls25YCKcgskJ
	 GVbV0QZ0Qi44w==
From: netdev-bot+sinfo@kernel.org
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] tls: keep TX and RX hardware offload on the same device
Date: Tue, 13 Oct 2026 20:29:56 +0000
Message-ID: <179192339687.160550.14797947648260280628@kernel.org>
In-Reply-To: <20261013202647.2206263-1-rjethwani@purestorage.com>
References: <20261013202647.2206263-1-rjethwani@purestorage.com>
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
