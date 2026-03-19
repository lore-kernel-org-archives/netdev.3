Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279B3E9F7C;
	Thu, 19 Mar 2026 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938417; cv=none; b=l7Ute2w4aY1A6GWmNaDvtBUwcGWpm5WoyfV3O+jab4EIeKsXdM0mp74CU3CyxAAmFUYt46784mpadWHW1MmVCC6L5U+44vo6s1kx9/6ssEklKszUNaGyLJ43APg7UnwZ3LQjzi+Z3HbIkNHhj5E4H8pq68cbNGJ8+egAE+GAzdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938417; c=relaxed/simple;
	bh=MV5BNbwXvaI0ASYw7Q+3gYMQsNYfca7q3AJDNfPoJwk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A4b+eAQQQMGZ0+aItcTRd6F6MGJ77wmCW8K1Kn1diCAsttwVBWgv2e2O/TSTJDhPgmZzbiiJ7Xe9u3c7buj2lC+uEuc3dQOka+rjphmQiKrQjvoCIH/EQMugXW/+b0bwQNzI+/AsgIUnmtkSIOdeYa+v7TP+0nvLID/rziuqh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoeUcZsp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoeUcZsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C399C19424;
	Thu, 19 Mar 2026 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773938417;
	bh=MV5BNbwXvaI0ASYw7Q+3gYMQsNYfca7q3AJDNfPoJwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FoeUcZspymLy3BPQxW5zhI2wPipAdF5nVTRm6kpvVxXUWCQPX5IQZHTHWvR/PqHR6
	 1wSw8jGCwXqxcIACAoUBN68ONf8SnSFinJWt/1hKu0/uHPXOaNB8q4FG3xv+/730oi
	 1w48mjmBSK5USZvdeznaGWbeM59Dij6XJoUckmfem9wBtSWrdTMA3bQ5Fp0+FHHGh5
	 c0DmYMR3mxdkubi9cesvy5F35V7Dn2nFnK6adFsUuRdb3WeepZc1U/aJAmrcQwelP6
	 iCsoVYB7gyeUnRpIxw1Sb21MgnhIZX+/p/IajaUppTQvq9d6JIF4WLZKmI0sL2UnvB
	 kwFGtg2cLzgIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE85380692A;
	Thu, 19 Mar 2026 16:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] icmp: fix NULL pointer dereference in
 icmp_tag_validation()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177393840804.1701817.18293524741667806586.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 16:40:08 +0000
References: <20260318130558.1050247-4-bestswngs@gmail.com>
In-Reply-To: <20260318130558.1050247-4-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: security@kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, xmei5@asu.edu

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 21:06:01 +0800 you wrote:
> From: Weiming Shi <bestswngs@gmail.com>
> 
> icmp_tag_validation() unconditionally dereferences the result of
> rcu_dereference(inet_protos[proto]) without checking for NULL.
> The inet_protos[] array is sparse -- only about 15 of 256 protocol
> numbers have registered handlers. When ip_no_pmtu_disc is set to 3
> (hardened PMTU mode) and the kernel receives an ICMP Fragmentation
> Needed error with a quoted inner IP header containing an unregistered
> protocol number, the NULL dereference causes a kernel panic in
> softirq context.
> 
> [...]

Here is the summary with links:
  - [net] icmp: fix NULL pointer dereference in icmp_tag_validation()
    https://git.kernel.org/netdev/net/c/614aefe56af8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


