Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF574399DD
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414874; cv=none; b=WJB1Xgjh79aOlzvtg9HaVlb+y9WsjT/LjqaAgxe/8FPxwirc2oXpRX0xjzEQa885mc9STOz7Tn6Q3l4qJLZ943rQI1tpn2fQMq1h9FRwIcYrrjjhgMjI1iORuXjpXX2zaCzxK183QIBPe+YD6cnzvh2qTR9Rhe9kAVRJNweXhm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414874; c=relaxed/simple;
	bh=A74VplKNwB5PjUwnChmGzzeZc8btqiUZLhz1Q7rzKz8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eAuTnawsQG/XC+PHG7IPhKmNl9juP31exLI993xcZ3lPhfCVK7iYqQ1gsKLMXrTBT2gDvezok4MpBjQP6VIv1kwILu+ceaIPn0q9b8BgRhzyCviOeeDFlu8HVuAc1IPqpMAL0kVyWQ9LEHuhtiW+zfqUbfQ0HmvtjqICOuZqFTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fg3iXwg4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg3iXwg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7061F000FF;
	Mon, 14 Sep 2026 19:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789414870;
	bh=3L4DjPfVjH7DnXsu0nfKjPS3l32zzJnypAp1/A2fkwM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fg3iXwg4ZU6m2XqMmcfChbe78CctWi59l+qmA7anI0z2dTWNcsgvy9t+qw2emWgHS
	 DlMTdJNOxX5lNzyuLF82r6Wax0HS8OgetRouiMLbMtfF7ESLlOXEcy9cohffT+OQ9B
	 a1CHOUvRDo0bRne7ItZrZe8RlOrnbK7tIbbH8dKZ0pQ5Jvv4vWfh2Pp3WkJmPYQByH
	 S2sP490PDK11FehxLkKHRans0Q03VI5+cJDi+pmZyzsSsfXl3/iuvwYrblk6Rs+ZZB
	 S/wPFNawvkFX6+AirkqdWVBDKFKTAKrrXRsBOyEOLq3wa8gGGHJXOCuoPfsMSqG8DB
	 MG/mf7qfHvtHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568E13924FD4;
	Mon, 14 Sep 2026 19:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool 0/3] ethtool: fbnic: Fix register dump parser
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178941480513.1189361.3629799487219008069.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 19:40:05 +0000
References: <20260902230739.2241212-1-mohsin.bashr@gmail.com>
In-Reply-To: <20260902230739.2241212-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org, kuba@kernel.org

Hello:

This series was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Wed,  2 Sep 2026 16:07:36 -0700 you wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> The fbnic register-dump parser is out-of-sync with the dump layout in various
> places. As a result the values of some of the CSRs are displayed using the
> name and bitfield definition of a neighboring CSRs.
> 
> This series fixes the affected CSR definitions so that each value is
> associated with the correct register and its fields have correct masks.
> 
> [...]

Here is the summary with links:
  - [ethtool,1/3] ethtool: fbnic: fix off-by-one shift in reg dump parser
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=fb8062c3a35a
  - [ethtool,2/3] ethtool: fbnic: Fix various TX and RX CSR fields decoding
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=db38bb13b152
  - [ethtool,3/3] ethtool: fbnic: Fix register dump names and bit labels
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=6b7b16e90fbb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


