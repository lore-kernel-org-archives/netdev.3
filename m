Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476CA4B0E57
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823343; cv=none; b=jDQwQijb/r4MlyusRJ4ZVRYD3UzZFGgzW9wUcbInbnq0Np5CStRRrsv8NgkEkrv+D/Dt9VOxsI5cTIF2OmlOaAhB/yey3Kf0ZUTdSdYIQHCj+wucEUuwaPuufJncEu01bHtjFPZTFcHuV1hyjlZfvSJbmjrQiGqvGoL8zKJVpH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823343; c=relaxed/simple;
	bh=3oxtSu9bUyqv8eRvbOTaaLELzhbhyErWddsiC7w31RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOizl3PfCPZJI8bzHKutWd5AI+ZH4E5Teq/Zi/oemHhAiahGF/aZyF5el/JjqCKNmfZ8WxHqLNCDGjRfvtwYL1Ot5EPPYwBG7j2PVtGCWW8cAWqBa9Pwu2v6or7B9e7q/FjmcAQUTkhWFv3hjJmoWDFVyxrTEHDi0GHluIMb5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p7v480xu; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7v480xu"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48affdf66f8so314482f8f.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791823340; x=1792428140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UzBAet1nTx5+JCjWlEVDo/FdC70Ip2kEQYD2LrqnUXY=;
        b=p7v480xuUura5wDXwn6aDvUwHjUY7fbpmLIz/swBgQ7QrPKrpccDrA67Zs9MyqCksi
         trbA1sHCkGomBMHHyT5J4YvYreXRcY0UvWpjf9dDr7Rhx9AnR+/hZHXSFPVbxpDcbmVJ
         9N/EdYK1Walzbe9NW7B70m+YmlqOfKc+4sIp/f6SL91PAEntHUQjzCvx6lysumAXVLCG
         b1LB2loosVXl/7HvnXggLNokaQQDatmo7DkSJtTk+VmrotcB40HWehB3ctiujn87j6cH
         8c1tEo0Ch6+9w2LEj41RCy01g6koBonMMsxq95T/IJzso4ASyuk2aZd6/5uRMRGC3rfx
         w3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791823340; x=1792428140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UzBAet1nTx5+JCjWlEVDo/FdC70Ip2kEQYD2LrqnUXY=;
        b=w/N0SbHkZFX314remfkdUiY4AGDIoT9w1y4HGaUh3Dy9gsHGrAkjvH+EFoh0D+DZWO
         sDWC+vKLBMh7SItlFZUYINnWuzWBDPUphAKXR9i/J03RpqEKrmXBLrvEcciaXWRSnV7H
         NWeHUTgFWD930eIIrx/OkMOfy5NL/0DuRbd6cB6SGfY3EB+DNbwQawsYuc8s3oxGN7nt
         2gxmNqn/MEjJdTEgPq8BNDjZI64OQg+PWd6YV3DEz8ETQelQaYr6mTZVDu7KTYH2G/Ns
         oFRBTWLVg7KDexTKFaPQwleetyAJJ6H3y/oIWXGWYwmVwN0Y1vKotyou+jZp6/MzE27Z
         Kz6w==
X-Forwarded-Encrypted: i=1; AKwUvBx1a8UWi9KHUrvBIqGpR2vsBmYeWPQnrhiV9GqCXSEGXIhbaRT8hSwdwnxrHyWs5qT3DJ+Kmps=@vger.kernel.org
X-Gm-Message-State: AFq9FYI775tJn1jNub505hxvCsJTq9gYFsl1JDdoZK1eHR0v3wPHiDJq
	7RKANw5GAa6DJ+FOTC4eu5ivCkzeb4am2ZzJtZUmkPEBF5NxUt4yQbXW
X-Gm-Gg: AYBFou375vkOYcgskUST0CZhDcRhOQB0FlyrzzX/DoHbrUwYhhzZvhjsvVsjM/HVAYl
	i6/c3d8DOyBE8fI1OwzrGNV7ehZBpB0b5klh3oqEYCxv3Jsymvj+iXO4O8eeyaTcGg0HVXWlYpK
	HYDgGo8816tLCDWso6+djkVovTGFGlb2I1aTCinksUe2k2BrsnhMy83vl3rnu7yCh1sL0v2B3u6
	vSFigVEKYqRiTauV+uYms9BbyFR1NGAV8+IepHjORFqtTo/dPO4Q1E+9G57gdkGo6RU4L9Cd5qM
	SjiarXzv5Tq4yXs+53HwimNDmPAiSkFiDYAQQTW+JWq8sVQ8k5J19F/C/FDFW27r+pr0ibHW3zD
	5ClXIPzDG2hpcgnWKz0E9AGmRzIR07Z1jbxBMttBmQNTr2wFQ0sWlyj0fkB4h1adRGAljeKY+Wg
	bvRGDpeOvJbJz9rA6XemTVJCvctzypEO+LSGSOyGpyKZBx0bsk88yH
X-Received: by 2002:a05:600c:5246:b0:4a1:7e9b:e0b5 with SMTP id 5b1f17b1804b1-4a18e3ee9d3mr162847075e9.0.1791823340401;
        Mon, 12 Oct 2026 09:42:20 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:c555])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a198c80cb3sm127695195e9.3.2026.10.12.09.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 09:42:19 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 12 Oct 2026 17:41:58 +0100
Subject: [PATCH net v3 2/2] netconsole: read np.dev under target_list_lock
 in local_mac_show()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-netcons-fixes-v3-2-1aac85ed7665@gmail.com>
References: <20261012-netcons-fixes-v3-0-1aac85ed7665@gmail.com>
In-Reply-To: <20261012-netcons-fixes-v3-0-1aac85ed7665@gmail.com>
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

Two places can free np.dev: (1) netconsole_netdev_event() moves a target
out of STATE_ENABLED under target_list_lock before netdev_put(), and (2)
process_resume_target() releases np.dev under dynamic_netconsole_mutex.

Fixes: 0953864160bd ("[NETPOLL]: no need to store local_mac")
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1fb846ad07d1..be7eb632ee42 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -888,10 +888,23 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
 
 static ssize_t local_mac_show(struct config_item *item, char *buf)
 {
-	struct net_device *dev = to_target(item)->np.dev;
-	static const u8 bcast[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+	struct netconsole_target *nt = to_target(item);
+	unsigned long flags;
+	u8 mac[ETH_ALEN];
+
+	eth_broadcast_addr(mac);
+
+	dynamic_netconsole_mutex_lock();
+	/* Hold target_list_lock here so netconsole_netdev_event() doesn't tear
+	 * down np.dev from under us.
+	 */
+	spin_lock_irqsave(&target_list_lock, flags);
+	if (nt->state == STATE_ENABLED && nt->np.dev)
+		memcpy(mac, nt->np.dev->dev_addr, ETH_ALEN);
+	spin_unlock_irqrestore(&target_list_lock, flags);
+	dynamic_netconsole_mutex_unlock();
 
-	return sysfs_emit(buf, "%pM\n", dev ? dev->dev_addr : bcast);
+	return sysfs_emit(buf, "%pM\n", mac);
 }
 
 static ssize_t remote_mac_show(struct config_item *item, char *buf)

-- 
2.56.0

