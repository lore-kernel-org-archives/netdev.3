Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386C5370ADF
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394199; cv=none; b=uM7hgzBXpyOCIT25qrOsM7LfJ4PgmbiCqDMe6vTCgQhGU6xJhrxH4u+U2QE5RQm83tpB5qUeLFsR27lsKe6PVYkKJgJN4hYzy0xu+4yZcMqACYnG005OsgKzm7i0SNpgR49heUEuHMT4qlVkxt4c39wDqnGQUQTkZkOpeiCai/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394199; c=relaxed/simple;
	bh=nxcEIJsP5P568+JqspaC5riVmJMyvmOUZ8MmoVK6k4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jY3ik8RUU3IfFM3I5D6wT4t2tSYWtVs4j6Sp3SFqh3R0hQ0hUBzjYWBG1K3RKv/32EwcRp0hT1BmMusLuUud48rcNc8K0kKMAADMyWdp3C6qVM7p4gBzBTy46PXqs9QhAC61gWiL+1RG4ileVNM6McmZl6VAEOJoKEnuws+LqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=jELXcHWU; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="jELXcHWU"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917997ab0d9so20884966d6.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 10:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394197; x=1791998997; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ulf4knBkH5u1TnqCidkxaqLV4+gGgnRz6zb0SQK2E4w=;
        b=jELXcHWUKU643dyRwTkXtJw+kClt4BKIxhjIEuFqqg3pqoXH9TBv0+9Y6Gke98T9vT
         UsEAxkvAmlJ46I6ywBuf8vU8Hbl/zlFTz9d0MKL6869grSzYxIxEtZR/wXPuL0CLhHeu
         j64hhAUjDVP3iqGpzv3BtMlIkE9RUhqQPMZxavMfP7ZEZS/e101snUYzfL9npTktOhkt
         5nw7IGUUcZ9+W4dGcM8QXtksaWsNUDCb1ZlWlb0i+FGMU6V/w8B28Leqv0zqUHMpBcAs
         zNhDhidDtwmfYrAxfI1+5i43sMZb3msLnWyT1ezsZxA5E3oL03ssttzL7E4ybFKByBYw
         77RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394197; x=1791998997;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ulf4knBkH5u1TnqCidkxaqLV4+gGgnRz6zb0SQK2E4w=;
        b=KBF+uYA+JuShw9KhKIJb9r5z5S4gLKdk8wDT9G0yvc6J0Rgdk4iM3gY0wm5ZqCr6ub
         jy9mkmMFZwuIkj4hTjhpGk8bTZp2OGZh8lBRGzUjBgBm9w2kHXln7xxLuvoftEad+txk
         Y4QnLXPVJcmsN1H0Ylh7ScS0Kile7K/Jmo/Exp0pK7TcykfHbhxgLkQMEqZgzCTINpqG
         ej4whX9QV5xqcns/3oulo/k5aIc0BB7jdKJZT9EedOS6IzGfUiryjIeJV8mmrGASHeIv
         wwFoU+oUAONmnajmfvi7bjDUlOec7s85dfzsrhpcwvyyexfwQsSYyhmTw+Su3kJLzbjy
         rFdg==
X-Gm-Message-State: AFq9FYKM6zLlUMkAC+kxbCaZQrcXYhBe5PA8COg3aCIniBbJigqs1CDU
	EUCtU+/0mzqbAjYU0CQgO4E50zKlpn4DjxRGzUJqT2DgTiXrkD9kF09l8fA4mkFMyT4=
X-Gm-Gg: AYBFou1f2Dlr3S7hlGVqksdZ1ezjjMCJOJY7RRJPVciYg7z9nsmRTMKBx/4Y2fatvzo
	K/NkM+2frLA3nVIXH8uMU4Vbauftws6nN4E9htZdVkNc2biRk7dxfqLK6iSKFGEJ2Ym8ENlWEyN
	cCENSXOmAeoJRIgLnmxa+39i+3msOh8j4bKK7etLUAxP9hb8USvIZwpQTqxY/DY3Ya8HsJ4/oio
	zoWy8wIVXfevxMNS1wzn/AJr7EQPL8FdzvG8/xe5vmChY+X2k+EKBac9BOtAzRwRyv14FxlaoJi
	3R7M+Ay4e8OxAOjVSt2Y4BY41V9DscKtd9dLO7eQT4DK6lWCpsHcXGeW7QzWhLOeIKmwpPhzCse
	Ha+RJKiYO0YMPSaH/a9VA3DDKZhbspXKizobQVrURUKi+l8Wuq9jAmWjYAvbCwxPumWhSbgXzzc
	zI1TydskN0Ogiy5zGKi+TFT5/vUUaKcuMSczn8gTs+3PfhQsHcWzisH/FiRXAB0bCGu7ZQESAwb
	/f9gmNWIyNgoD0=
X-Received: by 2002:a05:6214:451d:b0:914:4129:92de with SMTP id 6a1803df08f44-919976b94acmr54775506d6.1.1791394196971;
        Wed, 07 Oct 2026 10:29:56 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996d0556fsm25727146d6.22.2026.10.07.10.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:29:55 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:29:34 +0000
Subject: [PATCH net] net: skbuff: don't leave stale bytes in
 skb_copy_and_csum_bits()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-skb-copy-csum-stale-bytes-v1-1-adbbde033fb3@toxicpanda.com>
X-B4-Tracking: v=1; b=H4sIAH2BxmoC/3WNyw6CMBBFf4XM2gkPqzX+inHRqYNUsTSdYiSEf
 7fg2uU5uTl3BuHoWOBczBD57cQNPkO9K8B2xt8Z3S0zNFVzrKtKIymUJ6EdwoRWxhdKMj0jTYk
 FFbWadL1vDicLOREit+6z5S/gOcH1J2WkB9u0htcZGcmFaLztVtWHklS5yb9XsCxf9OZ47bwAA
 AA=
X-Change-ID: 20261007-b4-skb-copy-csum-stale-bytes-4bf7b713258c
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
 Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394194; l=2000;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=nxcEIJsP5P568+JqspaC5riVmJMyvmOUZ8MmoVK6k4E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMRBnjw/ta2UpP2RDQp1kaRlRViFZAVb3ZvXE4JKuE81FPw9Fm+YTe89rAnJKPUv4QeMME4FEqF
 +mbfSHILnggE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When skb_copy_and_csum_bits() reaches unreadable frags it returns 0
after copying only the linear part, and the rest of the caller's buffer
is left as it was.  The callers copy into a buffer that is about to go
out on the wire: an ICMP error quoting the offending packet, or a
driver's TX bounce buffer in skb_copy_and_csum_dev().  Neither buffer
is zeroed beforehand, so whatever was in memory there gets sent.

Zero the part of the buffer we didn't fill.  The checksum usually
won't match the data any more, so the receiver will usually drop the
packet, but either way it no longer carries anything it shouldn't.
Only zero for a positive @len, a negative one from a broken caller must
not turn into a huge memset().

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
This was patch 1 of the skbuff BUG_ON() series; Willem asked for it to go
to net on its own:
https://lore.kernel.org/r/willemdebruijn.kernel.235bf1cecf85f@gmail.com

Tested on net with a module that marks a nonlinear skb unreadable: the
part of the buffer past the linear data is zeroed, and a negative @len
leaves the buffer alone.

Thanks,
Josef
---
 net/core/skbuff.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 4aea06d5167d..41beaf625421 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3633,8 +3633,12 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		pos	= copy;
 	}
 
-	if (!skb_frags_readable(skb))
+	if (!skb_frags_readable(skb)) {
+		/* Don't hand the caller a buffer with stale bytes in it. */
+		if (len > 0)
+			memset(to, 0, len);
 		return 0;
+	}
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;

---
base-commit: 23609bce9e1de525d1d0e73fc68c6e7971d0b49e
change-id: 20261007-b4-skb-copy-csum-stale-bytes-4bf7b713258c

