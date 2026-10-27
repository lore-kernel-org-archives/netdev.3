Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059210;
	b=azLS/am9KXJbk/ucS4bC96DwbzW3QslJoZwbW8cjtNvhnnGylW1utdaGwQRLIwi7ejAG
	 HMpgCgYR1IBuuJIpmlS4dNxiqveXM3cj2ron8yyoESJXxyn7ZYjOJ582ORUX0ltQdBxXw
	 IVOJ6HVpIldavnJoDz5dnLgy8nQfqfijVdOzZt0CajlsZiY0M8IkzS1IWf5TaGal5xGwE
	 6Nj31z+PMBU8kL5L7IftrFklgJKp46FS0/6c2CuGejBoJYJlkBWv8+uLPhYKmPyl1paWD
	 imVBBOn8jsWiMd+XzFm8HjT6drrbt5IK+cHVNWdyIIgJIAxABGN1NWuFqtCfiRwdhRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=/+dLj3NwfDosSbNrwS0xYoMb5nud4zuqBHFjRnmRvY0=;
	b=ARpZ9dSYEsk0hhdjFIjjYFNZgJsXhZ4vWHi10vHJ0BoMFC6fHlJI4Izfo8MdMrYA/igb
	 rIMQf+daqcJe9vkk+8+cdsXbRPdmgreH73IMJ8SNNvpagZcAe/62WtV540iDq3bKI8tKF
	 l3QXUT0VNlvAx4xAplpkqH2sumlRWOEuZnTSlzt3nNLh+p51QI+udYu+BTyZnIJmFyyOv
	 HxcRrhYFyT3yEIU25ckZ13Othmd6bNIHShJeYJ9qPsZJ9bxN+lXrtY67MIBOwsZbpqTzt
	 fMdQCmYx28JZHVVF2yC5cTtsjrKLbt/iU6RPfMIZh7KxEy+2e2Gr42ZWMrymh06JIGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TowA4J8D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBEC606A31F;
	Tue, 27 Oct 2026 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TowA4J8D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556151F01825;
	Tue, 27 Oct 2026 00:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059209;
	bh=/+dLj3NwfDosSbNrwS0xYoMb5nud4zuqBHFjRnmRvY0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TowA4J8DHYvJcYlA8XeLH9ME0quzAgLwOxbL6RDn+3RBbiksfzR+I4UeHnOSPcMeL
	 nIK8q21woxG3kWfEsZoVFt23I2R4s9d8PQiOZTxbPPiDhK0IrqTMPJ9wMzoPSWl8P2
	 laexTR9WFWL8d2x+i5z+ysTNO9Cs/Qo7Dr9z0NsVuYrM1gDCoRNMoGM5R00PvYjfuZ
	 9srw9MbAPk+1EtOE/Pb777cMQOMqgQvp7qrxx1uBtqX/UQjLB1pFaU3LVZQjtkKEeG
	 Vaj9CADb97F5HFRnFN/X7rMpE4YILL2+r/UD/rze9OP6sRzi9OSIPEkfWh5uezh1b4
	 Z7SZlg5zpFykw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 496633AA80F1;
	Tue, 27 Oct 2026 00:00:09 +0000 (UTC)
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
Subject: Re: [PATCH net] pppoe: drop discovery frames with no MAC header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305920806.3470272.16839047097995389873.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 00:00:08 +0000
References: <20261023080002.221332-1-qingfang.deng@linux.dev>
In-Reply-To: <20261023080002.221332-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ericwouds@gmail.com,
 nbd@nbd.name, manizada@pm.me, gnault@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Oct 2026 16:00:00 +0800 you wrote:
> Commit 8540827ebac6 ("pppoe: fix reception of frames with no mac
> header") drops PPPoE session frames with no MAC header to avoid reading
> uninitialized memory.
> 
> Apply the same to PPPoE discovery frames, as both functions read
> eth_hdr(skb)->h_source.
> 
> [...]

Here is the summary with links:
  - [net] pppoe: drop discovery frames with no MAC header
    https://git.kernel.org/netdev/net/c/406bf2dc8d6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


