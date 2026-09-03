Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639A47A88F
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430266; cv=none; b=L5vTVAdcdEuzKe0kCO0KyizxOtqCeJ/7B73qZ3I3Lng4bCxsY1gO7e6PQEotZlJ/x4UyAZT09VreEAxrKyY2hSfi9Ap/gDNkDYtLDn6oZM8lAQt1BWBJCsnXzUR3ZnyMxyoRue//dD6Pgo3z37UKkazIQArMpCauKi3TQJN6jG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430266; c=relaxed/simple;
	bh=I+4CzoKYXPF3sW0dOqh/p/U0M5jP7PLCOzJg5schpF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=swG+IRUp1jxdIrJZGjFIi4EaJko0M83Qj7UmW6OxF7sSIzDQRGRPEk4t5ZCvpMTvoXTA+zHXuBzoc9zPn0zHgsljszdENVc+Ks3Ac66xY50cR6sD9cLXk4lFdGPPTpuHo5cWgD1LR+qoH01PsUeS8VnCG73Mne2EQDDrgawDdYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG5l4Wr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG5l4Wr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A21D1F000E9;
	Thu,  3 Sep 2026 10:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788430265;
	bh=WGYoeDmiTIlfdYj/SmCDvoBmEjqLBYvUYlicIdwKfgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RG5l4Wr43OAfnf70QcrrsdqVdV1oDRbVe+GRSrmN4DU6pkevZFSxBmI2Mr7gM+0Qx
	 kCM6EKyqQigs3Z3Q7rU6wzt2fkCYoKJecFDclkSRwv+ypXCBEz9sXwfv4Ze+OoAT1+
	 TGWPPrBrp0kNPOHZYpbhQ7uFrCMpjEZWL4hS3Yi9dQJbPOYnOXq5Omb+e51AE12DL7
	 ZaxnQLkVIsgtxBWH1arxoJn4JrN2l2GEifWzWFFFlng9Z5LP9VDWnhP3HymZ0ZDrWw
	 nf+lD6d/zzPO6dW4fz0yCiS0qRAyueA2A2NLESv71ZNMpe2u3TvyyOmQ3Ak4Hl6/eT
	 DITiwOqCemKZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D099E3811965;
	Thu,  3 Sep 2026 10:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: stmmac: drop the queue-0 pinning for GSO
 frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178843020640.3244835.6785391854454806070.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 10:10:06 +0000
References: 
 <20260831-stmmac_select_queue-tso-fix-v3-1-d9c215fe7a85@oss.qualcomm.com>
In-Reply-To: 
 <20260831-stmmac_select_queue-tso-fix-v3-1-d9c215fe7a85@oss.qualcomm.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 31 Aug 2026 08:48:33 +0200 you wrote:
> stmmac_select_queue() forces every GSO frame (TCPv4/TCPv6/UDP-L4) onto
> TX queue 0, relying on the legacy assumption that at least queue 0 is
> always TSO/USO capable. This is no longer needed since
> stmmac_features_check() already validates each GSO frame against the
> capabilities of the queue it is mapped to, clearing the checksum and GSO
> features for queues that cannot perform TSO (e.g. TBS queues or queues
> without TX checksum offload support).
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: stmmac: drop the queue-0 pinning for GSO frames
    https://git.kernel.org/netdev/net-next/c/8e2faf945a13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


