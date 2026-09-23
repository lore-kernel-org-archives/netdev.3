Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A939A80E
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790152339; cv=none; b=NagS4GaxXCs2scUfr8zsnd9Uihgm0PgaCfTJdXBYXAt0XViW0JmErtYzE/frzV5bro4N9GK5TkbutHj2HMHuXQfchN4K7gQ0NHJ8umcjLcnxOBWH1m2OL5zaDMELGr9DSFzIRFAREYkntnb7hec3dX5dPZubwNPMe1OmBUluC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790152339; c=relaxed/simple;
	bh=W3zg+SCvbnCMjnSlyLZFIfnhqVcfPWRSc9UjP6/deUI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bB1ebVLk2Ck04ayBDAttg/aKOLL/GT3bg7rU1TBbL14ppQGP9Ehc0d4s2Wb8+/Cf/hIh6qpJAQ5k4t3BMqq36THkxwMWFhg9y7er7ZiTZ5coQPDkLFjfe2nwKAPXN20tGn3dcSvnaJ17EGidCSCv0mzpa4QZoYjserG8wtzcpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QUV/wQhx; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QUV/wQhx"
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-532dc3793easo23899901cf.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790152335; x=1790757135; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=er3VVVQVzXkiOXwUjNNJomuF1cQrw0GssH0oG1wrCuI=;
        b=QUV/wQhx9ISzARJa++j3bRSj509Y/y0a5XzILVrqnzpMXDo7v2ljZ2wJNxhk/nEJLG
         xTf+0eoSeZG3eiMuusqp7ypH/MBwI4t0VAANJOd8QtsocXn0vnQdM0vAS64/h278/6x+
         SU5sJh6mnyhzBI2JM5NS2ceRP48Y/ouramLAS1nBUSQYoXZE7c0cE5Lu3cuFCVLTybca
         l37rrO2PeWluwG6c3DPlssTvIlQJeFQzVs8E0xjbrURoLdzvZR9w9RWW6ifnQwvky6g8
         /M2LLXswNa24GZOt+QME0sQwvrAZV1M9Ss91Ug1xalDqbPDcJAaKOuxK+4/z7sIfRoGr
         uDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790152335; x=1790757135;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=er3VVVQVzXkiOXwUjNNJomuF1cQrw0GssH0oG1wrCuI=;
        b=Zl2NuhXyUqnp07rEn6Zc8CyDHzm0hmGVtHKnBhHRzrkG03YReF4Zq2KX9cmQrjRm0Q
         a6+JLmyi7QSWG704ELWAyo37j8KcRJOKBaal8YBFiiSYb0wDQjZbPz6rar9eKulQYpGT
         QfGvq+CU9ss+yuxIz5Bblr1tY3C88EI1vVC7EjKhzEO71QiCpt9dSTlfCek8+1vZO49u
         KxVqg09sK3c86Gn4VFKbmwoBbWYo81vZJcDbFIqBfGNDiKNhf1gaOk76G472g0gRhmak
         +0QLmT5AFYuzw5fjWQZkn6tFrF7hD/jgKdSM/8fkYbZrXefdefnPOQWs6ITlyGlCZBLv
         0F2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwQouHcwsFkShSh5m1ewh8U3dUDJhCvuM6U5PDis7SQjjvsOhST6bJiu5OJHpy/VrsU1XQFksM=@vger.kernel.org
X-Gm-Message-State: AFuF++kacJqpZPcexiwGz5ZArQiNemd1FV66WxGEAoHmAz7XIFQbKAOl
	mtarle9l7Mx/ColqEklKmayGSdjQSlgpelHu8cKwKLQhJWZmbOxaBQ/VJaeLoDe/TE5KWAeL3gl
	PRL3yL/9hoCUuTw==
X-Received: from qtbk6-n2.prod.google.com ([2002:a05:622b:46:20b0:532:c925:c324])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:180c:b0:531:608:1010 with SMTP id d75a77b69052e-532eb5d3418mr29216331cf.26.1790152334795;
 Wed, 23 Sep 2026 01:32:14 -0700 (PDT)
Date: Wed, 23 Sep 2026 08:32:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923083203.383923-1-edumazet@google.com>
Subject: [PATCH net] MAINTAINERS: update Eric Dumazet's email address
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	edumazet@kernel.org, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

My @google.com address is going away soon, let's switch to @kernel.org.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .mailmap    | 2 ++
 MAINTAINERS | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 526217c884951de479bf5013a6cd001d2d5cf69d..7dbfc4a16a819f9536acea10688ae94d35231024 100644
--- a/.mailmap
+++ b/.mailmap
@@ -286,6 +286,8 @@ Ed L. Cashin <ecashin@coraid.com>
 Elliot Berman <quic_eberman@quicinc.com> <eberman@codeaurora.org>
 Enric Balletbo i Serra <eballetbo@kernel.org> <enric.balletbo@collabora.com>
 Enric Balletbo i Serra <eballetbo@kernel.org> <eballetbo@iseebcn.com>
+Eric Dumazet <edumazet@kernel.org> <edumazet@google.com>
+Eric Dumazet <edumazet@kernel.org> <eric.dumazet@gmail.com>
 Erik Kaneda <erik.kaneda@intel.com> <erik.schmauss@intel.com>
 Ethan Carter Edwards <ethan@ethancedwards.com> Ethan Edwards <ethancarteredwards@gmail.com>
 Eugen Hristev <ehristev@kernel.org> <eugen.hristev@microchip.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b2eb2a7a89a88c83f1ecf242189544f888c9bd6..dd2642c546d3c84039b40dcfda7e1a332cde6506 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18881,7 +18881,7 @@ F:	net/core/drop_monitor.c
 NETWORKING DRIVERS
 M:	Andrew Lunn <andrew+netdev@lunn.ch>
 M:	"David S. Miller" <davem@davemloft.net>
-M:	Eric Dumazet <edumazet@google.com>
+M:	Eric Dumazet <edumazet@kernel.org>
 M:	Jakub Kicinski <kuba@kernel.org>
 M:	Paolo Abeni <pabeni@redhat.com>
 L:	netdev@vger.kernel.org
@@ -18998,7 +18998,7 @@ K:	struct\s+phy_port|phy_port_
 
 NETWORKING [GENERAL]
 M:	"David S. Miller" <davem@davemloft.net>
-M:	Eric Dumazet <edumazet@google.com>
+M:	Eric Dumazet <edumazet@kernel.org>
 M:	Jakub Kicinski <kuba@kernel.org>
 M:	Paolo Abeni <pabeni@redhat.com>
 R:	Simon Horman <horms@kernel.org>
@@ -19224,7 +19224,7 @@ F:	net/ipv6/seg6*
 F:	tools/testing/selftests/net/srv6*
 
 NETWORKING [TCP]
-M:	Eric Dumazet <edumazet@google.com>
+M:	Eric Dumazet <edumazet@kernel.org>
 M:	Neal Cardwell <ncardwell@google.com>
 R:	Kuniyuki Iwashima <kuniyu@google.com>
 L:	netdev@vger.kernel.org
@@ -19257,7 +19257,7 @@ F:	net/tls/
 F:	tools/testing/selftests/net/tls.c
 
 NETWORKING [SOCKETS]
-M:	Eric Dumazet <edumazet@google.com>
+M:	Eric Dumazet <edumazet@kernel.org>
 M:	Kuniyuki Iwashima <kuniyu@google.com>
 M:	Paolo Abeni <pabeni@redhat.com>
 M:	Willem de Bruijn <willemb@google.com>
-- 
2.55.0.1082.g2b9226bbc0-goog

