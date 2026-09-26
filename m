Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763F4547069
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790380880; cv=none; b=ctZAi0tbTf076nUKTy4+PyYErtyYe3w1viaOutmRcKkm6N1jNSxLu+ej7EHgvNnhpMsF0JaFhOlPUtwxbi8nvKa/D3bF5insKAhofvzaghRw0Ig9nlX/kFZUyy+qQqNzPm33jtzDxc/xIGFiDCmmyoJI7L+d6xhfedSKxVVkjec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790380880; c=relaxed/simple;
	bh=ktSxmbsv86qRz6RGEBpT9VpfjFvwqRd694PZLY1xP+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C/2PfOLXV5PkL7xGgzFtCJdIkhrErhfdAQ5BRadCJKDw4oLtckavi+inTcSgZhWjmTqIQykf87nCqk+04rV1tqh1tvFM5UKz1PU6KTCkX3B38X3QgkycpGXmYbFpAnodDJ9lyNd5+iIvE235blwLXdsLwWaQMHX10DLVyzH7fYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhuDDYQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhuDDYQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507791F000FF;
	Sat, 26 Sep 2026 00:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790380879;
	bh=nMIYKUOcQB9FKJOA3mZcltQGbV8gz2XQKOqw8UDfcyE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DhuDDYQOYPqRTaPjt2OLmx+qwDtV1aRn7E3eTq5NFbctVjLvRdbcYLf1dxOwGQHsz
	 5gmKg+NnC7NXHjcMxfE9m9tjMIHB5p55UhYH5ocn+axDtkMmjFMbR6c5O8A33HkQwp
	 zuLgHRLTZkCJOTjcISpEVPjAXYktcbdU/oK+iqFq3dy+visYwRx2FecEOYtwQjg0U8
	 G5pNcVwgVXYfYnuQZ04uwCYngNMjjJRhwQGSpbo2SgRB3raAO2ck96CA8BMmLLh+LG
	 PrZhxLKfiTJUeFNm8A4yLRffoxTZza8mMoP9e3WTvTBsSBe+DKQ52CX42ii3JlOAys
	 hBLXZ6kvLh+8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1980A3809A04;
	Sat, 26 Sep 2026 00:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] net: macb: 1000BASE-X on internal PCS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179038080664.3212797.14106854083562625902.git-patchwork-notify@kernel.org>
Date: Sat, 26 Sep 2026 00:00:06 +0000
References: <20260922151429.23272-1-nwhitehorn@pa.msu.edu>
In-Reply-To: <20260922151429.23272-1-nwhitehorn@pa.msu.edu>
To: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, charles.perry@microchip.com, andrew@lunn.ch,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 11:09:23 -0400 you wrote:
> This series adds support for 1000BASE-X autonegotiation to the Cadence macb
> driver when using the MAC-internal PCS. The existing driver code is oriented
> toward the PCS being used with an on-board SGMII PHY, so uses Cisco
> SGMII-style autonegotiation exclusively and does not anticipate e.g. link
> state changes arising from fiber attach/detach events since the SGMII endpoint
> is permanently attached in such cases. The first patch changes the driver
> to monitor the PCS's link by polling, following the approach used currently
> by this driver for fixed links when the PCS is enabled since the driver
> does not currently monitor PCS link state otherwise and this had not come up
> with permanently-attached SGMII PHYs that report link state out of band.
> The second extends the existing SGMII autonegotiation code to also support
> 1000BASE-X autonegotiation.
> 
> [...]

Here is the summary with links:
  - [v6,1/2] net: macb: Poll for link state changes when using the internal PCS.
    https://git.kernel.org/netdev/net-next/c/456a389f594a
  - [v6,2/2] net: macb: add support for 1000BASE-X autonegotiation to PCS
    https://git.kernel.org/netdev/net-next/c/f342b1208f8d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


