Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209FC14A60F;
	Wed,  9 Sep 2026 00:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913867; cv=none; b=oYrQzaRCSzrmCzY1az49PcNbLjSUo0wSbBGz8+QrOTEVg6MbOYzodyqi31RdcCixY2hW9f6OjsxPhn2OP6SmmDhRyyTQaEDrHla7aeSRzfZpalyIJ001Z5rV4eiTvjBvbTyjbHQtkX7heQan4eCx4vDvN7Tx7j31QyBAwFWgMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913867; c=relaxed/simple;
	bh=UZsoliyAz+VAXxB+2higK8AEAOVTH88EXgkOa4FkQtQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jZTqu8nRqPiuA7sdno3Kssoqf5NcxGPIPUI+oPLbORZPT+Q1XaLLO6w5akIeJQ4nVkSL48hvz0Qckl4Hl3cikjr8iMRINumnlSi+SG7O55TgyXIoP7BlYYySddkXljrmgl0iGFlKcc7EJU82vXd78vQE5cJByExjJRODpHvpQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKdJgXOF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKdJgXOF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32381F00A3A;
	Wed,  9 Sep 2026 00:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913865;
	bh=B9aCLmmm5iK/rnj6mZsWiq4Xi8Uv6BexryWvU1ypfAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dKdJgXOFRvnotP1IqNOQUF+raJW8oVBLS/WN0YQGIJWm4rCd4/sFirkZ4c56Y62ME
	 rzl3tcTJAJZzLADNJrFSvAuA+dlsu2hXmWzmmAhMQxFX92RZ4mC4mEhK/w1jWMcGdX
	 KsCIehYi+8klHWcNPwjvDhiWarRXgnmpg1hINlPOd727dlG80xZmKvKb8Q5vNzHCND
	 oj1jaexG3OPcGdln9rHzsakjk6b6MU9aAqcctkBsYfnBQ1PpLNmN3bM+RKQcO6pZLZ
	 VQ2AQqK10PbKnFCvNSGvLo9qbCPrlGji53RRmJUnARs0XYyuBlizWoJ3lCtcyYwt8p
	 XbFQrNgosj6WQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56E4B380820D;
	Wed,  9 Sep 2026 00:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: fix use-after-free of the flow
 table
 mask array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178891380414.78759.11339646827353081574.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 00:30:04 +0000
References: <DE115F9C-2545-423E-A702-986FC952FD62@doyensec.com>
In-Reply-To: <DE115F9C-2545-423E-A702-986FC952FD62@doyensec.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 6 Sep 2026 10:21:09 +0200 you wrote:
> tbl_mask_array_realloc() retires the old mask_array before it stops being
> reachable:
> 
> 	old = ovsl_dereference(tbl->mask_array);
> 	if (old) {
> 		...
> 		call_rcu(&old->rcu, mask_array_rcu_cb);
> 	}
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: fix use-after-free of the flow table mask array
    https://git.kernel.org/netdev/net/c/ba4ba11ed6eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


