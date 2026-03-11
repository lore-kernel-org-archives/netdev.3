Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F410145A1F;
	Wed, 11 Mar 2026 03:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198031; cv=none; b=rFfheV599geILsnmI9E1yKIej5dvaIMnG1IG9e73/6a0Ubu1PSRh0Vfr5Em8uA7aCYaXHrgiCTZPfc5MvgvXU36kcfcod1rexTH2gjWexeLiO+FmqmaBENzfycVho427oUYoQFfbPYKAZc4+qMDQFECBz3vitwlK82euy3roLbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198031; c=relaxed/simple;
	bh=hNi3uev7bsTl1AWa5hKkQAmSV6K/S8aDBqJ9gjCIKII=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eObVjsof1ky6GahJCqyfJlwnD//lu7VAZpAbIs6dYMT9ix8m3xHqqKG6Bn5jdJl31Pj/zNMSF1fe2yefK8x6/22swTtfhmEQMlM+0x33X+Uc3F5N08PUUEgcu2KxkkMuIGouGOGSlJCRdFuFg117Sfk6bWFQJ09GShTpMS3m2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCWwG7YK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCWwG7YK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBECC19423;
	Wed, 11 Mar 2026 03:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773198030;
	bh=hNi3uev7bsTl1AWa5hKkQAmSV6K/S8aDBqJ9gjCIKII=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QCWwG7YK8G0Ncec3sH+7ZKPCoJCnZA+x0R1hZ+Rjli8igo0/8IJwIYsUTLpf2KkOD
	 +fA6c7I1NRERjofwB4Lv2BhSj/4V4XU5e9eockFMAliDIHnosjdfX5w/lejZM4adtb
	 lMSCRvReUyKoP3TETJi+IGTMJtLJloMl9T3nYCa4Z0XjYB5OnyDjMwd3gkTRyOjaK6
	 btL3VA+ezA4Zl75xgT/C6Zk4PVf+2CDvtINodPGEf3E3a5pF16n+dqG4vzxyjTn77l
	 fzGZAoO12+Ki3J1dkKomZcqakeD7VQS9C6Z4ndUxVGtFMcCfBZCzvFhST0bs0f3Rb/
	 /yhON3Fp+QUbw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDEF3808200;
	Wed, 11 Mar 2026 03:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: mdio: mvusb: drop redundant device reference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319802729.3019253.16685225800132018422.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 03:00:27 +0000
References: <20260309082641.15574-1-johan@kernel.org>
In-Reply-To: <20260309082641.15574-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: tobias@waldekranz.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Mar 2026 09:26:41 +0100 you wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
> 
> [...]

Here is the summary with links:
  - [v2] net: mdio: mvusb: drop redundant device reference
    https://git.kernel.org/netdev/net-next/c/1a6ca6497a40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


