Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0AE33F594
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073184; cv=none; b=Lwv8KdXfdsbmAL04hjfpHYoKFok55yBwJKv97gjE0dyk/zlfNU8QPEdIArPUrSut7GpcPy/i86PXDhzhKJonLgjD7WcYYJdtEfEbJEW3kxTlHBOuoOgEn+CRw74v/z+KQeerrPE7Qms64oKUod8nf2Arh53E5cTDmmX1xtPzBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073184; c=relaxed/simple;
	bh=n2nIYRqHBzHU+iwk0E4STJBtokRVeYdmeY9qxc6hZLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MkeQp+ofJYvIl4mE2moH0mQhm/pucX0rriofFyU4Fm4WhDe4T5iUJORD47I2SvneZN/o2uxHHbl6Ui3y5j7set+p/mS4NREdiU1hDasBttWEaBN0PIOJ9+NLmnQ6Y6T3SMiibe8UCw8+6eKvJQa4FMYfHfW6DYzQza2oip+Ob48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g//1IXjN; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g//1IXjN"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53062ec5b9bso4063691cf.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789073182; x=1789677982; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0GgtuX3FrP77QmTVJJi4hjj9DUungu61kRSNpAReAFg=;
        b=g//1IXjNPpx/cxgMRY07yXMDpSBBUoMkiQFzgOEHYSIse/T0ze9IUb+sOgq0L4JACk
         ZrUzgN/nx7FM3BahqRN54B45qxCxIzAcrTXeyh41FvUdz4JJfxsTRTIMujLtKQfLaNt1
         RUwtNqBObJvZXRH8ahF/iPh+VRKodURIZvcFAr5RI7/NPSAHZGDwGPIM51b/oEJPsBfa
         e3PLa1JBGMEVXyYkZcRIf3iJz+p+24AW645ypEuAwJ0BsdOqRww9RszxSbFCRtqudx9W
         Rz+CVIW14GcqlFzW832lpf9N3owSztLiJ/Rw49Xw988UmEX8DQdBO7mE6wEaDOC9xwpy
         zycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073182; x=1789677982;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0GgtuX3FrP77QmTVJJi4hjj9DUungu61kRSNpAReAFg=;
        b=Lrn9t5bML1tlfo14aeESpWfnTivG5NPXkTwoQO5EVA3bp4bbG1+jrzY1YCjUqXNd/w
         4yJwzN6N3v+PjdVBmzkspG0IeAZkWGaIwuREwENTKegCPzXXvbAPca1mQ0e2/KruLMFC
         tcgULjB8k9yXWACsiBskwQUtXa+aDUNuUV2jjBROQ5BfsLzntrQvhDpXGFHD0DMzzz6e
         5oY5GEFdAuFsT+KKcUtqgVZ4v6xRKuKZtlXb32zYq2CZWFeaqCNMsOcEVD4w8nmBNKGK
         QR8cxD2L4fx467xfDkTZgdTL7/q1/fwox0svhDoSdZdym7qaBmKaCoktQPCNrZsV4TF4
         /RuQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3rq8L0Ak2cRaz2EiWkFE6v2Fkf9J+BbUZUlkev1jIDSGGvO8fhUl5Yug98m6h+cc3/fZ8+0g=@vger.kernel.org
X-Gm-Message-State: AFuF++mpPzW41asoD9j1VDSsVYHjy2f/dXcNO3VXFkCyihfqSM9eARHm
	LURhJcH38pXDIZaP9z3HrAzef8/X2j2znAS0EkmfaQP17CJvuoExckB+sTVUzCSoRst7bhopOnC
	kWNArNK4I0nKN7Q==
X-Received: from qtbif7.prod.google.com ([2002:a05:622a:6a07:b0:52b:721b:7c2a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4184:b0:51c:f3:34e3 with SMTP id d75a77b69052e-530c86fca9fmr18700941cf.28.1789073181940;
 Thu, 10 Sep 2026 13:46:21 -0700 (PDT)
Date: Thu, 10 Sep 2026 20:46:12 +0000
In-Reply-To: <20260910204612.3762015-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910204612.3762015-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910204612.3762015-5-edumazet@google.com>
Subject: [PATCH net 4/4] drop_monitor: fix out-of-bounds write in reset_per_cpu_data()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In reset_per_cpu_data(), al is computed as:

    al = sizeof(struct net_dm_alert_msg);
    al += dm_hit_limit * sizeof(struct net_dm_drop_point);
    al += sizeof(struct nlattr);

    skb = genlmsg_new(al, GFP_KERNEL);
    ...
    nla = nla_reserve(skb, NLA_UNSPEC, sizeof(struct net_dm_alert_msg));
    ...
    msg = nla_data(nla);
    memset(msg, 0, al);

Because al includes sizeof(struct nlattr) (the 4-byte attribute header),
genlmsg_new() allocates al bytes of tailroom starting at nla.
However, msg points to nla_data(nla), which is located
sizeof(struct nlattr) bytes past nla. Calling memset(msg, 0, al)
therefore writes al bytes starting from msg, exceeding the allocated
buffer by sizeof(struct nlattr) (4 bytes) and corrupting
skb_shared_info.

Fix this by letting al represent only the payload length, allocating
the skb with genlmsg_new(nla_total_size(al), GFP_KERNEL), and zeroing
al bytes from msg.

Fixes: 683703a26e46 ("drop_monitor: Update netlink protocol to include netlink attribute header in alert message")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/drop_monitor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 795c15dd1771a2a5f15e109d0ef2eed967c45443..edc660778408e1bb996124be5a5349dfc9be3568 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -141,9 +141,8 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 
 	al = sizeof(struct net_dm_alert_msg);
 	al += dm_hit_limit * sizeof(struct net_dm_drop_point);
-	al += sizeof(struct nlattr);
 
-	skb = genlmsg_new(al, GFP_KERNEL);
+	skb = genlmsg_new(nla_total_size(al), GFP_KERNEL);
 
 	if (!skb)
 		goto err;
-- 
2.55.0.1007.g17ff1f9808-goog

