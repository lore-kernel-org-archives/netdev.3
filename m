Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AD93B42F1;
	Mon, 15 Jun 2026 19:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553036; cv=none; b=RwsueROciueLGfb6f1eueSVV3/DM3az60cqUy1mbDflRGk74eR/W+PyCnEPwfqkeCTeiiUSeJ4qHWx68kvLWg2GGjTuK+hKKup1L0iBT2emennY1xHQbq1DVgoygvS7AYgarauFhO0bjBN+ZCq17RVbT3j7pxzB+Hi8kaxYZiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553036; c=relaxed/simple;
	bh=EUFDYhrFJESAeO8mrJmNZcwzqnKAa8kBWCA473BPdZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jeovjTpb4ggP7zExRCosmpeRrxYDTepsRyrjdJ/taPiYRnJ5zP2sf76gWyzjpYv8Y5A2XBEyuXmgdTuCv3L4MF4QcRBT/Ivu9g5u5UJUO7mJN/F5F1saKXGqhBhzvLekqI+2+9DiU//WhRxsNOmMF7K/86X+6BfvpsL7xCoEtNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKcXZZXV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKcXZZXV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084741F00A3A;
	Mon, 15 Jun 2026 19:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781553035;
	bh=Ywu36GF+JzT7opTbaIFg+FjRAJujNHtYpeGS/esxG68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kKcXZZXVk3SFxN41+tue3AjtTdQ33aKanaT8NIhs22f14XZNHP8kd+ZDPwocg4R+P
	 ZX48ITRVuqn0UBdyTBGssmyMJ9S6bVFmlI5I18HAdOJZgGQY7daJo2WRkyi4O6kIlw
	 qfnowwZLsPvrgfuvPst4aa0qKJ/lnB37Tt/9uW3S8Sx7E9nQt/JYqvfb3QisVGwXs1
	 4x6c208vwPKERl/BQGyStjZ04nxKyUjjnL+lJCLrHz/9V5kb8ozX/C8HOv+Rk/AzF4
	 QBhR6Cohb9hyd96OGe1xzAV6Z68hbwjumPwo7QWlZSi21jdYcbAtAdvFcTjiroHBjl
	 Inb06L0dubryg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569303839A06;
	Mon, 15 Jun 2026 19:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] devlink: Warn on resource ID collision
 with
 PARENT_TOP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155302988.269508.8987903722532704224.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 19:50:29 +0000
References: <20260611070856.889700-1-mmyangfl@gmail.com>
In-Reply-To: <20260611070856.889700-1-mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, florian.fainelli@broadcom.com,
 jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kurt@linutronix.de, jiri@resnulli.us, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 15:08:46 +0800 you wrote:
> Filter out the ambiguous case of
> 
> enum {
>     MY_RESOURCE_ID_A,  /* == DEVLINK_RESOURCE_ID_PARENT_TOP ! */
>     MY_RESOURCE_ID_B,
>     ...
> };
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: dsa: dsa_loop: avoid devlink resource IDs collision with PARENT_TOP
    https://git.kernel.org/netdev/net-next/c/b2772157e5ae
  - [net-next,v2,2/5] net: dsa: b53: avoid devlink resource IDs collision with PARENT_TOP
    https://git.kernel.org/netdev/net-next/c/89ccbd3fe837
  - [net-next,v2,3/5] net: dsa: hellcreek: avoid devlink resource IDs collision with PARENT_TOP
    https://git.kernel.org/netdev/net-next/c/31d2b61ba2cc
  - [net-next,v2,4/5] net: dsa: mv88e6xxx: Avoid devlink resource IDs collision with PARENT_TOP
    https://git.kernel.org/netdev/net-next/c/bfdf01f4d161
  - [net-next,v2,5/5] devlink: Warn on resource ID collision with PARENT_TOP
    https://git.kernel.org/netdev/net-next/c/f1e13d23e0c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


