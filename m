Received: from mail-pj2-f18.google.com (mail-pj2-f18.google.com [74.125.227.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B7302753
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828751; cv=none; b=q+/iakK4ofnVpys5BzXmnufAmgil/Q0CUIVW8YuCYTlq2VeFK/cd90rLHAdFUxfMF8QuEmjI+eGY3NA2XOFsDBkC3HFqCaErqtPqKUCqkhi8/3aN+3M2Vshbcte5kqpSN5ZmTCBAcKRaZyhJmBhcwQ9U3EPGhqxjE4s6i6XwqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828751; c=relaxed/simple;
	bh=hE1cVQyQt2OU6ibt8nyDkD4ZukailLQ60/Lsgbzd9KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJScVN0K8bO7G7CvJtjXu2PrQLSg/ukuAd5ffqnJsdFwXR+8gF1oM78jPEURbSs5uV+arKjodoZRAm6d3EdXulBEu3w4QQF9lIKVv3chHcgviG93h7UjCxIHCZS66kY/kdkxx+taU6B1o0LHcKy57cg/8VavDQ2IJ3huyRY0clw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7K+MwaF; arc=none smtp.client-ip=74.125.227.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7K+MwaF"
Received: by mail-pj2-f18.google.com with SMTP id d9443c01a7336-2db22383fe8so10865165ad.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828749; x=1790433549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xl99vzI4+2TnnI65ZZD8Z3YjYIk3m3LZhJLmHUA4G0M=;
        b=h7K+MwaFaxlRtmxd5+/AHQz3quQ9CjjtN3UJh6rBeDoc+U+6lE+/i1xwUC0sUSt6BA
         ljZl+rx1Jh3SkerTYD0llg32vj2g5vA1W6vkNypi0re8sQJMWFxlo1ooYX1YFcy7c20a
         Q41lLrimPT/RAU9jIgP13Ixry+QYPH0k3to7El7wutZMhouXS+SCJyxAigIenObKObLu
         3k+LLoBIjSLd4/QG3a8v0DCFtEtskgMthTg9Ry3sXjVqz95lPilNm8itY5OhjOV3PWim
         Ml5XD5so/6mr+ZF1v39EmQKGc4ZN0754csI7QIYWDydWQzIr4QZWZZzU3m8M90xD9z5c
         bFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828749; x=1790433549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xl99vzI4+2TnnI65ZZD8Z3YjYIk3m3LZhJLmHUA4G0M=;
        b=Pbg/mVsoEiBvoaX4FSRReBbSngg6hzPqIedL4KCj+2sKThli8KIZ+SiuUUT8lwvlJ0
         W7nb4iIV73sjTxvF7qQdfWFjIxPUtenUwdWXooQ35hGl5p97GuzboQQl3eauqpc0of/n
         1LkijeIbg5mL7k1Y1kxo8QcyEOwQnwZbR06VFLYswA94IdGeZUJDU+R8nRIICk7S9nDL
         5YaWlXsGNw24U5lImYZ2wjg7zsHcEcB3+ZwzGhKIh9Yo1LIdnC2D5Rd7Dl9ni87IcsMx
         T7ns9X9TZ3PXtXN4eBohayVquMf0PkWOEw5kiUSA0R00E47LwdHo781XUPVC7N6YldPD
         EDnw==
X-Gm-Message-State: AFuF++m4XLh0AH3a4rB9HARZgIXP9zvbEItO2TBEnllDe1JpkXGfYDnK
	fdSbWaXaLWK0lhYhL8r61yikaP5D8r2wdx0EYrhdamjY8/lQmllsRsKJ
X-Gm-Gg: AYBFou0YQ/QgnB4phn8shLRdp0OdaVZ6yZl869h4EBqwI7ZQj3UbWSXJHlAaCg/omtu
	s9QnA9C5pEg3+QVEj39sQCTKYwSyy423UL8wpMjMWVgIgEsueT4oxk1FtCoeSc+wx3CmPkEF6lx
	ZippQPlwMTiSq8YcxR+Lc9gcB2y7wDTVucFYguh5LKeY/g9v131H9IY/eivVcFR08x6Wy+v2Kku
	ZRSgIR6PYukBgoJ3mDVCAso6vjwg6GOtXhDbma9NIUdSf0ea2V6Q6uWZVBnljfiYOjdCJ5WRFeZ
	x+zqS92L2o4/T6VsbjkyvRttke2/y6kHLdGHr9K1rzDHidX0/Z9XE8M/Y35hzCpwdCZKrjQX8Hl
	ZJZW/UtIwY+gsq/ld5Ywe/X1dX52D7+lUASfTPHGMsY8uqal5eVIAuOdSaVcC2yuHoOI9A7wPxl
	/NDw3lkdPiTTSXpL5n0f3q6FCwgzkjIDdaT3Owqn9s8wIIqPpVnaxVthrUAqmxQxeWB3QXh3Uxe
	rSUoP568X7hUsY5eFPvj6A8yIsA1sgYsZW4JL38yw3Pnvs+iCOfmrfnGYuceuQwHt5A+Nt4MHP5
	XdXMRW211lgwfHmnT3RbCsP2PzzW8xyBudreL2bOCuqQbbZMhoazpUeG4bfrPue6912Ukg==
X-Received: by 2002:a17:902:ce0c:b0:2dd:ad73:c989 with SMTP id d9443c01a7336-2ddb1bc360emr93215125ad.33.1789828749395;
        Sat, 19 Sep 2026 07:39:09 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:39:08 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RFC net-next 6/9] bpf-timestamping: restore skb hwtstamp if it is used by start time
Date: Sat, 19 Sep 2026 22:37:29 +0800
Message-Id: <20260919143732.11772-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When BPF Timestamping V1 (SKBTX_BPF) and V2 are both active,
skb_tstamp_tx_report_bpf_timestamping() writes the hardware
timestamp into orig_skb:

    *skb_hwtstamps(skb) = *hwtstamps;

Since orig_skb shares skb_shared_info with the retransmit-queue
original via skb_clone(), this clobbers V2's start_time on the
retransmit-queue skb.

Save start_time before the write and restore it after the V1 callback
returns, so both timestamping generations can coexist.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/skbuff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 44aeea713da7..98cd813006b8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5686,6 +5686,7 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 						  struct sock *sk,
 						  int tstype)
 {
+	ktime_t start = 0;
 	int op;
 
 	switch (tstype) {
@@ -5695,6 +5696,8 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 	case SCM_TSTAMP_SND:
 		if (hwtstamps) {
 			op = BPF_SOCK_OPS_TSTAMP_SND_HW_CB;
+			if (static_branch_unlikely(&bpfts_v2_needed_key))
+				start = skb_hwtstamps(skb)->start_time;
 			*skb_hwtstamps(skb) = *hwtstamps;
 		} else {
 			op = BPF_SOCK_OPS_TSTAMP_SND_SW_CB;
@@ -5708,6 +5711,8 @@ static void skb_tstamp_tx_report_bpf_timestamping(struct sk_buff *skb,
 	}
 
 	bpf_skops_tx_timestamping(sk, skb, op);
+	if (static_branch_unlikely(&bpfts_v2_needed_key) && start)
+		skb_hwtstamps(skb)->start_time = start;
 }
 
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
-- 
2.43.7

