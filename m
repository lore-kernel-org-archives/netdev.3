Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD63A48ED;
	Sat, 13 Jun 2026 22:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388619; cv=none; b=afHfPCZ/ZZ+eMaEtsarQhOEJiTy+R+H3uLuiVzbCEY0FTDhbhK47c1SP5kZBfsakWGlzmZlrp41Url2dZrwTGb56UNojDZo8HMOERvQEeRXSKopkro1qbS2TBVOndhE4dWb3L6xPpboeYn6yhlXbb7zBJ8OwAMswOAU//gb9zY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388619; c=relaxed/simple;
	bh=E85k4s2TtfZJ8uSMubSORRlHeaWBtvuUkDF9LZe/R8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kwB2xFtJs8/ICsVzFk4vUSUyy7DSGRDUai798n3nF7bBXl0qWsqWh5C71wOjqHsxwPXtHx2NsNf3WsaIxBWrYrGPh5CtcrMRj5Lgf/RlLt8Nt3xTh5vm8+WgdeFdsS0dzoSOHljrSSKhPXKI2w/nwegcIIJKqwx9Iw+Dh5J/3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5SQahEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5SQahEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DCE81F000E9;
	Sat, 13 Jun 2026 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781388618;
	bh=LM9Ad9DH5AVeOwfb75LlD+HrRg8ZLl14zucjpK7Ngh4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=V5SQahEE7SpaRFg33BrGsZmK4ZhW7Vqp9SgPj+QXANrnwZThuEBIrtv45/2GeaGaN
	 KpqhYzFq38oQrrdRMuvCcFQcTWjHWGmBg8V+0kkWyCgeV/5/MAhuzLNioyUMqwVU5B
	 7+j+SwXbxTCkVlAoVOrwQeJL+tOwOzN7q3Dbgt3H021rR9SOZX4Ql40peKewV7YWWy
	 t5arrjS5YxcIaFWTIVMOXJc7ttQn9F7Y3CcFSwl2U9h5zTqgu6hsEHPPRm7X10lX+V
	 nWComYdNpHWCPRQQeVU/j/xobqsRmE4GQXj+Y3lEqDQGa6ywNnCm+tiy+sTfYRILNs
	 DKNp2/490w2xQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A463A54A32;
	Sat, 13 Jun 2026 22:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 1/1] dt-bindings: net: dsa: Convert
 lan9303.txt to
 yaml format
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178138861438.1607522.16348781028982190801.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 22:10:14 +0000
References: <20260610150533.515914-1-Frank.Li@oss.nxp.com>
In-Reply-To: <20260610150533.515914-1-Frank.Li@oss.nxp.com>
To: Frank Li <Frank.Li@oss.nxp.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, Frank.Li@nxp.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 11:05:30 -0400 you wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Convert lan9303.txt to yaml format to fix below CHECK_DTBS warnings:
> arch/arm/boot/dts/nxp/imx/imx53-kp-hsc.dtb: /soc/bus@50000000/i2c@53fec000/switch@a: failed to match any schema with compatible: ['smsc,lan9303-i2c']
> 
> Additional changes:
>   - rename switch-phy to switch in example.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/1] dt-bindings: net: dsa: Convert lan9303.txt to yaml format
    https://git.kernel.org/netdev/net-next/c/b693b51e0829

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


