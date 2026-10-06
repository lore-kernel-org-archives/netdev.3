Received: from mail-wr2-f22.google.com (mail-wr2-f22.google.com [74.125.225.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40C4A3D3E
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 18:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310954; cv=none; b=B0YDsqUxzzYUEJWLREgVMfojSikZc3yqI8YIs0tTO1q3M5o5Vbh62HphIvkX5WVrdN1pJtWhInSNNQPDubL7wXGWplqZ+Yzv7qD6u5hGw5+BJA2VM4mKMA9HKGb205CrLVu8cxvJCV6HBjuBjOt0pgt4LOmEmDa8iv4AyTrRqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310954; c=relaxed/simple;
	bh=hGPSpK7vOKkuBZAIYhJaDSFiXzz8tS0oLa+g+i3axgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFGHF8GKUUZP6jnra8E4G9KJajQrpE89WPfEvFTyYMO7r1EO5Ms9u2KlzXn3P0ku0/fpQW4WbBT21f4uWfWvRSB0ntnFyLR9uqLJkVs2uJJcOTPqWcS0BJicuERInW4tqBvTo12vr7Dp9NdKwBhrmJUwaqgiDFSahlQai8cZ34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MN93rvxq; arc=none smtp.client-ip=74.125.225.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MN93rvxq"
Received: by mail-wr2-f22.google.com with SMTP id ffacd0b85a97d-48af51f6182so381606f8f.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 11:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791310951; x=1791915751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LYOmk7tdofg9jpf4CztLkT/sa/eQdR3c/+qRIcJfM1s=;
        b=MN93rvxqstN7MA0rAkbc5wfzFoSwvF+VNhwvf8cXmT3oHlHNmVOjKsMina6Lg6qJ1B
         MTaSbjr+7R5fMUDc9afYIVsGuz0UO+hJfka7GdqLFoj3+BuLwWwZ0fO9UgmjQFtKDea2
         bO2bSOwgbywc1uIzOa3oAfM0v21akaDrUsxcRxCSUBsnyEgVr1wjfIsu1CVa2MgEKk4J
         oB22F4WQdv6tF1skgVTTettcof82HKqU0upOOEG7MpOpaQ6aHTIVE++Y/9rP8q+sqLyx
         YpUJfQ+XMYW2cka+V/xvkunGXpAwDHVAJM7QqVAsFYdkOwkXLkFPfyS/ODcFc+Gk97L2
         DMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791310951; x=1791915751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LYOmk7tdofg9jpf4CztLkT/sa/eQdR3c/+qRIcJfM1s=;
        b=I5VemXT0ntPJjm+T0A1quiQ7YdSri99rcCSaM81l2gCSP03KE3L3bbgwlDKGvqipO+
         Ovw87e21VfjtmRAhKfmNBJiX8JFIjKSVe0lDncFRs3Boqf6DJb0TYOrRUqGzraaDzr5G
         yTMPY/Q7qSSxn0VJkl7ff0dTxlfzI7IYd+/7A4Zd9VeNZ/tQKWvydLJw/Btg2UUophCF
         /QLuQhe69uznpYzTRARwSpXrTjL/CkOl0Y4cOvt5a2LRwpMvMpy7z1GXvBlZZU1FRFp7
         rCpd/orQ6t0hLhpHQq683yjGW3EjCLSUEiTbov0cDxo2uf6EuQJS22K7XNr6Nb7VKyp6
         tCEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVU4UKOA99r21CGyBSfB18BINRf8/J6PguvFfWDFKZL7pV9D4TzyJnymxBoRNRLpU/vF19Z44=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0DtVZuOO7fAS6fpGvXSnvv7IMfyuW6pgttO+CyPs1Ifxp6Pmi
	KxVsmwUjb6w9FeB4da7+MXoaZaac1bGN/QNKNZws4DfwLZEnQpgzUFfV
X-Gm-Gg: AYBFou3mwYKwrwuUFcLd9lN4T0iHoG1AWSlS+88gWJ5YU5EO6umpPqagGKs9odLw6gp
	7kkIlTgASke9PACvSaVpmHnfm5i5dTFbsUvn7F0SP1WU132uIhE53/+tezIIHwHKsMJFD/ZJH8Q
	fpPNV4AZmMoMq0G6dUxrJl2AmZyEBMeAJ4ZBleZyqXcgXakMOoGroPeMCO+jS5ZcnqVPzHG16my
	DDx6LRTQkOiKHUEwVx05lmQAD4+VVR5zSGLrujo6mzFWJr59Ct8+2B3CJSC3+RW/payToZ7w7O5
	gkTFu/OA/alpEF5YIZTEWZU0LQwj93/qsGjlvdiVS5jzzj6hJKfAHjuiL9XwvvJOGVJ9nkuUwLF
	tzlOjLkAUGoigPA3zGqc6OBSzQ2AIEsxJ1FHMfHMJtz/rWLgKDXuCmOSETBbECUB9IILikXIpRJ
	XBAIPNIju3/nkGQ9GukoED0VLLusmqCFYOMD1bLphUWWNsrarJM0wBzjNSdJ3vBfI=
X-Received: by 2002:a05:6000:2210:b0:48c:7009:fbf3 with SMTP id ffacd0b85a97d-48c72705fa5mr560384f8f.2.1791310951420;
        Tue, 06 Oct 2026 11:22:31 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:4701])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1fec3sm1055688f8f.37.2026.10.06.11.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:22:31 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 06 Oct 2026 19:21:26 +0100
Subject: [PATCH net v2 2/2] netconsole: read np.dev under the RTNL in
 local_mac_show()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-netcons-fixes-v2-2-ca652d55fd4a@gmail.com>
References: <20261006-netcons-fixes-v2-0-ca652d55fd4a@gmail.com>
In-Reply-To: <20261006-netcons-fixes-v2-0-ca652d55fd4a@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Gustavo Luiz Duarte <gustavold@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

local_mac_show() loads nt->np.dev and dereferences it with no lock. It
can race with the interface going away and netconsole_netdev_event()
eventually calling netdev_put() and freeing the device before we
dereference it, leading to a UAF.

The window is only a few instructions wide, so I could only reproduce it
with an artificially widened window between the load and the
dereference:

  BUG: KASAN: slab-use-after-free in local_mac_show+0x4e/0x80
  Read of size 8 at addr ffff88800e990458 by task uaf/130
   local_mac_show+0x4e/0x80
   configfs_read_iter+0x187/0x260
   vfs_read+0x453/0x5a0

  Allocated by task 116:
   alloc_netdev_mqs+0x78/0x830
   rtnl_create_link+0x53b/0x5c0

  Freed by task 121:
   kfree+0x159/0x420
   device_release+0x77/0x120
   kobject_put+0xb5/0x160
   netdev_run_todo+0x420/0x850
   rtnl_dellink+0x259/0x5b0

Fixes: 0953864160bd ("[NETPOLL]: no need to store local_mac")
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1fb846ad07d1..830262864da2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -888,10 +888,17 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
 
 static ssize_t local_mac_show(struct config_item *item, char *buf)
 {
-	struct net_device *dev = to_target(item)->np.dev;
 	static const u8 bcast[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+	struct netconsole_target *nt = to_target(item);
+	int ret;
 
-	return sysfs_emit(buf, "%pM\n", dev ? dev->dev_addr : bcast);
+	/* Hold RTNL here so netconsole_netdev_event() doesn't tear down np.dev
+	 * from under us.
+	 */
+	rtnl_lock();
+	ret = sysfs_emit(buf, "%pM\n", nt->np.dev ? nt->np.dev->dev_addr : bcast);
+	rtnl_unlock();
+	return ret;
 }
 
 static ssize_t remote_mac_show(struct config_item *item, char *buf)

-- 
2.55.0

