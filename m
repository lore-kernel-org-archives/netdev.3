Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A3535CB91;
	Tue, 26 May 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790804; cv=none; b=oh92av2fNOSDVJK4rmmiKKCmvhzwd8lHJvlH2efcjfGcRUTc26cE1sstnNZFlwGNk9ziCGCbSswCehfCgMdAcK6/okJ6h2jCO/tuQVzHBdVPG+70zp5Wj0hAubNDUOxsTa0awwj6kRlGesKQjQfz15kTMMopnsdvoyezsJiuEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790804; c=relaxed/simple;
	bh=bI7Sg/XtYRr+SEDExyjx48jNmvBoFor6ujuLUUZGEUA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qsA68p2KI/7QAhIEUb/BVCQx68b2R/PXbEeNxr3dAozh0V50DVSPWaPjgTDwJTAOV9jRPinMuJIIrGpCmKkZ4ASgsQ2DIB/X9l9gBE/pGjHK6waeB+BxYeaVMeHcbYJebK68yxLMPe3dNg4YKZ737RJye2Geet7PcTlBkm5JOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fujf/kNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fujf/kNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DD91F000E9;
	Tue, 26 May 2026 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779790803;
	bh=nOF59IeH8mcg4fmrVsTcwnJm767OrXWB9qx9WN9Nu4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fujf/kNdw1WRVDhNzweKdpoqQHZnoN0ISK3mLSmX5frTh+Ks4uSN6DlS3kluFIb5D
	 XVBrooRsn2QYkAyaStyLldXOfUN5riZNbES8htvkOf/U9N8kwkznxQ558n7pkPwqaP
	 q4JsT5sruPw+bv+DNYmfW5MSBbW5r2izZzkgXDLQZAv29DQF1qKPNLB/a86Rlgp4p3
	 Mry1JQOxICCQ3p2fW9fuCMAv5ICOMmjVP6koYFnMoVY2AUxtCD1Q+mv5dhPm7W0Dn0
	 QT7Rt0AJXv8BKPnCSPi+fRjECJuWPwBPC0KHZZcrzyI3NAeJR7Th3FOkn+gD6ZxUJX
	 vZ5UNIuDagV3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56D58380CED3;
	Tue, 26 May 2026 10:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] mv88e6xxx: Cache scratch config3 of 6352
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177979080915.3306056.15944567753850936937.git-patchwork-notify@kernel.org>
Date: Tue, 26 May 2026 10:20:09 +0000
References: <20260521202924.727929-1-fidan.aliyeva.ext@ericsson.com>
In-Reply-To: <20260521202924.727929-1-fidan.aliyeva.ext@ericsson.com>
To: Fidan Aliyeva <fidan.aliyeva.ext@ericsson.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, marek.behun@nic.cz,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 21 May 2026 22:29:20 +0200 you wrote:
> In mv88e6352 scratch register in Global Control 2 set of registers
> returns which port is attached to SERDES. This value is a pin
> strapping value and is set after the switch is released from reset.
> Thus, it can be cached during chip setup instead of reading the
> register everytime when SERDES check is needed.
> 
> The series consist of 4 parts:
> 1. Add new mv88e6352_reset function as ops->reset
> 2. Cache the register value in this reset function
> 3. Refactor mv88e6352_g2_scratch_port_has_serdes to use the cached
> value.
> 4. Remove the locks surrounding mv88e6352_g2_scratch_port_has_serdes.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] mv88e6xxx: Add mv88e6352_reset for 6352 family
    https://git.kernel.org/netdev/net-next/c/f21395a783ff
  - [net-next,v2,2/4] mv88e6xxx: Cache scratch config3 of 6352
    https://git.kernel.org/netdev/net-next/c/948330d99feb
  - [net-next,v2,3/4] mv88e6xxx: Use cached config3 in 6352 has_serdes
    https://git.kernel.org/netdev/net-next/c/da054522e881
  - [net-next,v2,4/4] mv88e6xxx: Remove locks for 6352's has_serdes
    https://git.kernel.org/netdev/net-next/c/e4a9173e38ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


