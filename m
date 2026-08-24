Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54D25CC79
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787537939; cv=none; b=FjnI6FXGYLsASrHUvHM4k6vHrUzZxhzBuv18AegQtWPlXZrL/eNBQ4FoZL2a113tx3DexclVgt3Lr8BqaQA9TFuy/Fg0PXmOtEXQ+v7u2Z0Ui7uDA2ZB7hK02F8jmSBZIJQdteQszT02Pi3s/j2XOiqxqEwREAu2UQNxhDTUg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787537939; c=relaxed/simple;
	bh=COq2dJsX4Wo4xfq0ZUJE3cGkk7NlbkPtkeLagPTO2aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgNQwXHNP+0fc3K1QOKiUWev5qSqEvCfD/by4qLNB3bSKOuiz6LonH0cZHda1JIfkQdO7yU/8RJBLKhVlLRO6IR/700grLOFzRw9bfT6O0oH5w/h0yU34oIb+bX5FyfYBK/WfaRrznGV3upMt1dJylNlS8v8GzyF14UXmtq6yTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beSAqEWY; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beSAqEWY"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c8612812170so219398a12.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 19:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787537937; x=1788142737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zrDILERb95TsNDPp/xr8y+ID/sGXxmyWy+d24zww8cY=;
        b=beSAqEWYePx+PdXAYzH7ezka5kThlEDdzFBoqLDqYepzCgXao9SNfHBAZXTjmRyVzr
         C4s91xAZYj+GV1cnz/CgpCjbB9khsEOj2/0E+M32r5Q+dA02/LMIbGWsfbtpaGQ1hb45
         9GKamI6GPavNCDs9p7SlFiCGfhZb51NL2AmQay0bClrzHzlMSBqoCfTSypazzN/X/kMx
         N3d3TPPW2w9Ciwx3ZXbV+/SDj2nvLJT/sG2SQPVIwL1E6CqH6SNzeGJJlUpW4xQyWAgt
         QZoCANm4JZuZCuDArLeQeyN3QBXtqyPoSn/Fih4Wt64ZVaUyoDh6i1o0uHSMyoNRKxJ5
         XRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787537937; x=1788142737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zrDILERb95TsNDPp/xr8y+ID/sGXxmyWy+d24zww8cY=;
        b=oAClaBetuyA9lR27wOPqMkT531IOIKPWaxWfmW/hS76cthHKAr3PfyQOt4D+7v5LH/
         e/CkAha5LUm7yzr7GYdRDNzSs4Qb3Bt7dhP78RLHDWxqIYKQFj7feW94ng/80ibQvFAx
         94RyAI9cIxda089ChBTVf6juq99YTVD7NooxJPA6uGpnOnhCrIKakIr+bT4fGn3He9U+
         hG1RBFawGrZFobTrg4W3EeJ0YNRgMq7x3QK4mmcWh0CN7j1vXvNdLuEf1S4eUYy9dkuY
         mZvVAjVrjEC4hV72RCawloXFd0AlG554zKeaJFYAUpdIVpTNBRIQPrlTKqS4gc3hfdAI
         Jrog==
X-Forwarded-Encrypted: i=1; AHgh+RpFGufvgUM0NUH6SUOcUvFH8ePjgoE7uqajt5WrE5fsZw2oFBm9RUTKj3+tYh4egpSyDXAKwX8=@vger.kernel.org
X-Gm-Message-State: AFuF++nIVRhHzjbmEmMhktFLvtbJDyFT/XxyIVtLsn9a0MFdyQo6/yMx
	6r/jq5u/h4PLq2FEBCdGsK7yaen3wJBlU9niaRnu05GM8ZQ8iAFAb7Fm
X-Gm-Gg: AR+sD11cn0/WChHDXcRDryTQXSIBQjL+MUxotwgtKpgxJZSM0ble0baUG8qLMT40LRj
	VDtUv3GshN6WnQmNzq2vuVtgTEBBkjjzlK8ZW+6euOFip7wvxFnX95fQSPW9db5laMB0PmLdX2L
	MOJM6dy+MWLNHJxaLonIIbHS51491EuvvWnWNCMp5kBjup3zRBhdVCmEYWbMOX4y0W6bercWdP2
	NCPfn9E/WUSrAqXM4HkGp2mLEsnxfexYe7eVBZ73bIuhcNzwassomOWGrJLWDRK+2fMJYJhCI0o
	sJyipZS3TS6e1tunxc9YKXyDnp9QRCpD1xrGZOamf+bBc94Wsb/LV9C22cc8UfTR+i1c13iHUsR
	EhyAqOXf4kqtcxRlIfEanEyEniR8zt1nMY205f6hg8kRO/65q8dZC50u6crPjVQucmNoI5B7wNm
	6yg8G3EquWLkdro0M8XMBsGqYN3d4UDaUDAkaa8C3KzT5mOy5dpHpPyY9Ll6+u+Xn9sCNQ2Rv7G
	tXhUV035ytpKxNcymEc7tJxWHLTF0OZ0z4verl9rit4JUJ4IUGMqTAChJYNzg==
X-Received: by 2002:a05:6300:4044:b0:3c3:7f50:fc39 with SMTP id adf61e73a8af0-3cd2f9cbbe0mr19412557637.0.1787537936940;
        Sun, 23 Aug 2026 19:18:56 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f03b185sm1406434b3a.39.2026.08.23.19.18.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 19:18:56 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: jv@jvosburgh.net,
	jiri@resnulli.us
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	netdev@vger.kernel.org,
	Qihang Tang <q.h.hack.winter@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] team: reject frames with insufficient headroom in team_header_create
Date: Mon, 24 Aug 2026 10:18:02 +0800
Message-ID: <20260824021802.90369-2-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qihang Tang <q.h.hack.winter@gmail.com>

AF_PACKET SOCK_DGRAM sends reserve skb headroom from a snapshot of
team_dev->hard_header_len.  A concurrent team type change can switch the
selected port to one with a larger hard_header_len between that snapshot
and team_header_create(), so the port's create() pushes or writes past
skb->head.

This is the same race as in bond_header_create(); the snapshot series
that fixed the SOCK_RAW send paths deferred it.  dev->header_ops is the
stable team_header_ops, so snapshotting header_ops in the caller does
not help.

Reject the frame if skb headroom is smaller than the selected port's
hard_header_len, before delegating under the existing rcu_read_lock.

Fixes: 425000dbf173 ("team: fix header_ops type confusion with non-Ethernet ports")
Cc: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
---
 drivers/net/team/team_core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index feaa75fbf8fc..2742a4bfc9d0 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2269,10 +2269,24 @@ static int team_header_create(struct sk_buff *skb, struct net_device *team_dev,
 	port = team_header_port_get_rcu(team, true);
 	if (port) {
 		port_ops = READ_ONCE(port->dev->header_ops);
-		if (port_ops && port_ops->create)
+		if (port_ops && port_ops->create) {
+			unsigned int hlen = READ_ONCE(port->dev->hard_header_len);
+
+			/* Headroom was reserved from a snapshot of
+			 * team_dev->hard_header_len that may predate this
+			 * port (concurrent team type change); reject if
+			 * insufficient for the port's create(), which
+			 * pushes its own hlen.
+			 */
+			if (skb_headroom(skb) < hlen) {
+				ret = -EINVAL;
+				goto unlock;
+			}
 			ret = port_ops->create(skb, port->dev,
 					       type, daddr, saddr, len);
+		}
 	}
+unlock:
 	rcu_read_unlock();
 	return ret;
 }
-- 
2.50.1 (Apple Git-155)

