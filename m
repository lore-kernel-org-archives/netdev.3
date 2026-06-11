Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E38382F26
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781219421; cv=none; b=jA7CjX4uwdJYUSMJX1kWltOr5h1CFRSvoYpLQAwUc+w33O960NZtR4jPE237uPimqLplUvperd01duBCBLN7hGMt5BQOEwkZ7IRKT802kkiqZWp9TnQetlSUL3E007gvKxuLWqFWY0kTEYtzRoJNZlsTBeEC8MVhimCXkL29RjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781219421; c=relaxed/simple;
	bh=i3Aq2PcwudkxP5r08quAA0h+qjzrsRSy/PdbSZaaPF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bAxkb8k5XxzKFXoqrNtCYgM1eqpxyVxB8/2pi2FmuJ2lmHrx/AjzHtNBoHvI9nluyveouD82/qTUohIS/xZHkUQ5p4sX/uEfdBK+feXCZQDt4iy+Z0g9OjNDnEAVXT8cwRP02XzY7XgUxvNF+cM9fFK1HNkUXIbZVpeQnZVC5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yx6XtJEB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yx6XtJEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB461F000E9;
	Thu, 11 Jun 2026 23:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781219419;
	bh=lHWbvWBXo6R1Y5mCluv+7BrQuPrDe+GNhFCSz7RUlBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Yx6XtJEB2cfqU8yXrv58PyS2qBlGNOiiLiXQ5bu7EFZqcVAhY94sadaBoG2iStm6I
	 SpntSxesJy9xNHt/0F+F2JZwJj/hQ3X1lNIqubk5VV5XulUykAkJaCtqSe5qVjVnTg
	 kNaeLsx1VhO6tw3o8vT5/ZQ08C6HSa6u8DpYusKo1yKRHacibXsbkYXyYY0r8wBe50
	 dLgW8K/+8WWkL8gYQZtra9KS9D29/j5F29rID07V5sYUOuQRnw0sSA2GjnABRR8Ahx
	 +YPy1B0lvTb7c3F/0/KFhQAFNev4yG9XtCnafFOyG1b7DaIpC1zmZ3JvKflYW4TIiq
	 YpLEBxPh1BXqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198D03930FB3;
	Thu, 11 Jun 2026 23:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: airoha: simplify WAN device check in
 airoha_dev_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121941663.401113.5124460643582532071.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 23:10:16 +0000
References: 
 <20260610-airoha-eth-simplify-dev-init-v2-1-8f244e69b0d4@kernel.org>
In-Reply-To: 
 <20260610-airoha-eth-simplify-dev-init-v2-1-8f244e69b0d4@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 15:25:13 +0200 you wrote:
> airoha_register_gdm_devices() iterates eth->ports[] in order, so GDM2's
> netdev is always registered before GDM3/GDM4. This means the explicit
> check for eth->ports[1] && eth->ports[1]->devs[0] is a redundant
> special-case of what airoha_get_wan_gdm_dev() already covers, since
> GDM2 is always marked as WAN during its own ndo_init.
> Remove the redundant check and rely solely on airoha_get_wan_gdm_dev()
> which handles both the GDM2-present and GDM2-absent cases.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: airoha: simplify WAN device check in airoha_dev_init()
    https://git.kernel.org/netdev/net-next/c/9912dfa2d46a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


