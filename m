Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A0B339390
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 04:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788323329; cv=none; b=MNUhDi296cr3E+v/FWC1g7kAe5cza/RaJDO8Xt7ESBPjySFKikrm2tleIw9PojMWJ0hbsgc7S7vpQdZT1Fhrr+EVddDPELONCIWHdebJ3outxg2STz3cCoTJJa4mQpkYr/9satyt+gDb9N2gcJuFyLLaG7gRNPKBuIKffHMYepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788323329; c=relaxed/simple;
	bh=N21Vzv1HbZV2cyb+BOYOmKD0UqnOJLiHupk32XdQByU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usxEquCLPN6ap1qfJy0dlMDhgm67m2ntAUKQtHN4vA5D+Pod5BWoquN4WmTOGNJqpqgldGOwSmCbMYwXc9cNSZRPAERLemcmi+/5Yjwt7+buUcxX5EAXim9C27Zw44ZOqStwnnLEB8HyzK6uFG6LLTjJbrMdRlUPGSNMTVwcqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmtYSmEA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmtYSmEA"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so598388a12.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 21:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788323328; x=1788928128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rngmd5Sor8C1sREUFFjDMaCn8tg1D1lb1qOrOyed1nU=;
        b=pmtYSmEAHk6xgU2W76E3tZbyYLz5pmo9sQYW7UhIH1IlxjKplu2qwn7GTjmQF+3Dns
         4M6our5RTZhjSJSsZW7R0jyhQCCRp0RfEOjl5av4tCsAUXVWUgNjezwHFSF3NTHtiVSh
         GdDLFYmyQ2mx6Y8YKAeBTilAkObBuBPiLiuMcIDSXf2xtzOBzjA1XqDvUE1irBAuxgiz
         UDpDZMxTinRRCQclUpnC0Awq2thPeZcPLLT4LzAxzzjOtHxovfs/Ep1oGannNgCNSaWv
         jMFkkxIEVpaAar4u20eE3EgU5tZ0+ay3fREjbP4d5QZb/8KzkNeDeDFxFUZM/vdT9ISC
         Vh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788323328; x=1788928128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rngmd5Sor8C1sREUFFjDMaCn8tg1D1lb1qOrOyed1nU=;
        b=OTe1ED0khfAlRq1B9ppMjDcGqr2K9vLHgbm5ekiMGS4CB6AOk5FqlkmXtyChMB5+e1
         u5vvkLY3ivh8alL9FCEy3wLQ9sZ8XUHTCiSGlBrl42yHxIfygDZDudQxbU9azALUlZDT
         JfE5N4jHqfZz4R9ixCPU8zDuJSPromCSzhckojOlNd/iAtQ9koW6k/QKIHT/MJrM/JC9
         tP6pQmn0XtRsCKT25UwuPADAmDLbCS/cdRF3wG8wGCCgOCkLbi6oCUNComPoedybteHA
         CjmDm9KGyGpEO+dO63ksrOh48pydI4sC+M++pB58VGtjBh1pSBrJr6rREOKVD8GCFieZ
         htsQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFm4yHYl9BWphvfelYcVzd8mawJDFz+lWRrfK0T0SvKMmbzfJTRaAR/xqoXhdcWJB2fOIpU2A=@vger.kernel.org
X-Gm-Message-State: AFuF++l0dhuGdwa62xZPvmJrgTH2o/HvirtAb3ONHx/PGBDhFPHXgNdn
	U/CTNPy4e3qYhmwb74W/oN8nBtNE8dXCo/ubxihYM9QBbQ9RSKEC6ETk
X-Gm-Gg: AR+sD133ZCOAmHMOO9IeJqcAH/C6oUW394PJX/bd9z+9hlqQKQRLf4xo6SFE3gNaYLN
	IKfrbYAfGRlWTzwE+HB04oOXnzVNUMHlsmcr67fzgn9hJD2LIwLXqQ0l1sayIWRNJDhNpT7H0J+
	LMD72VSxxDS1wx1OOf3Bb6zHgqdpXH6Q3+8DMxn6BffwTGM40AmqJnLR74YP47KdCggQ8L78/Es
	VPpuZrrzu5f4Pai1BNAexQ/uNQyjFieetWCp5R0vKrJZ+SDDz8pHkb+q3ujXpN8mnIms7Laxnf1
	0xcy811zeMxXC6yLFwvYwHW+PzLw5htTCGFtzwzE6s8bXjzWO9VfP/4+T0eQ6W2YSOkldavqwb6
	u79XwC7gtoNpjYhOBLRy6ChGWosFB2A5MBktHTyj0VhmhN7LGa1BUvQ7v0uch8ixElfvBLKlqbQ
	b39Kgcgxtz3Sm7xxXOypS9PSQRW8aZzJB35YDOWmefpO0rK9QoDfwXEbzd/QCK0+yqvp8eKQ==
X-Received: by 2002:a05:6a21:6003:b0:3d3:ae0f:526d with SMTP id adf61e73a8af0-3d9b0e3f1efmr3397268637.25.1788323327814;
        Tue, 01 Sep 2026 21:28:47 -0700 (PDT)
Received: from c79home.localdomain ([14.154.12.105])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc3473ff3e5sm409503a12.4.2026.09.01.21.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:28:47 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Yifei Chu <Chuyf26@linux.alibaba.com>,
	netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH net-next v2] pptp: validate available payload before parsing PPP fields
Date: Wed,  2 Sep 2026 12:28:27 +0800
Message-Id: <20260902042827.87534-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pptp_rcv_core() looks into the PPP payload for two special cases:
allowing old-sequence LCP Echo packets and stripping PPP address/control
fields.

Both checks read fixed PPP fields directly from skb data. Make sure the
bytes being read are present in the skb and pulled into the linear area
before dereferencing them.

Use the available skb payload length for these local checks, matching the
existing receive path which passes the remaining skb data to ppp_input()
after pulling the PPTP GRE header.

Signed-off-by: Zhixing Chen <running910@gmail.com>
---

Changes in v2:
- Use the available skb payload length instead of the GRE-advertised
  payload_len for the local PPP field reads.
- Pull the required bytes into the skb linear area before dereferencing
  them.

v1: https://lore.kernel.org/netdev/20260813082247.31499-1-running910@gmail.com/T/

---
 drivers/net/ppp/pptp.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index a797a0606f6b..4fb94a455c57 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -275,6 +275,7 @@ static int pptp_rcv_core(struct sock *sk, struct sk_buff *skb)
 	struct pppox_sock *po = pppox_sk(sk);
 	struct pptp_opt *opt = &po->proto.pptp;
 	int headersize, payload_len, seq;
+	unsigned int payload_avail;
 	__u8 *payload;
 	struct pptp_gre_header *header;
 
@@ -314,23 +315,34 @@ static int pptp_rcv_core(struct sock *sk, struct sk_buff *skb)
 	if (!pskb_may_pull(skb, headersize + payload_len))
 		goto drop;
 
-	payload = skb->data + headersize;
+	payload_avail = skb->len - headersize;
 	/* check for expected sequence number */
 	if (seq < opt->seq_recv + 1 || WRAPPED(opt->seq_recv, seq)) {
-		if ((payload[0] == PPP_ALLSTATIONS) && (payload[1] == PPP_UI) &&
-				(PPP_PROTOCOL(payload) == PPP_LCP) &&
-				((payload[4] == PPP_LCP_ECHOREQ) || (payload[4] == PPP_LCP_ECHOREP)))
-			goto allow_packet;
+		if (payload_avail >= PPP_HDRLEN + 1) {
+			if (!pskb_may_pull(skb, headersize + PPP_HDRLEN + 1))
+				goto drop;
+
+			payload = skb->data + headersize;
+			if (payload[0] == PPP_ALLSTATIONS && payload[1] == PPP_UI &&
+			    PPP_PROTOCOL(payload) == PPP_LCP &&
+			    (payload[4] == PPP_LCP_ECHOREQ || payload[4] == PPP_LCP_ECHOREP))
+				goto allow_packet;
+		}
 	} else {
 		opt->seq_recv = seq;
 allow_packet:
 		skb_pull(skb, headersize);
 
-		if (payload[0] == PPP_ALLSTATIONS && payload[1] == PPP_UI) {
-			/* chop off address/control */
-			if (skb->len < 3)
+		if (payload_avail >= 2) {
+			if (!pskb_may_pull(skb, 2))
 				goto drop;
-			skb_pull(skb, 2);
+
+			if (skb->data[0] == PPP_ALLSTATIONS && skb->data[1] == PPP_UI) {
+				/* chop off address/control */
+				if (skb->len < 3)
+					goto drop;
+				skb_pull(skb, 2);
+			}
 		}
 
 		skb->ip_summed = CHECKSUM_NONE;

base-commit: 25c1f6111034aef7fc06cfbdcf1e4f0d6e5ee74b
-- 
2.34.1

