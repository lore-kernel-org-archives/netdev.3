Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226433A9FC;
	Tue, 21 Jul 2026 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784668846; cv=none; b=KKaRhb91YJdrxegmbeoukWSPr4q+DoFTEICSz4DjEtv8Z/DJYbCcXGpJmn6V4EO2VGa9tXDkU1IJAXOdXY9XOE+bLeYfG4ngM3xSPp072j/O35CHORD9vpvJFoZ7rdiBYJVQMM1B0wrHVVrR9X2ci4neUj79JKs4BU1i9bf3dwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784668846; c=relaxed/simple;
	bh=smE4qOOCGoFwwWd0fvXnqGbal1Z82e3NclLHNpXj5f8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CpUy4gAsuOi840ddu/JrC1Yf398tY8kYiO/cWZVfsh+J6hyDB1m32FO0uSnGZNQ6MYwAaiOCWvVuCStHYZ5uA4mM7toGgl0qdq6cY4PAAmYifvclnwEVNQqKgyzToQzjkmr0SlTAiXUssG8mTDh90IeNcVMMNklJyy1Z0cwCrY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvs/pHQ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvs/pHQ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB61E1F00A3A;
	Tue, 21 Jul 2026 21:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784668844;
	bh=AlJsW/LovYy0/4Z7ktKkxw97wKetdJa1YYeCQG8OCTw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mvs/pHQ5rcjLwn2AntJcicfVTqWtR6/zvXbph6+f6Q2nOaT957eUVMZmJcuXC09Ty
	 /OLoJtJp7oiPCuoNKhzoZMGmF75t18XIekS8cBettj5ChsntfBosq5GH5PWeogBYxN
	 8kSZGsKl2VwGj+PUhoBR5h6UGXWQCRE6ilvGbKf5dTCi5C9zLwt8fId2DkMM6qxkxy
	 vYXI/ZOoLUryKXgKQotquqoouTD/qat29Z2W8wjsuSl+wW+Ea7hD2RlEeLHL0QaYzB
	 SVsK+4dtWOpKFDHrAKNYAYt3l+gL+C/FgnHfZipzWfeaPZlKYzHQd6w4by/q7TZ4hs
	 TJVYmniKF2YSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5694E380820D;
	Tue, 21 Jul 2026 21:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: add quirk for HORACO copper SFP+
 module
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466881388.1074610.16003052961180452719.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 21:20:13 +0000
References: <20260719100158.874882-1-olek2@wp.pl>
In-Reply-To: <20260719100158.874882-1-olek2@wp.pl>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 19 Jul 2026 12:01:55 +0200 you wrote:
> Add quirk for a copper SFP+ module that identifies itself as "OEM"
> "HC-10GE-113C". It uses RollBall protocol to talk to the PHY.
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/net/phy/sfp.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [net-next] net: sfp: add quirk for HORACO copper SFP+ module
    https://git.kernel.org/netdev/net-next/c/1bb028baab54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


