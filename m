Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.154.197.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865248;
	b=xVFQx7d2o/F3SEoCAUV9Nn1oQUXfvo4ZYxblAA0fBQmhQQ19vflsBa2AZ4mQ1KsEwmUR
	 vXNpN+HcN3XGkaPtmPBBbXia2WmESGxx37h8xMEWggsHlqE/cq0Tm+LZLyR4Kz/52yECg
	 dSl96M53rA2FqytdrYWsVbirJyJpSMJPTNC3AqTpdCn43ifxKOL2ILkr2T4fTwq+I/W7Q
	 oPpnmX8Kt19WZXZ9C73ZOj9Q8LZN41ZQTjAUhtVE0pwmiqMuIuAl9M7KyTloYQgCQUEgU
	 51npVYl4PT8b4wfj8b4u9yuCMu2J7C/7htemBSAWQHAOOdXSZ3JjNEGQY++iL58T+8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865248;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=XuTMD0+bWh8qdKbIHRtIOzKefAE+ZWunb2Md38v0VYk=;
	b=rpLD0Y2RUPGiIhYQ6BMAe2I9HgxU5fYz06CSEjYZBqyLikrShMbCn+YvcaUbXHDABinq
	 HaKhk7p7bEBhcXSpMEW0P36pT/2rU0tOY1AI2RoD2KCIl/IoQoO9ISYWjGR/nQ5u9DC/o
	 Td8xN2Fb49Gd9qJL2s3GfyQonl1t/1TiNdwtsyH//yJwd3bhLMc7wrr4VfP54CTqicXMc
	 7x06WttPLbjkP0vjkkdHuTe/lXc+swcbzTAwzjFgmKSYlBFfvQn0sp6el87tBcURR60KB
	 DUY400iCIv6vuiYH4IBkysuzNrD1tTcJHdNfI4QlQTpHPIGw3XkVewHIt0F5w3zIw2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tencent.com;
	spf=pass smtp.mailfrom=tencent.com;
	dkim=pass header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=uc0jfUJO;
	arc=none smtp.remote-ip=43.154.197.177
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AF7606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 07:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9AF7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tencent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=uc0jfUJO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
	s=s201512; t=1793865189;
	bh=XuTMD0+bWh8qdKbIHRtIOzKefAE+ZWunb2Md38v0VYk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=uc0jfUJOVAJOwY631GGLgnIt0AKRnBj3zc28M+rvVJLcrXdHOPsKZYFkEtubKZc0Z
	 ouwPFDfxcrmykyL7mHxdraoqmMccpwmnYVHpFHMyDCuWxUqkc2P6PJI15BQNBEVRaI
	 moHQPmCUwOOhCQ5b85ZWQOq7GwnJpYCg0lWAH3jQ=
X-QQ-mid: esmtpgz13t1793865188te7642f86
X-QQ-Originating-IP: 2Mtxe6CgveBcP1cAzBK8fIi7YkkUpuHpGgzMOZzPZQs=
Received: from localhost ( [9.218.232.158])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Nov 2026 15:53:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14525464289534385858
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
Subject: [PATCH net v2 0/2] ipv4: fix fragment length accounting
Date: Thu, 05 Nov 2026 15:34:36 +0800
Message-ID: <36C40B0A9C6336F3+ipv4.6d58afc075934322860394a26ceaa2e8.0@tencent.com>
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
X-QQ-XMAILINFO: MMnP0fEUKo/hkFgNFlyFu1AT2JiCICBUpZx0B8nIASRDxQXfXLyIiGnS
	gL+J9Hcdg80c5t4XKDd8Ea2QdU/dWYFAySxXTs2q8MLoYNo12IJGZmNaEW33mjcQIzHEynW
	QHARvKu3HTsipQXDPI5/i+c6ZP6g5spXgy+RwcGq+mX0J26jj+5s5Sc0bdXICWF9g70CylV
	lsJ1ToS/ik3Hs5EyAKE9lThZmU1DwQT7m9NP2a4PdHL9kDTPvkfeiamIxcXoJYkH1+NFn8W
	WcMoujOYIJscAAB6NNWYnAGmw5Jjf0FJHbzmSEuJqpE3y8nS9yt+cPeortmszKsQu4k3ghC
	bPjgM5pcHkSW8a8TTHQaGe3WQXFL7mkaqfXFVEBKnRGNN52wxP+nsfe/3zTupJmHIC/ia32
	t7ME+9pgvagM+Ot+GcnPYpogGgWCk9dkTFiysqZV961+rKKHeDkpsE0IYGa6/vTKinGq7oW
	iQLRVNlZlMJ+Z3kYlQlqrOv7YZgfwd52/c1S9zYkFjPNLNOikSv/bsQC5fCdIN84OcVt4ww
	RvDcFz2ucrSzkIYKEHF0PN8DSzAiQPlThsmCllqcrLfDibeUhMGGgn4UPtdGO6KS5f76KH8
	VE/aY2V29zzaCZScecbU7n0LkKkfMQkGvrxiRQxt2XHiWq2tpDtHF8E4FXUN6kqKPvyYCIw
	xLDwWCZEnRhoWwctB6J1HB0P8dircZFV7UnGb6FCwnzimo70Et3moQsOjN5EXkxrDkdld5+
	woI7znJG1JltlEBQXkwgkb6ytiqDbCNjHBQKOQizRTBJsWRoFjVKpU4Hbs0c3juvM5gnlO/
	vOmG3YspzFH4VqBnfUgTOQMvfEXXmd4VgrgFBikuxneNWFOX3V1msU3N0kNSRhrxLYMbZXG
	tzUZf9bCug/v1bzYBlxSsVy2r00iMQMtjre8F9mBG4nEqlMZBvYvvVTUjoTpeKYMn1PNaps
	ttzZnjKFHZ+imSA==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

This series corrects fragment length accounting in __ip_append_data().
Patch 1 reserves the XFRM bundle header space as headroom. Patch 2
rejects an append when the transport header and moved tail do not fit;
it also addresses the independently reachable ICMP Timestamp case.

Changes since the initial public posting:
- Patch 1: correct the skb->len/fraggap explanation, clarify IPv6's
  dst_exthdrlen terminology, and scope the layout comparison to the
  same skb setup inputs. Add Willem's Reviewed-by.
- Patch 2: describe the ICMP Timestamp corruption path, distinguish
  negative copy from unsigned pagedlen wrap, update the subject and
  Fixes tag, and remove the unrelated XFRM Reported-by.
- No code changes in either patch.

The patches remain based on v7.3-rc7 (f909e534f5e3). The unchanged code
was previously tested on x86_64 and arm64. The relevant selftests/net
subset on arm64 gave matching results on patched and pristine kernels,
including the same failures in pmtu.sh, xfrm_state.sh and ipsec.c.
For the ICMP Timestamp case, a patch-1-only kernel returned corrupted
timestamps, whereas a kernel with both patches returned no reply during
the receive timeout. No additional test run is claimed for this respin.

Previous posting:
https://lore.kernel.org/netdev/v2-20261026-cover@tencent.com/

Thanks for the review.

Anakin Zhang (2):
  net/ipv4: reserve exthdrlen as headroom instead of counting it in
    skb->len
  net/ipv4: reject appends with negative fragment copy

 net/ipv4/ip_output.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.55.0
