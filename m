Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990C751CF6E;
	Wed, 30 Sep 2026 22:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806481; cv=none; b=E7yCQb0P1b00IqGA8rmJUfgvBvl94G4O2Sj6A19bQTU65UTSS+/FKuuQhZYAmzgwnvMDSl8LUyoUzawhVOJqqB+OeEG/A2OJSjkQ4EQHLQEE7GQ8DzlG8ELMHB3WKJ19E42kXs7LYWeuzIyIr29lmZkky92LB8O/yg+jCxb9VaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806481; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWRnt0/I8D1okoyphDHhA9MXznaoXTaF5QYELf//ZVJN2sfbMVUl46+T3YdXX7iekwU+hwOXOj68VzpzSlFxoTqIoddKtylAeEJDpxFt7PEnbdss/kSHmyxr4iFKBiKpO58muinI3lkvLTYi/zqg7qQGjlibFK62GzqbdNvLYdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDnULEJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDnULEJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958881F000FF;
	Wed, 30 Sep 2026 22:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790806480;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IDnULEJvAU+YloY16NpUZ77FLhCu+IquBIXCra9tHtcwIWen7thyO98Sxw5uC+gr8
	 1bDy3DjJZ64PVpnmfX9YdsGtZZPMd60hH0BCdH+Oa2Bydgg2zSFJtIx21/epn5wYhd
	 hUHuoK5uLyHa+wAH2g9rN5m9F7imBXSrBHNLBv7gVQ+G3QwuEREbfVKI3T7dNCmM02
	 EfpmrVoaYKIJhzM7YwtRv96J1JKvGi1gtIyPqVkdvhQTU2ZADuPpPR4Y/OJSr4s64L
	 4Wct4NmlpBTW3fqbhUpi1cIf2gcIrGQJ6M6STLmLOdEXAsCtow21T6X8zBx9iDeyRv
	 qD+qV7gLGl3uw==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?=C3=96mer?= Mete Kaya <omermetekaya0@gmail.com>
Cc: oe-linux-nfc@lists.linux.dev, david@ixit.cz, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] nfc: digital: fix read of resp->data[0] before length
 check in sens_req
Date: Wed, 30 Sep 2026 22:14:39 +0000
Message-ID: <179080647916.31693.5412797645123910488@kernel.org>
In-Reply-To: <20260930220857.721985-1-omermetekaya0@gmail.com>
References: <20260930220857.721985-1-omermetekaya0@gmail.com>
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
