Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B87313543;
	Wed, 30 Sep 2026 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760608; cv=none; b=WWhP0so7fJkoAHe1+V/8Mkg5iE3rP89YE9hNUaIyXG55pJb3tlvouPioS5k3djjFxdg1xEAu3hK38LLwe6kpcWwoKPmpXIj6pwSKPRbYbxbHNwGD9Ht+NI4DaRKmAkYAevaYY7EhE0r3J9nAIeaPeLZOQXIC66lHq7lEZIj6ums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760608; c=relaxed/simple;
	bh=SiOnEoFLz4AagjEf0QJa5q11C4ugufBzekm96HEA+V8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cg59Vs7aSh2OqD0/5LXxohJXkaKroWgcL+50p1vIXEMBsuuP0aggih0KQfIdAvCaDgdRYy0/ijLlRZ5E9J4F3AhnE10O+P7d261E93PIBX9MT6o6+p2xhUwji/EnLezs8B+an6w/hvV+jfjZLiGdzhe75HaZpD8iwq4XVyGfJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfiuQkLM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfiuQkLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093EC1F000FF;
	Wed, 30 Sep 2026 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790760606;
	bh=sjcvPJp7qyZH0h3JFK+CWWKeG5u1wLGWfMiMgytCi04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MfiuQkLMXkOGZdjhSEbkKgTPxjYzwXeHltydpcOEmEDR4aAIMnmP85nbzuzRzzIg/
	 JxNuVOmHcOz1c1szwrKa7SaqVYhnX/eR6etlI1O+kdK5ZoHN4mVv8ZjUrWbg/XpPKa
	 RtnVIftgurHWBkaciOqj2MPLhjbW03y5UZnQMgGHPmrThlOWbGv9MG4fqhfIzsYEVy
	 ZRdXRG1W+LlO6LIQE+bQ4u9IoSZFafd2fBB2aVst5Qf7zFwrlktIrCOiwqB1RjMqUB
	 V7sdRYb4kn/Plj3kd6RmXQBzkKeo5rCgMvq3LD7/ppUR/hVXTGa6X1ROw+4wdu8/OE
	 uTprwJW2Fv1Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F154A39E8A7B;
	Wed, 30 Sep 2026 09:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: microchip: vcap: stop scanning after deleting key
 field
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179076060478.1357769.13599525229018760574.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 09:30:04 +0000
References: <20260925063937.963430-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260925063937.963430-1-harshit.m.mogalapalli@oracle.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Sep 2026 23:39:36 -0700 you wrote:
> The only call outside the KUnit tests is in
> sparx5_tc_add_rule_copy(), which passes a fixed key list with no
> duplicate entries. Therefore, the potential double-free is not
> currently reachable in tree.
> 
> However, vcap_filter_rule_keys() is exported and does not require its
> key list entries to be unique. If a future or external caller supplies
> the same key at another position that the inner loop visits, it calls
> list_del() and kfree() a second time on the freed field, leading to a
> potential double-free.
> 
> [...]

Here is the summary with links:
  - net: microchip: vcap: stop scanning after deleting key field
    https://git.kernel.org/netdev/net/c/99b43ede9e35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


