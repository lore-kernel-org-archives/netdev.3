Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510606;
	b=kzcZwf/DQ86QEB64IvVupxY9heJuo3jDwhLoxwp6hbLjrXkUTFaIpFM2MZmsi56ldXGc
	 JqHW8DFeYTcsYxomuLWZ2z6mjfD9jb/pwy3N38nOpHHTebyAxC+4X06TIhpDr0UtAceL8
	 fstFDbjJEFJskw0zjq3IIdNnkgK022X/fIohvo4yiIoL1kfyY82pMrM9oe/oIOb8Wblv0
	 hkXMcESqPgsktcnlKpW7jjIiSNnNYcQC9DaJHq+5YpadggrEJ9e+Lurz+R/xjcqIt2l3P
	 3THOpmlMQdPeTujID1qYMJqpYyqjnutcd4Wx0MflU6h3ai5svCA7tA+mggQGAJIHs9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=k+u9ZELK0cEE6mVHbrD+EOF2KyXq+O1Ddn95XbV+VJg=;
	b=DUlzbhRZARZ9by02ojpk8W7Zv3NbstzuICeorCYRBwf2GNgkU6EhmWa35mfnzeV8yA/m
	 YW6U/af2bNt16if6YnwwHXYjiTAc5obatjI7MRZHmVcsfIP9KvLAEUw9zZISEt9OJHuFq
	 tQ7fEBbN2UQL/tz2iU/6p7u4I89P0hB6EOudhdGVhxSMsX4Gl63ckfDFSAbpnE3uMS2Cy
	 611qeJYhjQmROB4jBJawiqiuyRhNXYDYLBGQoxcwa2shmOrdw1Du4ZIViYjxS2+i/doaq
	 5Dpk31Ly16wYfJiM5dIFJZjCcoRosGrqFZhn+qlUKW5f6cbXi2mMoZ6fshWxBE7FEXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGbwzMi9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F096606A333;
	Thu, 12 Nov 2026 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kGbwzMi9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0894E1F000C4;
	Thu, 12 Nov 2026 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510606;
	bh=k+u9ZELK0cEE6mVHbrD+EOF2KyXq+O1Ddn95XbV+VJg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kGbwzMi9Awtvf3OKYLK90cUD9IA4pztlDuQedtEus1Z+4oHrC3ga6M0Cd53XJ65R1
	 HxOJz0ntN3mcQDxdM8pibJQi4UV5TfrudDHstDqyFFYGYnGiVW5hVWMGwVLKRgHscn
	 Rf71krR3IAAe04OUnQIzLzZXa3Aa+DS1kWvIs8NaDvBPNmCFDHil2vVoVi5a255veD
	 if6oF6lYrlFismlrXUxVFpCk/lwTUCB+J81ApNT8qX3W0xrhpx9Hc8BvtTEVbaoKJK
	 98x99XQ/dzG5pbtB7+AB9jH/9eerG737x3KjQ1CNjNwX90T/TkuSaJpli8PUxBNGsh
	 AgLLUaRqF8sAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16303924A5F;
	Thu, 12 Nov 2026 19:10:05 +0000 (UTC)
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
Subject: Re: [PATCH net v3] net: phy: c45: select BASE-T1 type for the forced
 speed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179451060478.599290.3189541035062475572.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 19:10:04 +0000
References: <20261111100053.345196-1-iustin.stolniceanu@analog.com>
In-Reply-To: <20261111100053.345196-1-iustin.stolniceanu@analog.com>
To: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 eichest@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 12:00:53 +0200 you wrote:
> Commit 25108a834e14 ("net: phy: c45: add support for 1000BASE-T1 forced
> setup") made genphy_c45_pma_setup_forced() write the type selection
> field (bits 3:0) of the BASE-T1 PMA/PMD control register (1.2100) on
> every forced setup: 1000BASE-T1 for SPEED_1000, and 0 for everything
> else. 0 selects 100BASE-T1, so forcing a 10BASE-T1L PHY to 10 Mbit/s
> now also switches its PMA to 100BASE-T1, a mode it does not implement.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: phy: c45: select BASE-T1 type for the forced speed
    https://git.kernel.org/netdev/net/c/df501db9b18f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


