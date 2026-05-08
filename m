Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834512CD8B;
	Fri,  8 May 2026 23:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282470; cv=none; b=LtEsMY+FH9fuXgPy2PgjExn9HPnf6bxJekrHeqBST0k44ws7s75Za3rGnMGRSwxwNOu+VBhzQm4UxFuM1O0nWRprA/iVckoJFeNpjWGisVcEyCJiM5KPhPmmRhszQ6ilumR7wPv4yt1YJBxr6V33NJ1DjuqYf0FskDBdnZZbpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282470; c=relaxed/simple;
	bh=jiBBAh+tYPq01D1+yZYu764BQl5VgaiQlj5egEd6T0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YpQdJ7398MadzJPXmwlkLHsCyD7oqOkk31nO9owhi5sWh9HFMOBfGjT2ZenD97ECdmxUgADPWPE8NqubcmndS7mJjNmyCdDg6do8gp96wetcUBdYEihjAcFef/+ygVFnvFsj2M20QfKyTNuQjTT8ZvnLD8IiG5SusiI/c9awDgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGEMfB7a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGEMfB7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269A3C2BCB0;
	Fri,  8 May 2026 23:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778282470;
	bh=jiBBAh+tYPq01D1+yZYu764BQl5VgaiQlj5egEd6T0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eGEMfB7a+7c7g+M7fl40Y1/cUSASCmqYG57gbOiuRivqSYO7Ftt6/G3ctm/cwL7xa
	 FA8/EBMRBzleoY7ayfyoTccvw2H58W4jrqx1BvFnfCjCQ6u3gZ1d8c7k0DvPTMQ7aU
	 W3WgwTAw8//YvOWCENb63O0dSJj94Hn/SuCdO4CNh66drMI2wGB817NTQDqZ8Wsgwo
	 9s5xFDpWhgpq8R76n8Kq4qJ/JdWxfBc0bXTErFafgRWaBqcNe5JUHdMRVw7ChxupyL
	 azNUEuSmrh95xB7tdLNMtyUxIh0UC+dn/9Rpg+LEEO+rXh+SoePCDA0P/3gVHPOjcW
	 D0ZWnmksKyPJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EA838119DB;
	Fri,  8 May 2026 23:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/8] Intel Wired LAN Driver Updates 2026-05-04
 (i40e, ice, idpf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828241855.890779.16522525518979245121.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 23:20:18 +0000
References: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
In-Reply-To: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 piotr.kwapulinski@intel.com, aleksandr.loktionov@intel.com,
 arkadiusz.kubalewski@intel.com, maciej.fijalkowski@intel.com,
 joshua.a.hay@intel.com, madhu.chittim@intel.com, willemb@google.com,
 david.m.ertman@intel.com, ivecera@redhat.com, grzegorz.nitka@intel.com,
 netdev@vger.kernel.org, stable@vger.kernel.org, tactii@gmail.com,
 sunithax.d.mekala@intel.com, kohei@enjuk.jp, pmenzel@molgen.mpg.de,
 emil.s.tantilov@intel.com, horms@kernel.org, Samuel.salin@intel.com,
 gregkh@linuxfoundation.org, anthony.l.nguyen@intel.com, stable@kernel.org,
 marcin.szycik@linux.intel.com, bvanassche@acm.org,
 intel-wired-lan@lists.osuosl.org, arpanax.arland@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 06 May 2026 14:48:09 -0700 you wrote:
> Matt Volrath fixes two issues with the i40e driver probe routine, ensuring
> that PTP is properly cleaned up if the probe fails.
> 
> Emil corrects the initialization of the read_dev_clk_lock spinlock in
> idpf_ptp_init, ensuring it is initialized prior to when the
> ptp_schedule_worker() is called.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/8] i40e: Cleanup PTP registration on probe failure
    https://git.kernel.org/netdev/net/c/1619553b0a6b
  - [net,v2,2/8] i40e: Cleanup PTP pins on probe failure
    https://git.kernel.org/netdev/net/c/678b713ece1e
  - [net,v2,3/8] idpf: fix read_dev_clk_lock spinlock init in idpf_ptp_init()
    https://git.kernel.org/netdev/net/c/da4f76b6a84e
  - [net,v2,4/8] idpf: fix double free and use-after-free in aux device error paths
    https://git.kernel.org/netdev/net/c/6c77b9510829
  - [net,v2,5/8] ice: fix setting RSS VSI hash for E830
    https://git.kernel.org/netdev/net/c/b3cda96feb60
  - [net,v2,6/8] ice: fix locking in ice_dcb_rebuild()
    https://git.kernel.org/netdev/net/c/0ded1f36ba40
  - [net,v2,7/8] ice: dpll: fix rclk pin state get for E810
    https://git.kernel.org/netdev/net/c/cce709d8df6b
  - [net,v2,8/8] ice: dpll: fix misplaced header macros
    https://git.kernel.org/netdev/net/c/30f1658fc538

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


