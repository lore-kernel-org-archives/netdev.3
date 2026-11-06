Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990912;
	b=qKCFwwGz2eO0iZ8Dd5gwysFt1lBAQHr1R3uQFTzRmK8bKRW9MlILPJjD4eYqBPmC/ARf
	 3hb+41dNd/KhUWluLMCMoMK5hC00VvxLQVOksbNeA+2we2Pi2XOZtXIvrD3mNFoIigPlh
	 nkUQfZzbhX8FlvmeKSZWFg5WRXHEct59X46lvRWF9JlEJSDs920+FGYwwjFcmJZ3uV/Ry
	 Frwb52vBsPAYjE7QpIMtirq7lR9YSNUR0QRFYALbrrpmqAO8AvJfUkEEmCpVNIwWdW31N
	 jhm0PXmjD3WqMz/2pjKvdzKy47PND7srxowVNZkVR0qJZEyHnWcVlM0050fZS0AVA/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2HdBXlaJXaYgSMY4eXF1sMxsmXNGqblFIccArGP2O60=;
	b=Yf2urs24fWN/EuMFbto/QzELTwCws7gF/1OOyf3NN13AyyBkRLB9mpIFKbdVUpVh7Vhw
	 q/GT27t0cX6Nw4ZNx5xb9hnpPqcQ1m208tW1TXIYrWcrSVLXX2Rp/GJg5VJLMhXdI6MPW
	 NU2YcwbA1jvze0zOANsm4RIOQXJN0clfoYbDhN0Vf/bd3LyGwNvDr/yL+4Ry7XaOB3ha0
	 OpF2NZSRPxKPwlw5I0sJEf60CQSpYjRqljlgFPAaGh6dtPlQM56CTigYwl6731Ou5JNMp
	 uVthZbIFa8f74+LwXDxiRW5Pzt2NjDuBWAQYmq0zDNfyrsvlouB23ouLb9XlAFXrllQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IVV9lyFc;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C505606D81B
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 18:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C505606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IVV9lyFc
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso480003a91.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 10:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990911; x=1794595711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2HdBXlaJXaYgSMY4eXF1sMxsmXNGqblFIccArGP2O60=;
        b=IVV9lyFcxqRWIXGP5/aKRAL4R/xuzADJA6z1/gV58kmc2MSy/Auc7xNH7zVrmhVKqC
         eMVyhcti5GUxCK9fWzBE3xQ6nFWXy3OQWJCsoDWlwBbbOnsAAzjLhU573zYCq2hmHOhO
         UVfcFIQQTHiNY+9IuouTikXbesNZpJgwWrHEaWNytfoSvjczrORPSU1PLazz6xBYmPRx
         kZrud4KvAf3zH93+CCPUvJayVaxNbcVDHTYpmhsAl3MpWWC+kh1QSZDAnAUMfkrmj171
         V3ZYb2tCELXEJdsTLQtcTzdRMEZzpHNqOCC7khM3hXJQn3VClPEKP3mLikTi9Vm6kmP/
         uRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990911; x=1794595711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2HdBXlaJXaYgSMY4eXF1sMxsmXNGqblFIccArGP2O60=;
        b=j+RDwjNwPGZqR7mkseRP1wGy4+diesl7GYuT4ex3MdewoaiseK4GEM8JtrDF9g/ZZP
         3sCa305McJwHCInLMDec/Lg3NKsR7c+jQsZiZ6UXQxlPFfuUs7H97HBf4IlrDzfGWf/Z
         2J/UUa4gjhWSOX7X9RINcn58cXQFOl8NKT3Jy+zhWJjhJ+ndyOatf3g6EtlFVQGBVPnY
         FVHffLMxE8xGqSBjLUPOVcQzVzSaWyo4V9UKJ5A/NXbW+Cabi6u12QwiDNexgiyqjAq/
         OR6fW7jceXt8SHhL4iBbvciKHCJuvn5RFAxU57pSmV0lPIRAkj0jWv5OuKbRTHa1y9LM
         XmsA==
X-Gm-Message-State: APuU4Z+oWIST3BFBHpoCPnjY4hG66uuyZNvlztMR0zklv2dY2FQkXh9l
	ZzqsqVf3F1i8Sg9vSngHo0GeDX4M/dva3Usbjx9w7Horagy/X5zEkSk2Lw2kQjAK
X-Gm-Gg: AYBFou1QvJ/RtvJEfubNBdGN2y/a/iNw4boqvHpgLETTbVThWLqveQMFszeuHNnrL/L
	sRNZffgufE95h2MUi6Q2cSaAwbx9J+jyuQ0N+gpAFFD9VpMlUcQ6GqXyir0KYfHGUFOPDtb0Pix
	Kk4yTHX+KjIxGNquk39y+oAo8TerGdC2WmXfiflxd4huP41SsSK2bPGIC2REyqzV8/ujgyul3J7
	GykwqHnmYySIIuyVCnFl2moMKYg138tTMz3P7RRtNlTdFFcTT4oNQ+lyEUgndSTVElYCVZKr8Fj
	4AUqFAc5/sOf7WdbBCahPSU9SNCYw1IA2/8OMwLJAc/gzuSh6JLhzRy3PduGNkOC4kVNjQjsF0a
	FHJZvs7f1zQj+JQgod0RsZaYijxOJg1n4nNAdSY408ollUdOXlAb52GA/GWTBwX+aF279cyw4xv
	vbqj44dRpc/Cp/U+7apJ+9FYT0i9Xe0TII2KaiJ6DPdJ59T//9qNIpaS3QW+RHaKnS4Ysk50qL/
	C9+HlY9ODwNOMB/cZWZEmxS1oAWxQUJB5oWGXV+wgytzgJuTBPBWbquWSCqWlxQ9ZHT1aY0vEt6
	dLrzcepeYiG+CfpiAcEBZeyQwQZ6ejE2z9N6XJdakOckJEMvBejP
X-Received: by 2002:a17:90b:5343:b0:3ad:4bfc:1e77 with SMTP id 98e67ed59e1d1-3b0db72df1dmr3442049a91.66.1793990911494;
        Fri, 06 Nov 2026 10:48:31 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm45036a91.0.2026.11.06.10.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:48:31 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: dsa: motorcomm: Report error when FDB fails to add
Date: Sat,  7 Nov 2026 02:48:07 +0800
Message-ID: <20261106184811.350700-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106184811.350700-1-mmyangfl@gmail.com>
References: <20261106184811.350700-1-mmyangfl@gmail.com>
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

fdb_add() ignored any errors returned by the hardware (for example,
table is full). Return error for that case.

Note that this does not affect userspace tools: .port_fdb_add() is
asynchronous and DSA core always returns 0 for that.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..a7a9a7439304 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -725,7 +725,13 @@ yt921x_fdb_add(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
 	if (res)
 		return res;
 
-	return yt921x_fdb_wait(priv, &val);
+	res = yt921x_fdb_wait(priv, &val);
+	if (res)
+		return res;
+	if (val & YT921X_FDB_RESULT_NOTFOUND)
+		return -ENOSPC;
+
+	return 0;
 }
 
 static int
-- 
2.53.0

