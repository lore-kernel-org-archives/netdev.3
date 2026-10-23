Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792793080;
	b=safrs9YmZAjkEjZIbMe7xbXneksjtSuhb8IE2h98FWEogYeHhzIaivU0H5vYg+8262rY
	 1DgOOUiGLiSnRq4Sao5UqWanfJKYhPlFZTRN5gGBh0Dyi/qrF+XGM5HWmkSP4cfJ2w2My
	 MZ5C9yQ9dg1jOIcbFzKuX8z7It5xLaCojOdAHfYa+AfHeTeFkJmheaCA5Gw2Drp2DBnO2
	 lySuTpv8fTysp5L/HPYGCxkfWcxVIdN0wMo1bOQCfdZrckhzZkPh0tYUB6AiZ3RuUyILy
	 E11SZC7lsrf+XWi+gvSEreqayUcuBWlTgE/zCa9HZVQj+7dYz9GRgmTP6wodjaatqpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793080;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EPP/d/Ya0/T2FxJwfpmQrTkWP988A03MGXlw4CVnJzM=;
	b=z1tORRkE3rYBUeOhjD5I9fBLVxNAPEpkyWk8+X79wU9alwA5GDS0ER1mVHVDlVeZLX5P
	 j7NAGii1BPtCTbpulS5Gb7TYTylqZDeUAXxr/wZhSgNGhcCMR8k98ajl+B35qCm8DWxFB
	 I8o6sILqslDRMXDPl1Ldpu1KssX1mQmexMHBNE+omzYwCey7z4stKZnQVph1rR/BZL9eP
	 HuIUVSuvNsX0I11Tvcm+a4+fclmhXmoq2yqyQBk/i+KEsHZDF1CVH5DXKaWzysqHx+ulR
	 iLIM27vhbHE7bKMxO99TMjVCUke40uegFZxma4L05CAwa7EF9Kb3JY+9Pd7WhEkh27Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NXrTMK4Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E5606A328;
	Fri, 23 Oct 2026 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NXrTMK4Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A211D1F01825;
	Fri, 23 Oct 2026 22:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792793079;
	bh=EPP/d/Ya0/T2FxJwfpmQrTkWP988A03MGXlw4CVnJzM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NXrTMK4YMtlG0XHeAXlo0UnQ8k7l3DysJlAuT7a20Vxum2WUpnpG0glvE02DrKp5I
	 goRn+oUtCx22hLrjxQUxxSQPzAoW7INBXfru+wshJghgJWf9BdTmZpxVWJWPlqA0HO
	 YNIHvO+mPWj/08dRJcdRVhHrXOfw0EX6vIz84kkLZniPDy7Aeg5gK6eLuqu7lUGDen
	 xxx9TkW0cojafHj87KZnMPH2mCaZHAYRFUbA/LuWM2OG/iEw0f+i3dPJ1dabe0LZ72
	 h97fRDyuw+FgNVcu7lO/7ltg9oIxz5rCH5ZQorm3Q6ezGuPVQX2iczZAyLcC2sgYJ/
	 hwVNINW8koqJQ==
Date: Fri, 23 Oct 2026 15:04:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, jie.luo@oss.qualcomm.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/1] net: ethernet: qualcomm: ppe: Fix multicast
 queue admission control access
Message-ID: <20261023150439.4fd52428@kernel.org>
In-Reply-To: <20261019105950.3977665-2-mail@tk154.de>
References: <20261019105950.3977665-1-mail@tk154.de>
	<20261019105950.3977665-2-mail@tk154.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 12:59:50 +0200 Til Kaiser wrote:
> Multicast queues have global IDs 256 through 299, but their admission
> control table has 44 entries indexed from zero. Using the global queue
> ID accesses registers beyond that table, leaving the multicast
> thresholds unconfigured. Subtract the unicast queue count when
> addressing the multicast table. Keep the global IDs for enqueue and
> dequeue operations.

No longer applies. If the patch is still relevant please make sure to
include the answers to the series bot questions in commits msg for v3.
-- 
pw-bot: cr
