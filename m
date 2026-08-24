Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336537FF76
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593870; cv=none; b=ShXfZwntqL5JIAJ5VUo0nYH8JPaPOR78q9rdvr+qi3L9dRkFagPK2kBT+K9NEJq88VUucVTh9Raw4/C2wE2yBa98EWjHdye1Nt2iinj+ACv3IhtW7PMDGPeDNorCI8u9g0LvVAtxY27t89uvRkzzA/hEQhc2oeOuG/u8nDooK8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593870; c=relaxed/simple;
	bh=VylVE97urOnGo1fKhA1IwM8dNjVc6rVPycHxhapEvGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pC+khD0a8sBvxepIRkbtsLfE0ZDJtOmXYrMs8Tje8kHqCn1dk5nlBNeoCEEXki9AakJojdgN8R0c55ECW/4jGK4Bdq7NA87G41BuTP+7KY+kaVDye+mv5sT4HwTQ/U4gTyRKyhhn4mS1Yeprjf1w/k8DqECqgcuKKnyvneBkwmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZNEHqdq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZNEHqdq"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-39266382df6so3121285a91.3
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787593867; x=1788198667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5mP6wFrKPhYjd/5KHULwyWUdonzv0xy3jN9195/5g2U=;
        b=VZNEHqdqh73dRJ90JBI/k7ctacPrY2CRjheyuT18bHhSF8WwaPi/E9UAMg63NnjK+h
         R10VcO/NvmDIaFafquDJQJcC21crhJG12B2+r6F3iKESkA1Tvo1v4ykiswng+vkvMUJF
         hXJpZr075UN0KQGDyEkgu9qhtl4UlBfxno5PO08Rk5TZUuGPqyhh2MB2700umXN+/iDZ
         qEJ48N+qzCOW7/Lc+DPpOmK8zutSee9Q+m5Rl1K8hdSr3Re2BbQqdfiNS/rx7RmEb4S9
         zczrXZKg4sjyolnfL7nGkVt1d5aFlFVVMkO/xPFKnkdPZ/da7bAhhQlNctP40DKsGiko
         VM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787593867; x=1788198667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5mP6wFrKPhYjd/5KHULwyWUdonzv0xy3jN9195/5g2U=;
        b=ah3NjIPuCFfmJ1pNFsWvjSE3Zd+1ml9GpFCrYGti/0N8Arp+krICWr2R/72ftcsIS6
         eJ1wIhCQpvoqZkrKNOaYVYePU/NDfX/FQJiUw1LnVz4/J5k+gzCx/+9pNHzATzmCJf7X
         /Vtu6dKdKBOiKnG+7i0eiCRxjwyquH3JLKI9/yxRNjY37dRg7Gco4CtMWc7thgN0cIYY
         QWB8mS/+UVRb9eTIfp6e5x+eglMVHuLnsCftkIGVWCeGzdyMixM+n2Yt/kUdbAv6T3l6
         ArOOdbKmlcAcukbYb9kWk86OaQPXA4GyaQZZ/hJ3rUrmf8xR8qwizl4PpsiN4D6vb5xe
         rOvw==
X-Forwarded-Encrypted: i=1; AHgh+RrRnXPR0dyf5jrYvVnsh4IgST+KVxh2+PbEwDj4HA3TMB7PX/TNC070EB4sPoKGDTGlOPFbZvk=@vger.kernel.org
X-Gm-Message-State: AFuF++kCFfOQ7+nRcoRDFURHAcQeuoDJCAouEM497rLRQN7RDfU2BdtO
	BOSa1ojboQdTlpAJGSdE7bdvaq0hjyPZ8UnwCxeAY867xhjxb7sgUP+m
X-Gm-Gg: AR+sD11vhbTG7RWXTGtldZKbRu+bNeZmZ5Df6WAO4glb2K2uiXsHtDGUrDRk8/MEaT4
	D8I6727SoDOx8tDWw1raWsen+Pv2xQonZHLE7Or4ETEA/61SI4yy7I3A81Zae9wH1BsB9MuLT2/
	e0ap7Z+U4W5hEo/stAyByF2IZeSlBVOIPGFzqFtPb9mloQXjyB13hiqJufTtG6i0b6ykJgBW9nC
	0ONlpmj1Zd7urJM+Nk+Jd33L1eg+MxgmQf+ev4t6nxHHnpQ+F4xL36o1Ly+mDQqTsIAbe4piJGZ
	6FqD0TTqQB4yyeXt++LKg0HW/MlhUL67LhPZ0Yg+Zz9BGvpWDu9mpQvRiuFPWhqbM/r0VVJuhGx
	J2VveC11epwF9zoC2tr46xRz6uGIWkMjHHBwDCiHiJYMuxC+ndXRRa00TmCv58aI0UqvlBgx4cC
	RZfWu+m9Rw1reAS78XIwt1SehjRiQKta7rNzwXkCMvS1vA82pfRL/h12kOwjHoC76KfU4=
X-Received: by 2002:a17:90b:4986:b0:38e:e9b:ffa4 with SMTP id 98e67ed59e1d1-395c33cf295mr51309257a91.6.1787593867050;
        Mon, 24 Aug 2026 10:51:07 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:ddd2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141861732f8sm26815132c88.10.2026.08.24.10.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 10:51:06 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	Zinc Lim <limzhineng2@gmail.com>
Subject: [PATCH net-next v2 2/6] eth: fbnic: expose all hwmon attributes unconditionally as read-only
Date: Mon, 24 Aug 2026 10:50:55 -0700
Message-ID: <20260824175059.2485048-3-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824175059.2485048-1-limzhineng2@gmail.com>
References: <20260824175059.2485048-1-limzhineng2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All fbnic hwmon attributes are read-only and always present, so
fbnic_hwmon_is_visible() can simply return 0444 for everything
instead of matching on the sensor type and attribute. This also
prepares for the threshold and alarm attributes added in the
following patches: they are exposed unconditionally and reads
return attribute values.

Signed-off-by: Zinc Lim <limzhineng2@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
index 6c8c66ab86c1..38bb26cb8e6c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
@@ -20,12 +20,7 @@ static umode_t fbnic_hwmon_is_visible(const void *drvdata,
 				      enum hwmon_sensor_types type,
 				      u32 attr, int channel)
 {
-	if (type == hwmon_temp && attr == hwmon_temp_input)
-		return 0444;
-	if (type == hwmon_in && attr == hwmon_in_input)
-		return 0444;
-
-	return 0;
+	return 0444;
 }
 
 static int fbnic_hwmon_sensor_read(struct fbnic_dev *fbd, int id, long *val)
-- 
2.53.0-Meta

