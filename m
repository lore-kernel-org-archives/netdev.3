Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354610;
	b=onCNYpAtaKTojSwkaW3nPdAl0kNIWcFAJjUpddswfbchG7TWUt63LyriZ0I9qTyaJQOQ
	 MkBxSTEFVyU5buHvqQ51NcivVFt8CerVv1f9SbFQA6iLFfLQC/iT6nVPKMzPSQEU9Tn9g
	 PVASxry6jQeEGYaFVsaxHYXJcBeWQSXBnfMZr7tpHkYATAYiUPpMkzMhdani0bTYyvSzE
	 e/ZhhjaI/HX1hCmeHo/WIIW/SsC6EtNMdyXPxcsMpDkJjG3p1MA+L3obtF0BDa+8kfxvw
	 xm5Fi0RZupkWapruQjJ+eXucFhgtKlECxzP4YhXf+g/FpC/1lrjFR9Gnxab4GkF4lPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354610;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=BlFhzc5ZGN08zmXM4I/NfmBwaM8fELgmngk5KfNoj8Q=;
	b=v9KfRoNToSMM/VU3tgLurcHjo03SZGWt93NsFfMvSZ/F7sUplQw2B2iMD8N5FODdk7X+
	 LpSaezZhIcfh1OaG7M4W1ivr/YmlIS3knjRKn/oMb2OWR9YqNN/RwAw50kFgQ5skNTzfe
	 BtG6a+rwMUh5VcjuKr8sNBK4lur9DtSKoEhYtJ29cuWWPhE6UrRTdfF7Shsmp6p8198QW
	 OLgzg15IAYYed1zTBPKWYZwmZMhJEdlhmcjSKJDAMf22FHFq//0qJlJjLxj9meJwoAZhh
	 +Zqsra2AIL+Ls31nZQBgnHg/TpzE6B66aT0sH1Ro37xn1lTwp5QsDhdi1CbkPUtWGdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsJdQyRK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C4C606A333
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PsJdQyRK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E241F0093C;
	Tue, 10 Nov 2026 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794354609;
	bh=BlFhzc5ZGN08zmXM4I/NfmBwaM8fELgmngk5KfNoj8Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PsJdQyRKsaNxINiIwUdZ/e7PMi0JNM8zYd1qjysZtf3xaa6z9OVy/6wRXqUfyJXEq
	 JByoPpnYT/ZXDS0OyJd7yPSCm7bQvmPwolMCm0dNud23EU8EMTXQk5k3RsUWpXDL56
	 prH7dghmNn0HaSweE0ttw9JwRmDHKLOu9uydHbirZ8V6wv+ltePiR+N9eZ42Tu8h6S
	 162ceuBfxlpTGvBPoZB9+a3uEWvbuecpPTu/DvDefryA85OYgIGkZ8bf/IsI/ctwpT
	 zz9ufmQE5rFx+LTADqw8mrzmo22h0zTnvPAHPLo3k28jsQggKYVfUPtjoLho55519F
	 duxKhy7fwTuzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D838139E8A49;
	Tue, 10 Nov 2026 23:50:09 +0000 (UTC)
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
Subject: Re: [PATCH v2 net-next 0/2] tcp/mptcp: Don't call
 tcp_update_recv_tstamps()
 if not needed.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435460842.120887.1387158068394130012.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 23:50:08 +0000
References: <20261105215209.3160316-1-kuniyu@google.com>
In-Reply-To: <20261105215209.3160316-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@kernel.org, ncardwell@google.com, matttbe@kernel.org,
 martineau@kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, geliang@kernel.org, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 21:51:44 +0000 you wrote:
> When RX HWtstamp is enabled on NIC, skb_hwtstamps(skb)->hwtstamp
> is set.  It is also set when one socket enables software timestamp.
> 
> Then, recvmsg() always calls tcp_recv_timestamp() even when
> sockets do not need timestamp.
> 
> Since it is called after release_sock() and touches sk->sk_tsflags,
> which shares the same cacheline with sk->sk_forward_alloc, it stalls:
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] tcp: Don't call tcp_update_recv_tstamps() if not needed.
    https://git.kernel.org/netdev/net-next/c/f8143639f2e6
  - [v2,net-next,2/2] mptcp: Don't call tcp_update_recv_tstamps() if not needed.
    https://git.kernel.org/netdev/net-next/c/59e3434a73c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


