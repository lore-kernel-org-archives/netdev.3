Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51836B93C
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786609432; cv=none; b=PV4A0AZq3OKC7KMZCtJvDFpzgOXBCdwXQdLpAZvIdn5PqZvFNNakbebvAiZC4rhs2ve2kXTdof8sqX4qZ8CpgxcoUTy7LFMMHw7A2NKVsmAiwo3+Qp0WQzANZb3Af0hVBtFuFZ4BeCJaEfq1QDg05E6KTn9+tbzc5Vj2PenYQlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786609432; c=relaxed/simple;
	bh=VBQD34twbTX/KlyyGFX8UI8SPcf2/piw6Ix5oQtjqZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RYpYgr052YfiiJU9LLdsQQSx20joy2VsQm0b+238Ppf/s3MQs82DaMb2ixbzDA/aJwNr7IEEmjECIPPaA38e9EO7hGMXHC9nQRMlZpiGFEojhsOX90ZCpaMM+dH5OGpkO7At8wNRntfSfnrjzyHTODBYVkew48vzkaW6udlghWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhE3An2l; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhE3An2l"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacb8416a1so22652015ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786609431; x=1787214231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j4dJ17/MmMP7lZvLg8mvMoTWvikj2SGroCwhkkBrmEE=;
        b=JhE3An2lsMTw9rDtkNKrwma0uC/GGZ10dB3ABtGfOhL0AM3pAQWJKpXygr5SsBXXXC
         PXtxMiu1VdE/06BRSgQxYOevjdAlzVahDQBAn1AM3UWQPrAAMC1Sx8PjFD4kRgQSCSgX
         6FfvO1gVLQufjq8yqoSnyfqnHA93EvI9YBX5W9r7qyT/A2UZic6sQ3ka8AgW9rfSrPGT
         Cyd+AhfCcSVxiojaPR0POilPHwEvt91BETFssLpf7vaGRHL4WF20CIcQlfCk9zwxyIm+
         uIB83I0Hm7Ygigcpk3V297JF7UJyNhETa4gUfOEtuwkBThArwYWiDvcXXbxVWowWPvXF
         ZeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786609431; x=1787214231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j4dJ17/MmMP7lZvLg8mvMoTWvikj2SGroCwhkkBrmEE=;
        b=GbYk5IfPn1Kp3jT5forgzYGiZ0g8Y2njNDdA28YhWkijnK3v4e3RuYD4eO/8df4ajG
         db1pZ9EgC/kWgqAsQ1aNDRd74O6oWJ/MTbjM0N0Kk5UkfH5HB1KRWTS1bfPFJPFjU6+2
         qAbAJZfXuBhJWydmilncK9gmukOB0bFU9LhDwMmrwi9VtJOCjRJo4ENJAE4ZrTk++CK6
         YBcGgwsRxbclIR0jTcEp1sLf2Td2icqxhmwf/936H0SdUaajZYTg5Bxu/5ryzN/josXK
         TTtzzFFgGBGaE+25lZ1meF2rvOlsEiMj1by8VLQV2t8P8BvEgIKUmpjPkJIku8LvlF+1
         E8HQ==
X-Gm-Message-State: AOJu0Yy0Lz4bzrAgb3jHRo0WQnsoEqzYAuDMpVM05KWLMfcn2zSwmQGW
	f0qhVKryG4J4P4Gtz3FZYQdZpM4a9dHr6cflvE28/JqQumccUuo04wsX
X-Gm-Gg: AR+sD13b5SFCZ9bbV9fVf/GUJ6Ae1KPlwMS0UOKzNDJcrFkgQb1ciMbzr6hSFceqHsT
	Igsb8TtTpC41a1YHCzylO4fYzYWFaGCK2WT+hKB5MP93a8YqDJUkWUBIcxt9ny6VOAm38I+Y1UH
	rhZ8ZY7P3Rmn8IeJwoRnld0PE0zPCh8E0qknKG8NBLRqwTErI3Y6aYTgKV2lJ3SkgTZQelQna5W
	Y5eGC3+PaAghUhnWeVzAtLzRTvYHEbgdJMwdAUKEBZksKDkRgix5OIUYPG2v/S6cEwtQPtpUk5Q
	rfbv/EMdydq21jaMcPp4ZfyYG/ObKLI7K0R1uPyC+CwSr9CGWbm/hy0aYkZnzz4oOuqzFD4zQe0
	+eqfhh+g+pg6IyEP5jOjYN3/hEzjAL7NhnCKH9d+jkQiYEvNy1WLqNuUaq2o2Klil53cmo+9DEc
	mzk724yI7wi1AGKW57iCGsCUyyCAcecEJIUBWrkmc62ELZGR7lpI5CcnkHmTOV1fQHj6/DLM8=
X-Received: by 2002:a17:90b:2e50:b0:37f:df85:272f with SMTP id 98e67ed59e1d1-3931e30bd44mr4997948a91.19.1786609430588;
        Thu, 13 Aug 2026 01:23:50 -0700 (PDT)
Received: from c79ofce.localdomain ([103.165.85.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cecbf08sm2387592a91.12.2026.08.13.01.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:23:49 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH net-next] pptp: validate payload length before parsing PPP fields
Date: Thu, 13 Aug 2026 16:22:47 +0800
Message-Id: <20260813082247.31499-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pptp_rcv_core() pulls the PPTP GRE header together with the payload length
advertised by the header, then looks into the PPP payload for two special
cases: allowing old-sequence LCP Echo packets and stripping the PPP
address/control fields.

Both checks read fixed PPP fields from the payload. Make sure the
advertised payload length covers those fields before reading them, so
malformed short payloads are rejected before their PPP contents are
evaluated.

This keeps the receive path within the declared PPTP payload boundary.

Signed-off-by: Zhixing Chen <running910@gmail.com>
---

While testing PPTP stability and reviewing the PPTP driver code, I noticed
that the receive path can reach the old-sequence LCP Echo check and the
address/control field handling with an advertised payload length shorter
than the PPP fields being inspected.

I exercised this path with malformed short PPTP GRE packets and confirmed
that such packets can reach both checks. The test packets did not trigger a
KASAN report in my setup, but my understanding is that the parser should
not inspect bytes outside the declared PPTP payload when deciding how to
handle PPP fields.

This is intended as a small robustness improvement for malformed PPTP GRE
packets.

---
 drivers/net/ppp/pptp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index a797a0606f6b..708d8fb3a900 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -317,16 +317,18 @@ static int pptp_rcv_core(struct sock *sk, struct sk_buff *skb)
 	payload = skb->data + headersize;
 	/* check for expected sequence number */
 	if (seq < opt->seq_recv + 1 || WRAPPED(opt->seq_recv, seq)) {
-		if ((payload[0] == PPP_ALLSTATIONS) && (payload[1] == PPP_UI) &&
-				(PPP_PROTOCOL(payload) == PPP_LCP) &&
-				((payload[4] == PPP_LCP_ECHOREQ) || (payload[4] == PPP_LCP_ECHOREP)))
+		if (payload_len >= PPP_HDRLEN + 1 &&
+		    payload[0] == PPP_ALLSTATIONS && payload[1] == PPP_UI &&
+		    PPP_PROTOCOL(payload) == PPP_LCP &&
+		    (payload[4] == PPP_LCP_ECHOREQ || payload[4] == PPP_LCP_ECHOREP))
 			goto allow_packet;
 	} else {
 		opt->seq_recv = seq;
 allow_packet:
 		skb_pull(skb, headersize);
 
-		if (payload[0] == PPP_ALLSTATIONS && payload[1] == PPP_UI) {
+		if (payload_len >= 2 &&
+		    payload[0] == PPP_ALLSTATIONS && payload[1] == PPP_UI) {
 			/* chop off address/control */
 			if (skb->len < 3)
 				goto drop;

base-commit: f6057f06ef7afa9893ed33603f7917fa39d237b5
-- 
2.34.1

