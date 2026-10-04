Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002D2D23A6
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134699; cv=none; b=GwJOj46CaRBvDB/knN3qseEv8Y+FqiXeZmfod1Q5qX/b6PBr1298l8q1hS9OR/q6zRmX+API0WlxQvZlOUBFfD0V3ZkErEp6oiacgPnt57cIiAjryQD/ezwX/w4PoOSrsBJSG6Xc3pA7wExP+9y7uEPuV7bzEKSVVIDGYj9N9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134699; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tYYkTZjh2wM5Q3UA+ke5RGh/DCaRPv9nEAmTrxtv4adh8j2XTfx2W2jHimGcG7ClGpqIj5KvYqazPnGJpsCEg1bHZLhDadmHn2P0wIbhRU4Ke8oNo0KeiPy0KwtKyEJ5cM8t/cReW2EmZ4Mg5VdB4YZy8Tbz98n5B/KgDVKSd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GU/L3bWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GU/L3bWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8C01F000FF;
	Sun,  4 Oct 2026 17:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791134698;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GU/L3bWQHSys4/n1L/huKiGBOSxqcz9AjXkQjUAiyy4f2eiz43a7BhX1nGApcXErE
	 esRaTyTVsEPR/rjeoRZYMR2BPc55or1HpIcEHNymjo4bss+lzzFujnkjf/wZ6/1bPp
	 0lwHKDEpPg2WKejx9LYIxLM/uHnuiWAuzodQ0RObuGFyjrJuB2AZuSjG4QzHx48yoT
	 t2vbnd2KauD7d1/5Sam9KUbMKfBwocxnP2723UAQG4thSxrDaYgRF76g8WCgszEsDN
	 Ohp59UPUDU8wLQORVTnpLkRk8tJSAo1BUAGblaOs5xEeGZO0AX0SAMU2mAOMYJwvrI
	 CtOrCGh0heOAA==
From: netdev-bot+sinfo@kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, daniel@iogearbox.net,
 Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] net/packet: ignore timestamp bits when testing tx
 frame status
Date: Sun, 04 Oct 2026 17:24:57 +0000
Message-ID: <179113469733.1402591.8712402637621399147@kernel.org>
In-Reply-To: <20261004171847.186954-1-willemdebruijn.kernel@gmail.com>
References: <20261004171847.186954-1-willemdebruijn.kernel@gmail.com>
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
