Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0000A448B90
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241812; cv=none; b=PNsVLbAtchPu17TaGbZQ5WDChrO2BY7YK+VR1HUUY3z4CPulR4bLd2qTHnJS161s6LOlqtnIwMTkiGyVGV9JPuYxo+7JfdYeLHFor35GIHNdKF6Zyi2r8jGzah/V9bjk2HW/liEgNSQ2efFpEGAGpeslfzBOqLD9POhR0xy7Sbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241812; c=relaxed/simple;
	bh=2F1FLeYkndi/51uX2dZyf/yf6eE/Q/rWL6wxPLGlk+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LfQz35+QDso5UPYRqIg1uuWHUJbN7aPwQ4XWl+SPXqC7lD5EErITCixTrCOyODmm23uJzhn2xIBIPrOFHg1CjnQh8LdArauwLKmxfeVgvDKhrxyOMxIrkPotjU8ZYMMxIkbUvJj/wo67oOnhOoaYfhS46F+0+Mmu28Q/OIS9F1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub7PO8Ev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub7PO8Ev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D2D1F00893;
	Mon,  5 Oct 2026 23:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791241810;
	bh=xRURQssFTHK3X8+DUnDWTIwfEO0R4JcAamVCKfdMBDI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ub7PO8EvM1DlIvQ7QBiEsAWA/oGAyWHpTN165Ct0ZYklVg0AsfkWmfRuN0zI/Qix/
	 MD/b7ltogT60PWEItoH9pmZD97CxRyzSwNYti/LPTc64O4KtHIFidFK5+EECNVFVVt
	 7Jvg7gLapEa04yT/dFHi+ztRfvk6gT6rN/uLyZD2l7+/5jQ7qErryuFAg+iSU/b/xC
	 57Nti6ULPx/0QigaztGZ+/JrtotnQhPpmIKT59E2beIhmFXTVfrQSBy3n1EkveJl64
	 amRQzn3o1aN4K9+kjJTNsQDVSM7SQLRP+2rCLo06DdnDyV3rMFYg/Mop6IUcop+3SA
	 uoyb32Rvtrv0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774393926677;
	Mon,  5 Oct 2026 23:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] strparser: remove general mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124180902.1932101.6938951674802477526.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 23:10:09 +0000
References: <cover.1790702233.git.sd@queasysnail.net>
In-Reply-To: <cover.1790702233.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 09:57:24 +0200 you wrote:
> The "general mode" of strparser was introduced in 2017 by commit
> bbb03029a899 ("strparser: Generalize strparser") and has never been
> used. We can simplify the code a bit (remove a few indirections and
> NULL checks) by dropping this.
> 
> Sabrina Dubroca (5):
>   net: strparser: remove unused abort_parser/lock/unlock callbacks
>   net: strparser: remove strp->sk NULL checks
>   net: strparser: remove strp_process()
>   net: strparser: removed the aborted bit and aborts counter
>   docs: networking: strparser: remove general mode
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: strparser: remove unused abort_parser/lock/unlock callbacks
    https://git.kernel.org/netdev/net-next/c/ed0e5b924d8f
  - [net-next,2/5] net: strparser: remove strp->sk NULL checks
    https://git.kernel.org/netdev/net-next/c/05e37190ba07
  - [net-next,3/5] net: strparser: remove strp_process()
    https://git.kernel.org/netdev/net-next/c/b5e153a5c8ee
  - [net-next,4/5] net: strparser: removed the aborted bit and aborts counter
    https://git.kernel.org/netdev/net-next/c/02fd0a211137
  - [net-next,5/5] docs: networking: strparser: remove general mode
    https://git.kernel.org/netdev/net-next/c/5f193cdabf25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


