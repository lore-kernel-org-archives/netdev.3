Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324862DCF45;
	Tue, 29 Sep 2026 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646018; cv=none; b=bXGJMbiGl7COiFovlrVgYQOtQRf1UqWyNa4oRF7qE0jpx5kwZkgb+GOdDKt+we4qhTejLuXvrV/p56e6BcU1i9qJOApXknM2WCyVBPSwFfmjs/koeZzx4k72/lF/2/VZ8H1W81BsUZPDP7iC3mu4WfsDACTz4SMedHkyD9blwdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646018; c=relaxed/simple;
	bh=N7o4phRruxZwI8gd9fsjgLJFIwC8FfeeRgBPuBxpZmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VyUvk7+YCJZoMxZt9/t2SMpMJt8MAo2OaRobaave+hwtmAggYTNdYX87EnMia49RYzXDAzJGzyNQczCllvJu+WxbTb8nTbCFhycBRFsb0UvfMnZ5gHYbbRKsEQ75CePUD6y5oHi6uvSe8g6V9rm6dCcgT/BN0hYTCKyJFhdBYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HP/tHkaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HP/tHkaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC08F1F000FF;
	Tue, 29 Sep 2026 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790646012;
	bh=/uX6Y2EEp7KvSdpNQYfg46B5hXLVJKLDCTXtENJKz1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HP/tHkaRqezgyQ63YUABMnQcuwwF6OvBU4aCj9pxydhxn24SFbL9ooqi6nO/KezBt
	 yrIcUyTb9XIZNZbBJ0BxKSsmCAxpOeoDPsdLeT/icwyOLt9XfOw/e6o+lYxGlVp6ar
	 28qW8YneAhULBcpTwhPleLbZCevgw886Uekk7mFsZAS/LnZ9hq1HswovC4GKldBnVL
	 IDIqy7Vkb2WkKgol/jPhRmEsxTrs5ZJbCGWYHVpF7vzok0gjX+0yh2SO93WdEOlLCH
	 55ZrcKZyfP8xJNwW5A5Le2MLiLIG+R1gGa97ugGy2cnIrw74On+ka1n1Ivf1dsUx0r
	 gRp9KTp3KfrTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44193924FED;
	Tue, 29 Sep 2026 01:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tipc: prevent GCM nonce reuse on peer key changes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179064601127.210624.12477364079034672571.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 01:40:11 +0000
References: <20260924202105.3722778-1-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260924202105.3722778-1-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?b?SsOpcsOpbXkgSmVhbiA8SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Sep 2026 20:21:05 +0000 you wrote:
> TIPC can encrypt traffic between nodes using a different transmit key
> for each node. In this mode, the AES-GCM nonce for a packet sent to a
> known peer consists of a 32-bit prefix (a per-key salt XOR the peer's
> address) followed by a 64-bit counter. That counter is stored in the
> peer's RX crypto object. When the peer reports a change in which key
> it uses to receive packets, TIPC resets this counter. The sender can
> still be using the same TX key and salt, so subsequent packets reuse
> earlier nonces. This nonce reuse breaks confidentiality and exposes
> GCM's authentication key. This makes forgeries trivial: an attacker
> can exploit CTR malleability to alter captured ciphertexts and use the
> recovered authentication key to compute a valid tag for the modified
> ciphertext, under the same key and nonce.
> 
> [...]

Here is the summary with links:
  - tipc: prevent GCM nonce reuse on peer key changes
    https://git.kernel.org/netdev/net/c/512ccd3d0e91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


