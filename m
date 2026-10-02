Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CB53BB138
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974211; cv=none; b=CQ0c3gq5eegBl6VaXw8Ia9JgRWvoJVi2QpnhKcbwTp0mVUx0LEyDcsvgKf6J0NfMqnkuYVe4eFuQD3DwXpbhKb9PFoXCvoQUEu2m4I3b33z6DbtUpTHBEDeky/ISW0wof1MNaNS8TOyw/5ljUbXaHK5C+R0KVmkwQ/J6yW/41i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974211; c=relaxed/simple;
	bh=DtALHrOTZzLRlqARmgmh78RLeENSU1spIR+3iFUa+K4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fmeb0XAdAotjlfqjlcBtlSVHWRxNuMroyTgiMtg0H2FjwWOleO/7so8rN7jEtxouHEmgYVSEbZ/0PNm6c9qptTk+lQNaBfUJAbrsK4XRac20WXjsO7bOrQU5rmMEYQizh5HlXYzumRifj8xD4GlGhYNu07RoPJjQLR+V+fU15Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UToqDrr1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UToqDrr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C7A1F000FF;
	Fri,  2 Oct 2026 20:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790974207;
	bh=ygeFSV2yPNqNjZcRTELHGXDCxbPcwP+b3h0z2VpB/JI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UToqDrr10VIoM9TxWTm+62wiTFI8pGqY+FwpgJfGt4E0likKVWG0WjYKgZATob0U8
	 6ZivSRA9DHwhfKHCaiCXgzx1lhMhn5/PfqA6IZ2piXD00PNhDSJOBz1/KxUClzKZo+
	 3jemWVbRnG9vveoaWzFDOTLDFmpYKmWoEXIYaeRmtN0LPWDUzz9zB8GKkhTkfWr7nR
	 tJ8WzQCnaQIopRQMfhoBAkKKtzedQtnSPQw9u12jlI47u0ce4eiXQG/yyhHF3I46lA
	 UdQu6eZVB7vPgAXIU1IDUbRfLrVw7EiYA1At9IJW5wTAVBkkGTHtp6NQNUUNnbNYJe
	 3cKvF/ys3Zr2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2F33811A72;
	Fri,  2 Oct 2026 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-09-28 (idpf, ice, iavf)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179097420603.3580978.13126376721297449645.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 20:50:06 +0000
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 emil.s.tantilov@intel.com, luoxuanqiang@kylinos.cn,
 bryan.fraschetti@canonical.com, tristan@talencesecurity.com,
 tomasz.lichwala@linux.intel.com, david.butler@appgate.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 16:04:21 -0700 you wrote:
> For idpf:
> Emil fixes a remove/reset race by always stopping the vport during
> idpf_stop() so NAPI is properly torn down.
> 
> For ice:
> Xuanqiang Luo resolves a use-after-free issue by changing order of
> operations so index is used before being freed.
> 
> [...]

Here is the summary with links:
  - [net,1/6] idpf: fix possible race on remove during a reset
    (no matching commit)
  - [net,2/6] ice: fix use-after-free in dynamic port cleanup
    https://git.kernel.org/netdev/net/c/1402fc67d2f4
  - [net,3/6] ice: Restore Ordered MMIO Writes for Tx Doorbells
    https://git.kernel.org/netdev/net/c/7a579dec8423
  - [net,4/6] ice: fix metadata_dst refcount handling on representor teardown
    https://git.kernel.org/netdev/net/c/58858b8f1480
  - [net,5/6] iavf: fix VF stats not updating due to PTP command preemption
    (no matching commit)
  - [net,6/6] iavf: cap advertised max_pkt_size at the single-buffer HW limit
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


