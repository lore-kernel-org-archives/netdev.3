Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792856464;
	b=vPe4NO0HmCekPKfoBSukgPsk0HvVJwD3jnGsET0EY9saxBV8sCZQLXvhTj5ZWQaDYz/G
	 woTGqbxDiToec1jkCXcrM8zY4SNODHshgcd3z3psgVAE9CGr2gWurR6YO86weG23Fcu9S
	 RFbhYUC9rMlqOk2wcs2o4amdqCZwMjkv3u5GANDWZ3i16W+uptPIVH0iKmVosswrJS9gP
	 nrQzOAkumzoWw5Dfgi9Gya/8Zn0Y1A7Se6nN6xUxbgHLkA26l7qo7uIL1p31EY0nuVQL8
	 Kns1d9S1+btjQwp6br7YMDBJcfqDLmlwrNNZrIVyQihlqz98aKNS5x6arXlAU+VjJsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792856464;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=ImssELXjcAE6mDwSXJsIaJvMVYb6Z3DgU+RHxX+MS4w=;
	b=nZiMtYQzLF8IFRLJfrWfVkKkoTHFCJEXih2zoxXnf/P9BfL4xxLqrVQ3JZmeV06TEfb/
	 htdas94RUfKwzliGog/oUiq7aSFfAPx5vIqYaOaDW2rxiRUgcfrnL5JFJlY1z+8RJKIrG
	 DCIgYaSChZ9L1WyWeE2C0BnAMIpK1Lirn95Pp0H+4F8kv2rgsrKUkQKhvPJoJkk+gE4ah
	 gtzGmaMeu//4lj2tON1qcybVl/rhLXIdwkLMmamPJWrdjPSzsgUt5NOWbUx37stmaHU4J
	 2xK1p49P4Jvbtuhg7M3MRO/rWougOflBtXsVKtncSJZX7vykSRmYwE8tP9M2FIFmMOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Z/KblFm1";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CA3606A322
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 15:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9CA3606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z/KblFm1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792856462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=ImssELXjcAE6mDwSXJsIaJvMVYb6Z3DgU+RHxX+MS4w=;
	b=Z/KblFm1kZmAh7gHxM8pBAhoOE86pbavQ2rua+hqoYpaTBec9N57hPFgxD1qkbEDqcxOkr
	CmCYLRnOaOexqv2t/cFZ8uzl/Tdnn05LoNGCp7XYPbTThyvADrQJlbfDxBAjVKpCqWkmAc
	1nQmm+KTX7JAekCxVYn0GCyRgwaCL5E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-PzwqWdthOpCI3F291cXvGQ-1; Sat,
 24 Oct 2026 11:40:57 -0400
X-MC-Unique: PzwqWdthOpCI3F291cXvGQ-1
X-Mimecast-MFC-AGG-ID: PzwqWdthOpCI3F291cXvGQ_1792856456
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 141361802641;
	Sat, 24 Oct 2026 15:40:56 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E74AD18002B7;
	Sat, 24 Oct 2026 15:40:53 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Sat, 24 Oct 2026 17:40:55 +0200 (CEST)
Date: Sat, 24 Oct 2026 17:40:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Allison Henderson <achender@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: pabeni@redhat.com, edumazet@google.com, kuba@kernel.org,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH 1/5] net/rds/sysctl.c: move sysctl-only code under
 CONFIG_SYSCTL
Message-ID: <atzRhN_WvQfnJOjv@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atzRTslzb6CAKPKX@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Collect all code used only when CONFIG_SYSCTL=y into a single block and
wrap it in #ifdef CONFIG_SYSCTL. rds_sysctl_init() no longer needs the
IS_ENABLED() check.

Add the corresponding init/exit stubs for the CONFIG_SYSCTL=n case.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 net/rds/sysctl.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/net/rds/sysctl.c b/net/rds/sysctl.c
index 968d6279bbd3..47e8782b1aa3 100644
--- a/net/rds/sysctl.c
+++ b/net/rds/sysctl.c
@@ -36,11 +36,6 @@
 
 #include "rds.h"
 
-static struct ctl_table_header *rds_sysctl_reg_table;
-
-static unsigned long rds_sysctl_reconnect_min = 1;
-static unsigned long rds_sysctl_reconnect_max = ~0UL;
-
 unsigned long rds_sysctl_reconnect_min_jiffies;
 unsigned long rds_sysctl_reconnect_max_jiffies = HZ;
 
@@ -49,6 +44,10 @@ unsigned int  rds_sysctl_max_unacked_bytes = (16 << 20);
 
 unsigned int rds_sysctl_ping_enable = 1;
 
+#ifdef CONFIG_SYSCTL
+static unsigned long rds_sysctl_reconnect_min = 1;
+static unsigned long rds_sysctl_reconnect_max = ~0UL;
+
 static struct ctl_table rds_sysctl_rds_table[] = {
 	{
 		.procname       = "reconnect_min_delay_ms",
@@ -91,6 +90,8 @@ static struct ctl_table rds_sysctl_rds_table[] = {
 	},
 };
 
+static struct ctl_table_header *rds_sysctl_reg_table;
+
 void rds_sysctl_exit(void)
 {
 	unregister_net_sysctl_table(rds_sysctl_reg_table);
@@ -103,7 +104,20 @@ int rds_sysctl_init(void)
 
 	rds_sysctl_reg_table =
 		register_net_sysctl(&init_net, "net/rds", rds_sysctl_rds_table);
-	if (!rds_sysctl_reg_table && IS_ENABLED(CONFIG_SYSCTL))
+	if (!rds_sysctl_reg_table)
 		return -ENOMEM;
 	return 0;
 }
+
+#else
+
+int rds_sysctl_init(void)
+{
+	rds_sysctl_reconnect_min_jiffies = msecs_to_jiffies(1);
+	return 0;
+}
+
+void rds_sysctl_exit(void)
+{
+}
+#endif
-- 
2.55.0

