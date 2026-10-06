Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659C3BE620
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791313150; cv=none; b=trWCBkMUrMw6Id/D1zkUPLqCFR2j0Gatt5szuHQ6OyosS0MbIe8ekhwNeCwGwn2TABjwRrYsLxOC+9Wlk28vcoRlqomHrzY329R0S1aasFZFh58Jf7HzFrKmGLzVqhVeeR5F3wONb+GgGiIRBGoM/DZL/NsNuJsX/qaZUbUD0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791313150; c=relaxed/simple;
	bh=tMLsN85UXT6wrJkZlsJXgWH8LDuK7i7RwaHmL8NY3zA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BX/HalFzu74MGODA+NTZog6wglYF2KPkuuJrqy/OWUs7fsCo6eBbB0kDiffI8/pPOpMKS7guWum1gxP/rH4kOtQsolYknfio1g5akJ/nKNqw67sV6Zk7Lps951eRhMe0i/x+YUFk/gnWjtJnyMEF91lRj4M+mivmqTK1lnYMsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTk3faZn; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTk3faZn"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7c6dbc60so1766275e9.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791313147; x=1791917947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VbBKq5PTG+zTXJMhfDnHYLmZDkMnD71kksXBsqcRR9A=;
        b=gTk3faZniuOOApM1Cn1z/p05mDicIPrZGv5HXiwbyhx4OHizma9UB8LwKz96hDH9zo
         wMV2SpSmds3DlW1Bkd7aoScIZxvl0swNspmKKp0GwIlfsDgVqs4t5lyozj0hPH2OmmlF
         69PeCFOAZ4MxRtchKKvUl3rbXmBPRO0bKY8fHWqabWiC+Yv3DXe1wLFhdTYZwVgXEw+2
         We/FfXgHx7ZO4USKq0wV8fgXGPdWsLq7nzLIOLNWCuZ8LygMD98sSrtOSbdm3E+n6ux4
         CpMwZ/i4Ww2erAShwcVbTP4xPCaqJswwzZJzETjLjGNq9s3fsLPTGuqjlGB4+3pN/FLj
         hc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791313147; x=1791917947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VbBKq5PTG+zTXJMhfDnHYLmZDkMnD71kksXBsqcRR9A=;
        b=KP3e0de3qmUYOjBuFnB7AACQHdmz5s1c/Wd54BVI9Fbd+MgHDbyiiJhOGZXHx8wbMd
         0BkqxcvPlw3Kjy9IS0XSPh+lgk9lP04WWtAu8jhAVF6khkD1Kq8yS/z9Iv6aoE0nAc/c
         KWqPthFQGf8gMccTIDL0vTQ7FrsBG+VR2xHr59+yMjrvSutvSYJ2aS/OgXf0y58XH2V6
         CsZTF/Nv80uesUXthyNzDb5PFY8eKSUfTRmW158cEd052Nn1E6IOloWd+X/tDvGwRHcm
         iqILEA4lUu0A3Ibowvf7x+AvuMGnqBo0GDXfTsl56YBpEPcRzt9v6YAJxyFEWPBXqA3J
         55pA==
X-Gm-Message-State: AFq9FYIBZ7I/Qi3noZypERQYasgRupc8sffxK+IFslTMOJG59Rdjrjdt
	23SZJkmaimUY+payw+HxRphjJf8yfseLAfXPZqx1af5k5lUpMw2yU3Hv
X-Gm-Gg: AYBFou1+Dsr3NKUlpBI5rt/cd/72467/ojO5tRD2UaQepa0jS95BglUX4YbhtroeUwS
	DYF+iifRgG4ZRn00tsIW4FYYhaKdMHhD21eS0mTughSjenYBlrgPb0zsCuFyb66/p5Frnl/eukX
	ZrNMq55GmyCs3vOSaaqeSAZ6d6ucEJL8yzJaWlGv6Kp/RxJQ0kUVDyWguyqK8jMf+sapLouaJn1
	R+kU/lbfk4hVFIEZl98Wf8sgNuB85WVLQLJvQ4PsXEOSaOFX5goO3TQBlN6SJ9M51xeGKYyMXgU
	tMX96n/bfv/Jqg96WiFRhbpnP/PvmbnlbrkSugNBQyf2qkeDr1WFT7H41vYzykxkNrV8+ar1i6Z
	tMr+9jo11X/H2KCPBY1CPn/RNazYEheyBRtmMJ1He0DaEgPn9jtU6p0MjKOx4hU7XQpHg2jZLcG
	GmqnKkhiEq75kHFsTOSjBKw9Ct8galG90tYIVKnSgixBGTiWY3TVGE
X-Received: by 2002:a05:6000:4810:b0:48c:4802:e253 with SMTP id ffacd0b85a97d-48c7288f1eemr562307f8f.6.1791313146607;
        Tue, 06 Oct 2026 11:59:06 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::4:4701])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71c0b604sm1150678f8f.13.2026.10.06.11.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 11:59:06 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Tue, 06 Oct 2026 19:58:29 +0100
Subject: [PATCH net-next 1/2] netconsole: avoid printing partially updated
 target attributes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-netcons-fixes-next-v1-1-231cd26f8c51@gmail.com>
References: <20261006-netcons-fixes-next-v1-0-231cd26f8c51@gmail.com>
In-Reply-To: <20261006-netcons-fixes-next-v1-0-231cd26f8c51@gmail.com>
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
NETDEV_CHANGENAME. So it needs to hold RTNL in addition to
dynamic_netconsole_mutex.

Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814-netcons_ipv6-v3-7-bc0915e8c75f@gmail.com
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-netcons-fixes-v1-0-bb5ffe5e698a%40gmail.com
Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 62 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 267254f046de..188beacb308d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -859,7 +859,19 @@ static ssize_t release_show(struct config_item *item, char *buf)
 
 static ssize_t dev_name_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%s\n", to_target(item)->np.dev_name);
+	struct netconsole_target *nt = to_target(item);
+	int ret;
+
+	dynamic_netconsole_mutex_lock();
+	/* Hold RTNL to prevent racing against netconsole_netdev_event()
+	 * changing np.dev_name.
+	 */
+	rtnl_lock();
+	ret = sysfs_emit(buf, "%s\n", nt->np.dev_name);
+	rtnl_unlock();
+	dynamic_netconsole_mutex_unlock();
+
+	return ret;
 }
 
 static ssize_t local_port_show(struct config_item *item, char *buf)
@@ -875,25 +887,39 @@ static ssize_t remote_port_show(struct config_item *item, char *buf)
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
@@ -906,7 +932,14 @@ static ssize_t local_mac_show(struct config_item *item, char *buf)
 
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
@@ -1342,7 +1375,14 @@ static struct netconsole_target *userdata_to_target(struct userdata *ud)
 
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

