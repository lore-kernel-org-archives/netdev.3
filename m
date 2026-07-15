Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559042CB14
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113631; cv=none; b=af5pDouIchHdZJZSW3muIWInL1blHW1GvvmntVYkb8S9ufS9J+i2cRvat6ibgC2+crxqvZngaeMK6weWghfesc4jv3R8364bGqzBfszC/7CYbgC3BGkhZZ6vGEoJKFPIP/k0bnS5t2lb+DaOyS46bBXorq+5V35eEoYPlP3uyco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113631; c=relaxed/simple;
	bh=R2DtYEfB8e5iG1EEJO/C2CCkLxu30v1Tnylhyx1tKO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YfKWFaFo0mZXLLqpmOR1VrLLCrqfc7/MmfXA/um381lSQP+NrStb/0IXcHkezPKp8c3+GRRaPUz4o4LZy29QpPBIUH1/PwzJNOcbzndor88bu32yy81zIhAqm2ygg4s89tKmW2es7bZumhfd8L9A0aqWKF/ko6r8L9sA0k56J8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DuupavuY; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DuupavuY"
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-8423f236418so1636049b3a.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 04:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784113630; x=1784718430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A2naLAXXujVMKwya9tA4UgNbI68wM8xmyh040OegU64=;
        b=Sr8pRafPlUX1Qho9g6a9ZwzV2AqM4LZQ94nbfFjMhANVI7sMWf0J75ykiUb0s3Ce9Q
         LqrFyVPx5lPJC8hkLJWzrjX0uqb0lhAfP+nq9RYk6C+vieINuD93At4PjrAb8Lzoi72J
         Gc+l90ZELHG7PJbIp+wqS+/5b5o8h7UBreibarIqUUxg6fdCM/WF+J0zgq4YuJZd2Go+
         XSpvxkL33MbEETsj66t5G35EYVIRxhPrtvTFd0x+7R5bqynkTYoB3C40x9GqyNEb40hS
         EAbAu4uIfy5h2CY+d1JTIc5xjBbafoJy+NogzJ43qDQE1Jc0nywpoWt9j7lTKjY8Yre9
         +PYw==
X-Forwarded-Encrypted: i=1; AHgh+Rpa013RakxC/gm9aD1AkixSxtjeURMLbKOyQjYMvfztVrBlVjlS2hIxddGCIawL4x9vW376o60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTDB78cT0HXRMB/vcnE08kceyeKjbyaZaCMRtFGm3wHN4qvld
	Ngn0YDMeMj9ph2Nlr8lLLtwtUXP1TKTRvj/gC/ytNmfQeF0DfaqG+nsDEyDdSGQsLhBhpdmvgZ1
	x3LenIMPJpdmaJioqHi+51EkTZ4E7PFLlr8jGD9/c9GDfH39rJOkgre4DdDrQzue6exDzer3J0N
	KOx/C9Dr66VBHLKy9643upbPHrXvdxMS2Y114XQpRbFyj+1ZhKbJipwKlxCkebmXAQIj7380BIj
	fBsHcZqRIiR
X-Gm-Gg: AfdE7ckw+BsLuyK1wTRzHnc+smjuu6QQXLulbPBd6zxkBnoBpFghC+JvoGJdNoJOFV1
	vS2JjulV4IbNxsuLoH0BhdvGF6jRJPchTgXwos18XzjBFzqDVnX5Iv0VnjqDvZkyMdmZH1dekXz
	Zof1fZxtomkIuBt2tWF3BxJxoO3PdnVtPQION/JXPYiPiXdyH2KIPTo5nWuIeZBseBbvf5UZXzW
	Cmb7pc6/M2a+tVomUiWd5Cc7Jsg8ADnVVGqE8siIOclKBCuKkEF8uFXbzVPrbP8Sl844I2ydk1J
	v/dFc7LBlF0N/n5dQ10o92VHYvX414lDN2Ny/vNRMl03LHU+jRoqYF7vN3vwQWMWyezts2GWd57
	Oo1MBkxNb0o5JlogMkgQ4iBFcq5aA/vmKuQkYdiBxE2jYEthG+gEmYL0QDtuL53wP2SlYRxhV4y
	kXWQ5oUUB8SUafpV1/99v3ipsM/eNAcqhpSncTeuqPt0kj
X-Received: by 2002:a05:6a00:94c8:b0:847:759e:f61c with SMTP id d2e1a72fcca58-848896bacb9mr14920117b3a.47.1784113629585;
        Wed, 15 Jul 2026 04:07:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-84a5c518a3fsm341763b3a.7.2026.07.15.04.07.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2026 04:07:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e632390d2so374805185a.3
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784113628; x=1784718428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A2naLAXXujVMKwya9tA4UgNbI68wM8xmyh040OegU64=;
        b=DuupavuYgufDMS/lBSOQKsdxlURyXQZ8lXoHdg69AITYhD0ZqwbqEK16TXUZKGq0Ls
         qXpY8hfbc+pDzCd3tn/GucNLmJLuRnAy86YR+jcNYDTAMF25fFggxq3vN3ElDhmtjFOY
         maiuQjvWJmnoRrqvPude//2fYxVVsZssq0rXo=
X-Forwarded-Encrypted: i=1; AHgh+Rom4f396bq2O7OOp5beF1C+AenNmPXTXECkf1AXm/q7ppYS8mL5S1U+YmTMcX7rlY9UYOt4sIQ=@vger.kernel.org
X-Received: by 2002:a05:620a:4693:b0:92e:604f:909a with SMTP id af79cd13be357-92ef2b2f794mr1763083385a.29.1784113628126;
        Wed, 15 Jul 2026 04:07:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4693:b0:92e:604f:909a with SMTP id af79cd13be357-92ef2b2f794mr1763078285a.29.1784113627564;
        Wed, 15 Jul 2026 04:07:07 -0700 (PDT)
Received: from lvnvda4076.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d37540sm1675346485a.38.2026.07.15.04.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 04:07:06 -0700 (PDT)
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
Subject: [PATCH net v3] psp: fix NULL genl_sock deref race with concurrent netns teardown
Date: Wed, 15 Jul 2026 04:07:01 -0700
Message-ID: <20260715110701.3775026-1-kiran.kella@broadcom.com>
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

Both the main_net path (derived from psd->main_netdev) and each
assoc_net entry in psd->assoc_dev_list are affected.

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
Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
Tested-by: Daniel Zahka <daniel.zahka@gmail.com>
Reviewed-by: Wei Wang <weibunny@fb.com>
Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
---
v3:
 Fixed typo in the commit log

v2:
 - get rid of the extra struct net *net, by doing
(!maybe_get_net(assoc_net)) directly (as suggested by Daniel Zahka)

v1: https://lore.kernel.org/all/20260703112431.2860506-1-kiran.kella@broadcom.com/

 net/psp/psp_nl.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 9610d8c456ff..1438dbb07949 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -62,7 +62,10 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned int group,
 	struct net *main_net;
 	struct sk_buff *ntf;
 
-	main_net = dev_net(psd->main_netdev);
+	main_net = maybe_get_net(dev_net(psd->main_netdev));
+	if (!main_net)
+		return;
+
 	xa_init(&sent_nets);
 
 	list_for_each_entry(entry, &psd->assoc_dev_list, dev_list) {
@@ -77,21 +80,23 @@ psp_nl_multicast_per_ns(struct psp_dev *psd, unsigned int group,
 		if (ret == -EBUSY)
 			continue;
 
-		ntf = build_ntf(psd, assoc_net, ctx);
-		if (!ntf)
+		if (!maybe_get_net(assoc_net))
 			continue;
 
-		genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf, 0,
-					group, GFP_KERNEL);
+		ntf = build_ntf(psd, assoc_net, ctx);
+		if (ntf)
+			genlmsg_multicast_netns(&psp_nl_family, assoc_net, ntf,
+						0, group, GFP_KERNEL);
+		put_net(assoc_net);
 	}
 	xa_destroy(&sent_nets);
 
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

