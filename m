Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42F18AE3
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111635; cv=none; b=Lg3Mhu5KCHcd9JBZAFK+OpLheCJL4E00iJsptH3bdOE7xRKIE6cAbtIJgtpfTLUrzn+ebD+Aee3vrxgajdivEl9I1iPlL1Ry9XTiG+7bEOTdwORId+loaCLqxSQpRxGuQ4c9RZHhanJOY/vJ51cCSQh5+6lnYIFfxzzd/NSCu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111635; c=relaxed/simple;
	bh=JIVVxGQjXd1Cf4O7igWlJ/JjWWiFlO+jsTKMKo7qS6E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pyNsGZWt1jn8LkYPVEF87rDfb3SDAAcNcuoYAHqZRxDQnWrofbfFqKtKMWojOGRBOseFBjb3S5dKIz8sMhxGxJaPaIQxaTI12RZ7cvKbtCy+LCefQPhoQUDoQKjffEurilQV5/ulHsJLzsgp4PFcflbPvwdfy7M0JzPv8H8404w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfm06AzE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfm06AzE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FA0C19423;
	Tue, 10 Mar 2026 03:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773111635;
	bh=JIVVxGQjXd1Cf4O7igWlJ/JjWWiFlO+jsTKMKo7qS6E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gfm06AzELJa+oyoHrkw/uod36rhUIMOkaDGpyuW+jKADimo8znH4PbhnttfzLefse
	 eQva4f/9I/BKMKTkjvn3qf2XCeDkJwqkIraFLvfBba7l7zCMjFNYyiHDJMhE7lD/7W
	 D8QdLt7YOjnRFp7epz70hbYNHFOd+dW2l3WRqgjWZiMwPshhOR1Mc8jzoo/p10V0qi
	 A0v2YBtWPsjJ906vATU5WFbrwmokkx/uQ16vWS7MjAcJhNw7BO6/7KxOmKgZr3B8wh
	 xIgX4dsXtRjOojhr4qWzIxyf3EBwyJXZGFIP8O/L+YqwGqJmx1OEtdJs/DEvb1U4r7
	 XRq6E62Zgyokw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD863808200;
	Tue, 10 Mar 2026 03:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: move tp->chrono_type next tp->chrono_stat[]
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177311163204.2039470.12236470908983671120.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 03:00:32 +0000
References: <20260308122302.2895067-1-edumazet@google.com>
In-Reply-To: <20260308122302.2895067-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  8 Mar 2026 12:23:02 +0000 you wrote:
> chrono_type is currently in tcp_sock_read_txrx group, which
> is supposed to hold read-mostly fields.
> 
> But chrono_type is mostly written in tx path, it should
> be moved to tcp_sock_write_tx group, close to other
> chrono fields (chrono_stat[], chrono_start).
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: move tp->chrono_type next tp->chrono_stat[]
    https://git.kernel.org/netdev/net-next/c/4b78c9cbd8f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


