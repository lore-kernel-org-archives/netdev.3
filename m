Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792939884;
	b=viLmdqN7y3Lukx3WbgCZEL4cHHtFIMUvcF5/ADAEXJleFvXfPMkXbn8FEyFQJPWNvEgb
	 YKmq1M2bCLRh2ke7Va6EcdY7Zvhpl7Teux9WfZyYkD/cEVYvrs5cv4/KJso96lgw5AkAj
	 yBEDUhEoY13tzrjRucQxzh6+96r4dC6p0Rj7NoOqZSMtUjnOabH0kCYXoeuHVuGSV3D5H
	 WNTPEGAHHIApLBrKYpKOtScAibgyHzmyyyNRPXM2dkcOULOAavJotrpt8q3FbM7VvNwv0
	 E6CwvzicTdaBF7Ht+TUWsxnIXoKHisbcUeyjLOH+dOOTWrVJaBL9QUopiAjNgFcc6dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792939884;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=cvZhJqsc68LQeLzqI/29EcSnElduVJfEOCcEZHYGK+d4LYQPxD+mwBp08PZoJZ9frPts
	 e9gqaWEgMV5mZGc4Y6OS89Zepo5QRqfzQtTh+Fl1lEm8WOyK92ORZXiACtrDUxSBvOk/+
	 gf7mIljSOzyEdg91ATg/XoHTrLF65Hb+AowpuB/fUNsIMqj/YNo2fyAiIEutDBQERRg0j
	 6FcKF2Q+/VyKgAbwIde1Jx/hrcfUTUTDmY+upTEeOAqdGh8MwttQlF/veeAWo2m7xLo16
	 YBtYETQ/WR8YeO2hYB+cil7jLIPCbt+OtSZcRQqew3Fo9bERl9sum71oHL4fq9BGBOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVlt3dSe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ED3606A31A;
	Sun, 25 Oct 2026 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dVlt3dSe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0EF1F01825;
	Sun, 25 Oct 2026 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792939883;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dVlt3dSe5OEhbiMw4TvY1QJ98ClgXyNjXyd2R/zoEkhdXeU824EhxsFjWqU4Q6I8s
	 daAUqXez6aYfa9l6Vm+/XoHcfxJXArfGqym6JmP4CgiMjwG3V9cCuynmc8yQMXAwyb
	 h0B9NFv3+/qF4xfGZtTHYui7INK2nQOGf31yaTrIgM7I9gw9deZh4hbfJtvNOhZhuq
	 UCpYvB3RxkS7DyZcL47n6vSqNHdpvT2bcbT/0poxIAKPttRdkBo2vC9T4GBiU/PM9h
	 TV2ZxSdfXB3vwO/SYTSN/P/VWKZM/sYJAtHRWaqzBCZKnMeuZu6zABOipdkzVjIugb
	 QPPMJ1cyUsaYg==
From: netdev-bot+sinfo@kernel.org
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net v2] net: dsa: motorcomm: Isolate all ports during chip setup
Date: Sun, 25 Oct 2026 14:51:22 +0000
Message-ID: <179293988263.3327.974649019719589803@kernel.org>
In-Reply-To: <20261025144834.2810828-1-mmyangfl@gmail.com>
References: <20261025144834.2810828-1-mmyangfl@gmail.com>
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
