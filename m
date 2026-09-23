Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89D1BC2A
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127076; cv=none; b=kQ+ULjoFgriXluUMOb1MvkZI3/Qh1KtJDwdzbFq7blLyd0/Orc07gKSm2weweGIIdGefNifXFuZ4y8TpMXBMt/ZHhE2nyLCKq32p5XkG3GTVX/AdHt4E4dTkuavX5R+qJRxOZDJcCZvlXu09GaYvZB7lW7eQJSJ9VnGG2z/YyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127076; c=relaxed/simple;
	bh=vOWSWIHuF/VvsnQh50xbiz97djjWijeaTW2hf+YkSZY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lqSGqA5mC+cXyZ5OWKo3Usj/MG7hd40tcUQCkiQpdZiPAEunUtJQVoESnY5aHwlh2NRxqhe/cS2UGacmcv9SGAhzQJo8dq9QzWD4aD7SG7XF93+A/msemmPCvEFUYf0gSkd/CA4sJOnecnkwgQ+GrLp2zSYL7Z/pCJ5PFjfQrwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kENHUZsH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kENHUZsH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FD41F000FF;
	Wed, 23 Sep 2026 01:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127075;
	bh=raSOH/qvT3t6Kl8VH5izM4Me6Ms6rd4LzLpwAEC/R60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kENHUZsHG6G4ipncKWz0KFATBky24UA15uweR3df26GLEiHVB6pMpZHHxTfGNWtX2
	 2AkgA6hXQOmk1VlBbUXisiFDb5u0WswqTjxB3CrYOET77ou+qpT9Fi0gFdyg9BJGbi
	 CW3zBxCnUsRlND20uGhGDGhqZ1E1oMyS9QfZZeeTEsAM1iyJXRS2qx0NMa3DGABj8X
	 zpRTCxU8+WZnXc04im/dHztwHfkq5MZe0Ba4Hec4T4kX/nLGsOpIU6cNIg++xzXXm5
	 IC8GEfDCIeT7oSjkxZJ0s2+zEkTZb16YMQBITK5OY74u1vM9QEkxXP/gQlPz6VGClG
	 FpbkBvdqO91QA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AF53924463;
	Wed, 23 Sep 2026 01:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/12][pull request] ice: Add ACL support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012700564.164326.11549624941458378418.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 01:30:05 +0000
References: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260917183927.2692068-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 marcin.szycik@linux.intel.com, aleksandr.loktionov@intel.com,
 sandeep.penigalapati@intel.com, ananth.s@intel.com, alexander.duyck@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 17 Sep 2026 11:39:12 -0700 you wrote:
> Marcin Szycik says:
> 
> E8xx hardware provides a Ternary Classifier block for implementing
> functions such as ACL (Access Control List). In this series it's simply
> referred to as "ACL".
> 
> Implement ACL filtering. This expands support of network flow classification
> rules for the ethtool ntuple command. ACL filtering allows for an ip or port
> field's optional mask to be specified.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/12] ice: rename shared Flow Director functions and structs
    https://git.kernel.org/netdev/net-next/c/e3a93c886d9a
  - [net-next,v2,02/12] ice: remove unused ICE_FD_FLUSH_REQ from PF state
    https://git.kernel.org/netdev/net-next/c/9782619d054b
  - [net-next,v2,03/12] ice: initialize ACL table
    (no matching commit)
  - [net-next,v2,04/12] ice: initialize ACL scenario
    (no matching commit)
  - [net-next,v2,05/12] ice: create flow profile
    (no matching commit)
  - [net-next,v2,06/12] Revert "ice: remove unused ice_flow_entry fields"
    (no matching commit)
  - [net-next,v2,07/12] ice: use plain alloc/dealloc for ice_ntuple_fltr
    (no matching commit)
  - [net-next,v2,08/12] ice: create ACL entry
    (no matching commit)
  - [net-next,v2,09/12] ice: program ACL entry
    (no matching commit)
  - [net-next,v2,10/12] ice: add ACL reset recovery and NTUPLE feature toggle
    (no matching commit)
  - [net-next,v2,11/12] ice: re-introduce ice_dealloc_flow_entry() helper
    (no matching commit)
  - [net-next,v2,12/12] ice: use ACL for ntuple rules that conflict with FDir
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


