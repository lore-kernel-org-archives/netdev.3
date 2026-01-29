Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45F35B656
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769658636; cv=none; b=D5pvaFECZwFfpZIMpYrtEemqR55r/baEihQYABLZ2u6xxYWvKkbxXabMwXIQwP8lEO/ucrZABrVGGc9LW2DiCGmTCvtzpkzm/AA/dDxmUjZxyRFXNiWtD1X3yhyaAmCbTpr68pnwvCKqiHgehOxNc0XPgqO3FMrtEPEA3sWVppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769658636; c=relaxed/simple;
	bh=PHpE/0Hn7qr2bM8jKHBafvhR9B69eVixSVqp569e2MQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=afhHbmfq6qKpfuklh2x+Z2juU5Gd93vaIAkTjvcRXgRaim2wy3ENJ/DaEpj3Dmt8qyRdMZLE07YQhjmfTWgJ/iFn/n1Uqk4JtX6tuBQJOUPoPXw0aEIon0kYluXqy+JA+datY9zW+ZrdwpaRCHbzzy+yObc1JILEBYzHCBqjxZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FopApdzw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FopApdzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B912C19421;
	Thu, 29 Jan 2026 03:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769658634;
	bh=PHpE/0Hn7qr2bM8jKHBafvhR9B69eVixSVqp569e2MQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FopApdzwpo75MuctKmwMAplM07jqB8YTBBj+VKy7Sz2TkBCzOQm8ScM31xlCOK84Q
	 s2X9M46rWVdY2NNbELdKg1KGyuvtLwIYyMZTjFQtgNmlVm3aI/HqKz46iZDRuGej85
	 5GPH3jZJiPEwpgXqt2OYlrKgkKnSsocoUVPTwtqnBTx0Slusz94DbA6povsi7n/e/D
	 AntlRrNWpEehe/kyzH3SaJnucCRlSTaazT00iEMaHn/cH2KXaKiD2naE2Cds0OaAVY
	 PRcbK/tmnZC9Mkzpk2rx19EXiKZeL8Bd/ktQl58LaCH04TahdCLQi2lPnZvVvHbysI
	 bdVmeyF0No9qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BC4E380AA61;
	Thu, 29 Jan 2026 03:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests: drv-net: toeplitz: accept bigger rss
 keys
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176965862710.2339773.12430640446680159044.git-patchwork-notify@kernel.org>
Date: Thu, 29 Jan 2026 03:50:27 +0000
References: <20260127174806.886561-1-edumazet@google.com>
In-Reply-To: <20260127174806.886561-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Jan 2026 17:48:06 +0000 you wrote:
> /proc/sys/net/core/netdev_rss_key got bigger (256 bytes instead of 52)
> 
> Fixes: 37b0ea8fef56 ("net: expand NETDEV_RSS_KEY_LEN to 256 bytes")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  tools/testing/selftests/drivers/net/hw/toeplitz.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] selftests: drv-net: toeplitz: accept bigger rss keys
    https://git.kernel.org/netdev/net-next/c/5fc90003de59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


