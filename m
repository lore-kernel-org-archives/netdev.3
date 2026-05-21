Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E136A34C
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375012; cv=none; b=GK7zNbHjoR6YPfY3iYfXvmlXFosxo5p4226zTppMb6e0gtOpajtahpPt/3zfji21sVjpVNBgAMM0pfa93UT2ZPI1iMJMsNiBE9FY8GkMnX0pyjeyYOf02Aqmng2mTWC4mlSObR6sps3Yjb1r1ztvK1E4vTNNnNGGRaiO5mhrOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375012; c=relaxed/simple;
	bh=J7sSUOQ5jVAGXYEFYbIGASkzgsFfErIhH3tj4wfyPro=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f9Tl6PGpKsT5iWySBD0d+NzcwU+n8Bm0QTatUpgh3yLRpUynnuSRzHV3jC+V/jAHYVOfqXJFTTz5MIKtJaLCSCb+/0WXg/Uf9iCtQpLyXb5MUnx1WuVFNqdUyR7dJsL3VyC99ba1RaBbga/X9r1kGjw1dbsQaNEy5+y8g3YXnYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMB7bH7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMB7bH7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AED21F000E9;
	Thu, 21 May 2026 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375010;
	bh=A/uqv7fWn2b6IIbw615o4WV6MrOHRwgo4SQSpIBmpkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FMB7bH7UyNvBeQuR8ylZQ29Ot060jfK4G2uXx8QxsRgnb1eqHjhSPqdQSeZou3HzX
	 5IvPJoe/n8yq7YI4dYosCOdCEW1xZymeSBLmesIGnRTx/edaN0sMgIoX3zte2bxucw
	 GVrzypwHDOo0qL+60pO0PnC8lFXSsKythgqLXdoSVueRHCz6uPXc8/cqXytVQTrNxU
	 /8yD/tY+7gcanu1yiSHm4ZZMyH4sYeZHDGgqEluq6Dqg7SfLdGgIliUTphoXStemAL
	 gXSSpHf/6i72ap0h4aC4Fur2xcHeI3zv//F44/uJboxskv7k9JYcrmorR28eg4Oo3q
	 jHChV6nQ+OPsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938453930DF1;
	Thu, 21 May 2026 14:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: add missing entry for Bluetooth include
 files
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937502022.361786.2944807789509694535.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 14:50:20 +0000
References: <20260521004151.625049-1-kuba@kernel.org>
In-Reply-To: <20260521004151.625049-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 17:41:51 -0700 you wrote:
> We X-out net/bluetooth/ from "NETWORKING [GENERAL]" so that only
> the dedicated list is CCed on patches, and networking gets them
> once already processed by Luiz. We missed include/net/bluetooth.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] MAINTAINERS: add missing entry for Bluetooth include files
    https://git.kernel.org/netdev/net/c/099258bde1c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


