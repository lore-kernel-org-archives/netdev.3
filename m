Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616206;
	b=ojrga7vcv0ttDkNmtCdvsh7iweCst0rwR3g+s04WarFkugwX1dKqArQTJ3HLPBlZNlta
	 t45ZKSD7Ln22s7/ZbFAGxlgmHhk9Vdm8xBVBJT8mcI6hntnM1EebNa+UNflAo4XZ9xxZb
	 h6lj9qim9FXtwY4JB35DP6gSx76ASF0Ujfrg1zVENbxSahHjd0Wi39PNBOq3hAfzSdg+A
	 sXheHK/6piVoI8ChLbjkR9ULh1oQA8Wk6HD4GuS/ffApoMavFSUC+wQk1zCJ9f4pc3pzA
	 cs4sRFRzZ5VQH40ThX3w9wjdg53xbEdS0/P+XJffJphnof+NWoO+HFUNnznxn6CFgVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=PuFa16fBpGiZU3eeEbBb2FuWXiexswnwiNwtYOnIbwQ=;
	b=vqKFrcW4XacPBlf4CKRVDVDyKmlY+h0bu79QbzX7lET2/LSb/KkgXYn4qk22++Y1WyPW
	 pWi0VU7UwIQnG2BRUFO5QMCaWLEK+DXdgyYv6WxT4HSXb6Q92fW9D/mJzGDopvNNg65sh
	 HwmkExQHVJmUlMjYxyhep6oaZqUQed12wE+JdGfdLuPcJz9wSly65JD4HeSDHYddGYecj
	 jO3oDIgzffa/GUFq+NYAdFKPGII5UiY9Pv3rgTzoSnxaIGKx4GqVBP734hhnGbg7fF6b/
	 neS0CHPgAZZwTYZSPZcMUZsgL5gOF/oMHdLEZL8DxM4/3akKdlQNwYR7kC+6CmXMjJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMdUrs3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DB2606A32E;
	Sat, 14 Nov 2026 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMdUrs3M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6DE1F000C5;
	Sat, 14 Nov 2026 00:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794616205;
	bh=PuFa16fBpGiZU3eeEbBb2FuWXiexswnwiNwtYOnIbwQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JMdUrs3MCQMr37D6TlA96kjUrcxeETibzy+T6x7mJrKtq49Ztbs7fbp/+Fj5EhFQS
	 8HF9l8nUp4QToiVBBp5uSNXcTe596Fj/Q+mopeeSkgrbQOgYM/3JFhBSuU9EWiPGZD
	 rcO15AWaKQxIWaPIa9vgHOBNr+/kPmBCBp2dh8WpsckRNshelwruZJbUdvCQpUy1LZ
	 DxCXN8V3Hyru8lqs7+D5FMTY0j7GDHBx0of2i76B96t8nViAHxu61A15mW7gbFGAxn
	 xzPFUWp286YeXXX/YGEia14eKGanZNYES/fsmstSBZATevd+czDrceaJeeZUU1Q+kI
	 xs2zmmkRWMK9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44A2380821F;
	Sat, 14 Nov 2026 00:30:05 +0000 (UTC)
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
Subject: Re: [PATCH net-next] ipv6: reset all.force_forwarding when disabling
 all.forwarding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179461620453.1914440.16207711907487044718.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 00:30:04 +0000
References: <20261109-ipv6_reset_all-v1-1-815dfd508246@proxmox.com>
In-Reply-To: <20261109-ipv6_reset_all-v1-1-815dfd508246@proxmox.com>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Nov 2026 16:53:08 +0100 you wrote:
> Disabling all.forwarding resets force_forwarding on every interface, but
> leaves all.force_forwarding set:
> 
>   # sysctl -wq net.ipv6.conf.all.forwarding=1
>   # sysctl -wq net.ipv6.conf.all.force_forwarding=1
>   # sysctl -wq net.ipv6.conf.all.forwarding=0
>   # sysctl net.ipv6.conf.dummy1.force_forwarding
>   net.ipv6.conf.dummy1.force_forwarding = 0
>   # sysctl net.ipv6.conf.all.force_forwarding
>   net.ipv6.conf.all.force_forwarding = 1
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: reset all.force_forwarding when disabling all.forwarding
    https://git.kernel.org/netdev/net-next/c/a76e8bf4be55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


