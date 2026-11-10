Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311191;
	b=yLtjnYezYTr8DCJxoFInU3NXCyeZyKSoCvTR9woo/xkv/0m147wOoBuRRWAWCtYgcqLQ
	 HrQcWZ2Ds7vPEepElQOfbK2ZydeZ43wZ6RDsNh2PiVIXYj2NelUdVaCho9CVY6i6VcZdg
	 CvI0jJi1/HffJNo8xDvleT/hjC4iK8uqdSe7e5rfee4JLyYKIb3PfuWS/c2HjN7INUoUF
	 tlC1rl4Vgwcygvk6Rz+5HYZakY26h5omk+BJRcU6v5m7HJDQl/kj94R7FW3AxSEW18BdF
	 P1/mXFKFYo9VJ4/82jiR58Mzqu5J8cCqk2BsQgMdbZ99U5xhRfwHJ2M/HwScNpUkDvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PBZCd6YdkJxJ064F291tmqCngK50lIQhQHSwEALjDEI=;
	b=fzYCSfAq/TnM/zyBBQ+LOHc4fX+TozppVayy9RSdUMJA/NpXSw2kgpdGdEkIyWLYtywh
	 da2GIuSLsUgvfIRjfTxc9NpvU+NLlBr61v7ZzHudTSoN5qycwxZQHPHtg/JjssOkCmrpz
	 dZDj5OsCFBgkvsbTgXIr827qmw4jD3LP1mCe3RaNf47/kfco3bho1TCyEwva5sS6lJj+9
	 QOnpurolqNT5oOhQIKRXA/ZtdBQJk4Dpx/bkZQ67qH0g8h3H8lejlkAf50VtItNr3kurC
	 vhMnEw4o0zuS6aJx1QJ+jnjap2O11cWXx7ivklRb/vkzAQPyooQuYfoCt0ORqqOOBkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N2JmzX81;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B0A606A336
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0B0A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N2JmzX81
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cd6a7b62ce8so811199a12.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 03:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311190; x=1794915990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PBZCd6YdkJxJ064F291tmqCngK50lIQhQHSwEALjDEI=;
        b=N2JmzX81TKFRZTtMxYTh8ssnFayP2VMKsoCo0yuwYe1NM9HD3yDfiYxDSzTiYg5XnN
         1KdPDK9jXLcjQGIBkrf/tCvdD4sgbLoJhfxHUw+fKnu7o+o7loe+qoV4ie/YBCm9UKyE
         vNJ2JU8Uk4zngh8ucwUPqvBjfInsaNC9wUUDDRMRmvzUNe/l2P75WITa4XJZuwC2oK/r
         HTt4HpG7EvdNGFkEIapT+1wQWRtD/MwIEftIWMZS3MA/01qf5sR0ji27YpxLIxkyHBQn
         nh3pZinRzP9LabFySk6gr4M7XtwCLKxCb84vmV039TxI61xi1wUgfS7wnc6sceXPg22n
         PZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311190; x=1794915990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PBZCd6YdkJxJ064F291tmqCngK50lIQhQHSwEALjDEI=;
        b=Svw6tpppsxDQgAuO1vS9RiXzQLxGYYrmumeVQoRCKoFA3qCDSYWSeKQGWd0MSjAMzN
         57hnYDaSxda+lJ2sVlIwC/9rqReuqos0ved5AkWSVBmO7S7cgFqmxcXzW2sl/6PB3VSm
         +t262D/WXj8KR/LajxAnjYizDLwyml5gXSnvoRugwePxS4pzQ9+xduCJ5fs2o3kbIh+c
         f0n269/wh0rMved0mc/lvrgY+YM3JaKKKlj3tgwUpyaYuUj3w7YougURuUPPrYPXw6/l
         ktnIdGXwDe2ufrgenpB0usgNoxYM+H9H3K/UbEIf2GIcwT7XLYt7Z5HOeh0QLK8CaoIR
         MOKw==
X-Forwarded-Encrypted: i=1; AL+hErGlREKF5i9r6OqQXZUXtbwhoU9KmOI6cyrBvyiVYhz4KQAloGaSvzWVWGnZnnULLUkZQJ2UoWI=@vger.kernel.org
X-Gm-Message-State: APuU4Z807NUZzw+X65vFt7gMft5hjuj1BksA8iZ9xHdgqS64IK517/Iy
	rX9bo8GfsodQ6Vhe66EtV+1UN4u/5c/+QNGHtUTbTUCe2FejgKSvlS9y
X-Gm-Gg: AYBFou1F/ZG57VdUZvfQoflCYM7T4Z25NhGFZy17lBlIPfK+y+MB5kmQJlWW+LifU3o
	NfPWt+aGdMTr2RS4rMK2a4HK65fuJFsFJjefflvDOb+dUnW9Ywn26gfRizXrdncR3wCxc0ijGyx
	5XoLIizutNenO7kpI8wsXFUNqb86rAZuc9OIf+58e49+5k1H6SJ9c+/RCuNoatEFRqvhO3+3CH6
	acv9POgqWF9+p0ghogPOdCEbRiF1zdO+/AcoWtoYI0AgS8HLWn/xQKJ9DnS4JHWm28vSNAMRK0Y
	ijN1QFYROxVJkcVfS/PV+1Xsj+IA8JmyTi7jn2kBBmHSTQ7O60JrjfxT7CrWfbVCXPn2cWEedZC
	OvvF6lgqR6/+VMha+f7YRPVPOZz2rz5eEJru6+GlPnDlZh5en5KP4VhyxxgwdpXEofddsmDRefL
	uUATDClb0FwTe/1pSZMhxO8D63J2IV2NkFXwmYd/eHsu2KkT/n6xYgo4nkAL28oYZWAbViS/Nvr
	vAQTA8AKIkpGBz8LoK9I/9vJYW869YC59a4bQDNBEX/jgnrQZFQTku9s5zm/cOWfzbYg5veQbLr
	vXaLtXZpHUMY+T9TgFWmuAKe2klQIaP8C5w=
X-Received: by 2002:a17:90b:3142:b0:3b0:92be:ea4a with SMTP id 98e67ed59e1d1-3b166d14ebamr2280964a91.45.1794311189808;
        Tue, 10 Nov 2026 03:46:29 -0800 (PST)
Received: from localhost ([240b:10:ff26:df00:c666:4b57:9ddd:d960])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b167970669sm3391915a91.13.2026.11.10.03.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:46:29 -0800 (PST)
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
To: steffen.klassert@secunet.com
Cc: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Subject: [PATCH ipsec] xfrm: account XFRMA_MARK in xfrm_sa_len()
Date: Tue, 10 Nov 2026 20:46:23 +0900
Message-ID: <20261110114623.2659197-1-yasuakitorimaru@gmail.com>
X-Mailer: git-send-email 2.54.0
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

xfrm_notify_sa() sizes its netlink message with xfrm_sa_len(), while
copy_to_user_state_extra() appends XFRMA_MARK whenever the state carries
a mark.  xfrm_sa_len() does not count that attribute.  Only the
XFRM_MSG_DELSA path adds it to the length separately, so for a marked
state the XFRM_MSG_NEWSA and XFRM_MSG_UPDSA messages are sized short by
nla_total_size(sizeof(struct xfrm_mark)), 12 bytes.  The other length
calculations in this file already account for the mark; xfrm_sa_len() is
the only one that does not.

Instrumenting xfrm_notify_sa() on an x86-64 KASAN build under qemu to
print the accounted length while adding a marked state confirms the gap:
accounting the mark raises the computed length by exactly 12 bytes
(348 -> 360), matching nla_total_size(sizeof(struct xfrm_mark)).

Whether the shortfall is reached depends on the skb allocation, which is
rounded up: xfrm_notify_sa() fails with -EMSGSIZE only when that slack is
exhausted.  km_state_notify() discards the return value, so such a
failure would be silent.  This was not reproduced.

Count the mark in xfrm_sa_len() for every event and drop the now
redundant addition in the DELSA path.  The message content is unchanged;
only the computed length changes.

Fixes: 6f26b61e177e ("xfrm: Allow user space config of SAD mark")
Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
---
 net/xfrm/xfrm_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a2587c7e796b..5c6ee35bc012 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -4046,6 +4046,8 @@ static inline unsigned int xfrm_sa_len(struct xfrm_state *x)
 		l += nla_total_size(sizeof(*x->encap));
 	if (x->tfcpad)
 		l += nla_total_size(sizeof(x->tfcpad));
+	if (x->mark.v | x->mark.m)
+		l += nla_total_size(sizeof(struct xfrm_mark));
 	if (x->replay_esn)
 		l += nla_total_size(xfrm_replay_state_esn_len(x->replay_esn));
 	else
@@ -4101,7 +4103,6 @@ static int xfrm_notify_sa(struct xfrm_state *x, const struct km_event *c)
 	if (c->event == XFRM_MSG_DELSA) {
 		len += nla_total_size(headlen);
 		headlen = sizeof(*id);
-		len += nla_total_size(sizeof(struct xfrm_mark));
 	}
 	len += NLMSG_ALIGN(headlen);
 
-- 
2.54.0

