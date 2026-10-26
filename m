Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.154.197.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013840;
	b=PvXsebes/L/ypKxIyv4GpcYmtJDE3S2mfWNZqCJ9p8ZrsR5O3DvvJPC371cpK290ZWAN
	 VxPOAxm1KMUHKL1Ah91Ef7ES2/ZohdO0bIBW5FYWBZBCdllC9eqDrMHKJehATjOa8sH43
	 sAaZTHb4QUdJbGmAkWjqQ82lgjKGcuis9SSG7qIvHT8v5RkgO8H7XwiwPrsDCYAzrERhd
	 4HQEndz0er73MRxYVlNFqrQdTsZjRYbrBveOhYTpAau70iG0Ip7I4ispIPOIKUuHR5eYb
	 Yepy6XVrNoot41g9AYAYsecFPvFcqhA+DOyZSVbhFu9Wbm0h43GLHFP42GLeU9FInDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013840;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=FxN75mrFae7iT423OoJsRaHNk9tTPVDmM0RyqgY/HHk=;
	b=kKwmOVBWxaXZcg9KHua2lDoL5hzkRxANb4unpJ6Pi12f8J8YGM360B6alRpBCTOQjwgY
	 6euKBufrGU+K5koDamDU5IFJI9JKT8lKztsRgZwyvawHhe4etmnCsNirpzz/D5RpTtTyj
	 PMnZWR5VtikE9q0PJyZRBEaEtG8YIeaH/yR0rYOlFHPYLu4Vzn2tA4kxqfdO5ioVpkVUS
	 824RoTjxdnMMKt2+tv4B5Z2lTks0v009Poc7HtL9sjIswFuE70NqgfdiqYK3yuMHNKjO3
	 bnj18PKtiEbHBSMJAs2pdQbLNrSFnNV5oAOrx6aiWF0fNBf2EQ1tHp0whRFFWr1R8+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tencent.com;
	spf=pass smtp.mailfrom=tencent.com;
	dkim=pass header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=g2U5jq0B;
	arc=none smtp.remote-ip=43.154.197.177
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625860A260A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8625860A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tencent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=g2U5jq0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
	s=s201512; t=1793013791;
	bh=FxN75mrFae7iT423OoJsRaHNk9tTPVDmM0RyqgY/HHk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=g2U5jq0BGn+XqC7IlzseXNjb8eGOBoqRXeArnr2T8ZCMRuhlmop3af7zZKfV3Pfz8
	 nrZOKqqolW+JTn+iK1NR4Bfgq1A8IPMfNlJcDjDFpGG8wEnyitKqujsCES6S/FpwAd
	 vIJFxiUcPAj2rmeAaNGi7mQKFLWLKq7wbAlE9n4w=
X-QQ-mid: zesmtpgz9t1793013790t1f63f10f
X-QQ-Originating-IP: wkZkH0AqOKgbehz8FhcTuMQyP+Gpy2Y9ZugKhcd2eRc=
Received: from localhost ( [9.218.227.15])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 26 Oct 2026 19:23:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17845924391617974366
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
Subject: [PATCH net 2/2] net/ipv4: fail append when the moved fraggap exceeds the fragment data
Date: Mon, 26 Oct 2026 17:51:28 +0800
Message-ID: <98906F734B5D43DA+v2-20261026-p2@tencent.com>
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
Feedback-ID: zesmtpgz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NImvdRhE6fHpgjtFAyCci6ZDRG1GZQnsbaNYK3BzT7V6/DfsQcbLyE+8
	JiZTWPRLV7KWzaLvR+N8Oc9X3JXmmBdnZlv6ujcjjQ3aDriO0TM9K4w62t2PJXb7M/ZPp5D
	pkoOoLms8yM40VlkCJcaKwYkipW3NSxMzjQ78SN/O+8su2XD213yeCURDxo9WcLUVV/ByDB
	qG5di/U7byah9fb1axcCXnL0GmzGGrAQDjxViDEc57ZbhUIV/e4GFDxZytgySiChVKosktB
	uzvQbDN2EtTTr/Ray8qq6qnxCjodSUbiPNphXHnNRra9jYXFuK9EvLv2YcY7RfrTPSUxySz
	ai6suo00oyVLWYaknCvbGjMIaO20JWCiG8CqKnCxYPUSgELNnbYLT3CF0GKNqwqh6Zllz6z
	OknOPYlhWgZhDsoxkpwi5Z1apDP0hqjgewaDlSsQAxx9KItQOSEEJOreiRs6UisKS+4s6xT
	TdyVGnefQRdxqiyOT6F1S95+ZjWwJXBTBz1XG1/b/34rcvEVQqWkVKz2BgJaAX6/4pTwPsk
	wCxOJRDR6FAEpy0L+Jr5sEPYD8MdD7gIyX3HFxjygbfaKQ/ioA407eERZliXXbHRyl8A8c4
	62Vh8Dcna4qGiC9klFD1FwuLKfH46iLKb7rjKcYLn+6KCRBlOEIO2susyVb4yhnTxf6EoTn
	U9zKyaKu0/63dO20Aay0qvVD3rbxe6rOuDDe8Uhk4dPBb9ZYClPum/SsjDd1qSrCVvo1o7L
	4noCy9AwvgngjvyUrsTgAMIaOTeRH4oUPoISo2a2k61vK+IYt21bHzuJlt1cjKgpycfUqks
	YW2Y9VOVxRuC/RZ99IZXX0pmYW6JqQPs1B6/eHPamj4he7O/CVH2XsUfnuqhsBKewKH1ma4
	vh4PyPLTALxPwitNFFoEAuoULhNbziRYxFkqiFdIEKyZOcsnhHFS63Ow4GzDOUkK
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

When the first fragment of a cork is already at maxfraglen, the next
__ip_append_data() iteration relays the previous fragment's tail,
fraggap = skb_prev->len - maxfraglen, into the new skb. The moved
fraggap is charged against datalen by computing

	copy = datalen - transhdrlen - fraggap - pagedlen;

but once datalen is capped at maxfraglen - fragheaderlen it can become
smaller than transhdrlen + fraggap. Then copy goes negative: no payload
is copied and the iteration makes no progress. Worse, in the paged
branch (MSG_SPLICE_PAGES / MSG_ZEROCOPY / GSO) pagedlen = datalen -
transhdrlen - fraggap additionally wraps unsigned, breaking the
alloclen + pagedlen == fraglen invariant that commit eca856950f7c
("ipv4: account for fraggap on the paged allocation path") relies
on; the loop then either queues skbs with garbage tail accounting
(silent packet corruption) or, when maxfraglen == fragheaderlen,
never makes progress and grinds on until -ENOBUFS.

Reject such an append before any allocation: if the moved tail
(transhdrlen + fraggap) cannot fit in the fragment's datalen, the
iteration cannot make progress, so fail with -EINVAL. This covers all
three alloclen branches, including the paged one. With the preceding
fix fraggap is bounded by the alignment slop, but the condition stays
reachable with extreme geometries (e.g. an effective mtu too small for
fragheaderlen + transhdrlen), so pin the geometry explicitly, as
__ip6_append_data() has done since commit 232cd35d0804 ("ipv6: fix
out of bound writes in __ip6_append_data()").

This cannot reject a send that would otherwise succeed: the guard only
fires when transhdrlen + fraggap > datalen, which is exactly when copy
would come out negative, or, on the paged branch, when pagedlen would
wrap.  No send can get past an iteration with a negative copy -- no
payload is copied, so the loop makes no progress.  All callers flush
the cork on append error, and returning -EINVAL in mid-cork state
already happens in this function (MSG_ZEROCOPY ubuf mismatch).

Fixes: 353e5c9abd90 ("ipv4: Fix IPsec slowpath fragmentation problem")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Signed-off-by: Anakin Zhang <tencentos_secure@tencent.com>
---
 net/ipv4/ip_output.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index b84d56c..5db8b06 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1105,6 +1105,11 @@ alloc_new_skb:
 			fraglen = datalen + fragheaderlen;
 			pagedlen = 0;
 
+			if (unlikely(transhdrlen + fraggap > datalen)) {
+				err = -EINVAL;
+				goto error;
+			}
+
 			alloc_extra = hh_len + 15;
 			alloc_extra += exthdrlen;
 
-- 
2.55.0

