Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794061317;
	b=Gdi40Yiy7C6Uep/MSqjMnXopN0+U1joNyG/4je+m/w0I+5kb8wGBNrW2buR2Rif83GrM
	 oqnndkEyMGyUIeFiAGTzywOg7n1gqhkAv35IG4wUGqTSojeMkILaKdce152rYz1/q3yd9
	 fLVXmBDi466xJpUl532n6RaQxuY2Ei2VfYCVUyXH0MWKoJWN/rFTacr2KycDDt9dfHZdr
	 7l7Upbd2BjLre4M0LdlruuT/UiiEutnyeSmYJRK5+Jcy5M1Eqa9h0IaENeOkb/+QvkgBC
	 bZsvXi88tXnEozOZNTX1wxOiJk1qKpLqlEZDSCzZQwi+NRFi5WM1ZwHlg1vxS4F0U1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794061317;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=MyPH1PUdIHSdnI0y/1nHJ7OSAnq/pOxRfv88Gx7uj1TEjZuGnZgDNnk0G6BgjLqppUbE
	 Fe/WYiz4R/WcUpfz8pvBv6ZzJN3r415HdS+LGSdFaENAqtsLL176wlVFnqMGc+K534/W0
	 cNJaKgYKbVMLqy25a6vCoBf6UvEkiGn7zLVJXe38jjycX0Lg/iNbhvQRdz44Be5dP10gD
	 RwxcPjSaxLcMmCcY5+guWiTzD3xTi82Z15+X47G//YYmvTukEXiX17KtPdG+0GOAxW8fe
	 jupSUbFI1jnT4/tCVLIA1BeuxZ1YNqv1L6Wfl8pMU3+FAOQXWgjMWh3kO4UDgcp1H8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXRNeYSD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EA2606A326;
	Sat,  7 Nov 2026 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXRNeYSD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F37E1F0089F;
	Sat,  7 Nov 2026 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794061317;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jXRNeYSD1UFTW+NzGat54yHQg16hpMnjBsqYjThBrrtvQyodflqHQeRKKA7W1RcZH
	 ALzByAeQiF62jKTemPxWK/EV7tJu4Ug+IoU3xITxOvOXWpxblr/TilmjeqsbWPFV/Z
	 DbaPxKh8rC376o04cjJlZ27+7fxdXsaWTOjuR47TpE4pD+gyYyn51uWNgCjguPHMJ1
	 N9566qdk+Ts3qOVOJpIi1yduyno6I1Umw6R+4gCprK4S0IDR1yIRb3dPt6gbkSAcVY
	 VPtt2WQ8v8N9UNuVfFstevm2w3t+fYpdu4gQLY0mNZa3oAfgsxw8oCf2YidKp2m/AP
	 os8f0QVy/bOfw==
From: netdev-bot+sinfo@kernel.org
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 yana06070@163.com
Subject: Re: [PATCH net-next] net: ethernet: mtk-star-emac: fix device_node
 leak in mtk_star_probe()
Date: Sat, 07 Nov 2026 14:21:55 +0000
Message-ID: <179406131565.488859.1019307996230359534@kernel.org>
In-Reply-To: <1794061182000.57993.3986467551914992480@cmss.chinamobile.com>
References: <1794061182000.57993.3986467551914992480@cmss.chinamobile.com>
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
