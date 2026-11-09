Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259575;
	b=vdagI+m6iTfFRzayhLHA0VZjSt6U8eJAHYnVbjXU5MnPFhJOWx8KD+dp/WPnt59xLYiP
	 8kbhT+bzegjKt2iony1htvOjEgbU07YHhLbaQREu6DaaJJQ4+3ZS30TCpVk19JwEtExyP
	 hGbOci+94ncXIomWLt7q6pPc93YA9DNPpQUFxqPPoZ1V5YUfeiEkpcPsf+0NA1f414jOV
	 iRqEo354CNeSX5Sn2UPMEpI/qtgFyMRzqhzJ0idknwEDfCo3pDvHCdWy70YESxDNXKTRu
	 I29PvI1F1eOKUAt/nBl1WPOuorkBxkm/dTK+wfufsshimYvX4OJgdO+KYHsy53Adm2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LuuRaYJ3RhnMpsiZ6yTMucDw1d3M89Z4iz4EInyzFLg=;
	b=i/2XkpSgMQj+ssLV+1nVkCZsK9YEnCnHOyVh+RkFzBEbOk7F3Jp0/Iolqet43PmXg7d8
	 GR/wuTj2Zcak/MciPAq/fCjvETP3095PXArM0sQ9XjnETYpLWXwB0bCL+6Q0eP5wIJwtj
	 dz6BkkcrDbkWQ6iUwSUiRbvIJzJWuinfa/lSqAqprzncr5VMknrHO2CV9EzYQBxfCHjR3
	 saDw77rPD4LVCF+GBxIX5BLMgt7YBm3IJS1FfAS00UvbvWijpwFujHSSkqixQso3+Z2Xo
	 EtyvMtLyOwCarzg5TY92telQOSUbF4p59eHKGyeN/WlY4fp3Sp73uQGW/SadFAvVkxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dLp1duIo;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7440660A2600
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7440660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dLp1duIo
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc147d86bebso744469a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259575; x=1794864375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LuuRaYJ3RhnMpsiZ6yTMucDw1d3M89Z4iz4EInyzFLg=;
        b=dLp1duIoL7Hp/a0Mbap9uxdGLnG6q7tIkhr8ggcvGlvGWOyTMBfmcIpaOklVXyMYqc
         2QVp7Vm96clvSyc8WPSTEY9snjDzCrwpAPN8vUVhiLOhImxvTt0O2fMRi9MNp9GMPNaq
         TsKlmRSHg6HTXSrIn0oawe4Rn2MF1rIdzA5EATW+f/TtYH4OMeXlx48Zl+6O3yrXBDzE
         AG4WyWpvCkVQ+oQIyKNEhgv4tbGevFgn+wPzgzy617TpXUIOXxNp1QwcdE2TtmmLfFAO
         mXe5j6zdMfO71+9Bvdi1rWkNp345RvYe17b7fC+nAd3BvUWBIQuVshhkoHRsCkWIe+j/
         tqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259575; x=1794864375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LuuRaYJ3RhnMpsiZ6yTMucDw1d3M89Z4iz4EInyzFLg=;
        b=WRjBzSq3pZXUC+6Nil5DgZSMf1MINFeNnrCNmGQzV9Ng+12r1WeB1edMEbvyXxSWQj
         NXQbqtXmwRhheGN6EYogkHOVg2KnG0ZOdk3MOhs/mNEbSKsaHm8RTORhHoEKEjbE99uC
         /vvUGxNXjQDo77TJNDilTzyuKnQujJa6nwMYS36PMOaHsBEQWjHGNiCKW7jEJeBPhpC0
         TAQ7j4HXa6Eo8vzGaVGUR9i8v7LGykfgEnGujRJeZm8Duo1qqdTwEE1xPG7N9rYaIYbl
         0XxGod+JrXcCyZHT9/JVYsoSl4s9RmTdOyR358bnHzVF6saGZ4LoiXqHfQfMeJ80R4im
         YrIw==
X-Gm-Message-State: APuU4Z9BLzGfwGTBKw2VofKe84y6qqB7mjs54P9d9gmcNQCMTtzwv1Wh
	sZKBXl1cSOaNLLRnKuVQIEXo1msMrYTHoSjzgajlNtPgoJn25fD5SBcUUbkDRC3guDHSJ+AEBTW
	9IbZGa+g=
X-Gm-Gg: AYBFou2OPd0UJQVtAWPvfZZeFkXGvt93QnUpO80Eev7QrK0KYyQLw7+VafJ2GqFZ46K
	qJogBKmAONQ0ULVP9jZY9hBnTvdzihHj18VkNsTF6I/teoZcbqv4Ylkn7FcMk+dfQ+XzuMFojmu
	wy+TetTsz+0tnqM6H3VLiS8RrWnCPk2xrfkUcg7HVgF6bMlvK9v9UZXWajxWIiwgSQnA1xtbk5V
	6804tM5tvs5968n0Ys6gydiFsf+0zhwDjs9e7OdcZiFLYX68oR2vvuOusR4dtB6U2BAfk6o2HQa
	9cc3Kclpy+DUH1KDJ1Du2THtT00KVWvvb6aXvuaW6q8zlu6Lrbfz/kIS/Ser1BdwGlqPeg/Ttrw
	+n4AvzJNp09E0elpcct4qqWHnQK8tSmRa+jB/ny/kpX6UZSNd1yv3rg4/A5IYUWCMRGQ78I+lzP
	xEKsUDFiLN++zwo4AmEB273638eO/fH8LKQy/lAooGjf4MGnqqZ5vrl6GOo7g3eYaN2EAztVNUk
	1+fVAfceHrCP5vmLS3EU1DO44VM+S/o70E7I52jjexwBwZVvzdNbmoOLwRb16HtPznkMKixQmt7
	Dq+N/XJODrBpJN2maTi7f8uTBaqkdlbfUYKJWyAvr+tzcEcPnAjcoPdYtDoHH1lc2sj6
X-Received: by 2002:a05:6a20:6a04:b0:3e2:26fc:2e01 with SMTP id adf61e73a8af0-3f18ff882e9mr309234637.40.1794259574786;
        Mon, 09 Nov 2026 13:26:14 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm122854b3a.5.2026.11.09.13.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:14 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 11/11] ss: report a failed SCTP or MPTCP dump
Date: Mon,  9 Nov 2026 13:25:27 -0800
Message-ID: <20261109212559.39661-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109212559.39661-1-stephen@networkplumber.org>
References: <20261109212559.39661-1-stephen@networkplumber.org>
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

sctp_show() and mptcp_show() discarded the return of
inet_show_netlink(), unlike every other family, so ss -S and ss -M
printed only a header and exited 0 when the kernel could not dump.

Neither protocol is dumped unless asked for, and sock_diag_error()
already reports a missing module as lack of support, so this does
not add noise to a default run.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 55d9ae00..26cb0942 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -4095,7 +4095,8 @@ static int mptcp_show(struct filter *f)
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
 		return 0;
 
-	inet_show_netlink(f, NULL, IPPROTO_MPTCP);
+	if (inet_show_netlink(f, NULL, IPPROTO_MPTCP))
+		return sock_diag_error("MPTCP");
 	return 0;
 }
 
@@ -4104,7 +4105,8 @@ static int sctp_show(struct filter *f)
 	if (!filter_af_get(f, AF_INET) && !filter_af_get(f, AF_INET6))
 		return 0;
 
-	inet_show_netlink(f, NULL, IPPROTO_SCTP);
+	if (inet_show_netlink(f, NULL, IPPROTO_SCTP))
+		return sock_diag_error("SCTP");
 	return 0;
 }
 
-- 
2.53.0

