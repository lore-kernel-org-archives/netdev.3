Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0537246A5E7
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655054; cv=none; b=B/VJxKyZLcpOFdzGKKOSJuvL0S5h9aK7vnpPm9+KOe6M1oz2vGmzEzn1HfQ8OuOroz3Xz5wN39TOGzapR+VfEmPLrMfjvQ9fuYc+kYr8Fgj5ht2Sb/tdWJQ/j/WMMAO30JONKgqs8b6di6iE4b91YhIhYaCoVleZox0aJ+bgKcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655054; c=relaxed/simple;
	bh=9qo4HJBabutPhL/6L6PCSsHDpjpS045wKQXF5yQgSj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=POSZC8vgd7amfo0sKxz1VGdCgXsmqeKln6zjDXG+RlaU5nnLbKx1+MX5N+ZD8kh2+W4zZEkVpgwE55WQ3OCIJASQMqETB0Yb4r4d7EynK16iXIvmfIiLaQQtWxgM3SCf/twBilj7T/XHx2A0tw1yGTIYbeDouOtukChJy0RdHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bbe73OGH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbe73OGH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA2F1F00A3A;
	Tue, 21 Jul 2026 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784655052;
	bh=/0/MY1v4/chURaKZ1Ouio1ZbtsclnIrQmP1W+b/b0r8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Bbe73OGHGSTPa/4eedj4c7vuYDXDgQI/4C/n2Zs890SEMlfIwPD5fNIViWjkUq38X
	 f1Y+9YdoNb0kknTQV39eh3Tg3DviUBbvfnc4Rk1KSxGoZfTWodHTYFj2aKqknPnVwE
	 Jo4NiyIoR85QIbA+KArC7tc1TeSou0kMLiKHhY1M/fEX8on5/DQdwpIV2aVncCRwH9
	 Up6DbJXf0ADtINZsPPVXtKgLu1G38n00W9ZS9+igrqpyDrfy+T+1YnlMgmqv8wqKL/
	 rvNLqcaFvN0nPCCxhkgmvBwp+9Y7wKh/S4fDRzbIke78lG9kZV3jIzSQZPIWWR6YPs
	 s1OD9l/tHHdJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9CDD639253CB;
	Tue, 21 Jul 2026 17:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] geneve: ensure the skb is writable before fixing its
 headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178465502251.874899.9095921584206782641.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 17:30:22 +0000
References: <20260709125000.141092-1-atenart@kernel.org>
In-Reply-To: <20260709125000.141092-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, sashiko-bot@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jul 2026 14:50:00 +0200 you wrote:
> Make sure the IPv4/6 and UDP headers are writable before fixing them up in
> geneve_post_decap_hint. As skb_ensure_writable can reallocate the skb linear
> area, reload the GRO hint header pointer and only set the IPv4/6 header ones
> after the call.
> 
> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260529144713.780938-1-atenart%40kernel.org
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] geneve: ensure the skb is writable before fixing its headers
    https://git.kernel.org/netdev/net/c/447ec540233c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


