Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E83F1ABD;
	Thu, 23 Jul 2026 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812852; cv=none; b=RVoM+C/JfJt4Roch0gi0s+KFkANIWevFfW45osxMNKVYQql449F0ydmnz4Zgt1pUOeUBIg3ydetVZznZRFjEZU+unFNp7t5gHOn8Yn5N2WsXxD0pHQvKVvdDsdubkngDgf/a5FZximqxiIIKFq60Fob+PpqkLKlHHhZMKl0tqvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812852; c=relaxed/simple;
	bh=ZpZzI5NeNRdmggJ0HA0mpylXKj0OTPPtGv+F1UtzqjE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Edg++TJTweDb2xPAFlmPKi0+iJ3vHWOhoXAKZKdImF/s4kWdKYzjscobU1/pQGYXIJ+5H6+aQ8NaTaxz/5phXgyXcANVhiQSCDosNbggRI7VShlfTbM0h2DmggBP/2tukprx29xSytVuFwPsQPT/C0ZPCF2e7HR4vZIIjJtYBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGzs3lIg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGzs3lIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BC41F00A3A;
	Thu, 23 Jul 2026 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784812850;
	bh=zbCZ6G6cwtPCohn2UhvQPxnpmQt6zbzPBHGYmJoze4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SGzs3lIgqttav+TMpaG/uZlC/ZcJNIFP4GxmLUhcOw9CvkK0cTaTNxpIT7uui9abn
	 GtSpBQf+zZ00v9Wsq4WdUqskZljQrjkw4FH00KHppREtEU7k6rtLspdavV4ER/6y8N
	 Loqia2WRMCW3DAxJu4h15x12gXvCS2H040xIYa16VdzgQBnXdXZ02Pu9DBERDlA5Ru
	 X5C0TrS9QkQgWozdR9mUAygN7wzTCKSBdZ+PK+jucBiA9zL40xeaVLV9t2QFQIW8TV
	 b6E91N+T5HVik/uCu+abpFjHW1YT3r5quSDEI2ivzREIKfZjXGSoU4WaCJv4FzUcCR
	 YzGS5ZNTJgiMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569BF3810908;
	Thu, 23 Jul 2026 13:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: return VWQE timer delay in NIX HW
 info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178481280889.2242888.995489319414983165.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 13:20:08 +0000
References: <20260715073112.622662-1-nshettyj@marvell.com>
In-Reply-To: <20260715073112.622662-1-nshettyj@marvell.com>
To: Nitin Shetty J <nshettyj@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sthotton@marvell.com, sgoutham@marvell.com, rkannoth@marvell.com,
 gakula@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 15 Jul 2026 13:01:11 +0530 you wrote:
> From: Shijith Thotton <sthotton@marvell.com>
> 
> Update the NIX_GET_HW_INFO mailbox message to return the VWQE timer
> delay, which is used for vector packet wait time calculation.
> Repurpose the existing rsvs16 reserved field in struct nix_hw_info
> to vwqe_delay and populate it by reading the NIX_AF_VWQE_TIMER
> register (applicable for non-OTX2 silicon).
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: return VWQE timer delay in NIX HW info
    https://git.kernel.org/netdev/net-next/c/92f0217f8afd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


