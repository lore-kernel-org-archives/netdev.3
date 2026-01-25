Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6AB482EB
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 23:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769383221; cv=none; b=GhArzDN3QqDjq5Z3gQdgckEZ7V5Mdm57wfaF/27ULn0w2l0Acy6iHvmfB1dXKltG+KA5pr1BbAqk+iiVBfm/J3aXJaLi6mFAnRbuBbioJJxgFRLTr0OmtWGye1ydajlxXKbs3qMn1x4ZLKGWAPh1C7ePWaYW88CTxS34APYpBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769383221; c=relaxed/simple;
	bh=vcwJPEGd8edu1GZTl3cjkXhQfKn3kFMPP01XZ3bonho=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LxS0dBDSFh4Vzo0hgMwZRraZM0Y+2w93B/y+AHrknsUT/RpIch8YF4VTzIQLIHBkhRazms0eXNDlub6TfnHLeeto+jBI7nkXybgh1aaPBwrf9cLbgV/KeSRyqePug2CVYLCY34itSbpD/yBcUmb84QwwdXIUOhGsr0pn5T/AsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnHR+NMo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnHR+NMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2BDC4CEF1;
	Sun, 25 Jan 2026 23:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769383220;
	bh=vcwJPEGd8edu1GZTl3cjkXhQfKn3kFMPP01XZ3bonho=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JnHR+NMoVNCQ5MiGOevYZ/vxh+M1NIQpvcISe1GrTq7HDkH4VKd6K9q/whQvIxJ0d
	 7Tf765Xz0yCjD4ES7e4+GNgh5hX9NXFPOfjG8ZiiBBThBKF3omCj9CjcVtSywgVkvN
	 7CoXHkSs7ZxUyRG8zu2i3widbxRfFOOpmT8La2kusQzJXAMV5E3Evo56Wz7mrAd82k
	 WakAZeFgxX9GoI6cSoKpbzvukw1eMdzt5ys5cSlJY5u0PvjH5YHDE73Ltw9V9XmPGU
	 BvbhIL0i5ceKYWvCHYf4WaxiyzNNZ3/+R89dvXlCFOrWftOdKaTrYePa5UgZqxBaJP
	 OI7Mh0QGuf4ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8D4A3809A15;
	Sun, 25 Jan 2026 23:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/10][pull request] refactor IDPF resource
 access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176938321560.4010024.11653612290613271910.git-patchwork-notify@kernel.org>
Date: Sun, 25 Jan 2026 23:20:15 +0000
References: <20260122223601.2208759-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260122223601.2208759-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 joshua.a.hay@intel.com, madhu.chittim@intel.com, samuel.salin@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 22 Jan 2026 14:35:46 -0800 you wrote:
> Pavan Kumar Linga says:
> 
> Queue and vector resources for a given vport, are stored in the
> idpf_vport structure. At the time of configuration, these
> resources are accessed using vport pointer. Meaning, all the
> config path functions are tied to the default queue and vector
> resources of the vport.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] idpf: introduce local idpf structure to store virtchnl queue chunks
    https://git.kernel.org/netdev/net-next/c/d83d80347dea
  - [net-next,v2,02/10] idpf: introduce idpf_q_vec_rsrc struct and move vector resources to it
    https://git.kernel.org/netdev/net-next/c/d1061502f353
  - [net-next,v2,03/10] idpf: move queue resources to idpf_q_vec_rsrc structure
    https://git.kernel.org/netdev/net-next/c/502eccecce5f
  - [net-next,v2,04/10] idpf: move some iterator declarations inside for loops
    https://git.kernel.org/netdev/net-next/c/f6892116be91
  - [net-next,v2,05/10] idpf: reshuffle idpf_vport struct members to avoid holes
    https://git.kernel.org/netdev/net-next/c/47ee0543a450
  - [net-next,v2,06/10] idpf: add rss_data field to RSS function parameters
    https://git.kernel.org/netdev/net-next/c/cfa7029a2500
  - [net-next,v2,07/10] idpf: remove vport pointer from queue sets
    https://git.kernel.org/netdev/net-next/c/9ad94c235aa6
  - [net-next,v2,08/10] idpf: generalize send virtchnl message API
    https://git.kernel.org/netdev/net-next/c/601643400bbb
  - [net-next,v2,09/10] idpf: avoid calling get_rx_ptypes for each vport
    https://git.kernel.org/netdev/net-next/c/822cd0923344
  - [net-next,v2,10/10] idpf: generalize mailbox API
    https://git.kernel.org/netdev/net-next/c/086d030e99d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


