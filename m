Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517228;
	b=DbbFpy5k0ner+JqwXpc0FEnUM8CW0W7vJDomci3T3v8/70HPJXTxXgBNwIX0JDzI62FJ
	 XKbwKrgci9nWUqm2v1q0VrmjG4QBhZ4CPKnih8Pa/FSwsjuRvfHqyeVS1ayff/pL/4wCI
	 u8fwB7FPPxD465epWfeSuM/azY8M4UpwEUklVm/gzEGKUqXXBJbvTTcwdIlxsLHmC+S4Z
	 YRMrWVBxoPcGvEYrJ2uet8zXtCciqDdDBBfM/izxvaVNEmm5ItwkFNrmc31LF4gwqWzxs
	 N3l6LO+Vp/uBAk4zffTxDWrepK+yJI1w7j+/V+q1odK5cK0bEV5DfvM1Z3n36xKAUGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NHAmGjcfTdm8qHvpHOWbs3PA4mhZ0gnX7tnDSRMFqS0=;
	b=JkMF7eYLwi8/G8epkNBMfenOKCoKeE+SAcAU0rtgdYZrNTSXB1R6rWH2qLKou60251Ge
	 Knk8vKvQ7zSdpR/b4p+rsRymC5TqE+znupCHKIs7Z/odRo6zZAvL+9Nvp48LEe7rFSzdL
	 LCo4012pfy4RakFL+YvHZtOyFugdrmA8t+c7GEPTC3jWwkGxncp9267jOM8tXfOcROUut
	 yQAdTz6MFuL0pDPu9sdGgdQgQIDLbulE3B+Xi2rcijjvmTxTN2TeDlKtloPHCAZOtRJRW
	 OB2yfVmulBjg5L/PgFk7j/TTR+jEgBuZUcKexVWN67XHBzPJHgEMhIG6aEG0NHraCJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B5jMLift;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445C606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3445C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B5jMLift
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4c02ddd62so1722583a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792517227; x=1793122027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NHAmGjcfTdm8qHvpHOWbs3PA4mhZ0gnX7tnDSRMFqS0=;
        b=B5jMLiftl50uzfRJ9Ytx4MTHqxHFkHmokX994LfPaRx9pIkV0QcoUI3rFafUxnK4X+
         M87zfm0eROxTPvS81l1ICDsYOf4Vv3A+0Zw77IA5JJpo+65bD3NX6qNycChMVAWTx3XQ
         51nipwU79FTekphCszbzGqXBiiyvPYxL0uQc+050JnTm8IG1rG+WuYinzPC4h/Cx4sou
         Bt5FZueogVkYnYZI+Mp7VpTbJF5CsM9FxBGWveNigmO0+bI9DNEzSqlc88Z8bmhdEgzh
         nGAgSRxx/qQ1mNv9kWOtMqaDFXE05LWnj9jLASIF2YMK44NVfhOD4U4AzpOOaQHyEkpi
         43ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792517227; x=1793122027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NHAmGjcfTdm8qHvpHOWbs3PA4mhZ0gnX7tnDSRMFqS0=;
        b=0jBYq8285RaVZ4al7VICPivDt+gAHWz2jDbXV6E6WKiHELd6XrcPWyJiWWeOUyv9zR
         UUOaidjMXYEK6J9Ec23t91I7k4EQ8pElog/u9y13xXPNTm7duG6PtkvjaX1+40qjkCPG
         jVmCUTA4I3UBG3hAhqYvgBOtk0NsoaCGtppzbS5N61vBX7U8GRmeYFNSJZJK0pssw3eD
         w/SVld1UHGTkgeD4vBQbV1s0IhtncZs99Kzhm1y/1IBIbPjJB7S+JU7Ux2vaYowim/+U
         6QUIL9+mbw+IpLr/NPHaTPo5E6Ozj+0SyuofMQubD/8eaQAavViODGYG7dyHECCnJPJB
         NhKw==
X-Forwarded-Encrypted: i=1; AKwUvBxs/QIMJgHadZFsqJEMiB5e9b4wHueRm29B0HuWcqoffLvplM12uRXMQJa9iRynfSlm2jcRuLg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKBJgi/lmr8inaa38NQ8UuNviB5lrqd0V3DzOXZLzPjW395KVWy
	y6RIyDvc5PN4FLNx/CK0BuCwmbT60ciFdQNyc7Mqz6MYJtFqIHIUCiuY
X-Gm-Gg: AYBFou3kSww4RNQWjI3XC5ftTh3uSs0d2JfiEkX4+z7Det/qazUPHnLDT9fAYxuXkn/
	lRrY9YqxN+lLa6KW9a0AkE/l4jfgj6rqvdyvbzpjKpok/Vjb4EL0hfJiKgd+HQ0WE5J8aj7SVUf
	e8a1nVxKhAD/ERIgUHL3y9qNuIizza5k2jUrGWQ+vmxqFzYQN/NQIr7h/cCa6btcqOR/7s/NUUG
	Xyd0YKJ+OIvfx9DLC78PWmqKB6QHQ7EKpqESHiO24EOgjXl/5vafUJ8aILIGqogFqIIOIbAx/AO
	KwesMpMpMCqGCRPv/qQH9ETnQCo9Wkdsmlr3UG87xNB06xBhn9KdXM9vozPY/fM2TAXMh1SrkxY
	wQE/iblHm5bYpLNVbC/7rQ5Z4Mbrq5eDIkB/96q1Ba8EfF94Itzxgwh/bPrIF9wTrMkbp7yD+S9
	kuhg9hGfmrNVwNF310TqhtSp/ktx/q5Ot6LeeCEMTbqJNESVKueANe9+TzpoBRbfssHprVv7ti0
	ur0bKo1nu02itdqJA/5GPGoe1mRFRdMI0m7XkTqK5o6splQULMyVh+5Sj20
X-Received: by 2002:a17:90b:28c8:b0:3aa:548f:eb77 with SMTP id 98e67ed59e1d1-3acef5f1ccdmr10361895a91.56.1792517227458;
        Tue, 20 Oct 2026 10:27:07 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad802917c3sm487593a91.7.2026.10.20.10.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:27:07 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Dimitri Daskalakis <daskald@meta.com>
Subject: [PATCH net] eth: fbnic: Correct packet header prefetch
Date: Tue, 20 Oct 2026 10:27:06 -0700
Message-ID: <20261020172706.1090951-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
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

From: Dimitri Daskalakis <daskald@meta.com>

The existing call to net_prefetch() fetched a stale address. The data
pointer is not initialized until after the call to xdp_prepare_buff().
Thus, making the prefetch ineffective.

Open code the address calcuation to give the prefetch as much time
as possible.

This was found by manual code inspection. No issues have been observed
from this.

Fixes: 9064ab485f04 ("eth: fbnic: Prefetch packet headers on Rx")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 10caacffee0f..69cd96a4508f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1011,7 +1011,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 
 	/* Build frame around buffer */
 	hdr_start = page_address(page) + hdr_pg_start;
-	net_prefetch(pkt->buff.data);
+	net_prefetch(hdr_start + headroom);
 	xdp_prepare_buff(&pkt->buff, hdr_start, headroom,
 			 len - FBNIC_RX_PAD, true);
 
-- 
2.52.0

