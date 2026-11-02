Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649308;
	b=exrXGwT6j9fIhgkfiN4ytwjDehPk3198CHIhkeKKVG7P4BpfUGfpKXenQJmJUa9WALfw
	 An+TIkhcsm7n8EpDATNLusgzyHXW/oXnVj2Uxn1XbGgasQ7g7m8mj2K1PorQinmuqhFkr
	 3qfUHaPQmdXLiuJUj+bz2eHluIEx/JkhPvewIsK9JXoIhs8ig5/moTpncqaDvnbf7uqDP
	 +6y75s+t+rQVnHshJ5tLr730e/202caR6VJlMbg/JiLkhzf+W0gW6tzoLoj8yDkji9QXb
	 uMUkcpHls0yNNnXfgaHRR+3NojBjrDQU9MNGTBhR5lVD8Qs/dmiw/PVisXzL0Dcxhtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=9uUZbAhfeGjYG/riHe43I8tFvO+tplgSrmlkSMwjJsY=;
	b=FH/2i+adca9Od031Rb9a09oUI9ggOa0W+nzbAUUJS0TiC95J7TWU9YpXxvFvXyv/lK2o
	 7EjvalgsanXjOWjEl73rVuIEbD8bSPs/4BZOK7k33EJc4wI5FrzPPBx4YmeRzNjL7lDM+
	 deJIWgB5j6J2Czevsev6H+whWkVfbbx7vmcLAz4u6BY/XBjB+VY6QZ3PDcyA8y3OZGLYr
	 /SePJOSdLtGtlaqs/30Idi8tXMViovTADbrd9QdHYNrq3m0KTZY2mLyPdLiC7q/7Fx7xO
	 W8sCP9czRU0RWPCg5svBMIhPXTtswIO2QyPgSkoL7Gb67Vax71hGhe/pWt5vN5QlEMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nbc61Li5;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B12606D805
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 19:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56B12606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nbc61Li5
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48b09c273caso363203f8f.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 11:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793649306; x=1794254106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9uUZbAhfeGjYG/riHe43I8tFvO+tplgSrmlkSMwjJsY=;
        b=Nbc61Li5mrA/nfVnFJBC+77qQTYw1R19JfVYWDt4vXFAWRYiA/Kj/jZW4gDsux2G0U
         z4xSX2Jo5KBV9a4Gblt3/9U4XT5JPXUNAwk2aeSiMTrQQCQSmWPeusrWxNzRfj7go7x7
         L7ND1QnWt043Y4aupzbTBav8HUseoTeEYEJj1IE4XNejhQk5qE1sCd3GptOM3SLi9hEO
         vEZpoxeCQruNGLChXf/W71TM4ORkfk2QiAervrEqJJkRFlJQN6dS2mMASE+XE1soty9h
         NXzjzUVoS8ppaVGJNNNFkEpbd6F6F7Ug1Z0+uu33fkZ5idEH/o0JNNGGin7DsZGb3Set
         KiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649306; x=1794254106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9uUZbAhfeGjYG/riHe43I8tFvO+tplgSrmlkSMwjJsY=;
        b=tAHl/6uTsxcAfTIHyzIIrnrCkDdr3ViwkP16ZlW8o3t7mnSY7MfOjACYdtNJWZWUL2
         7X4CjkI89Fp6eaNuISy+IciY+8jy+l0lNpBpK4VuukT95FLHIgIoaGVnhe0CDX5j0DVR
         B6ixDjhYl+53tB7UIAOgeGenOcJnd+vOXYuj3EYcvu0DXp36qhnwPJfvJ91y56G8zq6k
         lnkLUYPEwEMaBKJUKfDOuEliVPR9o1Qt+LVuV3MvDTWnxe/R4/Dm5o2x1ARkJvEbcM/V
         t3mEkHZNEWztrMFRJGRXdXHzLl0tF/2SGQ9t0mR9LnKmzI9OeR3uulBtGEx0HksGISs1
         KUeA==
X-Forwarded-Encrypted: i=1; AKwUvBwJC8bSrXAMaOzg2hyA4JLZ/3ZSHFUs8GUcco0a8oZ7s/UOMDHjud+fVCQxKI+UNg44PX1ssRM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8lGaLY328mNWq5YDR7Eea8cuttJEv4s6YlQSCCL+nit9xp/eFQ
	qX5lXuZFoItYCm6gqR7/5waEK9OAaaTbgT6iY/RSUx5Xvv0A/I0X7pVc
X-Gm-Gg: AYBFou04W7jqDQIF3TeKIqnGREI3GMcWw7C/GodcXXBjXVdRO1XC5cqhV44hFfeud/B
	ZGmulp+ReXDaVgldbE64VmqAIF6e+oxo8py+4lEOvmwEd4eNrSwfcA387uGjBb13YH4LjPkvVq8
	3C1VflMxeq4oIHg2Hj38B8TIRklF8qECRLw+nRZuaU+b9G+MPmUznpbAw6RbzOKyeEUv2oD2Ugj
	msSMnm9xLWF8z8SIBCvNy/zC1ZPcxyfnhOOqCBMfo1t3j7YUxUwxmH2GkjZjECiNUrlY+43yoOm
	BqUWzeLUSIgaGVmz6qr6ueOYgrTx+Cbu0qzgbOvQLqN1+vE6bl0b1KIaTAuZHu10mA7nPW6fRHy
	UhcVj7HVZY3wadtIe7WVV7ltOmmsLJJThZKGGyR4p2zRlB48jzUYScoveJQa4kdWu+cgji+y0Ry
	gBkzO151YAE0nAPRVBXObdTMSP05cs28XTyyN1E1Lq6Yt5GAQ5smELkciAbENR5nCGZfbrxXagm
	iJicQD+iD4A5E9nMUQu1g546ZBOdkGb5yOrUm38J0w6+qVuYPVOa43Q6Y3vZ+RrtFeKmvUAD98u
	EWKoKEw8xO1nJjhChWJ/nPWOVF9RE+YN
X-Received: by 2002:a05:6000:2587:b0:48e:5ad1:5e77 with SMTP id ffacd0b85a97d-48e6e261607mr24082404f8f.0.1793649306240;
        Mon, 02 Nov 2026 11:55:06 -0800 (PST)
Received: from localhost ([2620:10d:c092:500::7:f93e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723cdsm22180229f8f.12.2026.11.02.11.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:55:05 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 02 Nov 2026 19:54:50 +0000
Subject: [PATCH net v5 2/4] netconsole: read np.dev under target_list_lock
 in local_mac_show()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-netcons-fixes-v5-2-bdada2f03563@gmail.com>
References: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
In-Reply-To: <20261102-netcons-fixes-v5-0-bdada2f03563@gmail.com>
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
index 7dde00eb8e98..1680581c595e 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -900,10 +900,23 @@ static ssize_t remote_ip_show(struct config_item *item, char *buf)
 
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

