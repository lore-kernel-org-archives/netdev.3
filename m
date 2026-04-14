Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E034EF08
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172835; cv=none; b=XgtpbAc8BgwMXBGeoXuG4jimHHAofHd2VkDOgAqj4O6ZDFgJephxrENuUUeEaRIOsaQOxL6gX8qc5wQOr/RSU9o1hd7GdqMVJIh2SmjtIlBfcv3drJK2Riamz6TorMv1GyhpJGvva+XofAlXo97bUcrq0JuXZST24TfeJR+a4Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172835; c=relaxed/simple;
	bh=cMCDkATKBmtmieFp8QBU6yJuQwNr3qs20Cfx6XJdEWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uZkiaeZOah4tybKqD0t59TvUDmrqqc8gzRWPSTaiv9r2UgHdZ54zamqKvsNozrzliiDTKxgMesvrVeS0p1Lja15FoAErQDHoz78SIQNuecIxN3mAeUt0eqMKVOKVGsIqeZYB2vIqUfAH8tgHtje/U9EsDhrmB/yF+eysj4YPdWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5XSbWwJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5XSbWwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98F0C19425;
	Tue, 14 Apr 2026 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776172834;
	bh=cMCDkATKBmtmieFp8QBU6yJuQwNr3qs20Cfx6XJdEWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B5XSbWwJ+9hKnt5Xdh2YU+VP2rCKj5FPUW3me8pSMUUaW79hQUMGZt49iZI5aT9E7
	 rxBm8aJxvQ9rj54iGEC3ZEuMaxoliVjLY3C7f71WvRLJnNYaygyHfH0eWzLGQdNmBJ
	 M2PI6lBOvRnlDhsNlJQxZ7vUC36QlYFleT0bT/WGe5hVi5A4K6WRvU93BXZs8t8It/
	 WoI3t4Ul5bfy71peBBJlX6b2ZFY0QKnRxF1ricuYosCd5cSMokKQxOqKZt6wN/wfO3
	 0JEyaMxbwJzBlqO6CaimbfarHs88jz25P2ikU2og/bSMK+vko+elJKTu6ZjA9XyCxV
	 i9t8cjufkt0Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE743808205;
	Tue, 14 Apr 2026 13:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Add missing PPE configurations in
 airoha_ppe_hw_init()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177617280505.878864.13821756004828787817.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 13:20:05 +0000
References: 
 <20260412-airoha_ppe_hw_init-missing-bits-v1-1-06ac670819e3@kernel.org>
In-Reply-To: 
 <20260412-airoha_ppe_hw_init-missing-bits-v1-1-06ac670819e3@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 12 Apr 2026 10:43:26 +0200 you wrote:
> Add the following PPE configuration in airoha_ppe_hw_init routine:
> - 6RD hw offloading is currently not supported by Netfilter flowtable.
>   Disable explicitly PPE 6RD offloading in order to prevent PPE to learn
>   6RD flows and eventually interrupt the traffic.
> - Add missing PPE bind rate configuration for L3 and L2 traffic.
>   PPE bind rate configuration specifies the pps threshold to move a PPE
>   entry state from UNBIND to BIND. Without this configuration this value
>   is random.
> - Set ageing thresholds to the values used in the vendor SDK in order to
>   improve connection stability under load and avoid packet loss caused by
>   fast aging.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Add missing PPE configurations in airoha_ppe_hw_init()
    https://git.kernel.org/netdev/net/c/b9d8b856689d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


