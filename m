Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100016;
	b=qj0wqjm/6k7u4TThIbUTP32Kbxu5xyRklagI6tYTUDUsRoVHyIoQN8JsNiQik5UdfkAN
	 3e5H2pFl+QlNrix5c/PcMrn93cYLYr+S8iFJl8UXuSxENIUskiHmEQazyIBGHZijKGaqW
	 58FRMbVq4RzJQldLGgjXprClpRWnzNnZIjF1N3uCtNnJ04HzyEa9d59bgHPeWty5HQsCg
	 McVXHKQbHdfQkqX9c6eXFRFUyzYCRjbgx0dltHoir3Sf2TGMLWlld/Vw+ovNZOzX5fJk3
	 U2HVP7/GX4G7KO6a4YWc2APF3W2MA/SISOe10N4l2gCWEpvrMmUqcNF9Xnpz5WChdZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100016;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=CuiZddo/01BhTAXEP7M7RaEfIKgYuXoE3a1KQe8iOqo=;
	b=4jbf6k1r5GDwKfWjYWq7sDS6vyrvW3jEi/icl13Wwu4fJS12rcle/iUIoE1jrDbZh8m+
	 SgiPMKCTOgJjNvrAz0QS4nYPoWzy7MCErYM5lEIxKlziZkUIhUPCn9bQRymKZmdnXdjTV
	 O9WBz87p1RvzB2OU6/6ARt4fPsgUeM40/KoioZ7fdiuMADT0D7iyjN5t6mam8TLzcrkuu
	 /exLP0DEyFw/NsKrqHwxJ0BXAw8TDrmEiojz09GdPBY0quAyEUa0OR+2Sf1D1kPDeo+32
	 O4Lgb+WSn61BokbFZHrkXADrugzoML1sX56XBE0pQiOt9SE8zzYxE5/fa442pai6EDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGlPIRoh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C039606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGlPIRoh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F2541F01825;
	Tue, 27 Oct 2026 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793100016;
	bh=CuiZddo/01BhTAXEP7M7RaEfIKgYuXoE3a1KQe8iOqo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XGlPIRohVj/j60H1/kL8KNzIiIfM3rNfeHke70FxRYvp6IxY4rWQmD9oMKVrXiuHh
	 bKlaapwpQ/AhdyqGHwbCIhBtrvvfp7MPtR7jASuqrmNs2C/BI6KM4iFN4lVTzvyjsx
	 AUkmCSRryI5xyHIHT4MeczgwDDhjBqomyI24jqM/fDnTg0gA8O5JojyUt+GrrIqxSO
	 4F15CLsAa++ZBBhmd+2SxMsZjEEQLvQgrbev5yHvVHJ3/vXcND5KDpjvKyc/MqgHC6
	 j8SgiuE2ybxTt3Mc2b3mjWX0tww+WGYEXtMiFniJ8PMQ64L+7HI6EMxliql6dbnQ6o
	 yQVwTYvOwLZ4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0741B3AA9388;
	Tue, 27 Oct 2026 11:20:16 +0000 (UTC)
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
Subject: Re: [PATCH net] net: xps: bound the cleanup loop by the old map's
 num_tc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179310001483.3743855.12990694604364154535.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 11:20:14 +0000
References: <20261021155538.67867-1-phx0fer@gmail.com>
In-Reply-To: <20261021155538.67867-1-phx0fer@gmail.com>
To: phx <phx0fer@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Oct 2026 23:55:38 +0800 you wrote:
> __netif_set_xps_queue() walks the OLD dev_maps to free its entries.  The
> per-row trip count uses the NEW num_tc while the row stride uses the OLD
> dev_maps->num_tc, so when dev->num_tc was raised without rebuilding the
> XPS map the last row indexes attr_map[] past the allocation:
> 
>   BUG: KASAN: slab-out-of-bounds in __netif_set_xps_queue+0x1458/0x1ee8
>   Read of size 8 at addr ffff000014f69458 by task insmod/112
> 
> [...]

Here is the summary with links:
  - [net] net: xps: bound the cleanup loop by the old map's num_tc
    https://git.kernel.org/netdev/net/c/6d5a2cb0b7d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


