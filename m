Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC1332EAD;
	Sat, 28 Feb 2026 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772247009; cv=none; b=kqjmxHRGxDebHW7Fmigs3kp58eqeEAOXmiy1J/HGf+g9KkXRdN4B9KJbQIN12UTe84gNWTuO807rF1s3EtfvRI87FwY4sgPT2ceY06HUUB5jEqjODIWILzg0YtrHMErzITgfe2IlgpOE3P/dFuG8OXwZyR5W/4kIp2Dx5fJ0550=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772247009; c=relaxed/simple;
	bh=KlFFnao0DuPJ1Fmon/fxu0IpRoKOysu+4lTKUmPoc0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sj7ieKER1heLSTLUFMc9j0o9lhOOed7xAEw5i20eGSCrqhX49VdfhYfvOG+rxp3OnD9lOl2z4NHZXqEvTnbEjSFXii8QTZDfgW/J9ZdHvpRJO3T6G62T2752yRhK9fv46GU1oieUKKelsxhXtdsvGgadOrD8+gYdT7ToO7XtKcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrrLchoa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrrLchoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FCCC116C6;
	Sat, 28 Feb 2026 02:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772247009;
	bh=KlFFnao0DuPJ1Fmon/fxu0IpRoKOysu+4lTKUmPoc0Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BrrLchoaQqwAmz2osT0o7MUOcoGazY3mNJknFtDIOILQBjnmy82/TuD42M05ZuCLO
	 05tuKVxmaDe34H6ksdgf5trrXvWPSuC4AHkVTy5mBpGoWtE1XZWRJP69d2VZ12eBKx
	 8B/OrMVlLCdysNrQcS1TcMxmvMy+6l9pvut9LIzKvQSwqYPD2wtUU6lhF0SUhJwfmD
	 mIbVM5a1uoxRV0yj4t2LO57x/2VMcjc6EqiEE0a9ufY3+gnDv35ZwJQtv301GmZxSi
	 GEUIsK0Ol+zIcV7xUyTacVOb4kk8iPU1qYs9nGisG6APtRGLUlp/2m1MDi6qrVYMAz
	 +7hcLustx1aGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F8939EF96C;
	Sat, 28 Feb 2026 02:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] r8152: Add 2500baseT EEE status/configuration
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224701222.2846847.10778591223233826261.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 02:50:12 +0000
References: <20260224-b4-eee2g5-v2-1-cf5c83df036e@birger-koblitz.de>
In-Reply-To: <20260224-b4-eee2g5-v2-1-cf5c83df036e@birger-koblitz.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, opensource@vdorst.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Feb 2026 18:40:14 +0100 you wrote:
> The r8152 driver supports the RTL8156, which is a 2.5Gbit Ethernet controller for
> USB 3.0, for which support is added for configuring and displaying the EEE
> advertisement status for 2.5GBit connections.
> 
> The patch also corrects the determination of whether EEE is active to include
> the 2.5GBit connection status and make the determination dependent not on the
> desired speed configuration (tp->speed), but on the actual speed used by
> the controller. For consistency, this is corrected also for the RTL8152/3.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] r8152: Add 2500baseT EEE status/configuration support
    https://git.kernel.org/netdev/net-next/c/e8e83b67960c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


