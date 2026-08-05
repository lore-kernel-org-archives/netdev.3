Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A37B3D9DAA
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 23:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785973876; cv=none; b=mMRQfL6Ori5IAzZytzh6y7NqOXQ4uG4b7z0M1i/VjugabqmeBu3a2YI2v7VBpm/eTVz/EJKPIjrzc6sZw0KOv3m28Y5jWbKXwYgOswYemeZdV7cFPP1ED2ZPLOR++Z0HZ6EwRSLj0IwdU0xkjx7x2sJQ66RhuQE7JXKcJ83vsFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785973876; c=relaxed/simple;
	bh=9Wq/nYgHCfajGNgyeER1VTVyL1Y6C/gzdIbB3oN9LCk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VTd216fTVvzWjb/ZmOAuaC6iqqN0zchNB591KsiKpylSceCK2BmJSGwTjpGuWupHZcNAE6OxY7d9ouMsEQzYXszuVCfwg/mEXZLF43F9XROnun4mj98lMv0ydxsnWMsVqV8O05jXHFy3mYn1ZgC3RtNd6/ARkTbMnKi+kOhkXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPLG0+6Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPLG0+6Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A27E71F00A3A;
	Wed,  5 Aug 2026 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785973874;
	bh=2VGI/ACrhcxiKqiD4wr3+aYFOBFjZ6UPEh7IWgvTeOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KPLG0+6ZM61wa16TK2b5fDWBqpmnyCM4iIBe1aM95nIA+uNJQxzHD9WLskwZ+UFne
	 24OJnX46AlPNC/F9+XX7k99WT5auiwN6hwrLNWCqJh6Ua6O0kOdbEzswP9zo3coV/h
	 4riRReDwIzvI7k5BvfO6diI+OskaNbnCq6FO2CgVZg4V8WR2avaubiKfke8ICf2to9
	 8dX2OrUbh+44ykHcBS0PyX8wwHAc9+3PQvf/3x/4L//N/E1bTB54ZtRqnC7wHDGPwh
	 UgjBx3ImMFbwLtrjj7we3MX+Zkrx3M6Ez3+iSsFUR08faoz9yQo+2ErJYSYDJKV7cK
	 TeQ4UxumpY6qA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A76392FFD8;
	Wed,  5 Aug 2026 23:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] devlink: Expose external flag for PCI SF ports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178597383413.567483.16197150306455051560.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 23:50:34 +0000
References: <20260803090012.257242-1-shayd@nvidia.com>
In-Reply-To: <20260803090012.257242-1-shayd@nvidia.com>
To: Shay Drory <shayd@nvidia.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org, parav@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Aug 2026 12:00:12 +0300 you wrote:
> The external flag is part of the PCI SF port attributes, but unlike the
> PCI PF and PCI VF flavours it was never filled into the port dump, so
> userspace could not query it directly.
> 
> Reporting of the external flag was missed for SF ports. Hence, put
> DEVLINK_ATTR_PORT_EXTERNAL for the PCI SF flavour as well, matching what
> PCI PF and PCI VF ports already report.
> 
> [...]

Here is the summary with links:
  - [net] devlink: Expose external flag for PCI SF ports
    https://git.kernel.org/netdev/net-next/c/cb59bfd419d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


