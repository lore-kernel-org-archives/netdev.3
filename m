Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D684541DEF5;
	Mon,  6 Jul 2026 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330834; cv=none; b=Tb22jTJuMXJC5M63UqUjtz0nuf8NPEncsHK9Aenkn2nHf3JvMcoqR7chLR/o+/iXtxKN6GFSyPnu4QPwgTKgiDRxLv6DzNLFw9MCAOdCm6TaN77FapjecCAJGO2G1PSrMsdKd5pvkEJtiRo4QaRwuUna8Z5Ok9dnS++OBeoAxd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330834; c=relaxed/simple;
	bh=fI6OSerW0QsHBMNXDYUNqTeMhk6r7hRXxv0q8WXbYe8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FDd1kX2mEbw48xiIXAkBrAsWW/m0t0CECmz8PJ90mflZyI+auzv8HYoCWqabjVQ1yYN/93OCtW2EgrDbOO2EVBFImhcYPRdVdA5/ffXnrwMcg0xGjq6Fh+sbczXRZHLReG5JEJ0bdlofR/O94Snx41s7JQ3KFMxfv18jCyeftSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyoM2iJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyoM2iJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C4E1F000E9;
	Mon,  6 Jul 2026 09:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783330830;
	bh=TPq1k5+ZrZVzc6ASmSFhgD78a5P7mmd44ZyIaN2l1gk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PyoM2iJRhzyBWiHDmPJUNh3faVKroDjyS9tjCBogp37ufyj//GwB2AjTuK5dL+tqV
	 7y+vKO6Fzw4Q+dbhKlmtuITgk7P+Gn9TubWIOcbbkloHTFZoOto5xU3d+i43NsN1LT
	 +JKQTV8S9vrRV0Y6vkshmH6xvwjeWfAdGPEtwp8hJrGSJeNWBoi+GCD1AsBSly+jeF
	 /332S5xDHv7D4/zgJT+VZSt6btb80Ubx9XSApVekSNKPCGz5s8qZPtLJNa6dJ5+T0P
	 AvABOA1GdHHEDBxycgZt/1/1FU4GZus5QFthJ83YuvFsv5zednIg/0drMlUd6vVI0v
	 q/wXBIpkujKpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939BF3926278;
	Mon,  6 Jul 2026 09:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net-next] net: hns3: add support to query/set TX
 pfc_prevention_tout for ethtool with RX prevention disabled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333081114.465126.17705659397389447251.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 09:40:11 +0000
References: <20260630134043.1532431-1-shaojijie@huawei.com>
In-Reply-To: <20260630134043.1532431-1-shaojijie@huawei.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shenjian15@huawei.com, liuyonglong@huawei.com, chenhao418@huawei.com,
 yangshuaisong@h-partners.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 21:40:43 +0800 you wrote:
> From: Hao Chen <chenhao418@huawei.com>
> 
> Add ethtool support to query and configure the PFC (Priority Flow Control)
> storm prevention timeout. When TX continuously sends PFC frames, the peer
> end is suppressed from sending packets. If this persists, a PFC frame storm
> may occur.
> 
> [...]

Here is the summary with links:
  - [RESEND,net-next] net: hns3: add support to query/set TX pfc_prevention_tout for ethtool with RX prevention disabled
    https://git.kernel.org/netdev/net-next/c/d7261cdb9550

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


