Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DEF46EC80
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802610; cv=none; b=KNRBFaOwD+SVL1BoS3NbAkT6wTWBSYb33jaAIdozLvmKzlkkCyaPw3tM7dpMNKVnr9y1mufpfVzbmp/kA2IotR5ja9s7Yi4ST0CLPqmITiUqOBSMwLQ7bUlOXU9u37rEmnH0o3onb5rqqZNKMhiWTTqHyIVe8kJdrDMVnvlR6OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802610; c=relaxed/simple;
	bh=iZ4yw5/oIJUZczE3Rjq3zqy04q9Vx91y+JXwIDBi1ug=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a3masal4kPqDY4ULUaaynvQs3Vw5MBitD5VwMDgQ3DUX0d4dm2iTbHDqjTKEuggBcC0CsfiLb+erNvYvNeWsUcHTFFQqnIkA4GKAK1sI0nHitpO0hBnXsb8pB3k4zfobXCEpsbpRIkn63gR824/cp0scWaxl0ZPemQli6De4WOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n35wyVNM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n35wyVNM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD00B1F000FF;
	Wed, 30 Sep 2026 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790802608;
	bh=Rv2C60dLRPvl+tqEAsq14o0GPCWFdLg6FyDwsAVUSo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n35wyVNM7jdfkTgd5kqV0MS5nIhJM0P+vKDIR2xMtdswWHZrq2XML7H6bc0sjvf0B
	 dOSkNXU+UbRYaFbVLxVkV21gFKYo3F1U/gVHddtntAau8kuwlgl4F2RERGF+MzC5IV
	 NyfFIDEFSZ1ZdlddnctuSj7R3LiHRsoEkDqD68CmSsvqP8nEFFftXleJyhJJKMZ1oq
	 9aTebpf4qs0+l5arWtwFQizWfN7R3iFkSLSugMs/UhBeb3QWvN809Uu/1NHxo9QyEY
	 OLaECp/12D+umnSo8WJrIr2QO6cAsieKH07CRPB7Efb2XpXyfSU2CTgtdWcRnGVVml
	 Pf5Oqr2Xmarkg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B444E3A56772;
	Wed, 30 Sep 2026 21:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/6] ice: fix stats array overflow via proper
 realloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179080260753.2130503.18321701667640096193.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 21:10:07 +0000
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com, mschmidt@redhat.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com, horms@kernel.org,
 pabeni@redhat.com, davem@davemloft.net

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 15:15:42 +0200 you wrote:
> Fix OOB access to the stats arrays.
> 
> The first commit (new in v5) fixes stats code against VSI_CHNL case (ADQ).
> 
> Next three commits are simple refactors to make the rest smaller,
> the fifth one untangles the logic/lifetime of the stats array entries,
> then we have the final fix for OOB access to the stats array (combined
> for both PF and VF VSIs.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/6] ice: skip stats handling for channel VSIs on rebuild
    https://git.kernel.org/netdev/net-next/c/3fca849c9653
  - [net,v5,2/6] ice: extract __ice_vsi_free_stats()
    (no matching commit)
  - [net,v5,3/6] ice: extract ice_vsi_new_stat_arrays()
    https://git.kernel.org/netdev/net-next/c/ed3cbc4430c2
  - [net,v5,4/6] ice: extract ice_vsi_get_num_qs()
    https://git.kernel.org/netdev/net-next/c/4425fa055c0d
  - [net,v5,5/6] ice: rebuild ring stats arrays instead of reallocating them in place
    https://git.kernel.org/netdev/net-next/c/66444f06a9fe
  - [net,v5,6/6] ice: size ring stats arrays from the final queue count
    https://git.kernel.org/netdev/net-next/c/f1c3b87896e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


