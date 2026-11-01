Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562282;
	b=pLIfE/jNvOsrN3GQhJacVYMDWnbvqcm9BSFcFIKNUXlJWB3vQZKD181zHkxmuI/KTqS5
	 WMfofBcRaHdz0P2t2i8fDrLVHSUzb1pCuU30JntSUvoZJjT34fbZbCw3T5E5kIxNKZ/kx
	 VUmoA5cEEDXCHBbDElWOiSPxXgLqNahKrW7c3Aj0bRBN1GMmK4IjLqLwXZqFaGO6yrJFD
	 ZKxyiCY5xq03xEeiqApDWHP8JRyOjL+fqhenoGXJzuObYgOO+PtEQu47GosZ4uFdaCFWR
	 GttkqNl1uz8yOm3btqi6+S6QvGyk2ZuzgUaXq/mbC64/T/xpjRqWggH73AW4dBX3D4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=n6JuWpF+eef2V525L5oCizLHk8iadx9qRsILopmNHm8=;
	b=0BALs5jaxOqSr/zFDXB8V+1LXD/8Okas4Lp7W9WcAI+TO2I/GYmR022tw/vlEtgKddT9
	 5o9A7kYhnKoKAXnnNAuLppe/dFrfm9/clgJZpa1Bl+gebvba6SPROSdpdz31UE5UCfEBe
	 osm08jZ9aGPVcbnE/fA7EpwYbeAtBsNOP0DcIjbRQdiMGa1+AAl9jAD3bDjhkJ8wPOw+K
	 vbjUhW79XvgrenuzR2l9yVSL1EAe+Ob4YTA7Mf+qqBZ+qUtrkugr6siqEQnggmENDA4P0
	 Fvyb9Qnqtu2ayBH1J/mtBM7p1HYcUpB39WFXG8RBxN0D15cdn+SeNnGTsxr7KuuC1BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JMfzN6r6;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99127606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99127606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JMfzN6r6
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9995ce866so19796615ad.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793562281; x=1794167081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n6JuWpF+eef2V525L5oCizLHk8iadx9qRsILopmNHm8=;
        b=JMfzN6r62tAPM45iQwOIp1BthxUrUWJaVIkoUWk3ykeDifSIkN2JBh1At4A8kMyO3K
         pjOt4MzNIt+mHsnQ0xoajiUApx0MFvsPC5nPp4SXnt3KHsONDglCjPED7N0XcRWjoyR+
         aHFKINocDldisxAg4byJp+qkByRH2mEY/+XRzjEzzEGNT8Lo6VGB9KpbK/3/0IjB386L
         UWh4lrL32PtUK3AjU/H7tqENxFH6iibw5UbIiAY1Vf/84GpbVDttAVs5lsvooUXJMFaX
         M9L4y7c6+7l+RVum0NFY6nniMYGdwKVdhzcj+VrHQKGrADFJvYIqgbJPSmWl2lULln6r
         MLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793562281; x=1794167081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6JuWpF+eef2V525L5oCizLHk8iadx9qRsILopmNHm8=;
        b=yj8CC/H+L6GC8ZEI1gF4s9ffgENf4mT2Wb8UaPEPVkJQoAukKC8pk7N3JsTY3DRT5F
         Gb+B8FXwkJxtRVFFBSdand1sOFAMwGzLRdvRncRfyRbFeLUU0a0XStfDzOg7TEv7b2id
         lcItu4jE7PtFq9yi485eojPK17cXUherFNBxamoEoQ5hvyx09PrJ8iBSGcEFuqTomcQJ
         6YO9TZ/1i/AqQBj3PSmn4H17WxgbAWlGNc6c/tlm/kXjTjcOcCDSa6qPM7GitDVDx5yW
         qJPQUasJTmq52dEa93trLKyTaalaweGtCoKsRATRRU0zY0WTPEEys7EcZo0PubJafjX4
         qc2Q==
X-Gm-Message-State: APuU4Z+3MWKNnqnXP5qlRTSEBMBXB0pz/QCQNH9oMEqzulPPuU6K/LrY
	EgkGqikVwhwexZTuC9uaBmV5MkMcV+/5fBJVEdpt1CVcYFAKs3meUnodXDwmLA==
X-Gm-Gg: AYBFou0rj62Vp9iEz6HHUNKe9jM5XprYWWlPTXb7LlUje1AoijUeFmjvJ2dG4d4/uiw
	0VBQzjdV96/LV2ZGYSGiquRvn5g7X+Ua68kqdCRMdY77pLZ6u9i41OedbtF9OHnsNVbsg+Mr+Q7
	Lw+sXUfJ0B7ychcqy4KBguA8I6pSPvSX94hQQ+GrEul488tV7Z+MZoxQMgMi4JHZHewGg4O51Rk
	p9pktnXN3rljD/yNNXSkHRKiViQXRBgXo64vmHHK9tX4ybFPstbllqnfvYGOI/m6kWuUNcuDhCg
	DIQQzu5+BRADATj+1F4lq026pBmwjzn2Pm1R+JNSl9DTiCYbGZjKEfsv9L45R9J7qKk6uj3y+UV
	+X+LB1gt/QwlwBz3ugm3ylY95dyKdqMTNUiFnbSLVIVLacbAYRR2Ta7k0KOdTGg/frsVwWyZfDT
	Qfy9Rq8B6xwKffo9y8hCalfHhx0djWFkoFsV1AAwcFNtPEHjF83GunL0/nK4BdMH1tQVu8j1Vk/
	Fe8kad8JvP/zF11rlPBnRq+Sx0gMb+P4EOOaxg6+RG51YOrAq1wZCPWXOAXc3vgYRM0fTa96q1y
	n7/TkZuXGwpZ48Q/R07qMlDDmDDy0gtwzPHbuCgz1Ji3li9Ty4ipZwi1jAlO80JEVUVVQ0yi0J1
	0fPSyXonVIZ+l/f4idSPcq01IU/OCwdgYVBWRUrz1p9+pp15T17NYw0i80kZ1/wnccQTu+bZdwY
	E=
X-Received: by 2002:a17:90b:2641:b0:3ac:8446:c1b5 with SMTP id 98e67ed59e1d1-3ae8974b804mr6376412a91.31.1793562280788;
        Sun, 01 Nov 2026 11:44:40 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae881c5624sm5824167a91.4.2026.11.01.11.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:44:40 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dongchenchen2@huawei.com,
	bpf@vger.kernel.org,
	daniel@iogearbox.net
Subject: [PATCH net] net: reject a negative TCP header offset in qdisc_pkt_len_segs_init()
Date: Sun,  1 Nov 2026 19:44:33 +0000
Message-ID: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Alexei Starovoitov <ast@kernel.org>

qdisc_pkt_len_segs_init() stores skb_transport_offset(), or the inner
offset, in the unsigned hdr_len. A header in front of skb->data gives a
negative offset. For an offset a little below zero, pskb_may_pull() gets a
small length and succeeds. Then a 64-bit kernel reads the TCP header far
after the skb and can crash. Further below zero pskb_may_pull() fails.

Commit 28a57fb2c5df ("net: iptunnel: fix stale transport header during
tunnel decapsulation") fixed one source of such offsets. Other code that
removes bytes from the front of a packet can leave the same stale header.

Return SKB_DROP_REASON_SKB_BAD_GSO for a negative offset in the TCP branch.
SKB_GSO_UDP_L4 and the other GSO types read no header and still get a wrong
qdisc_pkt_len(). On a 64-bit kernel only packets that cause the read after
the skb today get a new result. Then __dev_queue_xmit() drops them and
returns -EINVAL, but sch_handle_ingress() ignores the result. Their content
can be valid. Thus the code that leaves the header stale needs its own fix.

Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3ac700d37e59..ccf4b02e08de 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4320,7 +4320,9 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
 	if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))) {
 		const struct tcphdr *th;
 
-		if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
+		/* A header in front of skb->data gives a negative offset. */
+		if ((int)hdr_len < 0 ||
+		    !pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr)))
 			return SKB_DROP_REASON_SKB_BAD_GSO;
 
 		th = (const struct tcphdr *)(skb->data + hdr_len);
-- 
2.55.0

