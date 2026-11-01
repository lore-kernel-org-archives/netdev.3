Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545484;
	b=1ofmJ0/yQF5VSoGj+KEQulEkc9N5Qhl/lhm1Mgok0aCzoN400D5mGaRYvfHyHEGJPDJH
	 O9g2QX0y/Pz0KFmDHHfOuo2LUL9GSouEVkLFogqKWnbnyWrOWIAMm15uqzOshezYHphP6
	 gVQBeaXkHHN7YZLWeFFnD9mgjQN/RNi9zikgNzKlLZHzmX94GMq5DP27h3E/JWBZyW7Mw
	 1vzXBNsmB3JerP2qF/SKAXLY03fNXc63H+b1lcKYvZo0L/4DfE2m3z5FW8He2PkR1b+Np
	 XJ/9AXFmOJ7p9inqv+jeC8SzoTnTIV2Yt4DKTHlHqM5AsX0rvwWzzNrOljKisv2GckQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545484;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=Ji98D1o56zL/mKeh3/RIbcy7fdPx164Rp3RmDXH3BShXWnNt8iInbZ5gw3I1iNGXRJgw
	 NNrgrMBg9+eLht+Jg/Go13ji3ic1fH85/BqjTO+ubRxXN5xSE//VXQuPyK11BsBky5EMx
	 ce29B8/JDE8o8xyUfz8gN3Ywlh1kkhKiJmXtaqqk1u7YNeHZWf+/Fvn/kYxT/8x/fdFYr
	 lrmrZLPT599zOJw1Uq2olGfamzlHP1jODlWM+uzlS6c1jlRG6lMIcUcq/qv5qfKH+hzrm
	 6EKEZrEcJrSI5eFrVjJrJLVkxekbGzqyvZ0aMO0m/tFUiuoOFd+OBelSwYBeeaCNg2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6tlSabP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4CB606A324
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A6tlSabP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EBA1F00A02;
	Sun,  1 Nov 2026 15:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793545483;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A6tlSabP2/OHpqZ30LMUTII3gqXUvxRO2/W/74Vcumzh5Lt5JhAMRcKHjVxBi5Ler
	 vUOiaLhpXT63OLrxkCVO+Ev95Vx6l2k5SCFvVKGSaSEZPDKTLxueJNArdDyJPPLraD
	 iCon2yOyvJJWgE5HgkuljfUpOju0f5wGorinprXXpizZkkIqlKGNkdDjTllgdrrDn9
	 t8ko/UlWTL6dUmrLiOpfbXS6FN3/Txrm4WcM57NM4nsgjWvkx0A2YCv2K+LYRuYU1Y
	 u7GzJKXUfG1xqKE/lPzwxfk1zhNnv7bgSt4O3nTW2c9W/Z+TTu1jWTIQHtKSzAcdh5
	 LpRrcUROByH8A==
From: netdev-bot+sinfo@kernel.org
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, toke@toke.dk
Subject: Re: [PATCH net v2] net: parse the eighth nested VLAN tag
Date: Sun, 01 Nov 2026 15:04:42 +0000
Message-ID: <179354548267.3286.5284066594506058325@kernel.org>
In-Reply-To: <20261101145841.687905-2-thnkslprpt@gmail.com>
References: <20261101145841.687905-2-thnkslprpt@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
