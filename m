Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792541414;
	b=c+gWGyhyPD2PkFWMeOJo0rnVJXlQVoVxWyVgtwBvwspO7X+Bgg+bPvz5V3rgxXw9/FHo
	 UtLmdC+oP/3u9+5cvov/drqihajooxRPawk1h4ANMnVt/gOJvtstlWbipfq/P76pyMLc0
	 jDhwNaxw+HMMhb5TCMhpVKo2FHiFVtZDMhmYzARMLruzJOwuH9vtwkdAFYKQHaU576Qmy
	 RvCSMf9SYre/XzKvxE5gkUjIAp0nYizlmW54yQGTRN3DcG5ECcqf6YaUvHlw0yYX9MhYp
	 91Ydq9EZC1L7E5078Gfxcjp4ouBbky412BJbZ8rASRHHvCr4SvraA9Oz30RRBrzwbAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792541414;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=NGYSqtXY1AnVivlpLbxLyPsD8hcsGkwLrPVEx+GFj5o=;
	b=u8F4+bOtUTrHMKOLLDH3plOznyAagihzAXjXFBa/acIO/0T0CZDhDEx6xSx9Tlb+WIrW
	 Mn576s+j50zh6gNemddGkq7nDLrHUQNt7yn8UFDzxkoqPYHsukzTn3yqUwO+6kvaj2m0L
	 HbG43FLzmvSBOi36t6btCHry+7I5bOhqkdD//H9ZpCnBX3HEFAccDZB5cJpiSh0C1vdvH
	 eblvjQGR3rSh7FA4kA/hMaLQanQJfLaRdBIsrmoAYqilSICHrKKVbBv54VWVrBky4mfx5
	 NyUw+kElu6JXlne52voqipzk0FQRz9Z1mmIMj8Tw6qGyqPVwv9HRvyS6MT1CcHq+Yyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcAX47z9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E3A606A31A;
	Wed, 21 Oct 2026 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcAX47z9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCE01F000CB;
	Wed, 21 Oct 2026 00:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792541413;
	bh=NGYSqtXY1AnVivlpLbxLyPsD8hcsGkwLrPVEx+GFj5o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VcAX47z9k7GWrd/eSc2up9vu944al3uDVkygRfWUNLbU5fkHaD426ue+potyRqfak
	 BjMlKHV2En4OFIzDzbrpUMrzzAbqSjH0FxI+w9rFzWYFE2hjNuEOfp8CYJHQoO5P49
	 Yo4cdi0mvzgxvYYw6IvrvZIDKKpzQOY5Bgp505LqFv7x53LvSMtddbgy11OL2R1/tj
	 k42TfQZh6LJlJ7FfxUtvOEjhd06VWxQDw18FbPWl4piugolsoUJfkPZtVAaH9Dsxgm
	 PijBYD1WhZsmyo0BlsVAZ2LNYMdpfe9KYTA2RkOQwZozHcJfb0KcBANyDkeMNE8yTA
	 x9PXIMCC2eYSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B449A3809A0C;
	Wed, 21 Oct 2026 00:10:13 +0000 (UTC)
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
Subject: Re: [PATCH net-next v5 0/9] ibmveth: fix hangs,
 use-after-frees and netpoll races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179254141226.280032.2437128299395048724.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 00:10:12 +0000
References: <20261013182926.30417-1-mmc@linux.ibm.com>
In-Reply-To: <20261013182926.30417-1-mmc@linux.ibm.com>
To: mingming cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
 sshegde@linux.ibm.com, nnac123@linux.ibm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 11:29:17 -0700 you wrote:
> Hi,
> 
> Nine fixes for serious bugs in the ibmveth driver: two hang the
> system, four are use-after-frees, one corrupts memory, one lets a
> frame from another partition stall or oops the receiver, and one makes
> ethtool -L report success when it failed.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/9] ibmveth: fix netpoll races with RX replenish
    https://git.kernel.org/netdev/net-next/c/8d9ecac6b96e
  - [net-next,v5,2/9] ibmveth: do not close twice after a failed reopen
    https://git.kernel.org/netdev/net-next/c/95811c873d1b
  - [net-next,v5,3/9] ibmveth: disable the reset work before unregister in remove
    https://git.kernel.org/netdev/net-next/c/141223544786
  - [net-next,v5,4/9] ibmveth: step past bad RX correlators instead of spinning or oopsing
    https://git.kernel.org/netdev/net-next/c/c9b95adc755f
  - [net-next,v5,5/9] ibmveth: release the pool kobjects when probe fails
    https://git.kernel.org/netdev/net-next/c/fd052c6823b3
  - [net-next,v5,6/9] ibmveth: return the error when set_channels cannot add TX queues
    https://git.kernel.org/netdev/net-next/c/16abfa871dc8
  - [net-next,v5,7/9] ibmveth: wait for in-flight transmits in ibmveth_close()
    https://git.kernel.org/netdev/net-next/c/c807573ea58e
  - [net-next,v5,8/9] ibmveth: wait for the RX poll to return before freeing the RX queue
    https://git.kernel.org/netdev/net-next/c/3f872b34368c
  - [net-next,v5,9/9] ibmveth: check headers in the RX large send and checksum helpers
    https://git.kernel.org/netdev/net-next/c/9486c89a8e15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


