Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB4E4AC153
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211214; cv=none; b=WGe+ia7bTy9E9msBVkazjjrJGeNk3msN1rDQ26trN9cdaVlec9+ohoUu1kKVZhB9T4EcsEFdSaQS075eG8qI2uodIUrnSRSfplabldxIITMgibUqEatNhUvdL4e426CKyrv3w0KvYMUcjKu89osH6ZIJ0ttrdJaV1brDq4ZPcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211214; c=relaxed/simple;
	bh=bc3UIeJGXymNWzviGzi36dDwbhBuh5YOUZaBLyslBh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaSbTW9lLqmyiPfNRzZ/XPkWLB7AfSg05gEZFDiYVfQk/nGMZx35X/wv8mHaGkDkEqS3cd2l9ZDs3472rI2Pvgupxsb3oxWsal2uLuF11RpMNrAlY7Y4kqFYsrVxb8cwKyC2RYVKQopovTa7rFQC4gOebMFf4BRR1l8QUZy71jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=L94tzlPE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="L94tzlPE"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b02a2359aso1018516f8f.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1791211196; x=1791815996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xM7Nwx8pyio9tSiG3XrEnckcr2m2atmYD5UuxvLKzZY=;
        b=L94tzlPErAcNlwBkjh+jS1z80WOmsOWuaYCj1UnMesNAm2pmfzuCTYrqpcLN6jgxMG
         s8/s1y9DHRgE8SNbvZfj8DRkXLE+FrRewvR6FV0BzeYK6fmYT0jinwMunLbAMwGhJKA2
         RfdKY9M7pcYc2DvaVHXj0OisB0P8WUQ3wgCz2ZnIo4kUFKWOEwsjWxoqQJtkOtdp0Zpf
         fy9sw0itMcYhowmu8l0t5StX5tM1uu+biAZ2ePMYE9ytxhmzzmH4ebPFxYMqR9RdXKxZ
         cf33jhm7e4lqLKGGNy7cbSM8Pv7H2e6XwyJhjKJm00L70Rq50VRCoIyyN7Jv8hWd85nP
         89yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211196; x=1791815996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xM7Nwx8pyio9tSiG3XrEnckcr2m2atmYD5UuxvLKzZY=;
        b=ebg5VBYs8jftF5uyCWNrblnxUNB1ddJYZthE6bauLOB7Ibcx4XfF4grpS+elbnbj/A
         UyW21N5Zy5vmbs6yPlCgR8HimkYP9x+eV+ZZ9IszjG8aNBpSof4sxjyKfHsuBwN8a7ME
         TnNeA0fb4Ri7CuBZY1KHiIpLHFDq8u2DQAFp+OZp4WJQWJpO6oT5aP/iY0rEra1sCsAg
         JTBJsbpZbb8PcwFwptROIJ7P1VO5RKodmYNFxqZe1eDy90uaqC2uFhNZKnMTXFCkMWO7
         elimO7q+Tg5cNJvcBS5kNoK6NpevK0fuQvZCRR9KaX2LHCXjFwlhZjaH26NtoKrQyAHL
         3tGQ==
X-Gm-Message-State: AFq9FYJxxap7uqrHXxmdGPzfm5gflfz6orCgQlEzAFfj7wTowpStALeP
	uUySAKLgJxC1Zjwq5gZO0K6fGEFFYsO4p8URxlGbKJL4cggS/orQ9hvF6H/YfAVugGdIfFoRHCD
	/E1T1
X-Gm-Gg: AYBFou3+RAbLAoqbrdrcHCRDrIjCHevxnoBOCXS3XHR3vSrZ7vlUlYt95fTKBQeTPDn
	Jdh5tAzn7L7vgqz1+nGHP9FqRCFi0mFgFlYI3ZIpjNtV82dubfvcGIMBeomBe7gPdedxik8aXu+
	v5GrCBIVeAtqTDlSORh+z8XK5gz6V+YAF5wPpZqmR6ZU6RfBze3b0UkK6m8C+69Nx1Kk/BP+eih
	ES21mWKpRHTd2l38Pv00HqQQlmb6iu0yeGl+sdEqYAPUe1YUZDer0UxFex21UurQ7oORw08s42s
	x/f4d3uxqutjXGhZkFPHJbW2fgyfYvpNSrQ1qaPf30ev851VxrzL857tVKW34Zxjq9HEkl9YWaA
	pcj2r6zhdB31QZpr+1kt17T2t++7ESFqeb19hEepm/9i3bJgTgIfMfpHJbVsCSgaws8VQX6zCNI
	UlvqVhuLBCF7p8V9vvdCK38+5kPKw3hNsBFT8nJueZncCrES7IbtjvJuaFl6hh4074JI9+y8L0H
	xCrydJ9coCMzP/X2hSx
X-Received: by 2002:a05:6000:648:b0:48c:55c1:fb47 with SMTP id ffacd0b85a97d-48c55c2040amr9419659f8f.10.1791211195153;
        Mon, 05 Oct 2026 07:39:55 -0700 (PDT)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48c622704c1sm3388213f8f.10.2026.10.05.07.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:39:54 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bridge@lists.linux.dev,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 1/6] net: bridge: rename dst to fwd in br_flood_vlan
Date: Mon,  5 Oct 2026 17:39:32 +0300
Message-ID: <20261005143937.877466-2-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005143937.877466-1-razor@blackwall.org>
References: <20261005143937.877466-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename dst to fwd to be consistent and avoid confusion (dst is used for
fdbs).

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_forward.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 82645db32efb..54365c6104b5 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -291,7 +291,7 @@ static int br_flood_vlan(struct br_fwd_dst *prev,
 {
 	struct net_bridge_vlan_port_array *array;
 	struct net_bridge_vlan *masterv, *pv;
-	struct br_fwd_dst dst;
+	struct br_fwd_dst fwd;
 	int err;
 
 	masterv = br_vlan_is_master(v) ? v : v->brvlan;
@@ -301,18 +301,18 @@ static int br_flood_vlan(struct br_fwd_dst *prev,
 
 		for (i = 0; i < array->count; i++) {
 			pv = array->vlans[i];
-			dst.port = pv->port;
-			dst.vlan = pv;
-			err = br_flood_port(prev, &dst, skb, pkt_type,
+			fwd.port = pv->port;
+			fwd.vlan = pv;
+			err = br_flood_port(prev, &fwd, skb, pkt_type,
 					    local_orig);
 			if (err)
 				return err;
 		}
 	} else {
 		list_for_each_entry_rcu(pv, &masterv->port_vlist, port_vlist) {
-			dst.port = pv->port;
-			dst.vlan = pv;
-			err = br_flood_port(prev, &dst, skb, pkt_type,
+			fwd.port = pv->port;
+			fwd.vlan = pv;
+			err = br_flood_port(prev, &fwd, skb, pkt_type,
 					    local_orig);
 			if (err)
 				return err;
-- 
2.47.3

