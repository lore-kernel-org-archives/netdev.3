Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C452D060D
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770059506; cv=none; b=Z/XecIr8vmOs7sgq/2JXFmKLCircxKzPOC22LjyXJTy1c524s8vvmdNtI/R+gC1v8MZQ15mHxrzX0e7aGnBjK+00Hvpmzuofz7OeYaouEIDF1y3JAdZ5p3uLaChedGw97h/OaC6h2O25AcGq5UV1XpTHfI6ntTfbC2Ct0xJZy2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770059506; c=relaxed/simple;
	bh=TdRytP4xqFZikpMugpvvmNzKZEhaCw9xpEC8EWobXPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tEuOAVqAOf899e44OwqYGWIk8hsqiruewoBAsTAhyVvzerNztRY8HG9+KhfS9WjWL8JNv5gc1UbfnxGGArNRikk7H1zW8Ld3TgRe+iOd9zkY+H8524CW4ak3EZg+AWPfNC8G9C3dmI4SuNUwNY9xS8EPe+t7bZ6kQ3g5feZihjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGSLVe08; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGSLVe08"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82318b640beso2674147b3a.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 11:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770059504; x=1770664304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvGWEdBww258F432lhr9VeJTkkvbaT6ZjGBPuUmklLU=;
        b=NGSLVe08zZvpP/k6XTDQYeZcwDil3wH9Ky1mnr71iqmW7k9eTH0LDFJ3oZ8bcRdLmE
         VZ5IW/tW3iU8ggS+sM4LjpLmLeRUvlbfZ4OCrw+QgzZTA6fZUgDyhKCpEPqnToVIZyjK
         2nq9a7K2vzi0h0d/k1/w4TAwiJX7yb0wBOqnisMqeHkKsMzSRNUmN51Ewwxq54r9PhZ8
         TXXF8FBRQS+PEqbGbaGwbmjbe+uyTNeePjpzjsXI6Us1zNoA4FVq6bxqZqkeYyJe6216
         05ItVZj6olnTikoYqRnWkDYNMDN7wOJYf3q0GlKmwH00JzcZS/EQX8U5anuLeAtHi4lV
         Ze6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770059504; x=1770664304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvGWEdBww258F432lhr9VeJTkkvbaT6ZjGBPuUmklLU=;
        b=RcQQ+uUpGXVKEn+WAXumqx+poZtOXzFjFoneaQiXP4pzcqJXfCa9xreKxpXLBsiPbb
         v5BAeI/0DQnDgJBXEKZ1lOV/qKhLbG47f2Rvgk7lXW6Tzn5Mc0R3pTwHFR5A6Y5pkaKN
         KZpyEtEcBVr8yxUxGTzYG16iAO6P65lKbtvEjWVm4KG6Dl20IorLqVMc3Vwox0OTXH7M
         r+LlYdfdiNBadU8IWdHOGk+wcmEWpQWzizgcbF6ePpKTu+i7hVLYNJ3U2r+ftMlgXDZq
         NAcM7FW6415695u9FlfQ6ImOalC3IGQz5cmoxZh4PoIQNlqwcw8ShTjC8IRIWLPCtU/w
         K7xQ==
X-Gm-Message-State: AOJu0YyapOjvtMzRjDnrK8kk6Xbu8+VasEo2qDJNIJ5TMuGIB1CVeUY3
	OKwvx6g7GvO/fc2MyfdRisCuxuaFTW3Payc74lIeXBKXE0Qj8MPdttLpA9Lk
X-Gm-Gg: AZuq6aL79jask33HcKu2K7/dPAHRAeI44RiOD5SysX4A2S1BosIUTIoHTFHP9WxaCp+
	mraki3zkZ1pRgGakD/q1WnUeVL2F1w8lMHI/vzjRFkZCadQRnzG/IMzApGUO7b3A1ticCpqTYXk
	0kr4cUJEP00gCCY0sYk7AImeXTK7NUnqAHv37WnYN9fOY7MSXFsnyukuyEHZX0VPL7QoqdjtwCv
	APWCCjq0WvlWUrIvgtmc/DI+fn2O6A4YNKRnW1PGImsDu68DkbXVrqA7QH+o3buuV69LvMd7y0V
	LZATzTUUnf6ADRASdoLsvgwVbMORGr1ygFGBo3OEy4k2xqGpFntmghjh9hbCdwoprR1E9JmVxq5
	afVGiYvCjls9tXZwBPRXkSr9SOVrePIcSD1JToYFshADjnp4Enh0LqFlJyKotxh8AaQTuFpTcpA
	CxcBNQSmk8OpZ0JHinBWuiBd0I8cmkrmlAb6J3J1F1
X-Received: by 2002:a05:6a20:a11a:b0:38d:e6f8:fd97 with SMTP id adf61e73a8af0-392e0190bf7mr12297377637.76.1770059503600;
        Mon, 02 Feb 2026 11:11:43 -0800 (PST)
Received: from MURARI-LAPTOP.localdomain ([106.215.148.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c64276efd8asm15454863a12.7.2026.02.02.11.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:11:43 -0800 (PST)
From: Murari Prasad Samal <murariprasadsamal57@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Murari Prasad Samal <murariprasadsamal57@gmail.com>
Subject: [PATCH] net: ifb: record drop reason when redirect device is missing
Date: Mon,  2 Feb 2026 19:11:35 +0000
Message-ID: <20260202191135.7668-1-murariprasadsamal57@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When redirecting packets in ifb_ri_tasklet(), the skb is dropped
if the original ingress device can no longer be found.

Replace dev_kfree_skb() with kfree_skb_reason() so the drop is
properly attributed as SKB_DROP_REASON_NO_DEV.

No functional change intended.

Signed-off-by: Murari Prasad Samal <murariprasadsamal57@gmail.com>
---
 drivers/net/ifb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index d3dc0914450a..689340ccf9c7 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -115,7 +115,7 @@ static void ifb_ri_tasklet(struct tasklet_struct *t)
 		skb->dev = dev_get_by_index_rcu(dev_net(txp->dev), skb->skb_iif);
 		if (!skb->dev) {
 			rcu_read_unlock();
-			dev_kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_NO_DEV);
 			txp->dev->stats.tx_dropped++;
 			if (skb_queue_len(&txp->tq) != 0)
 				goto resched;
-- 
2.43.0

