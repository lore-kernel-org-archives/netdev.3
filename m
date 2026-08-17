Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194843EAC75;
	Mon, 17 Aug 2026 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999860; cv=none; b=ERnSt4NSjUuHIkMvU08bLQOWGpojtsRTl8sAOmEt8k+R2bVjX+g8wc2fHXODfUYcGLa9QNzA/YuBmaEuMv82r+0xYLhQ59q6BIRQFQ1pBJ+yc9JqvfowrZ6GmcMK+/jvyor6Jg3lkmXTFs2J1UQmhzgKx4/7Em74Wx61KSk7BF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999860; c=relaxed/simple;
	bh=8163CUvTbwqb+wT62T+KBd1LsuAuEbBfjKlIK6uBUwE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t5A1OV1gaeY58brem3ZUyR4B4NG7MDdg5+X0DoBAlvNyAEsoWYqJPAbXID1sG/knQX9LuO2zkcS3iSXiirWeRSuaorcIk8zBDN/BdEH1M7MOTAReFvcSdldtNgltT5h9/zMIf3n6UxPVKwDin3tIWvztYlKM5+AjzxW/FGswuEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJuSTA1G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJuSTA1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B461F000E9;
	Mon, 17 Aug 2026 20:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786999858;
	bh=Z4bGUQm5gPA38BptgqGQJlpgeb5NbVanbJTmaji8B+I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NJuSTA1GP7H7EspackGcTRxhEGsLVCUASZcYYaHn6wWiYtGyeIn6M30qfpstmFsMJ
	 UfQJGU4QEChXfwRWVPmZkmQUINtDCp4Vl9Q9r2ASzb6AhYIe0VKAW4qw4v5ZaufJjy
	 Ho6l6O9QviBr0y2/Xgn0tyHFqEJpX0hBQWQM5rugACG7PdfeiS9pNcP3gFDu8uUUlG
	 ysmGbFGhzQUjqmnDOhPHwYIs0KkTgSFnB5XMLRRFXyDXzg4ZEYI9SR7TX9rm6Yy5Y1
	 SdIpssvQ9jf/JDCKsQdOrAsQ9Hopo52u8oA9FNO991JXuuYiDPYBuL4bJY/xUwguoo
	 3oHuGlr78JDJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198503926265;
	Mon, 17 Aug 2026 20:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2] MAINTAINERS: update entry for socfpga dwmac and
 gmii/sgmii
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699981063.1732278.16029098609531352169.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 20:50:10 +0000
References: <20260813005536.2068392-1-dinguyen@kernel.org>
In-Reply-To: <20260813005536.2068392-1-dinguyen@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 19:55:36 -0500 you wrote:
> Matthew Gerlach is no longer at Altera, so remove his entry as a
> maintainer for the SoCFPGA DWMAC ethernet glue layer and the GMII/SGMII
> dt-bindings files.
> 
> Maxime Chevallier has volunteered to maintain the dt-bindings YAML files
> as well.
> 
> [...]

Here is the summary with links:
  - [PATCHv2] MAINTAINERS: update entry for socfpga dwmac and gmii/sgmii
    https://git.kernel.org/netdev/net-next/c/bda1d74b41da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


