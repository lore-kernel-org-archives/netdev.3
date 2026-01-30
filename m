Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD91A294;
	Fri, 30 Jan 2026 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741417; cv=none; b=mNxQYBJESSNdDrIYR3dPc2utwzbiPsqe0JsYM8TjoAB9d+mYNyX3otTQIEJEfejCFTRMZnPqhrQMnmRoBNiUmtOtD9ccRr2ZycbYBC/DKTehUnkorTadt35V4Z9dpP4YtSsPbq8Ap+n2281eS48/5VFI85/n/NgNVLtn/I3nGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741417; c=relaxed/simple;
	bh=q0D6TE57sJj4q7yKjU4o4j5xqATZKwnRx7BCLgT7rzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VVmPsb1jtSEb4iZafS3SxJJ1+9GO9RhZmPa46oebJNMhh/I9Clpjof30z9XjecUgpzM2CMSDypIXqyIJ/sT/wIbrDVjERpvjYhJ3Iw2vQ7e9LFBdBH+XFXKT3cguPllyV5MujzAoy7lIiMQOglEOdzXGPGV9zUf4mAt8MOQmgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmq5FmN4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmq5FmN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22793C4CEF7;
	Fri, 30 Jan 2026 02:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741417;
	bh=q0D6TE57sJj4q7yKjU4o4j5xqATZKwnRx7BCLgT7rzQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mmq5FmN4qmZQI/VlloHNKv8lS69osQwn/FGirB6JrjlAeHQumE1lbyOtNqR2sqHgd
	 oxOdIAicmLZUjnyq/J52UCyWsUgv1KeLbc4hmT4xgEqUU5PiCUSyVi8JsRgQw3x5H6
	 35QsLmDof7Wmnkzg/IW+QoWQXtGlhyEzjCbvlpl8siiwc5j88AU19RFhUFtUxDJjjN
	 4DQorHRUTUwX/k/sd9kv9o+Ta84UF9TOhTTrTT1fECiNbPxE2ud+f5A+XI66psMu/O
	 xrP2YzapDnu9+wZU5M1Xfe8cPs1gnDt9J8rW63C9dKPnjrvfQUf+eYHK8fHCrVx8h2
	 HLEjyUQfjFsqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11ACD380CEE0;
	Fri, 30 Jan 2026 02:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dpaa2-switch: prevent ZERO_SIZE_PTR dereference when
 num_ifs is zero
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176974140986.3149010.13987469540887646258.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jan 2026 02:50:09 +0000
References: 
 <SYBPR01MB7881BEABA8DA896947962470AF91A@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: 
 <SYBPR01MB7881BEABA8DA896947962470AF91A@SYBPR01MB7881.ausprd01.prod.outlook.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: ioana.ciornei@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, danisjiang@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 16:07:34 +0800 you wrote:
> The driver allocates arrays for ports, FDBs, and filter blocks using
> kcalloc() with ethsw->sw_attr.num_ifs as the element count. When the
> device reports zero interfaces (either due to hardware configuration
> or firmware issues), kcalloc(0, ...) returns ZERO_SIZE_PTR (0x10)
> instead of NULL.
> 
> Later in dpaa2_switch_probe(), the NAPI initialization unconditionally
> accesses ethsw->ports[0]->netdev, which attempts to dereference
> ZERO_SIZE_PTR (address 0x10), resulting in a kernel panic.
> 
> [...]

Here is the summary with links:
  - dpaa2-switch: prevent ZERO_SIZE_PTR dereference when num_ifs is zero
    https://git.kernel.org/netdev/net/c/ed48a84a72fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


