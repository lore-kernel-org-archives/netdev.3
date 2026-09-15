Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2713D1CB2;
	Tue, 15 Sep 2026 02:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789439477; cv=none; b=bZLDeG2M/Iz9IOrn2b+pUVjcprrbXuwo0aWKVkg7eto2+ZgTV0quxoXFVPfOPsBbguSmSD2BAqNl6rjBP2mH2MH54qhxZkLdwkBT4M10reAZ1p7FTOIqyI0sLmZKF+Wdt0IEUzQ1TrCKRb6rL85DqXjAbARO0riaigJkJoeq0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789439477; c=relaxed/simple;
	bh=9WIpQDhvLf3nwS1jST1IagaOL+GBiKItu3KAVEl520M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fwjQB7bDLaY/xz0YxR+nPsO1ny40J9t8lLFQLPyra/vdq3uY+v0paMhxcThsXm7+dnp3tQytqZuUEQ1RXAA3/x6S3hEqOP9BhrGBgnXm/G7ElE2JuRaWjz1Bu0O5lp7Vlvwj/AbfKOk7dDQrAWx8W7jvM8JkweW46CItIXQ2rcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khpF0eRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khpF0eRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F121F00893;
	Tue, 15 Sep 2026 02:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789439475;
	bh=U4Lf71o0gdm+jtiadJ0be5u30vtE4J1iH7rzjQT5DJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=khpF0eRHDrmLGFyXf+l8YjbH1r8Ejf6X5KedZmdnS7XM42a2hfOqCI5P6f/VFZt6G
	 sRn6d8SsBUWTIIt41g/m0hgygiCh8tYnUlnB0cZ24IHugpciVtz3Q9nbXqIkKgJvCP
	 v8Mj4ZIQqaL/Wb9PpTC3b91dBkBoXP4r1KTbuedXYyT7debk9FErgSgOoxyUM/zrzT
	 oSAppBvW9gd/djmIGqQt4BXahElSuTk9A/66VQK90Qp5B9WcaSfXkJsQU+JunYTdYV
	 EF2ekHokiaqS0ljgLS/gLiEs7q4VoL29zuFepIZwuqetVex7n5V1XcTaLZK+U6h4xp
	 Bytd2w8rRGWeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A7C3924FFE;
	Tue, 15 Sep 2026 02:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] octeontx2-af: consolidate RVU AFVF device id
 definitions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178943941013.1322157.7401389527831061083.git-patchwork-notify@kernel.org>
Date: Tue, 15 Sep 2026 02:30:10 +0000
References: <20260910104102.590989-1-yijiangshan@kylinos.cn>
In-Reply-To: <20260910104102.590989-1-yijiangshan@kylinos.cn>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: sgoutham@marvell.com, rkannoth@marvell.com, gakula@marvell.com,
 sbhatta@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 13667453960@163.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Sep 2026 18:41:02 +0800 you wrote:
> commit f695390ea639 ("octeontx2-af: Fix limiting SRIOV VF count logic")
> added a local PCI_DEVID_OCTEONTX2_RVU_AFVF define in rvu.c, although
> the same value was already defined twice elsewhere: as RVU_LBK_VF_DEVID
> in af/rvu.h and as PCI_DEVID_OCTEONTX2_RVU_AFVF in nic/otx2_common.h.
> 
> Move the definition into the "PCI device IDs" block in af/rvu.h, rename
> RVU_LBK_VF_DEVID to match the PCI_DEVID_* naming convention of its
> peers, and drop the redundant copies in rvu.c and nic/otx2_common.h,
> the latter already including <rvu.h> through the af include path.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeontx2-af: consolidate RVU AFVF device id definitions
    https://git.kernel.org/netdev/net-next/c/ce71c433395e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


