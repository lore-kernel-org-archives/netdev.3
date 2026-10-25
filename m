Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792962180;
	b=NuRR+zGgBiJwUTY7lK/afiotBOi/WdjhrHDF9lV645IM1YTr8VAog7HQXb3Rkr8uoWtr
	 r/Oq9goIL/y5k4CjFS6qclUWcM3dHesrcWkw1dPbVNrOM2USjEN60vrgBOT1PQpqddgZp
	 kyn1bI5JFNRPMIR7jBWYGWNIYdinljPp3FqQey6QrDOTgfJR8sva8PdOrXsOK29kXc5qv
	 hLtOGrrjIL9X9Va7PVi7HEa1Vhi9LQtXOfrPdPKjPHGP9vhj4pON2U2JO+DEVWlrNcfzK
	 isjQcdbldVfzxIhhpTqGMqI+w0kOEf+pg2r+MIq0WtXXpujpzFkRhSnRxRqpdMBFwxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792962180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZvdM/zwudCibbhvG92/DAjuffztDVUyeE/Q5y2G9nAA=;
	b=W1kcf0K8Fx3tMmPf2l4EVR0OaYORxS17f01nTOCLq3PZSjKdkv0uop5Ku4WmI07RVZNn
	 KODt/VSrG1DwKN9DBo0eM6LlMHb2j7XGHKuTxblY/FaXulZELwErnlPxzFj1F6C6SJtBV
	 UW5lH+oZNL/F7KwKeTRLNRPX44zTML4+t25WdRJtUe0q9rzdhwV11BAj8Ay5MklaqsNdv
	 tdyeWi7vSwx+Sqqr1m9cmN6V/8uWFPnKEXY3V98Urbu50MAZkee1x3z11gDJdxGUvxUAP
	 IF89BRmF7GA0BbVHjX6qpXYLYdKFEVKz28Z/qW/hdAjHLW1IFCuvZBmEIwV9SI13C7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C6kwohrd;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91084606A31D
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 21:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91084606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C6kwohrd
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48dee593f18so1764674f8f.3
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 14:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792962178; x=1793566978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvdM/zwudCibbhvG92/DAjuffztDVUyeE/Q5y2G9nAA=;
        b=C6kwohrdRBvofaSx1qmnvQje7E8iuZTJCsv53d4XxPyaSu4EcbbdgBCp9JFbmvFlhy
         YXNyoy9oAMVj5h5rDBeBAATHEMAbXMhftcsNERr5mCx5xsu0rrnPYIauxlazNmaaxEem
         xaLd+2K/zAOl5wGuoqf2lAuBdBOEt48a8AUcCNYFlI13TnS+Vfvay1nbvRIRgq6QAWm5
         KokiwBqbVbTd8q7lhrEwTLewDBLXNaUXIQm8UpDf6LYpUTv4LvZ0xMJ1MDvITkmUGegb
         4qeC+skOZmZm0phpdCvmjbjLf24Zdcn+aunV48yuwYoPDqZAsvgo07aNobvzsdTUnVdN
         DqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792962178; x=1793566978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvdM/zwudCibbhvG92/DAjuffztDVUyeE/Q5y2G9nAA=;
        b=FD0q2UikjJ9Uar7JmoHC9/QAngQKXuUszwdD2rGUPkPZP5+YCYcch0YQZBo8xZdtUy
         4Ym8tW42QUpLG1miP7sY5Fljqkk7sMpCoIPqb0yjluDungjafyzGRzVoCPy8vJ1NDKP9
         bA44KrnSUJGEMyqZfnWvpQV40ZYVO2W8i6z+AZhnS0brD8xAl9/Uo51JQ7+jsCMbF2HJ
         vtCiOrEZHErQHF7d+BEmW7Yom8v1E9+t44uFXuEJzxCZxHuVD0QtFGkhI5WGd65M17il
         U0/j07dTO0u8wHhez9aZ/pLSACmskyatQmxC4PitvwTRfgpAKE+oRJhy3aL+dFQIh+zO
         z51Q==
X-Gm-Message-State: AFq9FYJQ7Znu0ZDho6PbgOz6ZrVs3Gay3Xul8uAiOW6BqNxKjOAHR682
	Oe5gv4dT4nkHRwOBY9R9ZIflJCzmhALsSvsU3kXwAdXjnI1JHDUqk3s=
X-Gm-Gg: AYBFou0mGfZyU8MI2eYbw4rn3rIdrWNlR+VWl/fiH4SM4Gdqd/JprQ5DgjTX7YYlFj6
	N3Kk8oHcWlxlTUGny8HRm2t2fNA5wu6WWPTyTMU9iKk9Zb4od8d4/AiuKxYMyt+2a37E5f5bGJK
	Ro6ZFgwSl9bsPc4awc3bz8+PTnIVL1TsJZc6QHIf2HK5yST++/yZfToz7oxrwR4HY/+C6l7QDLi
	W0PWcUHcb1GmravCg20NTlulZtUj1BtO5EnU2rcbDgdCbigjKaHI5whjO8iQ3Ah8whdaYjwkOEg
	1Clp/yucMnwObKqttcdElF+5GbOZSEk99AYj6SB3q90V01zRcgNzIJ7jfprbYLdnKvKAQf+M88H
	aI39jpbsyO50MmQf54wZTVJFVnEfR/53USs6GroH1/n83VPDBlkcuhL7rWVCVlZt7N2cEZhtKc5
	B+bim6wT5I1zwzisVuKSUELw3E/YMcWL6quONKX7MuRqcERbBxpyXtAeNGuZggK1DdZ++tL3HpW
	fWR+qtloNY3AzIB6GGSOMjENxdkFfkwAvUH4Q==
X-Received: by 2002:a5d:4743:0:b0:48d:f249:82c3 with SMTP id ffacd0b85a97d-48e3eb8b816mr5791876f8f.30.1792962177683;
        Sun, 25 Oct 2026 14:02:57 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f36asm12289177f8f.1.2026.10.25.14.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 14:02:56 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org,
	mkl@pengutronix.de,
	socketcan@hartkopp.net,
	s.grosjean@peak-system.com,
	stable@vger.kernel.org
Subject: [PATCH v2 net] can: peak_usb: fix use-after-free on PCAN-USB disconnect and init failure
Date: Sun, 25 Oct 2026 21:02:56 +0000
Message-ID: <20261025210256.629830-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023195400.3531721-1-tristan@talencesecurity.com>
References: <20261023195400.3531721-1-tristan@talencesecurity.com>
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

The PCAN-USB adapter uses a restart_timer for bus error recovery
but does not define a dev_free callback.  When the device is
unplugged, peak_usb_disconnect() frees the candev without cancelling
the timer.  If a bus error armed the timer and USB disconnect races
with the timer callback, the timer fires on freed memory.

The same timer is initialized in pcan_usb_init() via timer_setup(),
but on error (e.g. failed USB command to read the serial number) the
function returns without cancelling it.  Because dev_init failure in
peak_usb_create_dev() jumps to lbl_unregister_candev and skips the
adap_dev_free label, the dev_free callback is never invoked either.

Add a pcan_usb_free() callback that calls timer_shutdown_sync() on
the restart_timer, register it as the adapter dev_free handler, and
also cancel the timer directly in pcan_usb_init() on error before
returning.

Fixes: 46be265d3388 ("can: usb: PEAK-System Technik PCAN-USB specific part")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/net/can/usb/peak_usb/pcan_usb.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb.c b/drivers/net/can/usb/peak_usb/pcan_usb.c
index 8fd058c328564e..440d8e2cfb6fe6 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb.c
@@ -882,6 +882,14 @@ static int pcan_usb_start(struct peak_usb_device *dev)
 	return pcan_usb_set_ext_vcc(dev, 0);
 }
 
+static void pcan_usb_free(struct peak_usb_device *dev)
+{
+	struct pcan_usb *pdev =
+		container_of(dev, struct pcan_usb, dev);
+
+	timer_shutdown_sync(&pdev->restart_timer);
+}
+
 static int pcan_usb_init(struct peak_usb_device *dev)
 {
 	struct pcan_usb *pdev = container_of(dev, struct pcan_usb, dev);
@@ -901,6 +909,7 @@ static int pcan_usb_init(struct peak_usb_device *dev)
 		dev_err(dev->netdev->dev.parent,
 			"unable to read %s serial number (err %d)\n",
 			pcan_usb.name, err);
+		timer_shutdown_sync(&pdev->restart_timer);
 		return err;
 	}
 
@@ -1051,6 +1060,7 @@ const struct peak_usb_adapter pcan_usb = {
 	.dev_decode_buf = pcan_usb_decode_buf,
 	.dev_encode_msg = pcan_usb_encode_msg,
 	.dev_start = pcan_usb_start,
+	.dev_free = pcan_usb_free,
 	.dev_restart_async = pcan_usb_restart_async,
 	.do_get_berr_counter = pcan_usb_get_berr_counter,
 };
-- 
2.47.3

