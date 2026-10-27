Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793095808;
	b=qYJ5wv20Xl5g9iqyX/ulFSBM3TrlA2AIZYFM8o/G1pphZgrFuDht87H2m4Fu882lDYBM
	 a4vsfjLH0u0ADwW+FoOBDsnQe6Euf5/ofPRGp6Yl4sWapiStRghPY+CHtFrqkEfb4ginH
	 rXtWXwoFy4ou4NPMDgeejQWTV/9zJ68zspDTCNsWO+/SUc7wYAyHrYImipq50WWKFI5nw
	 NgzeXAIwFuCiniT2FAzjaDE4n4I9GT5ZEcwUVje6fROCQWzDPOhyHe/z70AELxSFwzGrx
	 J+6ENd9d9T6HsddmpiiaFcMlQLi8P0IlyGnGA8Z+KYst0RjSJGMxeqJQc/eo7df50Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793095808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=wFjjwyONnPzQ4w3z8NzIQoH7nGV4JXACu28LTxdUNb0=;
	b=PmhchZjQChR9x9KgePxtemJPMjEzL2E2/RO0FAbBw7Q76puOCoAApVVTzdo7FFpc4/hH
	 bkuaJeH0frNoL17s4tv5raFnWjRId0ezuMQ4iEsBAptLQlCyVxyr+6wQtwaFheeiRsiqZ
	 /xPESz6E/cmk1lC7ZdWAGUYbRTUrHryoQDcK2emF45A3TaPpKYm++TnxMhKLyrm8dLzKR
	 aF9XQhHxcPXOFnpqNVpONO70gTZ7Hdl3w4xRu/4GQT2srY/6ZGPIu8qSPfTu+k8zGmuIg
	 My5rrVJK9m4kwuFgyFpoh/4nOab/TAvtF2f0BuFtCLhG+OfnA/q2XkN2ir+m0b3q3gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGirNWWG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7C606A31A;
	Tue, 27 Oct 2026 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGirNWWG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5103D1F01825;
	Tue, 27 Oct 2026 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793095807;
	bh=wFjjwyONnPzQ4w3z8NzIQoH7nGV4JXACu28LTxdUNb0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aGirNWWGEpxMK4wS0z1nuJBln4c+Cu1HEf9MES8VEHCRe+rktGQLU1DHpVNdeseKc
	 AcIVmxpuXngANbTcmbm+1z7hKHMY0erV0zyG71PSUwHKRx9kkMX7Teh4wbph/pQXLu
	 23Njsw64iqdrWYmMwqC5/cLLXgrHaqGrdRYYk5WCgfjFwiyzgcJ4SSNQlwGm8onzcv
	 3fIfgk8kKq2ZRA0XUVbdrKFizfCFwXB5Rq1Ra5vTWak83EVCdFsM+Q36y5RO2M2RDZ
	 jSD8obv0rrUCFatzM83/bbGGUzyfRhCUX0Q+ESFzj0gQjxn5izc3O3MhK3r+JmAZbW
	 CjY8tMjnkUAGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444A73AA8FFB;
	Tue, 27 Oct 2026 10:10:07 +0000 (UTC)
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
Subject: Re: [PATCH net v3] net: dsa: mt7530: trap frames to conduit in MFC on
 EN7581 and AN7583
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179309580589.3705173.241549361006084981.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 10:10:05 +0000
References: <20261022205649.2351696-1-gongtao0607@gmail.com>
In-Reply-To: <20261022205649.2351696-1-gongtao0607@gmail.com>
To: Tao Gong <gongtao0607@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@oss.qualcomm.com,
 chester.a.unal@arinc9.com, daniel@makrotopia.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, lorenzo@kernel.org,
 arinc.unal@arinc9.com, florian.fainelli@broadcom.com, ansuelsmth@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 22 Oct 2026 20:56:48 +0000 you wrote:
> On EN7581, STP BPDUs received on switch user ports never reach the CPU.
> 
> Like MT7531 and MT7988, EN7581 and AN7583 only set the CPU port bitmap
> in MT7531_CFC and are skipped by mt753x_conduit_state_change(). On
> EN7581 this is not enough: trapped BPDUs reach the CPU only when
> MT7530_CPU_EN and MT7530_CPU_PORT are also set in MT753X_MFC. Add
> EN7581 and AN7583 to mt753x_conduit_state_change().
> 
> [...]

Here is the summary with links:
  - [net,v3] net: dsa: mt7530: trap frames to conduit in MFC on EN7581 and AN7583
    https://git.kernel.org/netdev/net/c/a58b221496dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


