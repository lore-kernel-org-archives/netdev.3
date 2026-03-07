Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5DB28C87D
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 01:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772846414; cv=none; b=srIJzkhmjf6nh/8VCfVvhC2QUB36Svq+2Sv54bFpEBbfo2Q0fm74h3C8QEIgNBjOG1pMnpwU+kA5vHC+fcW5ihwuSn7U1pqXF/l69jXcbFb96V9+h6cuqrJ5IlBeXZZE3VSp2j9h/mtBlKFwgwsgw97Nkp71DQgJc+fpCwi6qSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772846414; c=relaxed/simple;
	bh=wIlgkj03eF4XLF7xndddSK4qfp7teXvnpnai8+VqeWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gR33+toKtr5VqNNzRcSmQ2r1dUIhkue3s1yYRLJ8+0NNg90OG2HSWESurTeC72+6+7dRobnJ11ZkNHROlf1Wcl98+YC6IcvRamwXi3iXxOFSI8+SvGSV/oxNBLtZR2/mZeE43o/AwqvTzZCz8U3CaG/0m4/rdbM80VPHUaShPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkBGBWcl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkBGBWcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC8EC4CEF7;
	Sat,  7 Mar 2026 01:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772846413;
	bh=wIlgkj03eF4XLF7xndddSK4qfp7teXvnpnai8+VqeWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XkBGBWclR06xKDiA4dUKqiQtNHT403qoLzJAMaXBSoUFp2fln/nTkg++dKNMkA8e7
	 DUlbQymHG2tVwKrYscFmhvQydADGRPLMo6V7nf3YNQcyQqRvCAurmBOLkn+vaoTq7m
	 Vmymfnj4XC33Xajhs3V5Anpl3zjJbM8wy/2MIuZADdJRo6GynyGG52Jj0aQ2sAX6yg
	 0fBlIAhNWUvkPDCXyZU6iMP16BZ79WP/IWUvvEGT/vorRWbe2NjDw2GlIrpzwBp2p2
	 hl7ngI3yA+bmushJkxrQ5LhCcBFY/0bAsHuF/xim/JwZIpaf254drJRn9y5pBJSPwZ
	 3MFcBpZhR0NdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E873808200;
	Sat,  7 Mar 2026 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2 v2 0/3] Add JSON output support to the remaining
 qdiscs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284641280.115442.1510536699484746021.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 01:20:12 +0000
References: <20260303130733.540278-1-victor@mojatatu.com>
In-Reply-To: <20260303130733.540278-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, jhs@mojatatu.com,
 deren.teo@outlook.com, andrew@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue,  3 Mar 2026 10:07:30 -0300 you wrote:
> Since qdisc core already assumes all qdiscs are able to output JSON,
> add JSON output support to the remaning qdiscs (HFSC, QFQ, muiltiq)
> so that a JSON qdisc dump outputs valid JSON.
> 
> v1 -> v2:
> - Fix bug on line printing "level" field in HFSC (Pointed out by Stephen)
> - Emit HFSC d (delay) as a raw numeric microseconds
>   value (Suggested by Stephen)
> - Use nested JSON objects instead of flat names with spaces when
>   necessary in HFSC (Suggested by Stephen)
> - Output bands and max_bands as separate JSON fields for
>   multiq (Suggested by Stephen)
> 
> [...]

Here is the summary with links:
  - [iproute2,v2,1/3] tc: Add JSON output support to HFSC
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=3ebe6ec196b6
  - [iproute2,v2,2/3] tc: Add JSON output support to QFQ
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=935b2aea0641
  - [iproute2,v2,3/3] tc: Add JSON output support to multiq
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=4ac8d234f736

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


