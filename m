Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4E1290DBB
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249954; cv=none; b=ZhIbEWBtSiP5CmqWDuMko1BZLBKbjihfjVtvdk4dZ4K7QDWiwnWmaZk8dh8KmcfMBT2/YnrIrWdwiAgT2vBgTwOHE7+tehJKlgFe6H+1Emg1w1LaWajQMfDPymxXpSuuL2SXNHol0P4wfqOk+HXiAMTjzisOy4Lpn+eP/17KCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249954; c=relaxed/simple;
	bh=kqYs482WFY46q7KpNwPM4K3CeK+5fOx+6sZ6nE4D9Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATDQEzS/cA/GCr1IUVcPEe07wTfMxwZLEdPW47ySG4fDeWTXV1rPAdtgKO6Uv4YGvHIEirlGBmqqMBADcVw1+/l9E+msFhooAXp7mVKqnMtPTpspVG858101gVRTjgp98S75PbOKBGz+pF2QlfqDsf0EGtVX24rmMWRwrk6ANVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBE4CG55; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBE4CG55"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so17104555e9.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775249952; x=1775854752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PC6QSIaCKHRw04W5RZeL/4jeRdbgtJ8aXjIrqAGfS2c=;
        b=dBE4CG55oJU4skkB0N1F6ZGedSw9a0i0B5D6KUGu0YFmN3X0zxdmmerqUp8UFMWMpo
         d0kExpCFgbmRzYlYvmbM70tM/HUAhlYHPDHKiLA80bH5/Z18zK1hiAKaZG++E49wtleD
         k63gW05g8SdtedyJYkzuRlkzyaQHvHayeJl9tSeReu3Zk1ezWtV1CdfUq/VnNZsy2xM3
         j0JOhhbvNmwW2YCiCqSGLneD/Fz+JPNpE6tzR395C+pjHfik3ICkH3Up0ypSVck+Qcrt
         eraGrCez0eaFQv4mjTXtWhbBN8L65IXkNY38kQc2GNY92AJQM62V2Dwkp8y8fEoqKxdC
         CkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775249952; x=1775854752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC6QSIaCKHRw04W5RZeL/4jeRdbgtJ8aXjIrqAGfS2c=;
        b=g1FvY/BlsE5L6dFKe+PD1XpIGgbfuEPtnKs2kJMnicnT0W0MQgl3mGj5ZqOs/lPAIc
         BDMdjTMGQ41hOZXZMK6GXwTSiU8tvl2Za0uTKibWDBMQjxLcqbUssffNXrOAHL/RLCPF
         /l+E4cqZgGZ0OJknhrtOJ9IdVA7MJQIXZeSb2dB1ReskdI+8sf8c6IZfNWM3ScH1yjUy
         OrLFNlrrcWlBdAbZZDALza1i7K+Uxm9MVvWMlhmTNQXh7X8BxrbuaSjAH73umQ+pX09E
         T4ftVmEQO1PGSD79vLViW+/Jd+EhNnb/iZ7Xi49bX9e32ubvGvC8rwXFiRoISSOWIkSG
         jq/g==
X-Forwarded-Encrypted: i=1; AJvYcCUxc9yL8CCG8Gijq8mQwoi8dRLhfxe7VYAve0AEzxcZmN/+Dj0HR5dfKFPGuCLBHtw7BMQWUGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaBYh1SckJnovvR23BDx4l+mGyv+nJhssjh4q3oVrDXbvCdb/4
	VSxaLvvuvYmc/F5IVlEkeXGpigEOEtr6Lh9WTgAeEhj2tARSZYaAlmV1
X-Gm-Gg: ATEYQzzcAaexWI7aiYGtmAQ2v5JqX5xFubRQijFPbnSu/Mxt7jMPpA26Ntnv340JcxY
	VPV+ozDkCPAKvUhsKuI/S8u6+U07TeyQAlSKYO9+B+J+KC3re/MTZ7y26zSuO6YgUA8HhThN7SS
	wcyZW7NWN8YWDpg1j1FdsXAsDnvw2GNQTmSsOGggb0+FwzCzJXPD27KfSIGJSa/onH1mQ8pHjqv
	XjcGxwJvbC9VD2O1ug09DO0EBQju2xl82bi3g7BCn+IkC+Oeaq4mq14kbIPkiGJB2WrI2p0BUqH
	5z/PK1DcP+4MHqwcDSdamFfGRGDaSu0pE599iv5I283WVCuZgvAQ7CeEg5MK1gvFy0eHqHAmBTS
	xWVzVUxToaBv0ozpfjXqP/Nnfv8SP/KwJiUlDze8yE/DY/rF2FXWRTh8Nqp0tvv/FRNBy6n2/8P
	nda5WwgtiuO0FEAHSF+8sWH+IyucXz8VQP4UcKpIv6MIx0VTa7Q2DbR3OXLZyN9cxynWUn8hd87
	l3Mt3m7OMuqeAkkmL0nu3kTiW+HLtrzYZd/gsszuqePjpBUi/s=
X-Received: by 2002:a05:600c:450d:b0:485:3428:774c with SMTP id 5b1f17b1804b1-4889946a42dmr64393995e9.4.1775249951503;
        Fri, 03 Apr 2026 13:59:11 -0700 (PDT)
Received: from localhost.localdomain (cpe-188-129-81-72.dynamic.amis.hr. [188.129.81.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48893f39027sm104356165e9.2.2026.04.03.13.59.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Apr 2026 13:59:11 -0700 (PDT)
From: Marino Dzalto <marino.dzalto@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: jacob.e.keller@intel.com,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marino Dzalto <marino.dzalto@gmail.com>
Subject: [PATCH v3] netfilter: xt_HL: add pr_fmt and checkentry validation
Date: Fri,  3 Apr 2026 22:59:07 +0200
Message-ID: <20260403205907.92749-1-marino.dzalto@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pr_fmt to prefix log messages with the module name for
easier debugging in dmesg.

Add checkentry functions for IPv4 (ttl_mt_check) and IPv6
(hl_mt6_check) to validate the match mode at rule registration
time, rejecting invalid modes with -EINVAL.

Signed-off-by: Marino Dzalto <marino.dzalto@gmail.com>
---
v3: Remove mention of NULL checks from commit message, as they
    were never part of the original code.
v2: Remove NULL checks for skb as suggested by Florian Westphal
    (skb is guaranteed non-NULL by netfilter core). Move mode
    validation to checkentry functions instead of match function,
    also as suggested by Florian Westphal.
---
 net/netfilter/xt_hl.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/netfilter/xt_hl.c b/net/netfilter/xt_hl.c
index c1a70f8f0441..4a12a757ecbf 100644
--- a/net/netfilter/xt_hl.c
+++ b/net/netfilter/xt_hl.c
@@ -6,6 +6,7 @@
  * Hop Limit matching module
  * (C) 2001-2002 Maciej Soltysiak <solt@dns.toxicfilms.tv>
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/ip.h>
 #include <linux/ipv6.h>
@@ -22,6 +23,18 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS("ipt_ttl");
 MODULE_ALIAS("ip6t_hl");
 
+static int ttl_mt_check(const struct xt_mtchk_param *par)
+{
+	const struct ipt_ttl_info *info = par->matchinfo;
+
+	if (info->mode > IPT_TTL_GT) {
+		pr_err("Unknown TTL match mode: %d\n", info->mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool ttl_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct ipt_ttl_info *info = par->matchinfo;
@@ -41,6 +54,18 @@ static bool ttl_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	return false;
 }
 
+static int hl_mt6_check(const struct xt_mtchk_param *par)
+{
+	const struct ip6t_hl_info *info = par->matchinfo;
+
+	if (info->mode > IP6T_HL_GT) {
+		pr_err("Unknown Hop Limit match mode: %d\n", info->mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static bool hl_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct ip6t_hl_info *info = par->matchinfo;
@@ -65,6 +90,7 @@ static struct xt_match hl_mt_reg[] __read_mostly = {
 		.name       = "ttl",
 		.revision   = 0,
 		.family     = NFPROTO_IPV4,
+		.checkentry = ttl_mt_check,
 		.match      = ttl_mt,
 		.matchsize  = sizeof(struct ipt_ttl_info),
 		.me         = THIS_MODULE,
@@ -73,6 +99,7 @@ static struct xt_match hl_mt_reg[] __read_mostly = {
 		.name       = "hl",
 		.revision   = 0,
 		.family     = NFPROTO_IPV6,
+		.checkentry = hl_mt6_check,
 		.match      = hl_mt6,
 		.matchsize  = sizeof(struct ip6t_hl_info),
 		.me         = THIS_MODULE,
-- 
2.50.1 (Apple Git-155)

