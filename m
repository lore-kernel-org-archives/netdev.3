Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574628;
	b=mejlqJK+E+W9p7k9VRtgOzdfuIvqJjtVvL0uhrzwimpjKmNsoo3t3Lg8taLNLoEcQHFX
	 NV+ZLo7ZOmVsMPp0Bu4REiNB6X4ADtkt0ZYmGVB3hn2RZ6UPTcL8ytHAZlx91TzNBFxd/
	 ov8NO3BqF8sOiBPx7D0tAf7VgSA0jWV+UaMMrSMO5Fav+PW+IsIAWmAYJvAxLIkwvOTd4
	 xyMsKpresmwr3M8V1yWRMlYqtaBezcU6EhAfZ2A0fykzrq6A7WGascrKxzs54fo3vYZ9w
	 0dg4byMmMOt7OUBs8FQpd74m9DaZqnFiVk+d4xHClvCQPCCx9MByw2YCPLrDBEsP6NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574628;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=T8LEbC5Nj/7e8NKVpVO0Ci/FuDt7bXJsHNoJvsHPv2aPIY1isnd37jt/ua2QCseIhab/
	 nFiuM3FXNN1METmYfPiCkHj7Z6c2BQQzY5k5I3E8joY7MLMovIegTlTX95rOR41God93l
	 bjJl7bUI2xtIGNzrJmbCy3BlczjXmxmGC88gILBvG7szfuBn5Csvwj5i/CGxvDmj4snVI
	 HZ1bi/1saZPkp/da1evLum0z1ZsZDlFkpOl1++a4j34MEjrAR4rgizUdHWzSfBahcUCxy
	 KIutxAukAibqM30EP71k8Sq9bb1SLHWnuTU+VXkPNzKhr+Vyxek3qBNLeXuCK1Fm/NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YROeivkX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13973606A319;
	Wed, 21 Oct 2026 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YROeivkX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0022F1F000CA;
	Wed, 21 Oct 2026 09:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792574627;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YROeivkXCb65gOAk06ECi0hILHeWLBUP9TiXxe1j4qys6OKZUZfduoBnUHK6ts8ax
	 tj5/Qm4n5RlZ0GCg98Ycm8CDHHvqR/+bVa4R9e0d+fbX8QvDKYDuzGtJgYGQa+55K4
	 LbgnbhO6fd5ziuZCM+Krhg/aycNBmGvUvIfx2uZ0bIEsqBvgrPToBqx9jKy7rn7tnS
	 NpH2ovA8zTodCjh6uj7lbVNJ0lDSZ63hVc+Tc+zN1mLcMNT32n+WjrOIaFaN8N6VwJ
	 vO8ACWX9OA02JWuYiMF206pWm5/JcvluFhzccfP748PDppzD3PEWnCUybAV7OpNPjy
	 kClVrJwG8A9Eg==
From: netdev-bot+sinfo@kernel.org
To: kmahammadraf <kmahammadraf@marvell.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Sunil Goutham <sgoutham@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Aditya Thapliyal <athapliyal@marvell.com>
Subject: Re: [PATCH net] octeontx2-af: Fix representor flow rule PF_FUNC mask
 and channel In representor mode, an AF-installed TX rule must still match on
 PF_FUNC, so do not clear the mask when rep_mode is set. Also, do not
 overwrite a channel already provided in the request when the rule comes from
 a representor device; only default to the PF/VF rx_chan_base when none is
 given.
Date: Wed, 21 Oct 2026 09:23:46 +0000
Message-ID: <179257462649.3290.12613681924217714517@kernel.org>
In-Reply-To: <20261021091736.2406505-1-kmahammadraf@marvell.com>
References: <20261021091736.2406505-1-kmahammadraf@marvell.com>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
