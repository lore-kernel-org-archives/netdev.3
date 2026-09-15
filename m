Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399024AE8C1
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513914; cv=none; b=bwbMc/dmRveAkmYLLAD1ghF5mu/0n3TGOBjYP12bet9DTyUnIMMIgwEXRsrQE/Mf6X7KXtamup882nHCl8p4Rjq9XunIgx9TfZjNQSvURhxbiwz9JaXR1jhvKaYCzFbdMsUYcs4YsZxlML29QPYRgVz5zV+uKPV1lRP6eyIkAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513914; c=relaxed/simple;
	bh=y6UJqHJdFjJ6HBQ9dPEgMz+8A6jHpPtqxx0jW8XZw/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aX+gYCxYJJCfH/7A/oPUaGKIEgblOqVJpRr+YKvHkb/YNpeF6rlEQD8pIMTJuXFMWaamVoP4gv14nbddBGynf3003hxJPVHHSqkHiGqjhUKdyzPIHHI2gZ5JsjecMBMiE7xzQ62EgBluAHUdLMvf8vvmHq2AD0gRj+EWRxQxj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGhkGtvb; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGhkGtvb"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae6c9b81so57714eaf.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 16:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789513912; x=1790118712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qYnx8lIChO5awa8u7wXu34IHHlum4k9WS5sRW0361To=;
        b=cGhkGtvb2/dtLXnOJSd+h4Dz73eqp6uwUZR4FC0tQIcZjQ6USwvcyMigmIz/pg9ClO
         v8HEaUglT/ImBaPXNfQVgdGhWrdn1fETDL7rYfwinq/4tssCD2N209EJoJjteHdESxvP
         R67yse0XkBSe/epgnD/OUIY+8+hVMy7wxs9uUQazs0vpDnossWM7vxIW4ffN66DcHWHt
         SVzAYIziHaSeCRSp0BxFNwS+Floqf/V7vk+WWk1ImUGIfjXo2EhYBriFpEA+/otOC8Iz
         g667U4ROsy7SEWGQoiyRkty1OTI7Rh0hVEikl4/18dkA5Tr35HxjfUMFZEknuT308cNO
         Hamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789513912; x=1790118712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qYnx8lIChO5awa8u7wXu34IHHlum4k9WS5sRW0361To=;
        b=dpXS1vi1QCG7OYZPIfW32AQSbBQSwCBeh4NOV56YyZOFNia1zbzJUAFAHrYFIqfXJ0
         Df0m8iFLBFc+DXhmQabfhx7rAudPJUEE1ILqv4KXkvgaa0pYj7T7VORB/3lk7sSUODpj
         Cw2X/DVDWN69ZKAGHKhn2avJw9K2n6m1CjIyEjmez2zGCtBwA6R76sSPBBmGlQPfdXqf
         ws3g7CodlUux4TBOF0LCqVZOmlOCcOc9s4Ji1aJnWzIRMpddGoxuixuxKpDQo258T0Z1
         JGkt6u4vip3Vy3jZ0/CrcEw0oy9L+z0STVmp6AxlldcRks2a1bW/k9lj+9fbMyf4Cu8q
         Faqg==
X-Forwarded-Encrypted: i=1; AKwUvBzN4wWV/9O9dm0lSrvzYpiVn91prqSSTqk6BhcuZ++hN4mPMR7SuA9KttosBOkHPKdJZvhm2YU=@vger.kernel.org
X-Gm-Message-State: AFuF++ks5T+odG9uGgf7xa+lJEeLr8UPlU5wjjahIixf0EMs1zEnvxBV
	4CvQSKU+wmXD+dMiQFVrd0cTR85tUS+i1wG5rNn7urgXoGrRZVHqh380
X-Gm-Gg: AYBFou3HNPdb0iynZ/+yXPkA6F/YQHby3HcV5xwJj7/HF1nGgrbvcioqoocq1ur9I7G
	TdqT1gel1KU7wF5oQJ4xaW6VNbCbc0ayfopEmIqUcg2OT8SyP2QHGSBasxQisLGd76k/Am60fqh
	JPJSL9h9YYUU+nIliOOsCFVbBNFGKr6WEzBrZ7q/biOPJRc9rSVJHGaoaOVvvcCsxWkkOzzw8aL
	pZceuDHOQ8XerXhjQd5Am95153oam+/LEwPj5cAlOrtxW297N0QdqWDB652fMGIzGO+xd5MKZUG
	8dXurmYTApBweAyQ0yEc3jDuVm0AhdEdE/YYKL5DheOZbQAbXKkEmNhn2kDCpeBJqr9nSdFRfas
	p/psWholVHo2eRzLD0a+SMX3Dhv+pvaoe8cV3/l2Gb54OKUGQpMJniJ2tiHfNiq5sb7lGdoTR/L
	ABW7qQPrPJJii+Kgzp6QAI/PiJnLbljy8qBXp8MMgQeGVBas1hxxMD6UkW9i/we+PALydW
X-Received: by 2002:a05:6820:80c7:b0:6c2:c7b7:770a with SMTP id 006d021491bc7-6c7e6c8267bmr279047eaf.10.1789513912098;
        Tue, 15 Sep 2026 16:11:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c7a677b3bdsm1222340eaf.6.2026.09.15.16.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:11:51 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Tue, 15 Sep 2026 16:11:38 -0700
Subject: [PATCH net v2 2/2] selftests: drv-net: psp: test PSP and TCP ULP
 mutual exclusion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-psp-ktls-fix-v2-2-0eedc3b148ec@gmail.com>
References: <20260915-psp-ktls-fix-v2-0-0eedc3b148ec@gmail.com>
In-Reply-To: <20260915-psp-ktls-fix-v2-0-0eedc3b148ec@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.13.0

Test both setting PSP after TLS ULP, and TLS ULP after PSP.

Add CONFIG_TLS=y to the drivers/net/config.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/config |  1 +
 tools/testing/selftests/drivers/net/psp.py | 46 ++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/selftests/drivers/net/config
index b6989c7d3d9d..4838adf27fa1 100644
--- a/tools/testing/selftests/drivers/net/config
+++ b/tools/testing/selftests/drivers/net/config
@@ -21,5 +21,6 @@ CONFIG_NET_SCH_INGRESS=y
 CONFIG_NET_SCH_PRIO=m
 CONFIG_PPP=y
 CONFIG_PPPOE=y
+CONFIG_TLS=y
 CONFIG_VLAN_8021Q=m
 CONFIG_XDP_SOCKETS=y
diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 315648a770d0..a5b1e14f120f 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -23,6 +23,8 @@ from lib.py import NetNSEnter
 from lib.py import bkg, rand_port, wait_port_listen
 from lib.py import ip
 
+TCP_ULP = 31
+
 
 def _get_outq(s):
     one = b'\0' * 4
@@ -333,6 +335,50 @@ def assoc_version_mismatch(cfg):
             ksft_eq(the_exception.nl_msg.error, -errno.EINVAL)
 
 
+def _require_tls_ulp():
+    with socket.create_server(("localhost", 0)) as srv, \
+         socket.create_connection(srv.getsockname()) as s:
+        try:
+            s.setsockopt(socket.SOL_TCP, TCP_ULP, b"tls")
+        except OSError as exc:
+            raise KsftSkipEx("kTLS not available") from exc
+
+
+def assoc_psp_ulp_exclusive(cfg):
+    """ Test that a TCP ULP cannot be attached to a PSP socket """
+    _init_psp_dev(cfg)
+    _require_tls_ulp()
+
+    with _make_clr_conn(cfg) as s:
+        try:
+            cfg.pspnl.rx_assoc({"version": 0,
+                                "dev-id": cfg.psp_dev_id,
+                                "sock-fd": s.fileno()})
+            with ksft_raises(OSError) as cm:
+                s.setsockopt(socket.SOL_TCP, TCP_ULP, b"tls")
+            ksft_eq(cm.exception.errno, errno.EINVAL)
+        finally:
+            _close_conn(cfg, s)
+
+
+def assoc_ulp_psp_exclusive(cfg):
+    """ Test that a PSP assoc cannot be added to a socket with a TCP ULP """
+    _init_psp_dev(cfg)
+    _require_tls_ulp()
+
+    with _make_clr_conn(cfg) as s:
+        try:
+            s.setsockopt(socket.SOL_TCP, TCP_ULP, b"tls")
+            with ksft_raises(NlError) as cm:
+                cfg.pspnl.rx_assoc({"version": 0,
+                                    "dev-id": cfg.psp_dev_id,
+                                    "sock-fd": s.fileno()})
+            ksft_eq(cm.exception.nl_msg.error, -errno.EINVAL)
+            ksft_eq(cm.exception.nl_msg.extack['bad-attr'], ".sock-fd")
+        finally:
+            _close_conn(cfg, s)
+
+
 def assoc_twice(cfg):
     """ Test reusing Tx assoc for two sockets """
     _init_psp_dev(cfg)

-- 
2.52.0

