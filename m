Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81537F32D
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790618476; cv=none; b=A01xrx7lRtfErdjplZLQ+pBmtHg89enoVPBWSnTLWahXZj6wx1XC+LBPK6QUMnz8oJJnLlV9l0Id5tEMzoAYalfqs/MVnl2o6euxbRrVuVzs0voidMsrF+yle3cFLYO/NSUzQryP1+pjIoFjpKbZVXP+jBKOcRq8xxHJ4YLNPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790618476; c=relaxed/simple;
	bh=MLoOgdgamwvKpLuHxrXRbyWeQguYU9XHzrGDgAYZM8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ASoo4w70IWjblvoN54izg7OgxQL5Z4jqugMwD9lijlIqDwI4kHh6CllP829k+nkyQeao/9K3Q2yXQdBKE6hcteiKplJ7w0BZGLSE06hwb/IHrS3x2Bw1CNPP8qd63lkGA+0x4xuUXgzspRsmzd4Kq2yluz886bbRH1g5Cw6LAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pS28ad27; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pS28ad27"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6baf77afso1162545e9.2
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790618473; x=1791223273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yzM+wuGo8xGnnJ9h7U2YxWtdWl494XOm0tmOIUnpiXI=;
        b=pS28ad27xcYcIGB+bOGbdOYkglLdOHMCa34e85c9d5+JX4Ng2+avM9irla5ccxhNRo
         oex6RV8RWBAS2jHLJgnhKO1qYom6oErmUygl8QXMAGElcc1aoAlRUce8E0uepIyVogpP
         i17xx0py6LisYqlgSyVFYTnDJQ1trQbhfC2ucUbDvBlGd+rX2G5pJuwZTHOgYJ7mrMTB
         34NBeT4mDdNxCStcVWx6qE2i1I1Xs1/g0i80exlyazoEv1VtDsRmmSpf3/0dQdHaAZEI
         99sSuUYaACtSlDq1FXb/wTmacVIetIli0tqiNgvmh3iuog4Z7LX47HqNWDERw4er07Ql
         u5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790618473; x=1791223273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzM+wuGo8xGnnJ9h7U2YxWtdWl494XOm0tmOIUnpiXI=;
        b=xJsLtdnIySHt+ya8k8Dot+RXsgRa33PaQcd8YA0g81Gg6ew9RqlF3u6JB8xkcDIVlc
         uj2mWCXk6droQDn3qZu1yzXt/jXLKaDgr7DD6gl7NmxKS6RJb2aFYDCZJYBNeWMFOqQ8
         M7YyWeKaBtYddx8MVFt3IO4Uve+xr0LUa8jG8PPY3Jwwp5olaYJNf+RLZmRqRfNMWEiw
         SmEvog6bfcMymsXG/1JhZBeRBj7HdtUWq48R7sWn7GR6HeeRRddeqjrrckzlTl8lwfya
         5udXxJ1z22uDhWLzMD2hNXaEYbud7fkK8miYXNAzS1404kf7q63UTp77n9BqcKlVtDvc
         j1cw==
X-Gm-Message-State: AFuF++n72DyR6mbzN/IQ3NtalhKblOAcdcCKrJ77FTFEbHD4HCzrc9zI
	9c6ekJstaqi/V++X9QVqwM6yfbOzdlve3wag6fQwpl6zSZ+WvDOGl7QF
X-Gm-Gg: AYBFou2hwWlY0WZMuKVgdtzcq7SbgfZxmjjfFclm81s/VWvYae5/GJPXjacqLwuYeTn
	72dlnAViaLAvENGbza5b3z0vNGpuaVV8UbCOe4vu3rDS3TGon20Mgg/IucVXvCVI/e++h+UAN4B
	dT8yaQP5wEFLE+IJabcCtWncXAL/TOd8hXjk2QhuXWNpE14vGgGmzkytsEDN+2xLl5UZRADMP4r
	EXV4fo0wOFjmJkxXXpet96r+h35VND4mpMsUhbVYqaS24+1jOIIdghVSs2BD4XI+Rv4PdAuTcr7
	xq673wq4NiDwr+nH563+3VS1fzyILfWdE5iq44WTNWyXrvvlnnVF1Nzi1CGuS7DWcMl0zjJPpfv
	UnXazhjFbUzZMpqazQS/RLXtJfYOtaqK8rDWOx35jdvMOEHcEOjpb3a29NXlwTkiiT46wQ+cYMO
	1Hnl5Cbxg/50+asDoUq1QskMyqMIv6980Npcs6iOqmsmQotepA/EnCBMcYKdX9Ji4=
X-Received: by 2002:a05:600c:859a:b0:4a0:73b:a222 with SMTP id 5b1f17b1804b1-4a0073ba3ebmr29396585e9.0.1790618472590;
        Mon, 28 Sep 2026 11:01:12 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:c231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c10c656sm30484605e9.2.2026.09.28.11.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:01:12 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 28 Sep 2026 19:00:05 +0100
Subject: [PATCH net-next 3/4] netconsole: avoid printing partially updated
 target attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-netcons-fixes-v1-3-bb5ffe5e698a@gmail.com>
References: <20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com>
In-Reply-To: <20260928-netcons-fixes-v1-0-bb5ffe5e698a@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matt Mackall <mpm@selenic.com>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>, 
 Sashiko <netdev-bot+sashiko@kernel.org>
X-Mailer: b4 0.15.2

The configfs store callbacks all serialize on dynamic_netconsole_mutex
but not on the read side, so reading an attribute while it is being
written returns a partially updated value.

Hold dynamic_netconsole_mutex on *_show() callbacks to avoid racing with
writers.

Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 57 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5f4311726d11..627475f16383 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -861,7 +861,14 @@ static ssize_t release_show(struct config_item *item, char *buf)
 
 static ssize_t dev_name_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
+	struct netconsole_target *nt = to_target(item);
+	int ret;
+
+	dynamic_netconsole_mutex_lock();
+	ret = sysfs_emit(buf, "%s\n", nt->np.dev_name);
+	dynamic_netconsole_mutex_unlock();
+
+	return ret;
 }
 
 static ssize_t local_port_show(struct config_item *item, char *buf)
@@ -877,25 +884,39 @@ static ssize_t remote_port_show(struct config_item *item, char *buf)
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
@@ -915,7 +936,14 @@ static ssize_t local_mac_show(struct config_item *item, char *buf)
 
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
@@ -1350,7 +1378,14 @@ static struct netconsole_target *userdata_to_target(struct userdata *ud)
 
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
2.55.0

