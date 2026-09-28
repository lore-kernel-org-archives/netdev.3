Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC372AE78;
	Mon, 28 Sep 2026 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605540; cv=none; b=JY3lGMKiU5zd7R85kCywZgtW4ubkuE59c9Y04n20IW3uAUi9mIsC9Ymw2JErlcn5aGiarZTZ2NWJpJ1r905Y6hjxPLmehdJHJOWpkvBRei4JiaaFua1zY9m/rtaOjHy6ym5EroETkDeF5NSs1BhNS4VILlP5R1coX2shTmCqP8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605540; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2a+d8Yfxeg/loapKPC7lr6LdB+pMT24WkNmMNmaKHWW3fYCLqiSfLLXsrH2bmbZ/Dsh0zG/Em+zK9nkS9bDyZqTX0Toa6Td/PNqjk7J45TF+xIHjLe6xi0CVZpFjbPOQCcLAzZ1JU2fFyX7qFwSf9lABui0Xp+FtndsKc9tbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv3Hxxn2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv3Hxxn2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F971F000FF;
	Mon, 28 Sep 2026 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790605539;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bv3Hxxn2zU8t2doRCa71eB3yEn43k3+1ED7Sj4udMhiAEFot/1SviaoXEZI8HPhtd
	 fNpEgmOfLtaVSL6XIagkt/wCqu12ozBboUNdKb/ItMIEGbiFSiyeiwokHQgPDkGhX4
	 3di4tDqnUjh7JMQ0oRw+jVwf9GeE7/KPuU1DgZruuah5oLwlSXe1C5Pmrfwj0rKYJ+
	 QfY8C1Zucey7xf/bmjrGuztZQR2NBSB1x8o/Ut8SVFWnc/2CcBLM3pzWWvGWJEZdQp
	 ROhA6R24Zpt3MkdBACkSaHrxtYf1CtRQFXaD3KalovCaTcO8m8AMp7ydHl/qM1Ys5t
	 panBJArBRwL3Q==
From: netdev-bot+sinfo@kernel.org
To: Adriano Cordova <adrianox@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: sched: revert tx_queue_len on partial qdisc
 resize failure
Date: Mon, 28 Sep 2026 14:25:38 +0000
Message-ID: <179060553814.31693.4005617911238587252@kernel.org>
In-Reply-To: <20260928142233.1131459-1-adrianox@gmail.com>
References: <20260928142233.1131459-1-adrianox@gmail.com>
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
