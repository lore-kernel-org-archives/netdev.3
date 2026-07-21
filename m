Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8D41A683A
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664041; cv=none; b=EEFEHcknCLJBegcyc2DFynXQYyKQY4T9hw0jqFnSciQQBKLeZLdN8VqEA7t49TFO5bQhEDNEUt6D6iyJ+UBATvci3DLA17I/E13X6csz1IGQ5cDp/S3usHtmN07sz+5Uc2FXAdHWj1pg/4gueqMbwT0kV0NrmzpoHiBM1/DtD90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664041; c=relaxed/simple;
	bh=oQaKKjaHJEo5nioXXjeR6edfmRhhz4kujh86Ob+1ygo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dmdrIePR7tcztPH1GakN5PCKf4wIq3JcjmDDjvS0cUnEl5Gr58dpGNjN/W40VHxD9N2T5fwhLEUW0Do6v+F2joElPYi23Knl2tsXkOQumpUnrsgHVcKBUh7ryA42m+1vHDAMM3OXjmnSprTXWMvCDCMM2/5NjZAZ8wVgQAl2Utg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOUhtxFz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOUhtxFz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7621F00A3A;
	Tue, 21 Jul 2026 20:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784664039;
	bh=57NiZKoHWfbe+AmBIymKlYbXZ/fZagKBojr9b8t7wLA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VOUhtxFz/6mD4EpBo7IrpRRLznsgOaH3GnBSKEQc3ytauvbYxp4R6fgOR/aEXHaXU
	 QMBLJbz3Pp8VKqn1sDd+F2yP1BjQzrjsjn0wrPBznRs8M0ZCtYXcU+fa0p1A8iQ70v
	 GlSBdNpEh//JM3/Nk/Z2qbKCgdxiL6BEAmgcX/h8KBMrULB7MC4oj24YIaxvowWe3i
	 /zZmVoSiNm2TZpYpf/erOyCLhjFbgPDdFVdncoyNs2th6xTyApUIZHPQe9CEQVKrMB
	 i93laPVavzDkIXgT3XgycxBWlDYBQrAP6BB57kKjYMzKf7zlXAgJUpAzJN+VwVSsWW
	 NbRrzw/GjCv7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A853926242;
	Tue, 21 Jul 2026 20:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pds_core: order completion reads after the ownership
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466400914.1013514.17681312238621866638.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 20:00:09 +0000
References: <20260714204145.1782390-1-nikhil.rao@amd.com>
In-Reply-To: <20260714204145.1782390-1-nikhil.rao@amd.com>
To: Nikhil P. Rao <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jul 2026 20:41:45 +0000 you wrote:
> pdsc_process_adminq() and pdsc_process_notifyq() decide a completion is
> valid from its ownership field - the color bit for the adminq, the event
> id for the notifyq - then read the rest of the descriptor, with no
> barrier in between.
> 
> On a weakly ordered architecture the CPU may read the payload first. Add
> dma_rmb() between the ownership read and the payload reads.
> 
> [...]

Here is the summary with links:
  - [net] pds_core: order completion reads after the ownership check
    https://git.kernel.org/netdev/net/c/dd6b1cc748cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


