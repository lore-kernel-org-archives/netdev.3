Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A955519AD
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908265; cv=none; b=ERGMTNsBwDyS9L7rmDABXq1iTfOvzsjRjiwXwPt/38sUS+2v6I+6/ZFYBeLg7LSB3szd4WLNerqxMDmlqmpwjTUcw0BdAJ55PzDha7eGDJXtdPvFlfqPoBu4n145N9WCdPRvsQf5UQZHdbc+eedbCmyWYuhKn5Il+DQNqgqUuLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908265; c=relaxed/simple;
	bh=VylVE97urOnGo1fKhA1IwM8dNjVc6rVPycHxhapEvGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhra2feYbsVQiNc3VlVXisqgwAlvjuHoXkR1GHRf4AuSO0kXueAIB+m0L/0DeNz2yBQKzt3jr02mMk4acW5pf6Kzh47SiEHvEDyeBeZLxC3eQzruMPVLx8hhaJVVD4+80LX0Dgcn6vkIRUYkDyLEEyBmI6xVOwyr4NuKWrKGu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvhXOtxr; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvhXOtxr"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso5450560a91.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 15:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788908263; x=1789513063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5mP6wFrKPhYjd/5KHULwyWUdonzv0xy3jN9195/5g2U=;
        b=cvhXOtxrodHOE0zH9bB1Tol7SWh74fVXuX4HyR44DEEwbphbokhKf+OvQFtVpYlaEG
         v/jFeCV1PtEQZMeHl81rJDDZeHfv978A/b/4MA/4q20tCB0yhtQWxQM3SQkuAgde0Jp3
         24SHgaYyJIFzeS0la6n9sbZxx2k+QEzixCxzaYMz1zAIxrnm1wmX8jlpjFepdmAVHTFP
         oiwAuDpeyQZpWyKvpAj3BkXBDfq5C8QVKLsrLGNyZ5kw4Zbgi+9jLxrJ6x24wMQpN4qL
         zqLO9+WdYVvueJpMMFTntqQ0J0oont17n8fyTzwlo5g7vu2V9XhUL9eCCGe5C/mYJj8i
         dKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788908263; x=1789513063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5mP6wFrKPhYjd/5KHULwyWUdonzv0xy3jN9195/5g2U=;
        b=PEJHwM+kbx1Nl9Vg5ebmCJmKu1lONjfE8NwWkz3I50/F2V714HXfLwZN2odSQSExPT
         XkXccfOUgRMgmytjzEXdXznq4PUiP73pA61MnVXi8otnHP+p2BMJge9P0M/iGWyGSp7k
         8NKWqev1STo3IVU2SdDxVz3wtLSyyCtpKrnP5hTTq+WDaqWrakmasDEP6c0+sL4s/pby
         pag6J4lsTnoT4TrfCqpRJEYQNKSo/d/gsSQ9jRKhdyKaC2Nq0gViVOa5JqllT+oIAkdt
         jCrn2m+pYpdcgAYX/oUR7E3qQ3La9uSeMwJizD/Ocl+ATZQpaeSi14IV+t62HIL3U5mA
         OfhA==
X-Forwarded-Encrypted: i=1; AKwUvByBx4/kmZ5wyoZTIPLGPhXAupf33EE2Hfd5kekGteI2T5ygR8uJaza284oInXf9hIGg43mURE8=@vger.kernel.org
X-Gm-Message-State: AFuF++kQUyV0M2UFNzCle0liiTY8BSEJFRIoAECrmMb7rZQbE8RZwaFW
	DlFhF2eV4i7RiPHoLtbAdd6ejUR8KdQPHY834EkPOtRTkAPceo9VyfrU
X-Gm-Gg: AYBFou0dg8MdlQ0hvl6uO5438bcd3LVYNGc/9ROELmpEuOS3154qBml9bMzO9TB6h/X
	5DeUW+y1H7fWDY0o4wEJ1LKG2j4Q4gaGwNvA4ijgJcRlr6stQbPKkneQsrSIABnVIaV5OaAPP8N
	lCLSBhTTbPctO+lQnkCk00439e7Bvc5LLzBwmVGuhpRah0Vle7hfJzyw92TwJDpNfQnU4mDU1Ss
	1QJbY/9JpTiWgT46eihLR+lYTzlD0anxdLTzlvLYhOJvt9f9z8IFm/PyihuE73rRx1yZ/GbvZp8
	X1cU8zWpnRK3e3z+dl+65hjdnXxpxNF6pnJ5oqvAmZS6DzjSkRE38iOiRJXt79S3/QtT/8bEGSD
	09BAUkjP32ZdFv7kvHs9IGagVB+/9qoYtozAWB/mCaed1yvP9rh5jQENXhoggiXk1+fpfLakdZM
	FDKaDMkuBzzr6pCkcIWFQUxImdI67rsmNcXU3VxDT7y5a+SjW7PEqWB5AzLn4xszTMSkU=
X-Received: by 2002:a17:90b:5790:b0:398:9bd5:4910 with SMTP id 98e67ed59e1d1-39b2624f0ffmr45595682a91.23.1788908263245;
        Tue, 08 Sep 2026 15:57:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::6:91c1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a62be87sm32982165eec.6.2026.09.08.15.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:57:42 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@roeck-us.net,
	horms@kernel.org,
	mohsin.bashr@gmail.com
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	limzhineng2@gmail.com
Subject: [PATCH net-next v3 2/6] eth: fbnic: expose all hwmon attributes unconditionally as read-only
Date: Tue,  8 Sep 2026 15:57:33 -0700
Message-ID: <20260908225737.3034403-3-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908225737.3034403-1-limzhineng2@gmail.com>
References: <20260908225737.3034403-1-limzhineng2@gmail.com>
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

