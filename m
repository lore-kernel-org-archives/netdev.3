Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975D527B343
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548328; cv=none; b=c+lv2Pb6nyQsM6ZryTCc+ZZD29FNoXzzZzS/VNB7xFWVOZnZEDUDiHslIst3uTu5LTzeUfYmR4GC/LO+NZZNmBgIcta3RdJYTsY20jgIKS3uk1xRAQc0h5E82TUqQXyCT1VzP6WUkg/b36YcyeLrK4x/iGa203qNRWx956bjJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548328; c=relaxed/simple;
	bh=eD8nyVXkZwMwGzh3I0wUPK/ud6m2CBCzRd9kRJo/mnY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qaqgDUwsDZrCmI/OgvyOaJMZaDTGV6JdLpyELnNQCXDa812yf2BbggS/vVZXq/r/Ww3Y+9maex0UmUK9L5r1AUWr7Zm/5vQOTO++mZH+/tZLscYcav0WrnJXmZaMdNYKItciQzAX5CnvOgZ30al+9Sz3ohQXxNgGa/K8sPewVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xfsA7Urp; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xfsA7Urp"
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-502a341e108so196195801cf.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 13:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769548325; x=1770153125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TKTMp36nXJ90LDZGAgyXsU9Pk3eOSmaxr0RKSdnePeA=;
        b=xfsA7UrpYmvrD6flfV3oS5V8l6JnJ0POIdfgK+qPKa5mCssiSkmy+k57G57O2mwL7d
         B5Y0AddnTTqUkHsAtfm/ZsjP+LVix+nL6uytW/j9lyo5cb+RjFL+txoR2z0wrVmvNvvl
         xOY+Et5O3PwMbasCQZks7ldX/ij2z/pd3FoiUjLirFYXmoYkZnddrNUj7gX4XDLG0xW8
         DB7Ocpp36NESmJyjPoU1zZ+MTiZSUqQlxVkeocEaTb6vyqpyeJs/q4IsPU0Xea/blSJU
         vocRGsA9K5HZ2q3lfmCOlWowdjcouEXwZXaX4SIBtUfd+uWm97CylYg+kZ0YvlJPxlMp
         iDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769548325; x=1770153125;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKTMp36nXJ90LDZGAgyXsU9Pk3eOSmaxr0RKSdnePeA=;
        b=wvQ6kECJFE/eK91UPcWF+FyYBTfUrLrDo8gOqDisrOat3ZKO0wMpk3he2wi3ZlGOwy
         5zdOfrZ2ihpUHfDVLJfqKCUERYVdfC8ZZy54dkBFPg4vOhnd28BeJnzk1Arfyf7cuIvJ
         EXpBiz4NIRqZvTPk01zTjg2Wm0Z5JFkqsW2jquCfSrjP/OY7om7R5sldyTZBMrgW/zKq
         Ad2PgoCpZcmy5AfU9VtWivsq+KYE5Q57jQ1HFwuybpGeBdtJO028HHwef9ALaOulVhfe
         8Gb1nfbTUhFqxzEHbTpuE95YmuR2upqLDlmu3yRMswgtSnquxSgTWy/Q5FzlsvOFlsmn
         vAPw==
X-Forwarded-Encrypted: i=1; AJvYcCWlgWjH3z/DGd934w16Pv1DLvdPebSsNdeMvu6W23krbGmfpyZOy004FPSzJYDWyqwhChLGNpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ/h+GDckDK/Rn0zUtccJ4qlyZI1xjGNeRwtJAPvM1pLl+VT6L
	hBRbO3BKw8oxtjhVSXLv53YKpkG7pletApFNnidPFmnGRuM6YvNH+fgIqQKnWX8dCWukGfJkqTc
	HijzF9yWocAVhIw==
X-Received: from qtpe23.prod.google.com ([2002:ac8:6717:0:b0:4ee:26bd:e2e4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:242:b0:501:466b:5141 with SMTP id d75a77b69052e-5032f87f885mr41606611cf.18.1769548325589;
 Tue, 27 Jan 2026 13:12:05 -0800 (PST)
Date: Tue, 27 Jan 2026 21:12:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127211203.1524339-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: remove __inet6_csk_dst_check()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

__inet6_csk_dst_check() is a very simple wrapper with no value,
it is used only once.

Directly use __sk_dst_check().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/inet6_connection_sock.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 3aedd51c9bdb18b3b45ff3f6b56666e2ffd1f515..e30172e634a64d85cc774d1cdcad1ee36c1f7e7a 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -55,12 +55,6 @@ struct dst_entry *inet6_csk_route_req(const struct sock *sk,
 	return dst;
 }
 
-static inline
-struct dst_entry *__inet6_csk_dst_check(struct sock *sk, u32 cookie)
-{
-	return __sk_dst_check(sk, cookie);
-}
-
 static struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 						struct flowi6 *fl6)
 {
@@ -86,7 +80,7 @@ static struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &final);
 	rcu_read_unlock();
 
-	dst = __inet6_csk_dst_check(sk, np->dst_cookie);
+	dst = __sk_dst_check(sk, np->dst_cookie);
 	if (!dst) {
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 
-- 
2.52.0.457.g6b5491de43-goog

