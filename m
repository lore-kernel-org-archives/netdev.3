Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528210;
	b=N2RFvI/7hKdDidR4m74mQqAo2mXnnde4UHz4AQLZRUAe0dzU8mNZK9nPaKo+1SgyF4fW
	 Zf3TztdFeu+IuRUt7XPr2tDXqy7EAy9jNFyAGAL6SpDEmnRlLk6YF8InjTUAuDtryfL5I
	 at0tb4uhcfaS9KCdgt+uObTOMv0+5t9w+lKNWeuk8bcx7ttFAgrQHszs6B96wWytZoEHz
	 PQ5x9955MxnU3EfYyslgUe7YEnetl8khBduu9btVZuW8qJqx0RGWNCMKFUVYMbUxyeXKw
	 sIS8CC7m1Ba09/Fu1FNkTKBVUMvfwes25FVyKic9gbTtMIhS4RLf+zjWMljOYCchihg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528210;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+8Ej5p2dNozhwC71dJVOItIAbDuu7qLJiEwhEjUT5Ns=;
	b=WM0i5RaCOqXteJYiU4I+uWuPiNBB/EGKbFbbo2KEjuf0Yuwxa1YxOSgrCdbqRnYi3SgX
	 xavy7ws10lztMY/oRL3W62FcuaBTbf+CqD6RQL59xiYw4RQCvHTYP81cDFvbwX11yQ0rg
	 hWht7BOfEtYVB63wpcxaoLkwc1+6+eWr3OxL3jjQz73yB16o3drALIDnHrjRLXjzR/oBO
	 fm5t1ticy7UDph3T4+VSAczc5pDARxEq/zLX5fr5nXxjrI+4SnD2+bt+KAGARnYNTDnzD
	 DeepD+Hl1uklskF9JX+CK8Tigs3mN+hQMOYwPTfWucqOs1AOHwNXPK7NjrtVuEuglOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hnp83qCJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F14606A325
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hnp83qCJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3281F000CA;
	Tue, 20 Oct 2026 20:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792528209;
	bh=+8Ej5p2dNozhwC71dJVOItIAbDuu7qLJiEwhEjUT5Ns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Hnp83qCJAKNsjBbkVUYoUIWJNtonDqkU6Pfcyj74R8M4+pxDzCVq3xDyVMSjRfjna
	 JRCaN29GZnZsFPtoNMCNCKc1GoHXUVbvCRNgyOnuMA7kC/CqDRShk8Zl7t3MAnt1Cy
	 KHh6ClyHIpN46R9dQwLwnE/AMx8js/LhLqjz4L6v7edJLEgRcPD8AhgpIBrCB41h/C
	 z/zQz8Aq4FMVCy+5TJ2KvaRMexlNYapvpj+uzKH2RpZnwDCRP1UYkbnLOlmprpdvdT
	 2eq1heF8dgYmSbD8z2WNvoa1ColJVrQrhgBfzKTw3oPobHdEw/2cvfEbVH73JECOgb
	 Lbv4j5nK3yh+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B436F3809A09;
	Tue, 20 Oct 2026 20:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] fm10k: use skb_put_padto()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252820843.194567.9400214981730998248.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 20:30:08 +0000
References: <20261016094312.2759956-1-edumazet@kernel.org>
In-Reply-To: <20261016094312.2759956-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Oct 2026 11:43:12 +0200 you wrote:
> Replace the open-coded skb_pad() + __skb_put() sequence
> in fm10k_xmit_frame() with skb_put_padto().
> 
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net-next] fm10k: use skb_put_padto()
    https://git.kernel.org/netdev/net-next/c/8754a53984e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


