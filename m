Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780583;
	b=lQe++Nu7j1ki0iHNrsXr2bhgVhFAPaSWcxDUHE4as20t4kjjNX2edshjbR8wdKoIm2m/
	 IApBj6uMh1b9PZdrdI9IPyS546K+pdkoeuLNxXIkX7/928JRzSk3/3kw9j86cg6m4xAWm
	 Jp28IE6BfR+uSZRUJCcu036ykYJd9/yJTPMiGhPXsZGK0y8IT4w7pvQtys5Qqvy7EiE6D
	 gZLyonfyDUISU6jZg9JWqKC8lh/wk8g6XNI2E3fdRvWAZDxvPq0C53J6PMSq0kw1B5aQJ
	 wvIcteB4qGGT+rwTcJxkY0HdISEZW+LryITtWEduc3tPnh3urpaM6M/Cbpf7Dpb+IxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780583;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=Nk0aVzkO6leLM8sdir28nJkeSkMKire9lfJ6fYLlHnQ6Zbp+Vjj1qq2uMVaZgkiU7BGq
	 lERKFpeZ60KwAm0eUfX5o4AipXD+wNQ6fvmaZOk7tVjzwOUh4H7j/vs15v12TUpBIcaQx
	 ifFDxXpCi2uhBcbfLWuECxachY08FXnSrhSrpdT2Nvjf+MzLpc6SNbG0cZMpQIgW7kxV8
	 9EALT2ZPEIbp9YxZjyalXVWPYtX9CjL9XRaWYDZwlzTb868D0KQfCtqkaerWceGFGm46l
	 fFCPWyVN6VfRRi2dvkdk824O4vNpiu9oiio0YGv70FFKGoIlAi7sVrU1XU8UUtGUdcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXh8Euhu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB9606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXh8Euhu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC66C1F000C1;
	Wed,  4 Nov 2026 08:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793780582;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AXh8Euhu3PEvm1V6vJdBsmOi8UMGRWI5jC7XUSs/gx2D7tPNohJFmkufEoj0D6sTc
	 aniQo1RjVAKuBVQSBGCF5zu9SWyxe3d5A7hkB98PDmB6eV8Aq0rCcQj5yBvblhlQON
	 +W0ZMe4XmYRNEjHsxccfiXB2i5z1A3KJ+KNlgD4l2o1fmJWFXh9WODfUQldLVSPqze
	 TGtnyLmQnkjVOOtqvWnuoJM0nGm06FB1Vd3jG6Z/bc2w7qD7xANyXlbJfV0nyzrAqf
	 +fI/fe5OZ/sqL4l4dlIZe4hEqL9WM05JP9gahdz8fIoZsa+irz4u+lkzMSuJdsCgft
	 23eWEeil7vrmQ==
From: netdev-bot+sinfo@kernel.org
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Lim Chanyoun <onleaf322@gmail.com>
Subject: Re: [PATCH v1 net] af_unix: Convert unsigned long to u64 for GC.
Date: Wed, 04 Nov 2026 08:23:01 +0000
Message-ID: <179378058137.488859.5892003889281444606@kernel.org>
In-Reply-To: <20261104082058.452188-1-kuniyu@google.com>
References: <20261104082058.452188-1-kuniyu@google.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
