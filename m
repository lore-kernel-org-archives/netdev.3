Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328B132C92A
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773793; cv=none; b=hFRCCidhD1e3+5gGgTYAf0VudSg4keAA1H9OaRRTXF4mk4VjPHrQFQk+I5sBfVlIpJFQ/R3zc6t8fGmPCYO8F6yQRBKVyn20rFZIyp91nZ5W5ZExXuhikrWFbxgJEkmQ+G34bVZfvjsRf0WNKwSp4rRoJCRkAUzODiNKwcirUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773793; c=relaxed/simple;
	bh=4vYiVVksyldn7swIpfllG1hkNNDW7P+IPr9Ajbx6HE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HDkmH5bXU1aSv3QeZPpTqaFcg2frYQlEJ8sn3fKMbCiRP2kqbu7MHTFjPT0lsQTgmp3uRWTTsq0ULaNUrteKE5G9qOeWur8JnQI7ZCgF74Yim6nh2eAwejGK1xQklbNHwVIVhOAam6nikVi02uEkkT3wMgfKbymL2WXOdhQ0yaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtwz2ZVI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtwz2ZVI"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84874b52eabso200422b3a.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784773791; x=1785378591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p8LvT3IJZd7EJrtc9YjjpZEfucaV4n9NX3Db71UzcA4=;
        b=Wtwz2ZVIQFRkBFEWLXJGG3ciDgy8i76mJmZMfVMFQN5acHvmXxy5Li8sHrzgtxKV+8
         YDjUkIKsRwj7N2U3G6ccnsrhbn7KZR52kv4CHK1FusfukKWHNh1ubXUYZ+j5QK0QlEiH
         Tm/fAY6TXaye+NvvN5o+qQ7I7d9Qsbs374mF968saXKCJJX/wWS0l6oR6AsstfYCtVFN
         py0LYra0xfES1KQwgRHubqIAygeHXu8jGP0H9I7pjzyaRQ5TTZDQ7ccVYupWZ/uG4PtR
         7xHofAnNo1XhLw5ncB05UlRIZaEr7H7FAjNmF9/I0CMqKPR8XjNXm7aoLiKE363BNvYh
         Y3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784773791; x=1785378591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8LvT3IJZd7EJrtc9YjjpZEfucaV4n9NX3Db71UzcA4=;
        b=puXMAWurwkXBlWHf+L0f36VSUcn/vAUceTk1Z9b8ChcZmWMT4RjueXoIzFeIy/Hu4a
         XV7CfjAH3uB63WMdCOIw5TonDmXc3M2RAHaScvL1VCiQZBRipSH6hyq/8p6hPTo75WU+
         FYLC7jbwrpzt6bFgH/3EpfKX83/hfsKtD0vK6KbglcpPx/jHd2Gfy+nWhv3Q9+n9VNI2
         H+nlEKDtoH347IRkbF5xW2NQQN0Y2onSdntNA3SjMnI2VNjY5tiX5k7WIEPqlf1d8R6P
         2dfe/sQNxCdTU3mPCqX+6YOy1Q3k6zqtXWAeQ40pfH6nWgVJuhabPP7o+ALFY1Bn6xwM
         lCnA==
X-Forwarded-Encrypted: i=1; AHgh+RpOSwbKkFw/BceRUaLnK7NofXpje8gHT25bU6ID5RFl5VMAY3exsxlKVttRlq42YUJB/YMDZtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoS/3AXbLZOyyvMLciMpx1XKSb0c49u51LBk9PmRjfZbLvvA5Y
	c3xSKuiDmXNSarBdEaR/uvlVsegumGIPq1CHDpWLhofcdrMIAHruSNLG
X-Gm-Gg: AR+sD1161AKZD4J6GDczd85p3+Bszglkr+A3nvlKtjtFLJf3a5xsGrC68Obuv+iS41d
	Jnd92us9pdpqX3dSX1IY36S8v2UqLhELytKT0AUaMQfJLyG5fHm4IV1yXAqQTgwBhsPV6bbN/9S
	E/ml/Ba4HcYm91eVbFNE2B3gIGnHkXZXu9JITU2pCNGA7yPZeeNKYhok2h5HNV/dM5rt2Wyulko
	62KtbNFxDsD3XizwSx6dleRrjfo3Le+An+fCd82mmYcALevn8HxOo4KG/jbixIzsUDxuR5t5BhR
	KdEnx4IOf5oLKM5dy2EQG689RByJP/zFIMaJ8CdNVizML8YyCN9SFIJ0ROJvoNt2NErU3sAl+Zo
	gGFOYtu9Hwq46tHnUCJDloGMk4wiyQ77L2s6FQTl2/ZAys1zvCGrLn4GEKqvG6Xpk5PmjCLwCHA
	/C1GKxB3ebm1wt9r/03cCnMLjrY52OvgbV5Z5icC7n/FC3us/M8rUEs3CTl3f4Gjg=
X-Received: by 2002:a05:6a00:9501:b0:848:2f77:e2d7 with SMTP id d2e1a72fcca58-84e2c2208fbmr1505866b3a.64.1784773791358;
        Wed, 22 Jul 2026 19:29:51 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17578345sm2129549b3a.39.2026.07.22.19.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 19:29:50 -0700 (PDT)
From: Sangho Lee <kudo3228@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org
Cc: tipc-discussion@lists.sourceforge.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ying.xue@windriver.com,
	tuong.t.lien@dektech.com.au,
	linux-kernel@vger.kernel.org,
	Sangho Lee <kudo3228@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] tipc: validate Gap ACK blocks header before parsing
Date: Thu, 23 Jul 2026 11:29:47 +0900
Message-ID: <20260723022947.1569915-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An established TIPC peer that negotiated TIPC_GAP_ACK_BLOCK can send a
STATE_MSG with fewer than the four bytes required for struct
tipc_gap_ack_blks. Basic TIPC message validation accepts such a message,
including one with an empty data area, because its declared size still
contains a complete protocol header.

tipc_get_gap_ack_blks() then dereferences the record to read len,
ugack_cnt, and bgack_cnt. Both callers compare the returned record size
with the declared message data length, but only after these fields have
already been read. The late checks therefore cannot protect the fixed
record header access.

This was reproduced on current net-next with two live TIPC nodes over a
veth bearer. Replaying an established peer's STATE_MSG with its message
size reduced from 44 to 40 bytes produced:

  BUG: KMSAN: uninit-value in tipc_get_gap_ack_blks
   tipc_get_gap_ack_blks
   tipc_bcast_sync_rcv
   tipc_node_bc_sync_rcv
   tipc_rcv
   tipc_l2_rcv_msg

  Uninit was created at:
   __alloc_skb
   alloc_skb_with_frags
   sock_alloc_send_pskb
   packet_sendmsg

The uninitialized record length then reached tipc_bcast_sync_rcv(), where
it was used to decide whether the STATE_MSG should be dropped. Supplying
four initialized bytes after the declared end of otherwise identical
messages also changed that decision: a trailing len of zero continued
processing, while a trailing len of four dropped the message. Protocol
processing therefore depends on bytes that are not part of the declared
TIPC message.

The KMSAN finding was reproduced for declared data lengths zero through
three. After adding the minimum-length check, none of those four inputs
reported an uninitialized value in tipc_get_gap_ack_blks() or its caller,
and bytes after the declared message no longer affected the decision.

Check that the fixed record header is present before parsing it. The
callers' existing size checks continue to validate the complete
variable-length record.

Fixes: d7626b5acff9 ("tipc: introduce Gap ACK blocks for broadcast link")
Cc: stable@vger.kernel.org
Signed-off-by: Sangho Lee <kudo3228@gmail.com>
---
 net/tipc/link.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 49dfc098d89b..8cc30ebdf575 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1418,7 +1418,8 @@ u16 tipc_get_gap_ack_blks(struct tipc_gap_ack_blks **ga, struct tipc_link *l,
 	u16 sz = 0;
 
 	/* Does peer support the Gap ACK blocks feature? */
-	if (l->peer_caps & TIPC_GAP_ACK_BLOCK) {
+	if ((l->peer_caps & TIPC_GAP_ACK_BLOCK) &&
+	    msg_data_sz(hdr) >= sizeof(*p)) {
 		p = (struct tipc_gap_ack_blks *)msg_data(hdr);
 		sz = ntohs(p->len);
 		/* Sanity check */
-- 
2.43.0

