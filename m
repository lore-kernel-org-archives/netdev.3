Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED74481DD;
	Sat,  7 Mar 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772842207; cv=none; b=pCD72uZpS/T3Fm2hqRfCmJ5/IEx3k2v8YRpmQr/vzzqfu87ogK+mbO5gZ4E+FiGts0x7wx66Dok/zfpD5vIVj+IA7DxknDnAX/VTGBMz0jkm3QvTqimRAQa1o6m4zWnjKJGsxUk+T/9rXkd6iLjrXsv5Ds3SgJdgapBgXNTlDp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772842207; c=relaxed/simple;
	bh=fJbBxaqt0VbTCyRdEyjclQdBLSh5BBS08NZSsIJIAEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gOwwvIM1sHpQMoU9rNpd9woLJ17lNqnmNC/q3aqzfVNiUuTuoFSYq7E00xqqY6w1pgBM67GrxWLATmC9sNGiCkcRliiSzpFtjE66kL7TVMqx1yvLPYr8yo9R6mZx76gjLotcHYK9IDtq6sQcXJ+S/v3I0Vj48vimPA5czD1Yyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMsAYqFH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMsAYqFH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A385C4CEF7;
	Sat,  7 Mar 2026 00:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772842206;
	bh=fJbBxaqt0VbTCyRdEyjclQdBLSh5BBS08NZSsIJIAEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CMsAYqFHxBn6qK5W+V8oIR/2NVACL1QI6NSTzmGl5HhOm2U4F4qM0PeA9dePD+7/P
	 PgnyjOrUKU8cojOJAUmKs1cE+wQvB6DG2b0n/xtAEUS5HKISmWrjvSplYF1Fk91TQT
	 Wlb7YhxISmlNRfG+rZ3UDPPNJ5Mi5rgkkp1Qt6kRWvsFDK3tf+/P1DJ8haEQmO56kN
	 ElCRtVySYaquZuUQcic+R8welBpwWtxGf0RqqFwNbwttrnGRkJ2RBA1HXENk817LTQ
	 sUUDVqeklXULXi0vqLW1R8TDVFHv6ZoXx+aOFWPhAU7U4/bBDjhScx4NURnGzoEMXn
	 q87Agtt1sLfZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030793808200;
	Sat,  7 Mar 2026 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mctp: fix device leak on probe failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177284220580.98994.779227371043557174.git-patchwork-notify@kernel.org>
Date: Sat, 07 Mar 2026 00:10:05 +0000
References: <20260305104549.16110-1-johan@kernel.org>
In-Reply-To: <20260305104549.16110-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 11:45:49 +0100 you wrote:
> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
> 
> This driver takes a reference to the USB device during probe but does
> not to release it on probe failures.
> 
> [...]

Here is the summary with links:
  - net: mctp: fix device leak on probe failure
    https://git.kernel.org/netdev/net/c/224a0d284c3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


