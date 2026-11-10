Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279312;
	b=298RQmKinm68a6i0u3BmLXL77r3EKwykcZwxhp/3a1QVB5QL41wachhOi4pECIKfyq/s
	 1D4yia1qqURTS2E8S7i3lMm46FpVMohqc6SrBX5xa8FTIBGZdtyGitgOH/vBviZsghcTd
	 FQBIsXKKGwKJ41uzjvQF21t5MVMYbghh7Dzzwkfkhl8NwkWVHPBtCjeuVTfQwoDXy4oc8
	 Mljh8DDpDLewrRVcvnzJS9YoAGiBsSq8AUsSwaV1RJQZOlZ9cf7ClCLkcYJOq2UGZHxFz
	 ZftB+/8ooazGsATJxtDw2fYB9xUduyKr2IrYBXf7t5fyb0pa+AGUJKkZYTZByQTZA7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279312;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=GX6NMgzIRw89DK00cR/AHQm10bN7NFOig+LbXAxw8pE=;
	b=WxOhPchjnpgS8oamz7qdzE5QX2f8rkrjaAlX+hfQHMvEgDSho9NZHY/BAK3h4AdPrGia
	 ozt7svcR0mhMFvVQLRWrpk1nZyYNY31TekL5ZJaK39jdftwWwHzxVxxJjLC6pmgHNokZd
	 TNh0mx7d8ggdeRcx1B8mv8QUA/4ZCWXR4bTOKK4mbSYFZODcEc1uqzICceUkJxsjMqX8i
	 4aRrxQOYqTiN9SqafoFZMWuAS0ogWPK8eMXTFvB6tqkehJZnjgQXHtzkyzvS/u+TWchbZ
	 ha5fswbGgSeN2exYk6FmR/xgMdWeWrxf9LuPkQ7kCK1/Q5wv03drcuou2Wyh6+NwuVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qiit7JZW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33410606B0EC;
	Tue, 10 Nov 2026 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qiit7JZW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CFD1F008A4;
	Tue, 10 Nov 2026 02:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279311;
	bh=GX6NMgzIRw89DK00cR/AHQm10bN7NFOig+LbXAxw8pE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Qiit7JZWphnyULcjmDZtQY1+3Ad1ZuI7Nrngu8wNHQfGz6824RHRLxsyvWbSoj1Gd
	 NRhjRjWRi2aXENblbSiI2QR6Jn6eiVjtbxXnvu+bjYGpo9dIri/Pg+ek4pXJAHk7r4
	 OUp1h8Ye1xhoeGFnOppGyZvHMvKvcZj/4cTE4wZDp9SCoyI4S9VbK4oLHCOw5ZwKhN
	 bYUhpkQDPaIpXLehAr3EQrgYReSttWewDFtZwA/ZgQDmC4VVpFyvVeD4IYDgXCZUr4
	 //asiNGRJjtektg93joQSxSpFpsBQ62rZ1n5xYVMYoI4I59NJxe3OiO1zNZU28TAGZ
	 YRqSjQo9V4UbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B240391AFCB;
	Tue, 10 Nov 2026 02:55:11 +0000 (UTC)
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
Subject: Re: [PATCH] net: dma: use dmaengine_desc_set_callback()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427931017.3612825.1887357709243075778.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:10 +0000
References: <20261102191922.4044912-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20261102191922.4044912-1-Frank.Li@oss.nxp.com>
To: Frank Li <Frank.Li@oss.nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, wens@kernel.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, radhey.shyam.pandey@amd.com,
 michal.simek@amd.com, stephan@gerhold.net, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, Frank.Li@nxp.com,
 andre.przywara@arm.com, liyouhong@kylinos.cn, joe@dama.to, arnd@arndb.de,
 phucduc.bui@gmail.com, yiconghui@gmail.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Nov 2026 14:19:16 -0500 you wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across net drivers.
> 
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> [...]

Here is the summary with links:
  - net: dma: use dmaengine_desc_set_callback()
    https://git.kernel.org/netdev/net-next/c/e281e85235cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


