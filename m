Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C323BD06;
	Tue, 22 Sep 2026 00:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037075; cv=none; b=Skc8WMZSRzP1tpaUtq3m/ahpst2ViP3QXZy92PBhvJfKyxA9wWS6qKPY2/XtcooT353idUyrtrkQmwk5uKvR7fN/IRK0gYSz9paxli1BJ0vH/HW33M716NENMP3tL1v6Cvx4PLlB8GfWK9BDACUn/eup0s82y3mqrrsLdob30to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037075; c=relaxed/simple;
	bh=OMJquurHXLJwZYaPd8ZYPrU06JfIi+Se3J1wkrkUJcc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U8nFS8C/JlXB6pQt0XU40vJBSZU+VIKpMTykvCGmQxwXPTEpNF2cf5mE+edACxqrv1aFQV67eJ+71gCKjk3/SvO39sQgbclK2B7HJ9RkhmjiYMTwGJMHMK4ZAwjBOD64aNnItmw/47zNCh+MYOFjJckLPYFmAmkadDJFSx7Z6VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1IgHKR5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1IgHKR5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA611F000FF;
	Tue, 22 Sep 2026 00:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790037073;
	bh=TVqc+O/mGmKmltC5O7TAPelOBoirFBx9NXAmRz0SCIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e1IgHKR5N47AT55iiXVJxqrMBu+vsdADJOCQjiXRQWBUO6W5Mx+EAoG22LaHLJ7rF
	 o4+l/TmIY4BWA6QwGw2wjxIOesPLtvrlLqgQWlOSvs/D+I7kxFOQxBOdA7AkDkv3jj
	 G2xlkKaZ0+OSZnI05WnXTgACAlZpxh6grfvpdKXrC8L6lS4jO/MQUBXIRKbjiVb+Pm
	 c2HvsV2HQzSMBtAaDJeKi3Lu0JW/1SN2iPUS7qs9Q+q6zUVQL3h4OdOL9DazrGSKFf
	 n0FQbX9aH3JNjw4MluFQWtB46KEUZBNPMcpLU0SQvhFIz0gWJW6lzAozf0iydEuiRA
	 S2pTe/Q4/3B9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568DD3930203;
	Tue, 22 Sep 2026 00:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: use exact lookup for reference sync pin id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003700515.3305732.7157422558298107250.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 00:30:05 +0000
References: <20260917143736.526221-1-ivecera@redhat.com>
In-Reply-To: <20260917143736.526221-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, kuba@kernel.org,
 przemyslaw.kitszel@intel.com, milena.olech@intel.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 16:37:36 +0200 you wrote:
> dpll_pin_ref_sync_state_set() looks up the reference sync pin in the
> pin->ref_sync_pins xarray, which is keyed by the sync pin's id (see
> dpll_pin_ref_sync_pair_add() using xa_insert() with ref_sync_pin->id).
> The pin id to operate on is supplied by userspace via DPLL_A_PIN_ID.
> 
> The lookup however used xa_find() with a ULONG_MAX limit, which returns
> the first present entry with an index greater than or equal to the
> requested id, not the entry stored exactly at that id. If userspace
> passes an id that is not paired as a reference sync pin, but another
> pin with a higher id is present in the xarray, xa_find() silently
> returns that wrong pin and the subsequent ref_sync_set() operates on
> it. The request only fails when the given id is larger than every
> present key.
> 
> [...]

Here is the summary with links:
  - [net] dpll: use exact lookup for reference sync pin id
    https://git.kernel.org/netdev/net/c/7cce782d8327

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


