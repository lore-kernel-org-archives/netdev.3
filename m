Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621379;
	b=StvsHO3IIM1xBfuHkcvrBJECMswuRPgc4ZlXoZm0Kh+Cx7raUPTEcwlVQgBp4EzDs6Pb
	 QTJRQGOOJZXTOGdtBQB2GGdF6v2ggzFcUeM3vXZeiHpTrk6vUY1MrbmMfthgcEnRzfQqV
	 hucy3Vdma9HDQGQ21uQd1VHWMgX9s1U5R/dxr1skZwkUOWCLtG2r3BfOM9TfSRVe6V+mF
	 MBwNx7TaocmKXL9DSCNO/kyl1E3sfB0t9XqhXGBEstLpgQ3Cv6JskSICKxVHd5UAJ5f6Z
	 BhK7+OLbrJqRX9c7M6SLMdjCgyzXqVh+pu39SB6Fvb5Pv+RFfOh3WLHwilzRlBtpiAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=h4bBhShGgMtgvUcHfjYjgyBrngfAAZXiORF9a57vGdw=;
	b=lvQyTeH0Fq01u2appHaEiC8WRyxvBbUNpNC1LodtV/O4tjx2KLS/S6v8mVQFztRJrlvh
	 NXXjIF8GMNfDQbeRpY4RVAMivAYoHsfB9PqtxCVno6482IWK1frJotpuXz5yagytBjaTg
	 5Liu/Nc8O8K1ZxhCjm6/ZjSCVgdEy20Z6zNXqdLUNqhiJV3jewr5KlAjlw0+VsITIi+jY
	 h5zH3cf0YkPuyLQU0+N0yRVfkW7MM7NVFOwkvrm/JTMxpTEYxW1ITnlAqKX/2Kjh7261Z
	 omUbnaMW7mm2YftdZIhDmExtZ5DZG/fyayqaMEWGdESnOKxp5eEd3A2Ymlkf6x48psA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fB86neL/";
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720A606A32D
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 12:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7720A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fB86neL/
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4f699fe49b3so1854062b6e.3
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 04:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793621378; x=1794226178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4bBhShGgMtgvUcHfjYjgyBrngfAAZXiORF9a57vGdw=;
        b=fB86neL/9KY0NOgH68tG86XXv5ZntiyY4QRbMv1Q/zJ1/20+tKVOIgyOG3j+qP+dWf
         qC36ZFZOEYas9LM2el3mRFDkmLHvZumPInEqCstb93Sa2Jp5fqcsh/8FdwHb6tiuABaA
         5HpT39BRa4aVs5f+eTRHtbhc1h/n+7kod2VBmW9FQysby5uXYLOCMmyaLmxvRtP8uF2r
         KCXqp410+TmI5uZCkjCNzm47gNY4Bi7Cd2bnD0nuEEz4eB+i+Q8tTkfkepAYZ5xuWaki
         wnlSoRlj4icbjoq4n6fp3VgOUGMU1bRfzfy8jLvRFeOuyBO08rZhgzKzOSifbcftpo7c
         vdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621378; x=1794226178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4bBhShGgMtgvUcHfjYjgyBrngfAAZXiORF9a57vGdw=;
        b=Wk0NN3rnbUY86FdxqIkE+Hv+PoRPYOsVZ3Tbc3D/0VGJl27Ay9JpJEknc4wzNoFHUA
         TaLKlYQoUZHYhVBX+lOkqae9iVqeNN8LOOgf/Q3uG/LNJrlpptGlrHxU3pfl32NPHqTJ
         v0b8BJY2iKoT6o8bmqtiPjJo3zRuP9RJ0/0s3cbATs78/s63qGOLaLnrqNIaay+Zm/+H
         7Svayr2hMHw+jAtSVb+BYnz/jFDqK0KtEsfiV1JYR2wIPy3YXfALrgNWUOFYAlU5X1Sh
         ds1STcKF+QiSggaGyYZO8vY5HfRNOePKM9wgurqwbsiGbUBnaT8vhJQ1FCoUQHrgKi+A
         SHXg==
X-Gm-Message-State: AFq9FYJKbgByqb4RZEOYDAeMeXEqz1BVwErfEAZhddEW2pgc6sjWbTJZ
	TlU8PyRsLdqH3QYpe3YSRShx8cDymQMNSr/LHqhFXch3SLfZmqWKAWxCcvZuVA==
X-Gm-Gg: AYBFou0zGCQ8ocrPkZJ7TAsHj0Nwfg3OCop6J6ChiefttjIDgHentqMBs5U4O28taF/
	C59/Y+7PJcWjKVEufaRzy0UXSEhi/LWojTTXiJcVDz/7ILYSx1+jtX4nFD0pgQvhm0OJXar/Mq0
	iJCBawzRaKoGwTc7I2gChCiBgbywyjohTiIZa9Flwo1Du03Fpx3P2g3IuB0mkj8yN1HY+hC+ASC
	RS4Pk2wSGOFjFoucIbtLja2p1FKVSd9zuVilD9joNFDuggv1ef7tFo3mFNke+mO/tGuZA/a1emo
	ZXfcl782DfuSc5SsT1wqqP0bnnwL1MK/yvxMsjFuT+2qn22zbl9IflSsndXKkelZJw5fupgkrnU
	9eI7iFnQvjBJgDuTHEOVSBRm26uKB1eyN/XfuE68D2SNDhEFU5k12oej74pWdMmtcG1hAM3axNV
	YLsOjgGvHPM7vGtEEf0toL+Q21ip/paVNwb3S2Vkh8mjbGqw9SZy5gv1E294t0jcYbvU4e8pDL9
	R4laNvoU3EZYY+jsx0eej94+59h5e5SOvlXVJLRYYTq2onJe2/4YtwaDb3a1EXhUNY9j8svQCBr
	Phze0vUWoY8vzpaAhc6vWyCo9t9oBVBtJ1Bg71pZN+k2FB4kxKoQ8rIWuAiYI3BdFZPsj/FzUsi
	NcB45X/6mPzVAKl6UkZRSNJsWdYQe2ZgdSU6T2KZ7DGjjK2KL/u4lioerGvmjIfAyQQ9tAvDCRZ
	Ge8Clgj++453yC/h93vJM=
X-Received: by 2002:a05:6808:16a8:b0:4e6:e72a:1ba0 with SMTP id 5614622812f47-5640dcb7459mr6360233b6e.12.1793621378085;
        Mon, 02 Nov 2026 04:09:38 -0800 (PST)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fd95dc0sm8461851b6e.6.2026.11.02.04.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:09:36 -0800 (PST)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	linux-kernel@vger.kernel.org,
	Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH net] netlink: Do not call the unbind callback with the table locked
Date: Mon,  2 Nov 2026 12:09:29 +0000
Message-Id: <20261102120929.4077030-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
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

When netlink_bind() fails to insert the socket, it calls
netlink_undo_bind() with the table locked. genl_unbind() then takes
cb_lock, while genl_unregister_family() and genl_register_family() take
cb_lock for writing and then wait in netlink_table_grab() for the table
users to go away:

  netlink_bind()                 genl_unregister_family()
    netlink_lock_table()           down_write(&cb_lock)
    netlink_insert() fails
    netlink_undo_bind()            netlink_table_grab()
      genl_unbind()                  waits for nl_table_users == 0
        down_read(&cb_lock)

An unprivileged user can get here by binding to a port ID that is in
use, with nl_groups set. Lockdep does not see it, as nl_table_users is a
plain counter.

Unlock the table first, as the comment in netlink_release() asks for.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101101347.3910654-1-anilkaushikwireless@gmail.com
Fixes: 3de21a8990d3 ("genetlink: Add per family bind/unbind callbacks")
Signed-off-by: Anil Kaushik <anilkaushikwireless@gmail.com>
---
 net/netlink/af_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index fec2879c497d..666a0ba03ca1 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1047,8 +1047,9 @@ static int netlink_bind(struct socket *sock, struct sockaddr_unsized *addr,
 			netlink_insert(sk, nladdr->nl_pid) :
 			netlink_autobind(sock);
 		if (err) {
+			netlink_unlock_table();
 			netlink_undo_bind(BITS_PER_TYPE(u32), groups, sk);
-			goto unlock;
+			return err;
 		}
 	}
 
-- 
2.25.1

