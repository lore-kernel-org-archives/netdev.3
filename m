Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793315875;
	b=ojLof3kzEu3w+0LnGDS81z/8EA3l5u83UK9rf6Q3B2S1p5KGZ0MxaJLzPzFQCQZk9JtQ
	 m1KT3dqohg5Fzg+S+LmUi9gZdhr31jdGsh+aL5g8MaalaWUZyEgjQ5DU4KmbPq/+pY+/2
	 3A/MdrEzQ8wzzRx5ccVwbbbhm+H9rmhgC8Lsfeat9z/lfOyvU6Ia752TGe5L5Ju/4CwaZ
	 aUBmGkf9js6IXFEA0OOzZrmAP1vGHTu3xJV5W4xNbsrF0+MzxA1MVfYV9hAelMrikFR9J
	 VFfTQRTZaHpyumK+W/widkbzwyfKvaRzqYODKFAV7pTmwcch0/5A/79y4cAhWQgisJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793315875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=4oSKGtvEvHMaBkCfYGQi99m+gHJNL+J2+Aa0Qjrckko=;
	b=g7t8ogaBkM7/JKw7jFL7fZzSSfcgayU++YHcVAvNwO4bCCDgT1v85kE0WxPTBa3rHwZV
	 RQHRoXXCZwYdvj74flVY5qCG2FiJke2BU0Ln06Ip8ocmzJd4jEXuPQzIPMI9Z5yfsna2k
	 6L9fK34ipSsqpNAkBG4LWY81FzMQQFSrDr2PqucqyAxiwcmeN9h0UNNmxyNnCQB1LqjEY
	 huE9eOuHsQt60RACUVjKRcy+mqqkkYfNIau3isF/VigYqxHiMM8DXf1SQeivhyTpRU4ol
	 IPV/14uaetTS88RH7v9xtQBPtIG5HTfT98nzMDyusuv623FxW/vLgFLBJ4NaBeEC38A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TK5dx4GX;
	arc=none smtp.remote-ip=209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E13606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 23:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4E13606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TK5dx4GX
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9907fa1d2d1so28112241.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793315874; x=1793920674; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4oSKGtvEvHMaBkCfYGQi99m+gHJNL+J2+Aa0Qjrckko=;
        b=TK5dx4GXQ/T63l80mwSVQMN7xZbmgPtUseuLtfxfv8tayh/zJdj4k3znkK12WUKcQO
         J1AmgbHYSrBymjkAilMYvmE0PkdflJzHH7Mr73oiQB+wPxEOmhuzc/dtL+5Us1N9OHmo
         4Sik+mNjYfsxB2nbb8r8AwTg68uLcHHx1TRYVM19bqQg0XdzrtJ+T16qe6ViEWIMcI6V
         IoxRSGjeUgtleBHNEDwv4zu35oEIEFjF5x+6lI1fXTsv27runh89mN/DWsi51m1lz0yT
         mIO31734QI8mmk5ZtOjTijjfDLPGTveh1/DJBE3Nqe6lc9/JJ7zMfpr/oxHWZqTD2cHj
         jq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793315874; x=1793920674;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4oSKGtvEvHMaBkCfYGQi99m+gHJNL+J2+Aa0Qjrckko=;
        b=N57s3PQYbTG1y6Az5C09Kck5T5g8DjyBcbfYIXOWuyq9RJaDyfGRZp5CFPicgtfdry
         x48sg8m8oeDHscDbQHsjcEIeaxq9ucgmkNSuDTdDEmWp/yyQCMQwzyRMDunbIx978JA9
         EGZKWD7MvcFtY0qd/2QJtsrIAeEdR9kQ1Wh6Fxuv5tqoXN+FOIYsLaGZE75YfO5LzVKd
         MI3ozSKSxzxuA5GmpRpwb7pmFG1hJU2dDGh+RejxmgkWIcQNHM/LPKLcnkEWyI0NKbE/
         DEKc5wV04KsQkRcV/gSY7xXcbYDp/mw14kx8DGQSkc+a9+/L6qfKaPPUJycRbyNjTECf
         5+2A==
X-Forwarded-Encrypted: i=1; AKwUvBwMnopxdfdl6fkwDHrlimQ8He9Kd0bU9WGW/qupI/Qs+0s3v4dSvUggGCYwXLBRZEI70tUOy4g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKza5eHO4vzIpxIBMAfcDPjF6dGJ6j3gDC0Z1tRU1NzUC5wMuFv
	7PQm7wrPKXDwCdg7CG379BNMOZbVL7NoxTMfaNjuZL1mvMWpZdSQAMYy4dHnO9oT2OM=
X-Gm-Gg: AYBFou2099Y0ZI6DfAGGeo53rpX1C2o2ydBjRkTaPe6XQYj2QCCK64bAbWB2fWAsbsD
	zbNqA7Hvk6PD2NikDy4Pqtr3gNViTyOsZb8OPnERclCX2df+6EIsACByVwt70y52enoQ4+Nc6RV
	Aq9zl7XFr9QdSWmOIp+ekUNN4+vrirM8eTpoXI3tIpSto1/6S2wd2JSqXMMrV2dXxAj0dMEQ4nq
	FoEJD1CKTp5TZQY+qfvRTsKoryZrre01eIftff11oCtIBBA3esT8wy3Re13DJ4puHA1ePqU6T2p
	J3yt7CCwNaTwl5UAMIzlbIqFrUP49WJQhYGnwnPaH3tiJHIpSwzfpOHRLQfdjlzOLvhH5s0J4iQ
	6LdXufmLD1Dem/jqmQvFje4UMykOtJ0eJBg4WwTC3SJuvC23RoXiLhEQwltXXFXJo+BT9QGxcJX
	vvbdYOkrfFobMJhNmV2oWaSk2G5TDdsIy7spD6hf2b1c8hCgFJxulYncw2f8TT33SjFKhcm06Vc
	hrOvcyVrld0uNeeFhRY7co4d72JOyiIXyWT7PhNiYBo5Zo+4wrC5TXTumU55BG+oxAdJ5GqLFa0
	6NyxtTn9mugXW6cfdxybNny+EPx38IKx7tB1ykhPYwfpAGYNR48pFSdTVyj1ZIN5aehfxpaVaN7
	UugcLqOorC/ctw34s75k6yTcYjmwuIusIh+E=
X-Received: by 2002:a05:6102:c86:b0:7c3:fc96:fbdc with SMTP id ada2fe7eead31-7d072d663b4mr347181137.37.1793315873632;
        Thu, 29 Oct 2026 16:17:53 -0700 (PDT)
Received: from [192.168.15.16] ([2804:1b3:a2c1:77a1:5cd:8fee:f3c:4da7])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee4e7453sm319509241.11.2026.10.29.16.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:17:53 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Zhenghang Xiao <kipreyyy@gmail.com>,
 Sanghyun Park <sanghyun.park.cnu@gmail.com>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/5] nfc: nci: don't drop data received on HCI and
 loopback connections
Date: Thu, 29 Oct 2026 20:17:35 -0300
Message-ID: <179331585573.30322.8986243734262725676@gmail.com>
In-Reply-To: <179331585573.30322.4049957541187612575@gmail.com>
References: <179331585573.30322.4049957541187612575@gmail.com>
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

Commit 8265a626cc14 ("nfc: nci: fix double completion race in
nci_data_exchange_complete") made nci_data_exchange_complete() drop the
received skb unless it can clear NCI_DATA_EXCHANGE.  That bit is only
set by nci_transceive(), for data exchanges with a remote target on the
static RF connection.

The other users of NCI logical connections do not set it: HCI over NCI
(nci_hci_send_cmd() and friends, used by st-nci) and
nci_nfcc_loopback() send with nci_send_data() and rely on their
data_exchange_cb being called for every data packet received on their
connection.  Since that commit every such packet is silently freed, so
each HCI command and each loopback request times out after
NCI_DATA_TIMEOUT.  On st-nci, secure element discovery fails when the
device is brought up ("SE discovery failed") and the HCI and loopback
based vendor commands no longer work.

Seen with virtual_ncidev and an emulated NFCC: the response to the
first ANY_OPEN_PIPE command is dropped and nci_hci_dev_session_init()
returns -ETIMEDOUT.

Only claim NCI_DATA_EXCHANGE for data on the static RF connection, as
before that commit data on the other connections is always handed to
their callback.

Fixes: 8265a626cc14 ("nfc: nci: fix double completion race in nci_data_exchange_complete")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
 net/nfc/nci/data.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/data.c b/net/nfc/nci/data.c
index 4253edea5..76ec891a0 100644
--- a/net/nfc/nci/data.c
+++ b/net/nfc/nci/data.c
@@ -46,8 +46,13 @@ void nci_data_exchange_complete(struct nci_dev *ndev, struct sk_buff *skb,
 	timer_delete_sync(&ndev->data_timer);
 	clear_bit(NCI_DATA_EXCHANGE_TO, &ndev->flags);
 
-	/* Claim completion atomically -- both close and rx_work may race here */
-	if (!test_and_clear_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
+	/* Claim completion atomically -- both close and rx_work may race here.
+	 * NCI_DATA_EXCHANGE only tracks nci_transceive() on the static RF
+	 * connection; data received on other logical connections (HCI over
+	 * NCI, NFCC loopback) is always handed to their callback.
+	 */
+	if (conn_id == NCI_STATIC_RF_CONN_ID &&
+	    !test_and_clear_bit(NCI_DATA_EXCHANGE, &ndev->flags)) {
 		kfree_skb(skb);
 		return;
 	}
-- 
2.43.0

