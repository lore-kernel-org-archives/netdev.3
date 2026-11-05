Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793875206;
	b=i7+WI0856R4idqLzni0RMtvgknN6d6+NbX8e8FwmZaDuaIB4ivVXOuZu9zbmfvcL1Zes
	 YdrUktHNNfBN5ZRHO2IcHJWlZINs1qpkUtogm/Door6TOuhIbPy4kRBDVnCF/9//glqbT
	 08ImONTd6HpXETOI1FpCs2tDgkwJgPKTI+qHQMUlmE/AwN8IygAg0ZEmGhphr7JvbMl2O
	 QhWm3dob1DUZYUB/1YSiUx1cWn6N30qqCxkYw/hQPB5NBaeG/ecKeH4W0k4oz5om9DNFk
	 VEGT30dYWYW65lmPybLUPZQcT66T0vWO2Jm/zqxjPEBiNOwUb/WYaLPV4bsMT3w5iAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793875206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=YklILbv3bPFdb8VwM9dwS1UkiPgxX1hg00WRWNTQU9c=;
	b=odWum8wGWDnRYc7PEilmD1m7K/v/CWBSIqA7T3DlOU4ZOo094P0Ybfabs8CWdCZP78QM
	 t96u0Ro/ERn7JnxfAa6jlHoF2q/zvrhnJzIIIe0kmmwAKMu6Z2oQGRyYOMkgtgmVJvUOq
	 YXlqSUyidRpChB5UmywPMBBp9hiT6MeB08vrB+mNIebVDkRwaYWxKXe2w4iNhz5VG3E2b
	 qAYtKuWI24Bu+Wi4Tt3Kz7GcyXffCCVZNstApQrWmyLdXx8L/72qk2ipRtbtPoPXdBelm
	 btxEW5oJI1O+M/i1XnNnjtxs3zaugolmXy/WJoF0mUyH15L2BUyQPHPRyTX3nybmScQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZN2dhqMT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD1606A326;
	Thu,  5 Nov 2026 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZN2dhqMT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AE41F00A02;
	Thu,  5 Nov 2026 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793875205;
	bh=YklILbv3bPFdb8VwM9dwS1UkiPgxX1hg00WRWNTQU9c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZN2dhqMTAsBeaHybh6h59fcFGtNXGyqwKh6qBAnZw2dnxRKaNl77ypLh9QRlWDWbq
	 qwBw2Fl0uqmx6NDxgvme8Nd3X2kQklwe3UPq4LApsdu87wzToKNqUrgoZk4So6qIpA
	 oeShsVrXBBieZojh5Bvn2296rnGEsDDHXSJ0iVYX4Q2NCvQiLgmzeSI5pyXwP/iy17
	 3i3n5fQPavUFYfZ1PwGPHPRp4INzILWlA95UuUcAePI4xtMndS+Hq60FyJ9P9k0RSa
	 sIBFCXjMfN7dw2uMv419+Y9csx0GCVIWWsCKSTITOqweqHclS+bBq6BIWnMEDmy0Z0
	 7PXqaH3x9222A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA1A5391AFB7;
	Thu,  5 Nov 2026 10:40:05 +0000 (UTC)
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
Subject: Re: [PATCH] ip6mr: Serialize multicast router socket ownership
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179387520450.3581681.4727389061337048747.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 10:40:04 +0000
References: <20261030042221.73996-1-kylebot@openai.com>
In-Reply-To: <20261030042221.73996-1-kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 linux-kernel@vger.kernel.org, outbounddisclosures@openai.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 21:22:21 -0700 you wrote:
> MRT6_TABLE checks whether the socket owns its current table before
> acquiring RTNL. MRT6_INIT also looks up its table before taking RTNL.
> Consequently, concurrent TABLE and INIT calls can initialize the old
> table and then change the socket's selected table. Another INIT can
> register the same socket in the new table.
> 
> rawv6_close() calls ip6mr_sk_done(), which clears only the first table
> owned by the socket. After the socket's RCU-delayed free, the other
> table retains a dangling mroute_sk pointer. A subsequent multicast cache
> report passes that pointer to sock_queue_rcv_skb_reason(). This produces
> a KASAN slab-use-after-free in sk_filter_trim_cap().
> 
> [...]

Here is the summary with links:
  - ip6mr: Serialize multicast router socket ownership
    https://git.kernel.org/netdev/net/c/c6b41de4dd9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


