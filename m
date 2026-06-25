Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B42C324705
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782353428; cv=none; b=XRrrOwJJZbDXgTyyCw7U+UaRD+lev73QoaErL1Wn4SLERU+l3VpWybI3qFT97aShyzc7m1PllsS06Xw7t/q5uX9EcsM4kg7s6o3dHeGSUz/BDkzCp6MKbkO9KkS6SHwcpCKUGM0nEyFj3TuLxWErM3TInYirF/DZ6N6aszYX+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782353428; c=relaxed/simple;
	bh=SAUrU6KBW90i/H5VskQqlE16xkx0uXi7TddyIyWQP7Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JzmouUzsdt1AZvNxDbYX1HVMMesF0Z6oB5LUG9pNZ3WyCJPqIz1D0d+eONl24WhhNt0Yyd6MNCO9U3dmgHLWKY0tajte3jjTojhQfLZZU8C2vhMHiqcny6EJAEDcyQCyQF4pn8cZdhMOX1u5mJu34GXHAM3M2ymh8lAyS7yUMVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRUL718u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRUL718u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1311F000E9;
	Thu, 25 Jun 2026 02:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782353427;
	bh=jC3Iumcb0YdCjBHz+rUkU5HOAJG8To8wWPopoG2L8tM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fRUL718uS9OgMyFFHzooTUJ7eJuhUR3Oqr3aosAMYLgba2mSTZ9s0qrOrjnF+wjHT
	 pe/j4JOVDWo/HtRG/v6VmkX4wTXGT5+SuHvrwCsmHgRAvVXUmsmeXmqJPP6uxxM5IA
	 Z7Ms+H43vmCfCMWw7rFmp+dsJluniO1L7bmOjwvI5Yxxfh9u1IYfomkO9mQr84KsWh
	 SnK3KtuwtqZwWED4t8zB+3+afKm9tpIFeIJTvC9rm0CNQkszdz0IgJ/7Lh1t6nPBEd
	 j1cTfTyqWZQ6kxWHwXJeM614JNm+Pi55CrX/B+5abDEWx7Z9ge0V1k8HOxMRnirVzG
	 exYjumClakbLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C63AAA6D4;
	Thu, 25 Jun 2026 02:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/2] geneve: gate GRO hint in geneve_gro_complete()
 on
 gs->gro_hint
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235341483.3082498.12410825283357461784.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 02:10:14 +0000
References: <20260618032622.484720-1-xmei5@asu.edu>
In-Reply-To: <20260618032622.484720-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 bestswngs@gmail.com, kylebot@openai.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 20:26:21 -0700 you wrote:
> geneve_gro_receive() reads the GRO hint through geneve_sk_gro_hint_off(),
> which honours it only when the socket enabled IFLA_GENEVE_GRO_HINT
> (gs->gro_hint). geneve_gro_complete() instead calls the low-level
> geneve_opt_gro_hint_off() and acts on the hint unconditionally.
> 
> On a tunnel without the hint, receive aggregates the frames as plain
> ETH_P_TEB while complete still honours an attacker-supplied hint option: it
> inflates gh_len by gro_hint->nested_hdr_len (u8) and redirects the dispatch
> type, so the inner gro_complete handler runs at nhoff + gh_len, an offset
> receive never pulled nor validated, reading out of bounds of the skb head:
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] geneve: gate GRO hint in geneve_gro_complete() on gs->gro_hint
    https://git.kernel.org/netdev/net/c/2651c1744458
  - [net,v3,2/2] geneve: validate inner network offset in geneve_gro_complete()
    https://git.kernel.org/netdev/net/c/cbb0d30a1ad6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


