Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EBA3F4822
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145781; cv=none; b=BDScEoIZ7uR7Rhqum+uHbv/Isdd0nerOGK3VjEAXGHN7Ab6ARNmRdDJgrrnKUdFBZYV4Pgb8JTohUcwls+JTmgIFLMakPc+JbyQUgnshfu02oMSyfF65Lzfl7Zx6WrABrp8gtvBk3RZ0UkWfq2RiYTmcoiFgbFc+5BqjWd1fLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145781; c=relaxed/simple;
	bh=h8G1pIiq6VtLyvV+aP4EmHx/rxiH5Izdxm0Ddpq8ezc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RBJljbqWtCyavjbJoS82Za57hfycxswvvRik2sRdKhZjG4qoXz9TXuDw5O0fBx8MbEjkdStEN9oCOJIiGN9H2LTr1pF0jTin9Cfc2eboR8P/peZ5fftZjSUNDNJUTbD5Rt8Thr4jbAQJwyxF3SGSTz7U08JEJYM/Ux1q+UmeZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=M0b0omDY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="M0b0omDY"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66R9n2oO52998920, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785145742; bh=VSrDA5sHK2XxKNKLSfglzXLrclg/P7nADasOUc3337U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=M0b0omDYLa/a4qG+BUiZ5dys3vWKyGW8IiLkjfx2PszQUEpVpJF+FQWmb7+lEcgwb
	 gFt6xYlxlL8+lXdt1h0aySHvRUO6UbeQ5VmG48rrRu65EaLMJDDaV5CKVp2sELLMH3
	 hASPfrjjxUyB7BG90f+WshP+wX44oArin+Q5PtJ6GjBTJqN4rnQ3fgUvo6vWdmf+9T
	 gpjIJ7XKNBNzjVXoDUPMlFuYsY4j62ejBjrCZdFpPV2D+ztpe/PiHN6XKp9ShFoZHN
	 tM6KeRQnbYZW/7NbdmdyE+EgaVvABdGU6YX5EO/VPM9iFtQ/TL7uRVew+ed3BTJ5QG
	 ABdw5P2bgDkfg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66R9n2oO52998920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2026 17:49:02 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 27 Jul 2026 17:49:03 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 27 Jul 2026 17:49:02 +0800
Received: from RTKEXHMBS04.realtek.com.tw ([::1]) by
 RTKEXHMBS04.realtek.com.tw ([fe80::552f:8b32:656c:c395%6]) with mapi id
 15.02.2562.017; Mon, 27 Jul 2026 17:49:02 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Yun Lu <luyun_611@163.com>, Larry Chiu <larry.chiu@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH] rtase: fix double free of multi-frag skb on DMA map
 failure
Thread-Topic: [PATCH] rtase: fix double free of multi-frag skb on DMA map
 failure
Thread-Index: AQHdGLos1Xhxq8chuUmhFuHTG7BuR7Z62NiAgAZK04A=
Date: Mon, 27 Jul 2026 09:49:02 +0000
Message-ID: <ecc03cdfd2c44df0b23927491c581349@realtek.com>
References: <20260721023836.6691-1-luyun_611@163.com>
 <20260723102507.35b4246b@kernel.org>
In-Reply-To: <20260723102507.35b4246b@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> On Tue, 21 Jul 2026 10:38:36 +0800 Yun Lu wrote:
> > From: Yun Lu <luyun@kylinos.cn>
> >
> > In rtase_start_xmit(), when the head buffer DMA mapping fails after
> > rtase_xmit_frags() has mapped all fragments, the error path clears the
> > fragment descriptors with rtase_tx_clear_range(), which frees the skb
> > through the last-frag slot and accounts tx_dropped. Control then falls
> > through to the common error label, which frees the same skb a second
> > time and counts it again.
> >
> > Return right after clearing the fragments when the skb owns frags; the
> > no-frag case still drops through and frees the head skb once.
> >
> > Fixes: d6e882b89fdf ("rtase: Implement .ndo_start_xmit function")
> > Signed-off-by: Yun Lu <luyun@kylinos.cn>
>=20
> Justin, please review.
>=20
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 255667775f0e..67f7fdada119 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -1426,6 +1426,9 @@ static netdev_tx_t rtase_start_xmit(struct
> > sk_buff *skb,
> >  err_dma_1:
> >       ring->skbuff[entry] =3D NULL;
> >       rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
> > +     if (frags)
> > +             /* the frags were cleared above, along with the skb */
> > +             return NETDEV_TX_OK;
> >
> >  err_dma_0:
> >       tp->stats.tx_dropped++;

Reviewed-by: Justin Lai <justinlai0215@realtek.com>
