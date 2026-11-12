Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509413;
	b=baweihufdbe6Ar0zHWkgmpZi+4Yyf3rLNplsvgutNJDr3eKD488+AuXGhR1U1RY3hIQy
	 uk4lWQAHNgz8dzL59m+fjO5TxYfBU71qqR6CnBY1MecM5br/tnPl+11mTtTBGEiOgJ2D6
	 kg4Pkf0zrxhtucYIf+9dJo7KdcnEY4Tz4nln72fXHyLCX1F5s/iiT/3URTJNBL6w2Rkb7
	 YfmYiErwJDB8JtRHcGyYDpZcbETT6Zgcq7Hct/0xjDojVCUbQn9VFJMklVeszFPA1UmTp
	 vKIhhl7x9zYhKF+nuHxRLQP5tinACIJaf7Aa3S1jNNsnvGjcoR6janxtFO5uPd2f1Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509413;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=gFaVbDH+0XYCI4becZUfbpd0dWLjiEvsBI5PF0NUd1I=;
	b=BULixGcdGeg9095jvp/AvPtpX1UWgaIi/REXy/ChkugaYdpOv52sakhGp31o1RulkCJc
	 bEg8F96qenSjybpMRbTS/cCayORmCJKZE7iu6/R/0FXE5AQHUVGeW+uZszaxT28bqIkn0
	 dI7IM6OVwAa6YYa2l1wjxvkBFkFZwYtl8DtE2IkJ6ROINmtPxLcAx84TXU9E4IWvqP4VD
	 WxrC7OQAoA7bEp85RbfNXltfm3EkI9aZAyiZhpc0rl35W0qGqavtir7NODdbme2IS9prl
	 C+5apxf34ggiq5yitIZTlbj+5IDUGjAfb15O1rKlLj6E1W/fX/XmtjUo8Z0P0qIAQPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTyleW8e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1AD606A8AD;
	Thu, 12 Nov 2026 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fTyleW8e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E981F000C4;
	Thu, 12 Nov 2026 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509413;
	bh=gFaVbDH+0XYCI4becZUfbpd0dWLjiEvsBI5PF0NUd1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fTyleW8eXFxrGkpFXieaqZ4sUDXpiWiONeT6T+Rj0V0AB79f0zaSRNKLPMkhDnNqG
	 oDe3gbQTdaNdsPxAofXhOo5CWZrFJC95s/BiaM7dMJNoeOEgm4sSPWQiFyApTn248V
	 Xs+BcMgXFV8OOHdW7UuQoj6fCkQULNhkjkqN4z+oQ4xxEoQ8gE3Gmh1EePa7SVdc+u
	 O1Ojll96ZxoVNAiViLRUfdnKkRNAX5t5FtF9aXHsg/PcNeYO/pypvRloee5chm8s7k
	 hwpViRJeDda0HQVtQgLKV8ozntl/gTOP2J7H1FPdX/DG2lSKTMFmM903lr5E/wHED3
	 sRO0q1pNaoCcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A33D391AF9C;
	Thu, 12 Nov 2026 18:50:13 +0000 (UTC)
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
Subject: Re: [PATCH net] af_unix: Inherit SO_INQ in unix_stream_connect()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450941177.590019.6860476763740154200.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:50:11 +0000
References: <20261111023222.77227-1-sunwenbo@cmss.chinamobile.com>
In-Reply-To: <20261111023222.77227-1-sunwenbo@cmss.chinamobile.com>
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 1342116488@qq.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Nov 2026 10:32:22 +0800 you wrote:
> When SO_INQ is enabled on a listening AF_UNIX SOCK_STREAM socket,
> accepted sockets created by unix_stream_connect() do not inherit
> u->recvmsg_inq from the listener, unlike TCP_INQ, AF_VSOCK SO_INQ,
> and AF_UNIX SO_RIGHTS_NOTRUNC. As a result, recvmsg() on the
> accepted socket never puts an SCM_INQ control message unless SO_INQ
> is set again after accept().
> 
> [...]

Here is the summary with links:
  - [net] af_unix: Inherit SO_INQ in unix_stream_connect()
    https://git.kernel.org/netdev/net/c/0359338fd8cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


