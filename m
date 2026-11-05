Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909610;
	b=sPtPkNrrRa/oUdVBRJQ9FS4sA+HSWGeVWQLkn5nV8VhPK6D4Yjuf1wyxeUcO2Ky6FZNt
	 EaluaAGutSEJQE8NTrP5mb8XtLwtR7hldZX4nqYzFwFV8IFUO7S2abIt4mNbJ6zBiyNRS
	 OmDiMNGyE/QBaqWPpyNYmJkT6zARgdDcLESLOBWIxrqbu/ubwe9Nrdnqu4IKj7Z2TPEDN
	 uNMJp1oVMD3j02U51YM927NitzwN6ZjJFMe7XSRIqFQNAWtbwBsrvuVn8C3eugCk2q3jM
	 9ZEDOemnpfIqsYY0vSUChJIsOPIHeZC0eHsi2Bmz8/X9ZlwKbD7lYs/iwG7CuElY2VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909610;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VmsL2EhfQ/bowE/t4kOEn0H8b7bj8yaHObC0P+yarFE=;
	b=LIXekfNoqUh42K4cEqCGLdQuf04aohDntkdn6LgyhFu7ZmrNg14RBwuIwX5jnV1v8Dg6
	 KvDXJ81FF1skrGQw3fDFQimuAdBAc+cmGQ9oryvJKoQ3IiTYxooZBTP6sWlauNatxfT6q
	 iAtWczCElTi6s+xrgYaJbNYEXWBRGoswHMZNOXgWoPk0oZUd5NhTNIZn705yfctemZLfh
	 LsNekUzw6AtEZoAW+lXXBh+OAuNhD0SspGjwVvwoXTosJ4c49IIoN/291ohKtGgB3hMCj
	 aZzgF3ebtAEwboOR3BTlpd0fjXU1MJyNTuwgBxUReFnNrqWQd3kcRkqSjp5VdBbcKsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8y2s5UO;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A98606A330
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56A98606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8y2s5UO
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36a315ed211so1268051eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909610; x=1794514410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VmsL2EhfQ/bowE/t4kOEn0H8b7bj8yaHObC0P+yarFE=;
        b=p8y2s5UOAYmGZ0+DYhPo6SW4DMSss5Vu3m8gJj0y+eMlHj1JqJ+MktdRRnMTghgBZF
         sddYIdTkpG0C1Txoqlur9wn3LuIx/iHaVxyg212QsmY5W3No8N23tzLtWMjXJoqRHkbZ
         ZnHYRNoSkqNxDX3oO0IGGO+3G2JwpqKQqFOy9OeC5Ndhol93Jvs9zewmpYtV/mAwYweh
         NG4C8Ne7b8+FAB2tBU2B/25pG39HDbESlhsft/YUIhbnSM7SxJX4FViWJbhKvR5afmIQ
         wpCuoyy4Cl0a54zf/GztvVT14o1gdT20sXvJ+jJR3/3f6rdQKel+OP+keCWyutvzsxwQ
         c10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909610; x=1794514410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VmsL2EhfQ/bowE/t4kOEn0H8b7bj8yaHObC0P+yarFE=;
        b=a7oB/nDwZMXSeavGtlWIamC6cJvMIFrEsoUKTWSnfy272YZWMa07ew6vicDxDv8yJg
         JM/XmclpuvJG0IQQEBqjGrQMUvVe90l49cLpmWxIwDlaGWITzYMP68oNfNAhmct/Dtws
         80TqoUqM2CndZEGzhiM9OD8ckIYjsnJ9wpITQ44SFHZxqXf/bRJrYRXUET8+2PQr770q
         z1P5+Sq9WHRBTZ4dW3VbcuODL/3I9OZkLldv/+bcf1i3h9lXzxUXTlQNM2Cl0w04aMRK
         elh/kHVIpf/OzepB2Ty2ldo7hSr+eMbyqGf1qGCZS/AH9/RjTdwbMizBmTrPdEGW74L9
         n72w==
X-Gm-Message-State: APuU4Z+1IbeKhtzyTtp+hYr7AoIX+jHmr1nupFSjEwZ2bO39ZNeR3zM7
	f0ZCyN3MIa9E76wQxFeFK47FVPyJcOwJqmqbkKEG5YwL854L89TA+qtle9qcTRkC
X-Gm-Gg: AYBFou2cMsKPkXuPmIcrkpMIr7XEC8Gm9LvsV8RHdqwWPvg9dYOfSRApQf5ZOsm/tVV
	dtGwPXnTVn1IDq0WuArtM62UdMkZHw4lBADq1XFlrdnU2g/u8ak16qZIDuoBCVEuQN3xPlkyMQ5
	nu7yFTJDa5oZZsCQ8WeVR7B5dsQn950ybsQyuE4LiCPH1dZ3U+YXQpYGlEF9aTDjF/jvABLGnlA
	wn0L2P5IMvgTosRUP9zStbTsi1Vdbk+10McNbJUXrv/slF8O2PqbYGcW8yviOTGxWf5FDKvDqNx
	UQrst75jYImNxH8J2EKAvPE4nG9qtjG2UKeaR2Lbv4zoiMC+kbURRdzuEPdqlRqCvP5sienKxzg
	ga4eqVLl2lDp5AqvbHenr0yAsY7o+NTC5brL7GH5ihMlSAnTiL/7s0C0hPSpYzdV8mMp5YTBInZ
	D31RWdGO9YY1H5fqMPwrEKgGXKrPNgOQoeLrZ8zsso0Sl0GvuE4O0R3AeTk1aN6Lik9i95jUV/v
	9r4LLjaqOpBgAi09CKBteCUvgLI4FlDnn0uSCt0nB06Ct2oSSruGVOqTfYv+6RKU/17mNUmwe6l
	bX22Bd4hmfE4cHDylbWU6P9CPmCicw==
X-Received: by 2002:a05:7301:460f:b0:36a:15ba:43ea with SMTP id 5a478bee46e88-36f76d177bdmr256137eec.5.1793909609393;
        Thu, 05 Nov 2026 12:13:29 -0800 (PST)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f722ed312sm590869eec.19.2026.11.05.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:13:28 -0800 (PST)
From: Matt Vollrath <tactii@gmail.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Justin Iurman <justin.iurman@gmail.com>,
	Alexander Aring <aahringo@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
Subject: [PATCH net-next 4/4] ipv6: ioam: keep transport header after inline insertion
Date: Thu,  5 Nov 2026 15:13:09 -0500
Message-ID: <20261105201309.3182307-5-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105201309.3182307-1-tactii@gmail.com>
References: <20261105201309.3182307-1-tactii@gmail.com>
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

ioam6_do_inline() leaves transport_header at the inserted hop-by-hop
header, although the L4 header has not moved. GSO length checks then
read that header as TCP, and since commit 7fb4c1967011 ("net: pull
headers in qdisc_pkt_len_segs_init()"), a bogus doff below 5 there makes
__dev_queue_xmit() drop each GSO packet of the flow as SKB_BAD_GSO. This
depends on the trace type, and affects forwarded packets too, since the
insertion happens on output.

After ioam6_do_inline(), restore transport_header from its distance to
the end of the packet, which the insertion does not change.

Signed-off-by: Matt Vollrath <tactii@gmail.com>
---
transport_header has pointed at the inserted hop-by-hop header since
commit 3edede08ff37 ("ipv6: ioam: Support for IOAM injection with
lwtunnels"), where qdisc length accounting and ndo_features_check() read
it.
---
 net/ipv6/ioam6_iptunnel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index cfb2c41634a0..27b47f0c8bf8 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -340,6 +340,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	struct dst_entry *orig_dst = skb_dst(skb);
 	struct dst_entry *dst = NULL;
 	struct ioam6_lwt *ilwt;
+	int tail_len = -1;
 	int err = -EINVAL;
 	u32 pkt_cnt;
 
@@ -375,10 +376,16 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		if (ipv6_hdr(skb)->nexthdr == NEXTHDR_HOP)
 			goto out;
 
+		if (skb_transport_header_was_set(skb))
+			tail_len = skb->len - skb_transport_offset(skb);
+
 		err = ioam6_do_inline(net, skb, &ilwt->tuninfo, dst);
 		if (unlikely(err))
 			goto drop;
 
+		if (tail_len >= 0)
+			skb_set_transport_header(skb, skb->len - tail_len);
+
 		break;
 	case IOAM6_IPTUNNEL_MODE_ENCAP:
 do_encap:
-- 
2.43.0

