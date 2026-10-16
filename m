Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3644CF491;
	Fri, 16 Oct 2026 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177422; cv=none; b=OWosytsTxoLYfBntc72m4o6EYu0urZq+Ga6Xhl4zV65pzAjQ82ZlPkEMBRBc7DVx5fFKFyNlgspOH58N1OhfIIefVyabd1MmiYT0J66sxmfezeOnl1u3kjwbXLW4eWSO5mIAGkb3qSN7z+Ag8N1gd74LyTfNCzurfrcQtXvT0C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177422; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BSQmMF0xfJPhPVqZhRqtrmLo+QMmnJ9GNUvu3UgDnQuxnkfYNJ5Okfm8oqZ/KH3Wzbc3bJR+DqTTO6+jl3TkZvJXNPKXsQ7sr9amisyA3sL0Gq9bhCbli3xpa9dTrDvrvgNxl9+1NaomSqNJazGFXlbGUPEIcyD6gt+3+8LESMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1MPcn7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1MPcn7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD9E1F000C4;
	Fri, 16 Oct 2026 19:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792177421;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l1MPcn7wUKA11mOSJL22YnTaEa/FxCCDODmgLCSStH+eJ96lzxGK9WTi5p1Eli7dJ
	 HxGA676nimrjAwcCVEq8q38nrTOrausAuDgmsAtvtUCzNDu0UQQpzSmJaDp+GjVMUy
	 MljQin400Mh9OhtO+7hi3FQ5OHoHRNXq20c/1HlpjvrEYc3AY7icHre+kKzhSRUoVG
	 ry3+joGHnkhiIHX4briX28rBYQZVcSHqZL+Qqzq/pFeNjplP6KE3ha2LD8yHmrMWWK
	 yscNk1uflZ79XybqDi/YuX5D8wiFaqae5rXvJ7gQIvxmlfK6qA6WPRqBtLfK62puTv
	 4h9IRsTtCOStw==
From: netdev-bot+sinfo@kernel.org
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH] Revert "enetc: Increase eMDIO MDC rate to 2.5 MHz"
Date: Fri, 16 Oct 2026 19:03:40 +0000
Message-ID: <179217742020.408196.3167550560236175089@kernel.org>
In-Reply-To: <20261016185817.54096-1-marex@nabladev.com>
References: <20261016185817.54096-1-marex@nabladev.com>
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
