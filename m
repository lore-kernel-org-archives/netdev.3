Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513659;
	b=qyzWSeB/V2LSGtcSz/bWdCN8Kofr70soZw9+ACtk62EMRx6zz0ctFF9uoohZ2qOkAvQT
	 eHcWjwHlAOePliP/+3sWI8fjt9oMfDbHqRnBB+pM3Mt3IMqI9MY0kPhJ1YWSB3J4cCkiH
	 VkEc60zeuK3j+ZQe7Y7JBZ+vkj3Ir4lHD+Uf2CEESzZ/neHSEKM9TuTeBOABuMIiWEl0c
	 0ZCkBAVwmBjBD1aefTqUagGsf6Lbkr8X6ToVBNiH7OQwUA54B47PTT7kQ5BxZ8/P+Ufkk
	 hMJiRlRXgwrPwoYjC7JO6caBz/TKAFMSU0Wjc0lSI+6h6jtEA42oUxv/hyI3Ro8vZvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eYNgo2UVBenIRIwSD7tfpreyjCqu1yXJLp8IAWrk/4Y=;
	b=NWwt4OAv1fCiypjfXy1WTlfdVkzuo2T2Pz/0TZJfidXP9f3ddCAGHQtMlrUu5cMvMs6l
	 hHStzpcIt5ffwXTT5y7DLaJXuWhhq9uxnzlPjbkYJdRPDTP0Wki4sqhFfOoIlgTertszz
	 HceutfymVGmbVY7bilvNZnrMhK3s3YEXWI0y96OH+D4FZn5OhC6072CjALrhEUG/9sdoM
	 OD9Geo/orkoy257l0H3+gBd+oljspmQ0FApTNTYGT7gOotBpj3UiGMAeaNmUPWQQrzLXq
	 tSIxMM1wqDZuR1dOm6xZfcshB/uehMK6N0OpktEUeCCP+boXNi13Lh1RyKMhz0ptvSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kBgS9Xqq;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250C1606A33D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 250C1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kBgS9Xqq
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so116588a91.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794513658; x=1795118458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eYNgo2UVBenIRIwSD7tfpreyjCqu1yXJLp8IAWrk/4Y=;
        b=kBgS9XqqFCm5oCVdvyKq88qGeiOyMffX/UMqVapiQldA5zJCRkKOoSxQou9YCMNVJI
         Vdrs5dhXrLEpjruauxL8N7oiGt+plOwhA1QS9n5rGHr7R5GaQYJaL016hO/yDjHv+6rF
         G0nI3CJN9i+FbewuPZiG+mwDI7C9uwrHd/eRG6bL3BUyB+zhMeLyEVu/zrhuqwDw0vSV
         k39FXl4jP70gKXhzUAnfH0wzo1Sq53QltbfeGY50zbvindrAuO9PaYWYgVjUNmBO53y0
         EmEkJDvi9G4jBE0a1c2f4bEAyRMcboFm875UM2dGGBdKRHfnJPTPljRzUUI7Wr3PYxB0
         b4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513658; x=1795118458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eYNgo2UVBenIRIwSD7tfpreyjCqu1yXJLp8IAWrk/4Y=;
        b=NYtHMVF9wjIx89YOeSwnt3GkjRLIgQfuzPmDf3fnYMRjIByA6QQY66sNM+dbpe3Kfw
         rMrq/jA6NNcJKhj/IoXuj4OHvTZSXcQU7X5Xju1AdLviiRhsxTZoJFYfLQIjp2xt/NqM
         9laTrntAEOePjE305lz98a7F3Rzu1N/kFwX14sbv0Rg+slI8XHWbqUTX1wj43t1xKUCT
         63iovZCtEWz7pryXee7XRm6n0MoyTNIkAJ2V/8xEK+5M38MAiS1SQu2x9PVQxovGRRzx
         iz2E00/rr4ZAJSWGS4QnZrTvwglnjPh9VzMVhM4BdTrrud+Jj5Z758TedKvd+Na5cjWQ
         maHA==
X-Gm-Message-State: APuU4Z8ZiKE0XrNAFARP571qISn26x+I4N/fVCyUkVrdAARIDY0qOTIl
	hHv9DNSdPv9FPCHbsYHFaiatkXYY2qWS3RsF3TCS/rfMME7dFu8mO3HTnraixNVd/Fm470YfwLv
	enPxgvJ0=
X-Gm-Gg: AYBFou3O50ch3kh0tpwrkwA0pRVJLVz/Uyg0wn6+wY4BTxBK2nyMwLIewr7SDOH6uzq
	zPSYNoL135z8I15EejineC3zUiqFxCcnHfyTAK8ksFoGdw6Iai81yKqsFrNUWp0DEFEHj+pFFQe
	M2biTXmTuAy/GXh477/wZBrfq/UTDmxwMUh1Gf1NuaIXnolfLJP/Jn1DZuaWA5EOnzv5YhxHiHx
	ypdQrXw0CRZ65KSOmf9AY+qC+15i81A36Zi3tBg1fNwfQH2zkhw1JPXveQRqzgyWrSPr30EzsA/
	eWfWxtP06fUNsk5QVXbquDzaFRiueefZjwvtGiaKlBGo4xVYrcgtoQTRqGM37NXObQF/iP4vqPw
	/viQTLYa1prcumaNmGAC3027/rukHz/u8aPC8V0oGdk+2SGAT9zubwSEdx3ZDVWPVK6hhYqjXo6
	mFItei1xgBryXq1WtU15bUU1jQf7junDKE0iwpf56poZO7wopplJbDN+NwQ60e1WXuY+YwvPYez
	JW03YB6NMD0MxEWAih31J+ke7w3saiZDUN5LgYG4Jo8Rb5QzNCf+7LIcBlr/0iQMZtW0YHg6yyY
	HshhKCzEhOCLatxyoklK42I6B/HkVc0re0REDym+RoShcz6wqawwoDDgrFiQqeA+ohz3tbiu
X-Received: by 2002:a17:90b:4c8f:b0:3ad:7f4d:2839 with SMTP id 98e67ed59e1d1-3b1b0b5c3cfmr90162a91.14.1794513658214;
        Thu, 12 Nov 2026 12:00:58 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm5967123a91.13.2026.11.12.12.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:00:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 10/11] ss: keep following events after ENOBUFS
Date: Thu, 12 Nov 2026 11:59:23 -0800
Message-ID: <20261112200046.2164391-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112200046.2164391-1-stephen@networkplumber.org>
References: <20261112200046.2164391-1-stephen@networkplumber.org>
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

ss -E exited when a burst of socket closes overflowed its receive
queue. Lost events are not fatal, so keep listening, as
rtnl_listen() does.

With -K the second socket, used only to send SOCK_DESTROY, also
joined the event groups and its queue filled up unread. Open it
without groups.

Reported-by: Anthropic OSS scanner (ANT-2026-39AYDLBX)
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 6d37f676..7c47d377 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -5099,14 +5099,19 @@ static int handle_follow_request(struct filter *f)
 	rth.local.nl_pid = 0;
 
 	if (f->kill) {
-		if (rtnl_open_byproto(&rth2, groups, NETLINK_SOCK_DIAG)) {
+		/* Only used to send SOCK_DESTROY, must not get the events */
+		if (rtnl_open_byproto(&rth2, 0, NETLINK_SOCK_DIAG)) {
 			rtnl_close(&rth);
 			return -1;
 		}
 		f->rth_for_killing = &rth2;
 	}
 
-	if (rtnl_dump_filter(&rth, generic_show_sock, f))
+	/* ENOBUFS means events were lost, keep listening */
+	do {
+		ret = rtnl_dump_filter(&rth, generic_show_sock, f);
+	} while (ret == -ENOBUFS);
+	if (ret)
 		ret = -1;
 
 	rtnl_close(&rth);
-- 
2.53.0

