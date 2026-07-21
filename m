Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6F243C05F;
	Tue, 21 Jul 2026 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784671856; cv=none; b=VGnSz3WcOPDB0q2syI90qFgc6jyKV3KjDUco81WtXjnOnCFRDMz5r9P5kmP599TsEcdHL+eyficEKQoDoIzMVmh8vBEGUkGZp9Q/rhrXaDwlUIxQ9A1DLgK+v1qKnC/ByQiQmgX5O9epjkiP0r9+H/dHkgvEh6fVfbwRAy0fGKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784671856; c=relaxed/simple;
	bh=fHqi9cgXpN+JZyyK8HdNq/B4ro9lAYoq8oNr6iKmMuI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D5t3OrLjumxMUqn65pvH7700IzEVm7o4ZlO4sdWrBo+SMdhgG4zn1It6hLODdUYeNMDpkUZ+hNgkKl+8ENBkGO+xWSQk1tgSZlkhpZnIaTC1SM4VIz1xijWuyE3VV4Od1Jpc3dsCItWnNg5O1mQwzM5P21rxjn/Co0jAYbjlbxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3Rz0oWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3Rz0oWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D961F00A3A;
	Tue, 21 Jul 2026 22:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784671855;
	bh=HmXA0E7vO7JpuBT/RPJRgkSz4YZdO22lZZ9KMxvtYV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=k3Rz0oWOlaLh8H4Eknn1XwwgrpgP7E4EwZI2MCUz26C1h6EbzY3ROVmil566TGWAy
	 WnZ8mutnF8+Vxf/VmXDA6XQSPKouhsWnXY4V7gbzXthMoiuwXWOrI9Ch6iJLDd20H/
	 /N14Wc8MWHXwvEF0k1YQpAFwfJ6hyJyXRS5utPWoNGKW1QBVPIDFr+0M4XyNE0AxVb
	 2vEr2fDAIE+B9Dd1++KBul3aNFWOj2wcMRm60WVjannMk9VLeDeaUjY+OdwzrNOblt
	 6zHT9VlJUhFY5UqldV7QqVh20ioAF1tKr6NcjjeRTe/TNIh/7O7Pennn3RdaSGTzte
	 /fi+/DBz3bhVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A24380820D;
	Tue, 21 Jul 2026 22:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] gtp: check skb_pull_data() return in
 gtp1u_send_echo_resp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178467182464.1107545.10716395406289268841.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 22:10:24 +0000
References: <20260710230724.942574-1-xmei5@asu.edu>
In-Reply-To: <20260710230724.942574-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 wojciech.drewek@intel.com, anthony.l.nguyen@intel.com,
 osmocom-net-gprs@lists.osmocom.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
 tgopinath@linux.microsoft.com, kys@microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Jul 2026 23:07:24 +0000 you wrote:
> gtp1u_send_echo_resp() ignores skb_pull_data()'s return value. Its
> caller gtp1u_udp_encap_recv() only guarantees 16 bytes (udphdr +
> gtp1_header), but the pull requests 20 (gtp1_header_long + udphdr). For
> a 16-19 byte echo request the pull fails and returns NULL without
> advancing skb->data; execution continues, and the following skb_push()
> plus the IP header pushed by iptunnel_xmit() move skb->data below
> skb->head, tripping skb_under_panic().
> 
> [...]

Here is the summary with links:
  - [net] gtp: check skb_pull_data() return in gtp1u_send_echo_resp()
    https://git.kernel.org/netdev/net/c/cd170f051dba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


