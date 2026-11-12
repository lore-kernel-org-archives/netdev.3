Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794456822;
	b=bPLbIjXC982JVXtwPP82g6Gi4LnSqqgZNgSQZcs1iYNw0AvZJT1/gBY5CG5o4S9zT+x4
	 Jy50zLgI9ESrGL66e625oE78Lwy3HfS9OfLmVSx8N+kiqUWaOwumKykD4XYMo7L7NJ2LR
	 TRTo2keUPMjmj3gEDxhRelxN1555lbIcpjE5zwH2gVwQTZp+KoImBjP493eYXcrLUQGpu
	 d92bA+Y8kEDPgR95Xj3jq84KIt+G/wVTKC4/i1JmTvtjIGIxPc5CgSAQfA8VgKJX6o5/r
	 pE6j2mQLoDBK6XffPWxMSi/nFtmFpey3ohLKUS9ZhdDNBpqOYuh7BuNz1e7W1RFJe2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794456822;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	b=X9KoB1fzaGxOXxZ0cndFFQ22o27kDx3z5jY/Z6rT2f6Z809pm8PnTWsTJ6SxvRu968/d
	 YpojSoV9Al6lCaMK8xREpaT81REuFm/G5dnkdGfAIn6DANPd4O7AXyS5VsBr07/U08+2h
	 peKPLHvlvcZDaFaj9j35PdQafGXa1936/nY95DX8B9YLs4RPR5eAK524yImvTQpy1M+5G
	 EIf4504XLaxlgEhppaG1FivLD20f6nhj1zdpdVO/wfpGzslKOEADrpkJOYAn05u+9ungw
	 03L/7ccrkfW59q93n/n0IsVaZ6MGAR9I+WxhEbkA3CCERq1tdJ8L5UAmXQ6lHf07vhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBSmcK8U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA14606A321;
	Thu, 12 Nov 2026 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBSmcK8U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09601F00A05;
	Thu, 12 Nov 2026 04:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794456821;
	bh=80POjU5WP6ctS0DqN7hA/63JAQ8Agh1hTny2C1kJcvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LBSmcK8Uq825T5Yh2FSpWHL1M7tuqT2t3wXpKRLlSLa3uXS1Nv3aaquyIJ0DLZ2Pt
	 ch5YVpbRc/xMp0mCHRhrjwr27PJVHPzrOT6G0V+upyRrRFbhdMc9Zfs1Mu7rkBa7i1
	 GosTsaTx/xyD2TcPFv+RNsXOZRIfnZwcZfo3brlsP7LwkxySQpVFffLeoSBTtkfyxg
	 qVbJQ5V6K5o6VyQXuInRAOl5bKrDVl/yOk3bvEt0/A4BkPhEP9Wgw2yXOaTXP5Xg8p
	 Hgpmq7JgCguP2qA/rkVi4XI4xGxm2lDBICYTRWsYYu6TxiKyu3/8AxczmffW5K+uAC
	 mXDxc5vbw3JYQ==
From: netdev-bot+sinfo@kernel.org
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yanqing Wang <ot_yanqing.wang@mediatek.com>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 yana06070@163.com
Subject: Re: [PATCH net-next v2] net: ethernet: mtk-star-emac: fix device_node
 leak in mtk_star_probe()
Date: Thu, 12 Nov 2026 04:13:40 +0000
Message-ID: <179445682040.2168702.1032780874409478036@kernel.org>
In-Reply-To: <1794455490000.585551.2561101329908158128@cmss.chinamobile.com>
References: <1794455490000.585551.2561101329908158128@cmss.chinamobile.com>
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
