Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7163B7753
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780771177; cv=none; b=SLol2Mb6Eo/fel6w0mribp4PcCFTSd4oF4JsTDzAfCn3TsKd7ifaH2VMcJxPJqs9KjhPqTSRHhYjF5Nrvu4jlCWYBY7LOHB9dIIHDC0sN7I2xvyQVOydbUjA/2Gab1Po3liKLVwpOnR8Xf5s+WBd8J4GIdg7xaJNF0Ur5lNZUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780771177; c=relaxed/simple;
	bh=hoInznijmXNcAlLWUOC8ZbwHn/36szbur3eTTIq96ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdnChC5M64ZQLxbScUDpde3TYhgUmyID/zr8Kv0JIH8bOGhRrBR7ah4HqjDEuW7PQIb6oRt/GzbKJ85jDWvrLLYv+dXW6sua4hkpKAdnLq55ImglBVjO50rFpsPvRIJvTQtAM3I0XmJHMoAiL0+A5cNUlsfG+eOnVTml+n0G2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsJClNQf; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsJClNQf"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9155183b42cso414656485a.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780771165; x=1781375965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BtPhLti09zjexvIxGQdE7OP+nneYPm4H1afCVbrLWGo=;
        b=gsJClNQfbVPdCTWQ8XzPk+xuvph/vNCFedKaThvpTzTlY8q+d78d1YrEavVSGRv+OF
         1RQgfuvZ8oUY5q2z8ZdTz84rkWGpWJDs0EbSrjwwJoHDBbIqxRTT20BU12QzLV9c1GkF
         snch88O4yHo9Au0yMZfUvpd6Zku3WEiY72DR0um+ixIF1yl7rVbEP6UA535JzU3TGvbG
         79WoVyMHU6WihQJaRJCEFQRSdfs1ohKEseUvA4EMXH6LmADavdmazTRs/5/RrY1FLGkU
         ygNGRZ6GKZMe9vhhYJvKFvWzuG+n1n5HQVIphghy5c2WOaSVlrWKJWSc/5MhuIcejFP4
         OT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780771165; x=1781375965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtPhLti09zjexvIxGQdE7OP+nneYPm4H1afCVbrLWGo=;
        b=AKwm7IDPP0+PoSbRZIslC+nuEs7OPUhcYHtpcE6+Qf6W5cvaI64TUUjYOa6cTuULBN
         nXu/fV2HoIGra/rciuTG/yJ7Lp0wIHJCAHgGf8v8xFmU9R7/+KTvSME0cLLj+rMinnSu
         fLxnB+Gweb3kroqnBVTIO9wLqTWHDUMk5f39KYKn4HswDlw2g6M4Lco75/llhLevjwiy
         YGwW1jkb8ba4CrYFbwEGqbo1o/D/NnFoxcSFQH5Beo9Ar6TY5sGZgGDBHX596dlTHx9I
         MZv1LzZdgqKJPhRKAJ9xbUMnGdUmnsmQZtDAWXOv6P1BU/UkSn50rZKiMOZShaFmh2WB
         9mqA==
X-Forwarded-Encrypted: i=1; AFNElJ8EP6lNvtUtIm8/Tl0K6NlBqdJBRw3NSrPK35MwSG/IXPggV8aWf3lhBRzQ5Sbs9ZZtn47z4So=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1KOwLxeGuILmR33/EC9tcbpSEJXqhblWscETzcaE8qA8aPMJ
	RqFsCLpDAiPV3DP2y8k0denxuX7ecTmnsl5tthoQSyWqN5VGzVLi+MCU
X-Gm-Gg: Acq92OF0RKmCpmI2KWktSE3XKCsKmE2IKPzE/lmXV5mNWufViparcMvsj+MODTBmHFC
	D0tOTe/idGeluu6PzBeEGq44RI9pCRsMHRY7TGF6uC82Se/I3vzyAUFNd7jQW2aXDuWiGIgJDQ3
	+svXS/X7i90b/HbfhY0l9uDFHb31vPAH98xXe9fhMpCPoyF1BJqlmXmTKNjAKRW4BdC1Rk3ktXC
	jF9NQwIuxNRv8K9BHE0AG52JGWv+9TtAbrdlyg8zolyA4tBVuPDTsJBiA+BJP9BTqhLvuf+AvtT
	xPTBDJZZ5UyOFaPnQXULkP2URrwgY7zZru5o34dPHUam05qASsGi2sn1QcaMGeQtgrdKC4uKXDj
	PxjoyhQUkfr+KZqdQDOkHNjLlyY/0xLg73f63PdvOIWMzECo86jIG1O7LDqIw7hyZGjPFtKGFXL
	EKNU7P9u9qDOEXbt66LIrx84d0mD2W+JZ5aDeej/nDmJzn/sKiyRP9UTZeEE+5r6S9OW4JAKjY3
	A+NLaxf5AZwTpSmiWugRcrJm3iimqg=
X-Received: by 2002:a05:620a:44cf:b0:915:92f3:54e2 with SMTP id af79cd13be357-915ad0a9f9emr1008248685a.6.1780771164573;
        Sat, 06 Jun 2026 11:39:24 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3d2384sm1223549985a.39.2026.06.06.11.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 11:39:23 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Yasevich <vladislav.yasevich@hp.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
Date: Sat,  6 Jun 2026 14:38:21 -0400
Message-ID: <20260606183821.1688525-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

__sctp_rcv_asconf_lookup() in net/sctp/input.c only checks that the ASCONF
chunk can hold the ADDIP header and a parameter header, then calls
af->from_addr_param(), which reads the full address (16 bytes for IPv6)
trusting the parameter's declared length.

An unauthenticated peer can send a truncated trailing ASCONF chunk that
declares an IPv6 address parameter but stops after the 4-byte parameter
header; reached from the no-association lookup path, from_addr_param() then
reads uninitialized bytes past the parameter.

Impact: an unauthenticated SCTP peer makes the receive path read up to 16
bytes of uninitialized memory past a truncated ASCONF address parameter.

The sibling __sctp_rcv_init_lookup() bounds parameters with
sctp_walk_params(); this path open-codes the fetch and omits the bound.
Verify the whole address parameter lies within the chunk before
from_addr_param() reads it, the same class of fix as commit 51e5ad549c43
("net: sctp: fix KMSAN uninit-value in sctp_inq_pop").

Fixes: df2185771439 ("[SCTP]: Update association lookup to look at ASCONF chunks as well")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
- Regenerate from net/main so the patch has index lines and applies
  cleanly (Xin Long).
- Use unsigned int for the decoded length and compare it against the
  remaining parameter space after the ADDIP header (David Laight).
v1: https://lore.kernel.org/all/20260604175803.2142975-1-michael.bommarito@gmail.com/

 net/sctp/input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index e119e460ccde0..c63d42500aa28 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -1197,13 +1197,26 @@ static struct sctp_association *__sctp_rcv_asconf_lookup(
 	struct sctp_af *af;
 	union sctp_addr_param *param;
 	union sctp_addr paddr;
+	unsigned int param_space;
+	unsigned int plen;
 
 	if (ntohs(ch->length) < sizeof(*asconf) + sizeof(struct sctp_paramhdr))
 		return NULL;
 
+	param_space = ntohs(ch->length) - sizeof(*asconf);
+
 	/* Skip over the ADDIP header and find the Address parameter */
 	param = (union sctp_addr_param *)(asconf + 1);
 
+	/* The whole address parameter must lie within the chunk before
+	 * af->from_addr_param() reads the variable-length address; otherwise a
+	 * truncated trailing ASCONF chunk lets it read uninitialized bytes past
+	 * the parameter.
+	 */
+	plen = ntohs(param->p.length);
+	if (plen < sizeof(struct sctp_paramhdr) || plen > param_space)
+		return NULL;
+
 	af = sctp_get_af_specific(param_type2af(param->p.type));
 	if (unlikely(!af))
 		return NULL;
-- 
2.53.0
