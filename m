Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279321;
	b=4d/Yil3iJL+FMfjHxQSPfqXjhLfAvXxqdAr0u16c4TK9dlm/+FiFj9SQctFcPJYgzepk
	 c3i82CZ7H7pYZ+fcxsmt+zIJohSU60qvR0mVTAxcdm46DfUvjLZmgGDipUedAXyzC3uR4
	 86iWVrm2Un0ieaztag51M7ct6Z25SUhEAlvgJZKNNZMxOdwmHjMOkZL0Agg7VWwC5j2Wj
	 c8GP2p29TSw61bXJi7BxORxdWGpECT70F1UyDEg8gZ1LSbRz69NbaeU+VLt7bkxFUdsA8
	 xptnXBNWQwCzZbgVaCzyD3SKbtT8E6rHlLuO1MmMJWGHJSM8/cTMU6vWKTCvUpGbMxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279321;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=gJk5Loo4ewdZRGMXCTNBasCMn+4nttSPIJeUdBtcVpQ=;
	b=EPAfGsqNaMQk8avJuSHWZ5YPtvo4wiVwD30ZjxJtCHNZdciGunVwWQMvsbqI4cIDFzd1
	 8pJdT/DoJVrK5VYUnx+hjL9QLZ2d2U81jSdx5UOarvXKuegnpbhdLTWUXETiiWYsX/wDB
	 4R6jInSR5UQl7Yb+njnC5SDs4BXCgKsy/fp0anOVfhErpUT4mNvg8JMtLq7vTp1ukWq/2
	 sG+kw2om1ueixVcTEHbGMsXHn448WxTBwV0z0GcYGKZQptPqnZGIUYLYKt2zoFka5eJqO
	 3hMq+2DVs4FcSR6A5hEyiSF8GV64f/E1Dn9iZu8Qshw8rEV8VgUaSwGSgzl7BgIKhKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqoTNpTt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C7606BAFE;
	Tue, 10 Nov 2026 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqoTNpTt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E461F008A2;
	Tue, 10 Nov 2026 02:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279320;
	bh=gJk5Loo4ewdZRGMXCTNBasCMn+4nttSPIJeUdBtcVpQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CqoTNpTt55CLYEJTVbwdrkGOcFsGNV0oRSwdwCvalDa0ZGm2OIOU5AixCwiF/5CXQ
	 7WcvYGS8s4GJp/+aDjPUdvBrHlm1X3I17MdITovUETYjPBnp3+dcWWITh03tR+GZ4n
	 LcGKWni38QooBdstub+/HiddjNVDNXxuSELVaSGj9QN4ib9mvp/qeDqwNCIGU7Eex1
	 yYJsoxfgKVOVeX909YitgngejdjCiOAG99nJTgmGv27/HcaAVOOpZh4C4w/aoErp+L
	 M6qBBQd2tTDVzX3qdntIy94LLsH0fu2wTe/I0S6L4NGy+fmQYoPEEa5ujyi85GWgWN
	 AXxXEln7nQhVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B10A391AFCB;
	Tue, 10 Nov 2026 02:55:20 +0000 (UTC)
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
Subject: Re: [PATCH net-next] net: hisilicon: Remove orphan femac driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427931917.3612825.8235326287963165482.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:19 +0000
References: <20261104145038.946918-1-robh@kernel.org>
In-Reply-To: <20261104145038.946918-1-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: shenjian15@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, p.zabel@pengutronix.de, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Nov 2026 08:50:34 -0600 you wrote:
> Remove the HiSilicon femac driver as it is not used on any upstream SoC.
> The hi3516cv300 only has clock, pwm, and this driver.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/net/hisilicon-femac-mdio.txt     |  22 -
>  .../bindings/net/hisilicon-femac.txt          |  41 -
>  drivers/net/ethernet/hisilicon/Kconfig        |  12 -
>  drivers/net/ethernet/hisilicon/Makefile       |   1 -
>  drivers/net/ethernet/hisilicon/hisi_femac.c   | 976 ------------------
>  drivers/net/mdio/Kconfig                      |   7 -
>  drivers/net/mdio/Makefile                     |   1 -
>  drivers/net/mdio/mdio-hisi-femac.c            | 150 ---
>  8 files changed, 1210 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-femac-mdio.txt
>  delete mode 100644 Documentation/devicetree/bindings/net/hisilicon-femac.txt
>  delete mode 100644 drivers/net/ethernet/hisilicon/hisi_femac.c
>  delete mode 100644 drivers/net/mdio/mdio-hisi-femac.c

Here is the summary with links:
  - [net-next] net: hisilicon: Remove orphan femac driver
    https://git.kernel.org/netdev/net-next/c/10830cb24e91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


