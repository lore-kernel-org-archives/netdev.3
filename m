Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6286491585
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453887; cv=none; b=cCaNuAXttJzVCrpjGrklWVRySxE9j71je+anSBDGeskNDSpJ4E1s6MQaGhibhhuF7vAy6pG8S5pYhznnpQwJCNVZFUKqBHtM6S4D8dWclrjVJtiuXwRY0qi/9FTy188BsT2aZsb1QwzB7BtO0eL6CdvtDoQISoIvdqNXFNtzJ40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453887; c=relaxed/simple;
	bh=IBBWbJgmFH6lJu6+QIx/O2wKOmeF5C3uunKkyAaCrOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HSp62+nw0VdR6IlmZaZ1TqOKaKEAMFRgCDl6qoVfvgn4OVHfQ1/j7GFSBHOQ6Kw6Jh1Lfc9XvhHZsNQGKFVFFvShMLECvOgB9QL/DGiV1l5nJ/4VTfXmAqVk9BEjhrsfthalv7uYYXhzQKSZ+im17xColM8z1KCRfqyq77rvOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvsqKtor; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvsqKtor"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso6313356a12.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453882; x=1792058682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r3Fkc6KptJmnbz47ELueijac4ZeGq0qNxwAnlB3zbrE=;
        b=AvsqKtory3oSFHdQ+EwdbZaQQ5KmBKLfaJPpTc2U8nGA8N3o0xqDvyhBjc1b1K+6RZ
         K3h1XbbBCS/3gKczzPhOBzii1FpazBL4SMJHw6fvsfxLWF4BKsVyEkujfZtMwPXQSfLw
         i+RW6tFFhUC02YuUXGKTjFPCr+HxUuIQooRMH4kMQOXkRxJ/xEfJgv3ZJYFNyfjpsXO6
         QnB3JjPDExK20r1Zm1DpV5aESkKBRrGo9HsKaLt4T6IvrD/gkREuXruJlwzpq4G4G6mi
         gZs+D+LJ+IwqeZFDSa/ax1mg+j/RaGKjKWEUr1hQvlDfKidWzUe+/gJTsnTQIVm2I5Qr
         9yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453882; x=1792058682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r3Fkc6KptJmnbz47ELueijac4ZeGq0qNxwAnlB3zbrE=;
        b=uoWIrVfsazJf+DzcCN8ZxOHwi34kTai2TORGZP5DYLhC4TSjl4Yllwy6f+tEBzUdtH
         LS2Oy3q7tjSwiaXw0ZZb34lCi0JUOn8t7pf2eDHR6kN7d7J6eXTQf/dlvIVQyYC/5e9H
         XNgolxVNuvM9GaToRBumQ2UmH20eQMX78GA7rxB/ECqX13c66PCUSCHx+kkRyC0hHyp/
         +vsDSJrw47cEYmvhF6hko9KmNva8Oum8c5px4KsyZ1qZQDvakgqAjewu3KR+GkaYmc1L
         Kfb45OjTRpN+ultj2SpbOxxJ8VD0uANE9AAkPzsStUOCCzyvU/wdE/LVIqrNVvsjmHec
         VNmg==
X-Forwarded-Encrypted: i=1; AKwUvBw7tfDHjcXDDrL5VfyTWHfcOyVFRjyK5SoDj59gjKuVr3nH5JGA3eMVvS2L0guifUcWl1B4JB8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJ2Z9u2U89qadTCsUuvZwWLFfVFjNO9Zcjrw9EilfG+qhoYf7o
	n7qyzLWSKi5QOwirYZHl6ov1wt1aJeo4/TwvwpJhhcPqO9cjfZyRbYm3
X-Gm-Gg: AYBFou2kZ7Ofbd2XQ/skfnUd3GF1WgdFNgJyFDuJxOidWewcMGP8gmLGNCYAfZ/fhji
	vv6TTfzIvH+PPsQuxE/aUmKsCAUVero1iYrpMt2sjXtOkwmCTHV9HDOysRZ8ZQiCsn8YlKvXell
	V/njLtssy59XtA/8wZ42VFIEk5bRvKlJyCeTcVOr4pMaVbNb5SmnBWfBuwO6CrEZuvMxg2cCGvC
	ABdpWwT41LzNLd83EMop6Su2K1plZ2rr8f/9FFLZ46EoFLE1x9vk0qDXn8irFPH/QipizuBj+Qi
	exsVBMHpqHKPBd8jURx9Wak8BB9Mpw2eveJsfVFbhoBAPAQm/jI59+WNjAYIp/fwmCg7aZfZG1D
	AMoa+BmVbpq6J2eSo+GZYbVrmzGPYjAg5vrJvgmzUJ/+Lei4b3+GOdRL8z1h3weGMaxsAw0Rcf7
	5E2Jr4fIicQM+gJ6FHCu2h1nfKtCulhpeTD66e3hn4x887fXnJ2VyFkomcq14RSIE68pnT6bNan
	lDmXlMxjA==
X-Received: by 2002:a05:6402:21c1:b0:6ac:6c00:bd27 with SMTP id 4fb4d7f45d1cf-6aff27b010amr4366054a12.2.1791453881786;
        Thu, 08 Oct 2026 03:04:41 -0700 (PDT)
Received: from theodors-laptop.. ([5.255.118.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b009c6a4fdsm1176582a12.5.2026.10.08.03.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:04:41 -0700 (PDT)
From: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
To: edumazet@kernel.org,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
Subject: [PATCH net] net: use the full socket in sk_mc_loop()
Date: Thu,  8 Oct 2026 13:04:23 +0300
Message-Id: <20261008100423.1256884-1-theodorlarionov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_make_synack() sets skb->sk of a SYN-ACK to the request socket.
If the SYN-ACK destination is multicast, ip_mc_output() calls
sk_mc_loop() on it, and inet_test_bit(MC_LOOP, sk) reads inet_flags,
which is past the end of the smaller request_sock object.

KASAN reports a slab-out-of-bounds (or slab-use-after-free) read in
sk_mc_loop() from tcp_v4_send_synack() when a SYN with a multicast
source address reaches a listener.

Map the socket to the full socket before reading its flags.

Fixes: ca6fb0651883 ("tcp: attach SYNACK messages to request sockets instead of listener")
Signed-off-by: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
---
 net/core/sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index e8551df8330f..1302c1e848b2 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -769,6 +769,7 @@ bool sk_mc_loop(const struct sock *sk)
 {
 	if (dev_recursion_level())
 		return false;
+	sk = sk_const_to_full_sk(sk);
 	if (!sk)
 		return true;
 	/* IPV6_ADDRFORM can change sk->sk_family under us. */

base-commit: 6d25ffca055a77787c21a36b66c253f76239411b
-- 
2.34.1

