Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC854704E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791247810; cv=none; b=Ty2/9YzG4zoo63XV55lldpfjkmMizkHty+WQL9fpQI/9FNnbNH+RgvXdr/XzlPHeXYKDJb7Shn6spq96pOaGleJ++oXqtnv9tfdws4mqv60Y2Re7XEekCl/Io0TS6XLMJlNSmE5VFv98AKcmp8SQJqcsY1zcNVe3FGR90TQRQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791247810; c=relaxed/simple;
	bh=80NqeutT5gGNq1ZVfhRcW3IuZ79iS7yx87itvlec25k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sdzhgqHW6HMZRV9RTH0W45A5zC1dC+J6EvJ1FgLdHLnCWSAx8xDA5J8mrzU7LFqMDyAx2QPBsS7s++XEcSaMdrc1favUmDau0T7G4VNoh5+Zuqr+Gb87zmL0UaBIJNuJGnWPLVZs60iDbOtV8URbJ5A0izaSgX8j1ewf4K0PuOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj9dogqZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj9dogqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C0E1F000FF;
	Tue,  6 Oct 2026 00:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791247809;
	bh=nwczxQ9fvICRfG0h3rEJO7F4BMVUHAG9xNrV1heXrVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oj9dogqZKC91eT6hUP1XWDFC93Wa32ndL++A2aphs292/Mht/WqsEHNKcNlQgFjrY
	 8JqMU19Y0q0yOEXBFJ/jvIyk9C8t3irk7UUfQYvIB3vNqhCID+ETanPeXaduAgmybQ
	 vlvXU3aLNU6gGyxiGUDr7Vw/2GNxeISllNn2Ga4AQgPpM9vpwI7CdripWMNTkWulUa
	 kIe4u/fo/3a8EmwCGiPwOaMHP3er39szwsOtkeU2XQRsbU+theES0vFcVYy7irI/TO
	 GsQ6Xid6WqQMDp4bDo+BF9/H/sC4mBGC/h5VE9BVneX5EuVlNVOK0kAr3pN2+Mgop9
	 9A/16KSc2YIzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F142A392667F;
	Tue,  6 Oct 2026 00:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/9] batman-adv: bla: avoid double free after
 failed
 backbone_hash alloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124780778.1960739.8553982365608117644.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 00:50:07 +0000
References: <20260930094558.3723766-2-sw@simonwunderlich.de>
In-Reply-To: <20260930094558.3723766-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Wed, 30 Sep 2026 11:45:50 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> When batadv_bla_init() fails to initialize the backbone_hash, it is freeing
> the (previously) allocated claim_hash. The initialization function will
> then return an error and the net_device initialization will stop. The
> destructor will be called instead and (indirectly via batadv_mesh_free() ->
> batadv_bla_free()) will try to free the bat_priv->bla.claim_hash again.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] batman-adv: bla: avoid double free after failed backbone_hash alloc
    https://git.kernel.org/netdev/net-next/c/4c0a6a5b7715
  - [net-next,2/9] batman-adv: tt: clarify kernel-doc for batadv_tt_global_purge_local
    https://git.kernel.org/netdev/net-next/c/f11712fc3d5f
  - [net-next,3/9] batman-adv: tt: clarify responsibility for roam flag during removal
    https://git.kernel.org/netdev/net-next/c/08967c26cc8d
  - [net-next,4/9] batman-adv: tt: soften kernel-doc for batadv_tt_local_remove_now()
    https://git.kernel.org/netdev/net-next/c/be66c5ac5485
  - [net-next,5/9] batman-adv: tt: only queue local del event after successful unlink
    https://git.kernel.org/netdev/net-next/c/597c0f2f69c0
  - [net-next,6/9] batman-adv: tt: queue local DEL event under bucket lock
    https://git.kernel.org/netdev/net-next/c/f95b9f28a9df
  - [net-next,7/9] batman-adv: tt: queue local DEL event before marking entry as pending
    https://git.kernel.org/netdev/net-next/c/a6746cb19076
  - [net-next,8/9] batman-adv: tt: reject VLAN/TT entries before reaching size limit
    https://git.kernel.org/netdev/net-next/c/85fb027f611b
  - [net-next,9/9] batman-adv: use assign_bit() where applicable
    https://git.kernel.org/netdev/net-next/c/d1807b20d548

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


