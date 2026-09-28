Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DF84E80BA
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612159; cv=none; b=hLuJO2/ZiHNUgYi18bfN3TcemhyTH2IjFcT93m/CKHcVXVmAPddyiFEgMrkG4fl5f5fz794Jhu8tqB9lHgzkyDeTnjkRpvDk7awvVFOmO09aDCjM+VuGr9qJP6duvs+4fNsQWF6cuXCWnndL+TUT+ampJduaA1EvIHFgL2zxqn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612159; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EVvl+Iwiz2Ls+mKILL9w8BmHH63sYvnJ+M5g/NVOBX+i1AggjIt3scYKv0IymJPQUTJFzoHeeFZPernK1TAR2yITDJwDgz0z3pXBgr35HnaFLfla8GpibJuH/xAxlaIicw2Chz3jXnhZ6ESWDl+U7mMxqEWp5qNqJgT7eDorpkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YunmdijB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YunmdijB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889471F00893;
	Mon, 28 Sep 2026 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790612154;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YunmdijB4hXuRx4rQCK7TbY14zCfq69017eeELeQzWVqNpX2BRPQZs8ckQhHfQicl
	 y75h/5WUyMMlim6KUUD0rVNCWmelZKMLcJAJPAQ1TtrlghfXRR2GDH2sLp9buquztW
	 zY/iTR6+25Fy3yDUsEKcTg6TzGj8nJdGBDWdc2uLGfSJmTiOQq+DY+nXZjexuFFPUG
	 IFUxstHSRDx3Cam1bmbJZ3ci3mdxaHyU98ehEooRjd8vBUPzBO9CE4t2Fr/ef+kTWx
	 8rwAnj+ipjnWCQVR4zgPmqhcvYK80W4IBJIkOo42uGjcwZ/HuDQ18Ik4usELB2EDdL
	 LNyFcMEfthLSg==
From: netdev-bot+sinfo@kernel.org
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Subject: 
 Re: [next-next PATCH v2 0/2] eth: fbnic: Update BMC MAC address handling
Date: Mon, 28 Sep 2026 16:15:53 +0000
Message-ID: <179061215303.31693.883978833177117655@kernel.org>
In-Reply-To: =?utf-8?q?=3C179061185153=2E414394=2E13396934246780284806=2Estg?=
 =?utf-8?q?it=40ahduyck-xeon-server=2Ehome=2Earpa=3E?=
References: =?utf-8?q?=3C179061185153=2E414394=2E13396934246780284806=2Estgi?=
 =?utf-8?q?t=40ahduyck-xeon-server=2Ehome=2Earpa=3E?=
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
