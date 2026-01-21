Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33E346FC4;
	Wed, 21 Jan 2026 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963220; cv=none; b=sfMiiy0aanQmt9dMOJoBYhy+mOnBvXDbbEfQvgSiheq/QIeCSCkAjA0fNpemNbnm5pXo4c/pUmxW2rq1oTS3WwjfuxPe3ovp1ICCioTgKnSbLgZCjjQVDzICihpeT3WvFQZan8kgjfArEn3YoXEAYttjTbTbNfxlkRpwslWJxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963220; c=relaxed/simple;
	bh=hSiKA5SNj4F1zAh+ap48O5K+GSmIzww7tovpuDUUam8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XitYa870kt50VRQcAVFR/HZdYLJO6Yj6kkpHyx1Y2V5+i8v9KipkhxPYdZU4TE9b+Iakr+tzsCu9+mZpoEMq0n1W/uH//EkcTn9Ii9OJUQTCofDWu3E4ocI8jMltSv1CWh460GKCjOkwTDHZADGQzfIQrAHDO+tKB7X1aD4q8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br7uP+FX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br7uP+FX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38564C16AAE;
	Wed, 21 Jan 2026 02:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768963220;
	bh=hSiKA5SNj4F1zAh+ap48O5K+GSmIzww7tovpuDUUam8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=br7uP+FXlcnZ2t/3aP2i/nhaXYcvI75aWgAuWQ69G+fFw4Wj2WQe2ilkgOj5YThY7
	 xheUP0Q2fOxOnws7glNjLN/U8AK5kjBsnrrdEYok7/LgVgg9XEKbwjavYrBHi7PLTa
	 dh2uzmEntzK0ddn2RthQXoXiLCq7rZFQNNHUwoHqlpuf4dvlbGKhzzQ/bV2ryPh13b
	 1vIui2ZEAwots09gMpJ3kwRq6+6kW/plogWZJdrxuMQSUmJyIpCRk3mBzRVJet3T8K
	 k6xayhDUvwa20nYSMp59+R37cguBMn+J5px+XawE5HGAkCdbsZ++Iip8xviG+BwtOg
	 ug4iGDajbn6lQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8CBB380820D;
	Wed, 21 Jan 2026 02:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] be2net: fix data race in be_get_new_eqd
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176896321735.699622.10561550138317146229.git-patchwork-notify@kernel.org>
Date: Wed, 21 Jan 2026 02:40:17 +0000
References: <20260119153440.1440578-1-mmyangfl@gmail.com>
In-Reply-To: <20260119153440.1440578-1-mmyangfl@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sathya.perla@avagotech.com,
 padmanabh.ratnakar@avagotech.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Jan 2026 23:34:36 +0800 you wrote:
> In be_get_new_eqd(), statistics of pkts, protected by u64_stats_sync, are
> read and accumulated in ignorance of possible u64_stats_fetch_retry()
> events. Before the commit in question, these statistics were retrieved
> one by one directly from queues. Fix this by reading them into temporary
> variables first.
> 
> Fixes: 209477704187 ("be2net: set interrupt moderation for Skyhawk-R using EQ-DB")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] be2net: fix data race in be_get_new_eqd
    https://git.kernel.org/netdev/net/c/302e5b481caa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


