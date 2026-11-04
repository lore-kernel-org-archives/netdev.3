Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826484;
	b=X2wQnMvGGy+0vTWohJryUyWaSG0VKU+AwbJe2NwwNHDLK3G+xb54phFM9Q1lhFG1f3CQ
	 VjZ+GblXeZ5h94ECW8XvXnGseP+jT3NJ4+uvavNk65Ppj2W0ByeUzgKB8MFXgRRNuhTqN
	 28Zc5Zd2L8vAYYgS1mjULMDRvpGYaQx6cayIRFOznHLY7CdCmtflPT6tHjOiaNyOspCJz
	 8i/fNdKmJgR6hjjYQ0snsGKCF0CceWX8BtLB42a5+9Qio/DKzmuZ2mUgnN20KQOZfVEmo
	 hdvMmOPDSdJ1LWPEjOKKz01Imp0xQGkvQJwAf79Brrg/b6v93XfLmgb0nqnveZ0IqWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T+rJsZnbhDkmWhQLHD7xKdP1XlwnqJnabAk0+PXTaRU=;
	b=qGjdHNcatWh5AXXX9e2VZ5Sl1jxLk0tPJYAw7xIq9TWDdUf1d0BHa5lqxD9wGu/LY9Re
	 Q93It+ONEPmgNvrkEfbRy0i7tCtB21tGYHdfzPf0fVqXtrwMb0pqKG1RPnqgIFvR8fmDo
	 s5ASMU8wr9EUbmiiMa+E/MP3nTigCzpYIngxZzPIb4fWf1LlLD5AsrodpR1ALENtHVZQ0
	 vRvDn/Bh2fvOVw08RqEWd23aQMX45rJKeoR9d7/sQK7weMIsy3DDPvA2SoFlSX2ZFdUHe
	 kwKcI9AdV1I9kFY6ga3jKNo6SOKUsfj6ep7tmA4V+R1u3b5EO4wBexYftPlhGO+QWwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w3hBO3nj;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583E06070E42
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 583E06070E42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w3hBO3nj
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso8122365e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 13:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793826483; x=1794431283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+rJsZnbhDkmWhQLHD7xKdP1XlwnqJnabAk0+PXTaRU=;
        b=w3hBO3nj7L1QxCpl0VN0c7aFULGMBPeL+I52Ef4u6BaELl9LKm5wxHhYnIfO+QRVip
         jtr/gTnvC++DSgRt+KPL4pB9ewJrdzqVq4dnYXvJiNgSSEku4jjXv8+TUXTv2d9QDTT9
         jSw7pk3iJ5oKV47JtOz1fYLxg0FbdoONeGrDGZX9di/43J6L1StvS8jXTZ0mdBlh9xLc
         T5Qpt0KiAt0VWn3BQO4P17LZaYjicVYSjlbOQG9NiJFzRB7TEBCMnk6d78ADoF8h2WEo
         k0zJNyaJgIhTCuxempZyLP1/xWtOAk/ThEgdhGA3Y/GCWbIbS11HFpdzfMHslEujZzCi
         Zkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793826483; x=1794431283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+rJsZnbhDkmWhQLHD7xKdP1XlwnqJnabAk0+PXTaRU=;
        b=QT9+aT1Ky90g2yymMZVO/cPkUUEOzJKwjTVL6TnTIYSOR3To1k6W27WzFu+WaXP8W4
         /WDQs3qdaICLqhWvcbCXc15y5vzM+c84cQSq4/UgjyRXkRym55sHT3Y9GuWWIO2Srxvi
         gE1bpzoMf/ym6ClxCqrP0MAsfxsdu4agwPf/U1luMJbWEVvlnio0iQY6LxwYZX9zOauN
         9/MKLajhohxhPnXyIPQY9ivsGyqSlsXoI4ssfBZNs97DgW5hhx+IT/pzFxVQ1WOEaYc7
         NDIXs5dhYAwAiDi/dgMvd+M1lOvpMvNgS4ht5+heMEaM4DLLaUS164zGx/EwGwJychJZ
         k1dw==
X-Forwarded-Encrypted: i=1; AKwUvBxyEf+vQ/Z6Adxx5EkC5MLkQRNOAElK0D7k5hjHa05k0A17gGNIOKtJv2JfxxSJwVtx7du/ArI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xdyZC8B6sUyMSaBNBPHSBwbvcaj/Kz5WD+1oN7sADBPaY2iOF
	PjNdDfhmM/TvRP6ssG1GSvcnqOMkTDopzZDtNQP+8SxruKhg2zOereZs
X-Gm-Gg: AYBFou3xKL9JronbPjGTcAbV/8/baBZ4KQ/IT4wAeEFX1OCYew7/tAL/btTmmV5Uzu6
	1Bc+9bHPY+cNK1T1SqhO9sBsSWBa9icsK5edi6mwMyp9pcNeLYhUeNFFTLMoPbg2m1KeyU+ZBWG
	/LX+48I78Z2KFRp8nvMp13kG5wUvx0qidlPcTkVNFmVdJWvV82W/CjXiD8cVYDcqgMcH93VkTks
	kkNgHDozqOV3iE64bJL2nZ5bpzr4rUK8SSLA3VYBTBrxaIK8sJ5QgR5ZLKj0IXElmfQZ9yxUuXX
	VV/P9kfHTIZSsQlG/AbHSuqUW+uyoGUbeQh5ZxmoV0lMFPwqo/JZS4JB64PTXK1ZTJd+u73hfHF
	v310u7SEKnup1GKr+y8hZrkKB8e7TOsiYJWtque7i/oZRjRrI/ZjBDatKhylodPjvctEeZ3yZRc
	k63nf2k1XGe+AXgKSZWBfPTW3shNEYargQHQ5U2ju8cPM1sKhmhrh+Bp9OzAsdUp4FOZxm0NE8h
	2PaMbOqbq8QpWoI5V4tNtmwhoAlWzKWQMY7ka6dHDibq6H3uOrLOamW9yEmTS7br43Lxqngm3tJ
	FWnhMtBWT/PiQbU6M+AWmTHUhVTGOf7ACb5XOtcej8SyTbUvexw=
X-Received: by 2002:a05:600c:674a:b0:4a1:fb23:68f0 with SMTP id 5b1f17b1804b1-4ac14ec788emr386503895e9.3.1793826482549;
        Wed, 04 Nov 2026 13:08:02 -0800 (PST)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:c23:788d:6769:d03c:c916:2aca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e2ae73csm11998855e9.1.2026.11.04.13.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:08:02 -0800 (PST)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yongzhao Chen <yongzhao.derek@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/4] net: dsa: qca8k: read each register into its own word over MDIO
Date: Wed,  4 Nov 2026 22:07:54 +0100
Message-ID: <20261104210757.467964-2-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104210757.467964-1-kuncy7@gmail.com>
References: <20261104210757.467964-1-kuncy7@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qca8k_bulk_read() is the regmap read op. When the Ethernet management
path is not available it falls back to reading the registers one by one
over MDIO, but it stores register i at val_buf + i with val_buf a void
pointer: the words land one byte apart and overwrite each other, and the
last three bytes of a three-register read are never written.

Every multi-register read over MDIO is garbage then. qca8k_fdb_read()
reads the three ATU registers this way, so the FDB dump shows MAC
addresses made of the VID and the aging field, the search reads a wrong
status and port mask for the entry it found, and qca8k_port_mdb_add()
and qca8k_port_mdb_del() write that port mask back into the ATU. With
tag_qca the management frames carry these reads and the fallback is
rarely taken; it is taken every time when the management conduit is
down, when a management read fails, and on boards whose CPU port is not
port 0, where qca8k_conduit_change() never sets up the management
conduit.

Store each register in its own u32.

The bug was found while bringing up a tagger without management frames;
an LLM assistant (Claude, claude-fable-5-1) helped write the fix and
this description. I reviewed both and tested the fix on a QCA8337 behind
an IPQ5018 (GL.iNet GL-B3000), where bridge fdb show returns the right
entries with it and garbage without.

Fixes: c766e077d927 ("net: dsa: qca8k: convert to regmap read/write API")
Signed-off-by: Stanislaw Pal <kuncy7@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 07227ae8bc..1242ee3469 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -519,7 +519,7 @@ qca8k_bulk_read(void *ctx, const void *reg_buf, size_t reg_len,
 
 	/* loop count times and increment reg of 4 */
 	for (i = 0; i < count; i++, reg += sizeof(u32)) {
-		ret = qca8k_read_mii(priv, reg, val_buf + i);
+		ret = qca8k_read_mii(priv, reg, (u32 *)val_buf + i);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.43.0

