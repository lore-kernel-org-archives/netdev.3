Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F1131077A;
	Fri, 26 Jun 2026 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782441119; cv=none; b=b6R5uuqtfmHEjFK3o1sEATflBXnr/Sv3ao2SCtavAkEhW/I5gZqTrMPwua5xKgpSCG/h31V/ZV3MsKGY87PXzZ2L43XENb+T2QyizpxWEguuEIJdKrRfLJzyqZPs73q/HUq1mshl9LdYiTOAkorkK1U8ThRuBFnvipAwlQucdTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782441119; c=relaxed/simple;
	bh=2DK6o+T8/m0WavloxHsd9nIPURoul+8ckvajv4hEXkU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o1YFO2q6x5NMfnFwfD/J64Q0ds7KwPlpr44boUeFAFodQTVuvZf4XIO/rPGyOr54l+k9ijaOmhFQnfiaQBOKAvVGGovr1Kx1bJxo8rpKP1KzUqvtFob51BwGKg0bC5EEuJOE7zeFsqB/2Dymp9ZnqqmXRm6/XqG2dzBHUDDUOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIAz2RoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIAz2RoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87161F000E9;
	Fri, 26 Jun 2026 02:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782441117;
	bh=/97xayyH6bkvzwCjIpn00SFdcQECSqIVrrDeYSyPZ8I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OIAz2RoWdG+J2KdEUibsU3itWOI4x3krg/jEN1avfrTNGEYn3Bj90SyDGzYaYzRgf
	 OOZfr8SW1pnLeHb7qDq4p9tf/jw1RcmCiHJb2MW5qJdMiB/AM8xeX8FMy2jnn8CLzS
	 OhDvGbureBLEMxY3T9xbXf+fim6O6OgcQ9X4GvmCyNGd3uPPgKU8EMcg5h60jm24VR
	 O6m4M0meK+j5BXCQTjCoGbwEEQKniI8tT1pcRoAlOETTQRDlML19xwU/GNkxIMcFbk
	 IGE1RHDXt121kAn9MAx8aLq5ioZxZEmSKGH0L5MhrQpI5pyqC5gaeSWaCp36667iyK
	 75minc5DOHNsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5690739389C4;
	Fri, 26 Jun 2026 02:31:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 00/11] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178244110477.3816447.15045146244186363464.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 02:31:44 +0000
References: <20260624163819.3017002-1-dhowells@redhat.com>
In-Reply-To: <20260624163819.3017002-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 17:38:07 +0100 you wrote:
> Here are some miscellaneous AF_RXRPC fixes for more stuff found by Sashiko[1][2]:
> 
>  (1) Fix ACKALL handling by adding two more call states to simplify when
>      ACKs are valid.
> 
>  (2) Fix connection leak from AF_RXRPC recvmsg userspace OOB handling.
> 
> [...]

Here is the summary with links:
  - [net,v3,01/11] rxrpc: Fix ACKALL packet handling
    https://git.kernel.org/netdev/net/c/9b6ce5948085
  - [net,v3,02/11] rxrpc: Fix leak of connection from OOB challenge
    https://git.kernel.org/netdev/net/c/4b28876e78fd
  - [net,v3,03/11] rxrpc: Fix double unlock in rxrpc_recvmsg()
    https://git.kernel.org/netdev/net/c/a2f299b4d551
  - [net,v3,04/11] afs: Fix further netns teardown to cancel the preallocation charger
    https://git.kernel.org/netdev/net/c/2daf8ac812c3
  - [net,v3,05/11] afs: Fix uncancelled rxrpc OOB message handler
    https://git.kernel.org/netdev/net/c/a4057e58b070
  - [net,v3,06/11] rxrpc: Fix the reception of a reply packet before data transmission
    https://git.kernel.org/netdev/net/c/a58e33405acd
  - [net,v3,07/11] rxrpc: Fix oob challenge leak in cleanup after notification failure
    https://git.kernel.org/netdev/net/c/092275882aec
  - [net,v3,08/11] rxrpc: Fix potential infinite loop in rxrpc_recvmsg()
    https://git.kernel.org/netdev/net/c/67a0332f442e
  - [net,v3,09/11] rxrpc: Fix socket notification race
    https://git.kernel.org/netdev/net/c/e66f8f32f501
  - [net,v3,10/11] rxrpc: Fix leak of released call in recvmsg(MSG_PEEK)
    https://git.kernel.org/netdev/net/c/4bdb9e471f5b
  - [net,v3,11/11] rxrpc: Fix rxrpc_rotate_tx_rotate() to check there's something to rotate
    https://git.kernel.org/netdev/net/c/a5462da5a349

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


