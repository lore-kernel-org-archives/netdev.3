Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4628E54CF50
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788876251; cv=none; b=Qh9owqBBQMumwJEHZCzYpWU/HCQHMBPmGpkrueuPzkkE8ICLBJN9vXkiFvUoSSqAVbD20ms4NOFg6GzJ2iQzXzLUBG3iPfRDbk98zd/fzKZgruP2M8+1tdWWXqHoGhh7dARs1XRrE+Lw1R/6zwlMv8IrXKytUwZyV8pORkIy17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788876251; c=relaxed/simple;
	bh=o8OJDUsi1EblG4IemLkpTLGA2t32bXV44ss9aRsOqrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qB7+4M7goYGxddjYGIdlGepBo5OgVhO5k3jIpOkhiLM+kGGWXrgopPaw2+MH/Bh6I6wS63gvmXISNOGE4do/QohBkWTOKQutfmsPuL52WASqPXMIr3VhmfoHVuvLWhFbf5czy3puWEC17n0G/UTSZyt5RAGG0JQG/YluDNrtaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=EsK1dTB3; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="EsK1dTB3"
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5C2EF3F601
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1788876236;
	bh=widqTYp4xzFs2TnDgQ6LHpL+FeDKARGSWMUbVfZCj5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=EsK1dTB331kJ0nIWoKytpCmZCJYOzFY9znTHubt/bCDtFJ+E7l4mExKKspnm3pRZy
	 dCYchISt1xgleMUgwnufT9D8Er3c4rido+APkLQRNmr2sHDGfamulyx3FB2o3tD7Za
	 eKnM1iUK8kEuKvqMKwLlIRBZySGQfsEOlzgbG4a5Q2ruhUJWdsiiWFj+GEdxodQMpb
	 wpkcKObGXNRKADKpJZmaAKAGNejXpLEsnx35dP91/2cAO0dkDsntJqmGqj7T33bWAd
	 l30GsHeK5wUwlhRyzjmhuxbVoNiDeEkSWFAFvtX6k6kvMQaIdK/kp8+DiKJmXiJ/UF
	 /eJLIX2OyrfFitzHpThNZSEaCta+I/X5Nmtu+mwZxTsEl9QSsWivaTkrrnG6ivcnXj
	 GqixaMW8kv0aNkAeWwibihEfk4uLRQDJ/V/kx4hFx2DBRJjd5EcD9hOHEEoqOCf7EB
	 hyMr3hGmtdi/ryHSbv2lBWvJPEtZyS7QFlgTDljL4t6mt7TGt2WEmjPotXzECE2zyk
	 hEvlBC7pDJ7EweRMSuwem1K+OUBqD/elV6D0xYVO979WrPboedEBMtDB6nL3lruHuY
	 8TFp2RF8bT3arfw+NFbgdBu/rgURgRxETTeh1VqlqR+UZLpc/fVCpZBz4FVnLcr0j3
	 ZodoeRqxKdB1MpWqvzjTwzJ4=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2531b5afe6so566615866b.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 07:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788876236; x=1789481036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=widqTYp4xzFs2TnDgQ6LHpL+FeDKARGSWMUbVfZCj5g=;
        b=CCKgMPCoOGvidmXaRMLb5X7E3jFL2CVZ7rDgiD+QidVhhsJp22/0uYPOWCCtKerkS8
         ZLBRHSH0FmU9rZ/i9Z7b1ntswfWLbeRXPf8mIPRSFYq2uMxnzhEoyooXJ30r+AK0Sp0k
         Ur3Gf10ZXCsG8J7n53VBBxERw15AMBLzAypEYr6QlQyme2au5ZaHeveX5GxDk+na/paq
         D1+uxiL3Avz2zAI4REf7vMKOO7Ses+LKkYq6V6/UweJMZNMOQz49lAAF7beVbQgdLQ2B
         wR2N99/VxjCZErh9zXNWV26FBqn1tT+amnfKFT88R0tLCytXX/XjOjMeFLH0SZFWjoro
         AxIQ==
X-Gm-Message-State: AFuF++kenIPN7BfdatXGmdHF0EPIVqAUK4HEL30ZiSsUxgzF6iq64MCE
	NZ15Jkpl2Um9mdpvJdX7FU1nOfGkZBhc5Y6pgpYbeGaDvR3HYqr3glutKHmWI/pfriGaOVrJosm
	iZ25hT6Fc4j9IQsap7kQzx1k+qpLmrK9tC63LE5lDdkOsHY7tcIY3H5uokGSve+10KK+/Lma5ww
	==
X-Gm-Gg: AYBFou1duF13gn0NlxDkcthDheXAglzAhUVk3gX75kSTV2cszVcTq9O7apNhfkj2HjU
	eYUHCMYMduWH0U6keXf+RUMLXYyJjdJDnIqx1xlMwVu44bfIZd2tvyszlOf9Vgp7W9RJ9NjPOjl
	JlZzKSsIvH7lC1rsUXBcb0cX99vq/VFEnorock15AZDb3NdIhU4yLhDB0N1dQBqPZ8jmFqryzLC
	mKlIlfTXxTw9q6gUQYxmYMG5wvV3NWpmYYT0xmrX9DtLf4PsyUmE/+PEGbGx9MWYk8m/cvm/pYv
	6FhhB8HHuI5cTy9tJLW3W3QnZhPSNCjyTcC7MixPyYu5gcv8fGi7DMZaXz2tCSYF+rlC3jyN+d3
	XMlTAV3cYqMDe97TnKJMzwqrq7CaWuuZN+Rtt61+aqeqtS7B9+Fwp3yapM0/NCMatyQ==
X-Received: by 2002:a17:907:9288:b0:c25:3e36:acc8 with SMTP id a640c23a62f3a-c25efbe1685mr1400565266b.4.1788876235919;
        Tue, 08 Sep 2026 07:03:55 -0700 (PDT)
X-Received: by 2002:a17:907:9288:b0:c25:3e36:acc8 with SMTP id a640c23a62f3a-c25efbe1685mr1400562466b.4.1788876235454;
        Tue, 08 Sep 2026 07:03:55 -0700 (PDT)
Received: from localhost ([154.62.191.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2622a7c677sm522959766b.9.2026.09.08.07.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:03:53 -0700 (PDT)
From: Andrei Gherzan <andrei.gherzan@canonical.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Andrei Gherzan <andrei.gherzan@canonical.com>
Subject: [PATCH net 1/2] netdevsim: print IPsec salt/key in network byte order
Date: Tue,  8 Sep 2026 15:03:24 +0100
Message-ID: <20260908140325.13367-2-andrei.gherzan@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908140325.13367-1-andrei.gherzan@canonical.com>
References: <20260908140325.13367-1-andrei.gherzan@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nsim_sa.key[] and nsim_sa.salt hold raw key material in network byte
order, but are typed as plain u32 and printed with "%08x" in the
debugfs read handler. This prints host-endian, so output differs
between little- and big-endian hosts for the same key:

  little-endian: salt=0x61626364 key=0x34333231 38373635 32313039 36353433
  big-endian:    salt=0x64636261 key=0x31323334 35363738 39303132 33343536

This breaks selftests/net/rtnetlink.sh's ipsec_offload subtest on
big-endian (e.g. s390x), which hardcodes the little-endian output.

Retype key[]/salt to __be32, matching ipaddr[], and convert with
be32_to_cpu() before printing. Output is now network-order on every
host, independent of endianness.

A similar fix was proposed in 2022 but kept the u32 typing, so sparse
couldn't validate the added ntohl() calls and it stalled in review.
Retyping first avoids that problem. `make C=2` on netdevsim reports
the same zero warnings as before this change.

Selftest update follows in the next patch.

Fixes: 7699353da875 ("netdevsim: add ipsec offload testing")
Reported-by: Kleber Sacilotto de Souza <kleber.souza@canonical.com>
Link: https://lore.kernel.org/netdev/20220308135106.890270-1-kleber.souza@canonical.com/
Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
---
 drivers/net/netdevsim/ipsec.c     | 10 +++++-----
 drivers/net/netdevsim/netdevsim.h |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index 36a1be4923d61..5722837bcda36 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -50,11 +50,11 @@ static ssize_t nsim_dbg_netdev_ops_read(struct file *filp,
 		p += scnprintf(p, bufsize - (p - buf),
 			       "sa[%i]    spi=0x%08x proto=0x%x salt=0x%08x crypt=%d\n",
 			       i, be32_to_cpu(sap->xs->id.spi),
-			       sap->xs->id.proto, sap->salt, sap->crypt);
+			       sap->xs->id.proto, be32_to_cpu(sap->salt), sap->crypt);
 		p += scnprintf(p, bufsize - (p - buf),
 			       "sa[%i]    key=0x%08x %08x %08x %08x\n",
-			       i, sap->key[0], sap->key[1],
-			       sap->key[2], sap->key[3]);
+			       i, be32_to_cpu(sap->key[0]), be32_to_cpu(sap->key[1]),
+			       be32_to_cpu(sap->key[2]), be32_to_cpu(sap->key[3]));
 	}
 
 	len = simple_read_from_buffer(buffer, count, ppos, buf, p - buf);
@@ -87,7 +87,7 @@ static int nsim_ipsec_find_empty_idx(struct nsim_ipsec *ipsec)
 
 static int nsim_ipsec_parse_proto_keys(struct net_device *dev,
 				       struct xfrm_state *xs,
-				       u32 *mykey, u32 *mysalt)
+				       __be32 *mykey, __be32 *mysalt)
 {
 	const char aes_gcm_name[] = "rfc4106(gcm(aes))";
 	unsigned char *key_data;
@@ -117,7 +117,7 @@ static int nsim_ipsec_parse_proto_keys(struct net_device *dev,
 
 	/* 160 accounts for 16 byte key and 4 byte salt */
 	if (key_len > NSIM_IPSEC_AUTH_BITS) {
-		*mysalt = ((u32 *)key_data)[4];
+		*mysalt = ((__be32 *)key_data)[4];
 	} else if (key_len == NSIM_IPSEC_AUTH_BITS) {
 		*mysalt = 0;
 	} else {
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 55aec41237b9b..a82a685384e6d 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -42,8 +42,8 @@
 struct nsim_sa {
 	struct xfrm_state *xs;
 	__be32 ipaddr[4];
-	u32 key[4];
-	u32 salt;
+	__be32 key[4];
+	__be32 salt;
 	bool used;
 	bool crypt;
 	bool rx;
-- 
2.43.0

