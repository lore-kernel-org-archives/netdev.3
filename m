Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABAA37BE9E
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140801; cv=none; b=VEQ6BGMQOYUh70k0x6H+ijrZ4MwmV+FPHvraZ3WaUOBQsgFFOAkF3Pfht0fp+RX82JQ/g+IdyXYgOIgfwjh4hVQccXYkLbIPsDXbFMt6Hzy+4p5mMASDIBS2QH5wOT6O15Y58MCKkh9Z5+B4V2dI4huaQwjs7DI3D4qyBaf/+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140801; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MnGPxXnvqfoZoAsFXgTuNvGuH3BCGsd8w2U4Mq4XTpzCgkyWtvIQ35FqzeMgkXv5Mop7I/L0H/KDwmnVDCKibv6E0K1P2R8leHZc48RVwwJdiFBLW0BMWxrbOz2s9r8G4N9mmat1bATLvBQk/gnRdDKfVGACpZmYBAfcwx8kmrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzIk5Lkf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzIk5Lkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF981F000C4;
	Fri, 16 Oct 2026 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792140800;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dzIk5Lkf1jW/67qJaFeCh8iYQDMvflA/4FIQWhhcq7+OcgXH37vLCpSz5s/lJauEG
	 BNszgYI8J14aK6jk9bei8kqHkg9MR+dBMguqWp/+5ZucrA6T0THfNGNcSr5AsGSMhP
	 jPjs9styg61ZzMdjTTaFY9iczV9ej3hgAM1XS4EG42a+uVDkxQDgxX3EBtF0kyyMxk
	 CRzzmcTQoF0+VcaD1Qi8ix7N+qunlcOLtbQGIJZkQ300QJvY88Qn63A9MZEYtLXBo9
	 j32UWH5yFeOHGugVuh+z2lq70ejNQN6Ue8RGUocpHvBOsELIZWY/G++Szpk1cEg0Gy
	 Pq2na/tjvVDfg==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
Subject: Re: [PATCH net] tcp: tcp_metrics: use the socket netns, not the dst
 device netns
Date: Fri, 16 Oct 2026 08:53:19 +0000
Message-ID: <179214079911.408196.14833825392033478796@kernel.org>
In-Reply-To: <20261016084802.2725187-1-edumazet@kernel.org>
References: <20261016084802.2725187-1-edumazet@kernel.org>
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
