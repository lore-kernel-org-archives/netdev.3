Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A430C168;
	Tue, 25 Aug 2026 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647940; cv=none; b=EQIOYte0vjC5cSdQMHUGvfZsEBo+gUMjHQ1JIXAUiASBWU8YIZIX/clkMXrS+V8+zipxscIlsv+glPsWxxfzAMiJcH30Fj7pZ9ZDMt67jbYIgSDSI5sSA9YpaSp1+V9XUF2xVA8w0TndjjsX1tFm/5yhBV3cnMg7QJOdlMIov2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647940; c=relaxed/simple;
	bh=BUFZ7yGiwJ0cBn6OQPgCuyV0hU1Wzfhyt2tGD8HOMwY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pgAX2RgQsehZCKEjman+Bb+X4LpKixw8N7MXHUmWHUSTh5HhiYSzxCwJQ6Eqm7DaGQdp8IAcmvLFT1WJSCCUZ+jpFY45ucAAvv4gwIWg6AV/NW2gIwisxB7UiLxz4EVCwRsPvE4DYLRa9HEitN3fyYt1Sl2jtJ4Jvnv2aLw3IcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ncE0duPl; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ncE0duPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787647933; bh=BUFZ7yGiwJ0cBn6OQPgCuyV0hU1Wzfhyt2tGD8HOMwY=;
	h=Date:To:Cc:From:Subject;
	b=ncE0duPlt5c0bAQKzrxcgr8EyO4MiNY+u1LhjMGEZh5/Zx/ts6dRnFqY1lpftMJ0z
	 oW8nogYXZVUqhbrxcjfiVsZgYHaMoZjmK5F9xFtwf0n6XLdeXjQO2PWabNsWzWKnIo
	 ucCbkLnT0vh4iB1SzBmQA/668wfWa2l7t5tbkOTI=
Received: from [192.168.255.10] ([111.206.96.148])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id CB836E11; Tue, 25 Aug 2026 16:50:56 +0800
X-QQ-mid: xmsmtpt1787647856tegi32475
Message-ID: <tencent_6653AA61B6BB17B8D845A89977D199C08C06@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5HHYVy7S7dRjicBmhV2/sPORkXt7fGVN7J2vGNeGM1d5uRvXptf
	 bGAMnPnD6qx/gLOeZyJ1A7rnH5mpAX3r4ZoqKQxyKheT6W/W5CLOwee7davmn9S+M92geaV8gfxa
	 Ic2UShZIOfhuaLL+fz8XrMSXJE/Ao6klL3+Xct8DnKQ6bmXyZ4HYqXhPBMS2pUdz3SbFaHrYOV8M
	 SdrMNfsbw1paFsdtBaAnjSteQuPLSdEURRjm9zrEkBI++YcuXj99T4dQr9GRmeVaCwo1p1Xf+OTd
	 50ARyqkqZEF2rLf8pr5YPHRzuMTwewVhfAlXNbmFJidpy2pWkTtxZ9TxYZUSTg+myIX/yz8RlorP
	 LrmM8E4RrA19wCI5WFY/8crtt4Ms+/XR69/NGGoyPOFPdHO6Z/i7nlXoUL/O+7m9TnlJLVcOBpPM
	 4+uDC2k7Uax9QqdomG6k5aVTS2ehSVS1UCVJBQlGVCDIthubxl2PO5jz1ucB4L4CY6AwuUkI1jn1
	 kNbhO5fqNd5zMm7D321TspalqgaAbu5R79JxxjjmqHTv9kwHexLLelaEyEKEQMsoGBbHZI+kVZq7
	 URsKrMjWZsxvkTqBY5jK1HMvUzvhXYLe8FCr2E+OCDhzYzCJUStJqCx60Yf8vkdOy9zLrhrKoyP/
	 0tILihJ1l/9J7Zmga4drwKRWECDdqOFUAHzmMf0rrIt88JY5tPqpV0uKKWwU3cOwBHUHtiq/d5Uh
	 4PfWynEVEfYcPcfiWslxHmrGLY5b6yJnX8hvVMoGXf3hOw7bgi6RyIZpsTKNrHMAvjysACBme+SQ
	 Gv4rIYX1qj2nDSVclD6F6CqsFhRfg55YmRAGcse9YKWyaqsdkXlE2/P7y8yDWbypRHPSzDTOqPuj
	 IiGb9mRLkupsKoNvtPNp1XZSpnKkblVG02ZpqJqTdg27/owDO33qA2ni2eAFCS01bTms/GY3IJLp
	 9H8Mcvfu9YmVOOMYk1Z9Dk4b/hpYhsI1ukhA3H1LqZXMe52KES7E0oZyMq9MqMUjBFMgJbVNBM4M
	 4EHVQ++ofDZMpBqEVjdFDwstfWGQxp4JzrOl1PfooI+A3iUkk+
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-OQ-MSGID: <f5f1d8dd-0305-47e2-a659-5f67aeac8ffa@qq.com>
Date: Tue, 25 Aug 2026 16:50:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Cc: andrew+netdev@lunn.ch, kees@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [PATCH] net: liquidio: avoid sleeping allocation under
 octeon_devices_lock
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

octeon_allocate_device() holds the spinlock octeon_devices_lock while
calling octeon_allocate_device_mem(), which uses vzalloc(). vzalloc()
can sleep, so this is a "scheduling while atomic" bug that can trigger a
sleeping-in-atomic warning (or deadlock on a preemptible kernel).

The memory allocation does not touch octeon_device[], octeon_device_count
or the free-slot search, so it does not need the lock. Move the
octeon_allocate_device_mem() call ahead of the lock: allocate the device
memory first, then take the lock only to find a free slot and register
the new device in the octeon_device[] array. If no slot is available
(all MAX_OCTEON_DEVICES slots in use), free the freshly allocated memory
and return NULL as before.

The lock therefore continues to protect exactly the data it documents:
the octeon_device[] array and octeon_device_count.

Signed-off-by: Yang Zi <2959243019@qq.com>
---
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_device.c b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
index e98118e7b9fd..405ce14d46f5 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_device.c
@@ -723,6 +723,10 @@ struct octeon_device *octeon_allocate_device(u32 pci_id,
     u32 oct_idx = 0;
     struct octeon_device *oct = NULL;
 
+    oct = octeon_allocate_device_mem(pci_id, priv_size);
+    if (!oct)
+        return NULL;
+
     spin_lock(&octeon_devices_lock);
 
     for (oct_idx = 0; oct_idx < MAX_OCTEON_DEVICES; oct_idx++)
@@ -730,16 +734,16 @@ struct octeon_device *octeon_allocate_device(u32 pci_id,
             break;
 
     if (oct_idx < MAX_OCTEON_DEVICES) {
-        oct = octeon_allocate_device_mem(pci_id, priv_size);
-        if (oct) {
-            octeon_device_count++;
-            octeon_device[oct_idx] = oct;
-        }
+        octeon_device_count++;
+        octeon_device[oct_idx] = oct;
     }
 
     spin_unlock(&octeon_devices_lock);
-    if (!oct)
+
+    if (oct_idx == MAX_OCTEON_DEVICES) {
+        vfree(oct);
         return NULL;
+    }
 
     spin_lock_init(&oct->pci_win_lock);
     spin_lock_init(&oct->mem_access_lock);


