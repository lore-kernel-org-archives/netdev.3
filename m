Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334161;
	b=YnsELxOJX17yXUhg8MJiz1FQnthTscuP2Cq0sc4YHCHk6l8iQEvQv4iAMaH5o0qaBR7o
	 TFr8MJRfX66np3n4y2V7bILa4gsY3E1e7S/3w1wxtDPmNqkSvisC9ldGhYAF6I49AMQId
	 sUMvtkV6N3b4ruXxo/DlA0EAnAqlC0UkCQJMYFCA38ris86QpDqBtM/bSYXNA2de2sFV+
	 tdkSeKIGgMrH+VVkmLDR5yWm9RxqxXZRT+IwziCfHojac7LUd1waHjBtwQGnJ7dxJwMK0
	 dtUkys9g0ptJodx+DlNC+GDhn7oioQYboTnnhF/8ruoAX1wPX+L3dXTXQSm61A8B4ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=67W27p/QagU+bgmoCOvDgTbuvJiSS6L9t9Om4gfOTck=;
	b=Bx9bzhC0a6Ew3QpEIa9BMJZzTWn8bk19QK5JxIHmpDCs6usietQf0ncQsAUSJlkqAyRr
	 dvI/QEGkZneKhx0LTCweFW1c5wl4bcQi4JH7D4ZvlU1xkQSQeZ++hsj45F/qIFUGW+ZxK
	 XpTuAY3hLmkPeaRsaZEvWuQHilvwDMrM3uAFQSfkDAgrQ5jwVJi4bl1aZ3Q08ZFn3+Lob
	 Fb8ARdl1FGL3B5pNBtxUOmFPznBG2i4EK1ukNkRvBjD8stzKwRmCrTJgAYIe++Q5l5VsQ
	 a3WsSx+RYfbv35ejh/YF67R0RblB/5OIwnMGm2eKHMVHP2vl+hZj0Ap/eNQ7aULJPKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=aNhDxSLy;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD8606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0AD8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=aNhDxSLy
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-84d5e56f876so258792a34.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334160; x=1793938960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=67W27p/QagU+bgmoCOvDgTbuvJiSS6L9t9Om4gfOTck=;
        b=aNhDxSLyz1ZkZUffll5tb/D9lBZYdQj51d9JB9BCY+u3aDDAsZHi82xdG/llhnRlZT
         gMdeEH11C8c46kyEN/ZoCYdOHPAzncXjp2uRi4YXr2+CdIQPG19lTICxGtSKTezs4YQW
         qJPHDehTVxR70DLxIhqAbGeMx2SynNbZsfWFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334160; x=1793938960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67W27p/QagU+bgmoCOvDgTbuvJiSS6L9t9Om4gfOTck=;
        b=w+Z7NWFtfu6hbiwYdMG9R7UgKcXhHtjr4x9ECyhR9XTsStaB87coQb3VGm/2W+ZO1M
         zqWZFHBrQyabEgYhoWgwWb2Bu1w6StrTlianSUX689M2CsHKWs1eJVpXTqlBxAHGVCNd
         yqxiV73jTtjZ/rTT9b9lLWMBcOIhzJuf+jJ5myRcD3G7sXkNNHA31uhUILq9dR7z4kD/
         J6oz6QkjrAdH37SOzBfsTzpqrRmegxKAuua4Mf2euIBTvwqrojyQMT35KxFGhJvzDuF/
         0rYT5jcdWscPs3+rIUZ+851i/8Pp85Pz7x3SwwHLYFT90/SFvGOjdIT7i5vTxz/R2Y1b
         WXFw==
X-Gm-Message-State: AFq9FYL/7YEGUeC9sI9o4pLsRf/dDrOuxW1HOyNiLIpQTN29vU5+FQpN
	8FaN+ffBQeus7D+qy7ln1qlX/nlabC6FhtKL6VcBQc6ZHH7aWmUwoLrJql8h+B3ivzvWcQknKxo
	VXbTvtXE=
X-Gm-Gg: AYBFou24uofTWJSDcE7dGTSKjrHLUexgTl7P5eK+uW1E/YE+l7qZHBG+MFDTIbf6ICc
	v/r6svHXGihOx9PFRqpF9Ks3j7lRfmOKuF3r8FtBeBnXSA1ZRtdwYK6d3r7ugxpoVw5/75f4Rv/
	BViIfWIDyk+OfBzo7lVkP/7o37WxF3KcZIunwQChkWSf/bG8CFkxcQnF69nuSO4K4FDM+CgUXgW
	77ZmBNlWG/ZjrmfBP4wnorgPlUXIcwBvisnDWmXm/CFDsq7++klTu55cx/iY8DM+W0EnbFYJnaL
	j3KOzIfbQ+ObP1XszFAy+Np2dFduUPotk2m8dZHvT/WqafOQg2O87EG2ybQD9Nbqay7JtqSOmZu
	aWbVk1Nk4ubQ3DrZYKlLBlGk6KZeSEI8HeptpU/ZO5GBqrSzvWLkFfxoMgII20nWOC4rl4L7sDo
	zU8gGVpxFGrlUoZVPsrph/7tS+VcSm7Pi2lFM9MastKSUWJKfXuCwt694r3pBcQRwZ5vE31sb2i
	Mph2JWKWyZl3PE9IMUDIzEVsmn5IaRkz1UlhmbqT2BkziaBPa+vHQyyolxRoUWy+ZqDfvcf8ifw
	+01xlpSkPfv3wKvmgOr4bSLd+G45EKmLtnimHxn3EMCtKw5mWsr5mMncsURvZwRYPSaiCnTRRLH
	6lhC+qGzaEniypfGTEh9r4wePZDSQZSqfmsaaEv38nwoEjIidmbo=
X-Received: by 2002:a05:6808:1925:b0:4c3:4e34:c69e with SMTP id 5614622812f47-5640d919f60mr1177894b6e.8.1793334159798;
        Thu, 29 Oct 2026 21:22:39 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fe45587sm703285b6e.15.2026.10.29.21.22.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:22:39 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] macsec: reject frames that decapsulate into runt Ethernet frames
Date: Thu, 29 Oct 2026 21:22:37 -0700
Message-ID: <20261030042237.74106-1-kylebot@openai.com>
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

When an SCI is unknown and the C bit is clear, macsec_handle_frame()
removes the SecTAG and the default ICV without checking how much of the
frame remains. A short frame can therefore become an skb shorter than
ETH_HLEN. eth_type_trans() cannot pull its Ethernet header, and a second
stacked MACsec device can copy stale skb headroom into a packet delivered
to a packet socket.

The matched-SCI path has a related hole: macsec_validate_skb() accepts a
short_length of one, so a frame that passes the existing length check can
still become a 13-byte Ethernet frame.

Require enough bytes for the MACsec overhead and a complete Ethernet
header before decapsulating an unknown-SCI frame. Apply the same bound
in macsec_validate_skb(), using the selected SecY's ICV length, to cover
the no-SA, synchronous-decrypt and asynchronous-decrypt delivery paths.
Leave other unknown-SCI handling unchanged.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 drivers/net/macsec.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 87f3f4bdb026..240ba0ae07d1 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -408,8 +408,10 @@ static bool macsec_validate_skb(struct sk_buff *skb, u16 icv_len, bool xpn)
 	int len = skb->len - 2 * ETH_ALEN;
 	int extra_len = macsec_extra_len(!!(h->tci_an & MACSEC_TCI_SC)) + icv_len;
 
-	/* a) It comprises at least 17 octets */
-	if (skb->len <= 16)
+	/* a) It comprises at least 17 octets. The SecTAG and ICV must
+	 * also leave a complete Ethernet header.
+	 */
+	if (skb->len < ETH_HLEN + extra_len)
 		return false;
 
 	/* b) MACsec EtherType: already checked */
@@ -1331,9 +1333,12 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 nosci:
 	/* 10.6.1 if the SC is not found */
 	cbit = !!(hdr->tci_an & MACSEC_TCI_C);
-	if (!cbit)
-		macsec_finalize_skb(skb, MACSEC_DEFAULT_ICV_LEN,
-				    macsec_extra_len(macsec_skb_cb(skb)->has_sci));
+	if (!cbit) {
+		len = macsec_extra_len(macsec_skb_cb(skb)->has_sci);
+		if (skb->len < ETH_HLEN + len + MACSEC_DEFAULT_ICV_LEN)
+			goto drop_nosc;
+		macsec_finalize_skb(skb, MACSEC_DEFAULT_ICV_LEN, len);
+	}
 
 	list_for_each_entry_rcu(macsec, &rxd->secys, secys) {
 		struct sk_buff *nskb;

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
