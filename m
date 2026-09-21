Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8307143D4EF
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976532; cv=none; b=Dvb6EaG66aZlcZR/OCmLTTVb4+mFB+H4hcgiZPhwhqlwq9QnUb8lnrMsGWfatgvSWLrzzyuDKx8Xz/7Dn1ylGN8aS8oec0iVMWlsNqhjjhP0Zle/hR2AynbbJ0JJZRUwy8RDhSa+iPvFGkj76LB0baBboYy8l3UK7Vfj1CT2CLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976532; c=relaxed/simple;
	bh=+PxWiJGd3qQeg3qY9tqhXy5GvpqL3o3G+lizbAofHcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgT8A3ttYMp4LrecqliVRkhb23V3YWaRCzeHA8fs6fH1V0LeP2vnloiiBO3UFUFpH+APVm+4uEK5YWesax24iWzfwd/NUMMO6gAYDwJNkl3nhblIq2dEOijSkKZZa8n7mEUtFbVpwXXK9yK5W9M8+aka+ewxahs9KeZ0WoXu+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtIfeI5A; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtIfeI5A"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50dc1so1545621a12.0
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976529; x=1790581329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EHgcYtuYemojMdrCO9G6C1IAVKzr+T0NM2HjgpZp/nc=;
        b=qtIfeI5An/RpD16yzxCT1Sak7grlDcQirLRhUl+uXA4hCdgX1i7mKrpnzOFy5GE9NJ
         RktAx2RAXnQqqzMZCbNQ+T0yTTce9MmmGrp60VIcqKKflKepAHm3D3TiuvvAFhl+b9XN
         /eNaY0ZfsR2aff/1vDG0Ylq3eEQ/5jnKdHH8LZ+vFuQoz4Q3pQetRAvL8AyBj09vS9VV
         kCDtsbeO7ikh3JqnZ/i88YkrZzkVMDLMRGoMUw6eK2e70QjbKh54Mlg7XbPfbQQdoHPE
         h/xkA7YDYNMe4MkuaONiJgKpXX+136teBj2PAcNbVkglT2TWilmFb4TSivmvVuAKPtnT
         Jzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976529; x=1790581329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EHgcYtuYemojMdrCO9G6C1IAVKzr+T0NM2HjgpZp/nc=;
        b=QXiO78brKNC5Li6v5HC4iFCVqrx8bvID3sNT9mFprqek3Lnxqi67WzNZ0g17eaRmaD
         p7SeC51W/AR7xBUeB1m2azx9S1nSTBF6G+Hp6VZO8nkgUyeGKZ/YulDnNLjItwqXypS1
         GSkChXQe/KXiXcgzkBNH9PD5YkLzW2OqLKDnHBAwCyMwsUDhcRj1EhBgY+vvF06pW031
         sPJ0ng+VoWVjVQn1VtjUaxNyTFRz04wEnvJoyktvzAGFKN6sktbj4egD6xTrajJ4RBbH
         Tnw5JZPlBCFHUS+h0rh0YulxarZlndw+shcpOR2/RwYg8S+IHqmGWJgPrbJW5/EW8UHt
         noHA==
X-Forwarded-Encrypted: i=1; AKwUvByQO60GqWs8VB03SeOrVQmukFX9uNpjGpMOiAlyoZu6ropO2qIrcRPjkrjCN7HqTZZQk9Odkr0=@vger.kernel.org
X-Gm-Message-State: AFuF++nrGV/u3+1I/G/nL+GKgGp6BoqdybVpJvqZuJEf2sto5qq3dyVs
	aHbYxckr/t75NKJrRqSZb3GOekaLeJCdLCBCwiFtr2WaSoVwSeE2BgmE
X-Gm-Gg: AYBFou0OKQyeRAaXx2DbVi5D5VktAjgHXKGNV4ppi4tycZbgt2yRWimjZgryyTH3Nox
	5q3LGNvSpkdSZcCNFOZ15veQTwA0HQlsxLp9pYxmDmqbWdAzeWNmbM4ZXA0jiW7Wg6Sbx3TODRJ
	taQJBgoJYCodDL1Xb+LK82VRsCdp9PDgZOOY6VhW8vxhBRJYGqY/f6FBi6box2IdoPNt2vV28CT
	ZRfptouaPH+BBuOt+c/EnFY3LckdkMqLlp5IL5U7dG56tUE0Ay9TCRVrV6jtE6luis97/9KOh12
	Rj9HWc/9iDwYoHmNQeYb0J/7wduz9p4NUmeJ4u2qnltDSqWx34yz/U4x7KzDYTFDyMVlrU3dUBQ
	Rg59CVOsAAw96PGkN+Qvy0HvWKRV6spCMuh637uMzJKlTGcNJhP9/Gv9Xt8OU1Sff+gGBtZVs3N
	UWLZ832dK/lkI00Cj5GBX4pENDTcIwrWfWO1IgASF3sdr5OqIYHQ3j8RRAhIKweMc8e9hcyJ3kC
	9ztJefu6Efdms8pL7sS0Nvsf9Lkhkeq16nj3hNgVG2oZ1FdaZLPtrrUw4RVuYfeM9EIEus/15aN
	Dcs0AiGOCw==
X-Received: by 2002:a05:6a20:9c8c:b0:3dd:85a9:559d with SMTP id adf61e73a8af0-3dd8c57fe0emr17599249637.31.1789976529153;
        Mon, 21 Sep 2026 00:42:09 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae70637sm3048650a12.6.2026.09.21.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:42:08 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hui Peng <benquike@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 3/4] ieee802154: mcr20a: drop corrupted RX frames instead of reading 125 stale bytes
Date: Mon, 21 Sep 2026 07:42:06 +0000
Message-ID: <20260921074207.2289391-3-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919213639.3316625-1-benquike@gmail.com>
References: <20260919213639.3316625-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mcr20a_handle_rx_read_buf_complete(), when
!ieee802154_is_valid_psdu_len(len) is true, the driver overwrites len
with IEEE802154_MTU (127) and copies 125 bytes from lp->rx_buf into a new
skb even though only the original len bytes were transferred over SPI,
reading past the valid RX data and leaking up to 125 bytes of stale heap
memory to the network stack:

  BUG: KASAN: slab-out-of-bounds in mcr20a_handle_rx_read_buf_complete.constprop.0+0x91/0xc0
  Read of size 125 at addr ffff888002853f40 by task init/1
  Call Trace:
   <TASK>
   dump_stack_lvl+0x70/0xa0
   print_report+0x153/0x4c6
   kasan_report+0xf1/0x120
   kasan_check_range+0x125/0x200
   __asan_memcpy+0x23/0x60
   mcr20a_handle_rx_read_buf_complete.constprop.0+0x91/0xc0
  ...
  The buggy address belongs to the object at ffff888002853f40
   which belongs to the cache kmalloc-8 of size 8
  The buggy address is located 0 bytes inside of
   allocated 4-byte region [ffff888002853f40, ffff888002853f44)

Drop the corrupted frame, re-arm reception via mcr20a_request_rx(lp), and
return early.

Tested in QEMU with KASAN enabled by passing a corrupted 4-byte RX frame
length to mcr20a_handle_rx_read_buf_complete().

Fixes: 8c6ad9cc5157 ("ieee802154: Add NXP MCR20A IEEE 802.15.4 transceiver driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out as patch 3/4 covering only the mcr20a RX corrupted frame
  handling as requested by Miquel Raynal.

 drivers/net/ieee802154/mcr20a.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index 020d392a98b6..d01b277d33d2 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -790,7 +790,8 @@ mcr20a_handle_rx_read_buf_complete(void *context)
 
 	if (!ieee802154_is_valid_psdu_len(len)) {
 		dev_vdbg(&lp->spi->dev, "corrupted frame received\n");
-		len = IEEE802154_MTU;
+		mcr20a_request_rx(lp);
+		return;
 	}
 
 	len = len - 2;  /* get rid of frame check field */
-- 
2.47.3
