Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A37B39CD1F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824643; cv=none; b=Atx6RGZ3IvBVe6TUA/NhI82ma/fBqVwVnJEQK9Q6ij8PfK/jSlmKBOPzpsvQFxGBiuH5FyXsQMzJhjMCxgkWBYQk/kHZ/zS3j6/BMew1oDeSAw9Ou3VAAvMBu8aBBgO/owRRKBO8repJQJF+djdCZhZjuiBXz6UpKjttBM+Fe2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824643; c=relaxed/simple;
	bh=7MuVjuhF+Ser5K3+IN7XG2FsuC3X8ZSQxqeDy6PE6bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kd+t1b048G9wVZ86r7BVWuN7XKOSiTeve3k7S5zr3k+NgbHDe7zCH6z5l3PaqYbCgENwLSpARoq4bjwJS5ddi9WOvhI/MEw4chDXbRCSHmzV/WN2xOofPv2ha3tHk1aaZFd60Uh3WKiYApm3u62tBw9e7bt3z9rtjnB2MFTdFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY5TuFUf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY5TuFUf"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48bbb06f29bso169153f8f.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791824639; x=1792429439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3FVaPfHKAF1nMEvp9RjbHuFY5UhBJPIfS1hxOZsF6QI=;
        b=XY5TuFUf5qD364itS2gxwuukny79Gg1sFHP+th6xbpi7TlXd0p/l+g81sVUmnkKAAv
         p3k7AUeSSJOt99Wm5is6YBSuvbzqYkjgbzD84UZIZPEN7xtb1f35xVfNGObEqbqd7mfF
         dhGiwWErh1M4HgUytFWUZc/cPxizMfwEK/c7NiP1Cn2nGQunYFb58zCGWzRm9b/XMJzq
         F7/BEaGhbgrPVzmnbfrep9u9CsoUAK0uMaNbDQTbEvA/vovTaLNZ8dSPdBq3ZQWiGcJt
         gAf674WK3nnrntHJogQcBWmUnjXzDICd10nE1UWJEOLipVtxAUUl0wLp6sPLsBy8sOP+
         0Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791824639; x=1792429439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FVaPfHKAF1nMEvp9RjbHuFY5UhBJPIfS1hxOZsF6QI=;
        b=wemxZ+Oromtc2iMM5HCOprjn8qPdZ3fUPLimd8jeGNaLsL9tFU0hwgQMQH/TdWSx9A
         JJbkXhPWFb1TTi/IabpEEXk7FuaKgtHWxjIQ33NGpbGEd+WPEE6yxQbgQdAkAeKRl/vj
         WNRP5jck32ixyq5TCaRdXkfB4ySouwUhTphmQgzksQy0FB0oRXxbjp4t0/SLc71zoEAG
         Phvz0uGq1MmXUsrKA5Eq9jzyR61Aw9gn5dWwJcmMqHgTd6Y/cSsQD58wFS4xOujbRgd2
         TimvfYbsNhwWa8mDBosovTsls7m4SfLTcfwn91lwWMUgyBbqlM2i7M3P2tnzg6xKSEo0
         FnbA==
X-Gm-Message-State: AFq9FYIbCBtsLbCg8nXK6Wx2w4IQ3RpufveGhaRKcYzZ2H1MTlgNelAx
	UsXeyKwTpNLY/ln5VmGgR5LSMoepmkTHwsGCRsbf2B+1ZVHtZBzl6iRtqYdWDd1p
X-Gm-Gg: AYBFou3WptWtIAT/fQ5Vt0NP0/Vj8ozyy6qJWtVjU8aUS/t6z9jBtriyjcZunzO41PB
	dkHwdWGoEpxx55e7oyt84syKtLVj4LYfxtRDDNaxg/XIn1WCysDeCEkXgrRYcxUWCGoq7U/jOOO
	xtCD8zRNEqCzeCLHcpkkLCUmUVfc5HHFGtt8CGK0J4t0aP53FDrMIiVz6hUgKysLcLF1KES+Kma
	t/yFZtX8gaRyDq0ALNT4bMB/4W4DjaM6ezsrJrLayyA5GglMugCBJUvqY2ZQWzcd0X2KH1xWvxt
	JRy3yvz5CkFiafRbxvWIJFkTGaozFO5wiPdfxFQSQUpLivmwZAw4BzRWPQv5rm4eHpPyvrJRVVf
	EuArrLykGYnJ8JGrMA9J/A1nhB4rvfA9Ncwz2/rBSTp7KRUHcb1MbbzlfhdqwlsA/+6m8VOTDun
	FzRQMCGt+bjt+xdFl3+DqD7zt91LHnEVCcheTEBZ6lE1WvuPEUo4pS6kHEMlueiWE=
X-Received: by 2002:a05:600c:6285:b0:4a1:715d:1913 with SMTP id 5b1f17b1804b1-4a18e4760demr191336265e9.1.1791824639352;
        Mon, 12 Oct 2026 10:03:59 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:c555])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4f34sm447253f8f.28.2026.10.12.10.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 10:03:58 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 12 Oct 2026 18:03:43 +0100
Subject: [PATCH net-next v2 1/2] netconsole: avoid printing partially
 updated target attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-netcons-fixes-next-v2-1-ac8ec4c62edb@gmail.com>
References: <20261012-netcons-fixes-next-v2-0-ac8ec4c62edb@gmail.com>
In-Reply-To: <20261012-netcons-fixes-next-v2-0-ac8ec4c62edb@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>, 
 Sashiko <netdev-bot+sashiko@kernel.org>
X-Mailer: b4 0.15.2

The configfs store callbacks all serialize on dynamic_netconsole_mutex
but not on the read side, so reading an attribute while it is being
written returns a partially updated value.

Hold dynamic_netconsole_mutex on *_show() callbacks to avoid racing with
writers.

The dev_name_show() callback can also race with
netconsole_netdev_event() writing to np.dev_name due to
NETDEV_CHANGENAME. So it needs to hold target_list_lock in addition to
dynamic_netconsole_mutex.

Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-netcons-fixes-v1-0-bb5ffe5e698a%40gmail.com
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 63 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 267254f046de..953a1da07186 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -859,7 +859,20 @@ static ssize_t release_show(struct config_item *item, char *buf)
 
 static ssize_t dev_name_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
+	struct netconsole_target *nt = to_target(item);
+	unsigned long flags;
+	int ret;
+
+	dynamic_netconsole_mutex_lock();
+	/* Hold target_list_lock to prevent racing against
+	 * netconsole_netdev_event() changing np.dev_name.
+	 */
+	spin_lock_irqsave(&target_list_lock, flags);
+	ret = sysfs_emit(buf, "%s\n", nt->np.dev_name);
+	spin_unlock_irqrestore(&target_list_lock, flags);
+	dynamic_netconsole_mutex_unlock();
+
+	return ret;
 }
 
 static ssize_t local_port_show(struct config_item *item, char *buf)
@@ -875,25 +888,39 @@ static ssize_t remote_port_show(struct config_item *item, char *buf)
 static ssize_t local_ip_show(struct config_item *item, char *buf)
 {
 	struct netconsole_target *nt = to_target(item);
+	int ret;
+
+	dynamic_netconsole_mutex_lock();
 
 	if (nt->local_ip.family == AF_UNSPEC)
-		return sysfs_emit(buf, "\n");
-	if (nt->local_ip.family == AF_INET6)
-		return sysfs_emit(buf, "%pI6c\n", &nt->local_ip.in6);
+		ret = sysfs_emit(buf, "\n");
+	else if (nt->local_ip.family == AF_INET6)
+		ret = sysfs_emit(buf, "%pI6c\n", &nt->local_ip.in6);
 	else
-		return sysfs_emit(buf, "%pI4\n", &nt->local_ip.ip);
+		ret = sysfs_emit(buf, "%pI4\n", &nt->local_ip.ip);
+
+	dynamic_netconsole_mutex_unlock();
+
+	return ret;
 }
 
 static ssize_t remote_ip_show(struct config_item *item, char *buf)
 {
 	struct netconsole_target *nt = to_target(item);
+	int ret;
+
+	dynamic_netconsole_mutex_lock();
 
 	if (nt->remote_ip.family == AF_UNSPEC)
-		return sysfs_emit(buf, "\n");
-	if (nt->remote_ip.family == AF_INET6)
-		return sysfs_emit(buf, "%pI6c\n", &nt->remote_ip.in6);
+		ret = sysfs_emit(buf, "\n");
+	else if (nt->remote_ip.family == AF_INET6)
+		ret = sysfs_emit(buf, "%pI6c\n", &nt->remote_ip.in6);
 	else
-		return sysfs_emit(buf, "%pI4\n", &nt->remote_ip.ip);
+		ret = sysfs_emit(buf, "%pI4\n", &nt->remote_ip.ip);
+
+	dynamic_netconsole_mutex_unlock();
+
+	return ret;
 }
 
 static ssize_t local_mac_show(struct config_item *item, char *buf)
@@ -906,7 +933,14 @@ static ssize_t local_mac_show(struct config_item *item, char *buf)
 
 static ssize_t remote_mac_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%pM\n", to_target(item)->remote_mac);
+	struct netconsole_target *nt = to_target(item);
+	int ret;
+
+	dynamic_netconsole_mutex_lock();
+	ret = sysfs_emit(buf, "%pM\n", nt->remote_mac);
+	dynamic_netconsole_mutex_unlock();
+
+	return ret;
 }
 
 static ssize_t transmit_errors_show(struct config_item *item, char *buf)
@@ -1342,7 +1376,14 @@ static struct netconsole_target *userdata_to_target(struct userdata *ud)
 
 static ssize_t userdatum_value_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%s\n", &(to_userdatum(item)->value[0]));
+	struct userdatum *udm = to_userdatum(item);
+	int ret;
+
+	dynamic_netconsole_mutex_lock();
+	ret = sysfs_emit(buf, "%s\n", udm->value);
+	dynamic_netconsole_mutex_unlock();
+
+	return ret;
 }
 
 /* Navigate configfs and calculate the lentgh of the formatted string

-- 
2.56.0

