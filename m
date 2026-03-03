Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA708313E2B
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 04:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772513224; cv=none; b=hz7LyfU3wedFlI5YKFwqTeLWMXHIGJfQ+IqoCjnGAEwLhqBpUE/iHHoZNAPvu20VxrqAxOCKstpy+V8cuVRYJW9fPKo960clDESEWlFLzX+ywUWuZCe6c4O7AoJfpS4NYDZ7piwToiaQcge2Rn9dFp5aWUftR2/0w/47x5A6wGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772513224; c=relaxed/simple;
	bh=ReRegnCEuOLJkkAqXoW8FZuLPFiDvjgtbFm5IfcM3+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aGvo1QxluTZ1NJvpeT1KRmmeYeEpPxZ3AxB0kuA5X5aBbeKakX0y+FM5Qca1bR46JAKkC69O3Zz86eMfnZl/babsUo+FETclwpAOHF+WPBVjVPWoLl9sMwxusl9mgq+DhowZ5hJlN7IYBbHpANC18RD5gwCf/7d6MMXhEVtlyUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZpBWi01; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZpBWi01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C541C2BCAF;
	Tue,  3 Mar 2026 04:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772513224;
	bh=ReRegnCEuOLJkkAqXoW8FZuLPFiDvjgtbFm5IfcM3+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DZpBWi01iyozbwzr0aVH581Bl5e4PGX5ryIrPqZ9f4hmnnyO5lX/BZFaRwtyPG5HN
	 CczVn/DUJ8RwNc8C8dw+K1JoLx4TxGBxJa2p6cXxRcP9W6Y68WB4pLyP4dYv6/m5EV
	 WckMgiulIbRiywvIUcMd2/TCLQwHwug1oC0zs/XqnEyBl3iCCRX4PC+EkTUZkNFcPQ
	 Q8RfpV+kAPPp/9fCO5qIwkreOR+wy/rxUxGU4UIMfvHI72tCyItOsE1Ohf5HGS9H//
	 06XUSy2p4MzUVA8WpYu2vZT6oRqkWG0znnNYiGDTOvR0B1ufuwDNDgcXQVnJcpo5bL
	 t5MCaTBtjgN3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE923809A80;
	Tue,  3 Mar 2026 04:47:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] atm: atmdev: add function parameter names and
 description
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177251322604.625663.13472463638452478558.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 04:47:06 +0000
References: <20260228220845.2978547-1-rdunlap@infradead.org>
In-Reply-To: <20260228220845.2978547-1-rdunlap@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, 3chas3@gmail.com,
 linux-atm-general@lists.sourceforge.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 28 Feb 2026 14:08:45 -0800 you wrote:
> kernel-doc reports function parameters not described for parameters
> that are not named. Add parameter names for these functions and then
> describe the function parameters in kernel-doc format.
> 
> Fixes these warnings:
> Warning: include/linux/atmdev.h:316 function parameter '' not described
>  in 'register_atm_ioctl'
> Warning: include/linux/atmdev.h:321 function parameter '' not described
>  in 'deregister_atm_ioctl'
> 
> [...]

Here is the summary with links:
  - [net] atm: atmdev: add function parameter names and description
    https://git.kernel.org/netdev/net-next/c/c69855ada286

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


