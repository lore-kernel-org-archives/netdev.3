Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707460;
	b=5fwwNgVB9w9ev7NN2Xkm07bHLYn2D13gKizsQEOv6coZeNdGqA66ZO7V3xAwfRgq9JYF
	 zwMlbbtsk/JRkgYRI5/hPFVALKQewPAIJHpA7InbIgWq7QATKU+UZEFFYMl+VH6gOMncj
	 A0uDZPkUmdWrq69CfGKqd1h21YJ6yrIpF0raK4M578AIyqZec8vEAM9ADXnXvcBnMUJPq
	 WxpQtONy4ABTQ/iOyEUC+xXCDcKGPSXV47sOhhxmhRgG29IeaxzXdVe27xHVd1VeVII17
	 BviltGaLJmwW3NQpX7sdO33SbpnDFy8C14Jcx2NA7FroB977GeoCiGzJ+dHGE/kHQ4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7OKZKq5bWJRvPZZK5dWDJTjLJm7QlhYtPLN2j1VdgDY=;
	b=E/1KiX1987IC4gDGX3HqVbV1FqDlIq+q/oYVZMJ0cMS8azm/wLq14fi/jpRiz8eB7w6c
	 kiENg5XVSNtPa6rS4SzwDIuQltnEM5QO/2NBjLpbwspJOM84vof6cktBTeKhgoKRogNRy
	 BO6iVuhvIeaJhORmYWEjHPjmR5OHBjOh0kOP6MRPTMlwUncqw8Wkh+Nco5DOJpQzMK7f3
	 lILmSt6qfWpuJ2jkoihWUIHynDZwheYzw4+M3EAYqWwh2ZCtpkbvb8DjDCfcWTpWZKj3P
	 HJcFgBUuTSks6/N8ttZ3p4TSBC35TZ4dwO75x3ih7klsjqt1aSz538p1nRY7zvXQjkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=X7iwt3K8;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8D9606A331
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D8D9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=X7iwt3K8
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so107855a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792707459; x=1793312259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OKZKq5bWJRvPZZK5dWDJTjLJm7QlhYtPLN2j1VdgDY=;
        b=X7iwt3K8FL9YCiFt7mb9M+OmKYmHxZALBh7bVXJeBJqMS/wbK4IDmW+cZTzYjWNA/D
         8BpB97oCGWr4FsknaXP4iMuonV6o7qZpwuGhp92ozZS+bQdRGWvUJZISD/tQADLkh7Mm
         +GIzrh4EJOovp3mbem6jl/5lwNCyu2GCjFcn4I0qO45YSiUn132q2WOhSXFvQh/BzBHB
         MRgSW22Q2ZNS2sQwbMYU0WWxa/f2IeurFIqz0gw4elaBGhWuhlwOjZ0PfgZA9N0tIogP
         FVPjPkTGj7Enw4+qk65CrEIdqjxi0ebrJizXM4HbdA2SUNoitzh0Ckk3FJKfn4kFT91M
         js5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792707459; x=1793312259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7OKZKq5bWJRvPZZK5dWDJTjLJm7QlhYtPLN2j1VdgDY=;
        b=z/z5pos4VUrFYgtXxUpoz+9OcZW/9wfIuc0gJINV5AW9r9WK89I7DVSIx9FQy5Bd07
         BK/RZ6Oxy/Tb+QNKUfVDLxcL/u0NA0YUUKN24We/Y5j9K/YiN0Oh9mgYypphhO/GPWxp
         zy1ApB2GqHr+VpD32ThJZx9Je071iQMEUo1h+dqMdFgQ5cbgwukMNeKxHGB3pkAwT5jE
         ru3yUxGcRj7J7L1MUnBhXVzjJqaQuB3HBstLiLs5rwo5BNvjJYnhZ/yq8Zch59c2BG+K
         LfMfqMX4QfYRQjZzm7rA/SJdPpVwoUZSVtGSehIDF0Yt6UqApUkkAAkYlPjntmwJMBYu
         EW0A==
X-Gm-Message-State: AFq9FYKTLrzhNWNy4IgzlbglXKEYNBIqPqrhpuWaq515c2ASFx4Ahhcn
	u5pi3s2C2gK5NLkRk1b1wgh8lgqT/130dw5OhrW2fpZGXTir43NztCg2FypJuKaJgtCDBNFv8cx
	t2KPBanseBWTbgjuzU9D48WiOsbhys7e1DCcl
X-Gm-Gg: AYBFou1jdWnfMq9NY8X91O2C41JMTWIqjbmWJPTjaPDIOX73tVCiNHS3TCpniy6o1n8
	HtJZcA9aK0Rm+s8kU1HgfoJURDj3xXky7ChAziVc9H6QeH4AKb4nbut7OVL068Ugicz/SXjCgJh
	l0jh/WIEMFFlcpqmJIwCgl/L14Om5/O7DPVPXARnFCSsrUtuChGEGmt3X37Bvxy3iydi11mJQu/
	04O9cbh1MEDTuE5Em2p6LFPNCeWykLSptcoyVstplwDkAonZkueUdk6u6E2DqLGdDb5IklsU6yD
	hrueYkRioGPGg9o0cxN+vYxpab4YSm79cihD37atgIGo8g09qA/2PnMoPsXGVBhLBCQ9DU6Adva
	8FpgqnVJcWPdYnL1EO/tQVn5DDuT1rwGZup0=
X-Received: by 2002:a17:90b:1805:b0:3a7:a6bc:9d58 with SMTP id 98e67ed59e1d1-3adce7eb299mr151951a91.54.1792707458760;
        Thu, 22 Oct 2026 15:17:38 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ada47f5737sm2921987a91.0.2026.10.22.15.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:17:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 1E1C2402BB;
	Thu, 22 Oct 2026 16:17:38 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 1AF1FDC48A1; Thu, 22 Oct 2026 16:17:38 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/4] tls: device: fix record start reported to RX resync in copy mode
Date: Thu, 22 Oct 2026 16:14:59 -0600
Message-ID: <20261022221732.1397620-4-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022221732.1397620-1-rjethwani@purestorage.com>
References: <20261022221732.1397620-1-rjethwani@purestorage.com>
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

tls_rx_msg_size() tells the device layer where each new record starts,
via tls_device_rx_resync_new_rec(), as TCP_SKB_CB(skb)->seq +
strp->stm.offset. skb is the strparser anchor, whose cb is copied from
the first queued skb by tls_strp_load_anchor_with_queue(), and
stm.offset is where the record starts within that skb.

When the header cannot be parsed in place, tls_strp_read_copy() moves
the strparser to copy mode and resets stm.offset to 0, but the anchor
keeps the first skb's cb. The header is then parsed from the copied
data, and the reported start is the first byte of that skb rather than
of the record. If the record does not begin at an skb boundary, the
sequence is too low by the record's offset into the skb.

Every resync type compares or advances that sequence. With
TLS_OFFLOAD_SYNC_TYPE_DRIVER_REQ and DRIVER_REQ_ASYNC the device's
request no longer matches and the resync is missed until a later
record. With TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT the device is given a
next-record boundary that is off by the same amount.

The header is parsed in copy mode when fewer bytes than the TLS header
plus explicit IV, where applicable, are queued under memory pressure or
with a collapsed receive window, or when the header straddles skbs that
overlap or differ in decrypted status. The latter is most likely right
around a loss of device sync, when resync is needed. Commit 9466ef3ec972
("tls: fix RX desync on overlapping skbs") added that queue-consistency
check before the header is parsed; before it only a short queue led
here.

The strparser now records the start of each record before it can enter
copy mode, so report strp->seq instead.

Found by code inspection while working on TLS 1.3 hardware offload
support.

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d1ad31986cf2..5db4a6897b29 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2232,7 +2232,7 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	}
 
 	tls_device_rx_resync_new_rec(strp->sk, data_len + TLS_HEADER_SIZE,
-				     TCP_SKB_CB(skb)->seq + strp->stm.offset);
+				     strp->seq);
 	return data_len + TLS_HEADER_SIZE;
 
 read_failure:
-- 
2.50.1

