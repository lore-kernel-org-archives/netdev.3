Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.155.80.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865252;
	b=SWKAycalfwAqh2PUFlAFWE8XsMr9YFJCMHqSSeHHsuwcvVIzV6I8vjo687eX6JiEZgEA
	 euBvDZLhRMFLZ/IY2JvsCf2coKlO+bIR3Z+h3acIsGG0oc/7OMfzce7KT292HDP2dRWoK
	 nWYF3rKbC4y7RuUaXx+zZws+ehHsbsbmF0rgyR72gg8T6KTTUlSW5nzJPd63rL63QbnMG
	 jZQ4exin/gfaW+kAIu7/TuNldXRgnSsfyOUjhX0rfOULyA1B9QvjdcO/LS+RfLuk4vLbq
	 bA63NQz866rUm6oESUbeJnRu+T8XS05IvlMlN2h9r0oM94DpSgtR9wr2r+9bO2kHhpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865252;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=FFx4OIdSXTZWskx/Uy8yfO6J0zmhLKOS04V+9fSvjN4=;
	b=MMF0+UVooabxuW1cpqXLlG1aQSinaye+ZbM+BF+dPZr78HM62P0/gGXqVeN/ti0nXzja
	 r3FL5ISFZJv0atxFkfS14ye5V4pwnmZdwUOqEb0tP63XjjL2KeXAcChXkjsDkoAOe18rc
	 TsuBZDB/dn9VcoG5d5qbksnJTVvZE+miF50eI7mdwSN7xMxh0AbT2dYNndbl+HQ2djF8x
	 zUMFB9luNZMg1GPZNghe0PmJTAmJBidPE/Y8Emq5Yn0IpmqAui3Y19PNMCwAiF1wyrSPO
	 FrHbixINL5mIgcab4Q7VMXggjLkAgWTscbSlH0n+87HDBWml/IsKJyN4Cvwj/JI04/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tencent.com;
	spf=pass smtp.mailfrom=tencent.com;
	dkim=pass header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=J3vhJs6J;
	arc=none smtp.remote-ip=43.155.80.173
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED484606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 07:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED484606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tencent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=J3vhJs6J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
	s=s201512; t=1793865195;
	bh=FFx4OIdSXTZWskx/Uy8yfO6J0zmhLKOS04V+9fSvjN4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=J3vhJs6JqsT8NOl/l86BwMMn5gdXUkaiXCbcFb9wBpdY6AGd9Nix4jm3JeaOHxX2D
	 Zm5fKMuzE3KMWAUXSWSmp+zs9C8HPKHifNIUBILJj6gAkscBK8UUFwuJ2iQaXmvFVS
	 ZPdpsI29oOJ/CP7oFtMML+u8kI1wnh7BAf8amCe0=
X-QQ-mid: esmtpgz13t1793865194tde8168a0
X-QQ-Originating-IP: S43EqG484wwHP+JfAalG/F3VJ2a1mixugqgU0S4RBu4=
Received: from localhost ( [9.218.232.237])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Nov 2026 15:53:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10312450623886067163
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
Subject: [PATCH net v2 2/2] net/ipv4: reject appends with negative
 fragment copy
Date: Thu, 05 Nov 2026 15:34:36 +0800
Message-ID: <306E09760B4212AC+ipv4.6d58afc075934322860394a26ceaa2e8.2@tencent.com>
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
Feedback-ID: esmtpgz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M6x2tnEVru4eudxBaDfXjnCapx/vLeX6e7z0RxI9oU7qSmnXDI6InDiM
	oGMyxI8JWUQVb05t69bBlk916mLDH6iFwYBBie4+b//9XOM0WQDpKq46L4Ejcq5ia/0Yj2S
	VdnU1hfi+ddz1wz0BeeKjPrqAxbxnt0Zk4dfJvPaNZlOcuBS6shj89pKC9FOTEu7P73tAW1
	CMfoKR528e1tn+v8Izt91xC87zmbJBVf7Af5zApJKsbxOWHiSrswMjsFxeVVYuT4FsI8WV+
	6S+aOU9RVVIrvDhx0NN3ddnj0PDv1MHXP8P9qYv3cf1F94ExHyepWLY5U96UlvB3pVSOrWY
	vmsPgpmCmJRHNcWKHCiEmFK4c/+2ZQ/TmKSgoHWILDNKcFWI4DdrfYMbby/0u+gl4ngDoL4
	DbTUX9nGIepV4oJAJfFX78acghhyFmUZEC1mD6HqgNUeU1BDoQTCRLYtXqEm7hwZcOvWaam
	MdPAXKAh0fMoUI3XlBi8jRjESv+0eaiMC8YYnuYoXffgTNbREp/lkBJLgGvwu+IHrs0OD+a
	cM/nbhdOla/D+jalsvqXi8MR+M9+s8q4GmS7vVWA0Tt2VWELFvuT5keBIm2eTqym9mP75xR
	gWRggmnzTRrSMrzYE3JKn5UZtLlEpmXAd8OVj9kVaOr/9kgcIKUAEZnBqPFLPKAaa17PrmT
	9nRv0xXvPjYW6lfXUfH4FQURm3bhuEyzL5RWPl2F1m9Gx04zW+/NoanfCbe0ud13CkKmKED
	EQMn6+OpXUl2VTbNJ4XIMwagy9I1iJyPu5tsU8Al6l/gWHS5RJJSQtA1HQG9PKS+rquJ91j
	gtWoKoS1K4wU6/YyVopKEo7UQz3yye2IQlPJNq1Te1tEr3H+uqnlIrwWI5NII4lI0GEl1/a
	EE1x/mxZXhvAz8m/4kfou+VsVBV4F6DS3mWWOnHkD/7KrX6JFpDWTiL0lrAmAcs6MOmz8F4
	m0Mr5f7mtePKaSNTpYYzazhr3
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

__ip_append_data() caps datalen at maxfraglen - fragheaderlen when more
fragments are needed, and later computes

	copy = datalen - transhdrlen - fraggap - pagedlen;

If transhdrlen + fraggap exceeds datalen, copy goes negative in the
non-paged allocation branches, where pagedlen is zero, invalidating
the offset/length accounting. In the paged allocation branch,
pagedlen = datalen - transhdrlen - fraggap wraps unsigned instead.
The subsequent copy calculation cancels to zero, so checking copy
alone does not catch this invalid fragment geometry.

This is reachable independently of the xfrm fraggap bug fixed by the
preceding patch. icmp_timestamp() passes a 20-byte transport header.
With a small MTU and IPv4 options, the capped datalen can be smaller
than that header even when fraggap is zero. The negative copy then
propagates a negative offset into icmp_glue_bits(), and a timestamp
reply with corrupted timestamp fields can be emitted.

For example, with MTU 68 and 40 bytes of IPv4 options, fragheaderlen
is 60, maxfraglen is 68, datalen is capped at 8, and fraggap is zero,
so the 20-byte transport header cannot fit.

Reject this geometry before allocation with -EINVAL, covering all three
alloclen branches and matching the existing __ip6_append_data() guard.
A negative copy cannot produce a valid append, so this does not reject a
send that could otherwise construct a correct packet. All callers flush
the cork on append error, and returning -EINVAL in mid-cork state already
happens in this function (MSG_ZEROCOPY ubuf mismatch).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Anakin Zhang <tencentos_secure@tencent.com>
---
v2:
- Document the independently reachable ICMP Timestamp corruption path.
- Distinguish negative copy in non-paged allocation branches from
  unsigned pagedlen wrap in the paged allocation branch.
- Update the subject and Fixes tag accordingly.
- Drop the unrelated xfrm Reported-by tag; no code changes.

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

