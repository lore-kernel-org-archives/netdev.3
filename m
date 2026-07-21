Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFAF4343E7;
	Tue, 21 Jul 2026 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620237; cv=none; b=eH6JbaYXhHJWcRaFVFtG3M0cnakJDGV3mCfPqfAg7T9lTc71fQTJLz+4rdn+EiL1xN+OyjqlEo3fs8hWH/HTkKk/XGXzS2ONE5MblM+KlIxifFOPBK504c30DWWkYdzjebrLmL7I0MHHShpmL347HEjBnje/yTbRhoRgtODR5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620237; c=relaxed/simple;
	bh=qYeUXPhCIrNtCSqEC9lsCooo4ozPQ1d9Bq8ODS/bMdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T8kQOYRX1csTfHv+FmRyAO8n0m4BGeBiwVAx56qf2BgpJ5JGPSDu5pE8QjEVjNNz/4HsPhthdtcxenRgPlfWdxFiJzFXSSWLnqhUpwD5k4Qc6gJyHz3QoD81phhd7zVDvKU9m66FSZ9936G9OK0+aBo2nGMFoak4ncP+6Zs7L1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oh0FPs+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oh0FPs+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F901F000E9;
	Tue, 21 Jul 2026 07:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784620236;
	bh=U7pmL1JiCQuKcTU9dY6vrebiTYaqi3TIxs//E0Ypwtc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Oh0FPs+FTlYST2EQ72ESSOHdE2ntqhwRfq/XQSw70OssMZE62IQl7xFQwLD271Ehp
	 z7ibL7COJwD08Ai+Q0G2cBJZlcj3gk7KXdlGyQ+vZ0nQy7YR6SS0Xqfhpam7+/GI2B
	 5uHACu5/47GrhzTEkDlkJDyylniDm7CzcL+MaKxDpcEaI1lB5sjIwn/H+z9YrpkX71
	 31TXn+rSX0vEmE66z9tSdpl7yfhTKZd0q+r16sarWiejQVH6krpUlbxpTSpznXyQQs
	 qH+UeY4SIwauJ1FewfBa3BB5mYla601RwVUp1J/AwNKj1kTklPHPe7QE+PSTrFbjOC
	 5wogdagyX8gjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568FD3924A28;
	Tue, 21 Jul 2026 07:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] net: airoha: fix MIB stats collection to be
 lossless
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462020592.138517.6199339592479066921.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 07:50:05 +0000
References: <20260707152639.105628-1-aniket.negi03@gmail.com>
In-Reply-To: <20260707152639.105628-1-aniket.negi03@gmail.com>
To: Aniket Negi <aniket.negi03@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, aniket.negi@airoha.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ansuelsmth@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jul 2026 20:56:39 +0530 you wrote:
> REG_FE_GDM_MIB_CLEAR after every read creates a race window where
> packets arriving between read and clear are lost from statistics.
> 
> Switch to a delta-based approach instead:
> 
> - 64-bit H+L registers (ok pkts/bytes, E64..L1023): read absolute
>   hardware total directly into a local variable; clamp with max(new, old)
>   to prevent torn-read regression when the counter carries between the
>   two reads.
> 
> [...]

Here is the summary with links:
  - [net,v5] net: airoha: fix MIB stats collection to be lossless
    https://git.kernel.org/netdev/net/c/d163725af84a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


