Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358660;
	b=0y3mO86k/JY+NM6wIAXZ8kjsDYzjmt1jdq4pWNdfRh9kbkDUMQ0CU58R6P31QKGrC7nE
	 4rmrwidEwRIxvw8/3DItmUm1YxrP+LUhEj6PP8vEyNDKaXSWO/JqGdsrNblYqm+xW0vht
	 u14w7kXZUZLnrGGXF4zHwHq0RLQi6/LGaxOCWt5+5IQb7dJsazmg+eLszeO3ramNSfojx
	 ZADvqWcoGNceSNwvVxfgBe/yinXHK7l5tukPT02p7GvkZr0M16myY0DBVd9x64eBxlDWw
	 PlDqZdsXcdvO0o5rMQbs5VpmB1cT/Q61FLxO4HiOgjrEu3cG9y6YALHw8SPOUUqD1VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=46Vjwa9uE7FzNJRa2W9YmO/vasAer+dAOb58elbr7/s=;
	b=PbhC/aFOgGexrF3+CzCq38pX5gPp1YGQ7aqTTj2UZRV5K2wdtfI9UJVcMkih8xu8DI8M
	 RU+02s7ZsEO5rdWxtrAEMQY9RI+BcqCMOpElRZEo85dPUpQWQZepmymZu4UPcAPsAW4fn
	 zBUOr1LNCt/BCuBdGQQ5vjmT4jqmDodEep9ari/r9ShKLtuVxqX7j014Igd2lcZTkecHK
	 uevbtTln6I11z56V8CIids42v7euO1/b6OYyC6ZrTQXNLBLzw1tJguU2qhk2i1z1TUah5
	 XWC6idUNxXe7B1734V/A2vSar4MoBD4KuWCvMbMgedg/vmuBMOyxCHfvSqNRCgOb7SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DfbsY6t/";
	arc=none smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281DB606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 281DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DfbsY6t/
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7c322cbc998so97876137.3
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793358659; x=1793963459; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46Vjwa9uE7FzNJRa2W9YmO/vasAer+dAOb58elbr7/s=;
        b=DfbsY6t/6BLhRw3tbLgCCfjBA6TOS24zTyzU6NzQuCjFbxJFUti7riKimMyqdVcj/N
         Sukln1wgCrDXfGIDiXsxcaF8yKq1Vya1C4g12bvniAoD/3WK+kUZOhkYo0cCER69Zder
         rvNo4j6BniMcqAmiW3nYTrh1NCb1jWGm2G+6GQHwYPvueYXYgWM2qT3ZOVjOi43emS6s
         zFFpzKZnnLJvWNtUib+byTc0DvmBzlQ+Mm7RszeYmas24HslfWk75su4piwO8IIsuHZI
         usOpzFBn8e7CSVHc9AC3xOiawgPEEsD+6XLIJmg6NIkFHFoBacgN7SPlil6NmS8aC+rz
         X/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358659; x=1793963459;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46Vjwa9uE7FzNJRa2W9YmO/vasAer+dAOb58elbr7/s=;
        b=edHiTyn1QyG6cjtxGlk1uJTuaiaY5zIBVilmxHO2qouFX5otjRuEBkolHcugbuFsRN
         VD6Imz0ybvmvmr/Y0SjA4vb2QIimhAYHMyS3puXm6SR+01AE7RB6x6aK9t/wYfaA7oKx
         pQHHHraYT+QkgTBxWzsd2WZJku9cWx+ND6q0ii4oftFykGa6Srufxy+4H3/cZ0v8HjKO
         O22WyH3S9mJfmFLitz6PiVo+kEpgKvxMbwPffLRUl4XBWh/dGg02bBWR/dzx6OipBXQ5
         zHiBOTxiFE3o129oZK4tpl4+GhIkSzfb71OnefYhxmKkHj45v+08C2ubqvuYPagW/uFg
         xSmQ==
X-Forwarded-Encrypted: i=1; AKwUvBziA3KYi6Ep5NRoTjvsNCxNyvFW2LefE7TPISbpj7WYt0Ab/VrAT9qAJ0qyMyOBKiTeKM1n/gk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+m54Vr4qRfNeOPNjReNE37Ryr5OgKuHzENgJeDujMb/vx6jBu
	MZHiVDxiLRLbluHGnulbBkvsTBBPELr5nUfTWqTZvFvLOHUnzOklrF2t
X-Gm-Gg: AYBFou0Oa0LoqyrrL1odBp9LYIwH+uL2i1Mg4X0pGDMWGupMLXY32U19DR2wEyVTuED
	ycfMAJTALv5qcxeobQ/dR4cBkGSU+JWDtJQM5ETOcX1jXokZiUFaIXb3sM5Wt2qdJxadDn+X+yc
	RyJFhf7Pc69uBXtAsex5lLA1dTJt3QLTMedK+IrcHMx0oUXOf+CUR1WgCFKlYh4ChTqLWCpTvId
	iviD5FW2g/eYtb8cRmUNYFKPw82yx+3oIiVLQpt8fpS9KJGGY7B+vJzMVkIUAgLdv7HLbIBQoWj
	G5Sh9QlOqUh7O2QDn2oY/gKRcnZ8wWA07DPktPUoWXj3hJy8ilD99a3DUF6OGTn7lLF/Anzqtnl
	3byOEFHjfUgp+zAj9ZAb6mdVdHiIJezBuYMLY35ZYS3TOwtq5UGU+XarYjCwAVDnSMqGxqDx9VJ
	zcwGJIXXF99z4ExADjGweJGpGqBWIVtfTqLJrQeZ4So+LLzR1eVwcuHvFawY8S/Cu/3Dg9QPjec
	MHAJruJd2QHp6etwPsWC2nfcRW0FTkU5kFDWh+lQYU9xZPuvFee0Anah3gq01WxiYevj1Yd484O
	49Hmg8k1dWwK8m3faxCb6aMa8XF/WytZEKvm0zIWHZs962VSA8lEKkPKhT8YUNrU8tev1X4owJI
	9HqklTGcPfrPEP9CtvUqaXqLZhKDnTqpVM1NpEZtJ
X-Received: by 2002:a05:6102:604b:b0:7cc:25bc:3b27 with SMTP id ada2fe7eead31-7d07226d973mr786120137.5.1793358658951;
        Fri, 30 Oct 2026 04:10:58 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([191.34.116.20])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07754c1b4sm1841044137.4.2026.10.30.04.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:10:58 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] nfc: hci: free the skb sent through LLC nop
Date: Fri, 30 Oct 2026 08:10:42 -0300
Message-ID: <179335864272.64596.14178706469641120758@gmail.com>
In-Reply-To: <179335864271.64596.805818095553030218@gmail.com>
References: <179335864271.64596.805818095553030218@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

nfc_hci_msg_tx_work() hands each frame to nfc_llc_xmit_from_hci() and
only frees it if that fails: on success the LLC engine owns it.  SHDLC
queues the frame and frees it once it is acked, but LLC nop passes it
straight to the driver's xmit, and the phy write operations of its
users (the MEI phy of pn544 and microread) copy the data out and leave
the skb alone, so every frame sent to the controller is leaked.

This was found by LLM-assisted code review and confirmed with a
test-only module that registers st21nfca with LLC nop on a virtual phy
and a userspace controller emulator: 20 device up/down cycles leaked
598 skbuff_head_cache objects, and none with this patch.

Free the frame in llc_nop_xmit_from_hci() once the driver has sent it.

Fixes: 8af00d48dc92 ("NFC: Add a nop (passthrough) llc module to llc core")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
 net/nfc/hci/llc_nop.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/nfc/hci/llc_nop.c b/net/nfc/hci/llc_nop.c
index f9c826a13..1603e435b 100644
--- a/net/nfc/hci/llc_nop.c
+++ b/net/nfc/hci/llc_nop.c
@@ -67,8 +67,17 @@ static void llc_nop_rcv_from_drv(struct nfc_llc *llc, struct sk_buff *skb)
 static int llc_nop_xmit_from_hci(struct nfc_llc *llc, struct sk_buff *skb)
 {
 	struct llc_nop *llc_nop = nfc_llc_get_data(llc);
+	int r;
 
-	return llc_nop->xmit_to_drv(llc_nop->hdev, skb);
+	/* The driver does not take ownership of the frame (the phy write
+	 * operations copy it out), and nfc_hci_msg_tx_work() only frees it
+	 * on error, so it is ours to free once it has been sent.
+	 */
+	r = llc_nop->xmit_to_drv(llc_nop->hdev, skb);
+	if (r == 0)
+		consume_skb(skb);
+
+	return r;
 }
 
 static const struct nfc_llc_ops llc_nop_ops = {
-- 
2.43.0

