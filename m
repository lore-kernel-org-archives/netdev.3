Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA144CF40
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564254; cv=none; b=G4SCN6VRbDCJkEJOkUCIPYDJvnCD6QfGinhvDkRWXgE6pyXIovqd0XiVoN0OPYOVPz036uoJArQ0d8ZDZ683qh/mCuAZgWKQKD2HgMdO0pnZqt1xwvG/zwMe2pPnTr/negZbgFIn9tqvsIVlQM1Z5e0tNiA2odv0IrU6uOxcthM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564254; c=relaxed/simple;
	bh=t/IUxpp2JodLCmZSbdoisFCsQTNRdqG6fFYrJKxnTUA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gztBz2HX1T1FYkvZgxbU4BCuS1ZlGD79pmql9K74GN6+PwjyfCsPMLTka5sCFawcu4Cjnti1kykeEBf8PJYtyZPm6nInZ12P99L91mlepXTE4HpE1NEvxe9uaiqbu1zs6M8pS0bFHHBK6sLc7O2Rii0OQeD2US1jzii3jYaiS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W93pzHN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W93pzHN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8508C2BCB3;
	Thu, 30 Apr 2026 15:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777564253;
	bh=t/IUxpp2JodLCmZSbdoisFCsQTNRdqG6fFYrJKxnTUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W93pzHN+Wuw0MQFQY403SVC2a43KcyhQFp5vlDBIN7wADawn/kGwbaTqA80Xy+7Ll
	 YtSXfnqsCDKfns6vBiD5g7VLOgd59FwByn0EBSa/5TYZOqqijcbhCS5TQC0LKmeNpN
	 B2zwPMdUDG+RY8DIdxHK3woVWbrLonq8ndtcgO5TkwVzx7Wmfmiz8TCs8L9HcsAchU
	 cOTISPdXy6F1w+xRe7UFC3+ojB8I/f6/5Ul7P2lJ1/DDHNHgraSO3v+gS6Uljssam6
	 Hm0920IZTT0MLj+FHthHAT5fPAj8n++r4hithVN5ZtSoS4hRuI9O/57sWE/Tllu0tD
	 qhKbEZWEOfYoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE27380AA5D;
	Thu, 30 Apr 2026 15:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] lib: add input validation for time, rate,
 and size parsing functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177756420804.3067548.8196377441992514360.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 15:50:08 +0000
References: <20260421202359.632074-1-stephen@networkplumber.org>
In-Reply-To: <20260421202359.632074-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 21 Apr 2026 13:23:59 -0700 you wrote:
> The parsing functions get_time(), get_time64(), get_rate(), get_rate64(),
> and get_size64() use strtod() to convert user input but don't validate
> the parsed values. This allows negative numbers and overflow values to
> be passed through, which can cause unexpected behavior or security issues
> when these values reach the kernel as unsigned integers.
> 
> Add validation to reject:
> - Negative values (which make no sense for time, rate, or size)
> - Overflow conditions (when strtod() returns HUGE_VAL with ERANGE)
> - Empty strings (already checked, but now with explicit comments)
> 
> [...]

Here is the summary with links:
  - [iproute2] lib: add input validation for time, rate, and size parsing functions
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=c99a85a7c8eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


