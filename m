Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716FB3947B8
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231410; cv=none; b=BcMybHr0senYcZVf1mCmBGUUvDvXi79pMn0f7RKq7kNkm3aDrLKsq8EDEB2nPoXXcMNU+BH5DFyA7Ip6yOhlX/W9SUHXrawgP8TEUdjaqXCDzfEXFn1og6sVI6fjlMefUVL5kdsSnvTk7+bjy2XCqXF4A3n2MXnyLSLK8E4NcII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231410; c=relaxed/simple;
	bh=FiUVkrUIS77KLDnPrvwKSkbtlSwluU6zxUQfIqMTGcw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VoyNwaHxa5Rd1avpyxcmiLZbCPcVRQqUbxcQMUnoMtlXoal3CHRd3Z/8rkoZENU67d8siMXdf8C/oIEteY7HdaL0IK6rNt+GMmO6/OGFWuZl/8GJ1LBZ0W5xza/ydxENypyl9Ud9gbvosdxfMDwAdZhDQE1z5lLbTr62vF1MqsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpKFyMjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpKFyMjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E6A1F000E9;
	Fri, 12 Jun 2026 02:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781231409;
	bh=1E3LbLnjObz5srnwi1aUguFg1T0A452dmkx1+V2Dj+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SpKFyMjxH5F61jdibgXSg5H1PVwADfAxTqphyu5V2RThBXRUOnFaAxy6Up8HrAi7y
	 rOsTNdBUD+TaU6GUyIZor052iIfJMZzxl6jSRefl4UydngdagxcQ4AEAaMhEyN4Vla
	 zi7FUWtdmCTg6T/8XC9AMP4I9t6b7scAnJKDSR2jNW+BAaj7QPq+Hk2NUHTk9/yqAV
	 eUnK/Xfn/OkqoiXhzG+BC+xuNxniuCJYgaft8H+gd3VCy/wBouwYfQUqWG16dj+H9+
	 rx1qwXTZrCnvS3usE1DHhAa8NK/IxA840XM+jMTNloAGvxr8E6HdGnmHBAaFq10exD
	 gEtjyvsM9ezAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568083930E22;
	Fri, 12 Jun 2026 02:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ip6_tunnel: annotate data-races around
 t->err_count and t->err_time
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178123140589.450983.10617031345094345888.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jun 2026 02:30:05 +0000
References: <20260610171458.1359630-1-edumazet@google.com>
In-Reply-To: <20260610171458.1359630-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 17:14:58 +0000 you wrote:
> ip6_tnl_xmit() and ipip6_tunnel_xmit() run locklessly (dev->lltx == true).
> 
> ip6gre_err() and ipip6_err() also run locklessly.
> 
> We need to add READ_ONCE() and WRITE_ONCE() annotations
> around t->err_count and t->err_time.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ip6_tunnel: annotate data-races around t->err_count and t->err_time
    https://git.kernel.org/netdev/net-next/c/f6033078a9e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


