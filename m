Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186447ACF1
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790100681; cv=none; b=feOOI1Lcjw0dxnkP+orFQENNzsx4zk73xWM7XtN892IDAbjpoOvIzkzbef8BczzDKQgsIdeXW1iHRcN7iiE6y4QIdmFNxlsT0kr8d8ojC+9fS2rg7y/X5I/o/ZbjMpuwN9T5hez+srQZP8yLaX0cbaYqk3VtT5qkoNiXmrGLFOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790100681; c=relaxed/simple;
	bh=w+9osw9Lf5RphFNt3XjjteO06wGmU2WzHsvKLkv0Cs0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hJK5/C3QfjDRtRH7EDXJH1jv0VU5KzRJSVd4Ami7GFY/zyiY75qwTGB94MJRVIX/yJ8+gLGmFKCKOv1nJxQLkjaA1kLLFd/E+N/0TWF66kP+OEw6IPGTmiwgSEsaYhvXos72FkEVLlHgHbGYYL+ARxhJPYO2g47qbXUM+DQOFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gE4bnuyw; arc=none smtp.client-ip=209.85.217.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gE4bnuyw"
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7a9378b844dso118269137.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790100678; x=1790705478; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+QSqQVwnT+zvkzGb2wVLAC6idPVjtnxfL09KOOhiKU=;
        b=gE4bnuyw1BgP+9DiDpXCDszHui7PO4+BxHFnkZ/GXztCKMN9oBWuc9KNWxPc3KV0bX
         RfwG41PjvKZ+JDe/iuDQF/FKylFTH8uYJjzVuIw7+n5N7k2H01jcmcGJQUjG+VTZTjR2
         xlnLYGlhoRYC6X99KVPhjxWaZtMZA2dEFvRmCU5UhQzUc4L/JdSzQswnv54rWGDUp/aP
         Fgts+2V0alZYfQITNwOfGjnbHRdeFIr7x5whlhXrhoIMDDbKa07nFfqMJckIs4XbNrhO
         oyvUyvLYs8k1egXkj/D3F4t9m47ggJhVb2bFVPLKF9DxCYYYxhMEsB7io+O8egqPm/Eg
         eShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790100678; x=1790705478;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+QSqQVwnT+zvkzGb2wVLAC6idPVjtnxfL09KOOhiKU=;
        b=MZ9oBPyQO/Bqz5VJGA+MCfcTIk4CeU3XBUFHcwLi6Uy7NW6LVRg4QLdrDfmHm4VAy4
         gFhWV7w5uC9K/JA33BDMUn5N3/vKN7E80BIDYICJ2DKOFAlDsKi61xbSARQpYY6Tp9Kk
         pe/xdwfHw9G+/IL/jJWQWsAk8y/yUFYyVidVHAn1FPqzCgOe0AB+CPBxFEzBnd95MHpq
         TeiSXXBE1S6f9FRvR1WBQNJfCFoI44/LbhlU09g51h2C+UQ7lVCQPtWY+6oFP+tzH8UF
         WFyOaRqiOYAEpxqBJ3vSQS68ZcrXbo0abZiRlEqOfVg3k8zvCL1dGIcaxFZFOXRnhctv
         LADA==
X-Forwarded-Encrypted: i=1; AKwUvByYJSPVSb3AADCleb9voV4StVEMDMP5lBpp3Yk8aaDEckttm9D+wn/GLS8rEvgB8BbKBgN4fMI=@vger.kernel.org
X-Gm-Message-State: AFuF++mc+JZ6X8kxZcGgM2ma+hU7ObMnjHiQZbmnX3Klj/Wugpc6lohk
	KDlWX3yh1n6XQGGPZ1ZEm4n0mih6br/PQHXNqtTqtwiH0arnwL87NBNEZsumbfBwS/QHPPJV5hu
	kWikGNyNmiBQhIg==
X-Received: from qvc22.prod.google.com ([2002:a05:6214:8116:b0:910:6d7a:5e05])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:548e:b0:7a1:f980:e936 with SMTP id ada2fe7eead31-7ac1cc9f594mr162621137.18.1790100678114;
 Tue, 22 Sep 2026 11:11:18 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:11:02 +0000
In-Reply-To: <20260922181102.3989489-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922181102.3989489-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922181102.3989489-9-edumazet@google.com>
Subject: [PATCH v6 net-next 8/8] vxlan: no longer rely on RTNL in vxlan_fill_info()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that vxlan->cfg is RCU-protected, we can update vxlan_fill_info()
to run under RCU read lock instead of relying on RTNL.

This completes the transition to RTNL-less link info dumping for VXLAN.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8116ede68ac74174d550c3fcbe61fdd94c18046c..0e5ab0055ff8c4e841005bb408888b447585c25b 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4748,7 +4748,8 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	struct ifla_vxlan_port_range ports;
 	const struct vxlan_config *cfg;
 
-	cfg = rtnl_dereference(vxlan->cfg);
+	rcu_read_lock();
+	cfg = rcu_dereference(vxlan->cfg);
 
 	if (nla_put_u32(skb, IFLA_VXLAN_ID, be32_to_cpu(cfg->vni)))
 		goto nla_put_failure;
@@ -4847,9 +4848,11 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		    &cfg->reserved_bits))
 		goto nla_put_failure;
 
+	rcu_read_unlock();
 	return 0;
 
 nla_put_failure:
+	rcu_read_unlock();
 	return -EMSGSIZE;
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog

