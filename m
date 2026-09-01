Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E4472084;
	Tue,  1 Sep 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269470; cv=none; b=C/nwjwNUO/4+PW0smwYXnUyNUrKvKAa0VaDkpFxVY8getajV6pcGxzZuYQ8S9HdKqW6l6s+5NaDw/otNGAiSbiwwngthucquZAN278xrK6oCV92+yjx6MN04eUMQYkXfy0CcsS/7JwEdRvZDO4bWJvfKCIyUxZ0MZGT58Z+2CBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269470; c=relaxed/simple;
	bh=fSWLmEM+qUKvuvXBfZA/dIZDxpUvtz6idNCD9qf/v+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uHcuGRQQg3glr9kUwswRHTuN1TWLNx7d5oUs46C4XLpWRtdd8NDAvinDkX6sHAYaO4VCuVuLBB6OFKsOFxyMxi8b+isHGrxGL1ndNfe1FyEl0zscGWzEOqTn6ychXmgyzGl9YAOU0e7O0dhj578wfpb72/ZV6l1A1fVZrKg/qHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjNyuvUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjNyuvUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BAF1F000E9;
	Tue,  1 Sep 2026 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269469;
	bh=pY3Mevs5Q+7bXSl27PgPi8DZPEJ4oPIVYsmCCQIuEP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZjNyuvUUl4lJrerjX/MBp0tAcJ34HSJ262VzhSvfllK+j+/vGnaLoGlDZb5Dkyl2j
	 3ojZOGB1Qfjvhm8KQEJos4CypJFqEnj/FNSfCvLMgt2CX5c1M20Ia5XTUhjGzhJVme
	 YL4DfMh/zBHQEvFXO/UCz61CCU4hi98rtspftnkEO5ecq1R5NR+jSo3fcwUhve6cDt
	 FXzW316h6FbCOGMSH37DR5yYUQRfx4Wv4g0hPVSVnx9aNfqs/UqVdl4Wvw8Gyk3FLo
	 QXrtIvTFCBoxHCPLzRrzBOt227hUIpLhVVVSWu8qAgMeLEuQSZtKRp2fbAREqLhyiF
	 UcZJWw9CQiRHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568E43924FF0;
	Tue,  1 Sep 2026 13:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] netlink: specs: rt-link: ipv6 devconf
 updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178826941214.1182020.17205509719306465886.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 13:30:12 +0000
References: <20260831093458.472180-1-ast@fiberby.net>
In-Reply-To: <20260831093458.472180-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, fmaurer@redhat.com,
 danieller@nvidia.com, fmancera@suse.de, g.goller@proxmox.com,
 prohr@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 31 Aug 2026 09:34:52 +0000 you wrote:
> This series updates the doc-string for ifla-inet6-conf, and adds
> two missing ipv6-devconf enum values as identified by Sashiko
> during review of v1.
> 
> Changes:
> v2:
>  - Update commit message for net-next, and renamed from
>    "netlink: specs: rt-link: fix ipv6 devconf doc"
>  - Add Reviewed-by from Fernando (Thanks).
>  - Sashiko comments:
>    - Added missing enum members accept-ra-min-lft and force-forwarding
>      as patch #2 and #3.
>    - Re: data types: as Jakub wrote in the original commit 720447bd0b24
>      ("netlink: specs: rt-link: remove implicit structs from devconf"):
>      "u32 is probably best we can do right now", as the reality is that
>      the sub-type varies per value.
> v1: https://lore.kernel.org/20260824103816.40040-1-ast@fiberby.net
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] netlink: specs: rt-link: update ipv6 devconf doc
    https://git.kernel.org/netdev/net-next/c/5e63ade19044
  - [net-next,v2,2/3] netlink: specs: rt-link: add accept-ra-min-lft
    https://git.kernel.org/netdev/net-next/c/2b0aecb7b2b1
  - [net-next,v2,3/3] netlink: specs: rt-link: add force-forwarding
    https://git.kernel.org/netdev/net-next/c/f952040d7016

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


