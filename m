Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99DE1799F;
	Thu,  8 Oct 2026 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422348; cv=none; b=dmAqfND0iXyD686D6TtluFIedJl5J5fdV4UZbx6o/EEwlUuu9AmKgA6ctUeFXl4cwFBIsOyEHgvn5uC43YyCeZIAbB5H1PNL49bVJF2PA0MTMVl78U+wWQ/L4TSRXUgsruqRFPqMLimPL8B6NLf9UITE4uKAkFJ6YG9FZ2ngg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422348; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CYG3c2UjbE95l4TBPX6vkcO4SIczObGx6W0wr7tXhuDpQ6GMsH0oWLKhItmbXadMR305dbnf2BnyjovBvhH9knGH/KRlTQPvJzLzpa9/1A6OrKfal+cXfR4PrDszUWF+djl0Axr1YCctmnCMK7MC07iPrsvMsZqU4SDP65hjLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfYkLoWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfYkLoWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EDC1F000FF;
	Thu,  8 Oct 2026 01:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791422347;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PfYkLoWHbh7IYdUSrkp82CBSFp5WqF0TxaLAxKfU9XDZJHnVYNJbwYxAMXge9D/i0
	 m7MjgaqwJ/nIOEynINKU9TLpV/MJwnIXWnRg8fhiooU3y6Wo/tq7og7WwBYrVH6/8O
	 KGAo5EZGNs6D/+YwwUWXqyonm9/K198qdkqCPzap8dWU6Me+BjklsScBoI3/YNnm14
	 pFEyyt2a/gndPY1/kTBqQHsQapl7d0xQMWCYHjh229oHZNZyoozkm6KVUPYOmv8ECD
	 s9f0kwnz7p5YjSxLsPJBhWV6lEfHQm5mKK01TMJu3Y7picah3G+Bz5egIwd9Q/dwHh
	 NhzO/hucct7rw==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 outbounddisclosures@openai.com
Subject: 
 Re: [PATCH net v2] netlink: avoid hashing the network namespace pointer
Date: Thu, 08 Oct 2026 01:19:06 +0000
Message-ID: <179142234633.2527009.9314976849845433713@kernel.org>
In-Reply-To: <20261008011359.63727-2-kylebot@openai.com>
References: <20261008011359.63727-2-kylebot@openai.com>
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
