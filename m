Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB263BBFCC;
	Sun, 11 Oct 2026 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791696288; cv=none; b=rX1VAMjjmlwfCZVuPiD/FcON3Ou2thdUnCgFs4jVSGGNhaCXTQEb0LRksL5ZXzz2oWTDeQxJQIc699P1CSY4cvyFy4/O9UQMMbjqM15ZjQIKbHudLFprjBzwzrBY5bv5qOxuOInvg5rvSxK4uUgy0V6Z7f0SHoGX5myCuZD9r44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791696288; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oXqNfi8ysmKCV6DjotnqTvaEflgALHRJAH88+CyGcfkbdM0I5OlLGkllT9Qx4I3kcZ8GSQuK6LRSS0xw09a+A1jFELgHZ90n5fr+D/23BNWx8oIOq1+2GN/O4xxOWbU8tFQ4Wef8cQmY1fTCYgyf/XXEeq9/uR6HLvBde2JaoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg4oZaFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg4oZaFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C0C1F0089B;
	Sun, 11 Oct 2026 05:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791696287;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pg4oZaFn+kLF0NZ4UeZ+KQneQmtfNqJL890viQosw/oPv+sBo8qx/F7BLLTc7n5wX
	 TSdUZHgmEJ4P70bmvdekedD8LkUJleKGSo+vhxrk8EssmlZJywUReOrypTWOTU5sNP
	 AHajgA94wQjE3GEWdU7oPhiaK/cz3ZAOojMRqNsYRbbBe5xkiZtd3kBkaB4S5hkXnK
	 xKBSW/0H5y/GtQU+jNNrU/G+oWIW0w++hSQ/nuISD3yykjVpF+kbXzwlUh/DpqtJl+
	 dMZ546mOGzyRk+xOhPKM7C46IN6Q6pWZZXWJYQ8HhPHipSZOL8wOD+OCaO1J+yOGBf
	 W0cExRZlVAhfQ==
From: netdev-bot+sinfo@kernel.org
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tcp: keep the route window metric when SO_RCVBUF is
 set before connect
Date: Sun, 11 Oct 2026 05:24:46 +0000
Message-ID: <179169628642.2527009.18099159731266030842@kernel.org>
In-Reply-To: <20261011052006.60585-1-jain.sm@gmail.com>
References: <20261011052006.60585-1-jain.sm@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
