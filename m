Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8554654
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781047607; cv=none; b=sreLnad51hBRyw6zM2ffnB3WVFW7p5+xpS/v1VYAaT/m4VlOf5/1LDTtHbRNJBDyis66sj4cWzCYWQHob9/91ECU7N7Xny8phTMO+H0VntKBatuyifoH0vLXTfeX7nYe4KeWnwa1eq8YsZZ/Qrwa6L1TLKYCxk1KT3IOthlJQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781047607; c=relaxed/simple;
	bh=VD7dY7vSDCEpcauIsd4v/+QlmpscfEX+f4uoEaVEBx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQMEwMykLXaT09kOgWn24+ZLvIuxketcUrpb1+oP4sz1zg6xL6S+yB2k3+f3w3MK5ld/4312il9j8f0tkq/CbaBDCUnEg97tjXvBsS2xVSomKQ0AsJzT73VIBjvOP7mEi/3rNUysEpt3fA9k4lwEN7rW/2cZSeeV8qhKum3+YjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=MSksUcZ+; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="MSksUcZ+"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccef9eabccso68380386d6.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 16:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781047606; x=1781652406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8FSs80YlaqSNhhsNPLd7CnSfhWZyco7BKdP2zbQFlWQ=;
        b=MSksUcZ+PZEAuBmOpalC5eWjJvSxEJSghgKAysFplaIlBTBW+QUR6LBuExIOCGrKDD
         3N4OAg35eUMJPHJCBrDxNctSQwIGxvIxa7O+klniu+WPYWC3EkjN5CVDn/jHrH5tMcFN
         HwCq3r8wf4h6gucP++phPJxIpTG28CHwujMhjvpStRc1RfKi4ab6GGPyged6kGZQtBiI
         yWgJsQdTPuvJg/AYeaNBHOfTPPcPDO+qhq+sw5pwz/2Bk7usj8KQtqluyk9IB0nYEvHf
         jKYErypEuuT1p/cfbgH9EbfHJ3mTLAtplSnLKQYerG9ds/2rnqsG7CuFmG5F9TQz/nJB
         NMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781047606; x=1781652406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FSs80YlaqSNhhsNPLd7CnSfhWZyco7BKdP2zbQFlWQ=;
        b=Qzu3TF+CB/RJhbvErJFyCNCLj8A4XMXVvPhFPoEo2kst1RLaG4BElihBPtRA359ntT
         TFH4sgGn33CF8QLvMkZrHR2C5cCLqv3FxwkJ5bG1KRjpyd2Pqu4VCB01I84hHZxFVIoY
         wVoPACXNO0EscofVue4YUxKxvmoRurqgtWZ9SX/fml9yLhbNzJ66RziwDPFQn/Xhuusz
         pkG0tWGh3b/0TT2Kb7ZLb4AtXKW+JNevtKrE6dsCnbW3m9+H1BlcqpIZHqrYTGUJRog3
         ofXpeUYPDwRSasgBfjVzddAhwvC7A+raJuSg8cXyroAmTj3XSrpb02zmnG2py1k0Ih+/
         2D7g==
X-Forwarded-Encrypted: i=1; AFNElJ+yIQgmSL3MwQ/yBjE/EJXBiPC7ZDqbnLH5qgln5ytrBkDsL4trpCZdhYVlAte3ov0yQqeYFsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfGoTst8ZQRazNva9rHShUSayIiX0VzFwLQP5MLRTT0h22LeQz
	SwgS2XJdDIcGjGA3E8KqJdm8vaB1tKcJ1czeLxpaf0/CuMWJHdWguqDXczGo4KuQ5oo=
X-Gm-Gg: Acq92OG+4sWdfywHcvjBiouNvdfbgKSsaDyLALYFXvlJD5qQkDcufYVAwnA0jNSgmfx
	jlZowa6wwOdohoQ7KXapQCDaYU5V6NJdr3n97VEvEPF3feIALGaZ5Vr1tZ0uoup76P/C+FhzQMD
	YHs60zR+d0mAE1ttxnrKPNyoAONKKJ0lCd+mlTWP9Dn9F4BLAUKMeiWcj+zLnCrjpcaB1iIX1gw
	VkmDgSfC4in/73jorNEX11MD5BurBJ9+XgmpSz6NH+hhZMA5OPEKuLY5sbl0SG5Co2WBkOQBhkE
	g99fJyN02O9Ij7zxA6UwxRjpOlOgIQoG5tNzGNp3lTRdMSXxn6p+TQddD06isjPOUSJp+H2P+lC
	0Z8ShHnTpoTTT+GUucLdvlbb7jPOkHcuCx4AohI5Of18UXWPAjCTSLbN+cbaA3BVhusnJYXou4f
	I2zF8sJDZ41eppVAT0/6v/sZK8SGDW6jA3679j4w==
X-Received: by 2002:a05:6214:4a03:b0:8cc:e17:7d16 with SMTP id 6a1803df08f44-8cee8b0b68amr275892086d6.7.1781047605719;
        Tue, 09 Jun 2026 16:26:45 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd055181sm215524426d6.30.2026.06.09.16.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 16:26:44 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>,
	Olga Albisser <olga@albisser.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net/sched: dualpi2: clear stale classification on filter miss
Date: Tue,  9 Jun 2026 23:25:21 +0000
Message-ID: <20260609232521.1602334.0764789957e4.dualpi2-filter-no-match@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DualPI2 leaves previous classification state attached to an skb when
filter classification returns no match.  The enqueue path can then act
on stale state from an earlier classification attempt.

A filter miss should fall back to the default path without reusing old
per-packet classification data.

Clear the classification result when the filter lookup does not match.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v2:
  - Add fixes tag

 net/sched/sch_dualpi2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index a22489c14458..8d345a8ee4e9 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -378,6 +378,8 @@ static int dualpi2_skb_classify(struct dualpi2_sched_data *q,
 #endif
 		cb->classified = TC_H_MIN(res.classid) < __DUALPI2_C_MAX ?
 			TC_H_MIN(res.classid) : DUALPI2_C_CLASSIC;
+	} else {
+		cb->classified = DUALPI2_C_CLASSIC;
 	}
 	return NET_XMIT_SUCCESS;
 }
-- 
2.43.0

