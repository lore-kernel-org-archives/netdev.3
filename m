Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5857B37A4BA;
	Sat, 13 Jun 2026 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308817; cv=none; b=mEuSZyrV23lPS84iZ8uAn0eON95hp3Pn+Pb3Y8vWgzHLaIHqXuWKPLEmoUJf2Y7XxYxbJ+JMwR/MArTxCwzXaS8YYevtbNffSk3nr3pKeupOBMDABCbeajMnL1tCEjU5QctQPImx/5F+0yyPMTWWQf5BI4LhqNR/XpRMJgZM8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308817; c=relaxed/simple;
	bh=uyKZNfV+FrzC5S34lvsTujIR2Q8wqllWcjddceNEE+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mELRCACfuzE3rOdvNGiU+KYHtOPoYGTDM0Nf0Z5tm2lzEoDyg34tX3pWgBCQnxWwpZ4wAyasUIC5QXV2zIJ5CEii5Cp38dVs9pzGSaR0IjC/cUnUg4cygKcvXSLnxJvMccrEQbCTGrfHTcSX4z3fes3rGVWniGscPyR0xiRBXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzrDMYwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzrDMYwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BDD1F00A3D;
	Sat, 13 Jun 2026 00:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308816;
	bh=Nt1+ajjDEnNN42gTfFZL55aPCz/54VtL02JEDvkr8cc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lzrDMYwOeYEI9Nyex34CKB1qA0oaFH8CzITvm4zVF1w2bYbSucUVGCKzoIB8TosXB
	 7NgOFv+vbPtpMWhVng3GKM+IjostIbZG94AG15cLi4Kygmo9PeNiKesPhbk0wcAZgH
	 OtgL46D5g/FCou1ZTY+fjl75pDe/cCkzpciCWpuMdGOZQ296NPYOqA7lFWY20tR+f4
	 ZGErBWNqCC6JUSYrVHgz22//mGwPpv7RYczWHjUaph6ING8zl6xMYZ561qRkadzG6G
	 /TBIJbnS9tM+rHM+IGzEtoOhSvjqFJyKMWBrshD7jXqtxLaXrLmODj8YOxx79kaD7G
	 PgbXbpUPMKkng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AE439E9605;
	Sat, 13 Jun 2026 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178130881264.1297459.951918209446333634.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 00:00:12 +0000
References: <20260609140911.838677-1-dhowells@redhat.com>
In-Reply-To: <20260609140911.838677-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 15:09:04 +0100 you wrote:
> Here are some miscellaneous AF_RXRPC fixes:
> 
>  (1) Make sure rxrpc_verify_data() allocates a buffer, even if the DATA packet
>      being looked at is zero length to avoid potential NULL-pointer
>      exceptions.
> 
>  (2) Don't move an OOB message (e.g. an RxGK CHALLENGE) off the receive queue
>      onto the pending queue in recvmsg() if MSG_PEEK is specified.
> 
> [...]

Here is the summary with links:
  - [net,1/5] rxrpc: rxrpc_verify_data ensure rx_dec_buffer alloc
    https://git.kernel.org/netdev/net/c/16c8ae9735c5
  - [net,2/5] rxrpc: Don't move a peeked OOB message onto the pending queue
    https://git.kernel.org/netdev/net/c/5801cff7d5d7
  - [net,3/5] rxrpc: Fix UAF in rxgk_issue_challenge()
    https://git.kernel.org/netdev/net/c/107a4cb0d47e
  - [net,4/5] afs: Fix netns teardown to cancel the preallocation charger
    https://git.kernel.org/netdev/net/c/47694fbc9d24
  - [net,5/5] rxrpc: serialize kernel accept preallocation with socket teardown
    https://git.kernel.org/netdev/net/c/dc175389b18c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


