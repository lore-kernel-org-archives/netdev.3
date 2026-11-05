Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854972;
	b=MseUFHNPAuG3XrcDXHEctbdWpoZoz+eZyUtQKNKVHyZwXabytBcNusQH7cdMM5bK3Vte
	 UsJZBIHDObndJPWWApXClFpr3poh2+CC0qAZU1ncXBZZQkYIKQ5bCwE8MJonnK47ehuoP
	 QIdkpcM8Q1ZueCJvbLVy0TdrE+soDiSGwMYnTUsAfKr3gvJMkCMsi5LNlhMEZ9XOAEq0H
	 qoWJ+wBEDXkphl6TVxiasnyxbrPMFQliOI89f5jQZQiqQk73QXa3pbIMXvzzXUSLWEl1t
	 s0iwof0IgVM40IWUftpZs6gd7AubiabyKq3DnXI/3LEVErXAISCyf9dhexGw1tg6LDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JrA96iHSEppxQ2hp+sSJL/g5LPKU9LnKIC8wGzFqNw8=;
	b=2eALAacjZx63KZ858mZwyu7o81uSzQxX1+ZLnyhwQ2EooFaqPTtGnqIT/XoqTsBtkbCz
	 hv3WEI+E4QC8Eo03RxzGw2S1kVSurFNzNtPKWunlc0jv4jkHmUaGfnuj5RQ9Gz+CJTYi6
	 EVcK/gU5fLeQIh8QPkY/qh9qGbPt577fTVkbfPIXEC1gaifNAeL/A6bgmBwLdp2Gxl2wt
	 32sbirSqT6F8nClV7cO7ps2BDK1IcISiq2tynhK62CCicatcKAYiCEYTcsXSzTwLZrgAQ
	 V0lyBr7/PvevtEbF5SbJ9Blqjg9IcKPgnb+63DWO3O7QItpZjhvYxlGpdAlwyT2hvnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VxNtRLI3;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB94E606D822
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 05:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB94E606D822
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VxNtRLI3
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so1688757c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 21:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793854971; x=1794459771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JrA96iHSEppxQ2hp+sSJL/g5LPKU9LnKIC8wGzFqNw8=;
        b=VxNtRLI3j9T/8JzZeBa7Vg/9x3/kswBzW6MPGKAqaXfVyJ3lITbV4/VITEAICjFfMf
         eMk2B5AHjHt7knwLMB+T5Dshpo8fW5iugQoOKGXGvPz3mr5TGAdRRLcJWqL3TK8DyxDq
         cnBt51+U0LBmPPBvJyvPOSnvB5X6rTiDbKxi4szD6gQ51Oksxy/4Bf9/dg7xdWFE5xal
         ezJPO7Yz6vgEQ03dSP9ltynu3OCWaAeHuPGbVFyqCwv9sIQRTT5BErN8iBOywapHneTH
         3W9KbNFG6O4UgwRN8R5O6iyiVcff28vJEYPlqlQ4lLwQII/aIh2g+A8eGVJPWgXFSnUN
         Tt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854971; x=1794459771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JrA96iHSEppxQ2hp+sSJL/g5LPKU9LnKIC8wGzFqNw8=;
        b=b0urMWFXlDnam+NROvP2QFdqzR9lcWxnDtqpHzXHYR4UZGBoG+SkZhexVRZFGO/c9b
         7Gqi0S8JvVhXXdKsLqURcQN/OC38Wtyfqskr+ZZT8Xo2okkzdG2SKgLKql6Xwd+MzbG8
         NL6fWyShhwINx+LpVxvtLNZk9x55j6APvXUPvG/u0mgAKZV5kF1UWs7rYHgC/sS9jG7A
         boE1DE3fnPMkNmjZUUBDFIDMFL4aizD3j5XmLP11o2s0OeKEl5yDRUTsJYtOEplNmadL
         5YpH2/RRFg9Oem07daXKRA2p9XHLIPoEOnnWcfWvUJkk3pp8DlUNsUl6Uu2GTUYDebko
         xtwA==
X-Gm-Message-State: APuU4Z+p8vrGUBa0I1bytm8Bte+6Iu+lZcYlEh7ZMkowo4ce6rXNa0q8
	9+uKkf3yzFVi0do4r1B5dKgBw0/XpgorxCQqhOd3trAXQEowGPkljTBUOMf5nHec9nc=
X-Gm-Gg: AYBFou2YvzxbXMQ4X7qMLb6KuaHJJ+wH9hIqdHhBiZ5zVAzEGxwood3gj+v6WCA11PO
	BKCIY64l3H76oku6Kydon/67ARJ4RTmnk5+hcPlirNxRttKAwGzo6/UoM2/r3SKRtmI+RlQaOxf
	oVEKMLNA0ZIH56SP65aK9NY1XavShBL+DH3pmgBUSP3/iV2i3iYygxQa50kwm6JMze4akqAZX7S
	gM9Cfa5PkpRLjy3IE0xhEI/1mapGNNSro6yJqlvcHuQVqcfZYYFZtEeKE06csqF6Rflw2g97GTt
	rG9z2wLCLbw7MW9Epw8HSs56h71mGXXZ6XZ4X4FD0nWcw8brt4KXTACCyWh1qqVwxFnmGhCrw+K
	9dtBaoOC00Qff/tu95qG9DKzZKEEdhXA2phv0CLzIWI653FBgKt9AYg0RR9Ckml5ezGQm2pl0f3
	OsKuUDjP7dVz3XHmOxmM3FTNU8XAbyPln6Acio1AdjfoLi12M2S+omuNoDaz80IpdOH6+nWPmBP
	tuOOMW24kO85v8JeR/Ni4dIjPIJ+0q0vUER8Ei2aIEYML690lk4Z+/Amr/eVwcGBlfKwgvdXP7V
	mkZbzNTqpR6IDJrq7pZiLK40O6GODWZUuZwdz6WFGCNIEMANVV4F2fBVH76z8iHbDKTIdjuABQE
	=
X-Received: by 2002:a05:701b:2816:b0:182:94d7:f76a with SMTP id a92af1059eb24-1ac6088a34bmr25504978c88.43.1793854970493;
        Wed, 04 Nov 2026 21:02:50 -0800 (PST)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c283sm13626735c88.4.2026.11.04.21.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:02:50 -0800 (PST)
From: Tim Budding <tim.budding@gmail.com>
To: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Budding <tim.budding@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 2/4] sctp: report the partially delivered MID in PARTIAL_DELIVERY_ABORTED
Date: Wed,  4 Nov 2026 21:02:23 -0800
Message-Id: <20261105050225.49292-3-tim.budding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105050225.49292-1-tim.budding@gmail.com>
References: <20261105050225.49292-1-tim.budding@gmail.com>
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

When an I-FORWARD-TSN skips the message being partially delivered on a
stream, sctp_intl_skip() passes the MID from the I-FORWARD-TSN to the
PARTIAL_DELIVERY_ABORTED notification as pdapi_seq. That MID is the
highest one skipped on the stream, so when more than one message is
skipped, the notification names a later message instead of the one
whose partial delivery was aborted.

Report the MID being partially delivered, sin->mid_uo or sin->mid,
instead.

Reproduced on an unmodified kernel with the pdapi and pdapi_uo tests of
the sctp_ifwdtsn.sh selftest added later in this series, which pass
with this fix. Reproduction and fix done with AI assistance.

Fixes: de60fe910543 ("sctp: implement handle_ftsn for sctp_stream_interleave")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/179293012867.3134.16497481637722705271@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Tim Budding <tim.budding@gmail.com>
---
 net/sctp/stream_interleave.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sctp/stream_interleave.c b/net/sctp/stream_interleave.c
index 869940001588..e239da686f68 100644
--- a/net/sctp/stream_interleave.c
+++ b/net/sctp/stream_interleave.c
@@ -1257,7 +1257,7 @@ static void sctp_intl_skip(struct sctp_ulpq *ulpq, __u16 sid, __u32 mid,
 	if (flags & SCTP_FTSN_U_BIT) {
 		if (sin->pd_mode_uo && !MID_lt(mid, sin->mid_uo)) {
 			sin->pd_mode_uo = 0;
-			sctp_intl_stream_abort_pd(ulpq, sid, mid, 0x1,
+			sctp_intl_stream_abort_pd(ulpq, sid, sin->mid_uo, 0x1,
 						  GFP_ATOMIC);
 		}
 		return;
@@ -1268,7 +1268,7 @@ static void sctp_intl_skip(struct sctp_ulpq *ulpq, __u16 sid, __u32 mid,
 
 	if (sin->pd_mode) {
 		sin->pd_mode = 0;
-		sctp_intl_stream_abort_pd(ulpq, sid, mid, 0x0, GFP_ATOMIC);
+		sctp_intl_stream_abort_pd(ulpq, sid, sin->mid, 0x0, GFP_ATOMIC);
 	}
 
 	sctp_mid_skip(stream, in, sid, mid);
-- 
2.34.1

