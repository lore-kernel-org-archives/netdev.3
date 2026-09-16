Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD4E2E401
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517479; cv=none; b=W8V5OkP5lxfNuP4SKAdF8Bvsm8le4taV1/bq0JyfSl2gpviTlMlAY5lmBXPulQx2ojqetX4GTOgO09QQEmWSYGOJUnfIV47/K0eQU3b906ychgeJCkWMkGTeeXSzOOLQP49Z+EYYLM4XyI/2f71FMSpYrAmdZEzdLM9Kmof6D8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517479; c=relaxed/simple;
	bh=6fuOIW3IQRTYfiPMIIrM9XuEZKE2HPwoXXzN4XmEt8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XR80TU+qT0g0WV2z+JDUd/AceC/76zOb/IvuivALdMDVWHW5TmrgUdqGjgel4f2/6C7+ROSejCGYicUQIg6Bfv2dMBMqeL+pIQNKQT93mS7Ce9YiW9LAuwc2lfqfWMz4WYISMXbgScgYBWZ4SrHcYalz8pub1162Zc8DdIXYXvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPAZGMLb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPAZGMLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754201F00893;
	Wed, 16 Sep 2026 00:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789517478;
	bh=26/IblXRqzi3radZxLLmviCHZHdigy0xb5613KVcBzI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kPAZGMLbJiJZP4Z/Mo1d5ytucFY0QZYyeM00Zjrn4YnvaB1M4slEGN03ljmWkfv2f
	 gb12NwGgGC3mLpjL4AEARoH/HOEk3vL1iqFjsxry+KbS50+5avPeDSrnFypkjwfdVf
	 lJobiuZC85p//vPMKe328abH6u/mcrrwj7F0XOfsaOdaIcPJ4r/c3Tq7X3wvjjNwz9
	 7psNhQP0oJnSUT/vSd86eTp6C2TBdGhr3Lftz4jRpMrm3e6cv47n959Zt1iV6Ri8z3
	 2PWNseUB+/BB1InlmAOyudexFTLkFVfThagn6FPcTq/s3j9+Q56L/tO8UbdoIrQzho
	 2Zk9gWdsRliHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19759392706C;
	Wed, 16 Sep 2026 00:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] netlink: policy: report the big endian
 attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178951741263.2328807.1084523593940033347.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 00:10:12 +0000
References: <20260912202401.141336-1-kuba@kernel.org>
In-Reply-To: <20260912202401.141336-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, johannes@sipsolutions.net, fw@strlen.de,
 pablo@netfilter.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Sep 2026 13:24:01 -0700 you wrote:
> Paolo pointed out an issue flagged at low priority by Sashiko -
> we're currently not handling BE{16,32} attributes in policy dumps.
> 
> Commit 3f4285d741b4 ("netlink: specs: fou: local-v4 and peer-v4 are big
> endian") flipped two fou attributes from NLA_U32 to NLA_BE32.
> This made them vanish from the policy dump.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netlink: policy: report the big endian attributes
    https://git.kernel.org/netdev/net-next/c/b785f5c56fb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


