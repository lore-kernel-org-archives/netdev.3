Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86C346E7D
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147403; cv=none; b=hHFmXzKkVPVhf5Mo8Jm0m70wygv3/G+W0tlHz4Bgk/1J2QI58B2MAMMscFQzIEEQN5Z5cY0KNF7ooTcr/F67G0nNOGccc4n0EIbux3ac0kxaMGcjma4MuBRF9uH58EjT5Lcl85MqMWqGc33WeJLVi83edl+0zW1Sc+jbNMzToc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147403; c=relaxed/simple;
	bh=xg416wZWycPdqeh1Em1LGsWC/Ld+2UysN2Am1AH6zxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lXTuxqjHsYcvB2uEApc66s/c7OgHWpGFVo8OkWBfxBxiSC6wKSYQyF94EIWxGbhExupThsNGzoCb0kuS7P4F63bnMitzk+Q+txWWXxPWzOdhtvHCmjdAsDdR/+vQnpK9lhBSaC/IPtI6vOtgHmBoXoTFpEjZYwsXkCQ3DtT5PAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B7Wdd3HT; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B7Wdd3HT"
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-8ee88fce572so25678436d6.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 03:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785147401; x=1785752201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EXnlR8dRlG9FnR4UHV3rtVsyPMP4PaYSGN0799YN8n4=;
        b=YWj+LA8bb5t1OXoT7goeYkG3Cc1zMTRTLqHoaPepCSnJt91o6hzR8sVM034/5YUUe1
         JxXmItW4pcPvMB5IIr/32ym6gqZ4UfM82rj276v3YaVbgOsCIKXO/1ufaX5oAAkXQYmt
         ScCM+Ic2uc16JjFYP3BYAeu4WBQxPgh7jpTrhWCLBLErOx1B6hgIsXRujUlSo1xlvWQb
         QADcgRO1LWWJsoCe9Y9gydVjmgKgRokFmu32hv4/bp5sXOiZE94BVQ8ZPxXkHOphfz7j
         td0YvGtxZzuiHdjO1JFPDGestz34CAgDOk31g5wruOZ00SEU55oLv0omzf77ZaczTmsu
         Uh7A==
X-Forwarded-Encrypted: i=1; AHgh+RohmvjJFiX1JWdrs6LHf2ZO/zGG8xuksCZs+GEcc/ph0PlS+qmpweKNtbFVR/fIQiCg2QMPfKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZXFf19DkG7H0sxxIHsnNF2DoZN4axLLUOzfve1sqfk02y5af
	7IMKMWt0aZ35p92G4qSF2ZHlt3j/XNZQOqFA27MyhqszGYe1Jf50k0D2c+W5WFofoddG03i40jy
	UZRhTCBqXEUI7K8i346RuHTEhvuWfMpzcit38s3L1kmHQDAHLHRlXwPPxjq+qKEn4mk4Mb1tKhC
	VPjZHWi0LO6qmvq/AAWiJANrgwUK0OMUc9I86x5VbTtL8K+8dgolrlCxkMlwO8Cv+AoKXFqBX+J
	Aa9ZKTk42/J
X-Gm-Gg: AR+sD123hnHUHFw/j1Nwu40URVcdEEM3J5LXzdmUY1ZfUFaLd08XErQCcpSW1rRDXZW
	4dD6FRMx0pFAtPl+YPeHB3+o/T48wZVfl8lbIfkfILQezagMLiF2cI5TsU46Y7xpP3uhcnDCLvP
	bM9AuD4kWwPG39JKNyjGyrZSo+HsA4/qpZKdYxkRb6cTI6lYHh2OBhFQCPlGOBNDqpCdowRpsnV
	6EfnInHgWicDHWE9/QDHlpRY+R6GaOPZooMdiQ/CZsFIC1NavvtPw/jQTzFwITDRyXw8Nz+OYR8
	0XE70B7KyJK8l/Vj7fQLAdyRQhsddDf5DUSzUdsiaQHWHdCMAN3DEmn4YHlMpbh8X3egc8VPyMA
	rPuUmc4ypFrWmUM8uZ0o3q3ie48514XEMb+2XwoIyWPwsGics0nvefb8XyIPjjDZyAOqvHlCBwE
	6oxUjtks+VoQj7Xk1bNp33JbFb7tOYvlZ/bw==
X-Received: by 2002:a05:6214:2b92:b0:907:94e6:f8bc with SMTP id 6a1803df08f44-907ec76ac52mr102226726d6.15.1785147400766;
        Mon, 27 Jul 2026 03:16:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-73.dlp.protect.broadcom.com. [144.49.247.73])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-907e851aadasm4292616d6.6.2026.07.27.03.16.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2026 03:16:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e9a2b95b5so446333485a.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 03:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785147400; x=1785752200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EXnlR8dRlG9FnR4UHV3rtVsyPMP4PaYSGN0799YN8n4=;
        b=B7Wdd3HTuNPjjKpxxV5x2L3WoQMwMgjFF2SUiZMnueqR5rQzmHgjiwXMOO8tV3KqNH
         9bfq4UvxODR/BRIVx/X2iVcIkGVwzua3LjA8hr0WqDAL8wY2XrJd/E5TMVaAiE75wFn7
         U0M77NzcMArMp3oyQb6UgF6N7K+2XDLP20iTg=
X-Forwarded-Encrypted: i=1; AHgh+RqqqKY9WnTv+iKPHZN48bDb8SWBiUdRcXszlTM/czu5XUFveV839AxL+THkQhiF+pIIdMHKFno=@vger.kernel.org
X-Received: by 2002:a05:620a:2a09:b0:932:d9c4:3bec with SMTP id af79cd13be357-932df6bbcfbmr775938685a.38.1785147400047;
        Mon, 27 Jul 2026 03:16:40 -0700 (PDT)
X-Received: by 2002:a05:620a:2a09:b0:932:d9c4:3bec with SMTP id af79cd13be357-932df6bbcfbmr775935285a.38.1785147399559;
        Mon, 27 Jul 2026 03:16:39 -0700 (PDT)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de51a7cbsm587994185a.8.2026.07.27.03.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 03:16:39 -0700 (PDT)
From: Kiran Kella <kiran.kella@broadcom.com>
To: daniel.zahka@gmail.com,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	weibunny@fb.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	akhilesh.samineni@broadcom.com,
	Kiran Kella <kiran.kella@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net v4] psp: fix NULL genl_sock deref race with concurrent netns teardown
Date: Mon, 27 Jul 2026 03:16:28 -0700
Message-ID: <20260727101628.502042-1-kiran.kella@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The race occurs between network namespace removal and PSP device
unregistration.  When a netns is deleted while a PSP device associated
with that netns is concurrently being removed, psp_dev_unregister()
triggers psp_nl_notify_dev() to send a device change notification.
Concurrently, cleanup_net() running in the netns workqueue calls
genl_pernet_exit(), which sets net->genl_sock to NULL. If
genl_pernet_exit() wins the race, two sites in psp_nl_multicast_per_ns()
then dereference the NULL socket and crash:

CPU 0 (netns teardown)       CPU 1 (PSP device unregister)
======================       =============================
cleanup_net [workqueue]
  genl_pernet_exit()         psp_dev_unregister()
    net->genl_sock = NULL      psp_nl_notify_dev()
                                 psp_nl_multicast_per_ns()
                                   build_ntf()
                                     -> netlink_has_listeners(NULL)
                                     /* crash */
                                   genlmsg_multicast_netns()
                                     -> nlmsg_multicast_filtered(NULL)
                                     /* crash */

Fix by replacing the bare dev_net() calls with maybe_get_net().
maybe_get_net() returns NULL if the namespace is already dying.
Holding the reference ensures genl_sock remains valid across both the
build_ntf() and genlmsg_multicast_netns() calls.

Fixes: 00c94ca2b99e ("psp: base PSP device support")
Fixes: 06c2dce2d0f6 ("psp: add new netlink cmd for dev-assoc and dev-disassoc")
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
---
v4:
  Fixes done based on feedback from Jakub Kicinski
   - maybe_get_net() logic removed for assoc_dev_list
   - Added RCU protection on main netns before invoking maybe_get_net()

v3:
  Fixed typo in the commit log
  https://lore.kernel.org/all/20260715110701.3775026-1-kiran.kella@broadcom.com/

v2:
  get rid of the extra struct net *net, by doing
  (!maybe_get_net(assoc_net)) directly (as suggested by Daniel Zahka)
  https://lore.kernel.org/all/20260707185937.3177211-1-kiran.kella@broadcom.com/

v1: https://lore.kernel.org/all/20260703112431.2860506-1-kiran.kella@broadcom.com/

 net/psp/psp_nl.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 9610d8c456ff..43b066353c65 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -62,7 +62,14 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned int group,
 	struct net *main_net;
 	struct sk_buff *ntf;
 
-	main_net = dev_net(psd->main_netdev);
+	/* device may be changing netns in parallel */
+	rcu_read_lock();
+	main_net = maybe_get_net(dev_net_rcu(psd->main_netdev));
+	rcu_read_unlock();
+
+	if (!main_net)
+		return;
+
 	xa_init(&sent_nets);
 
 	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
@@ -88,10 +95,10 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned int group,
 
 	/* Send to main device netns */
 	ntf = build_ntf(psd, main_net, ctx);
-	if (!ntf)
-		return;
-	genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
-				GFP_KERNEL);
+	if (ntf)
+		genlmsg_multicast_netns(&psp_nl_family, main_net, ntf, 0, group,
+					GFP_KERNEL);
+	put_net(main_net);
 }
 
 static struct sk_buff *psp_nl_clone_ntf(struct psp_dev *psd, struct net *net,
-- 
2.54.0

