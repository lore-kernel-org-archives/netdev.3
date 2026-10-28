Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793230837;
	b=iMcPAMuW1P0W0SAI+BL9a3kmFyOMzwg6TH18MGRSKKtEZW1RWeVx/Woffbq7keZZ3IVd
	 nIAhEcmtSfGE8DKFnD3m8T0hLJ1nRlJbDDWGFkHpxuqn6OLrGmhp8YlM9yV4fXQzWQ+ki
	 2SBWXjAH03iAZf2cyfavNbqCxgoZBt4G47utrIJ68hyFbUYVifeL3VR/iC7frOcDr58DT
	 3cADls4QeI8+Oa/alFo253e+908FuGjJGyWBSBPIWc0uZrNr7/IXERsCzWKC8bw8Yq9eZ
	 amNQ5ShZVRtmZUAJXscPJoiyUtNtTCeBAjwahP8i3TTT8occIBfCsh00NxOVqslQ8wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793230837;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5wu2qiajMQZ+U9rvJTXwiY6+VJCvvVDv1gosV+MSrrE=;
	b=uCbMIFIve7SAqRZSOkqS0DvVDOM/oxyEJTTTNf0zF9OuCLwN6Sw4ew4cv8jqnO68rhfb
	 96LBkHwUBFwm1SPqATduZfml32RWnAyw1Tvd2W3cEMqz6tM6mOkEsZyHW4iffkD99tKki
	 phap35HiaoaxA3dRHuaxPs1p1OXD304g6lA+8eC52vyT4lllUzk6ctnnn67HClhI7+0jE
	 pOXYpCnorTk7h5hOZgh1+un4QtBv8sACug7IWXknxMIC/AEzf6om8T5Y4qiIE2XAJ8a5E
	 nFrNg/SHakQkk5m9O3bnB+/M0fhnf3f/adZajlhnsiXMw2hy7ybQt3gifOVcaw8BIcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zc9CTz0g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FC1606A31C;
	Wed, 28 Oct 2026 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zc9CTz0g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8060C1F01825;
	Wed, 28 Oct 2026 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793230836;
	bh=5wu2qiajMQZ+U9rvJTXwiY6+VJCvvVDv1gosV+MSrrE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zc9CTz0gx8eEu4dJk8vg4zPiFWo1dEIug24Q5/zt0kwxwyNhFPG1GwI08LhuQZh+v
	 sWXESpsNV9rOz4geEc8H0X3AEteqsyh+T/ioZFnzDz/1ncFgizwmjy1KIoSHfy+DGt
	 rX0OdXI6FwXUZ1t9maSwxNWRkKvEF7HsoEety8YA/3n09uEFALdI4eHyIXBdPS9uSQ
	 1snCieg8HmE4RrHlXvxJ0vmdEVKolG5lGWZioO1Jor/PBaniLx+DiNVrJHWViHBJA3
	 iJPLPrSgm6u45Nrh08jeI9NEOr16CDVHMknW+2DxoL6GT9jvVYCVumLIoNLdXx976X
	 pA848skjlZTgQ==
Date: Wed, 28 Oct 2026 16:40:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: vmukunda <vmukunda@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, "Subbaraya Sundeep" <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "Nithin Kumar Dabilpuram" <ndabilpuram@marvell.com>,
 Satha Rao <skoteshwar@marvell.com>
Subject: Re: [PATCH 1/1] octeontx2-af: widen TX scheduler queue index to 11
 bits
Message-ID: <20261028164035.0352ee61@kernel.org>
In-Reply-To: <20261026062316.754904-1-vmukunda@marvell.com>
References: <20261026062316.754904-1-vmukunda@marvell.com>
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

On Mon, 26 Oct 2026 06:23:16 +0000 vmukunda wrote:
> Signed-off-by: vmukunda <vmukunda@marvell.com>

Need a real name. Also please include the response to the 3 questions
series info bot is asking, in the commit msg, when you repost.
-- 
pw-bot: cr
