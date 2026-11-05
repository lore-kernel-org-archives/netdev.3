Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876410;
	b=YWXLUsKGFFdINoDe8wZYt5zI7ALVPbm/nzpPW9yHtk9GFCa+TNQlWU9WXu0oK25dwDxs
	 axPDSbnit/iB1SC5OcN/xxP78XkUkVtswki2nVDJbSSe6diTWNGa8KqNngMqi47masvlJ
	 virryOMnIlHHK92ql62kz0kVt6WF97rOr9UjVJO9xkL5oYM8ZQu0ceRxAKIBkOjs/CxQL
	 qKRrEjQJVa4AgqerIvEJ8uID4dDfDv+m8umb3O/0Myc9WHohM4wCykkuF5PMm0dUcM8Wh
	 V9feU2IzUWwoWWLnANdrlrX6d+PJFA8/0CSLUmIMSGLEApRkiT50poX9ZIlfpDlElqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=soHoKIJD8GZb4y0nvq88n/hT4e+HgEdbmBAc2lwIcEs=;
	b=nAgWR3W1Lyy+V8VkAWXrIWSwfEPfz1h2y66fl/J2J0+hVDrtqA9jeu3F+Kd3Pg5pozIZ
	 A5uqnoWgEYsDdR1hrHZel0uNn+rRQoUEpCOLLGtlnzFqOLczpZv1K8mA0V8RdryHLTA5H
	 Ec2lDrDgNENGyreSdfxi+xjKb23wej0s3kUxXiiYNPW8+C1At4+7WBliFFnTM7mvR3qwY
	 RakI0kSVEpTIS14AgnFdYk8q6Vj88H7aAVuT3hwe0gJUnRvU0hMdTYbNsgNBtrO5bYtl6
	 H3dB94IVvsMabMMY1MK7T3Q3yenENv1CA9aRIh59rJ6tbM4UmO/VUrnKMYnNL0Nzw5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EF7iGI22;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1696606EE82;
	Thu,  5 Nov 2026 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EF7iGI22
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313E51F00919;
	Thu,  5 Nov 2026 11:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876410;
	bh=soHoKIJD8GZb4y0nvq88n/hT4e+HgEdbmBAc2lwIcEs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EF7iGI22jNvAG/hwRR0bKU1JlRJxfpze+DtATqCjdXSOWK3nF0flhnjmtzdoIozFq
	 jhtL8jptl/94oIpBMnEbDmQdg9soti03njEm8SsExsjY2+61ynI8Jay63ia5QUNuIl
	 wXBAuBO6OPJ6BFugGc43AyP+Qzsbt/Ay9XCOqv8UJTv7MltVCPvYpe3/Z2nesTrQKU
	 +2qpzUv7XLt+YkoMmwuMAMRcTfgys0oVGhxaV31sgeSPpG02548/kxhrN8qhv8uNy5
	 K2tHPZnQssjE7CyVrACyCvorIGvNMMO9/oZON3LXO71DreqnCW0YKRanzVeB5aSKyz
	 +tIZy4XbnyYyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 27143391AFBF;
	Thu,  5 Nov 2026 11:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] bonding: fix missing down path on speed/duplex
 failure
 after FAIL->UP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179387640882.3593676.11672441638791431727.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 11:00:08 +0000
References: <20261101150240.66292-1-timur.stukan.linux@gmail.com>
In-Reply-To: <20261101150240.66292-1-timur.stukan.linux@gmail.com>
To: Timur Stukan <timur.stukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, hangbin.liu@linux.dev, razor@blackwall.org,
 fmancera@suse.de, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  1 Nov 2026 17:02:39 +0200 you wrote:
> In bond_miimon_commit(), when a slave is proposed as BOND_LINK_UP but
> bond_update_speed_duplex() fails in bonding mode that needs speed/duplex
> (802.3ad, tlb, alb), the slave is set to BOND_LINK_DOWN directly. This
> bypasses bond_set_slave_link_state(), bond_miimon_link_change() and
> failover.
> 
> This is fine for slave that coming from BOND_LINK_BACK, which was never
> brought up and is not in use. But since commit 1899bb325149 ("bonding:
> fix state transition issue in link monitoring") the commit phase also
> handles BOND_LINK_FAIL -> BOND_LINK_UP which means a slave that is still
> in use and may be curr_active_slave.
> 
> [...]

Here is the summary with links:
  - [net,v3] bonding: fix missing down path on speed/duplex failure after FAIL->UP
    https://git.kernel.org/netdev/net/c/a76ab5e733b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


