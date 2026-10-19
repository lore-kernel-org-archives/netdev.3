Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD746C851;
	Mon, 19 Oct 2026 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416329; cv=none; b=iIEX3b94fD8S0h20G45QWiynZAeSmniGHkhJHYpiXgC0Gq/scWraZivqQr9ZumBWnNRX8nuLONhfGPAwhh6rgwMsoqNWxlNSnDHbM5ijHatRnL50WPfDaIg/secuBXQeDnXmqhl61+mzOZeFmQ6xk+x/On1OPfYG7KEJyX5qUY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416329; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SbN7J5/Gj8+krW8mJprve2Qyq1Xi37LtVA55AO1qB663edLldwAt2oTNntgGnR5Hnz1kW/B0csj/1UqI9lBR02R/U76rndt49rTmU7XxuPrAk9yXu3gWZBO6D5zOna0harActL9+38lwxePLck2LOppa+/cQICS+vBD/9rQCfxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpLvKrhO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpLvKrhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5CF1F000C4;
	Mon, 19 Oct 2026 13:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416328;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GpLvKrhOLqw+7zF6BLJWXqKJXiPpNfz31vlEfZVxyet8RuFmREqzVEGM01sGEAzfN
	 oeWNiL3yAeYcPrTSIzxGhOvuPstgGMnjS3n9BFCI1dMmXGFIrClPmVH6nCIRNA5I06
	 8OsUUCT/cEFgG6K13JCE1KjhCVGPO+YLWyG6yaP1UclgCPeG/S5oOVve2dvIjBZCnn
	 VD/YIshzD7HiU8cZBdWqI43jB+LvVFbyQ1pp1I76LIpCZVjXldXOtdeaiGEUYOtKBd
	 7HLi8zWlz7d+z0GwgngjIUv4I3yhqBx69QN85RgVVbPQo3TxYm3glS7nYcpwZOkiZm
	 7cHPgXQdPcC2g==
From: netdev-bot+sinfo@kernel.org
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: icmp: use skb_dst_dev_net_rcu() in icmp_build_probe
Date: Mon, 19 Oct 2026 13:25:27 +0000
Message-ID: <179241632780.3290.8009042306781577182@kernel.org>
In-Reply-To: <179241614083.5916.6651154069510905781@whr>
References: <179241614083.5916.6651154069510905781@whr>
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
