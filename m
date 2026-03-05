Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174320ED
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679010; cv=none; b=vCFm9AjRIOrfMklUd2YwKiaqrBgj0zgLsnM4PcmYgmh6zWW9NVZn418MXOBV0YlfH6asx63UFSKQCB6I7nQGvtBGpnh/1oivuw8Zzi75Cs9r+wkbrKmzgRyeZxRRHDdFX4BlYKVEfLG1FvoFFYgnlCFN/LtebPoxTYK/yM9FU8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679010; c=relaxed/simple;
	bh=VyE2AkIO7OwTj423tujCtrshROy0JqsumF03i2+L/CY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cRRGQXCI1GDxAVSPbcOL3QyZXQStR001TeYWdw/KvxsP2WMk+F4u8q2snBzzAjO6kYqJfH2ByFnt6tWFUsrpHaDsnUwyhlRJpZTLqKBsZ55eCVE4hJ4G1s+wu/AEbv12B4KHwAXDJcrZi8mo2jUjyxP71Wuq2H6LbTheC+qpZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7qCExQC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7qCExQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87D6C4CEF7;
	Thu,  5 Mar 2026 02:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772679009;
	bh=VyE2AkIO7OwTj423tujCtrshROy0JqsumF03i2+L/CY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S7qCExQCQjn2ARXyK/AQ5gUpruS+JzEKDK6SPqfZBy8OW8V+PSXuOU8/BzwvEzcH8
	 Jo46eDx2FE0V8C6r0LSjVl0HtW/G4OArRQmmSEuiP3i283Dcwm/GKUs5AC60nwjGWW
	 eY3AIVviFXERP0jrr9GgcZLZP2UcnN02ssq4dGjj033VveBiuquDrly2CE4fP5r33S
	 jgXrU754gtiXsbHby07xZEt0BGRY2LC3hORT7fCqLjTnnYy1KshfPHi/jf86ZhBtgD
	 a7ekub5vXP6lg7Xvqy4IE4CBkYllmgQzpwnjDqgsErkcGxtjihe6yUXmva25dGlObe
	 A0riUU22pUa3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEC43808200;
	Thu,  5 Mar 2026 02:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4][pull request] Intel Wired LAN Driver
 Updates
 2026-03-02 (ice, i40e, ixgbe)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177267901030.2491987.15605331291201758604.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 02:50:10 +0000
References: <20260304000800.3536872-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260304000800.3536872-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  3 Mar 2026 16:07:52 -0800 you wrote:
> For ice:
> Simon Horman adds const modifier to read only member of a struct.
> 
> For i40e:
> Yury Norov removes an unneeded check of bitmap_weight().
> 
> Andy Shevchenko adds a missing include.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] ice: Make name member of struct ice_cgu_pin_desc const
    https://git.kernel.org/netdev/net-next/c/dc0cdb7ff3b1
  - [net-next,v2,2/4] i40e: drop useless bitmap_weight() call in i40e_set_rxfh_fields()
    https://git.kernel.org/netdev/net-next/c/1f3d49734820
  - [net-next,v2,3/4] i40e: Add missing wordpart.h header
    https://git.kernel.org/netdev/net-next/c/b09621cc0dfd
  - [net-next,v2,4/4] ixgbe: refactor: use DECLARE_BITMAP for ring state field
    https://git.kernel.org/netdev/net-next/c/246c5495c69f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


