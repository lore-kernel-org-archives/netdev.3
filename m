Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7154E3259
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400166; cv=none; b=OMACns7qcxw4WGCEosXXsuL73j1/h6AmQS6p5BPG33dOHli2DkEoobV2fUrTZzocKm1Mr7RbGSVU9ycm7Wgm9XPHbLKdFMj+MUGFjveUsPyu2fYPMGbUY41Gj2k9wZEhW4R2ycEmWtIh5w126ChXyz1eisPKT+nqHE9KKBjOK94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400166; c=relaxed/simple;
	bh=vVSqOGp2wx/0qJVjAsSbH5oTy4Gpsm8b9+BCotcy5AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4LoBtlcT2QVmnflpt1NzJVeUsNdRtcVbc4uBB+viBNKe1emXDlBF5MHGoa6QdGZHrSGB/5zG2sBngKfG2N7uHuMlNpN5YIEjJYCZsE4ez31BPvVUwE/+IVCew/DJZtOmqLu3ASmxyVY123JjT6uNqNKmAc+GCWlpLQV8wBsgd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyKU9oV/; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyKU9oV/"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so1132518241.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400165; x=1792004965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XGvHahoLRouhu1JIBcDAOTwzFgHXehCkZsR1IWSJgU=;
        b=UyKU9oV/Skj6omKIj79jVBpXFg+ATjDAhM9sqCUH9n7N5aK52iQU92wyj/ba8d5V4A
         S0zg7dUjAV6GAyUZWdQJaly3O91FpSYaNiL+BIO05/eGEEU1aA0iY18E5QjhonwDRVqC
         2RNfUEvuSB58m5AxmJlT2oIdzZXLYabSU8gb4OAgmFCwJ3cOcQjEnW9xeW5yhGJ6qk0+
         NOkBOn7Yx6d87Vuen2T8VFNR1vRfvw0/OvpuXf8DIiOUgG0cn6v+5sW1logY/xmMAN7V
         10Mza0jE1vixG8/LbiHHKSr3bqIH9aS6Ct27KVNk9TvCcFVJe3Houcp6+C9RQI+BqFKP
         JEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400165; x=1792004965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3XGvHahoLRouhu1JIBcDAOTwzFgHXehCkZsR1IWSJgU=;
        b=rC9J7Mi0zktVV8tRIyXwAxkGx3JtB/zJFi5GYRUDWRT0HRspv+qyvtd/h+G93ECDRK
         L38hPAIpNSQD+Ov4R48Uk9jo7pV30Gu7SXH7Bfix44U/fSgE5KVj+68X2e64r8n5boID
         xf9LUdlPAmoaw5ZdjHpHJyXpTPddAz5Z3DtOzlz9thmheuCTzUdltzG7uBncTUGkjNmC
         wyXRRoXwOA3JUSb1l83QiU4gNkJ3IDPZP8f0S2yq7n8dbW5G3lEHcudjG1qyeWbStmhy
         YNLLqZ4PTk/DQYLRSGDP6Ux0tY3PxJjlmx8FpETqgKI7P5OdB9vky3lnUCqNCFw1Zv8M
         jlAg==
X-Forwarded-Encrypted: i=1; AKwUvBzyxRaSfN0kZDq+qqLWBReorErMQCZY64O1frFlwzBhtNyqZxsxbACX8H0Bvu1PVumxRtEG9eY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQQ+s4OMqzxxL7wOrxQErn0arls0dPZgbrYjY0u2ykWgzFN43a
	MxkQhDprvOKCGva753VLwhTttPp2vipWgMpLQTAMj03kRnZCcRKWiV2k
X-Gm-Gg: AYBFou1bdT+/CK4JW+dp1mGsw6bBZorJihvrcu4UvOPlBfoa0bCCydb4PeO3LXOoV31
	FOhz/F6JwEqA/eqLeK1AFGmdz2+Lq/6/knrANYW0kBJ5vOVuQ3scDD4+hzUF4V2zz7HB8e+q7kD
	7+ZL3lwRWBRseVQrBhJ1IjkNg88U7jrfgb9pBOgGCb71ngiqNqd89oroxh2Z5SIqNLjHonJszaV
	mennbYzha/J0rrc6Pto/YfFrhppmFa3dAD75kZ6S4UtaXphUpYGiy/XkArCgVLX1bUGydAOcJ3r
	yMqbK/8Dq8euc5tSGoA3f2P+nkbhCzu5rgSEXWv5ejpwcOolzWwndn8uBsiit19Bc0uMIsZms15
	iwxp0pTz3TaX6MRHkqZSwFe9d6T8694Z5lgzIjazn3BY/lvynvZ0I4D+NW2tSlygIEXemrAkoj7
	8xioGafBc844MG8yI+dO/Ag8Cb1Xcnd6j0irVBmFtffd2kfW4Pcp1pSUF7fuq7VDk/oW6uylGzE
	oK02asKqN6EDKl4Fd0=
X-Received: by 2002:a05:6102:688f:b0:7bc:1de3:39b0 with SMTP id ada2fe7eead31-7ca38f28c27mr1016377137.32.1791400164748;
        Wed, 07 Oct 2026 12:09:24 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([74.244.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm2456787137.12.2026.10.07.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:09:24 -0700 (PDT)
From: Emerson Busson <emersonbusson@gmail.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 14/14] hv: netvsc: use kvzalloc for device state
Date: Wed,  7 Oct 2026 16:07:52 -0300
Message-ID: <20261007190752.336426-15-emersonbusson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007190752.336426-1-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_net_device() allocates the fixed-channel netvsc_device with
kzalloc_obj(). The runtime fragmentation drill reaches this allocation
from netvsc_device_add(): windows-2025 reports an order-7 allocation
failure with about 99 MiB free, while windows-latest stalls at channel
open until the guest timeout.

This object is guest-private control-plane metadata, not DMA backing.
Use kvzalloc_obj() so the allocation can fall back to vmalloc when a
high-order kmalloc cannot be satisfied. Zero initialization is preserved.
The RCU workqueue cleanup uses kvfree() to release either backing.

Rollback trigger: revert if channel setup fails with vmalloc capacity
available or teardown leaves netvsc_device allocations outstanding.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/net/hyperv/netvsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 0d017f836b9e..8ea7c993baac 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -144,7 +144,7 @@ static void __free_netvsc_device(struct netvsc_device *nvdev)
 		vfree(nvdev->chan_table[i].mrc.slots);
 	}
 
-	kfree(nvdev);
+	kvfree(nvdev);
 }
 
 static void free_netvsc_device(struct work_struct *w)
@@ -171,7 +171,7 @@ static struct netvsc_device *alloc_net_device(void)
 {
 	struct netvsc_device *net_device;
 
-	net_device = kzalloc_obj(struct netvsc_device);
+	net_device = kvzalloc_obj(struct netvsc_device);
 	if (!net_device)
 		return NULL;
 
-- 
2.43.0

