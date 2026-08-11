Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417B3603F8;
	Tue, 11 Aug 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448757; cv=none; b=QFiiPLni40ZIFaNIpdKv/yNY0sUS42HmWCMG+4WJ+QbmzjC6N7RpGRF/aaoohsMIaIefSP4wnQA+8YG7DVjXNXTkFynpbeaj71I14Prmo+RRm+cdCx5P2H/f1rOhFZx/8s4dl8LJazM1nYLq4X8zsF7TysuP0xLJcdtzBPS3Dho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448757; c=relaxed/simple;
	bh=une3Jz7mmYJxLNfmJT5dY1vwBR13DWmia6kGVSZevmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJx8Vz5CYE19909I8C/eVjufBiIpanSNjwJiCSfGxYIE/gb+l7udJhrgVvZgiY5Il/R4fyUMgU8FhyNs0ttku1E+Mi3W32x6N/0w5OFvW7yXa377eeYfvgdEQCkNFDG7lTCtpyaLlU2ifu7QOKXskqd0QnFqSwOIwFhlcMqFqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuFIo6Uz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuFIo6Uz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A7FFC2BCF6;
	Tue, 11 Aug 2026 11:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786448756;
	bh=une3Jz7mmYJxLNfmJT5dY1vwBR13DWmia6kGVSZevmM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DuFIo6UzZTPXIsmy4k25Nnf+NwIU1Ny56c4oH23/w9khzxJ+Z+owGgaKXTRWY+89c
	 Xc5/MG5lNeoDci26iV6bTXwjdaeoFfSK1u/vFwLYyQY/7cJaxWoXtpaeR4EDT/iIVJ
	 7k4IrqQ+Vi9RN2L/sbo4ha08ZiN5jsGEQH3aUjxk4pAc7uItcAharfVHlgAN1EpehF
	 Eu1l9+2RLm9FAbyGn0UPgojkLLxctfjMEgMiaLtne2miC4WppEUy44Yg8KrkaLjqU0
	 kcNJPxe20VqgYvzb6Z9ox/mSPi+7mX1uGlkBHfkMcmKB9vZS3x4Zd/fjdXD5SRPQsD
	 LAecZrj3APyFA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B69C5B56A;
	Tue, 11 Aug 2026 11:45:56 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Date: Tue, 11 Aug 2026 13:45:47 +0200
Subject: [PATCH net-next v8 1/3] net/sched: cbs: add extack to struct
 tc_cbs_qopt_offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-net-next-mv88e6xxx-cbs-v8-1-10d0baab2905@luminex.be>
References: <20260811-net-next-mv88e6xxx-cbs-v8-0-10d0baab2905@luminex.be>
In-Reply-To: <20260811-net-next-mv88e6xxx-cbs-v8-0-10d0baab2905@luminex.be>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luke Howard <lukeh@padl.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786448754; l=1288;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=aNoIWhFNHrFQcCZfGOBB7BByzBoikUxu5dgW0xHObus=;
 b=eYcjP2tH+oPltczi2zPEVpvlrxZi/b8CgfAogNIgpdatuzALLD0WbWedHb6jOGXVpbqfJGUVu
 6mW+tPhQHM2BcZLq2xEmw7eudDCM5o27KlNkVJa09M0qjQ4Waiow9jA
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be

From: Cedric Jehasse <cedric.jehasse@luminex.be>

To be able to report reason for rejection when cbs offloading fails.

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
 include/net/pkt_sched.h | 1 +
 net/sched/sch_cbs.c     | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 18a419cd9d949..d35c87004c279 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -150,6 +150,7 @@ struct tc_cbs_qopt_offload {
 	s32 locredit;
 	s32 idleslope;
 	s32 sendslope;
+	struct netlink_ext_ack *extack;
 };
 
 struct tc_etf_qopt_offload {
diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 1c93469c56e3d..87c2eda108c8c 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -307,10 +307,12 @@ static int cbs_enable_offload(struct net_device *dev, struct cbs_sched_data *q,
 	cbs.locredit = opt->locredit;
 	cbs.idleslope = opt->idleslope;
 	cbs.sendslope = opt->sendslope;
+	cbs.extack = extack;
 
 	err = ops->ndo_setup_tc(dev, TC_SETUP_QDISC_CBS, &cbs);
 	if (err < 0) {
-		NL_SET_ERR_MSG(extack, "Specified device failed to setup cbs hardware offload");
+		NL_SET_ERR_MSG_WEAK(extack,
+				    "Specified device failed to setup cbs hardware offload");
 		return err;
 	}
 

-- 
2.43.0


