Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615407;
	b=wFpv+MqXpHahEv3ii+QrR9jZ1au7LgONq1TcANi4ASMQkL5s8YJU2EkRQ15lzExCDULk
	 8OXXOInOqwZs6Fe7CFTO46wUcWelrPSxnPH0JbJMahgODxfUNEDu4aYA3F0hw4OTH3/fu
	 OXc08diZqQgPgqviDBoTHjpjyxnzRD9E+mOO1hljeWR63b9QPCEamRzhrMtgnPW9bdJGN
	 0osuBheFGpvVw/51pZIYAea1cQ9pdnMJRRP4gglRqUc07O4SBAKwxHy45R9GTW39Z23ZM
	 LVTiXdC8mGAphrI3Nc8twuC/XdXz7XXGo0k+FXDwpIteAKa6ebuH86jf7DBmXJ0I2tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3luduruKEhgJZ4x8d6ivAEmkbNCYAjS23jeoJK/KgN4=;
	b=utsUBWrry0w3f1pHH1GUVfoaGupXCM6pfUAt5q/3yDbYcS/WYdbqIeuQ99iSNiU3j34Z
	 FlXsAELoFWcM6NzH8y8pYzH1V4lAHr8543zfRTP8+vOki2Iz41StG6ZQTaaV6hULYXN5T
	 TF6U2djOt1YLXQzc/APhFvPEll6g8MyWSx5gB7E0Qmy+Jc1QCP4XihjbnBBn41JWpW1Er
	 klNHlobXzWInU+3cChOoyNfd7jmJ3Tr27GgZ2COJoQJSBwtVDLdYiXcdMsM8p/okjVR2W
	 YCjwup7KTrqO82G+zcs9HXB0BBpyULdUHNUT5c4U7SBo3giaNqzpsSUrcsHho8bOgRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnZaOsCe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996A606A329;
	Mon,  2 Nov 2026 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnZaOsCe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C96A1F000C1;
	Mon,  2 Nov 2026 10:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793615407;
	bh=3luduruKEhgJZ4x8d6ivAEmkbNCYAjS23jeoJK/KgN4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CnZaOsCerCHE3nBgq8+OsRiONekXv1UUXUtvrbW+SA35d5VfQfbOwr8cku/lt0I7O
	 koW4nAmee3QkOWQ+RmJxBJY+NiWyobGKfNcsFoef9YW0YWz3p9RFLG7BE76CaH3TCd
	 UtY/cTvLH38zqdTZaQYmT/2F8VIjvwb31Ky4M+qnxdCDSPRtZtZGnRwbk+L7kSCQXn
	 J7ND3FlyIEnq8MnigiIeCOx0JRp0o4+vu9inSaFpCfDGXtDAE1O5R1yuo0kDAPnHze
	 ptHHshlrjtt7nWHnho/MLHKAvTqbfh5d9KfYr5T7oSUET0QeSJDfQCSk/L/JT/jZhs
	 q6U3nkLCrMeew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0303B380821F;
	Mon,  2 Nov 2026 10:30:07 +0000 (UTC)
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
Subject: Re: [PATCH net v5] tcp: do not let tcp_collapse() drive
 sk_forward_alloc
 negative
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179361540591.3925787.2665655374452049262.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 10:30:05 +0000
References: <20261028190820.2917252-1-tavip@google.com>
In-Reply-To: <20261028190820.2917252-1-tavip@google.com>
To: Octavian Purdila <tavip@google.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shakeel.butt@linux.dev, willemb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Wed, 28 Oct 2026 19:08:20 +0000 you wrote:
> From: Eric Dumazet <edumazet@kernel.org>
> 
> tcp_collapse() charges each newly allocated skb with skb_set_owner_r()
> before the skbs it replaces are freed, without scheduling memory first.
> 
> Since sk_mem_uncharge() reclaims eagerly, sk->sk_forward_alloc has no
> cushion and can become negative. This can be durable when the collapsed
> skbs had a high payload/truesize ratio or were partially read, because
> the new skbs can have a bigger total truesize than the old ones.
> 
> [...]

Here is the summary with links:
  - [net,v5] tcp: do not let tcp_collapse() drive sk_forward_alloc negative
    https://git.kernel.org/netdev/net/c/031c403d13e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


