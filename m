Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3354049362B
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787537902; cv=none; b=GeL11WaoTfDTgVwY+oTpbDfiqpX3T0koCOc+ALEBKibl+rRiTT0HBd/j1UQLG+6XNsEG3jDGNI9mu0gZTo/u3iWzUqoe9yQUYiUVsYXdDIIVeSZRX6l2kDGVR7HdAys0sTiGmCmEJ0BLOH9kesrf6qhF4RbZBn6W4wJUmhLDhGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787537902; c=relaxed/simple;
	bh=Ru+VD86lhBhSk454Oyocv5T8P5aSVW/N0nVsamwbVv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2/L4EjESuZJ++uQrcrAhbGFcoe9WfvpSpNcqqNeYNUiMzDAGSTW+05+8AlTFJLN3uwEflDyydoKzuDQpdcdQez4tZdQKi/v/XanWOFO2r1a94S/VIImgh8KqkmNPDAyC6fIIWu+ssI0oGDXsxvcEjJY7lHvBDFB0q98JCEi2mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVM1P8g4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVM1P8g4"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbe4592c193so250705a12.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 19:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787537900; x=1788142700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xhypSWxOeI1zP+Bw3w2pXH1x9nj4tvFTNGUygwEptQc=;
        b=JVM1P8g4vz9ZLbxy5Is3hFDL/dizkgw2jPmgqd6qWdWKp/2dVIWJaz34SvE8yVX6i4
         AYcpMBdkAMpeD8Xj+hdBk0U7B2iNk+gBTKH34aaL2R+NC9moaiZFFeMIqbhDED82oKbd
         pz09WqI+NLPbeCmxCOxnYKr6TZjd4t958ptx/loos2h4jzZMzR7JDeee6+eGXKuGETLB
         ik79fwQ/k2RenclrxauozqW7ug0sOxq5P2f/EtO2xYO8K7EzsWzqDa7slmqsW8KZ6qHq
         J2hvGEnfzw7caSd5xX2g/8uYJ8PtWrjMxeLYY4lFDiVtxpohsFUHLThOuHasGDLtCHtc
         JfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787537900; x=1788142700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xhypSWxOeI1zP+Bw3w2pXH1x9nj4tvFTNGUygwEptQc=;
        b=rzBaJjqgTSybs9CMeImONip7YLOlS4hvXb265FCH0ezJP8nvSxSbiv+dDdWa7U2Rgm
         3yizteqbhKK/L3kkVIV5TNsobSzBHs0cokiFAJ9sK6vorDdZ4GHaMPcYSQHUolRNRJ0l
         5cwbmVeRLS85StuX2kHX3XQjQpqUud+BWjMXITtGlJPGwRIYSK3AWvvSayDCAacMIMQa
         5XquHErfUXvGjRe3cP95xTHB53i+/sIKCHamjKCzHW0B+Gj3ev5o4cCzWV3kOg4G/G2g
         ivFXubrXzmPD7xA+aC/DrVTMes9EC/EaH0zWwW9L/g8D8yrVhXbSMLMG9gmb3uz+C/sX
         2EAw==
X-Forwarded-Encrypted: i=1; AHgh+RopLNu0AL1WXt1jwEvG0ZmVeSkZQ2X5VUq8f1sC0ll+TKxZlZRSTJwd8fpRfZ1o3Ti9fLRroas=@vger.kernel.org
X-Gm-Message-State: AFuF++m0ai5mffNsmDi/tEVu6ieaPFS2B0iqoxgfblbL6n86qDbQV/AG
	46f9tKnrd21L+jITeNOBJeodWuOola602t/bq32iiA3JjpQOmvbS55dS
X-Gm-Gg: AR+sD131kMCSpL3rP0f5Dn5hstKhda/moLuR+ueKQSZJnuO3J4scPLkOuFeSQjgQGep
	9V2aDYP4PsTdn6mPufbYW3s/5wohjjXY7ZmQAWIDYEDyEc4q3KB0o+2VTbhxCiNdtFj3zPpFgJt
	Xdhys5Vtj2TY2MhYrun7mqdpmR+xjtTtUrHjEznD8F3r2jbGXe6pudvOPtW5vMMaedoT8OdW4ke
	EfTvCHMpMqq9/aFz8PAk/ZOwXXF4ozmG3CtJ71j6HMfTD8w0Zz7fRwrjkEec/wwdZUVrG7iyWVW
	TTYw1GnVE0SNJTH4lOyBaDhNoPCS0N+aTIXSAH8B+j0OGmk0Ny6960L7BDrIRz2Ir5gtch3jYuH
	yEdvcos9Hbu/Mi1YbAnBRTB+JhHxvqtbyZKpSrtc+3szYBZrA2iCpfjQByrgGb3D0/e1qxG6Skb
	Fxte85mTtbtN1h+Oyzb05lHgfhSY7uUtEu+D5hV+y4EEFkq3+NCr4CKcwItkTSHUO9vZI+VxMBd
	Sl6o7kPZyKzQxKsAZ1aJQDvcrh/3BO3wZm9jhEOHCxPWllWOrA=
X-Received: by 2002:a05:6a00:7112:b0:848:3dbd:5cb0 with SMTP id d2e1a72fcca58-851f9f1636emr13066590b3a.2.1787537900470;
        Sun, 23 Aug 2026 19:18:20 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b185sm1406434b3a.39.2026.08.23.19.18.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 19:18:20 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: jv@jvosburgh.net,
	jiri@resnulli.us
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	netdev@vger.kernel.org,
	Qihang Tang <q.h.hack.winter@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] bonding: reject frames with insufficient headroom in bond_header_create
Date: Mon, 24 Aug 2026 10:18:01 +0800
Message-ID: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

AF_PACKET SOCK_DGRAM sends reserve skb headroom from a snapshot of
bond_dev->hard_header_len.  A concurrent bond type change can switch the
active slave to one with a larger hard_header_len between that snapshot
and bond_header_create(), so the slave's create() pushes or writes past
skb->head.

The hard_header_len snapshot series that fixed the SOCK_RAW send paths
deferred this SOCK_DGRAM race: dev->header_ops is the stable
bond_header_ops, so snapshotting header_ops in the caller does not help.

Reject the frame if skb headroom is smaller than the active slave's
hard_header_len, before delegating under the existing rcu_read_lock.

Fixes: 950803f72547 ("bonding: fix type confusion in bond_setup_by_slave()")
Cc: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
---
 drivers/net/bonding/bond_main.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 522eab060f9e..9ec663610dfd 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1524,10 +1524,24 @@ static int bond_header_create(struct sk_buff *skb, struct net_device *bond_dev,
 	slave = rcu_dereference(bond->curr_active_slave);
 	if (slave) {
 		slave_ops = READ_ONCE(slave->dev->header_ops);
-		if (slave_ops && slave_ops->create)
+		if (slave_ops && slave_ops->create) {
+			unsigned int hlen = READ_ONCE(slave->dev->hard_header_len);
+
+			/* Headroom was reserved from a snapshot of
+			 * bond_dev->hard_header_len that may predate this
+			 * slave (concurrent bond type change); reject if
+			 * insufficient for the slave's create(), which
+			 * pushes its own hlen.
+			 */
+			if (skb_headroom(skb) < hlen) {
+				ret = -EINVAL;
+				goto unlock;
+			}
 			ret = slave_ops->create(skb, slave->dev,
 						type, daddr, saddr, len);
+		}
 	}
+unlock:
 	rcu_read_unlock();
 	return ret;
 }
-- 
2.50.1 (Apple Git-155)

