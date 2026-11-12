Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477606;
	b=kGQG23ZM4ItB+z2vxjCFYp8fDeA/2wifPbtWvYCeRxeFF1XMil6iBO2YkkpKSofAP04K
	 aPfv3Vuj/9t1cJhHe1uK7uSZ82NzTB2/1AN11kfhijkQSyAlD/atDbyMThaANxi1lONTL
	 jan46FPMbjQ9aOtr8wVMNOnCfTkT8QRnXgfD1DN4/T13YR2xZ5fzQDP6fWxyUS54qR+K1
	 yOuve9t9BSTVll3An3dXXE93JBkgiKSHCDHwcDl23gxKePLK7YCTOUqIJyl97H02ZdGI/
	 CUGKulEBI1VTRdyIuBvQDWYJKNbXcpa3J6J1T4Q8b635AkZMp3YfpHHopq8sTMd5ssg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=fGRlGGYybYZD5rUwhWpmwOKxGOAAu67qlqBSQsnLu5k=;
	b=yf0gYDo7mA8Ks9pZ78/pwWYe0dnJot77BaJDGfqzmwiv80CZQKGB/rOCxx0sNgDqrMV6
	 bK5crwgUK+3XwvmtkXawsD84/I9CtbC17H1jiDlPc8H/Kxnw6DUQrSZg1ppbdwulwoX7l
	 tGlg3kpfCk0Cb4EHwy4tj3RZvO8csqamUh38/6G7r3F/+WiPLtnqJ8M0+W5BQwiqGjZZB
	 Og1dj1CuAKxWzp5Rp7S/rK39xGDS2axqwoO0SctfvdjSKJDkdvAry2IPGt7BqL2X3NQUK
	 etkg9vrF8inZieBH+WsTDwv7q9m/R4zM1nv/WQ78U6TnQCvq56icUhOct7ndZI25epA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7MBROYK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5D606A331;
	Thu, 12 Nov 2026 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7MBROYK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3BB1F00A05;
	Thu, 12 Nov 2026 10:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794477605;
	bh=fGRlGGYybYZD5rUwhWpmwOKxGOAAu67qlqBSQsnLu5k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=G7MBROYKXgvSMmoShTZ1C6Pn102zMF34faIzzJPrmZjjaV6GEO8yMQYLDcwHNJ8zk
	 GUI7nFdNn9dTFJ2R5IZgiZyM/nvSlRqisy2tBUGmZdZeYdsUkpqSvhi4joPSeTJiFr
	 oe0RFvMkSm7BOu8goZBP8p5atkubU7y/w1jRNTQAS8uvSLb5IzaclVDtCFqXGwZKsM
	 qivRlRUkldSRPc07QV0UoBDf3Ah7pvyg96iPXLZPcmBEKH67PgiIfJcOOaTwr4GOxI
	 zS4yLfd+sqDNVmMIFxLPsUdniwK9DfS1YQYSyJVdmRn7YUJpOPT3RXNfgZdFk4i/g+
	 lVRV6Iedo82GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B16F3AA9A95;
	Thu, 12 Nov 2026 10:00:05 +0000 (UTC)
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
Subject: Re: [PATCH net-next] dt-bindings: net: Convert HiSilicon GMAC v1/2 to
 DT
 schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179447760442.1983710.9367740045427311229.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 10:00:04 +0000
References: <20261109191641.653847-3-robh@kernel.org>
In-Reply-To: <20261109191641.653847-3-robh@kernel.org>
To: Rob Herring (Arm) <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 shenjian15@huawei.com, shaojijie@huawei.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, f.fainelli@gmail.com, andrew@lunn.ch,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  9 Nov 2026 13:16:41 -0600 you wrote:
> Convert the HiSilicon GMAC v1/2 binding to DT schema format.
> 
> As this binding also contains the MDIO bus directly rather than in an
> 'mdio' child node, the MDIO node name schema needs to be relaxed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: Convert HiSilicon GMAC v1/2 to DT schema
    https://git.kernel.org/netdev/net-next/c/556e0ac6a771

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


