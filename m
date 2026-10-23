Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792783810;
	b=G2nSjSBC/G+xRvAYUmL7BUqVfuhLD0cVm9O3DGTZM97MDLSXiYf9jU50nuoe4dVpx2gj
	 siBwL0DVSoBL3q9HRJDJkf716yNQxBJgq5BHfEb4w2PUOvbRIlQwagyYa4Mm3lemrNWt6
	 xMgOfbAouOo62APa8q58vvZLISdVrW8ikiVdo4UXy4n7AJVZe3vtikPB7PdhJxMM/Ylbh
	 I4jw55J16ZYFms7oxzX8hsfc7rkjeBwe8rlxB3lAN6U1CxyvOkPzbJGVCI4Jhgp4ZQqCL
	 S/RQZDrpFOKiRNGLjkFC3No/p9ZsskZdq19NBDB3AOJyz9tAts24KmLJsHLTCOqVlSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792783810;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xfAgGsJ3OaY47WCXXcuFVA22hrvV+xSABATmtH7f0Ew=;
	b=jBcwphY/mh7f9GNDDfNRuiplYlPHfl2vuw5/e4b+6ao2EGjTg0SMN5d5qCd0x9qoT0t5
	 U4DxD8hDWI+oxdfgKOoXPDhOVHPqbu5FL2bjEQViwwV+yfrPEdRqhHkZCzBy8pfwoKJoC
	 8ctDmjW+aqunHiYpaMn4cgxnabjqPJFcjlO3pvqqDxZ/VPIhZ/pN9iG5BlS6uZLS5nvDh
	 3A+HgqNwWqvzLe1s8cv4nk24ut0XbPRGcXNqBQtMvHpkkPHfBOvNTl5psX5/AN0wQgZl9
	 gMoaEGNfuNgDEIoMJ2b1T4bXc/zDCMhXqZZtf26sTT35ykH6nhcb5aumHSiKyTsNhGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YT4Don7O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AC6606A31A;
	Fri, 23 Oct 2026 19:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YT4Don7O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE8E1F01825;
	Fri, 23 Oct 2026 19:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792783809;
	bh=xfAgGsJ3OaY47WCXXcuFVA22hrvV+xSABATmtH7f0Ew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YT4Don7Of+/HnGWk3I3/YtHXYq44iny+ZRUExoAJ/4Gn0ghc/cjiKGNVx/hyEaWyo
	 mQxWB1/0+6yraG9F5TVjUu1xJpJ9KJXADB741V7RWIr3KHHA14b2qM4Hf0DwLfSlTO
	 MtQn6XxFZ3Lrluyu4rfjkXQaXSOdi004xyN5u1f0dilnXQ/VEziAB6vLkWJ+68Iufm
	 PjsENHvAQ/Wl9y4Fok/4PW1cToUoTw6VvhD1aYen3G10KKG1UU4rLA8v8GbIqigE9g
	 g3b8qBra9f7SiGBQj/7/4h0c0uacK1oZRuDCs8gmmjzvZBVaW/Fgn/Qwl/8VMJCzZh
	 JHicCWla7Wizg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 81569391B14F;
	Fri, 23 Oct 2026 19:30:09 +0000 (UTC)
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
Subject: Re: [PATCH net v2] tcp: reject devmem tx with fastopen and repair
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179278380806.1224496.471951523295951567.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 19:30:08 +0000
References: <20261019174522.55644-1-kaifengw@google.com>
In-Reply-To: <20261019174522.55644-1-kaifengw@google.com>
To: Kaifeng Wang <kaifengw@google.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, asml.silence@gmail.com, almasrymina@google.com,
 willemb@google.com, kaiyuanz@google.com, sdf@fomichev.me,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Oct 2026 17:45:22 +0000 you wrote:
> tcp_sendmsg_locked() enforces that devmem TX can only proceed if the
> zero-copy path is active and a valid dmabuf binding exists. However,
> subsequent branches in tcp_sendmsg_locked() can still intercept the
> message before it reaches the devmem zero-copy loop:
> 
> 1. TCP Fast Open (MSG_FASTOPEN or DEFER_CONNECT):
>    If TCP_FASTOPEN_CONNECT is set, the socket may have a valid dst with
>    NETIF_F_SG (so zc == MSG_ZEROCOPY and binding is present), but
>    tcp_sendmsg_fastopen() -> tcp_send_syn_data() will use
>    copy_page_from_iter() to byte-copy from the iterator. Since iov_base
>    represents dma-buf offsets rather than user virtual addresses, this
>    misinterprets offsets as user pointers and copies the caller's memory
>    at those addresses into the SYN packet.
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp: reject devmem tx with fastopen and repair
    https://git.kernel.org/netdev/net/c/89b9db72918b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


