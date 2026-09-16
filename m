Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68E4BAA17
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789600171; cv=none; b=nA4cokUyy+Mlrmpx8UZWcTLjfW+nV/lsAOQjSjopJYXnj3WiRPgvRklPxYSRv+SyptOLB3YSMmA2UO4JzkeNRrPFLxbMS2bDHM0ITtgEmNg6R729B52AxWcCEw6Nq8qD13WkAWKXQ3sPjUVJCxoml66pU9iMS704cTB+XqLTgOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789600171; c=relaxed/simple;
	bh=YXCs1KdEJhDmHVyrcGoUuDUMs28wQI6wjuk9qTcd9TY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o2/drjrM3yJFsqupO3/2n4r12RB+6uxiS4OWUufJyqy6JOL+gJ/mQkZwPuAY4kkMwkxZXduBPsp2ZnIsWA+jIqC9pfdNs8eMIOMFccjjPREv/C5+KKMAWAVaD2G0VuHtpmpPULYPGxooTD4orfijP2p76HI6Kl0flWdPhWDehn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=auHla+qe; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auHla+qe"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so201374a12.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789600169; x=1790204969; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TGbhpDS+ezq/4dfsOBQt1yAKPkn/SArQrZI5FvR/tH4=;
        b=auHla+qeRnG5v5TdcwmLZ+F7iP2UGOv1WR3Mx3BObZaTYo0KQQIUMWmJyqLak/qG7c
         r+gR5AOlmrrZ4Q2Xim5bnDMlh+8XXl+FAIrAdESHgR1ciYfamY0BegdP7bz38p+9TjjC
         Uc32YsgeeYBCuJ8S3rZ9LsS6RPCv4lnemolEnXCrBw7MYPwL8XUDD4FG8doNYSffs2jg
         t3dfa/7yPaF8DNlOb2DqQjK0kmbaYg/KElZQ3H5vKzNdFWUdRyFJiTfZGHjCGvOoM0Un
         YAhbUBK5kX7ETPYAhwltn12gEyIj1ao+9sVvsRvmvLC1B36QzKfvUtvbdAw/M3N5hbY7
         sk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789600169; x=1790204969;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TGbhpDS+ezq/4dfsOBQt1yAKPkn/SArQrZI5FvR/tH4=;
        b=FJFvZnJtf9YcuDaB17XzCSHHQfpiQnUzGtc4AIvCA8Cv7fY+vnOMcRl9SCBktabme+
         ZvZ/ftohUUiDlOXVU49cEUPKnab9U58W8D37+Ex8fp+xeEHlM98LIK/ynxOM3jRqFHO1
         C8wr6Yp3vKvC3R5F2V4D8qP/1O+SJmyalDx10KRZfQT5+JK68yl21/D04T90KcNQoqnZ
         dRTpy/vr2acJGkbWff9myKpnaFd5YLmp6FbxBT6FGOYt2Dn9mv63+/cs5x1JwSClfg6Q
         DdE5JmUxfPIph2Rvl7wcq9NiVRKEmk7l40tQc1dXJ0Cg8j2V840Aqrgti2WcquDrcSQk
         JEwA==
X-Forwarded-Encrypted: i=1; AKwUvBzbATE04Wm6CVUPz1gGlFNnvkh9Y3WVfeSqfUTgLjUtqdRTuAouqUVRAfWp+ODQq+fcFWiBOpA=@vger.kernel.org
X-Gm-Message-State: AFuF++mBE3WmDMbbXqlSqDMbk9VLB2eer5MYwIFWU8K1hg/1rDhvXDYE
	fq5MBVEsFMDtVsu8xEYb/7O6Br/2b7QaspbhwV9/IDlestLuDlf9I8/sd/gHY0Yz9lQF05Q0cUB
	nvFB+SA==
X-Received: from pgbm16-n1.prod.google.com ([2002:a05:6a02:6190:10b0:cc4:390c:da2f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:db90:b0:3d7:b3c1:cc34
 with SMTP id adf61e73a8af0-3dd5f7a9c8bmr10755157637.26.1789600169293; Wed, 16
 Sep 2026 16:09:29 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:09:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916230927.378957-1-kuniyu@google.com>
Subject: [PATCH v1 net] ip6_gre: Call ip6erspan_tunnel_unlink_md() in ip6erspan_changelink().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, William Tu <u9012063@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The cited commit accidentally added ip6gre_tunnel_unlink_md()
in ip6erspan_changelink().

Let's correct it to ip6erspan_tunnel_unlink_md().

Fixes: b80d0b93b991 ("net: ip6_gre: fix tunnel metadata device sharing.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6_gre.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 8ebda0b6a78b..e61cb10b50dc 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2279,7 +2279,7 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 		return PTR_ERR(t);
 
 	ip6erspan_set_version(data, &p);
-	ip6gre_tunnel_unlink_md(ign, t);
+	ip6erspan_tunnel_unlink_md(ign, t);
 	ip6gre_tunnel_unlink(ign, t);
 	ip6erspan_tnl_change(t, &p, !tb[IFLA_MTU]);
 	ip6erspan_tunnel_link_md(ign, t);
-- 
2.55.0.1082.g2b9226bbc0-goog

