Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE63E9C05
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 09:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117247; cv=none; b=T8QCxtLRyOgik197Ki9MHcJJNRl0aI/8bnhcGKPJKxAfFx8+G5PSrujaeRcH1jL38lR9wx0tJUn6y0rrkGBgMsQAUnBzujQbUUBO6yrgUntTbx0+pHFXPCDR9x+hFP+JoBD0WZN9L3bUB4t6G/wgLp33SfQXH9ciIt4HxwcPJe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117247; c=relaxed/simple;
	bh=Dg54zP3zqsPQVQuqhBBr5VNQGRphMJ/5byAmFv1bRJY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFZWmBvnKXVk6X9DakRab/bTPn9iOWPPi26wwSU1+AvnTjuetW26zl4QTfFYtMLKYWq5pfVA4fCyBCw6ya7NSevPriGMTPaHr+tXP+XZMamBgtX6/ctWxnBUtgl8Oy/EBX9PGHzxIBSwQrctdiat8diuq7bznvTpF9zcj4VtD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQ0+xzKT; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ0+xzKT"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so667120a91.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789117245; x=1789722045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ed503R9eUFLnJwD7ktvT5pxAmED/gsI8SvD8uQZVm8Y=;
        b=EQ0+xzKTEWwP1BuSVYWNVnEC0V6ZrsQJOFdyjjJDcA3SyE4dEA8XyCwzil6oKko5wa
         LcZf7kczaMw8pludQzeHWWAWG/muCKbL25kSvIdqwaStmTag15Rg84bzYMVY6vZwJZIV
         drYaiJUwuNCMw0bE+S4W9CpZFLezhWStkYzP4esxQiv9c5gv5eysKVF8Gm8dSvhtbfFT
         DUfC+M9uXEAhQRfOmRTl1fDRBK07tz8NkdgRkJwVLzv7pKw5O3jFDgvLldJXL6FZApm7
         XymknaWD8MHf2JhjGIEXjxM2lH5HeMmeEb47HjEKbMJDwxt58dLZeFOPKZd+z6owR98b
         /cVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117245; x=1789722045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ed503R9eUFLnJwD7ktvT5pxAmED/gsI8SvD8uQZVm8Y=;
        b=GYtFOEAIFmJWHoUKTFMz8sLiwGT5h8xM11BkZiTXlkTg5f+25JNElLZ/1uGoCdRgu6
         McQG4ZBspd7yXzv9ik0z+4Z7Pw3jNZ8rwtd6pDKwZa8uFblJwwfVT7t+U3g/06RtDTfM
         hQW9Yo2ZrNt6bVPzEXobV2KR7ohyeBbkCuOjfAJWKGYJU7EJiBvMp3iUNCrPilm5M5cn
         Akr+avHhoahImW1UEfAXaB352d5ThcjlskgoYgV7m7TsX9RH2mE3+YAtkKD/YSba5jmn
         YEybyIYQOZAZSfGWnoqtPK/Rkqzx3q53kaVeAgjpCuFznatYzqonxh4Sm6xKkDyOsd5E
         v7uQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhu42iR8fX5dUHw8niuROynzIQjj0hO6GfMzar+U+yCwnnGoZ8ze4fZqpfd0oeuikGwCmBtXM=@vger.kernel.org
X-Gm-Message-State: AFuF++kfK+D77EdgDQTfC+weFLT7xK4zkz40rrIUh1FAPyeVVaGTXJBJ
	MA39McJZsCUGeAys1XeiCc17FKyUUEbm5w9uvT00UV6NHL99oIXQ0Z8a
X-Gm-Gg: AYBFou2KM+bxPeSBLCfCfxLx7j75pdLj8XU+jDNh5EYx5mM1uEpBgNn/cg7lRD5zUXO
	tgHG4N9R0TPTW5CgIqlLC+qDy8NEvBMcVrnIgqJZAkiML0RPKWgN90i7q331YzRd/QP3i6+ws+F
	k+aCiz+UahsLxNI1JOdKe8lfJzvHRCty1CDCCZtTz9nZrTMi1Qd76Kn6nh77gjmqg0guayHR/5c
	4rRSlDViaS6W1zfMwgQIz+X5hr/1XIu3FzH34ogoOBQdv0miLJlF6zEiS7t41+tvXUUBM/SVb0Q
	NpedtAuN6PB/SSMuus9UujY9ZzVLvFIRot7CxLZRFKuR5w6EzZ1/rbfs1rRfMofJhIquXt5FvK3
	Zz2skcxSSXiK1U2B2g0fZp65hi69WddKiu2jIGILb6TJipi9+NAWQP3Csypdrm7Qw6xtc2r6+Fo
	32VKr52YRqehyrTjUKmbDv36ZyuRyvQsr7lYzAQmUegJFyGeOBHQs3AVaMWZbJ55xz/PEkAqb2u
	EBxn6wKTLKh+W48vWUe6rlhUdd5K0A1qcN3y5NJtDszkYo=
X-Received: by 2002:a17:90b:4407:b0:39b:3510:49e7 with SMTP id 98e67ed59e1d1-39d9b99fccfmr5229578a91.0.1789117245124;
        Fri, 11 Sep 2026 02:00:45 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d98e5c630sm4178537a91.6.2026.09.11.02.00.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Sep 2026 02:00:44 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@vger.kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net v2] sctp: keep the association alive across the sendmsg connect wait
Date: Fri, 11 Sep 2026 16:59:45 +0800
Message-ID: <20260911090039.75646-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

sctp_wait_for_connect() drops the socket lock while it sleeps.  An
out-of-the-blue ABORT can then be processed from the socket backlog and
unlink the association.  If a concurrent shutdown(fd, SHUT_RD)
sets RCV_SHUTDOWN, the waiter breaks with err == 0.  Its final put can
then free the association.  sctp_sendmsg_to_asoc() consequently continues
with a dangling pointer.

An earlier version moved the asoc->base.dead check ahead of the
RCV_SHUTDOWN break in sctp_wait_for_connect().  That changes behavior for
the connect() caller of the shared wait helper and reportedly breaks SCTP
selftests.

Keep the change local to the vulnerable sendmsg caller instead.  Hold an
extra association reference across sctp_wait_for_connect(), sample
base.dead while the socket lock is still held, and only then drop the extra
reference.  Reject either a wait error or a dead association with the
existing -ESRCH result.  The extra reference prevents the waiter's
final put from freeing the object before the check, while the socket lock
prevents a new teardown between the check and the following send path.

Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_interleave")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
v2:
- Leave sctp_wait_for_connect() unchanged to preserve connect() semantics.
- Hold and validate the association in the sendmsg-only caller.
- Run the in-tree SCTP VRF selftest and the original reproducer.

 net/sctp/socket.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325e..09fd6b951 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1842,9 +1842,14 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 			goto err;
 
 		if (asoc->ep->intl_enable) {
+			bool dead;
+
 			timeo = sock_sndtimeo(sk, 0);
+			sctp_association_hold(asoc);
 			err = sctp_wait_for_connect(asoc, &timeo);
-			if (err) {
+			dead = asoc->base.dead;
+			sctp_association_put(asoc);
+			if (err || dead) {
 				err = -ESRCH;
 				goto err;
 			}
-- 
2.43.0

