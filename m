Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB03EC837
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792234116; cv=none; b=UAw+NkQ2cGm+eEoPqi+9tf4gQeY+WQFRsil4D1qWpowXMSkeT/NliJZkt9VbiVtquQ87YUuL+60ka/9yNxTvyV1/2yrG36CkbgTuMBTSBzP6l3aKKvk3GuD8VTBRDM31d5xHmYJBZVsKoca3gpAhrI90JqzxQa9M9uJxPgMJyQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792234116; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rMQu38J0aZSI4s0VOpQm2oLXqlIEYnQkwGM+Kb/pxLdG9fxEF68C5GBZ0tOHwEKuiNuq10/W70V80YfO1J2lVsjE9MSllReuTk5WUBbHoiDAEcypHhtsflZyQhIrfVe/zmd0Dm+JRuMeef0GirNxi2p2gj+8l8PyPE69/H2VbVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/VH64HJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/VH64HJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6391F000C4;
	Sat, 17 Oct 2026 10:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792234115;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/VH64HJLNtY/1pYuNl8w2nr5nLo+UtTSciGJMGfhKYxgt5sF6zZvA7WZF/4i9jr3
	 Ji9kcZncz4Jbm0aheexs4UyQMq7odueqVRARVZJT8OEQPBxXrNIocgXutCxzfA2Zsv
	 Ur/Y/HXXbLiPOLAyFW5s0GIwdFIBSro5MH0kb9mejxs46qQakxYrd6MgeW6z7XwG4l
	 IeDXjZVDmQn9EC7ZuZkBMXBkdmVdJ5P9GoIYs2JO9ETUWahTkeqx2V90UjMcX/yp6m
	 2G7jbn4Y8Toff/RZE0Vf73RdLV8DqGuexlio9vdaxIT6lCVmkQKtQOHZvGuRnZ2IG2
	 SgIAT/TrilPnw==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ip6mr: clear skb->cb[] in reg_vif_xmit()
Date: Sat, 17 Oct 2026 10:48:34 +0000
Message-ID: <179223411440.408196.17907536244198785027@kernel.org>
In-Reply-To: <20261017104228.3418775-1-edumazet@kernel.org>
References: <20261017104228.3418775-1-edumazet@kernel.org>
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
