Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865252;
	b=AFc613ZTQSBjGo+oPpYc/u+PrgXSTkdOhTUj1S5fhnTaVFhXJAv8wmwzXkI+mVMUQbU0
	 OLEUwgpFSe2EOrscON/zs5KUY7p2hauMjpcR0orXShcm6XdHicRotj2VHRA0fbZEj5WS7
	 MV1wbvlZKyYvsB1vYlN8y2UnDao2rA/0rwQji5d5Do5M7Chi4ZjKDPV66CQHRRsjuqVgC
	 9A10x5zk1iK7iaoTtb8pR5mpdlwFwDSnQ9FukyP/ZGYYWvC0Q8twm9Q/wGhbntX69HilC
	 Vs3TWtlVrqyqPDH3xjLKOhj8S/V8XhqWTG3+G0VBZn5o9btsswEHgACuD9B5AJrRBbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865252;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=VsKhWyNvCl/Nrc06wipoFvOLNzc2IYtH87GxxhPlcpw=;
	b=xZUxHINJkXH3jeUuC8QGT4QdGQsbI6ysmwx0jYbmbL+LYk6WKsBtRr8BgHdg9a+VqOy5
	 h17a/mBkdrhPqjDzX8BZMxMG33oqHEvVnvlhMq9orxvP631Rn60T4QV7VndKpsY9uU8yF
	 Ium1DOX1X1uSgUmUk1ujPDgWVz0RNLrORYFauywCLjubMHsEKWMNZdTkLEOpRdSpknxPH
	 mmuypU7PCTf9hdfL83HIpTo7z7+BMBoeD19TnP8o2H40ZjJpv3AklR5YfsNgBQrzWSuGe
	 2ufxR5qmPCte/gbT9VCI8On296U44P9GK/CxgVoKed71vG7ZAs7K4YCgVdCUe6XEJrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tencent.com;
	spf=pass smtp.mailfrom=tencent.com;
	dkim=pass header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=Cz9IwFmS;
	arc=none smtp.remote-ip=43.155.80.173
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED588606A32C
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 07:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED588606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tencent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=Cz9IwFmS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
	s=s201512; t=1793865192;
	bh=VsKhWyNvCl/Nrc06wipoFvOLNzc2IYtH87GxxhPlcpw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Cz9IwFmSYy6o6A8M8Hit5y23wiU+Zf1F2+4ZeUC8nm1EaqeKEyok7xFoPw3xkBRDL
	 qHy/NW6Ix1MZNkX0UfMNCcJq0NgVS2Rq+t9U3Bp3ewRlb8O5uubyAcLIPZY6khPRxc
	 WZmJBIGDfM0H3xI5o6o3eXH/34J0DkZ4+4xOaExY=
X-QQ-mid: zesmtpsz9t1793865191tb1e316ed
X-QQ-Originating-IP: Endx8ZTOB/qSoCXvPzzTl8cjMsxFqaxZiNjEXQRWT7A=
Received: from localhost ( [9.218.227.30])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Nov 2026 15:53:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12639784493344106518
From: "=?gb18030?B?dGVuY2VudG9zX3NlY3VyZShUZW5jZW50T1Owssir?=
 =?gb18030?B?uau5stPKz+Qp?=" <tencentos_secure@tencent.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Steffen Klassert <klassert@kernel.org>,
 steffen.klassert@secunet.com,
 Eric Dumazet <edumazet@kernel.org>
Subject: [PATCH net v2 1/2] net/ipv4: reserve exthdrlen as headroom instead of
 counting it in skb->len
Date: Thu, 05 Nov 2026 15:34:36 +0800
Message-ID: <5D29E94EA59C941B+ipv4.6d58afc075934322860394a26ceaa2e8.1@tencent.com>
In-Reply-To: <ipv4.6d58afc075934322860394a26ceaa2e8.0@tencent.com>
References: <ipv4.6d58afc075934322860394a26ceaa2e8.0@tencent.com>
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
X-QQ-XMAILINFO: NRkWGnbnkwTmi8Gbz2Pomf12WCG69/inHdB8JF9nbQ2sBdTPRvh3fgFB
	88EXNMlKmVQ4Qg10f+LDypqLuxMtUcFN20wLFFB4SgKgqr3KOBcrAGv9zx8LGG0QtlYFZ07
	UpFXXR/1+mIay1M5/UwjLD5U4RDvpk6sve9cAyIGPucKxggArGLcpI+ga0SbLlrgiN5QA8D
	OQ9NCkcctKFESFmCpGguQaCvwumSkGoUbCFhbMcHmORwJUA78wn2rZYnHwrd5wKZlkPHMbv
	/MNKPrFPi2zxWzc4RVwrN5lbLGPC12irVe4Fy25GKFN6+1u6e//w27xrY6p/7L1e5TPjwBk
	YrUNh7OEOUzaTxHcqr+t+P55JtfLF/YucmqKkMq/jjLzUOOqzp2Ty3dL4mSHvBGwyyhTgcB
	jNcerLERtdS8tUhkDVJEr/wsJkC8VVgckMKgcZ7anncYqqPZ7+lEdqBIgPXbgWExaB1bhPW
	4hFRQ7AxT1ZhFmyUzSt8/EH14rX5KOTW1sPhRHw4IFvtxFCMDhGW1Ei/vbbaHAe1FNkWYVj
	dbOgsb2c/p2MTVNWn54LXEtsugpff6NWBEq628kiY3CZYo9kABzJQzsU1AwiLFhB8WDwnJZ
	BuTKOdypPQ6cN6kBS1XuSeB0ccAtLFRzqHzRBlqvPIw9rqPBttDOBkk7trNpUjaVIBQiYWy
	NnJ693k29LAk5I2Ipy0394PmJRMKDNkXtsPvTzqhT8vmqdPi9WpJwb23o8htcAS9Ee2LlI/
	vcfFN8nRWHz2Pt5eAFZFoWBa9R9GcV+WbYVg8YUQQJtlmaFe0kQGkufG0RDngsoPaGQKAcH
	CkME1DOACK/wGa2Th39IjgXiHC2MDsQCuK4U576DvfEuHReHlal0K2flGdTtmGIQ2fgMHJM
	WcyxigOqYwVAAFTCpuQgyWgdY575zEh4Qtjp8agrtOLTEFb6AKcvDDGfFsln+k2efodBY4J
	RgTM=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
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

fraggap is relayed into the next skb by skb_copy_and_csum_bits().
The MSG_MORE (alloclen = mtu) and linear (alloclen = fraglen) branches
rely on datalen accounting for the moved tail. If datalen is capped
below transhdrlen + fraggap, the copy can extend beyond skb->end and
corrupt skb_shared_info. The paged-branch accounting introduced by
commit eca856950f7c ("ipv4: account for fraggap on the paged
allocation path") also relies on datalen being large enough for the
transport header and moved tail.

Fix the root cause by reserving exthdrlen as headroom, like IPv6 has
done since commit 1f85851e17b6 ("ipv6: fix incorrent ipv6 ipsec
packet fragment") in 2012:

	skb_reserve(skb, hh_len + exthdrlen);
	data = skb_put(skb, fraglen - pagedlen);
	skb_reset_network_header(skb);

The corresponding IPv6 variable is dst_exthdrlen; IPv6 exthdrlen
instead holds the IPv6 extension-header length.

With this, exthdrlen no longer contributes to skb->len or to the next
iteration's fraggap. When fraggap is nonzero, it is bounded by
mtu - maxfraglen <= 7, the alignment slop that the relay was designed for.

For the same inputs to the skb setup block, the allocation request and
tail offset are unchanged (alloc_extra already carries exthdrlen).
The network and transport header offsets from skb->head are unchanged
as well. Excluding exthdrlen from skb->len intentionally changes the
subsequent fragmentation calculations. When exthdrlen is zero, these
skb setup changes have no effect.

Fixes: 353e5c9abd90 ("ipv4: Fix IPsec slowpath fragmentation problem")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Anakin Zhang <tencentos_secure@tencent.com>
---
v2:
- Correct the too-strong skb->len/fraggap wording.
- Clarify the IPv6 dst_exthdrlen terminology.
- Describe the skb_shared_info corruption without claiming a write to
  an adjacent slab object; qualify the local layout comparison.
- Add Willem's Reviewed-by; no code changes.

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


