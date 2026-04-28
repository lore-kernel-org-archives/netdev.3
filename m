Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B22E414;
	Tue, 28 Apr 2026 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338652; cv=none; b=nFryYgHrWTUdEKEDdrI0HxfSFCr6+Sv6bjv2zfksgbgEC1LfT7M2JZM8sNFLC0I+07R530sYg951MmQaLa531S8vaA80shD9LVw6mi5vo8JxgP8aQR63K1jMbn4U+CFE0/D24GsNbykEm5l2N6cLBR59E/fKlNVxddeO9t7Yc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338652; c=relaxed/simple;
	bh=QHM6OJUk8z94VIukxLSBRylVRAbANvgxmkOa/8axmIo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FtrVKhlq+5M6JwVxDe1nM1tMw1GhCT3pwV0MEXqvgvlxj46WZzpmM0BfI94i3pFmyjyW3bv8LHPsvvi3CKTPtCIBx4d+GBqjWoqZuXPimCmuST5E8ULx/HWzWnZfmWkqCUpjTq0Tvoh4OxExSk3mYyhFnsyqXEbGKEzeGRO2KSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDX3VDvi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDX3VDvi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB70BC2BCB4;
	Tue, 28 Apr 2026 01:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777338651;
	bh=QHM6OJUk8z94VIukxLSBRylVRAbANvgxmkOa/8axmIo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jDX3VDviVWqFDYHvYvVtqmZ4zYsHr/lBB3aYVx9i+6QLsrItKKJHSbznuh6prgjJ8
	 c9nep/PyOEDtIutmwlxtEUYjOtzjh+aC33zM30B85TVPHti+KIbiqG3VUDW/jq1gFl
	 cZv3qWQkxH5oKgYuHVnLAqYKPxoEB5dXRVCycwvL0NVCLZXfB60p8RKuMdB93X5S12
	 GGVLyaLVHZImtr5xb65Gvj/Mm9NJusdpPtCv9cUWx8HrLJGzAImIEmLr9cqRdKCQWt
	 0WMg79pzU+zrle0fBiIj3MiitfkriUsKI9W1SESRpjIo3BcXeYgCFBO7e3i1/tP1yD
	 MBRNPlKbssMNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCF0392FFDE;
	Tue, 28 Apr 2026 01:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv6: rpl: reserve mac_len headroom when
 recompressed
 SRH grows
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733860905.182819.5296325786647390073.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 01:10:09 +0000
References: <2026042133-gout-unvented-1bd9@gregkh>
In-Reply-To: <2026042133-gout-unvented-1bd9@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 15:16:33 +0200 you wrote:
> ipv6_rpl_srh_rcv() decompresses an RFC 6554 Source Routing Header, swaps
> the next segment into ipv6_hdr->daddr, recompresses, then pulls the old
> header and pushes the new one plus the IPv6 header back.  The
> recompressed header can be larger than the received one when the swap
> reduces the common-prefix length the segments share with daddr (CmprI=0,
> CmprE>0, seg[0][0] != daddr[0] gives the maximum +8 bytes).
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv6: rpl: reserve mac_len headroom when recompressed SRH grows
    https://git.kernel.org/netdev/net/c/9e6bf146b559

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


