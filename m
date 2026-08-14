Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B03D9559;
	Fri, 14 Aug 2026 03:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677903; cv=none; b=Zd+VSu3cRUto88WdkAAAxy7A4P+qJSS4rMYc7CUA0FIetAd5Zg60f4s83g2NehiIPBGgJLNLKzwfmkJ4ddGso+dVRRp+ZI5RiyTSyEs03OoV+VZD3xt60WBEVUo6HqB5xlcB+9ntHiQphS6yA+kM1xPveXcKe/vDMW9xKaQp8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677903; c=relaxed/simple;
	bh=YWGhuMcjzWWsrMPzi5rtvO9dJ3rP3Y7BYCuyZJHVS9Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JstH5xWued0/hs/lf6tE3A7ir5HeBfO94vMQpgSRdd/1wF6vZeyxEEtyvFmE+cRxCC2Az1WZmxNz+vZWy7YHI2DMkMswLQgiVVdEs7zvbavT1ltPQS7+ZWnDH2Qy49ePIuDXX2wR1XMVCuhWPq60qYoijjJ1Jiz0++Y/fue9Q+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNsCDfXe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNsCDfXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0641F000E9;
	Fri, 14 Aug 2026 03:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786677902;
	bh=Kt5tgGvIVRQr23TCB4i3OGf2P8DUBRQhnOgwMZ2b9x4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iNsCDfXeSXtBYRIsCJfLiX+lHMwA3tOfZblxj7x+zPmMWwYm80bSXV/ngQG6iULGQ
	 IP6Bz5SKNMVU27+IrWlbDV1qyrhubX/L2RRwvy1FruXgm1m80ICt+bS/Ahimox2LQM
	 NxEUai+KRpfDeCHalfhHjPr0ANaho2XJcfLvLbi/zem4bZ0J3SkR2968g3W1zKFwyF
	 3gBVSmNYO7tj631vH0cWrnxg5LSsi2+eeQnkA8zczH4qKEmz9MaQaWOJzvUBw5lO0x
	 qLmULCsTdEmwR7znN84DkJbRoQ3tf+MF0fbwhKvxnGWyERHg1l1b4wNtBwbKHEtWr9
	 YX5+hLYKx6mnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09323810900;
	Fri, 14 Aug 2026 03:24:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: openvswitch: unexport ovs_vport_alloc/free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178667785639.3150297.10518427796662589055.git-patchwork-notify@kernel.org>
Date: Fri, 14 Aug 2026 03:24:16 +0000
References: <20260812122007.457136-1-i.maximets@ovn.org>
In-Reply-To: <20260812122007.457136-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Aug 2026 14:20:06 +0200 you wrote:
> Since removal of the legacy tunnel port types, there are no more
> users for these functions outside the main openvswitch module.
> Functions to register vport_ops are also not exported.  Allocating
> vports without operations doesn't make a lot of sense.
> 
> Highlighted by Sashiko as a follow up to the removal of the module
> infrastructure.
> 
> [...]

Here is the summary with links:
  - [net-next] net: openvswitch: unexport ovs_vport_alloc/free
    https://git.kernel.org/netdev/net-next/c/9702af05a007

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


