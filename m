Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413220;
	b=JDpzO/8cq9NY+2svBufYVGHL9OG/6BIchY2JcVWqD2pMhOqsgzNdWcmK/kBH4jCQI7UG
	 IDcYa777VQClkK8ZnPMh8FGvRzRF01CfecTyqjIcEjuzNgeHTwf5p8qhisBIdm1aSh9FT
	 6Tm2YczaP1zP1P/9oG9JR4g63HkCF2gpVSoI30LMGDDpGluh0sTmYxxKp5ZstTWelpC49
	 emRRmtts5bfyUXzjNXKsY4MIclSoyl2OtmrlqK2EII0PEFfRiF3SIdiM56Y700J0HjyHo
	 6c/Sl7NT4Ax9FMBcKDfaLW7R9gNwsJ3zRdzBGJ62pMlJuk0XZqnrLxquoUb56wpdQQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9BSVf0nHP4/mhP9EqbQcCZ9FFbpmkiKR53pnCEDo/p4=;
	b=BT+MrfYVbfdd9M7K1N1Y1qNhEXhLkXwGyJZPP7lM/8Bes4Yrte+/CX/4S+mvwShga+4N
	 PaRQRw3VUGGBcxhOzIwusAu5b+MbWqsHhjmDVt74zEzM96b6CgH1lNmeqfKcKGE4Vy//L
	 7yVwOOIAaCdaaBecT8J4PsZPEZqroKD0Z3T36Izal52k5w+l4BP0SKeOWBdb9+GEaGcPm
	 7ULWBAx8ZQFUP/IKzFp3TWndd4Jc5ZYab0RYQnB/SH3rmUSO2ivV0ItB8TILavFs5on4n
	 lca/tk5xEUWzXctAk3A77ddUS7cn4mH4Ys56+st0NyO9XtlkcBtBD1KGkgw2Jq5nXzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zJR7GQih;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF76606A326
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF76606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zJR7GQih
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so32934495e9.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794413219; x=1795018019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9BSVf0nHP4/mhP9EqbQcCZ9FFbpmkiKR53pnCEDo/p4=;
        b=zJR7GQihQ73Z/nNA1UHEb+m3JMssWqtoH+69LxKJb236waKuGCqP1jBnY1+prralYt
         wJa/5JZDK5rob/brOCQgzqOCU6cr02+AK7CJFdQL81167FXtD3kIwpTsuEufcDo5D/d9
         I65c9oFzQR2YeQqMW0jhQNVQi7YHA2DAQwqo9QM5oPH7iGytXu9TJUKrPy3tCqXIKbnU
         snYM/PYdpPht4CtPBRoQ82UMQzOwTcgMl6UYE5d+5TWC2XMpkZJGx3GaxDomNCNTm4QF
         aorF8HkdMDqY9GuckAw0gkC7CknPK9+SzAQS3kPwzwFumMGWjJnTHPuqIOJj14CWx7k3
         lN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413219; x=1795018019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9BSVf0nHP4/mhP9EqbQcCZ9FFbpmkiKR53pnCEDo/p4=;
        b=GbqDkzhSoNACc8W7N2q/bNqTY5WEuIC6YKbw3EYBL+AQtLgw03a6gR2okOJz5ubctQ
         AVH+4+WtDvm8PZ3OepbDhy7crqbZl2rA+RdN8rEK9xNn8igV2RXnz2dbjzW5X+ysCcWC
         yRNyrfxK5rMdvw0Sc6nd9fkYZ88QKMLaPCRxEmaimOw3M1o8EfXTt+bXlXRhrbgXmcL5
         9RKIKXt+ucglS3JBPq0sOhLxXkNzmJzpL9It7BFR9T9bn2IOTpHFeAFZ7b3uYY+6dWKn
         BHkzVHjBEXPKaPW6G36R7xqQ0I65CXM2Pun6sc5JQ//Qpsdco1N5/QkEVZzfr2KLjR9z
         BMfQ==
X-Forwarded-Encrypted: i=1; AL+hErEgEALobdwMQXY65kdlBXzd7vlVcdVpttW02gfFYHeecAWrDaxJx8+WhblLJAkw0o/qUM4I5jo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YiAEl7lkW4NzP9KKinxqNxqRQNXyHAFVA18qtujMoTQYAmHge
	04w3DIBGjBz4YhF95apBEOZJgKnalIiZXlDbt0uv+3gBmEzx5od3qY0=
X-Gm-Gg: AYBFou2tzTLuAuSaONXZJVXKWyBHTR0bUZ3Y6r0vHTQjAODE088dNmYKABAA8E4yRqm
	aP1NGgYPu77wFR4CF1GZnEUbl1zJM6g/X9vfvMMJFnbBOVKUtTwl+Op0xfRJYXFXcmCjRkvHIGa
	ZVfBFuppx6Lr0wjqpKqEhZgvgua/X0AnEsqCOSJfXxNoga8kShxHOVZoLbURshpoUexVUkBnKeD
	UyPwh23B/mWN92WB3Z8ds4btC8CsO44y80YPnJ+w8D2IKysnvtFehx2mjfuI42XXFfZwFKKY4ws
	AlqV4Rrf+YJn6FjTeOwyRbH2poYWnccnWyGJ5VqUsRj2GKJfxUO2+M3ArIX71xOlI8BUDSpi71I
	oDG2H9eE/HaYEaft2hYt0NgiNHhL6gq+TVRd3q15L8GX2f7xXC2oPjpviUFv2Z79J/KvjT07f4E
	cNe966dGnYurcBJh2JmeCTpTrEIweR/1R0GHcUXhWvpq9CuCLBcZzYqSXnqwygLNeuAV7+vHX39
	XmkIK85D6UEyaXiuvrV37H05JY/1xmFXGZUge1FQg0YDbxuM2lUyk8xtgeQnVoZ5yoS7NCQeQbX
	997PpGQErLtGKyU=
X-Received: by 2002:a05:600c:3e07:b0:4aa:1527:659 with SMTP id 5b1f17b1804b1-4ba0938369amr51998385e9.17.1794413218559;
        Wed, 11 Nov 2026 08:06:58 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4c57e999sm8350485e9.1.2026.11.11.08.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:06:57 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] net/ncsi: use kfree_rcu_mightsleep for RCU-protected list entries
Date: Wed, 11 Nov 2026 16:06:49 +0000
Message-ID: <20261111160649.677910-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

ncsi_remove_channel(), ncsi_remove_package(), and ncsi_unregister_dev()
each call list_del_rcu() to remove an entry from an RCU-protected list,
then immediately call kfree(). Concurrent RCU readers traversing the
list may still hold references to the freed object.

A similar pattern was already fixed in the VLAN list, but these three
sites were missed.

Replace kfree() with kfree_rcu_mightsleep() to defer the free until
after an RCU grace period.

Fixes: 2d283bdd5b20 ("net/ncsi: Package and channel management")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 net/ncsi/ncsi-manage.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 54d0df0a9efe6..64274a5058346 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -263,7 +263,7 @@ static void ncsi_remove_channel(struct ncsi_channel *nc)
 	np->channel_num--;
 	spin_unlock_irqrestore(&np->lock, flags);
 
-	kfree(nc);
+	kfree_rcu_mightsleep(nc);
 }
 
 struct ncsi_package *ncsi_find_package(struct ncsi_dev_priv *ndp,
@@ -326,7 +326,7 @@ void ncsi_remove_package(struct ncsi_package *np)
 	ndp->package_num--;
 	spin_unlock_irqrestore(&ndp->lock, flags);
 
-	kfree(np);
+	kfree_rcu_mightsleep(np);
 }
 
 void ncsi_find_package_and_channel(struct ncsi_dev_priv *ndp,
@@ -1969,6 +1969,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 
 	disable_work_sync(&ndp->work);
 
-	kfree(ndp);
+	kfree_rcu_mightsleep(ndp);
 }
 EXPORT_SYMBOL_GPL(ncsi_unregister_dev);
-- 
2.47.3

