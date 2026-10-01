Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61FC3655E4
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877767; cv=none; b=CPc/c8gMDPiHtdUjdEaqLajnet3S/ka5hq86h0Pm7SFTNY+L59skTZcmn4CG7bOz0zAmNFezeb9FFOtKNjs/b7XMXAUX0zHCrL2xsqWMlinjVa2q9/QOVXZWHXcH6MFKvcWPV8tszVE/C8UhGBBbwdi6U9tLocR15laF1PSOfaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877767; c=relaxed/simple;
	bh=wMs6vW86I8zfsm+tLyJQj3t0n3d+3Hy54v7gPa84fk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OA42eFhYcabeMHEAzCZvu6skqKXThiUkV/fetdkSA9zHRFWnuv9KxkxvYQkNReEjs8Sksgx5mNY4l2eLBsLZYI4fEdWB+FHaftayrmDk4VoW4i8TGSvPUHVPl9uQ+fZHqSNvC5GTxVSqG0LwACUTKHFsrRtPFGvaXYkfgoAXNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lV7CXU3T; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lV7CXU3T"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so4077288a91.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790877757; x=1791482557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JwsI/5Y1lBQd0B/lyvICZESjhXRO4PckWvccwc02nPU=;
        b=lV7CXU3TDWWfJ1mmQ4WBfwQKi5cwo1gPGYvamB3udVKXvSg+d38klHVEsaujma/JZP
         RwLpQGl+BdIFPWjMHn32LuMKQ3ClDcb9zdI+sNepizNjjrh40zV64p0HasbLb3qnhQpp
         RUCA6yoDNuMVNjMUW3RwF4h6AzQmx2+Wq4YD52Ij3I+7UZSWPWE44E2LL2CtCDWbtxA3
         e/D5+TE1mIXIv+KjtWTWzvPa4MI8K1PSkKOsZ1MPrkGHvnsjQ/ETr+ZxjXRRCfn48gZI
         FTR2rUQW72dQpkfl5w7KDpojhPASmH3bZ+8GFsQmc1j0nMlq+AfYE6+BkZquoIf1+1Sp
         vqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790877757; x=1791482557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JwsI/5Y1lBQd0B/lyvICZESjhXRO4PckWvccwc02nPU=;
        b=CQ0Don9E+QfGHDPuqIIymCmS7lds3HjIAnZ2Yyh3Vod4va3fDSyUlSkEjahehNGn3j
         KLDGw6wTO2ayz9CwbewRIsacQnGM0sv2lVtiJ+nauoEnVneptx6snPht+86chEUnY0sl
         AUgfAl1eoS+WKpQjyt2x/PkYBP5xjs1ay6YMUFHrU2ukhnISh9TFMuHZFRpNpV3qMLW2
         VJaic2rdoaS8fxA3A85OjqX0L6xyHP30CGg7+coLCsrTrD0SayzhKDeQxbyUUTgfQWwq
         kKh0cQZ82o2Ko/PN/tUztISlfJL9lBMqnbqm2TeDnxhMZY0x9aSWmJC+Ueg2vzNm96zL
         56vg==
X-Forwarded-Encrypted: i=1; AKwUvBz9Tamm2jXizjLv7rpTmTqDrCf91Q15rheQSsMhvD6jTg5UhhV1Dku06oYrlt0kbOMmKFQXP6c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJP/lGOHMMvTxbWxqHyYsz9inpn2DofmS10ZR6zPq+6aTpVQ5Io
	SMQE0yRfRCTldhFEsFaxYBqT9jXuI/aXTR/xnfoHzwI/PRUudFgn/CNL
X-Gm-Gg: AYBFou3L6CauEub29WTfrBDnEZoPv3SVq19Ri44buB+LNS6lZQuP+jCsmB6rVUbAxh9
	VmY5pVIRnSLrKSU1d8StQYP4C8yDaSngPjeUDQEMveUKhaMSOyVs8BPR85/ZkAmavy8/5j6qWlo
	0JAjlkXS5uW58pvNAKizwkjFJuUWPJAY2Ysa84Ax6KpUFTSCAy9j7vhC+NrBHOBnyB97PnbOnIZ
	crx8HbFnwGoGYtOW7PyxrJPjqIoGTh+twXcdp1aQWfxIuiTRo46BOK4zm+d9JRErMD+tHD5CDHh
	KPhTSi3//NwDaFZ8H/HDTCv/YmM5qhrLYDKQhOwFt7FwnHzECTCNW8UWqoxodRm8UYT74QfwaZQ
	ZrzcmINKA+GUQ/H/w1VRPqsXRXI3Bw+Mgbmv5QuHlUj7CiOIZyoNucc3SPpSaF1QIPLAMDAwSrz
	nag8qx4WGuTb9iRNtyszVjG74eXagI/NeBRApfKFRv/nNYb5gSrxEpZPb+UqG4fYqXmMyD+ZUP5
	2c3xljdnDg=
X-Received: by 2002:a17:90a:dfc5:b0:3a0:e476:576b with SMTP id 98e67ed59e1d1-3a6ce7c072emr312864a91.37.1790877757241;
        Thu, 01 Oct 2026 11:02:37 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f439f9f9sm5502805a91.1.2026.10.01.11.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:02:36 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: pablo@netfilter.org,
	fw@strlen.de
Cc: phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] netfilter: conntrack: avoid recursive master destruction
Date: Fri,  2 Oct 2026 03:02:24 +0900
Message-ID: <20261001180224.1018290-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conntrack entries created through ctnetlink can reference another
confirmed entry as their master.  There is no limit on the resulting
chain depth.

When the last external reference to such a chain is dropped,
nf_ct_destroy() puts the master reference.  If that is the master's last
reference, nf_ct_put() invokes nf_ct_destroy() recursively.  A sufficiently
long chain therefore exhausts the task stack.

Release the master reference directly.  When it was the final reference,
continue destroying it in the current invocation.  This keeps the existing
refcount and lifetime rules while bounding stack use.

Fixes: 5faa1f4cb5a1 ("[NETFILTER]: nf_conntrack_netlink: add support to related connections")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Tested on net e23a64eb244356ee47c0620f0722d51bd88db522 and exact
v6.12.105. A source reproducer and userns launcher are available privately
on request and are intentionally omitted from this public posting.

The trigger needs CONFIG_USER_NS, CONFIG_NET_NS, CONFIG_NF_CONNTRACK and
CONFIG_NF_CT_NETLINK. Host UID 65534 used only namespace-local
CAP_NET_ADMIN. The essential vulnerable trace is:

  BUG: TASK stack guard page was hit at ffffc90001197ff8
  CPU: 1 UID: 65534 PID: 178 Comm: conntrack-maste
  nf_ct_destroy+0x1ac/0x5f0 (repeated)

Fixed current and LTS 6,000-entry runs ended with nf_conntrack_count=0 and
no crash marker. The netdev allyesconfig and allmodconfig W=1 full builds
were not run.

 net/netfilter/nf_conntrack_core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index d0d9e5ea84a09..0ce6141b3dfd7 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -592,6 +592,10 @@ static void warn_on_keymap_list_leak(const struct net *net)
 void nf_ct_destroy(struct nf_conntrack *nfct)
 {
 	struct nf_conn *ct = (struct nf_conn *)nfct;
+	struct nf_conn *master;
+	bool destroy_master;
+
+again:
 
 	WARN_ON(refcount_read(&nfct->use) != 0);
 
@@ -610,10 +614,17 @@ void nf_ct_destroy(struct nf_conntrack *nfct)
 	 */
 	nf_ct_remove_expectations(ct);
 
-	if (ct->master)
-		nf_ct_put(ct->master);
+	master = ct->master;
+	destroy_master = master &&
+		refcount_dec_and_test(&master->ct_general.use);
 
 	nf_conntrack_free(ct);
+
+	if (destroy_master) {
+		ct = master;
+		nfct = &ct->ct_general;
+		goto again;
+	}
 }
 EXPORT_SYMBOL(nf_ct_destroy);
 
-- 
2.55.0
