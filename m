Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794391806;
	b=AmBxl1nfLYmCss6J9UD4TJuZr+hw4nMrznqOZvrgn+C6C5J7vD+iwsxUs2+8Xhv1ywKw
	 meNCdIWRmahEufoXRy2poSo9CCSnSixSzhVCTg5ukJFI50T+QpOtSi1xPKZg5BQ8hz5y1
	 a9sGGv4sx58+mgCmw8l0WpdEE3YWj3MIqsnknT47IfZHR4E/Jl0KEGZMgTL0OIlpk6UXQ
	 LiHQ+hypndJMm3S50cPo7VBOp0vYhP2B4NOgmTEe1ruRiZqnV+ODhFnDftLirJ87gmMRD
	 WYlvfh7Bq+jJbVDApcUx5NNwFNCJQKBVw+VyUVSobvbnN6sEDBPkqsMS5BQs1OAT/CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=VtcpUx8GqULHsTHhdxo1OyaDvbMFca3Kwvkhkv0NsBk=;
	b=T9rcbpe7/WSC5CfNPTRF0hJcVmV3a5Hz2FlWzOTqO4b3/2HXaGUQOgydKmzykK4KHR+B
	 qJe8TFA5LIjaFXmtvBSIxztLnMHhg3tlIvOt3ZLVTomlOLUIBJ30CFcX1eIadxncy/g6R
	 N/fkoCjKV1sPqtb62Ri0c0i7pG9yhO65h4HWUkjByZci90gxxd4RqUlKgnwheXrrBlipv
	 vdMuEDXQc1CVqLKB0KjXBjcL9v6jY7jsC7oe7N1RA4TAymJj+MCNoRqmah+COTTkzSWTZ
	 +Ap72iXXGXRFDATJ7+zFmsfQdCCKzvX+kL+l6zYT38ipi0HiGUxZWkqbw06Ii0CwmQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrLuQlIl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9528C606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrLuQlIl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB061F00A05;
	Wed, 11 Nov 2026 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391806;
	bh=VtcpUx8GqULHsTHhdxo1OyaDvbMFca3Kwvkhkv0NsBk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IrLuQlIlsJFuCKnjf0uc44gxWV74SJMWf2MESUuGDWXKGMWAXkkBM6vM+EAH+05kv
	 EMJF58JHT8yqwScesXdKVLKgKSFTn3SJwAaI2tILim8Io2SSTRJdSe0CDsxoT6Sr+b
	 vE+q9dJSXG+lENanmbPmlH7RNkebrUeDxJbPcx6LWuh7bj2g5R+TjSyNheJMw66dbm
	 eAlWr5VU/O3tVvtmnOwegk9WzZjEs2MmgRBHEbH2qvzUb53VXy4G54aN88s75actOJ
	 1UAaSvs9NAbQOcHLTq5OCe4R9WvMODq/evXlLv5E9x7PYIzXICnqQ1C1AONZr2AexT
	 lkIIQ24ULIz8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2106938007EB;
	Wed, 11 Nov 2026 10:10:06 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: leave O_NONBLOCK to the sendmsg and recvmsg
 syscalls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179439180477.841340.17728656628315045558.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 10:10:04 +0000
References: <691880db-d6c6-4147-8509-93fc76125d29@kernel.dk>
In-Reply-To: <691880db-d6c6-4147-8509-93fc76125d29@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Fri, 6 Nov 2026 16:50:46 -0700 you wrote:
> ____sys_sendmsg() and ____sys_recvmsg() turn O_NONBLOCK on the socket
> into MSG_DONTWAIT. That is right for the system calls, but io_uring uses
> __sys_sendmsg_sock() and __sys_recvmsg_sock() for a blocking attempt
> from io-wq as well, after the non-blocking attempts with MSG_DONTWAIT
> have failed. On an O_NONBLOCK socket that attempt can't block either and
> the request completes with -EAGAIN, unlike IORING_OP_SEND and RECV,
> which call sock_sendmsg() and sock_recvmsg() directly and don't look at
> O_NONBLOCK at all.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: leave O_NONBLOCK to the sendmsg and recvmsg syscalls
    https://git.kernel.org/netdev/net/c/bdc350ddbcbe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


