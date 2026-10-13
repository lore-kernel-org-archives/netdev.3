Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A7747FAEA;
	Tue, 13 Oct 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885607; cv=none; b=Sat88dh+kAga1lxjjgwCt5a8j8GQ2I/srdARVVv9iFaq9Dp/jeL8lwbwzg+qDxGP2SXIIJE/Obs4/lTbR3RP4VA1hkNb6vryAQjDiWkSE7c9CH9t1mq3rN7LeQI349WFO+57PizsV6WvUSnDmb/bkmWiRMVIFGq8zVA80E95YCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885607; c=relaxed/simple;
	bh=FTZIr2i0l4wxqJrUCquDAqHAGPvauxRfgMp8+C5lgFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pYdEMmRl4lkh/Ggzd5kKr+Sn9ULSZyrSlvPelXJq+5q6rG00xaXp5F8TvsFNlPCojj8Yz6sFqwAyR7V5gOryMFYSQg8STh9L5Md1ldWlyyO6btDxdj9jppr6NNiP6kwfjpo/jQxLaWUGT0T9ZusUImHyVz1rIYY3ucSfnUAKbdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i15d7lKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i15d7lKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488AC1F00893;
	Tue, 13 Oct 2026 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885606;
	bh=uxadpyM7ySOMAzLP54+BYp9FbHnqdBACwT1SKz0Wfck=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i15d7lKww0JPBmMKGWMEcQJL+CUKlUwLKxlru56zNRZTKyZo8iVw0GOvTHZU0ZI5E
	 YZPFeNXtivnbxH1FY1gusioDBEQp/KoALWYgImpoxRGRBmfN8SzXin7pO1EM71aERd
	 VyrVDzJ1Rh+I1afS8hTkAE5cgFeUTx+C5kYlPJgfNYkGcGlROTN2cxw7KVAPKlINhB
	 Qex1rb8X6lvUBpJaqDyrlnMEGAo+cT9LUXzE1emSKotuCwck1JHCI8IU6xtbW96iMy
	 PNPiwMp7ttzaCggMIM8WwCVmJfThfTlLDiGO91ofdFwq0mUYqbpmjjJGJ8ajo4I1Bq
	 UQxi/DR58hs8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2A63926662;
	Tue, 13 Oct 2026 10:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bnge: skip dev_addr when building the VNIC unicast
 list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179188560476.183954.16230716721652068829.git-patchwork-notify@kernel.org>
Date: Tue, 13 Oct 2026 10:00:04 +0000
References: <20261006141928.1432927-1-vikas.gupta@broadcom.com>
In-Reply-To: <20261006141928.1432927-1-vikas.gupta@broadcom.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 dharmender.garg@broadcom.com, ajit.khaparde@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  6 Oct 2026 19:49:28 +0530 you wrote:
> The default VNIC programs the device's MAC as L2 filter 0 in
> bnge_init_chip() via bnge_hwrm_set_vnic_filter(bn, 0, 0, dev_addr).
> bnge_cfg_rx_mode() then walks dev->uc and programs each unicast
> address as a further L2 filter, without excluding dev_addr.
> 
> Skip dev_addr when building uc_list, since it is already installed as
> filter 0. As dev_addr now takes neither a uc_list slot nor an
> l2_filters[] slot, count only the non-dev_addr entries for the
> uc_list overflow check too, otherwise an input such as
> {dev_addr, A, B, C} would needlessly fall back to promiscuous mode
> even though A, B and C fit in exact-match filters.
> bnge_uc_list_updated() applies the same skip and count so the
> change detection stays consistent and does not loop.
> 
> [...]

Here is the summary with links:
  - [net] bnge: skip dev_addr when building the VNIC unicast list
    https://git.kernel.org/netdev/net-next/c/0b3fc7fe6f3f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


