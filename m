Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793100018;
	b=H9o8hTVcr/TIZe2SMs2kC7S+nJtiw32dtAAsVZ9vD4ji+EWEGsWb63xaR+aDMU7dFaM4
	 3Y3aURPfIh/EWvMJbliDNBa0QKV115ShedKLuRe3Wkhw9OE/9ooLSkSfh8ORtwH2CFvxl
	 6vFZsSECXIxofkVDqwTBINMRc9SDUIXjnThuznUSvB9EkMGIvwQHRt/VQQ9GPN9Cqm0SC
	 uCZKqif8vUMfH5n6OxiBH06OeFXnqC5E7+QmPMrcZCec8KyRUTvd9i3UHsB+NSv9z4LdW
	 MO2AX0/8KlpyArCPsKaTXQU0rwN6lBRUXeXJiw4cbuaw9uER8zMkCFl5MPO80uvfgbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793100018;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=NPUrP0nMLlCTJtbvP22SrKWOCEW32C1nfkshChSMVTE=;
	b=s1dxZSd3GFpV3V45FfHaDoQFteYL4Zbq/olXRWmqrj8+nkuqwlzwIRMmidYHS3YAU8IV
	 Ue0UuzuDNs8Jmh7z3PoLYayh0+SNOXJWTJgaPiVqTatlzlZ0W+PIOn6K8vnI4r9V3BfJ4
	 X3uEWdVGMEcdmbIBjLClMRZpiMb5vSknCZ3Z2tRnLS6W+Jf5ZmkNOkWrC/dBrerdw3V93
	 B8y28+U35lxo8uVBt2QSC9Ylq4g4UFTxJWM0NbwmuczfMLrkcDy6CDfx23vq9GOKbs+u8
	 xdCEpozfs/OL6wqaPl8yUgZ68Gj4SG4mxitoaxdX/OXidVzLnWgWgJRxNpdko48bYpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6lZ+ybh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05B1606A324;
	Tue, 27 Oct 2026 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6lZ+ybh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD451F01825;
	Tue, 27 Oct 2026 11:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793100017;
	bh=NPUrP0nMLlCTJtbvP22SrKWOCEW32C1nfkshChSMVTE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=I6lZ+ybh/3jBGmuXL0o15T5AhbMmmVT/u+dejYVcMKimc7bXXWnVkIVRFrXTRbOgF
	 fm5c7u4xnnM1negW7Fl/Qdp3l6EZFyTBgGOVp6nSPplgBbtqPHBFzLZWk3xBsloUjj
	 TBVXMvYf9Apr92m/O8SKJ4e/xm6L0HR9fEt79omN4NVBVpsz6Kxu2i7uLbYAUsTq+n
	 IW47tOGSSWhqsbc5+Ix8J5few4QV65MeV449zDvGflT4PUHbfvV52qwG1eR+BR1egm
	 dnpx8tLpO5lWvcQr0R5PqQlHU/AnM7VwXRZnHp9h6QfAcsyknejNmQ8gRYdxJqfXxF
	 UWLOe+u52pMyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815383AA9388;
	Tue, 27 Oct 2026 11:20:17 +0000 (UTC)
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
Subject: Re: [PATCH net v2] pppoe: wait for RCU readers before reusing a
 socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179310001606.3743855.6417887506256110884.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 11:20:16 +0000
References: <20261026061300.256009-1-qingfang.deng@linux.dev>
In-Reply-To: <20261026061300.256009-1-qingfang.deng@linux.dev>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, arnd@arndb.de, gnault@redhat.com,
 nbd@nbd.name, ericwouds@gmail.com, manizada@pm.me, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 26 Oct 2026 14:12:58 +0800 you wrote:
> When pppoe_connect() disconnects or reuses a socket, it removes the old
> session from the hash table and resets the socket's fields. An RCU
> reader that reached the entry before it was unlinked can still be using
> its address, ifindex or next pointer.
> 
> If sockets A and B share a hash bucket with A preceding B, a concurrent
> __get_item() looking for B can be traversing A when it is removed.
> Clearing A->next then makes the lookup miss B and drop the packet.
> Reinserting A can similarly redirect the reader into another hash chain.
> 
> [...]

Here is the summary with links:
  - [net,v2] pppoe: wait for RCU readers before reusing a socket
    https://git.kernel.org/netdev/net/c/e7b01bc0202a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


