Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101C137750;
	Fri,  2 Oct 2026 00:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901608; cv=none; b=eqfxLqdWdhsdioCIVGv4sZxzh80lSFkEO5XuJNFbf+uBALmwQV+n43zXoj0gi1Jqt6K31T6Rkub/KMoM3KLfF2pWp/VniCW2Fhtw5ADuPfeB6SchKvFT/F/gFqYzDk+ytGPia/JH1NAJdnSd3BC/3PVDa8Uv2CIOojy4nKu/pxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901608; c=relaxed/simple;
	bh=0ekIBW8cXtBHzyPtrEVcnXMEivMEdiRUJ013YSD4YCs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ATn24vCe5kIf9OUTd7+KK2BsAw/Df70EmdUl20VJ1N4fm5+Ao8Ev8AN8Swsnd9WxfC7Z4Xdmylw/szc/aVKtu2P93+8vfO4qGxzIKiAetv+h8cWielegECJASSj4xL0UGsc1dmdcsJrPloCdsP5oP2Z6OZPXiykMosQ3ZRhdARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htOsGYge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htOsGYge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0531D1F000FF;
	Fri,  2 Oct 2026 00:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790901607;
	bh=jG/ruHNFDhaAFn2D9qCeaPE1eylcCx8K4+rMYgQQJeI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=htOsGYge6VCjB4ltEXCJyk2RfVYiLnNhGn+u6MNqSmAcZxy9lbFWB2odLi2aXHFLI
	 s5C81E3TMSjN4aYdMegjXuXTA155/V8P0aHqtsLlpZdWjDiAoIbtizUYhkk9h6P1EI
	 DlJrf7QJkTTVe69t3PTF7EtKIl7WmeAE+c29tgQpbnBRs7b7Z4g9vTy34dpz7XdMqv
	 4yA5D8mk8JufaqfhqbHvi/LKbjEQrDagXXZ3tUxUubTvurJu0FFbsGip2Vyhkl+fdF
	 f3UTnc+B6ADxpahXgz1gbPYrBl7UcSWVYqSAvwbO3YexeMnL550Q8WxQX+nNuuKNdt
	 5/llbE7fMVmLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1470381197C;
	Fri,  2 Oct 2026 00:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] atlx: fix kernel-doc description for
 atlx_tx_timeout
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090160578.3158777.8002399891186703487.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 00:40:05 +0000
References: <20260929101714.51579-1-ayush37735@gmail.com>
In-Reply-To: <20260929101714.51579-1-ayush37735@gmail.com>
To: Ayush Yaduvanshi <ayush37735@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Sep 2026 15:47:13 +0530 you wrote:
> Add missing @txqueue parameter description to atlx_tx_timeout
> 
> to eliminate kernel-doc warning.
> 
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> ---
>  drivers/net/ethernet/atheros/atlx/atlx.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] atlx: fix kernel-doc description for atlx_tx_timeout
    https://git.kernel.org/netdev/net-next/c/29b635a5bb8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


