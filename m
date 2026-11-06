Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998814;
	b=bKt/2+DLJanraCEJs92Nd4Z5NitwyKpySws2yQEo0PPlqyISslmhdMsrC+RPCRSEyTWX
	 Brr1P7M+njKx0tBojs89DXPUly0RsDZqg/V725WwdAwEK3ZjHz31K91BHT+Hy28xc7QvS
	 cBYpebyOdoDh5XLUCq1y0UcaVj7BA69S0iX+06wpafTGFlTk0+lz6QGyMbidhEZzZVqAO
	 Wm6DOT8XnFd8LXgeoBiubfrOAs3EPsTIbjXWAk4QeaIxMT54bMtMAHCaXu07L95aVFqy+
	 Zqa/9NHRD1YS1KUN3rmChrDHQ4arz6hWtsJSjVoyuYrwcXC5Hnj4OUcyk+oapdsj5pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998814;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=gaT6CRNJ/3j4xb/truYjQh4f0ordYI4g6zwRXZjIxaE=;
	b=lCUcZm4xI6tvId6Y3EU9TUBHLQdcgaT1LD8UNvIHE1zBdEo7i+IChcG4IJmsckyDkQyW
	 INEk4iIrBbFkVGB2OtDcSnQyj0ZYgee6s4jcRmgn8gku7RxbZd9Czt7SuB2oN4X4/kPLC
	 XqtRFyZ3fuYgrhxNx21eLiReepbAfXdwslZSQcwF0Zsqi3d0aLIcqto+7Rf6lR5aS0/XL
	 jvjy36hlnmWwdM6W3CEiuefStrEaVZmLk5DDc14H7yYbse4aGmPfF1EObNyYnjenFrYli
	 4Za4zJH3vaovtx4c+t0IXUN+9QNgQKaGabLpbYSCZLM25eJ39789iuG479msjJdF+1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfe8EQSl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63A0606A33A;
	Fri,  6 Nov 2026 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfe8EQSl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3D31F008A1;
	Fri,  6 Nov 2026 21:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998813;
	bh=gaT6CRNJ/3j4xb/truYjQh4f0ordYI4g6zwRXZjIxaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mfe8EQSlNIFHPbJAPd6HiFfLbfIGSLTGLZpxlJgYt2XNLJ9LE/m0AqmFq5DEoJYRh
	 hGY9WTq7hkC+pjPAHILQ/u0bAlxqab8ikcmY6eJzMCt4sJXvQviJ7/ykewaL1xrUjg
	 BxRIVsJUteETIttUrq0nRURnDG2Dbh2RjkNuELOGWVoQAJD1Gp/RAjAJTXDvQHGObn
	 0tvTdp7CA59PcQJ1gQ59OAZvp/X6iZhoFLN7yLQfXOUfrQi4/OmPvyzmLI2i445KLw
	 7cYt+bGvGz4ULALtN8PEovF0MPWc9J1vjC/p/Gxlpcv7yDkgmJZbPBgjAYi5/PTo/u
	 i9BtggkYIK+Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 210463A549A5;
	Fri,  6 Nov 2026 21:00:13 +0000 (UTC)
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
Subject: Re: [PATCH net v4] net/packet: account user-triggered allocations to
 memcg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179399881167.868572.2096486828284345042.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 21:00:11 +0000
References: <20261101094847.664612-1-ahmadag1001@gmail.com>
In-Reply-To: <20261101094847.664612-1-ahmadag1001@gmail.com>
To: Ahmad AG <ahmadag1001@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable+noautosel@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Nov 2026 12:48:47 +0300 you wrote:
> A packet socket makes allocations whose size or count its user chooses
> without charging them to the user's memory cgroup: the blocks and block
> array of a PACKET_RX_RING or PACKET_TX_RING ring and the rx_owner_map
> of a TPACKET_V1/V2 RX ring, the PACKET_FANOUT group (about 1 MB with
> max_num_members = 65536), and one packet_mclist per
> PACKET_ADD_MEMBERSHIP entry. CAP_NET_RAW in a user namespace is enough
> to pin memory far beyond memory.max this way.
> 
> [...]

Here is the summary with links:
  - [net,v4] net/packet: account user-triggered allocations to memcg
    https://git.kernel.org/netdev/net-next/c/f356e90de854

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


