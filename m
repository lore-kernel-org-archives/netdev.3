Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280809;
	b=YEw44WVXMO6oqqX1KYCPbX7z+nw+5aTKwxDZqb6hVx/PZuFPhkgeOLFlEEdp3414p5Iw
	 Wxo6GaPe43OUqeNxN3sqq/O46n8JzO+56XsuZXGEZf5141hYXhL6aJ7mpdk8l0gRobiGS
	 +8OPQ0rYTl4dNi9N/DNjRvwD3/sRhDNL1IzlMXxPRxowVs6C5fzDkRf0AWidynMFIMjsc
	 Bi2YP3hSOLEOkCUf4QznpkSfdoioE+VHMRqjd06/EsmXuwxY+nEsnOEJwdGr5p0VuT2uz
	 eiPYhjtCaueDP/8NLkAUVcfZvVWiOD/QSqCMP7xJACTMLoRwlvFr5c5Z1biMQf/KCxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280809;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/ln9Ib9VxSrRbqcFw+pmE8sOlcvEJcaFSWJ0EYv68hQ=;
	b=1714r6m32WjWO+wgnKQMomPY/lSb14OWIBvqczTzDoi02ZX5MDVolDEHBsY22bWELlWU
	 JoQweMeG8Mfrxhgzg7hLNjpl75gQVXDWYy/7/QUhI9PMKYnuhbsmqwl7v9nbCGZYigZhY
	 YZk79hebQYtuc6zDiZo4Tnxx4Q+ZjEl/99H12WVnmm/W9H+Alxn7nx+sK5SaDy4TuLOLy
	 XdcLrDUP9gfwhxJHEoa1qVs/kaJMC/f6WiENzsBI4ny4icczpinlsvry3d7QbXf50mKZL
	 nxecMeSe5MJ4+bbZE2L3c+qsu0yxJMryXcDXFdB65nppFVbUfYaY2F/Bj4xNDrs/Wag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=UCIk+2DZ;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA03D606A32A;
	Tue, 10 Nov 2026 03:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA03D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=UCIk+2DZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=UCIk+2DZBTvyXAQ+1+G8VMgcy5FPiliR/8DAB0f2Fo/cxh8t9fXRMmG+zC68x2dsO7ujkbFpNuIcM
	 bViTNvzzqAXDdLTNTBxfguIOZkOEXzqkqvGrONm+45GWgCg6xlXSbZ1iJ//8F2Rivp6Tya0KwP6JT0
	 T8mFCi1hdIYuh7C0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af28d645e7-cae6d;
	Tue, 10 Nov 2026 11:20:04 +0800 (CST)
X-RM-TRANSID:2ee76af28d645e7-cae6d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af28d4ec3d-a4cef;
	Tue, 10 Nov 2026 11:20:04 +0800 (CST)
X-RM-TRANSID:2ee56af28d4ec3d-a4cef
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	William Tu <witu@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] erspan: drop packets with an unknown ERSPAN version
Date: Tue, 10 Nov 2026 20:19:37 +0900
Message-ID: <20261110111941.10621-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179422426074.994134.14851036970867047596@kernel.org>
References: <20261108193504.73393-1-yanhaishuang@cmss.chinamobile.com> <179422426074.994134.14851036970867047596@kernel.org>
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

On Mon, Nov 09, 2026 at 11:37:40AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Can some type I packets still get through this check on IPv6?

[ ... ]

> For a 4-byte-GRE ETH_P_ERSPAN packet, ver is the high nibble of the
> first byte of the inner Ethernet destination MAC. If that nibble is 1
> or 2:

[ ... ]

> In v3, the IPv4 side was brought in line with gre_parse_header() by
> checking tpi->proto in is_erspan_type1(). Would ip6erspan_rcv() need a
> matching change? It could reject packets where tpi->proto ==
> htons(ETH_P_ERSPAN) && gre_hdr_len == 4, since ip6erspan_tap_validate()
> only allows versions 1 and 2 for IPv6 ERSPAN devices.

Yes. In my reply to v2 I said ip6_gre is not affected because it has no
type I path, but that is exactly the problem: such a packet has no
ERSPAN header, and ip6erspan_rcv() reads the version from the inner
frame. With a collect_md ip6erspan device, an inner destination MAC
starting with 0x1 or 0x2 gets 8 or 12 bytes of the inner frame stripped.

I'll reject these packets in ip6erspan_rcv() as suggested and send a v4.

pw-bot: cr


