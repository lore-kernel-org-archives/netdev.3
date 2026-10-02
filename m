Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A04E3259
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956813; cv=none; b=URDcXiHAw1tHR1zBdmSrTctxl73FA/sbJE/8XvzaJYUfXxedxERXnCN9XEkIk1FUxxFCyj07dfnBb8QYOqMpqUR3ErJu0bbFRA54nGJTSF6brfSSBx3uEvr4bp/Fo24W1HvtVCqD5xQykb2D2uxQMYK+LzraT0lCbso1npPxvGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956813; c=relaxed/simple;
	bh=Gd7W6BHc7DW0aqO8u1VvBplI+LX2rYVFxa/hScQ06r8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jJ6NJ8asdgrubmeaHWv5sVs0TVsrdNjBt42kxc3V2QjkOQptXqtZYtObxNBJ+ENc/ebvqEFcD6fInQeTDkHgTxURbVFp3R7PpwOc7jPFVK/HzKru4zlfZIH6cCp6otmzjbaj1L7HjrZznR1/ESheAhfj539mhvq5n+FW/kar++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5Yu19sM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5Yu19sM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2401F000FF;
	Fri,  2 Oct 2026 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790956810;
	bh=72sWbL5Vr9eVdwnb1cu/UKmM/EhAN6x3Eg2j36NdlLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n5Yu19sM9sDjWHojMXrMb2xNRHxYKQxo+TO+Um4qo+yRktx1I91JY5WkvABVLqGtT
	 ax/9jDkFjAT71vQrfuHjiAAWN8SWeaaH53xzzeTW3L2WkTPpwimQke+JFQtg/f3ZKP
	 yaGm9TSgCWPGc4JbaflMO8owB19K01RmyOIfsnmp93HwtPiBE+UyDkoXiJgPZ5gIuu
	 bOKPq75VdrYcleDGf32XN/R3vwi/tqCTHjPZaL6AYle9FAjjhTOy/8kv6T1WoqhW/f
	 kS8Y3ZHgCpJRn7OsotTvSatd6CcOOxBz1OBCzUHxT3Q56WwPsHBwQeb+/WMNK7fFJM
	 0d1kGL3nDM/Pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F137B3811A64;
	Fri,  2 Oct 2026 16:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute] lib: fix leak on realloc() failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179095680852.3481673.14252000971617279187.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 16:00:08 +0000
References: <20261001183731.2282758-1-stephen@networkplumber.org>
In-Reply-To: <20261001183731.2282758-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu,  1 Oct 2026 11:37:31 -0700 you wrote:
> If realloc in the getcommandline failed then the previous
> partial command line would leak.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  lib/utils.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [iproute] lib: fix leak on realloc() failure
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=e11870d5b941

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


