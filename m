Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710238;
	b=QT0A4/rzDaXJFNzjqxb6kyIy8FSm/CVXYhLLuzlsQc726p51mfn2lX3RK/VzbMVaZcLg
	 nuohdGkm0dHe9/ZmDbRdxhNEO7iT+eZ2cVg4+siQVcQ898SyFCFC46dCsfD+r5Gh6ctoi
	 equOT2m6tINv5emyh1L9typZw7CdoewJe0STz63+al0wNnwhESTOmeO4DfvGFowfGY3hK
	 /q1nAPDbdTW24UB+a+XiyrUqrsCnSby5MDVluO4WCxCUVX4ScyBXuMIIRppZjJ4L+m783
	 h3sg/e+GR03FBfHnWSWddK+3PgZU4HJ4nN6L2T0H/WAwG8uYn8ZWsYKkq7Qi7MBF+9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=79De+S9WzRf5YfczRDZE5oZIz38sSlm2evkJ8x0rH2U=;
	b=OaFd1dBKl3WUuVTMAoelpwLR9q/8oQuZA9liOXgck+G0fVEy+KIUnVZMHsZOMewDmWXk
	 zJkwdUbo3dn7My5DxbnELZguAW0zYxwgX7H1BbOQ7a+0u/rjDKtqJG5PwFOyOg78LZXU/
	 yJBzNPFmMafBGxRlXTBVANbB9MyxMJbvhTs0lZ8nS3GiBgtIO1ID5qxWYpztFgu0DgN1M
	 fLbKD2BAEJ5JBjPWiORyklNViNbYAZkhARYWzNCcWFFDEvHIB4yenylQZPt5qB+47Vgom
	 QgaFBABFhxM+sIQhIjiJwQzBbXLe4HzzMeIoCN8u49lej0UxdJTC3sIWTn021vxMR9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gVDdcLmR;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD30606EE81
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AD30606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gVDdcLmR
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48df4f540ebso1947171f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793710236; x=1794315036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=79De+S9WzRf5YfczRDZE5oZIz38sSlm2evkJ8x0rH2U=;
        b=gVDdcLmRviauunLxj4vvUm7iZXJvIRwhnqTv0OCN1KRF/if7ZfSA2g+Zskn6sToJPF
         moZCb/bqtFvll1Gth49VU/yH6jxj57qO75uOX/5cIrLJlkcBYMXx3yiDKqqHOmk+dMlp
         ela5tg5C9TUez6tQwcPoRTokfNuNt+9Xzd9VD3dPpDE5HFJPIiRhtAeke+kbPYSvk2R2
         xZ/mRPlTuqamRnas+kxMdO1Ir2KiEFeFtuZDkhYEOdInS3KCDdMumr6GvZeez8GM3Rwn
         WbgJwx84scqz6MOxit9OizCMkNYIy27XYSjdG+Dt1GUtmLqYwjl0h937tdR3jZ/QGxxM
         AttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793710236; x=1794315036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=79De+S9WzRf5YfczRDZE5oZIz38sSlm2evkJ8x0rH2U=;
        b=1P8NqMDO6cGGgtodZY9oqhfnlrkLrZw1USdFsnraHFlFCtaO3cNfV3wSNeYMoaYGaR
         YLFccx8zZ1nKy0NhYzcjfXtOum9d7JbeHIypTKxBghnMLPW2gmSY7+5mbIz9Ecn32d2p
         peToBQtVYLSjgNGv5PnERUqQN66LhxHScsTq4b1MsHFEoWL4J7LW+sfRDzAKiEYrvRjH
         uS0HQBXePISBKkT7CkWp1f7F5ryzl2gBbCH6E3W4yaHoeoQqwDcrh/9snk6izTaeYy8m
         Y8gfc78CKTvJJjJdVt/cSzcVcIge22W3aHLnRr7tzNzYt/hTKfrEuSENwoxbp2b27SPu
         ykdg==
X-Gm-Message-State: APuU4Z/ntSCGQW2+VIvYgOk39bI5z7oTmarJV/dTQ3Q1ZHwm7ji4obFk
	9iuso/TZR5hoSSELMW7eg1A9SzvLzpoe1/YW58LmBEdBNhsFufeDSsmZqWx43O6N
X-Gm-Gg: AYBFou1wkLvdr7otjvCE+yaMjVZFQtgLamEHxLhSjD2fmZeDRuWUDLqg/t4ena/KbUh
	FxY3EF+ftctTMrZjFanzlJSSqXA/lYpPQgp9Un4vg0qzuETbnWGSI4sk4YaIPOq4b/McL/d6iC/
	ZWkVSplIfAn3dTuM6S2a+yA0yJX89MPnBWAxMygO6KlEIT0ecexQf9dckoyU1caRHP3ndEEKBZo
	3Ok89rqG1LX44Wm37Xg4WiEZXnnTsm2F3zy2AE0rb0MdEw4tbzYPELA0IgTEH9GizOgZTZAx6Z9
	lIfu4fuXGxBb4GLRt+U+G+LhpY+nfcdPQ0eEnLT/Zr8rHSe2+WH3Wcb9UpW8GK1LMYEzlyfbnnl
	r/IW+0JsyTOmmIc0HgHbfF7dA8LBGh7ImZpjiac/AGygc/Swyh8lcipDOeR02s5vjf94NzLLq1C
	MF4Nkjas45Ju928qJXOLhQew6NWeCnif5BYwXapJAAKuw8FJ1r+xQoAOJiFTT8fxJG22vvOD6VG
	czZXjmO/gNRJw/4BPuyM3wgm787ChFhXRQdNCY3ciNhLyfddkBa/Z3TYzZxp5KXTwbTc0XSE/7m
	MHtObGU3V/q6j4Z4sQGA0/tbpVxK0qAcelSYStuYe1nfEC/oZt29kSDKalD7Pcx+dsmhmW+ZKxc
	MT75XD7DIRobYZJ+A24DJGD9EH+PVFZ5FwBd8uTRU8LjsUGYl7gA197vgORQFNQ==
X-Received: by 2002:a05:600c:e558:10b0:4b0:a307:46f8 with SMTP id 5b1f17b1804b1-4b0a3074938mr95994905e9.10.1793710235976;
        Tue, 03 Nov 2026 04:50:35 -0800 (PST)
Received: from localhost.localdomain ([2a00:102a:403b:96a2:e8a9:f4a7:ed37:36a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a5372d8bsm61406425e9.0.2026.11.03.04.50.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 04:50:35 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: netdev@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	w@1wt.eu,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 4/5] net: mvneta: unwind a failed mqprio setup
Date: Tue,  3 Nov 2026 13:50:20 +0100
Message-ID: <20261103125021.70845-5-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103125021.70845-1-pepe.schlehofer@gmail.com>
References: <20261103125021.70845-1-pepe.schlehofer@gmail.com>
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

A failed mqprio offload setup leaves part of its configuration in the
hardware. For example, when one max_rate is not a multiple of
10 kbit/s, the command fails but the TX queues set up before it stay
rate limited.

mvneta_setup_mqprio() returns on an invalid queue range or rate after
it has already mapped RX queues, switched the rate limit mode and set
the rates of some TX queues. The qdisc then fails to attach and the
driver is not called again, so nothing removes them.

Undo the RX queue mapping, the rate limits and the traffic classes
when the setup fails.

Tested on a Turris Omnia (Armada 385). After mqprio failed on a
max_rate of 10001kbit, TX queues 0-3 stayed limited to 10 Mbit/s and
the VLAN priority map stayed set. With this patch neither is left
behind.

Fixes: e9f7099d0730 ("net: mvneta: Allow having more than one queue per TC")
Fixes: 2551dc9e398c ("net: mvneta: Add TC traffic shaping offload")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 28 +++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 75d46349df37..d3a6bf8f383e 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5299,8 +5299,10 @@ static int mvneta_setup_mqprio(struct net_device *dev,
 		for (rxq = mqprio->qopt.offset[tc];
 		     rxq < mqprio->qopt.count[tc] + mqprio->qopt.offset[tc];
 		     rxq++) {
-			if (rxq >= rxq_number)
-				return -EINVAL;
+			if (rxq >= rxq_number) {
+				ret = -EINVAL;
+				goto err;
+			}
 
 			mvneta_map_vlan_prio_to_rxq(pp, tc, rxq);
 		}
@@ -5311,29 +5313,39 @@ static int mvneta_setup_mqprio(struct net_device *dev,
 		return 0;
 	}
 
-	if (mqprio->qopt.num_tc > txq_number)
-		return -EINVAL;
+	if (mqprio->qopt.num_tc > txq_number) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ret = mvneta_enable_per_queue_rate_limit(pp);
 	if (ret)
-		return ret;
+		goto err;
 
 	for (tc = 0; tc < mqprio->qopt.num_tc; tc++) {
 		for (txq = mqprio->qopt.offset[tc];
 		     txq < mqprio->qopt.count[tc] + mqprio->qopt.offset[tc];
 		     txq++) {
-			if (txq >= txq_number)
-				return -EINVAL;
+			if (txq >= txq_number) {
+				ret = -EINVAL;
+				goto err;
+			}
 
 			ret = mvneta_setup_queue_rates(pp, txq,
 						       mqprio->min_rate[tc],
 						       mqprio->max_rate[tc]);
 			if (ret)
-				return ret;
+				goto err;
 		}
 	}
 
 	return 0;
+
+err:
+	mvneta_clear_rx_prio_map(pp);
+	mvneta_disable_per_queue_rate_limit(pp);
+	netdev_reset_tc(dev);
+	return ret;
 }
 
 static int mvneta_setup_tc(struct net_device *dev, enum tc_setup_type type,
-- 
2.54.0 (Apple Git-157)

