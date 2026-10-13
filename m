Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA6531639
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791914065; cv=none; b=qta1dEdUZO6kC07englikxn4pHYw0FO3SxZaBSTg3qSgTa7rp7Jt6SqD7jQKU8PN62kaAqzXHjSrbpL29J65vR5eDO8alLjxKZfyThuqvKHawRQUVAKL6x0+bgXNZtSHOs14sDJo9AoNLxAIXJ8O4dKjPXBB79vF0lHfAxgclx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791914065; c=relaxed/simple;
	bh=DICuuSQsL9cW0882yat84ZKiXS42C1gmUGcVBN9M/2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqZbo5cu3vAi0ykVqwfGYLEwtq4Un2VNf6/dAp0u0cemiRbRSmbqBYCskOLrnABpTrWdgpM/lKYP4ML/63OCzqn9R8qfc/BJSmKKbZ2C+OYFHC+dzj6zT2uRbXJrMOgoFVsXktsHuv84Svj3M7zAk4CIwl/8LZdPbCTDZi5yGHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=J2cPlOLz; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="J2cPlOLz"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-354ba08cfd1so5487013eec.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791914063; x=1792518863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nBU1EIfeJzr2PDW5mmgopthXhZxcqsKna3lW0pjw7nk=;
        b=J2cPlOLza8Isw/sO/iyLNE1HUJof13aNtMlNDBYq/ZG5E5ETNXGwav3oPaaoM/ALGD
         DTJFu2oLBI/NQ+1+cRCbQPC7Qj4HnFxre6Phj7BemoJ+RbYEW3VZHOXrKmUuG/XH+dsM
         aFrlKRTDILqAXW7y0ZYVNqMM1wXEPY+LoJklPvdDcfKG9TikV3R8s39/HEaDcRxVEoAo
         Ad9hDCysz400rUsvlTgAsOjvivmRYosJfqvi7uEjFBv4u0vc9njTsogO9aAv1jnNb3f2
         TfTVK/GindYvRY33XmWhlg1xZSILAFgz5MsL46wz2qRg9EfjEAMo8QThTSHId/0HZdHB
         RA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791914063; x=1792518863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nBU1EIfeJzr2PDW5mmgopthXhZxcqsKna3lW0pjw7nk=;
        b=VgpLt4mmm+qaPDh0qXHZuqh8BKN/64VZ3lV1Bh+klIkteXCp2zWWFwkm7nYm73IzSR
         +dCSokK2JhzJxToClaWp4LRvrkey0SJrUckRRqzleb2C1MXP66jsRzjl057fcwhWWZlg
         VQ1Ye6a8XEHRDsJstn/eVNFkFqMDFdrJ4q1tnB0Ndb+Ad5PGB30afR24Z46UPaqAZpyz
         pM0vsiTfRfRJM/nOEHtWk5+kcaU4UfaGObytmujh87PYWRnqPyj+9FZzl4fzaS5qIbcv
         BgrP6NQLaF4xgHlBX4fqlbv4iC8O+bPLsuNAiPh8fPSg/eOvB72OdMuAa9/TrdcFG3kD
         QfMA==
X-Gm-Message-State: AFq9FYJBjFN6q1ygrWyogk4ns1HWMXq/EltkjqDvq3k5C06+Kadq1/4T
	E/CvreHIizuWx6f3bZtQIEbjsCgGloZaSzZrPiR7lN6qpYyhefPOxdSXwbuA6Fg6T5w=
X-Gm-Gg: AYBFou0SIUcvUFqfWbgu5x651W5fVzRU/beaMcyqnmt0rSGSt3XFPWITX+o9vM2gIjF
	21FDielWH+uNPpstWDya69kmrYvcnhJy0sSI0UQfZNF9RA/PH9FBd7ni+yvK0NWtbQRMJjef9rz
	tl3Qc221OFhukX9nNn21l7vMNM2Kzz/cUVJqIx014WRnvZiMU6iFOZCc1JX3axx/gnYPnV4F1RD
	W0dtsvZiz+JX+AdEaci4BikBvGMZ32JTpybaKEbPePZlmTQD0UX3P1ox9yW+oedVcXbH87CEgYP
	dED7IjQxSfX2GLzZ7I+cv5VxP8kD+D/UZN9Z59JrzZyEgp7otKqCoYcAzhSS1IUfrVwSINU7LO9
	X1qyini/6wHVUqlvkZAxRwrU3JIRETvioXw/ZWtsWtmRc1MCQ3nPoyikcIbn3BTFd3qo9ai/ctl
	Nv3+SeKVB/81wIQlfmN5REcvBfC/xB0nEpiyb4VZPj8k2ywZqfm0meCY5ANjszBCVK5yJThMyv+
	Rw3tczYiGU3c2fwmx7O+eXFgX5hB8T37Pbi704QLabGBmIvM54Asxr2BjnKt9fM
X-Received: by 2002:a05:7300:d084:b0:35d:8c3a:38a8 with SMTP id 5a478bee46e88-35d8c3a3c06mr327290eec.39.1791914062710;
        Tue, 13 Oct 2026 10:54:22 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm50183362eec.17.2026.10.13.10.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:54:22 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v4 4/5] amt: make pre-query report drops visible
Date: Tue, 13 Oct 2026 17:54:06 +0000
Message-ID: <20261013175407.947606-5-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013175407.947606-1-omar@blockcast.net>
References: <20261013175407.947606-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A gateway cannot forward an IGMP or MLD report until it has received the
relay's Membership Query for that family.  The Query supplies the
response MAC the Update echoes, so dropping an early report is required,
but doing so silently leaves operators with a dark multicast path and no
indication why the join never happened.

Emit a family-specific debug message before taking the drop path.

tx_dropped could not show these drops either: amt_dev_xmit() reaches the
same tx_dropped increment after amt_send_membership_update() has handed
the report to the tunnel, so in gateway mode every forwarded report was
also counted as a drop.  Return NETDEV_TX_OK directly once the report has
been sent, so tx_dropped counts only reports that were discarded.

The device is LLTX, so amt_dev_xmit() can run on several CPUs at once;
use DEV_STATS_INC() for its tx_dropped and tx_errors updates so
concurrent increments are not lost.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index e466cf8..884f27f 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1236,7 +1236,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		group.ip6 = ipv6_hdr(skb)->daddr;
 #endif
 	} else {
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 		goto free;
 	}
 
@@ -1249,12 +1249,21 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* Gateway only passes IGMP/MLD packets */
 		if (!report)
 			goto free;
+		/* A validated report can only be forwarded after the relay's
+		 * family-specific Membership Query supplies the state echoed
+		 * by the Membership Update. Log this readiness failure before
+		 * the shared drop path accounts it.
+		 */
 		if ((!v6 && !READ_ONCE(amt->ready4)) ||
-		    (v6 && !READ_ONCE(amt->ready6)))
+		    (v6 && !READ_ONCE(amt->ready6))) {
+			netdev_dbg(dev, "drop %s report: waiting for Membership Query\n",
+				   v6 ? "MLD" : "IGMP");
 			goto free;
+		}
 		if (amt_send_membership_update(amt, skb,  v6))
 			goto free;
-		goto unlock;
+		/* Sent: the tunnel consumed the skb.  Not a drop. */
+		return NETDEV_TX_OK;
 	} else if (amt->mode == AMT_MODE_RELAY) {
 		if (!data)
 			goto free;
@@ -1283,8 +1292,7 @@ found:
 	return NETDEV_TX_OK;
 free:
 	dev_kfree_skb(skb);
-unlock:
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
