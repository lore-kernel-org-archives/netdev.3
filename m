Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF9326945
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785403845; cv=none; b=YiQEvxSXLjnn5QilPj22/9NJARv5bVjqowogbtJCTSB3jJH7eCIkd57qsphQAT/uSDMEhVTgc5lqcqMLSiEVddX8o7+lbvuqSzqc5T2QZVybN1ATWMZkxaKU4Wjuyd85oWQMag9+m7xm548acoYoi+x4t5/tf9YsBGOIgRdTvy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785403845; c=relaxed/simple;
	bh=rZ9JbA0S5TbAZ8HiK8jE6ygWzKrJ6rHIK6/VacccEoY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jSeCpJpSyU8THvShANLX9P9a7VjtrVVWYRiUxMo+B+XnJNNW7pHkNamJ/9UU2QvSTNksXuTCO+KEHmDe5rGTTJ10+r+GJbVrtkcgOZHkCHqPOhK462bPLI7/R36SDKoOWGSQvxxIeCHg2JjoyKW0JZW8Y3gkgYwM16jJANjBHQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGtvfLtK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGtvfLtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655541F000E9;
	Thu, 30 Jul 2026 09:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785403844;
	bh=SnKNYJ5kYHmHl2jv7xeQbuwj5ySBW8abAiJvknwfpfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bGtvfLtKTaqdA9EBfwxNTuLN9o1DW4VxYp1S65hUiQsGkg6dFAw81ZBp+zibUYUxZ
	 5FKD9ZStea8PVUBM7ANrIV5n2T0Mk0DGw7jgB7cDliHwcXjtPauq39Rp9z0o+32tgk
	 q9Sj0cIUNZbTGVf9bj6EIvsOWE/y0dKVZWT/+WV194vByOSAtJ3qMp5r5SkkpCsfNS
	 aHXd+iwe1NzUwzG9DAbYCliDdUXbaySnP/9oBi+uxnOpBbli18A9YNo++AgKqc8xGE
	 3yhmxXpoYIDcx/z+E0nYHY865NgGnDJP1jyI/s6R7fIE+Z5+gDau17WXrYBx7x1I6Z
	 NWaUveZ4ZrCJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5690B381195A;
	Thu, 30 Jul 2026 09:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2 net-next v2] ipv4: remove unnecessary reset of
 position
 pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178540380789.3461627.4239979739077038624.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 09:30:07 +0000
References: <20260727091834.6645-1-fmancera@suse.de>
In-Reply-To: <20260727091834.6645-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
 dsahern@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 27 Jul 2026 11:18:33 +0200 you wrote:
> The position pointer is only advanced if the return value of the proc
> handler is positive at new_sync_write(). Therefore no need to manually
> reset it when doing error handling.
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> 
> [...]

Here is the summary with links:
  - [1/2,net-next,v2] ipv4: remove unnecessary reset of position pointer
    https://git.kernel.org/netdev/net-next/c/ea771e17e995
  - [2/2,net-next,v2] ipv6: remove unnecessary reset of position pointer
    https://git.kernel.org/netdev/net-next/c/ac84c8551801

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


