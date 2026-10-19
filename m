Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792424169;
	b=K4hJO8iR2glNwBdYd19h1fG7qxUKc2/omR0Sj+96BQsCocyP6MATDItg5ZVZ3Dmm3EZy
	 Mp2dBZRYkNOYPTfEa7k55es14azP/r0p8E449FIKLHH0VILddIsaiO6gMMb2KBFLNx5Zk
	 rRdPGDn7AupEtuh8zcffR1bWhhcRgehEsNWT/6V5hX+0NNYITQOYdehuoOr/EFkqyS0LM
	 8Wm7Xyq2SJStJOIabsAAvwV2o6fKTFOREHUeKBTDS9TwZcTVBYb1Sh1TathRlLur3UhIY
	 8i2z4iCs/KtUlTODgMJ1Hm5JefFrdyciRNviownhzIm4b3G0nMlEIzxBydN8X0Cpnyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792424169;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Scanned-By;
	bh=P/5dqfj7vTG/lINlWEYXcU+uCyfa82tRccYJR49wXCs=;
	b=yhU/fC9ppTyb4fPSgrC9w+C4nFbFb06VdCU1hoEwaZKqnJ+yLjU1stcCb3U1wZQgTCyf
	 hVn3zez+mnJpLI2P0AC7pYQnCBMqvFe9S32/3xwG5oXGGNonWaavpWQtxabohMz9WUnwu
	 TW8NwakQmum2UFfW5MJdrlZ5Zq9RwPdWtbpbE0iqhX7C5HT30xmzEo2JzNIYtfYZZRurl
	 4TKzC3xnTP9VfpRQsr6OCZ3hOIqptbZDlWh2qMQP6I5onlC99eM5yeqYyOzEIcklLkWVU
	 p1Qj+g0sPC2Kqv8T6Na3w857fFf2HQh5P4+PpVzxcJUwri4o+uHEneHGg/bRNN4lvQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BQjQ2qX6;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A481607BF3C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 15:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A481607BF3C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BQjQ2qX6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792424168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/5dqfj7vTG/lINlWEYXcU+uCyfa82tRccYJR49wXCs=;
	b=BQjQ2qX6CX3YOJU0XiQraBts3ue+smLic84W6zQXBaxKJZwwztid8d7tO7pDB8ieeEKuP0
	A8hjPcTEF4kho6+wk5UKefZQEovmftdgDsgxbLBiCaIeM4Cd4fKpzoK6M1s3XGasO35395
	YAc4NFdUF2b+Gxg0IgbhrEt9I0B23o4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-18dsTZefNZGqODH-NofnOQ-1; Mon,
 19 Oct 2026 15:36:02 +0000
X-MC-Unique: 18dsTZefNZGqODH-NofnOQ-1
X-Mimecast-MFC-AGG-ID: 18dsTZefNZGqODH-NofnOQ_1792424160
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 383941955F29;
	Mon, 19 Oct 2026 15:36:00 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4839230000E3;
	Mon, 19 Oct 2026 15:35:55 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 19 Oct 2026 17:35:59 +0200 (CEST)
Date: Mon, 19 Oct 2026 17:35:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Joel Granados <joel.granados@kernel.org>,
	Allison Henderson <achender@kernel.org>
Cc: kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	wireguard@lists.zx2c4.com, rds-devel@oss.oracle.com
Subject: Re: [linus:master] [sysctl]  8d75c338f0:
 BUG:KASAN:slab-use-after-free_in_touch_wq_lockdep_map
Message-ID: <atY42k00k0Waj6o4@redhat.com>
References: <202610190310.9737b2e3-lkp@intel.com>
 <atYB0bm9eEXp8A2g@redhat.com>
 <atYW0K3t57puHeLW@hobbes>
 <atYuE1xnVYe0BDG4@redhat.com>
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
In-Reply-To: <atYuE1xnVYe0BDG4@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 10/19, Oleg Nesterov wrote:
>
> But. rds_init() can also fail even if CONFIG_SYSCTL=y, after
> rds_sysctl_init(), so to me this looks like a bug in net/rds/.
>
>
> In any case, I guess net/rds/ init paths should not fail if
> CONFIG_SYSCTL=n ?

So I think that something like the uncompiled/untested patch below makes
sense anyway even if doesn't fix all the potential problems with rds_wq.

What do you think?

Oleg.
---

diff --git a/net/rds/ib_sysctl.c b/net/rds/ib_sysctl.c
index 2af678e71e3c..bccdb5c4df1d 100644
--- a/net/rds/ib_sysctl.c
+++ b/net/rds/ib_sysctl.c
@@ -36,19 +36,10 @@
 
 #include "ib.h"
 
-static struct ctl_table_header *rds_ib_sysctl_hdr;
-
 unsigned long rds_ib_sysctl_max_send_wr = RDS_IB_DEFAULT_SEND_WR;
 unsigned long rds_ib_sysctl_max_recv_wr = RDS_IB_DEFAULT_RECV_WR;
 unsigned long rds_ib_sysctl_max_recv_allocation = (128 * 1024 * 1024) / RDS_FRAG_SIZE;
-static unsigned long rds_ib_sysctl_max_wr_min = 1;
-/* hardware will fail CQ creation long before this */
-static unsigned long rds_ib_sysctl_max_wr_max = (u32)~0;
-
 unsigned long rds_ib_sysctl_max_unsig_wrs = 16;
-static unsigned long rds_ib_sysctl_max_unsig_wr_min = 1;
-static unsigned long rds_ib_sysctl_max_unsig_wr_max = 64;
-
 /*
  * This sysctl does nothing.
  *
@@ -61,6 +52,14 @@ static unsigned long rds_ib_sysctl_max_unsig_wr_max = 64;
  */
 unsigned int rds_ib_sysctl_flow_control = 0;
 
+#ifdef CONFIG_SYSCTL
+static unsigned long rds_ib_sysctl_max_wr_min = 1;
+/* hardware will fail CQ creation long before this */
+static unsigned long rds_ib_sysctl_max_wr_max = (u32)~0;
+
+static unsigned long rds_ib_sysctl_max_unsig_wr_min = 1;
+static unsigned long rds_ib_sysctl_max_unsig_wr_max = 64;
+
 static struct ctl_table rds_ib_sysctl_table[] = {
 	{
 		.procname       = "max_send_wr",
@@ -105,6 +104,8 @@ static struct ctl_table rds_ib_sysctl_table[] = {
 	},
 };
 
+static struct ctl_table_header *rds_ib_sysctl_hdr;
+
 void rds_ib_sysctl_exit(void)
 {
 	if (rds_ib_sysctl_hdr)
@@ -118,3 +119,15 @@ int rds_ib_sysctl_init(void)
 		return -ENOMEM;
 	return 0;
 }
+
+#else
+
+void rds_ib_sysctl_exit(void)
+{
+}
+
+int rds_ib_sysctl_init(void)
+{
+	return 0;
+}
+#endif
diff --git a/net/rds/sysctl.c b/net/rds/sysctl.c
index 025f518a4349..a0673a41633a 100644
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
@@ -107,3 +108,15 @@ int rds_sysctl_init(void)
 		return -ENOMEM;
 	return 0;
 }
+
+#else
+
+void rds_sysctl_exit(void)
+{
+}
+
+int rds_sysctl_init(void)
+{
+	return 0;
+}
+#endif

