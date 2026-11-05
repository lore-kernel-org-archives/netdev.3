Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902914;
	b=allWg6IeQ0J9OhtX3p/ZWjTwx2rWrq+gjiyr5Ni7Y7ylFT4HYEuoenZOUzGEkzpRr2wx
	 K8c+SFGlJLlKpYjV6jfzaVEnlARGKt0q5NZATSezceZT9qwXiue5hC2tNSL+Sa0dTGBPj
	 j5aP5k8zZURCRrI/l8UQ1vv44OzG7A7Iiu48sF8t3XSLXATIwV/3th8HS2twLnhScmbA1
	 XfldWGoi4T3Y71tbcaqNNnvf60h4J2D2tNuBzayiljxQfsEzKuY+dUbk0YNi+qqdHhJTz
	 awGJ0YrV+CKDhbP1BjnWGarYLvbl1RQpLD2T6q0WSUSxr7jK9jWHgLLPDpXi0pWWOrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Xe5bXUoSjdyUS5Z/rgEUMSGbH/+ArslOY+WPxBZy8QA=;
	b=sShQVmAlOcUIVG0/lcYZ+Fe632s8LIIgjMJoqdM2GytgtKXfcUIUiufsoXPiCRFexfKH
	 itaxSDImnvjxegMyrb1XlP09B9W8INr9lKPDPt5dsVL/CtxHdihMx+PbA0S5grgrJtarh
	 vmp5CuV7sQpX6eDvRWLDbv6cyxTRz1LhaVatrMKXualCYhfO7f9w8zST3KhmBQ3KEb7oM
	 CY19VZ1JAqqkgocNAhQHhqPKdIsUKRIOErID0cw4jgEcPrVk4wzI9cQVTQInyBcCWQwio
	 GSDGRfkFV6/MMzA2IvpemcLXxNmpWKDbdjQUButQjfhb/RvMZ7zRzxOeg2IIwYqqO+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T2h0DhmR;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC82606A329
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 18:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC82606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T2h0DhmR
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b0a921ee46so22091567b3.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 10:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793902913; x=1794507713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xe5bXUoSjdyUS5Z/rgEUMSGbH/+ArslOY+WPxBZy8QA=;
        b=T2h0DhmR02KOcmPE3YSD3Y18dAo1C69YstjJVJS3mpOsZgFM0hiT0zJagopeMurV4s
         GKfG+7h8mU4t12KFU+dSIRGQhSKjfRX3zLKEFKB5kK9JCGQKDNm6iqBr/d+1R017glvl
         UGZIrRfWrMGhkno2kGGr0FleUY43JQdOCx28g/W+lezrqyPTldeTrq7Vkj0+MNkgeeyG
         wxIKpxytgEeY7Hubcpo8l6VkECHQuFLvnSO7cGtkRbfLhamCQSUdRPdQWW/dJk4eOVpB
         e2wN+OIY2gCwwGR6wPMF+99UjlqIgnmh3ji07XoaG57SZb3AKC3QweXNbObTGDb3M47K
         Za7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793902913; x=1794507713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xe5bXUoSjdyUS5Z/rgEUMSGbH/+ArslOY+WPxBZy8QA=;
        b=olces0XuuNKwGYlvUMBE8IMkkxSmH4ohD7ocqlMnxgW4tJoR6Kva7rWpwV5NTQM+W4
         3Po3IFyoitcTbao154CfaUUTC2dSVYwa63p6ueOKgA7t/Nr4J6trsaPjGzF+utHTScse
         56pElqDfYGRT/9OeMylaIxlokpmnY9ZLWUudHZi0ucJiPQsypG1KdKwcChazSf8rsPhN
         AXBsCRoJ+5F54pQnTMOCCesEh4xB+9l6gn1BcGBnRF8id745ME4HW2p3ST9Ze5Tjd+SF
         XsmIRfleXQBrctTbedyxbyl5LecnGgzrGAMXMgWMkpJujndq1OdH0JdeHy2aqxsmpwop
         eD3g==
X-Gm-Message-State: APuU4Z968Egy6pg5/2vbHVs7rr0dfbpKGEOSGS/bRa8IlnITz743ubfj
	72fOdbX/hWtJqmIGc6Xs0I99qtEcC++P0uM5oDdc5E2BKwH28MBsuTARpIjqd+Qv
X-Gm-Gg: AYBFou3s0JhBlj795cQpndWJRYRxDZV1dhdNSh61S1TiDnpk/PsMMZPlMMckdLya99d
	IBZx77VcLBUEgaepv+7FOUHmolI+UHSHKZQMD1itK0wAZW9Cqt7jjVVVRnC5KL6cQ8+UiZGLoCH
	x3l8Vk0ATC7XT8Li53meSvLo2FmRFfHVpJfqgOAl99uKREpTDflkeAWgSOJiOUAaDw4aKNX4wXl
	H9Az+EkvuhGSjLB00qwAeHyY5thftmDojjocfMTVRXVP2ktraQWmuqxfra3fRWR7f43XI/NMzmd
	W5fly82WXHvtrzR9Qp65jQv6RasLsZcwrSO2dDn9Chko4UC+EfMpOy5BSCybRcWMI0zLIJN+VDl
	JcBY4VUc8RA80xJZVQ5lIOz1SNC5KdDUReKejEfwdHFUJ1pgleoMHlxdP+a/4R6ddcEjHb/zZIK
	Cekv62Zos3czR51YiQYldQWNw4JOuPqtYJjsbRI7HONifslNDw2MRkleWH+2lHf/t5WGioQRaWs
	DDvHERJDgq9R6KeJR/Q4upMZSWGKq0Q1FS+FfYf5onwpdfsJJtblNDCOlBdhTzkewjeLpv35Biw
	cAcvx0H0ZZxtc5SVF3pj4cpEDf0/EKP5y+LOzJYo3BTcYsPpb2wdJTXTybes5tOtU7qzBqspECN
	Ns9RGBSK/p2HB/sQM0tJIp4XaZqRTjnMxMvBhfuRV6A8vjB4/GyHDThiePjtKrjxy1wjF3iS3BK
	KnVuRDC4QBRMOYmPRO
X-Received: by 2002:a05:690c:e3ce:b0:8b3:343d:af6 with SMTP id 00721157ae682-8b3343d0bcemr9671047b3.91.1793902913216;
        Thu, 05 Nov 2026 10:21:53 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f7f084fsm1284817b3.20.2026.11.05.10.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:21:52 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: linearize GSO skb when frag_list skbs are shared
Date: Thu,  5 Nov 2026 13:21:51 -0500
Message-ID: <9997493edadfe9faa713c73de9c70e36cee9ffea.1793902911.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
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

When the iptables TEE target copies an SCTP GSO packet with pskb_copy(),
the new skb shares the frag_list skbs by reference (their refcounts are
bumped but they are not deep-copied). The SCTP receive path skips
linearization for uncloned GSO packets, so it later operates directly on
the shared frag_list entries. If skb_copy_bits() encounters a length
discrepancy or invalid offset in such a shared frag_list skb, it returns
-EFAULT, which triggers a BUG_ON in __pskb_pull_tail().

Extend the linearization condition to also cover GSO packets whose
frag_list head is shared, so SCTP obtains an exclusive, contiguous
copy of the data before processing it.

Fixes: 4c2f24549644 ("sctp: linearize early if it's not GSO")
Reported-by: syzbot+f15a6eff7a53f6eb7dc3@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/input.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 9494cfa51106..db3c7818724b 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -117,8 +117,13 @@ int sctp_rcv(struct sk_buff *skb)
 	 * it's better to just linearize it otherwise crc computing
 	 * takes longer.
 	 */
-	if (((!is_gso || skb_cloned(skb)) && skb_linearize(skb)) ||
-	    !pskb_may_pull(skb, sizeof(struct sctphdr)))
+	if (!is_gso || skb_cloned(skb) ||
+	    (skb_has_frag_list(skb) && skb_shared(skb_shinfo(skb)->frag_list))) {
+		if (skb_linearize(skb))
+			goto discard_it;
+	}
+
+	if (!pskb_may_pull(skb, sizeof(struct sctphdr)))
 		goto discard_it;
 
 	/* Pull up the IP header. */
-- 
2.47.1

