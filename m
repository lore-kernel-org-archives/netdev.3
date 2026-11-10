Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285009;
	b=yFB/Hvj7e53wv6nfaw35DqX0JByIQgM54mh03OHWuj9bnT9LrOOT1yGEpe5QA0+AXJI/
	 CVMIRyzZLvs9VUZw1akBFI9tB5opLTFLDXtLeIJnWh4dcvgTbf6QI5Gi6DEHIrnQd9DII
	 KNpQ/GbDuSzkpUWdW6PGsXP62NfN6cdvIsg6j7bKqAfrs+rDG0t20g0iD+30BfIoxAJrR
	 Y8mDKRIvGX4njbp+UXczUxZZsRt0xvF41B5STtBRcPeSoSP0n0ZF2itRIVna7QuQINHsV
	 wcazmiQ0ANCUCK8hiD/UeFjO7fNaCwElfP/2I3E0wF1wG3tJ9NLECdIUMEb8GjSoUyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Mc6rPhZtcy7thF6jBsEppMpKqkoctKS795gM28YkdhA=;
	b=vnfIAE3r/WwXYDN7eQQoMKhZrHJU2IHazsJHmVMczSlaHcCPbFGg13257bgQIpe1S0FF
	 86s1hs8HEHhGlaYZmGGgoGMRkpfzZD6NMyN4ZKwy+r3jZXaikElZn4OWv+sOQM9BSDnUh
	 xo7OmuZYUbpEEeVJN7rEmo2RPTD4A+qMhQeANd66WJwU7o5r2TmS1ecwL+PJoD5/ZQDKj
	 0cmMt9R4MIicQaD7ckSGvasp7uw6FS+YvXTMNnQ9K2VrNJ0i3zzVKMZsMYU0I6fqjsSA9
	 cXZZycsrJWS0J3HIWug3XgDMoiKnuw1W5FZbyGTKRCA51kGltCqYIbpu2IwyXgRhZiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tw2goD4R;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F38D606A33B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 04:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F38D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tw2goD4R
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f079a63b8so162602285a.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 20:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794285008; x=1794889808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mc6rPhZtcy7thF6jBsEppMpKqkoctKS795gM28YkdhA=;
        b=tw2goD4RZ/2tu7CCKcYLAvxfmyz4f4QYQ8A7OsaW1utqAFZAgbziDtsVqBNMvlpGET
         Te/vSDKbzo7q34BTmS9Pv5r4ds6z8orc8yvXnA6ne9M0GHXvP2jb9nbUY55IHFTrT7aH
         Wq3yVa1K4rG+nWmTA2nXQQfVW/rBtVkwjcx1INqPFxby1BShW16l4Z1Q7TGDYB2rfK1Q
         waw083QR7XlXSD5eolV1pZnKaOjXibjWhvN8JN0q/bZ6GgIh0zQgJmKQc9/26bM9rx35
         1HMbOchXb288maFkZD7b1GCiD+a3RLsvXYpMVV0IhUZevw2CPeddi2Ya68FZnklwUmc7
         PMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794285008; x=1794889808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mc6rPhZtcy7thF6jBsEppMpKqkoctKS795gM28YkdhA=;
        b=Sodn5Gc9Bir4V6ZBysUqOCEg58AEBbTupWaWwOnDPN4kATClEkOHg2JNBNb3JJgdPl
         AsAJhQqfbGAkwbd++vK57kWIZglNUajNvJS71wC5WeQKHgjP2IvGbaml+dR/fsXlrF0C
         7j8s2zORlRQP6NW5NK6K7gqeJZic/1v1GI3TLPIhbO8RJn0HNDBJiL0dEoBx9nvGS565
         pdjp+AOHluitQQ/nWm7OCzpwNJuWOcUm3xtgyAsoNGOLk+lNmsLznWRQIgL79a2nMiYT
         BiJXZh4B5b9b67ymtVQWCUlEOpgFgalcqscvgnN3eaqXgFo0DmvDoPQaszqma8a8a/o/
         6BQw==
X-Forwarded-Encrypted: i=1; AL+hErGN40xKUycD+6fvmzZcOWzZakFdBjnYrlSI5qZG0CJhe6eyNNMU7+kxYntb+G2UXU+79txhYGE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8V2uvwCnXjHKQd7ZJqBMktRT+dnwjDsazB6WBLiiBrUIl7Bo9j
	P0BmJicdYKndWZhE6iy2byny47AGwQkcBEMZdMK9PJ1mUDqzxiY3jlI=
X-Gm-Gg: AYBFou1VqHbO+kggZ8aPhYjxLlJR1ygDd+N90lqPgugnJQ/dQLq9cdXP9xjTj/5OADR
	4Bbff/+EqFYf3PwNaXiC5B/atXTmNAijUmONEMzW0oOSiA3DimvzOMjfBvP6LMaFp3Vlltakarn
	kYo+KUjoW42zr0A2KKyaLwq9NST6PlLs6+P07eTbnuc6EAmH5/J6VPlI0igGKfSuMIAyx5+zNNj
	1OZOnSCLB9dAZMHBGFBEcTF93v/TThrG+w2SrU7JnCY4sDN5L0qjcBjUFZ52GyeVjkPExT1iCOr
	Zizf0McU9OUD8Ng749Ly1GFCZuOmbXTd/DKXmMeVpHm78vUXE6ugM0baapW4N6rsFnsqmRGjuPq
	LhrXPZOxD12WDDHs0bCpqElut658lOpk3LEeQ+CSneT+PD3I+UvK+ms/js7Rvc8j7mvjD20OJSP
	GOgXUhCkztbYToXhfsQUcQwCDUp7+poPxaK5fPAAtkpHI+0zAQmRIFsvv6OP2URCuywHBmY+Qmj
	T5G8ubk6McOAy//JIp9e+4RFkv6Vvx0782XTxBTdQbOMCfP0xONQaCxdkDa/h7/XIBI99Rgkajy
	ea9jlkITTMRxHO3pMNOQLVP4i8lxEH0RjM0XrAQaNT7AJNTeU1pp86pDdTQQ5vmZcyefqMQDlff
	rNfGCibwRcXSdXjFPya/b75/Lpx5em3ldRvHodv2ks8Wf/MFUK9MSeCgI/4gRYeZF
X-Received: by 2002:a05:620a:6496:b0:945:d852:1618 with SMTP id af79cd13be357-9479f3eda61mr223680085a.70.1794285008081;
        Mon, 09 Nov 2026 20:30:08 -0800 (PST)
Received: from localhost.localdomain ([104.39.152.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73b2d2sm134917585a.10.2026.11.09.20.30.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 20:30:07 -0800 (PST)
From: Myeonghun Pak <mhun512@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: wwan: mhi_wwan_mbim: disable rx_refill work on removal
Date: Mon,  9 Nov 2026 23:30:06 -0500
Message-ID: <20261110043006.56681-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

mhi_mbim_remove() cancels rx_refill before wwan_unregister_ops()
removes the links. Bringing a link up in between calls mhi_mbim_ndo_open()
and queues the work again. With the MHI channels already reset, the
work cannot refill RX buffers and keeps re-arming itself, eventually
running after devres frees the context.

Use disable_delayed_work_sync() to drain the work and reject later
queueing. Probe initializes fresh work on rebind.

Found by a static analysis tool under development.

Fixes: aa730a9905b7 ("net: wwan: Add MHI MBIM network driver")
Cc: stable@vger.kernel.org # v6.10+
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 336f89756f10..3b6b0066f673 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -650,7 +650,7 @@ static void mhi_mbim_remove(struct mhi_device *mhi_dev)
 	struct mhi_controller *cntrl = mhi_dev->mhi_cntrl;
 
 	mhi_unprepare_from_transfer(mhi_dev);
-	cancel_delayed_work_sync(&mbim->rx_refill);
+	disable_delayed_work_sync(&mbim->rx_refill);
 	wwan_unregister_ops(&cntrl->mhi_dev->dev);
 	kfree_skb(mbim->skbagg_head);
 	dev_set_drvdata(&mhi_dev->dev, NULL);

base-commit: 0edbc945eb9edd0086f25b151a79cfe4adc0dfa8
-- 
2.43.0

