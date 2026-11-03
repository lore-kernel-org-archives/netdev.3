Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716808;
	b=Iiv6w13hpkAUy+usipyKk6XdSg9FOg0rXNw1st1ePvXFIVoslLg9EWmaSlbxuvVIRD8M
	 iKt7SwJXaumxsWJja+BPouRtYw+BnpOuTLxBKSiM/ONAuI6eBoXqFCkmb/g2hEhlWWfmM
	 FbEmXOHSgM5oeo2vV8vg3Yjl/5UUOlnmUIDTT0Yk4OC+AlNjsJOl1GpgBgTkqkJwNeSmh
	 8IWSCj8Es+SGfcWQEw38EOsZSa915/fjRnUCXI3n1UMvetIYkusjztDq1DiQ/JYkO16+N
	 Ih/1EWEUR4jr158EYBVUtFRUz8DxFP2ysbV7Pav25IThb7SBAYSqFO045TNOMH58KvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=c8feyeRH0cLxLRTnPthYSlIT+r0sTk1DA6ZShtbnsMQ=;
	b=aofiVNi0I22ThZCHDYzEt4yglYFYu987SWSiKqvtXYZxYUsvxc3uFgnzVRo1fMmrUmtM
	 wrRDouBq1o3w1nxDIwsVZv/VkUKwu55oZjTDDFOzHBqItQ7QjyOiQ9tKTXmpO680v9Emd
	 MK1uzoTYoDY47k+TRogbg3xGVViq4NIKg0yTQDLxwVSRnwpYeE8rJyAc1aujNQyRzr/g1
	 7n4RT9X49aJFkE2/WZo+KRj/mAeQCx/ksMfw3Vdw5+kwC9gB5YrP2x37HkIqps4Lv/Q6Y
	 DMV6N0nWhMTH34MUII3N0zuZcLYWebJBxqOJVA09DC3wD8stdntswF6EgL6oTXvPdKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZzaS/S17";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421B606EE9E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZzaS/S17
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890501F00A02;
	Tue,  3 Nov 2026 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793716807;
	bh=c8feyeRH0cLxLRTnPthYSlIT+r0sTk1DA6ZShtbnsMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZzaS/S170d18JLSwtKD3MIipucLeLQokKkNsJ5HsFCp993rwJKtbFjhWnM16qUlCg
	 CDx4q42PpJRFxRU+D2FK/OyNOdj0LhONfGVTsOA+UMsOXsKebhK7aFw6MJ9xTDR1Z2
	 6XLmMiG7XNelyoIlN/FIlsYWDAAIFX5m7tnn4WkT8t8aOKWxE+aPlnpQu0n2ybTo2U
	 RARcZLmY4xMCY78obrEM4dhJv/U1b2BsZvbRZxVWVnUPzvhwk371vjxpmcQs1x+VDY
	 mk1eISV2E1s1oBxIlTE0lt5AkVpxdzPrJOwyrCaHuuXKQMdsqk3yc0cApNCKdQDP7x
	 ymshE7/0Pp1lA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D22D38007D0;
	Tue,  3 Nov 2026 14:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/2] inet: fix lockless ehash walk races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179371680630.1177966.16879360910200844454.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 14:40:06 +0000
References: <20261029214219.1035176-1-imv4bel@gmail.com>
In-Reply-To: <20261029214219.1035176-1-imv4bel@gmail.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 06:42:15 +0900 you wrote:
> Fix two issues in lockless ehash walks. Reject unhashed sockets after
> taking a reference in established lookups, and restore the acquire/release
> ordering around refcount publication and acquisition.
> 
> Changes in v5:
> - 2/2: add acquire ordering to bpf_sk_assign() for BTF socket pointers
>   (Kuniyuki)
> - v4: https://lore.kernel.org/r/20261026003804.61923-1-imv4bel@gmail.com
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] inet: reject unhashed sockets during established lookups
    https://git.kernel.org/netdev/net/c/4e2b3ef19e0e
  - [net,v5,2/2] net: restore refcount ordering for lockless socket access
    https://git.kernel.org/netdev/net/c/5b5d8f351dd9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


