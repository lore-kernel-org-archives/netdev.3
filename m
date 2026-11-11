Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386407;
	b=dM4/9yfDKwd5U0ekxGbUDI150IEUno50+Rg+BfghNgQOjf28qDqcDLWFTMc+FFUz53UK
	 ZFGT2I/wSyg0iuVzXV8SGjdkoEr/1mHfNgk9xad+qjRRP4sJUVLA1OzCCpudNoY5n7DRj
	 mP6MHOJ1V53eV24oNrEkuXv9DkT4EWzznqomy0VkstXOU/rSXFxF1qQA5p8+taqDf5UsP
	 9sYS4cpHUHpzAutSm3vsXJWMPPQDsJsl8m3Une4nLtszhBavY2b+CGcjAZ3mjyFa4CLpS
	 v6rSFMlNl+/kHGwyKQ55ncWTo71pcTrG7cafpU1SsXBTZ8QhHolgYXsRctasusSSFYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ExDVWijlDii6IKHmwPi4pgSXddbMzGH+ApjyDrW/l+s=;
	b=zw4DcM0igRsKkwSVMvirAyM39eFx/AJOq/kyQn4WQ1SPM/EDayr1bb/CU+D2jzP9RPB7
	 z3L25IqbtD6sFx3ovX4XAxbRXlwBzTLeturftNQc2fXTNDkbRmn/FacNjcW/N6cIU/Vs/
	 uBWcvJHTwTzSgG1vOjI8h27iRBLVDLDVumYr72eeo8mZO+Dpnej/leWZWNAZtCaYzB/Rw
	 Oiyyiv8ur/B8TYnr6V/dCxfdUpm7Jhsk/75fMP1b5catpb2M6ULakd1goLcxXPbioQ1rU
	 KSVomwbDjvgTNoyOYakroc0bSly91Ke9bbc017Rb/TXqVex15t4FARUxtxuBQihmFhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRquJ+dq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0E8606A31C;
	Wed, 11 Nov 2026 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRquJ+dq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BB91F00A06;
	Wed, 11 Nov 2026 08:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794386407;
	bh=ExDVWijlDii6IKHmwPi4pgSXddbMzGH+ApjyDrW/l+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YRquJ+dqvO+ql9V7Lw0rD4ih0Q2gbZ0yeWPt35fIe3RMm8BWLG2T9FpDKKtOIpgmY
	 Y/TIz23BWm9pMI+8fh/0R8wHyA+asum6WEw13YSnGaDg/yahf6uIRZ8mPZg8ILaOXQ
	 W8GO92eMM3J1XWypMZgj+GyPXE+HsAZkeNSn3UnjAH1pdzWpXyLm/VhmgZnEq4OSYM
	 8Ox4GeKsqVR67Tz5GgW46n0tdmTSfygJCrZ+NgEC5jAo0AUbn+zBjVh2phiAI+pLDq
	 HPgsmKK1Y5KhIc/F4I43ZZ6dWuijyu4e53D6q+0sEq6dwrWckoBZjExmOiaATo9mSe
	 vcYf4D7naP1GQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E17938007E9;
	Wed, 11 Nov 2026 08:40:07 +0000 (UTC)
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
Subject: Re: [PATCH net-next] liquidio: enlarge the interrupt name buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179438640618.794109.4972687983974562949.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 08:40:06 +0000
References: <20261106095114.3564335-1-xujiahao@cmss.chinamobile.com>
In-Reply-To: <20261106095114.3564335-1-xujiahao@cmss.chinamobile.com>
To: Jiahao Xu <xujiahao@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Fri,  6 Nov 2026 17:51:14 +0800 you wrote:
> The PF and VF interrupt names are assembled as "LiquidIO%u-pf%u-rxtx-%u"
> and "LiquidIO%u-vf%u-rxtx-%u" into INTRNAMSIZ (32-byte) slots.  Three
> full-range %u do not fit, which gcc reports in a W=1 build:
> 
>   drivers/net/ethernet/cavium/liquidio/lio_core.c:1119:76: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size between 0 and 13 [-Wformat-truncation=]
>   drivers/net/ethernet/cavium/liquidio/lio_core.c:1124:76: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size between 0 and 13 [-Wformat-truncation=]
> 
> [...]

Here is the summary with links:
  - [net-next] liquidio: enlarge the interrupt name buffer
    https://git.kernel.org/netdev/net-next/c/1be1e065008d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


