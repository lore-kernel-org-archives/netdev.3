Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE34F30E3
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790691824; cv=none; b=Wfx2NWS7tQAXO0BSftD2CNrZGReO11XxEa/8HaTLHaDiiGV6dcJXlhJcwZfpaOEH7yXhv3mAPJDDzM4bropN2Va+iG72AaEWpc/tJfXA+TdJf2/sbZ+bKVyqTcJ7Epob9hJaIha2dwuEeLDb3/4amWA/1jdFSEq2VszKurKR+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790691824; c=relaxed/simple;
	bh=YFg442dzmYLAsAia1lyH3HC9c9oEaiM/RKHPe9FKX+A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KxLBofmPA0YBq/Toc3+PRuiBeYkph74JA/j+3pynZGDS0R3K3lMQ7Tz/u/JO3k5gGuvg62tckqCLP+iyc4rk1U2kjmBEDV+NOfgseIgb4SlxCHN+xHGBMW4LLoB6P4TVJDvNakbG+Gmd7q0RW5FqIFeRBAb8eDPwUQHx5dEzPIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JT9Lyt4e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FtqM8gch; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JT9Lyt4e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtqM8gch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790691822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YFg442dzmYLAsAia1lyH3HC9c9oEaiM/RKHPe9FKX+A=;
	b=JT9Lyt4etH6ARxziCExQRGuwvBXzqDl3S7e0eRi++uEmTcXSpONBHvyrHiBwx6sAK/S0tL
	oMqX5xWkl+Pnkn3Rh0gv27m118n/d5QfmWCxk9bjhtrMlG5p/tAjAHv2lGduKYwy5/FAE5
	/TrySt09SViiqoNxV7GZPNfHqpprmMQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-Y-AGB4KLNqywe4peirs4wA-1; Tue, 29 Sep 2026 10:23:40 -0400
X-MC-Unique: Y-AGB4KLNqywe4peirs4wA-1
X-Mimecast-MFC-AGG-ID: Y-AGB4KLNqywe4peirs4wA_1790691819
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e65f2f1baso38999335e9.3
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790691819; x=1791296619; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YFg442dzmYLAsAia1lyH3HC9c9oEaiM/RKHPe9FKX+A=;
        b=FtqM8gchF+ManqU9ls2eCinTJbMR7qlydUZQ+c0yY62zIhZfVgOJNWbYo/kWufCoE8
         SAYysEnlLGLhhPcESPqLMrjY74KODwIyTqQgOhsKxPrwXYAND8AmQppBBBdicabMBRLu
         pm1ps3GWAgAAENzl7sXT/2tIfCbH4oqV5UqMGwvj4n4jaAR86+tID9exwdc3KGEIYh+B
         WL/ilTyNq30bgbmXfRTnBW1Ym2mJPdnTF9uhY4qHk2jy60UWwU0R+a/IkeC7U5rPQimr
         xI8ODD2RhgodcnlK4gQr0FbmwZqMgdDy8O+Ip8zyWSB3vfGUeiVUK0YHLH/RurKGnKcE
         yMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790691819; x=1791296619;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFg442dzmYLAsAia1lyH3HC9c9oEaiM/RKHPe9FKX+A=;
        b=nE3vK8FqhbcekgCiJUxVJNjV/NCTjpmYijfbrP2DBOObWnzWJ9SBaFAvv/tT1VyYyk
         kMzXVzrtyHqJqpIXOt2ZSJfpgWUczkXX7Qf5AuaHC9ElIijl/1XHE4ZR40wPecLTrvhA
         X3hr9yxDyOgCRnNz/94s0v8/mOh8EbOGGagcR45tLTCtgreovoEGv+yDXuFHrogkd+jr
         0i6OTP70x0Mrh1P5CeRVhqNr+laVnIYjt1tKskq7xbb2sAhfYDB5SI9DotjmZCbv+O/T
         VhGXxy24JH58YZ4O2SvjRVIPWOpZ3HUhNRCI/+IMOSfyjlAdNKsBcmMEVDv19sCeKqyD
         Ow6A==
X-Gm-Message-State: AFuF++mHM/6oC4ts4kst6NgFi7eiWnPpAVZg2bntNw5oEeSinR+5U1To
	HQcMxdRmUZLt1o/G3un14zXf38J1nPyfd9GqkbnuWlOxNyXBLS5Hfcv9ri+w1Ulyf5tuONpY+qz
	QfnjbNwQ5cpq03in5okcxBLwoY/VqCbduGeyJPo+zpBRiBLkwYu2Jj1a0IQ==
X-Gm-Gg: AYBFou00770irs5THCvkgGViCTiuLCdvtdca8ZrKghN5YMWlb+NxjRYe2Si8XzAlWmW
	LedtlcrzKp7XRiu6rHRjUnY9BTRNDDv8zzJ3rXNe2JUj0ze/1aKzOcV2FeL7VdaoRrTTGRe6cjJ
	trntNT/AHWHzznZjWhJxUVZakNU/HCRGNzR9vvPIN/S/NNLhdzz/Jo86eJfEjdyejQ6f3Pj4sxi
	cQMIinuviorzy41gj2rUUK0sjBewl1QZk2uoYkdqlSCbRlGUaS1U84Nm4/LTy0NAJf2P1a/B8DQ
	kyVegFAlGIykwD9vCEcqQ3qqhyhL8WdYdto6Wzwx+7218qLcqvbA55SMH021nd0vHa+Um2BVCDp
	udi8THeXLkRImDgV8VWMgI2zPag==
X-Received: by 2002:a05:600c:8b32:b0:49f:fc13:189d with SMTP id 5b1f17b1804b1-4a00c6813dfmr53749135e9.1.1790691819356;
        Tue, 29 Sep 2026 07:23:39 -0700 (PDT)
X-Received: by 2002:a05:600c:8b32:b0:49f:fc13:189d with SMTP id 5b1f17b1804b1-4a00c6813dfmr53748395e9.1.1790691818907;
        Tue, 29 Sep 2026 07:23:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf9dd27sm83481025e9.2.2026.09.29.07.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:23:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3D5A3A1017A; Tue, 29 Sep 2026 16:23:37 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Lorenzo Bianconi
 <lorenzo.bianconi@oss.qualcomm.com>
Subject: Re: [PATCH net v4] net: mvneta: clear XDP pfmemalloc flag between
 frames
In-Reply-To: <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
References: <20260929-mvneta-xdp-clear-frag-fix-v4-1-1e63b25eeed8@oss.qualcomm.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 29 Sep 2026 16:23:37 +0200
Message-ID: <87h5j8jfva.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com> writes:

> mvneta_swbm_add_rx_fragment() sets XDP_FLAGS_FRAGS_PF_MEMALLOC on the
> xdp_buff when a fragment page is a pfmemalloc one (page under memory
> pressure). The xdp_buff is reused for the next frame, but only the
> XDP_FLAGS_HAS_FRAGS bit was cleared at frame start, so the pfmemalloc
> bit leaked from one frame into the following ones. mvneta_swbm_build_skb()
> propagates the flag to skb->pfmemalloc through xdp_update_skb_frags_info(=
),
> so the skb of a subsequent fragmented frame could be wrongly marked as
> pfmemalloc even if none of its pages are under pressure.
>
> Clear all the xdp_buff flags in mvneta_swbm_rx_frame(), which is invoked
> for each new frame, instead of just the XDP_FLAGS_HAS_FRAGS bit.
>
> Fixes: ed7a58cb40bd ("net: marvell: rely on xdp_update_skb_shared_info ut=
ility routine")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

