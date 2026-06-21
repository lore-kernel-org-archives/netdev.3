Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0F337187F;
	Sun, 21 Jun 2026 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782081617; cv=none; b=LWFmyTcqz6QA60UOC75B5BSaZSJB+jb09DcY8sHoh2fC72q2j/J5ckXQefSltN5Wr/3l7BFubfu54Lng8gxSmlQtx3mixPgo+f6PumgMwSPozVexYtFSJtK01HM71nKI0FLH99dxfxs18cmio1zTHhOIscjkOD1sZygieoOO4SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782081617; c=relaxed/simple;
	bh=7A4DIsiFEuB5jfv+cvpgTkbVF+aYMx6DSfHFrzSZIxk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Of1ipFxKBbdJIChIIEb4Rg9Tx5B+SCz6WThexSg5/Sx+eo9+aFSYu95kudJwfHLcYsJPKFj6I3dX4I5edhXyrVVESKX19MrJYX1oUqU7a0iQvEVh4rv0ZjqPRWabE4XYBi74+9F70EinsoSVFrsCpIbTqrDZtVEI5edq1dXIXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzUb2zcz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzUb2zcz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AD31F000E9;
	Sun, 21 Jun 2026 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782081615;
	bh=nDZYvBXBCjzfwzR49Vh9/4AGTfR1QgBydjvIT0HKAVE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jzUb2zcz60L7oVqfR8Ljdg5aZCriFf1pdDPNh8849P0tPSv1Nf4E1nUgufSErw5Du
	 6qRHRgAt9gY52tTqnnH18ZgFaeoSrQajn/Sxm5X9BqiyB+2U4gAXQblHzENMhGyTZF
	 5X82k4iv3+fyJBZKmHbTTYhjTgspThoqXeYz4nYaFopZo35GIxjvuuvdcbmxmQx/pQ
	 WicdjyLvi7XATKsaRY6y8JbSpZMeixyovVU0Upyx2Aj+vBrCCIIw2ZL23P2P5N6uQa
	 gxYmhrkk55dKP8uuOqMrNjTjAEKK+kMSXqvsy+A9Rp3hjO7ohSQFmDIKazLHj4LsdC
	 JopuddPvlDTYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A203AAA6ED;
	Sun, 21 Jun 2026 22:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] dpaa2-switch: reject VLAN uppers while bridged
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178208160655.527052.3318660739129647835.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:40:06 +0000
References: <20260618092813.432535-1-ioana.ciornei@nxp.com>
In-Reply-To: <20260618092813.432535-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 f.fainelli@gmail.com, vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 12:28:11 +0300 you wrote:
> The dpaa2-switch driver does not support VLAN uppers on its ports while
> they are bridged. The check which should have prevented a port with a
> VLAN upper to join bridge was poorly refactored and didn't actually
> return an error. Patch 2/2 fixes that.
> 
> On the other hand, the driver didn't reject the addition of a VLAN upper
> while bridged. Patch 1/2 fixes that.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] dpaa2-switch: do not accept VLAN uppers while bridged
    https://git.kernel.org/netdev/net/c/d07d80b6a129
  - [net,v2,2/2] dpaa2-switch: fix VLAN upper check not rejecting bridge join
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


