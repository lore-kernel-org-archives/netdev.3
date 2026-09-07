Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255642A173
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788767935; cv=none; b=r69Pr2nYiXNEI0/52wn8ni9S9Sy4R+UBX8nlHTvWzGAsqMpQf/UdjLrmsW9EIYEzYZTH4Kn/NEvQowKkxEjptdgUpxsKSeVmbMprVYveUT6F4Kf/Ku3C9ZN1+0bW5Mj8d7VeZQ/t6OGVj80x35gL42+5Ac/rPsFPCCPkHeoD2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788767935; c=relaxed/simple;
	bh=Xi4QG/BTy8HKRmVsIYHCwIXJHhtAoIkdIzGsesrgmMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nj7lgbE27CwxGW+rBRbjNNphLmjsT8klCYraxMXLoEmXHIbN4CU3rr4Z7q54gh+0qiG/wfovY43mrWhA0K96Cmp8p5ereD6TXzZmKmuvlIhQ92C/rCtDNTkr6T6xhCe/e/R1Jx0zKf9i0IA0G9O6CR++DqVULb2y5RuZLF56TXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QsvoF2Mh; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsvoF2Mh"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5308a3825deso5716771cf.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 00:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788767933; x=1789372733; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0I3J3LwymPulf1lYIwrlJKH1O7QI1ghU+DumRc3rtkI=;
        b=QsvoF2Mhu8pB6MuFdZeQbjqX8Rb1PYUNF4+GtT3H0aRkJGow7O4Ye/u2r50Gx9ACCb
         QF6uToBc1xykSJCmyjDq3Qx8gV2R5AUt/IYV9vrQgLiDS99OYhLuM4NuO72dJgapoqCB
         uEgfMTY+K2MmzhR3s2KnM3JchNBOLvpPqY6LoPEz2FgC7L7Bugocxvq7SVWKvMPGvuWm
         DBQk0YQJtJFqD7ReyqKYrk6ut07I0zGOrU4TUDlkHWimaKNS1EOE7CaJbRqeGLcQBzKG
         EDNEiT9uNNa3j0SHf7O/fRK0WaKiWBTc8F3azxIP94wsJp+yGJKXvQ30QV8EOOVoCGpU
         zivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788767933; x=1789372733;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0I3J3LwymPulf1lYIwrlJKH1O7QI1ghU+DumRc3rtkI=;
        b=f1+HTcpnI+K4mf5phkKHnienxcSLh/0mBZzITxjXFmmCWR6GDr/ud88jYw2a1kpjU0
         O5l65QyLkxka4z7ckMfi1sPdpGKaz9AjV3JMOIpgApwrD6stSaSPcA9oPsjXROWeWNdy
         Ni6sf7CyCWKvAwx+Miltsje4euprqnBSuq9Bnl/VdQRC32H6RSIttB6nLDuw50cqQiAa
         X07leWbnmR9942R8p/X9IF+9jWUZXOUtfSg76wey0fQlXRv6serNv44oETp5cVDnlNGC
         Rsjor4zvfE+bxxrSLku41iVbQXUSEsSbI7gbfbjB7p4kBudNjdwbP1BgxjZ6Xok6Rii8
         sjRQ==
X-Forwarded-Encrypted: i=1; AKwUvByR5MWCllzQwQUQLGQn5ogKurMheSFivvtYuMCPGKE/KX5Jy8m3KzyTdsEVhoCj+E5yw36AvEA=@vger.kernel.org
X-Gm-Message-State: AFuF++lbQersopmr2H4+cs1RuC32dqc8xJ2lej1vLu7zjEOfVT/PYjPX
	saGVIXPTo+/rFPCsGY0aw9JoVd9Y1WxIhOIgFCo3V4tUl+sKXr4KLYwYzB66FsvBt4/cMRvSd69
	fgqdqVr0y0YHI7g==
X-Received: from qttt16-n1.prod.google.com ([2002:a05:622a:aa10:10b0:51c:136e:bd6c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1450:b0:52d:2e0a:8ca1 with SMTP id d75a77b69052e-530549f8df5mr220278001cf.39.1788767932372;
 Mon, 07 Sep 2026 00:58:52 -0700 (PDT)
Date: Mon,  7 Sep 2026 07:58:40 +0000
In-Reply-To: <20260907075846.2913645-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907075846.2913645-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260907075846.2913645-4-edumazet@google.com>
Subject: [PATCH net-next 3/9] ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Artem Lytkin <iprintercanon@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Update ip_tunnel_encap_setup() to use WRITE_ONCE() when writing
to encap fields (type, sport, dport, flags) and hlen fields.
This ensures that concurrent lockless readers (like fill_info)
do not see torn writes.

Also remove the unsafe memset() on t->encap which could cause
concurrent readers to transiently see zeroed fields.
Removing it also fixes a bug where t->encap was left cleared
even if ip_encap_hlen() failed, resulting in partial configuration.

Fixes: 56328486539d ("net: Changes to ip_tunnel to support foo-over-udp encapsulation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_tunnel.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index e6bcf01411d0bcd12cc9a88e449d9283c4a83c64..13b5e35e8790b13ed4c87f28d46aa2bafc9ad72c 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -491,19 +491,17 @@ int ip_tunnel_encap_setup(struct ip_tunnel *t,
 {
 	int hlen;
 
-	memset(&t->encap, 0, sizeof(t->encap));
-
 	hlen = ip_encap_hlen(ipencap);
 	if (hlen < 0)
 		return hlen;
 
-	t->encap.type = ipencap->type;
-	t->encap.sport = ipencap->sport;
-	t->encap.dport = ipencap->dport;
-	t->encap.flags = ipencap->flags;
+	WRITE_ONCE(t->encap.type, ipencap->type);
+	WRITE_ONCE(t->encap.sport, ipencap->sport);
+	WRITE_ONCE(t->encap.dport, ipencap->dport);
+	WRITE_ONCE(t->encap.flags, ipencap->flags);
 
-	t->encap_hlen = hlen;
-	t->hlen = t->encap_hlen + t->tun_hlen;
+	WRITE_ONCE(t->encap_hlen, hlen);
+	WRITE_ONCE(t->hlen, hlen + t->tun_hlen);
 
 	return 0;
 }
-- 
2.55.0.979.g7e5102b832-goog

