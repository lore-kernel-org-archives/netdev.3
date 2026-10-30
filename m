Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334260;
	b=Fv5TXezJhXBxpdYbhEfgIet2qbgAyI4xy9Smp8FiXb4prX1Xwu/qWUJtgIRBWouRYPav
	 +itm8pCTxtAz/KaHcunwbJhXF6jrTHumlPeQs6Bl9DbQ7w3uihVzJX0QXAErAp3lOWGdb
	 Ox1ZkT/ZinMDRd/+3R9wZx0+QgyXyMY1Pu9jNfJbDvDmSNI0es1LaGSi10+5BdtQYkI0u
	 chZNAlvWPxtXaYteaRTypc5X0IBzLvQUMOAKh2ErzAoKpIUJ/6bxdAMdBQR+kc1uICIyr
	 P2xbp3CtOa3YTi7jLuj4WIabmlCwVKCKDHn8QMPVy9dk43rV4vKBXn2rP/3ZCpLGBbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334260;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=23sYVdgVvq63IcTsFNMUVg5/Rg2aDu5BspVFmTVFACbMM4MYeLYAlJ+QXbEYtCBH/Ive
	 8ern/ao5EODtBCz7mMjloA7D25bhNoLaBasHWhI4alv3KkP++L3caRpu6I3cVhr+oeyXt
	 fKEHvghuEqSXKgM2r0iawg0yiXndxAL9TpOxFFaHjbnVpFyuDvt1QnPCoSaQCiWjAgvNw
	 J/JHtl9jLQDTs8JI7I+YzIlLd9CnsF9UoWDauJ7hEPsLYjdV+T289M7KZkZ7Zqfg/IPr+
	 GrllyhXxROG9bnA1eiKOJtBVT6TtRGudxxMckn/eM57N2JxOEqinIEyHyWA7NQCMFyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXoT7Vxj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958C60A2601;
	Fri, 30 Oct 2026 04:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXoT7Vxj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450841F00A15;
	Fri, 30 Oct 2026 04:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334259;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BXoT7Vxjj90e4Kjq90CHkt3q2Ykb2E8D5w1Go4IR/XBST3ohR01JcqAKvCT6/+rBF
	 /gimWC0RXrU8L7jT2rqqN8z8RxhQQLytHUmWD3vYcusKpSxJAPIGoIwZiwVz7dnU3w
	 5wFuTH/hqWrzsHSI+Ftinv7294qbSJM4snCQV/eFourcTYfz6VVtLaqFp/STPnLTJ7
	 t4dKd5ZL3o8N6WXO3DkzELmew0QVXF4tMkZ7mWcVw7NtfY19/9drp0zYNiFNm9IzD7
	 +5RmuYNiNMW5+7Eq68OQo4z8msabeputpH7ru4bECqEgUUph0nUSp3KVMxrtox/tGI
	 SLVB+8FZhARPQ==
From: netdev-bot+sinfo@kernel.org
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org,
 outbounddisclosures@openai.com
Subject: Re: [PATCH] ipv4: keep XFRM headers out of corked skb lengths
Date: Fri, 30 Oct 2026 04:24:18 +0000
Message-ID: <179333425883.3327.4360202216473786007@kernel.org>
In-Reply-To: <20261030042229.74068-1-kylebot@openai.com>
References: <20261030042229.74068-1-kylebot@openai.com>
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
