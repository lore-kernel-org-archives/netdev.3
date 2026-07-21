Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187124582DD;
	Tue, 21 Jul 2026 22:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672445; cv=none; b=Yr0P4gbpLF6RAwPmZGCWn5YAYWndZcyEUGR1QgDMyphA5EgKGfR0UCCyG24SVHZRcEEK7iO80w+OzAHIwhpr8yQsLNFRqJeJU2WYnw74R+iDxkyDXwU62UVTTrRf1kQ458EG+/HtyWciDqUI+Jdthcxf7bT2WJev5giITms4fPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672445; c=relaxed/simple;
	bh=Iyf6sCZeHZQWCJahpnY7Ks+Etlv3xi1XnTZahnSl4uw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bbKzxc12Pe/105QBfi4fO4sNz0duqOtsplWLYxUQskz4oH6Oohygv+MMTragE2d52NRrjWllTU4CHfO/uWHAZENotUCh3mMgJRkZ+KbS9G178TN/BCHw6CqFgDFXeSy3LMDIEtJhSAtdsdFYQ3y2jPxp5z1bWdO/kLqKaQ+XKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSSUa//I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSSUa//I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F044E1F00A3A;
	Tue, 21 Jul 2026 22:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672444;
	bh=CFol5UsDId2V6adLw6Do0Xkdz2VCkiubsVXuQivpy28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KSSUa//IIU4eUFIZGZaN950A89F/5yjln9Qp/so+dng3xmclyHbZf80vEQXEN2fJD
	 Pe2gL3I1A1W2foiYSjWRlOTzh46Ev8ZVIKuu5jd3djB3TrAPI5bifzdRx0SGQ1FSWD
	 fcAcZCMYQ6AoOVy8HA0ihyABMIeaHBNfFvH8a3qHwuzWFQ3KpIJah1x0uak2L+YxX8
	 nnvtMvltD1q/a/Ojz0c382oW41U/MkMEFXhqxz2SgRK1Hd+aVZMRaIRZCs4u85LzcO
	 VU5M8BgpV29ElQypitD31AwXiCdElH/EoA7gYa8wXXWNoiWZVEOT+/8P76nB6C8ANm
	 9Ly2Jb4x3HQCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B1C380820D;
	Tue, 21 Jul 2026 22:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: fix infinite loop in __tipc_nl_compat_dumpit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178467241340.1119846.5904915833797134372.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 22:20:13 +0000
References: <20260713204940.647668-1-koike@igalia.com>
In-Reply-To: <20260713204940.647668-1-koike@igalia.com>
To: Helen Koike <koike@igalia.com>
Cc: jmaloy@redhat.com, davem@davemloft.net, erik.hugne@ericsson.com,
 ying.xue@windriver.com, netdev@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jul 2026 17:49:35 -0300 you wrote:
> cmd->dumpit callback can return a negative errno, causing an infinite
> loop due to the while(len) condition. As the loop never terminates,
> genl_mutex is never released, and other tasks waiting on it starve in D
> state.
> 
> Check dumpit's return value, propagate it and jump to err_out on error.
> 
> [...]

Here is the summary with links:
  - [net] tipc: fix infinite loop in __tipc_nl_compat_dumpit
    https://git.kernel.org/netdev/net/c/22f8aa35964e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


