Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE7839CD18
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211365; cv=none; b=AfOw/ttKTECBwjQ2f2LCV9fZJ/2YduQk73aM5giRBSWNko7rgkgjFutwS1bhF2D8FW3CA32rBwePukLD29Danf4nqtzI/O7yJnWfM141gT3jLhmdRO7Muui/9CaTf9rizpx1vnkGghnwyaXn25Ebt2Ue3jINE16v3+Igyox6LM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211365; c=relaxed/simple;
	bh=VylVE97urOnGo1fKhA1IwM8dNjVc6rVPycHxhapEvGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaW94GU9wAnqJ2CWvihlfuBVfd7rc0XhRUZcuqfhTxs/uT9JRD+6yXWiBK3bk5KH++jig2w6aMpHbgPzohsgqrGDD8xR/L8mcmgG+ObPINzx9qjkHIwy/dx0QyCISGPKaCkgGTSBKWEk9rKSWLqJalOAUH27WluelbE/JNelIr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYcIZQnG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYcIZQnG"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d58efc7356so47946025ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211363; x=1788816163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5mP6wFrKPhYjd/5KHULwyWUdonzv0xy3jN9195/5g2U=;
        b=EYcIZQnGJtMS0MpMPLpanWN2p3GAJtGW8WuCGaFlnXiaZ37hQ1f1fXqmzs/9rZRWgK
         VS6LHbR6bn9cQmeqdN4NJMMpLuyXqoOy50/VnxLCFf6aXUx5ZrSeEPhnnZabfKdjMOnW
         i0lgC2tMmAWG8a1qRJHziRpln6r43p9yQARde09Qn838yznOS/Us+1EErZtdhcd68ZvC
         nmie1m/RPlCTxiXIy9faJ48rvXujXK2wbhIGum6yBwG54jyEQBsrS9ALo1RZJ33aDzZa
         L1PuLY/SDkoW1gqs2QC7cO0SJr6tAF/WCllorAh951QKaBpgdLHMcflkQ9DswjkqZg8F
         PMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211363; x=1788816163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5mP6wFrKPhYjd/5KHULwyWUdonzv0xy3jN9195/5g2U=;
        b=NbwKxRLuOedo7r1Pw23LTx6ASMcQPlsx5ZxGYUGjiAXE6XoNI3J7s8cdCaoOK/ODXk
         m8hWssajJuAhlOzlJGq4bpJd+G2+rQztE4iMWfloILdUpo7yKOAELakRn4Ht8EhuPoE9
         u2mFX9xhkPFmYFspcN4t2pnwOYOhg7xNpTBNHhHow6KV0X673Kok5Df/o5eN84H16TFi
         KMeP8upnwSIU8QvBeAcl3Kwp20juuo0BfsJuzjapLh1YaFqiLm4tq1FUB4aRm+SupUDP
         6WL9M5EcIROwG155Wl8eLyFU5A7JdSIkS0wF0A4tfhrY9leNs54i9gfjg/bkQDpBC+bQ
         7X1w==
X-Forwarded-Encrypted: i=1; AKwUvBzxeTv8eVrHacNV6u3q21kIkVVNhQP6l3q2pudAci3Zfeu4ePfxGOR5cK66WV+mivfWHinY6XM=@vger.kernel.org
X-Gm-Message-State: AFuF++m49KDgXTR7PI5iBSDFAiRLBF4iXZUR51bL969FjwcIoP2Hdg2K
	bUhOdium/oYiBeRWWTC0dBlWMkmU/DEaYoWl0HTulsb4vdMbjQM8X0ZJ
X-Gm-Gg: AYBFou3VtKUjAyMzLAGkh72x2VQ3JsCR9/3j9v5WR3ieICwNGfq5+JKowt3BMzAHd8l
	6Cj2n8UWbxHcPIsY2HH8RK6ZUVPEqoTz5zl9SudnmZ+qXLebA51f92ZPAphbFSSj0QrtP4hGgCF
	EuhrWweJnNclfpU7CugWjqfBKzz44SqawS3EWqkEd2gTtUh//xuCHjx5bBPBy9LXo8d7mpip04j
	4NfL0Vrw19vpr71suOhVvznHojjSD7EjtBwoAvFNrx0JJ+s5+vCry3sUghHsYoTZBWTDh9o8QSf
	gwlYKU7juWQq3DW1BYh5WhozIV6MV69LeKbbLvQpw6R1/9fs4be8+Z3O5L8tCS6OGBNEDjhTifb
	z79mXjT6gztyarltZ7Vg06ia/v7NBk+KwKAp5wIalrVGn9WQ4Td0haavCFIoRFyO6UDKcf8DC+G
	FEdOrzZPjPWj0kW+t4dIYVgdPJl8Z0biuEbMN8vau8/ZQZx9YbE6zEMLv2pleoQrldyTU=
X-Received: by 2002:a17:903:196b:b0:2d5:ccb7:12c3 with SMTP id d9443c01a7336-2d74dc2b30amr430405185ad.2.1788211363412;
        Mon, 31 Aug 2026 14:22:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::6:bac7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9595bbsm37102538eec.14.2026.08.31.14.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:22:42 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/6] eth: fbnic: expose all hwmon attributes unconditionally as read-only
Date: Mon, 31 Aug 2026 14:22:30 -0700
Message-ID: <20260831212234.1212971-3-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831212234.1212971-1-limzhineng2@gmail.com>
References: <20260831212234.1212971-1-limzhineng2@gmail.com>
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

