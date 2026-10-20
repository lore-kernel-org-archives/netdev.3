Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792467945;
	b=qtgeiKtPAmekkWpd7eXSHNjVz7Dtyeu1FlD6sxYc1nBlKrPIEgT4AulWsszn0WJH38q6
	 6QLRN9nFiQwjMjrXDyZ7fYuggap9XGs/BsmgivTKYNfZFM1YlCYKL8QkWXr9R+dH80z4e
	 +iuOTs7SKuepYoulPC6yBSkZZwIYy+AgLimFymnp3J4ZVx5rmNlaXRCUYs3t3lpxVQaFQ
	 lUdV6qL74Lf+n2W4MmIMHl5BpOYtHAuhBOt5KszWqTyw/UHGegspWdc1HvZPKrJFvdCAR
	 H2xI+NNmq9NjW1LbSy1gZNP4Mh+hxcMi4X9w+tps4iTbxtadiPsQsvBrPfiYo+f3cWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792467945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ULuGvekLIA9kqLWF/rjFDFzz9QzEifCQafgwxDg8ZBU=;
	b=WCZpI5vckKXx3dQ/Atg7zV2Ij6o/1OkzULNKvHUsDndHX91qAqsnclVgZyDfOOfcV6EZ
	 foK5O6L63LdYoG3/H8Oh/AWCEGYck43NcizG4CeyHj6ILk/ycJoxIUl/xrQ3J5IiK4wZt
	 xGM8xez977oaHpcTLN5UniPjaYg8MAOE7VEgxbqiWKWFto6AZhga+eDu6JPcr0aOMj44U
	 iI6PBcB4QuQPAd6IF4E/LRcggv78HP2v7Pup0nvx6FDugBvsTMvY74j2aT5AagNkmJV9g
	 EM4rS760MJNebBwxLZcMfvr+OH0LflVWsBv4uBLF307XOmfEBmBQYcz20iHoCBd+diw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QNUydbyP;
	arc=none smtp.remote-ip=74.125.231.137
Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F60606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11F60606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QNUydbyP
Received: by mail-oo2-f9.google.com with SMTP id 006d021491bc7-6de48228f20so288262eaf.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792467944; x=1793072744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ULuGvekLIA9kqLWF/rjFDFzz9QzEifCQafgwxDg8ZBU=;
        b=QNUydbyPz7OjvEvLXsauM9XC4aZqXdk0GUCJxlwONwH6xc3ncdV30gJOAE3h0UlwG9
         ACMPDKSicxvuwyOa+VSoPt8r1WC7+AQI7PCPJfsMUFsf4U2lhRSdmBHPfFxvThSfCDpK
         /7AE3/AfuHijqSrz5AVovSgKi57dhOlPIiJ5qBVLCQ+3Ry3KnFR+M33loLvqzGSqc4CH
         phdCg+5ro093v3iTCZyOjMG6/U5IEXlYG5AGZMts6Fjr7bIqF4juQ/574qX3Bzk1KtEO
         NOJfku2kZUB48AoU62vl3dEKmFFeiZo7GK+/mSGccprSElJYgqwtsQau3pVKn/VzC+42
         VwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792467944; x=1793072744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ULuGvekLIA9kqLWF/rjFDFzz9QzEifCQafgwxDg8ZBU=;
        b=awlPMVUYXpDln5eYdQwnpKfI3iohPrmaYklQFiK/Yt7DLRk3dSM3owmC4T0JHZKWRh
         XLMG9GSRw/lWYLO89SC4nO7yoMcI0bmSf2gqRWTSoscslXXo6W4JXTTeWU9JNs4qoVvB
         EpfvtvdP0pr94sEsuJj8zfEoM+dLT4oDidUL5+5sLhJy3yk9Q2vv90fQXFlxiNFyXdK/
         zBG3Ekf9Kg3tqqoPaqZSUzoSNMCvVNsjfutG8Ehv8BUIe3fgr75Ks4A+OGNN9IN3H62H
         FkhK2OSYqhsZRS7pAW/zPpCP8bYac8q7mgP+3fIlLiNawB8tVvO2gRAYh55jdnzZfNPo
         WiiQ==
X-Gm-Message-State: AFq9FYL2ho3F5aWaxNXmNT80yIb4OJYDP3dbS33cpZekiSCV3odFUg6N
	8YIbAGr3Bx9Wt7t8aLPGsv9VwCrPUzdW3q5DsEcS+v66yn8g+Dc8dto7
X-Gm-Gg: AYBFou0pe21i0h6Izcynj8vhxFDsp4Lq3W4A0cvo9h3iegvTOZyrfbPMX3oh4zRXOyW
	i30pU6v+R7wz7syHMnSu/Zsb7ygoGffivvOY5OF6mBIdjsPBLd7/4bz0Zq+jPi9M2nW6N9a3Sd0
	QJma3K5VGdTp1KPGnmbxtXi5UfIi4XtmkqDmh+dHyycoLa6u8UGcdhY1axPZV6QF46RlI3ildEN
	Byn1xDy6e+okQCPZeds4qLPAEKwpLn7t+T8Zi7glTZppy5c0NG9qLu1qhEA5E/Bp8ZN4zYJl4j5
	81rgBA7Z+z6hA0jVQUfBWhS+gDIylhZevOAoUeZj2g65P5ijJhBw5vEGHgdychOUNfV1RScDYmo
	EymBZPp8QVax05FA5deAL64uWfYkCcaNiVnoOteDcclMmiJFUOZYLeMFfalyI5wrBIGZ0GVBBTc
	kqMKWV7Kd/LF/qL0Y90Cermon33sDXMGyJ8iRrgA8G5uVr+paID1Io+qKEjRMfY3thFuKF9185M
	WXfqdKwVoKp74tXOOfpbfbcsChQNdkKfX3A
X-Received: by 2002:a05:6830:719c:b0:81f:92c9:1f80 with SMTP id 46e09a7af769-844ffcda39emr8967693a34.16.1792467943952;
        Mon, 19 Oct 2026 20:45:43 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8498d1a4bfdsm4387344a34.20.2026.10.19.20.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:45:43 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Ferruh Yigit <ferruh.yigit@amd.com>,
	Antoine Tenart <atenart@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Seungwon Bae <qotmddnjs@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] vxlan: reject adding a remote to a nexthop fdb entry
Date: Tue, 20 Oct 2026 11:45:31 +0800
Message-ID: <20261020034531.1420194-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FDB entries backed by a nexthop group must not carry a remote
destination list.  vxlan_fdb_update_existing() currently appends a
remote via vxlan_fdb_append() on an NLM_F_APPEND request with a
multicast or zero MAC even when the entry is backed by a nexthop,
breaking that invariant through three different callers:

- "bridge fdb append" with a dst on a nexthop entry;
- "ip link set dev vx0 type vxlan remote <ip>" (vxlan_changelink());
- "bridge vni add/change ... group <mcast>" on a vnifilter device
  (vxlan_update_default_fdb_entry()).

All three reach the append block with nhid == 0 and a PERMANENT
state, so they pass the earlier nexthop checks.

Reject the combination at the top of vxlan_fdb_update_existing(),
next to the existing nexthop guards, so a refused request has no
side effects: placing the check in the append block instead would
return -EOPNOTSUPP only after the entry state and flags have been
rewritten, skipping both the notification pass and the err_notify
rollback.

Note the resulting behavior change for the two rtnetlink callers:
operations that previously succeeded while silently attaching an
unused remote to a nexthop entry now fail with extack
"Cannot add a remote to a nexthop fdb entry".

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v2: Move the check before the entry state/flags update, next to the
    other nexthop guards, so a rejected request cannot leave the
    entry half-updated with notifications skipped (reported by
    sashiko, confirmed by Jakub); reword the extack message and
    document the behavior change for the vxlan_changelink() and
    vnifilter callers.

 drivers/net/vxlan/vxlan_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3390e341d1e58..83dcede2ca62f 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1002,6 +1002,15 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		return -EOPNOTSUPP;
 	}
 
+	if (rcu_access_pointer(f->nh) &&
+	    (flags & NLM_F_APPEND) &&
+	    (is_multicast_ether_addr(f->key.eth_addr) ||
+	     is_zero_ether_addr(f->key.eth_addr))) {
+		NL_SET_ERR_MSG(extack,
+			       "Cannot add a remote to a nexthop fdb entry");
+		return -EOPNOTSUPP;
+	}
+
 	/* Do not allow an externally learned entry to take over an entry added
 	 * by the user.
 	 */
-- 
2.43.7
