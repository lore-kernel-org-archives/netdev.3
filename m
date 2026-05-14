Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC7730DD1F;
	Thu, 14 May 2026 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778721071; cv=none; b=XGUFXPOpcD03hW2rVnzpl90le9wKzdN3HclaYTDWJSTDzdrSCZJz+gBGp3jdYq7W3W9TW/DgwcKKjtD3HLEt4Azjy7+xyLkatpB7o0fMJ+PQRkx1Ejw04VE2oje8yfdY/idxAovlVAQ0hYvHIxCjYP0E/SukzFhJDSpy+zQfszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778721071; c=relaxed/simple;
	bh=1eOLRBzDmXFgzQrpfhA2gsRvGYQBlWELJe43PrlMdsk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hh6kEO8d/w1QMJTI3SJXBgCz4XUnQt49yJ8jXhi8Z3QeelDRLWvPYukutUsAAEBq4skFAYJe2w/klHmgWFiThIdS2OzHGtDXSpLCtBsHkGmm8JFSyRgWoWUDnsIYLwIaodOZ5R40zn5LlEqMfpRl3MxXwzTskYkXKEgMc/SZPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC4zXcg9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC4zXcg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28258C19425;
	Thu, 14 May 2026 01:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778721071;
	bh=1eOLRBzDmXFgzQrpfhA2gsRvGYQBlWELJe43PrlMdsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mC4zXcg9ZXWMcrc6oHEZDoT61aJDJDYLVmaDaz4BkoRqoPccjgVEweyvFTPUClLSI
	 dWqdKgKEoQ881+/MIEQ4hu5+1wShxQ9wG0VZrR9t1dqqjIW1DI60L9Oz+AjbB2TdAD
	 Q5KU0b6xAL+3+fYUXEH6wGmUbgG8Ac+S5RnU3RGAn0+MyEhYCBvbmj81iqQoFpSg3Q
	 8avhLUyzYfpFig57nsBZg86l/lC5ok0WZJfpaBwQR+z5pV+2tRD7Pr+2FEQU3v6T/U
	 hwxh+CzZubf0k6C88xxOWCFgYEBEZOFeDw/vuPGIMvBAcR8Uq09a9qKUDSv/5BN1TG
	 Fq4IKLH9fNcFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD8A393088E;
	Thu, 14 May 2026 01:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: usb: pegasus: replace simple_strtoul
 with
 kstrtouint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177872101604.3905490.7145336659582238795.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 01:10:16 +0000
References: <20260509095518.2640-1-sajal2005gupta@gmail.com>
In-Reply-To: <20260509095518.2640-1-sajal2005gupta@gmail.com>
To: Sajal Gupta <sajal2005gupta@gmail.com>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  9 May 2026 15:21:48 +0530 you wrote:
> simple_strtoul() is deprecated as it has no error checking. Replace it
> with kstrtouint() which returns an error code on invalid input, and add
> appropriate error handling.
> 
> Also add a NULL check before parsing flags, since strsep() can set id
> to NULL if the input has fewer tokens than expected.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: usb: pegasus: replace simple_strtoul with kstrtouint
    https://git.kernel.org/netdev/net-next/c/1f8fd0fe5641

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


