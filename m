Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F2411A1A
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429675; cv=none; b=pShhmoQ8HqyS6srdhiXEg3PVkzfJbIHBytqeeD03CdwzCkF4KQkWuoly/dytCq1Lr2HG86GQzsSQxd0n7o5V7+/tOFXp49caO+l+b5Sd5n6HLaQR1Z/vWKoeIQIIKoSqp2iMzwpMmwOFJMuteTxrEl11tEyT5WjVRvMdp3WuFBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429675; c=relaxed/simple;
	bh=K+FSVfZkbiHydi9qCJP6r8SIt1xBv4wEkltsInKzDT8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nrlB9jQzZpDAlu6/BErPsxbdmIXQ2AWbwYbyxyHT9Eu1lyJc+TRhqwDaP8OisU2GLx+eBShSIcu0uJcXrN6fPE9lvd17W64o2uawATfCBVuoSa9WZtr3IcaGajvHqtkMDxY7Xqv2CSTbWHVeCt22vmRN2AZX/xgXeT+hb2/92Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmhcmDmf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmhcmDmf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FD11F000E9;
	Thu,  3 Sep 2026 10:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788429673;
	bh=YcCFwQoxPWG//NUmWizcKUC93w3Cy0U+kHb0NN+ifTs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TmhcmDmfacbJRDzbgWEBG/J/QaZRQ49iRbvbMPIVAjINZdgFLIHVw4FrPQw7z6oju
	 At1pfYrha75cPOPf70rgIK7cTTLmnxp/oz5A1OIRVRGfGw9e0kwbIoq058zkFT1WsI
	 KUODjXmVabF2y4fe6nt/ZxHw01RMkkfXtwcoub0m2M8pP8fyuY4RTyev9LCGGy34Wd
	 yaho15QWGdIM7vVrFlEPFo6I+zYAciTHF6SFfWz9SGZR0JrnFxmProlBebRIVhBgNH
	 ktBlLT5tsGAnUkq5+6MrQyr2EzaetJvHjrsPoIaWg19xlh6O3MEDO1VEUORXhn4ogW
	 U4wWtkAnDXKzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5696F3811965;
	Thu,  3 Sep 2026 10:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2: use dev_err_probe() for deferred
 probe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178842961514.3239309.11509161427420077146.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 10:00:15 +0000
References: <20260901-octeontx2-dev-err-probe-v1-1-1b5e1affb994@nokia.com>
In-Reply-To: <20260901-octeontx2-dev-err-probe-v1-1-1b5e1affb994@nokia.com>
To: Juuso Rinta <juuso.rinta@nokia.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 01 Sep 2026 08:17:36 +0300 you wrote:
> The PF and VF drivers warn and return -EPROBE_DEFER when the AF has
> not programmed the RVUM revision or does not answer the mailbox READY
> message. That is expected until rvu_af has finished initializing, so
> the warning is repeated on every deferred retry.
> 
> Use dev_err_probe() instead of dev_warn() so the expected deferral is
> not printed at warning level. -EPROBE_DEFER is logged at debug level
> and the reason is recorded in devices_deferred.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2: use dev_err_probe() for deferred probe
    https://git.kernel.org/netdev/net-next/c/e048669dccec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


