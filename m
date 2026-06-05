Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF0165F16
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780626032; cv=none; b=ZDb89klYLDe45SR8ZkKaPn3v99RMuBIprc0jZEmT5z2yKqkzWxZHX25/bvL7hDvezXHRakB0ycwdgSJ3amY+rkZGdhih4e34YPvo8AcOKULIMQK7I2Buz2Y6Tqg56+jW9tc0kN4avPjyDzGrIP1m8iFG7MG4gEpFI1mMRkcP45c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780626032; c=relaxed/simple;
	bh=L3wTQGz3VciH82y1TTGUo2fb8sQe7n7TpNsLipaF118=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dV6HJqg7/Ee6sNLYemk5+s+Ci00XfMlKpN2Ljlr/cyTf86hlgHshcEOQmvDhs6b2VnmSLBe4Vp7nGP43AKtXyN004Kv4xBmnMFCymwYqVsPRXrieYlKdufMHyHjmbTr300TgfAbwvcLdfsoDjHAoG5DaeWP0V+9laDD9547aKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKwfaRGp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKwfaRGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38A71F00898;
	Fri,  5 Jun 2026 02:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780626026;
	bh=jotGDupi4iQAmLABa7Kyj5lMOG8HIUM3cxsM7Q8P6lk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TKwfaRGphFiecyTJtfFEEnhATgP6fIhkxVWaiLQ1HUxMoXdES0VxtNtBil8ZA5y+2
	 bSxNDtkUcXbBtzYX6RjhreMxUq5zByf/cq/ihMMieoaC3y2Og0UiToaDDPfzkQcuxj
	 Ym5G136RKVNV8Cv8lFPApiLOLhIwNFMx/3QpkhYJ24vVaXDAwIYZjpFWPw2w+SysGM
	 XcaB82C+x+dd7C9Y9rumOMW73yd0WvacbCZSIZLjFbh+PEyN/0lzwlxW+hwmtXedE7
	 ba9rrycqrU+gdmG84rvdtjZZSbCEQGHh/TRVN3DCebinYjDAWdFlEH84bXuwOT/Y41
	 w/VK/L7kTDLVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D473930A8D;
	Fri,  5 Jun 2026 02:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/15] batman-adv: tp_meter: keep unacked list in
 ascending ordered
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062602640.3107573.11057765265590457796.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 02:20:26 +0000
References: <20260603072527.174487-2-sw@simonwunderlich.de>
In-Reply-To: <20260603072527.174487-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Wed,  3 Jun 2026 09:25:12 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> When batadv_tp_handle_out_of_order inserts a new entry in the list of
> unacked (out of order) packets, it searches from the entry with the newest
> sequence number towards oldest sequence number. If an entry is found which
> is older than the newly entry, the new entry has to be added after the
> found one to keep the ascending order.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] batman-adv: tp_meter: keep unacked list in ascending ordered
    https://git.kernel.org/netdev/net-next/c/5aa8651527ea
  - [net-next,02/15] batman-adv: tp_meter: initialize dup_acks explicitly
    https://git.kernel.org/netdev/net-next/c/b2b68b32a715
  - [net-next,03/15] batman-adv: tp_meter: initialize dec_cwnd explicitly
    https://git.kernel.org/netdev/net-next/c/febfb1b86224
  - [net-next,04/15] batman-adv: tp_meter: avoid window underflow
    https://git.kernel.org/netdev/net-next/c/765947b81fb5
  - [net-next,05/15] batman-adv: tp_meter: avoid divide-by-zero for dec_cwnd
    https://git.kernel.org/netdev/net-next/c/33ccd52f3cc9
  - [net-next,06/15] batman-adv: tp_meter: fix fast recovery precondition
    https://git.kernel.org/netdev/net-next/c/2b0d08f08ed3
  - [net-next,07/15] batman-adv: tp_meter: handle seqno wrap-around for fast recovery detection
    https://git.kernel.org/netdev/net-next/c/f54c85ed42a1
  - [net-next,08/15] batman-adv: tp_meter: add only finished tp_vars to lists
    https://git.kernel.org/netdev/net-next/c/15ccbf685222
  - [net-next,09/15] batman-adv: tp_meter: split vars into sender and receiver types
    https://git.kernel.org/netdev/net-next/c/feb4a390a540
  - [net-next,10/15] batman-adv: tp_meter: use locking for all congestion control variables
    https://git.kernel.org/netdev/net-next/c/a7eff9402471
  - [net-next,11/15] batman-adv: tp_meter: consolidate congestion control variables
    https://git.kernel.org/netdev/net-next/c/4f117f562628
  - [net-next,12/15] batman-adv: bla: annotate lasttime access with READ/WRITE_ONCE
    https://git.kernel.org/netdev/net-next/c/98b0fb191c87
  - [net-next,13/15] batman-adv: prevent ELP transmission interval underflow
    https://git.kernel.org/netdev/net-next/c/5e50d4b8ae3e
  - [net-next,14/15] batman-adv: tt: sync local and global tvlv preparation return values
    https://git.kernel.org/netdev/net-next/c/5f80c363677c
  - [net-next,15/15] batman-adv: tt: directly retrieve wifi flags of net_device
    https://git.kernel.org/netdev/net-next/c/626fd1437161

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


