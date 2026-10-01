Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D233470EA8
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896209; cv=none; b=LQD83vYzdr5DgQ5r7wYAzJaImyBH+50c951SA3peks7IQA9OnSo1HHvyrG35MdBNxcfCTSd/KQmVVwGbKdDksbRLI/rQ0cGclnkdbyFiipDbZ4+tQRZoXZgp2nLVESUreBilBQZ0wIcIXpCgywRZRoCjYfapMts4gxku+M1qvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896209; c=relaxed/simple;
	bh=bLsbL1XkVswQie1vxmmiYjTxSco6eYYDyrQ2drvERUE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EutfnM4THjDmHM0V0NbJkwWJI02glkBlqyecx5sh23m81JKGsMQELgRuIU9xJoOIefr5UE6h/T/cqYNgua5YOITceiGZq+AXBDFXEr1O2Op+E+Z6AdWaIp0gMd8xb4Sz0dSRTBY7W3P1HHBBmVtlApGCocW1mD2IPqu9d+UV804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgD5e6C3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgD5e6C3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080911F000FF;
	Thu,  1 Oct 2026 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790896208;
	bh=jYjG3jjmQl7MkXQdcDTd4nQc+AvoJ033O9MYPxZmAqE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WgD5e6C37s5AOSTRNSwUPDg4UklkoJc5VFAGqPTsJchaspU3XnVi78uUvEE0XXwLb
	 RUooSpv8ZS1bt4YW3B/G/q/sEISARU7MdpV5hNzzZmsdRSUZT8tAurhi5dyu6Lt4N4
	 inH1GxzLq6yUZ9xRHHLCpzj8dGhEXmggaS0NX3wN0mnOJcOe8H80F5Awp7LEgmxg/t
	 YZzJvTaLutMB579/LjNBh2dNo0n4+wT81Pp3z36LnLSHoojHhtujrzav1uO153HJ+O
	 0yPE5G6WtqLw4kN+nzb45tXkvt1QZlm2MyfXnao8fMkOXRc0j1lYlnJnnrvcmFesU/
	 jfuAYSZS1J3Tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1619381197C;
	Thu,  1 Oct 2026 23:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] ibmveth: fix open-fail unwind after LAN
 registration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179089620655.3133874.6118634077996472369.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 23:10:06 +0000
References: <cover.1790357373.git.mmc@linux.ibm.com>
In-Reply-To: <cover.1790357373.git.mmc@linux.ibm.com>
To: mingming cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
 bjking1@linux.ibm.com, shaik.abdulla1@ibm.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 11:05:28 -0700 you wrote:
> Hi,
> 
> ibmveth_open() has two independent unwind holes after the logical LAN
> is set up. Neither needs the MQ RX series. This posting is against
> current net.git.
> 
> Patch 1 issues h_free_logical_lan() on every post-register failure.
> A pool allocation failure jumped to out_free_buffer_pools without
> the hypercall, so PHYP still owned the buffer-list page when it was
> unmapped. request_irq() failure already issued H_FREE before taking
> the same label.
> 
> [...]

Here is the summary with links:
  - [net,1/2] ibmveth: h_free logical LAN on open-fail after register
    https://git.kernel.org/netdev/net/c/af0524bf4ce1
  - [net,2/2] ibmveth: fix TX LTB and filter unwind on open-fail
    https://git.kernel.org/netdev/net/c/84bec0bf0352

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


