Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71244A3FF
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723553; cv=none; b=pCUwqpayANqDvFuakeqrTEzCf7BqPNbHUI9twIUt638Nx8mB7ZJwr9cto8H5/J8Qqvuk3fzz3/GcafNEoOfVFw8PyMegamSm3EF4D7gU4wJf2Y2EkHXJs+xctyPsGPJPJhlmhbojxOhi62oLU+lObbBQspNwx/9W/cXO65GsSxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723553; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FGxikZbKgR6m2OEj7nJNGaMPY0YKtjMLm0ZeQDch1uJ681cH5qzYWSjAP1QPPjNCAnKAbeZ/aO00FvPohqxmMuMjVvz6JVmL17EtbE63uYVmm/KhxUqypQcK+BpnH+xFCuVhkEFjaGy7eamTXBZjOUqW7wWdFXKnUPq0Pn/21JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2YJnJqH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2YJnJqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715191F0089B;
	Sun, 11 Oct 2026 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791723551;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F2YJnJqHYbGSv6w79JXArc/oJfIWw5/woDRE/nBV1hHqItsTU4eEncRt1aJLoGGEs
	 hF6q9W5ytImDJAjDld/e7Gf9kSnkVZ9EILerTqXObBNXaWqWwXsZ1MzUPQv5IH42ax
	 /gt3F6QNbsEXregD9zo20dXgxsc5SJ7nlOg+qgbyVdJrdSAeJhiJgE8zz8mh5l+p04
	 O9NtsMqXvN6LT1luuxKI72oeGPHKVvFMZIvElz1dhqRyx+LVU/nbBkelFg+r7BluVU
	 s8JICRw3xs7Gla5uLTkLxK4oTFrLJ++JQB8TELv2TLYx84Ckn8F1pME7aumLkVBfoO
	 klT1rz6a9v1Ag==
From: netdev-bot+sinfo@kernel.org
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sbhatta@marvell.com, gakula@marvell.com, sgoutham@marvell.com,
 rkannoth@marvell.com, skardach@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, alok.a.tiwarilinux@gmail.com
Subject: 
 Re: [PATCH net] octeontx2-af: Fix CQ enable state tracking after AQ writes
Date: Sun, 11 Oct 2026 12:59:09 +0000
Message-ID: <179172354995.2527009.3746469647065234779@kernel.org>
In-Reply-To: <20261011125508.534618-1-alok.a.tiwari@oracle.com>
References: <20261011125508.534618-1-alok.a.tiwari@oracle.com>
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

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
