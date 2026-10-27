Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140825;
	b=m01OdbqF34fJCQ/0NFPIGYLsGudKOgpZH/EUUreLRahT8NHrwC8VDwvMvoZloltp7dVR
	 DGPf4Vh7WEgrT3H0fgRnnTWipnzZboD/bvX7PSySY/HsRQxlTPaTwo/sYlWSthsvMREky
	 C/7N07wyZAL6YMPq4ftjxHp7UGJRIvwsdg/KZ/3Jqj8exHtwIdk+QgJuMap0fWdfOtIm/
	 uuuk179eZkLjhiICIEybVxEKitfvypQ6WUFjBYGWMKEQaXq8edmLx3Mstsco4Q53l2LeM
	 7LJf2lrhheMC+gule9qvBnocPESn02spwiKLfIs5M567R4V8xvLVlr3QV6rQUqMA/wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140825;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QIfX8wI4BaY3EOa8JEO41r1+x9SiDeIv5YiniQCAADQ=;
	b=MSEjHLksn1iEXIXyRTDNLkTlzZBV1IlhalPfTxn4N0ZbRGBpB0F/yTuuK0TTYg/bff/F
	 x/oHooHht99R2mnGVpkO72RrCkryn00I05zcKV2QJZFtFEObcaP0Y34mKga6h1cSPDN9R
	 pBfaR+a6i7/haCWNVAPEK/edOJKeqdHJpsLr2HuYXKCtT1SiPW6uisxUpmBNA7aWEPFD2
	 87AlykkwuU79o/wKm7MVeUDxTJ76IMt2RgSfezocGigjwueby5kHYkMvLMN227c6N44rz
	 IbEOVEY5KcBsMoehW68ZWw04Z/dovjmuhqOXJdw15dRQaDcKxKaZdGXrP1xv/3oHXAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ff9X5lc1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF8606A323
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ff9X5lc1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139E81F01825;
	Tue, 27 Oct 2026 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793140825;
	bh=QIfX8wI4BaY3EOa8JEO41r1+x9SiDeIv5YiniQCAADQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ff9X5lc1sIcNRLzA2w4HWHYo9RX+YY8QJwVULfxSUK5J+2XH5XsM7nDem/fTIy037
	 LyrUvh8buByQYJcmnkUGiW9fAsgp20mZgMRnTqRn9FIJDfvjhkLcELjH+o0zzCMK/2
	 XqecQRb87E+WuzUGnPM844ScquIchABitTIRwsnmz2LW4OAoKn5qL8Nh7QRBy4qxDm
	 6ZkZSWRnxDQIT4HhK0Zs35lth84Kf6tUAAskHlS4VPA2lAQCzJQ9n4rqlPIc8svTXQ
	 5Zjn//2nxSFMeLP+aBAC+Tanotc6HpRMg6WN/dIeiDKfKnn9598enMjXY0UFyMiq+S
	 wYT/3acKt7U+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0738D3AA940B;
	Tue, 27 Oct 2026 22:40:25 +0000 (UTC)
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
Subject: Re: [PATCH net] net-sysfs: reject a one-entry RPS flow table
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179314082346.370091.18360710136387266095.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 22:40:23 +0000
References: <20261021155522.67521-1-phx0fer@gmail.com>
In-Reply-To: <20261021155522.67521-1-phx0fer@gmail.com>
To: phx <phx0fer@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Oct 2026 23:55:22 +0800 you wrote:
> store_rps_dev_flow_table_cnt() accepts rps_flow_cnt == 1.  For count == 1
> the round-up loop leaves mask == 0, which is stored as log == 0 in the
> tag (tag_ptr |= ilog2(mask) + 1).  get_rps_cpu() then calls
> rfs_slot() -> hash_32(hash, rps_tag_to_log(tag_ptr)) with log == 0:
> 
>   include/linux/hash.h:68
> 	return __hash_32(val) >> (32 - bits);   /* bits == 0 -> shift by 32 */
> 
> [...]

Here is the summary with links:
  - [net] net-sysfs: reject a one-entry RPS flow table
    https://git.kernel.org/netdev/net/c/24927bdf0f62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


