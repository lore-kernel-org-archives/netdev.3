Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B525B098
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495843; cv=none; b=MR4wRbphX6JefM/fxzPfjkBiyYfUH0bwwCzZBtoiHDZWCm/MA/ME2UgNn1PzbvkqhMUqI/3X3fWF+ZXBie83jDrpySGoGOX4XE45omyrpkkOY/ayDVt3xLN6NpftCgs27xabIQxBdKUILdxmbnk2I8Yk7KyZU7w54ehxSXcnRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495843; c=relaxed/simple;
	bh=ieEs4aDAuA0FxJsZpbTn/nZhxP2kfPwpl5SAgbA3gt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhClCDB4LdA6154Xui7jLwz/NLTm6l2BQOA1pWjwEBcEhRPxq3RBEyZzENZo3G30ybWf/y2R0OAgQu3FLQA8H1kgV73ovO5A5SYhPDRyT7NM66WCk5RrPYJz/Ut5vdOEpyoR8pCfSKM82EkBklK6xsFYFF4jkGLnL2/qc5ExPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id QW2PwKB84PpWVQa9pwyIQB; Sat, 23 May 2026 00:24:01 +0000
Received: from host2044.hostmonster.com ([67.20.76.238])
	by cmsmtp with ESMTPS
	id Qa9owrCtimZHDQa9owKCLH; Sat, 23 May 2026 00:24:00 +0000
X-Authority-Analysis: v=2.4 cv=M6lNKzws c=1 sm=1 tr=0 ts=6a10f3a0
 a=O1AQXT3IpLm5MaED65xONQ==:117 a=QeWor2tdjpy9U23wdFvjzw==:17
 a=NGcC8JguVDcA:10 a=z6gsHLkEAAAA:8 a=Xie9NPzdAAAA:8 a=fwhH296K5KjeCrxF8jIA:9
 a=vUoOGYJDS1_Kmot3Fv_X:22 a=iekntanDnrheIxGr1pkv:22
Received: from [66.118.44.127] (port=46532 helo=timdesk.home.local)
	by host2044.hostmonster.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.2)
	(envelope-from <tim.bird@sony.com>)
	id 1wQa9n-00000000m2D-2YkN;
	Fri, 22 May 2026 18:23:59 -0600
From: Tim Bird <tim.bird@sony.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.kernel.org,
	horms@kernel.org,
	acme@redhat.com
Cc: tim.bird@sony.com,
	netdev@vger.kernel.org,
	linux-spdx@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] llc: Add SPDX id lines to llc header files
Date: Fri, 22 May 2026 18:23:54 -0600
Message-ID: <20260523002354.28831-1-tim.bird@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host2044.hostmonster.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sony.com
X-BWhitelist: no
X-Source-IP: 66.118.44.127
X-Source-L: No
X-Exim-ID: 1wQa9n-00000000m2D-2YkN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (timdesk.home.local) [66.118.44.127]:46532
X-Source-Auth: tim@bird.org
X-Email-Count: 17
X-Org: HG=bhshared_hm;ORG=bluehost;
X-Source-Cap: YmlyZG9yZztiaXJkb3JnO2hvc3QyMDQ0Lmhvc3Rtb25zdGVyLmNvbQ==
X-Local-Domain: no
X-CMAE-Envelope: MS4xfKeTLsadGsXRNKhLEQERNeP+aIDAOS0GBTM3AnCPpbWSEBgI30TOACEkmVATfMPx0Lwuu/JDNTfH/j8b9Qb4QBE+4qJfC8kiQuBKu7NbopNaw+WxvAHH
 i6Xz+XTkM1+4lo9dPZBpXXiZWEHABcO5S/cEIiSQrP6TZxVG0Xi4VaKzvqr705VsQx+PCs+2xuUwtKEORD+X9dzRJ8zHBc2wecY=

Add appropriate SPDX-License-Identifier lines to llc header (.h)
files, and remove other license text from the files.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
 include/net/llc_c_ac.h | 8 +-------
 include/net/llc_c_ev.h | 8 +-------
 include/net/llc_c_st.h | 8 +-------
 include/net/llc_conn.h | 8 +-------
 include/net/llc_if.h   | 8 +-------
 include/net/llc_pdu.h  | 8 +-------
 include/net/llc_s_ac.h | 8 +-------
 include/net/llc_s_ev.h | 8 +-------
 include/net/llc_s_st.h | 8 +-------
 include/net/llc_sap.h  | 8 +-------
 10 files changed, 10 insertions(+), 70 deletions(-)

diff --git a/include/net/llc_c_ac.h b/include/net/llc_c_ac.h
index 7620a9196922..af31a49bebb0 100644
--- a/include/net/llc_c_ac.h
+++ b/include/net/llc_c_ac.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LLC_C_AC_H
 #define LLC_C_AC_H
 /*
  * Copyright (c) 1997 by Procom Technology,Inc.
  * 		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 /* Connection component state transition actions */
 /*
diff --git a/include/net/llc_c_ev.h b/include/net/llc_c_ev.h
index 241889955157..d45140d4289a 100644
--- a/include/net/llc_c_ev.h
+++ b/include/net/llc_c_ev.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LLC_C_EV_H
 #define LLC_C_EV_H
 /*
  * Copyright (c) 1997 by Procom Technology,Inc.
  *		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 #include <net/sock.h>
diff --git a/include/net/llc_c_st.h b/include/net/llc_c_st.h
index a4bea0f33188..f52a4cc4880d 100644
--- a/include/net/llc_c_st.h
+++ b/include/net/llc_c_st.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LLC_C_ST_H
 #define LLC_C_ST_H
 /*
  * Copyright (c) 1997 by Procom Technology,Inc.
  *		2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 #include <net/llc_c_ac.h>
diff --git a/include/net/llc_conn.h b/include/net/llc_conn.h
index 374411b3066c..e1a302696723 100644
--- a/include/net/llc_conn.h
+++ b/include/net/llc_conn.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LLC_CONN_H
 #define LLC_CONN_H
 /*
  * Copyright (c) 1997 by Procom Technology, Inc.
  * 		 2001, 2002 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 #include <linux/timer.h>
 #include <net/llc_if.h>
diff --git a/include/net/llc_if.h b/include/net/llc_if.h
index c72570a21a4f..a333259613ab 100644
--- a/include/net/llc_if.h
+++ b/include/net/llc_if.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LLC_IF_H
 #define LLC_IF_H
 /*
  * Copyright (c) 1997 by Procom Technology,Inc.
  * 		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 /* Defines LLC interface to network layer */
 /* Available primitives */
diff --git a/include/net/llc_pdu.h b/include/net/llc_pdu.h
index 86681f29bda7..f165237a3723 100644
--- a/include/net/llc_pdu.h
+++ b/include/net/llc_pdu.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LLC_PDU_H
 #define LLC_PDU_H
 /*
  * Copyright (c) 1997 by Procom Technology,Inc.
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 #include <linux/if_ether.h>
diff --git a/include/net/llc_s_ac.h b/include/net/llc_s_ac.h
index f71790305bc9..076adc5217fd 100644
--- a/include/net/llc_s_ac.h
+++ b/include/net/llc_s_ac.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LLC_S_AC_H
 #define LLC_S_AC_H
 /*
  * Copyright (c) 1997 by Procom Technology,Inc.
  * 		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 struct llc_sap;
diff --git a/include/net/llc_s_ev.h b/include/net/llc_s_ev.h
index fb7df1d70af3..7b9c94093336 100644
--- a/include/net/llc_s_ev.h
+++ b/include/net/llc_s_ev.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LLC_S_EV_H
 #define LLC_S_EV_H
 /*
  * Copyright (c) 1997 by Procom Technology,Inc.
  * 		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 #include <linux/skbuff.h>
diff --git a/include/net/llc_s_st.h b/include/net/llc_s_st.h
index fca49d483d20..85ce230fd946 100644
--- a/include/net/llc_s_st.h
+++ b/include/net/llc_s_st.h
@@ -1,15 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LLC_S_ST_H
 #define LLC_S_ST_H
 /*
  * Copyright (c) 1997 by Procom Technology,Inc.
  * 		 2001 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 
 #include <linux/types.h>
diff --git a/include/net/llc_sap.h b/include/net/llc_sap.h
index 1e4df9fd9fb2..b259f5993c46 100644
--- a/include/net/llc_sap.h
+++ b/include/net/llc_sap.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef LLC_SAP_H
 #define LLC_SAP_H
 
@@ -6,13 +7,6 @@
 /*
  * Copyright (c) 1997 by Procom Technology,Inc.
  * 		 2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * This program can be redistributed or modified under the terms of the
- * GNU General Public License as published by the Free Software Foundation.
- * This program is distributed without any warranty or implied warranty
- * of merchantability or fitness for a particular purpose.
- *
- * See the GNU General Public License for more details.
  */
 struct llc_sap;
 struct net_device;
-- 
2.43.0

