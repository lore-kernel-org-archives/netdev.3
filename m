Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.154.197.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013863;
	b=SSQI0oS7vsuG7UbPDnxmaBplfdzpev4KwAaB9ezgHPimvyXqCbLuvUOto1ovH/z6Nobc
	 a/+qr33FdeddTszk+n+fTQZ5KK/3gc5LIUgTkX6buc0aq9nyQA1mTY6jpF2ydTH1rzcGA
	 nr9H2EzhsP/DWWOPbnMf/B5dgktcwwmUsCC/UniyHZ/+OCgFR4lYsxlR5HFjH5GMvVspg
	 3c8OHn4R74ZoRmaLZSTBE1kqFWgMWtilKOGN1DDjMtqZXx5sMqYGhbdecw2ZdEba8elEH
	 DRtjai1NyQB0CejK0JhrmogrOsVItLZlZ1eYlDD0PdGWXxPfPrmnt4m7Sz7d72Tf0bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013863;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=6M7Wze8cu9hcYEYOdODpmbe4mc8nJcgsM3yN/g6ABp0=;
	b=cVbfoflNcC6G145GAXBbrBuOo73Bf9Kx3XqRaQFDXXmslnnf0K6Dt0GlehL1r4B54UNA
	 ZVTk5OBcXGvIn25KeJAdMGHyB4rPwYzskPxa5R7pe8PAfxeEdB6htYwFBWA9rf3aBhcR2
	 O1Y9OuZszTopzLCcA77tFNkgZlC5fKscbMqg7Utqro3hXUxeEdGBvRujmqEkH6bSNhnjh
	 4IMAE2NW4CQVJUL/cXJftQyC8l3sKqFWrZiAaTGzijxet97Nho7AELyAQOIEgfKeBx9vu
	 fRQgHXYvN2M1eHK+IeE0EKqkZEkPbXaNx6Fsqpe/xqinZ1zfhuPuDEth2lu7y2W7eKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tencent.com;
	spf=pass smtp.mailfrom=tencent.com;
	dkim=pass header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=R+IcnYcr;
	arc=none smtp.remote-ip=43.154.197.177
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC0606A321
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FFC0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tencent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=R+IcnYcr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
	s=s201512; t=1793013776;
	bh=6M7Wze8cu9hcYEYOdODpmbe4mc8nJcgsM3yN/g6ABp0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=R+IcnYcrHOcGYX9mX1ma0KoD0aQJDjJN07tdAsbPFCdL/Wzo5W3bTwYGoOfUWb8Vp
	 +PrSc2YencCEXeG5FqW5hmYWsfPDERJfwxsfxGSt1x01+uaYJu0VLmfYd7Wzq4cRaF
	 1nXNcyQ3eddY6lOiNuPU/M0x+JNIvrhSEY6eOsSw=
X-QQ-mid: zesmtpsz4t1793013775tc6e14df4
X-QQ-Originating-IP: ub3iQ4Ew9ptDmcr1AfsM7+aPimCvtpfyfVBswZtG06o=
Received: from localhost ( [9.218.227.12])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 26 Oct 2026 19:22:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10555309787439539999
From: "=?gb18030?B?dGVuY2VudG9zX3NlY3VyZShUZW5jZW50T1Owssir?=
 =?gb18030?B?uau5stPKz+Qp?=" <tencentos_secure@tencent.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Steffen Klassert <klassert@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	security@kernel.org
Subject: [PATCH net 1/2] net/ipv4: reserve exthdrlen as headroom instead of counting it in skb->len
Date: Mon, 26 Oct 2026 17:51:28 +0800
Message-ID: <589B4474E0A78486+v2-20261026-p1@tencent.com>
In-Reply-To: <v2-20261026-cover@tencent.com>
References: <v2-20261026-cover@tencent.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MWdgP8+gtiFRFsBKXS03yqqRgf+NKjBaW+2h+W/2YEe60Es/zcJe7Z6o
	Ak0iexGmE1IYkzqpmyZevU8UCMj68r/GZvQixOc+EgDvnXkdFWCLMYGDN+Y2dFBkqICULDV
	KsulAtG0gZDSK3sinWCiNFHgpkIitTJB9R+HHikY1QZgrTrnzjg9R+1nHu8Lnp2G3AxXmLL
	wIXPehsoCDMlROPQmP8Rfw7g6/7h6pX/fixM64CkSUaMl8v6Q+Zw4nvMwvcOERbYz+TkmGA
	hpD5jrRKC7gsrRmpofupmH1y4MJJMykhprLyMt5oK3E1f0uNM3Pi52E4gT5+t9+eZWf1+/F
	gLhTSITI9J9B6rudx3Ql7aUZy1moq0b2qApehFDRT+Zglx/mb7nQyxMhCtSrV6iM821toXM
	dDGrMw40TD0K0iun6tLkym3Uw24gQmBWOP+nliaxhO8t6fipXC4TGNPMdI7zAqPzdUAU4qA
	JJBeYqLGwFwT7+st/C9AUeGZQTDGwV0ZbnQpaAifYXW46ZGDby93Y97JtdipAFoVfSW3K1P
	IeTWnYcgrmyCa02Cf0p4Kyuqnmir/TteWrX3PNzV02PJZpe0+2OfHW1DK/UQcAo8mfBPhI5
	6BJl65yA/R/Q/sQcVyuzKjyKHvKP6uhFYGirWLVhzDx6TBhMiRcSPVDPpvcznGRkazjOZ2D
	aFqXP31LXaI56WyLvelfuemdcEKlBJgAeRnHNZD0cjvVR9H3aVXHFLcspBCq6it+iF/EMjO
	8yzX0M9IkS9sJaZsJVa2IGotF2nhK8dZZo93Y3VfIZWgPSC0hQgmrlQ+AYIiRii3OzRdoBQ
	8DmSkB8RWuyEzj8ZlReY/oChlWZdpyCkYW77cXxG1o8uWdwAfsqJWMttqsh2GQEus7glh42
	0z5Rk2MFvZdeP5as9Kzg8tdcnMsbKEjtbyMSIUfQ3DX3yLcd7qe9OdSUBDd5ZeEc80ikNVB
	D3Og=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

When sending through an xfrm route (rt->dst.header_len > 0),
__ip_append_data() counts the bundle header space ("exthdrlen")
into skb->len of the first fragment skb: the skb setup does

	skb_reserve(skb, hh_len);
	data = skb_put(skb, fraglen + exthdrlen - pagedlen);
	skb_set_network_header(skb, exthdrlen);

so a fully filled first skb has skb->len == maxfraglen + exthdrlen.
Since commit 353e5c9abd90 ("ipv4: Fix IPsec slowpath fragmentation
problem"), the next iteration's fraggap = skb_prev->len - maxfraglen
therefore inherits the whole bundle header length instead of the
intended alignment slop.

fraggap is relayed into the next skb by skb_copy_and_csum_bits(), but
the MSG_MORE (alloclen = mtu) and linear (alloclen = fraglen) branches
account for fraggap in the allocation only for as long as datalen stays
uncapped.  Once datalen is capped at maxfraglen - fragheaderlen, the
bytes copied into the fresh skb exceed the skb head allocation and run
past the end of the buffer, corrupting skb_shared_info.  The
paged-branch accounting of
commit eca856950f7c ("ipv4: account for fraggap on the paged
allocation path") relies on datalen accounting for fraggap, which
stops being true exactly when datalen is capped.

Fix the root cause by reserving exthdrlen as headroom, like IPv6 has
done since commit 1f85851e17b6 ("ipv6: fix incorrent ipv6 ipsec
packet fragment") in 2012:

	skb_reserve(skb, hh_len + exthdrlen);
	data = skb_put(skb, fraglen - pagedlen);
	skb_reset_network_header(skb);

With this, every fragment skb satisfies skb->len <= maxfraglen, so
fraggap <= mtu - maxfraglen <= 7 (the alignment slop the relay was
designed for) and the copy destination is provably in bounds.

Allocation sizes, tail positions, tailroom and truesize are unchanged
(alloc_extra already carries exthdrlen), and when dst.header_len == 0
this is a literal no-op.

Fixes: 353e5c9abd90 ("ipv4: Fix IPsec slowpath fragmentation problem")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Signed-off-by: Anakin Zhang <tencentos_secure@tencent.com>
---
 net/ipv4/ip_output.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index eaa6fab..b84d56c 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1150,16 +1150,16 @@ alloc_new_skb:
 			 */
 			skb->ip_summed = csummode;
 			skb->csum = 0;
-			skb_reserve(skb, hh_len);
+			skb_reserve(skb, hh_len + exthdrlen);
 
 			/*
 			 *	Find where to start putting bytes.
 			 */
-			data = skb_put(skb, fraglen + exthdrlen - pagedlen);
-			skb_set_network_header(skb, exthdrlen);
+			data = skb_put(skb, fraglen - pagedlen);
+			skb_reset_network_header(skb);
 			skb->transport_header = (skb->network_header +
 						 fragheaderlen);
-			data += fragheaderlen + exthdrlen;
+			data += fragheaderlen;
 
 			if (fraggap) {
 				skb->csum = skb_copy_and_csum_bits(
-- 
2.55.0

