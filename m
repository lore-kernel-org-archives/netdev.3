Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AE9387359;
	Thu, 26 Feb 2026 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075410; cv=none; b=qQQOWmaMf9MkAdOeyzgGcz2Hdwod0zqLbtHsoEDiXce7vd6CSUQl/hCdKS6tr7CyQQMtTm4OX4Tj6sdt6jnqCV7DgN4qX/EyD+CkjPuMHlMm0+UhvwEV9F3hNmPsoHm/Aqte6vBWxnICv/s2dZSi/91ox81Nre06M6YaDIBGV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075410; c=relaxed/simple;
	bh=K7EXhGqT7SCdlQyqj7v1GAYDKgslyWgfrt0kL0qbeJo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=brvntZ2+id/vCi3XMGzUi+lP997bwnDbr2sxBQ4xuWO5wsEEGLeK3mP5Y1es8jRvzPoAcJeW4wmVNbUmjBoqEJgcKaGwNThgTrOpn8bI304hg72AjapsSKC7RCzp032YpjN04nAAy8s07BfNf90YBBof8vVE1t1SXbYxwXIuhYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l85xCG7X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l85xCG7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11275C116D0;
	Thu, 26 Feb 2026 03:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772075410;
	bh=K7EXhGqT7SCdlQyqj7v1GAYDKgslyWgfrt0kL0qbeJo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l85xCG7X6cVMCTbJJjvVUTLqlsR6HQmE0tWcC1/gSg6u59LTLBonVqO/1lgVOWAXA
	 BhxDQkvw0jYmenOPLdk2wdiJVeuQBDlRQbL912BbM+ny55Z1d3mejgkiBifMWoEFEm
	 mVL9VpQPfpH8FIRSNfieAwEnIV08hf9HntARzU3To34d1Aczjk/SDgfawktf7ICAS7
	 DiW7p124xHk4oFw2QtNaG3NV+a9ervAMhFqveN2DCbXIX+McqP26VCG8WGsLDs5e3t
	 2wk0Sj34UcFy8PjLIeoK8fG/g6KKobIN3HZLUaBc4UmPP0SDEws5Baj9vEybH1mpZV
	 aG+JOvGR6yw7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C0F380A94B;
	Thu, 26 Feb 2026 03:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: kalmia: validate USB endpoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207541464.1014739.791811311071521344.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:10:14 +0000
References: <2026022326-shack-headstone-ef6f@gregkh>
In-Reply-To: <2026022326-shack-headstone-ef6f@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 13:59:26 +0100 you wrote:
> The kalmia driver should validate that the device it is probing has the
> proper number and types of USB endpoints it is expecting before it binds
> to it.  If a malicious device were to not have the same urbs the driver
> will crash later on when it blindly accesses these endpoints.
> 
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [...]

Here is the summary with links:
  - net: usb: kalmia: validate USB endpoints
    https://git.kernel.org/netdev/net/c/c58b6c29a4c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


