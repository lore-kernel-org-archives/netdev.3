Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267030;
	b=P62bo795oxwEfITpbZm7frNoOkP7zuloNhipql8lrAAw1LNtYY4Y2HeIadD1dGjmXlh1
	 qmCr/g78UU2L+2Rr1lvXNoaNNA710JolNnnKWovYDYpArj1KAHPSzQ+Nzb+zzHRUu8CyF
	 DIBNDTdjxriskvG3N5V5BhPOiEBHiFaWjAQtNGbBhoh/60zKlDnBKujgH7JgE8a51H9p6
	 Ue47LxyUw1UiT9XkV/0d+K6ZUS6ujcDkC2WBgMUNjOIeQBMJpDIBcazLZa7E7GMcMrBTe
	 sOKbEaaa8KgY1OkIwSWhYwlEh3tHMYRE1UNT8Ud1tdxmyqJBCCQpL25HbJBPTeqIJMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267030;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=JmASC/2ykPTmrP4QNaDXpA3LsM8BcZdtf8jvbdaN/YE=;
	b=ODiHY5fROJmbms+86k8VI9bqH/SnFSqkb9kzY2PcsFEzLlF7b8OW08bhw00QMMeL2ydd
	 JTmzUB02RNPAMnmdSoCB5Xx/Ox3JXPAz3vW+b02CCvqFMhoMOIWkNPho7PgJ1hh+UH04D
	 1ImssZWLjTOpAJgd3ODrV9vsQKlGFYyCAedGS/zLsM0GRvdoMWdh2kFBwjk/cr35zAsmq
	 yRzmD06+trGac1y7Z9JonyXNILC2RvNwYclin4CnvW7CoVdtXA5sva7q0e80s+/FhcyoL
	 N5wgUJ/szmvE/pByZj1PDcUS1slc95hrMVZ5oPmqncBh+RE5T7HZxZtXqkdGnSAT7oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJkJYljb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B789606A326;
	Mon,  9 Nov 2026 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJkJYljb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BA91F008AB;
	Mon,  9 Nov 2026 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794267029;
	bh=JmASC/2ykPTmrP4QNaDXpA3LsM8BcZdtf8jvbdaN/YE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XJkJYljbRx9yqJVdE8hLep9GsGmSyaYObPKs3ZnLfiITnHXC03hfsbWZtS80Y5Op8
	 jjTaTRWn8+GZ0/4l1zI9uuQ14/51ceSctblK6uJ0/2NvZIa7oOcRqEBQmsrKAbQf4k
	 E1+Q+H1m8Gt4xhN6Yz3Ohhr6Q867/oGrzfdB/PfXQrwr5SzUB2FQPSvOMBE8FZTWae
	 T9HSn6EHYY7IpiimaZnPgx6k0gFy0Dmnqg/LWjw9qdvmzXgku6c5BcgyjbPxtAQDlH
	 mLQ38qSrkS6r0fsLS3tq1fXmk7/qq0wuchFsExGOMqfyIwNpAMC9mKhDNk2zO4BkUl
	 wXZwkKOp0BYUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AB847391AFA5;
	Mon,  9 Nov 2026 23:30:29 +0000 (UTC)
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
Subject: Re: [PATCH net-next] rust: netlink: remove unnecessary bitfield
 transmutes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179426702842.3543549.289908194176999743.git-patchwork-notify@kernel.org>
Date: Mon, 09 Nov 2026 23:30:28 +0000
References: <20261102023301.206989-3-blum@kernel.org>
In-Reply-To: <20261102023301.206989-3-blum@kernel.org>
To: Thorsten Blum <blum@kernel.org>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Nov 2026 03:33:03 +0100 you wrote:
> Use __BindgenBitfieldUnit::new() to build the bitfield.
> 
> Since the generated type implements PartialEq, compare the bitfields
> directly in test_family_flags_bitfield().
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] rust: netlink: remove unnecessary bitfield transmutes
    https://git.kernel.org/netdev/net-next/c/ce8659b5c8ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


