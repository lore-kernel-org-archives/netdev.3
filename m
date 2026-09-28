Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F33337B010
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638287; cv=none; b=AbTetBNRFA1BGUdMxZ/H8czs9/xVsx7vxd89eoEKiPG4gDUL/o0Asp8FYZKm+u2wJ0D/D5kkfSlWdxq+bHCnmNj2BDssZW36bXxol6wR/DmTgKh1VS+O8Ho/Gb2wsw7najikdKfstp3jROIgT0ZDDIO1cMrRWXLntu3TAcrwv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638287; c=relaxed/simple;
	bh=akg9ZDYoADgLVNcs+f1so4kIF4FzAPnoqsi+PHuv0tk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hkItmUEv8rivvtfT4q5YWksLKbqhwOuZOc48NB8rcgWWXr0dqMxMUNtUFEL/2g3J8V85VaLtPEDN5N1GW1GnHMexnOZnyxVi3nNFnc0HNDi6iZ9pySa/b2mljFMKhVZ+qmMcvNoTyB55h0PvTpNenjdJHTZh3EzdrMbWnckjThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaElHy68; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaElHy68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA581F000FF;
	Mon, 28 Sep 2026 23:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790638286;
	bh=NpiiFYmyXxoSavmyYFMt5KWsOACQ3FBW/fApiyc/Yns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NaElHy68isHh0tnP7zTQv6ukF0ayjoAECZGTfDy46200RHTGBwsIqlxx3yL9F074z
	 B7AJe7moKVr0acD/k2z5+zrFtH9Qb0zjifyLcYA1zB8oP9RXOi4/tuNkDwyo5eF3P9
	 q7fx7gM2988pZYckXpB1I9Zkhgd/RIqeAinQit+DG93Tg7vv45ocF70Ht8XzCbHOV+
	 dvRcJ1UOqlNCJa43rSF37/mu5gYpCzv1ZmVNQBtWvxt49R2LITMiT/XT6SwUh00c+D
	 ZJ6o27jBsMawCqKvqjvYzjHKulLjMJ5KpKTCyYXD+luuK4i716pxRvQj2cPkS1iYfU
	 FWbMTUR/6cuPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199263924FE4;
	Mon, 28 Sep 2026 23:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] hinic3: handle auxiliary device ID allocation failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179063821090.174580.17192072801797214528.git-patchwork-notify@kernel.org>
Date: Mon, 28 Sep 2026 23:30:10 +0000
References: <179001656835.91284.3719235813225229273.idr-bug-81@gmail.com>
In-Reply-To: <179001656835.91284.3719235813225229273.idr-bug-81@gmail.com>
To: Sang-Hoon Choi <csh0052@gmail.com>
Cc: gongfan1@huawei.com, netdev@vger.kernel.org, lcy8047@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 03:49:28 +0900 you wrote:
> hinic3_init_hwdev() stores the result of hinic3_adev_idx_alloc() in
> hwdev->dev_id without checking for an error. If ID allocation fails but
> the remaining initialization succeeds, hinic3_add_one_adev() uses the
> negative error code as the auxiliary device ID instead of a reserved ID.
> 
> Return the allocation error before initializing the hardware. Add an
> unwind label that clears pci_adapter->hwdev and frees the allocation
> without attempting to release an ID that was never allocated.
> 
> [...]

Here is the summary with links:
  - [net] hinic3: handle auxiliary device ID allocation failure
    https://git.kernel.org/netdev/net-next/c/087827628ad3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


