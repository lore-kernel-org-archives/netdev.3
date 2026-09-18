Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DBC29B200;
	Fri, 18 Sep 2026 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690282; cv=none; b=TLA+kWY62QZb11wDobSxL955+/2Ol7rtulSWsKI69/44n7KLMBN2QYnPSI4Q9Ji4w05v/1fl5imCRfdLwf9HBPaT4y4FoMrnRHHEobcEA4EgVgjJrE51Pte/D+fsNStbwHdoenNq9ADj5P6CSmTlrkf21DE5zAs4TMsfw6oB/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690282; c=relaxed/simple;
	bh=6UyzaTHj42Nb61zXxDrMdwE0PO21iL+VJLeLWXfTc2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M4W685pq489WzCUVqv/HWRXf7d+SKn+r8HnJdgxGYyp7EqNpxhUE8r35PqvJP5ojj6R/YavrPf/lo0hz+9K/dx951vl8gpFgNkNxQBHcyzaoMUX5E3jnki7PWQ5S0ZF/Mg2FRj6wV09Z0H1dB832Rpu/JyHluBrZk/iGcjyn3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BggY5uZw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BggY5uZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0461F00893;
	Fri, 18 Sep 2026 00:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789690280;
	bh=kbJeC/Go6gyZrgRdAYHP2UoKozFrLhyATbaUizvMHHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BggY5uZwihXO3u4j7RwAIaqfwr1pRYBsAEMNdKoK+cYsdpXucSKIgqt+jmLhaeO8L
	 O8w1Hmgg4TBaN6SU8/mTMPm4jqO4kLdAGTziRf9+WKYPIK+YVDp9W8TWUMikqFpy0T
	 VDlet+cRqBEwWNRiwXOiHoAE6x0vBZSiRfAGvolW6oMvPjIWdNSEvZ6+z4anRzyT8i
	 JkcazdGFzQCEose3HhYWxQ+B7tHgyHt2uQ5TePkfv91XIDA5ereWMT5/HocGpx0mFS
	 qjGtkAZAYlTy29P9/ztrhigvPOXoxHU4y8wg/HBVmSryrIaaX/Or/MbT61dZOsAnFs
	 OESgZG57m/Ybw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56ACE380820D;
	Fri, 18 Sep 2026 00:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] rust: net: netlink: Migrate to zerocopy's IntoBytes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969021388.191233.9085303450165399731.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 00:10:13 +0000
References: <20260915144231.31932-1-sagartaunk@proton.me>
In-Reply-To: <20260915144231.31932-1-sagartaunk@proton.me>
To: Sagar Taunk <sagartaunk@proton.me>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 14:42:44 +0000 you wrote:
> Replace the kernel's own `transmute::FromBytes` and `AsBytes` traits
> with their zerocopy equivalents. Specifically, this updates
> `GenlMsg::put` to rely on `IntoBytes` for converting attributes into
> byte slices.
> 
> Also, add `Immutable` trait bound on `GenlMsg::put` as zerocopy
> splits the `no interior mutability` guarantee that `AsBytes` bundled
> together.
> 
> [...]

Here is the summary with links:
  - [v3] rust: net: netlink: Migrate to zerocopy's IntoBytes
    https://git.kernel.org/netdev/net-next/c/5e5916923759

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


