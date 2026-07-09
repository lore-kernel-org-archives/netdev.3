Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E536C9E5
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783627742; cv=none; b=QQ7b0uH3apBUL3IrNzvSRRTIeREOhtlAg3OqNnzl3MkYdvZDKNKUSkhPMsxFLrRNUaUq7dGsZ2+i9PMLLsq2MpitS2azd0CEccvTrMUdBAb8kKco07OxxkXmqG7fFevtgX6dNMP1B/9Q35shNfIzPZH517nvOu8+LALyxinjiBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783627742; c=relaxed/simple;
	bh=Rtt8nr3qT6hzMGJBoDeZojgqNi/SCvnpBDlzHvuaz5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTdRtB5qaug14hUDOJMVPdWiyUJXHzK975eJ4920arytFN7ZK4E3s8TXuJtLJcHaVfidw8sJFPM+7OOvkXik4llSb60AByii5GwmtMjR8OFy4k/AzBBb1WQbKY2BvXYnBoyKEGHKEYJDymaUydzzerzlYd/JEtkQifIWKdWMffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d21jD8Nk; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d21jD8Nk"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-382ef647e20so348992a91.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783627740; x=1784232540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+lEIT10jaUsYVAQviHGdUkscS5sAHeOl4kQGTRtqCbo=;
        b=QbCfrHSfA0q/YsROygxqCnMAvM3D/6gPq9vQqU03uJFgE8PaZZG7giDBYDHQnLU+rA
         NxEHAN0tz98JqAx1DzFe6GZtwJL2lH9jx3gNEzaPqzThH0ztuOP0ke4lIZ8nfy2sTZ77
         x2eB6bMHxNGpOHHlmeAZha3diDC63L/0hvsjJvHHrDsEHShGIW+kdCzBx+kf0YxK7d0C
         Y7KsufaIksfzrql6+dKjbq/NiZtg1vypteHGHH/lyeeBubFbDNT+KQZDkkfPPImMZNch
         WXZqq/8js4h0pVDIoSDEfht0nrtLik7yPty9jWEb24Wq8ZwCfVbXq5JhBR5NKx6aKWkS
         PP5A==
X-Forwarded-Encrypted: i=1; AHgh+RpfNq/VqWECm3eJfBYOB3I2Bhfj+OQPAIOsVjXUixi01TlRhNYuVUAgNO/ca4sd4c61BdFrYRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMdKnuwPfa/f4X9Rn/mrjunyBvCBcITojjbxezKtH9znmuO1DH
	cKni4AuqCLf8ht0U7h5btycHgxOJ6pk5HFVNr7S0mc5r5F7kF0PsuFVjorObntUCrPpmWOrLQoM
	/Lyev8ZFLfA+5ECfeIFeMlHs8We4hEBayXxB/A/htrOdk/1/6Q8Qw4ZfHJcGM3JZzwsUqzkGHr6
	rapsPN6URqF4WUIDdWyBEygs2M0aopQQyIA4BtYZMoj7HWfyBezDsOMPOn2lQ/hxM6X1ZliEVrR
	KGZwtlLLrnHnZD2cAYF
X-Gm-Gg: AfdE7cnq6c2voOQdf/CzftoB7+dVHWLYRScRtEweb7cucNjvEGrzLZFTbrzEtys6Qov
	TOQMuY92cngZdMDMrX4V/wlRoJu+DnO+Zq3RYYMDvsmB3y9WcGE3Ia0bNU8+Be4uDofZEdZN1uK
	8kxlLQ+Z9umlgDLwEONWMe+9mj7U9Z2A3Bgek7il/Vm5k9sUceaVx+0EZFhYtVjIUIywktX0MTQ
	howXTnS8XcItHCTfy/a+j3/sYDKoBEwacvl0n/Xfu7H5n4mFMnDlyBbFwrhMRNUEVrwgVHtSpT4
	UqmjnAtuKaFP6QKgk2LDXczIE6JHMmwkYCBpPUfwjkcaABleqxb4cD/ptRAIyS69Nbm2+uAsEby
	GdFuJ6PpvhDNSLz+1gaXdKWVOGeiURTahPzRnO4lxEALeYOD48pUFQH+0ypGIzvspJQnlHwYVDQ
	pFkvuAAbhiJHtr3i7Sm/QNouoc5L3RlAUd9wwkZQ+APdHeTT2PHfGZ
X-Received: by 2002:a17:90b:2709:b0:387:e0db:3d88 with SMTP id 98e67ed59e1d1-389434634ebmr8605039a91.35.1783627740020;
        Thu, 09 Jul 2026 13:09:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-38a54681052sm254000a91.2.2026.07.09.13.08.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 13:09:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c88fc985a65so290347a12.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783627738; x=1784232538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+lEIT10jaUsYVAQviHGdUkscS5sAHeOl4kQGTRtqCbo=;
        b=d21jD8NkPYyoHp9FTM4GFyhlCyxpO7KV8g7bmgJh1z5LaD6YMjBCwu5mwKnqBk2oj+
         97zRGL0fssrq+6JYHmQmlNi72BFBbrEkuEn8LQ7v2jYlgz9XWu2rlP0X5sqHgGRvZsCW
         XBRbSKHNrTCShmxgNM4/El1zcqyAnJfnfjA58=
X-Forwarded-Encrypted: i=1; AHgh+RrwtS+2+zP82IsrR8lvPgQ+4GPF3dGIbw8tAWPxzt6sPebvKm8Rq3NJ5eZ2TuNSUWFDjb1YZ4U=@vger.kernel.org
X-Received: by 2002:a05:6300:141:b0:3bf:a38b:e8ca with SMTP id adf61e73a8af0-3c0bd3118e9mr10086204637.59.1783627737917;
        Thu, 09 Jul 2026 13:08:57 -0700 (PDT)
X-Received: by 2002:a05:6300:141:b0:3bf:a38b:e8ca with SMTP id adf61e73a8af0-3c0bd3118e9mr10086183637.59.1783627737460;
        Thu, 09 Jul 2026 13:08:57 -0700 (PDT)
Received: from lvn-dbc2448.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b65960d88sm28947940c88.6.2026.07.09.13.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:08:56 -0700 (PDT)
From: Harshaka Narayana <harshaka.narayana@broadcom.com>
To: harshaka.narayana@broadcom.com
Cc: andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	guolin.yang@broadcom.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ronak.doshi@broadcom.com,
	sankararaman.jayaraman@broadcom.com
Subject: [PATCH net v2] vmxnet3: fix BUG_ON in vmxnet3_get_hdr_len() for Geneve packets
Date: Thu,  9 Jul 2026 12:47:03 -0700
Message-ID: <20260709194703.3678075-1-harshaka.narayana@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260707165248.1859188-1-harshaka.narayana@broadcom.com>
References: <20260707165248.1859188-1-harshaka.narayana@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

vmxnet3_get_hdr_len() assumes gdesc->rcd.v4/v6/tcp always describe the
outer header, but for a Geneve-encapsulated packet the device can set
them based on the inner header instead, signalled by the
VMXNET3_RCD_HDR_INNER_SHIFT bit in the completion descriptor. Since the
function never skips the outer encapsulation, this mismatch triggers:

- BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP), because the outer
  protocol is UDP (Geneve), not TCP.
- BUG_ON(hdr.eth->h_proto != ...), when the tunnel's outer and inner
  IP versions differ (e.g. outer IPv6/inner IPv4 or vice versa).

Check VMXNET3_RCD_HDR_INNER_SHIFT up front and bail out, since the
function cannot locate the inner header it would need to parse. Also
convert the remaining BUG_ON()s in this function to return 0
defensively.

Fixes: 45dac1d6ea04 ("vmxnet3: Changes for vmxnet3 adapter version 2 (fwd)")
Signed-off-by: Harshaka Narayana <harshaka.narayana@broadcom.com>
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Signed-off-by: Sankararaman Jayaraman <sankararaman.jayaraman@broadcom.com>
---
v2:
  - Check VMXNET3_RCD_HDR_INNER_SHIFT up front to catch the Geneve
    inner-header case directly, and convert the remaining
    BUG_ON(hdr.eth->h_proto != ...) checks to return 0
  - Reworded commit message to describe the root cause via
    VMXNET3_RCD_HDR_INNER_SHIFT
v1: https://lore.kernel.org/netdev/20260707165248.1859188-1-harshaka.narayana@broadcom.com/
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 40522afc0532..dedf4082eb6c 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1530,7 +1530,13 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 		struct ipv6hdr *ipv6;
 		struct tcphdr *tcp;
 	} hdr;
-	BUG_ON(gdesc->rcd.tcp == 0);
+
+	/* v4/v6/tcp then describe the inner header, which we can't locate. */
+	if (le32_to_cpu(gdesc->dword[0]) & (1UL << VMXNET3_RCD_HDR_INNER_SHIFT))
+		return 0;
+
+	if (gdesc->rcd.tcp == 0)
+		return 0;
 
 	maplen = skb_headlen(skb);
 	if (unlikely(sizeof(struct iphdr) + sizeof(struct tcphdr) > maplen))
@@ -1544,15 +1550,21 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 
 	hdr.eth = eth_hdr(skb);
 	if (gdesc->rcd.v4) {
-		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IP) &&
-		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IP));
+		if (hdr.eth->h_proto != htons(ETH_P_IP) &&
+		    hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IP))
+			return 0;
+
 		hdr.ptr += hlen;
-		BUG_ON(hdr.ipv4->protocol != IPPROTO_TCP);
+		if (hdr.ipv4->protocol != IPPROTO_TCP)
+			return 0;
+
 		hlen = hdr.ipv4->ihl << 2;
 		hdr.ptr += hdr.ipv4->ihl << 2;
 	} else if (gdesc->rcd.v6) {
-		BUG_ON(hdr.eth->h_proto != htons(ETH_P_IPV6) &&
-		       hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IPV6));
+		if (hdr.eth->h_proto != htons(ETH_P_IPV6) &&
+		    hdr.veth->h_vlan_encapsulated_proto != htons(ETH_P_IPV6))
+			return 0;
+
 		hdr.ptr += hlen;
 		/* Use an estimated value, since we also need to handle
 		 * TSO case.
-- 
2.52.0

