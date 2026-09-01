Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2EE43C076
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 03:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232277; cv=none; b=O9FZypR+vAQtHdNeMUtU0KCOQtNiiacFaCXX59nOn//selTqYKFhdw4Gyb/gark2wKco58Vx6iNxbFKUc5k7J9f6ywltgm0b+g5QrT6Idx9He7GnRPbWqmPA+BpQtAvOc6AtZ+xYBmom4eFBSIpWnpBOJrW1ApjN3/DpXNIkWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232277; c=relaxed/simple;
	bh=T09jEvX/k+r00Dn3eeUVNZXyDbVstAkC3PNcnsCalQE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KE03kuVYvdTzbAbRJVhJ3grHc0d+5cYgmCiLj4E4vQPK9SDqRGO9/LMANsFmLm3m8dHE2WhCd7ZmMut4t3gxKQY3iJGn3uoHf+ft+utgAGV1O4ialQp9e4b+ct4skk/dUEN0n8KeAGJQP3J2Q/MF0jb9NG/qsbkkQGbOIQpbC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvyzI2Iv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvyzI2Iv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2911F00A3D;
	Tue,  1 Sep 2026 03:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788232276;
	bh=jWmCW7tf5Y2d1lKplCtcPVU6fUliKNjttlI3zVi0OcA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TvyzI2IvmPfGQfY9vQuYh9X5UQW/VMEYy8hqE7oX9hKgDWuRCP68dKkmh0kvi/WF+
	 HkKg3E7EWAgJ3vPtUeXJagX925RPaFDacUbY2LUZcxJIkK1QezJ6ACMov5fRHg4inm
	 cHyD2uloWSQRRaBUDCVk9aCqygOOtb7lTK4rgAy0M4kYExAIPsAo8GLiA92aHmCE1x
	 52bULs/Y3Czo5T+AVoeHP5TFhhDvMrAo+yGTW2j7HPcU8W83rRVKb1VkiMCTobtcNg
	 PamU4Mqe9xJNXOEGVyDFpn04epA9enlUce86qNyI4wqrY+EROidw2bbJ6nIyfeEylT
	 dRHZZTjlbRJ5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198473924A51;
	Tue,  1 Sep 2026 03:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v17] tipc: fix NULL deref in tipc_named_node_up() on
 empty
 publication list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178823221872.912076.7419768888610390771.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 03:10:18 +0000
References: <20260827111418.164957-1-tung.quang.nguyen@est.tech>
In-Reply-To: <20260827111418.164957-1-tung.quang.nguyen@est.tech>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org,
 tipc-discussion@lists.sourceforge.net, xmei5@asu.edu, bestswngs@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Aug 2026 18:13:46 +0700 you wrote:
> User-space applications can bind a large number of service addresses to
> one or more sockets. Each binding of a local-scope service address inserts
> one entry (publication) into the TIPC name table. If the number of these
> publications exceeds TIPC_MAX_PUBL (65535), protocol service types
> (such as node state and link state) are no longer inserted into the name
> table. This causes two issues:
> 
> [...]

Here is the summary with links:
  - [net,v17] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
    https://git.kernel.org/netdev/net/c/b3b76e9f4f24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


