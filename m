Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792843627;
	b=SCz1F8/ewlyT4o2qwoUqDXJhT8vEUpFnnGR/mYObddPENtrDr2r7yMPBu2xwEf6azDdk
	 nN/k/udm+8jeKrQuMXbnFaEu4OQVxPQ40oCKXGM0UDpVDgGIydOGgek2NlNJ1xLieKIFR
	 E45z7mlDqdj/IH+PBDgTjYR+6cF8t6b8+fRFZYXVy4ZraWQ6s6a+slV3KuB9QgkU6Zpp2
	 56sAdo9Vy+A3TsvOBOW41COQk/b56ldrscCtRVAMo0YzEGzA+MSzh1wm/p+FsNj1q5+ju
	 TZbe4xIJg/dpSoa2iL/2kXiMXUn8M6pSpRqXbc9dm8VHBB7xoZCv0u0q72c3Tiw6RlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792843627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=os4tDb6Xj+U686/n75PMKZ7wN38a+tP5+DzCKnGGcL4=;
	b=r/pxvtpnxbenbbZnF2l1yOGwJltig47l22eZYtBWDUq8M0eqPpm0LgjNcgjn/MzQNOGe
	 zoCwwZKZvKMG6CfMv3dK51LYi0imHf1rDShMh4/5b0AcS8xfhz6TDSn11Eal7k0vKOt/P
	 Am0tvWKLOuY3KashIY/8vBUJ87815sTR9v89voBQP8qaTNcOHMRx76tIj8X5C08KxZvs8
	 QNrfV641LRnZkT1TjXXc06PRYm+S6K3WcjuECu3IERrn1yytWC8tbV8DRVXVkAVu22rPC
	 tf3ujUuVqpCVdnRQJRoGvFTLD4G1GNHXAhH6p98fz3pdExSjvfqmyWAEwMjE0tAZY8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XSY6OdDC;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06138606A32E
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 12:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06138606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XSY6OdDC
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3798000eec.0
        for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792843626; x=1793448426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=os4tDb6Xj+U686/n75PMKZ7wN38a+tP5+DzCKnGGcL4=;
        b=XSY6OdDCSUlPOYv4PuPcxjInaUc3nzXMpvI8UYrp5Z4UXpyCr2KHLZRhqqkK3mbiGT
         EYi249un6JB5e4nmMahZ5NCubG4heReC1qXTKlOuJOZHZL8X2AnA56Qe1YVookEARxLG
         hfzgK1l9BzyWOBdfd21r/jlfhADCh1UJf2DzZAYn25t2pDyqrCVH6DxBLpST4JiGoks7
         RHs2HhOc5DFabGn05StfUXP7GRnO2A6nkhLjnjhzHLjcbOwJn6g3Rf3tchbuQ9ZNzVpr
         mIMJ5yCf3dpPOLs7SB4kWN4FCaqw0hiIlb14dGvdW7SPlHb9Jyp38OOazErINnS8VeAx
         MD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792843626; x=1793448426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=os4tDb6Xj+U686/n75PMKZ7wN38a+tP5+DzCKnGGcL4=;
        b=1s4YZxJvhFK+HtlpSmfIaCZ6PC4LTE9LHg1HsKXy+EQUbnlzvR9r3wFzn9b9F2gVtb
         Ox2qWmtPj70TSt7sP3kM8xqyTcCYlXFCv8ngmpiOXefCJoM4BCO9el3kJ7JHNyOSSk3B
         PMIhcRpPFirHagIFf+D1pYOW225TCQkGFjZCeYE05/Z+MWbN7gFkLzDB1HCaF2O49W6g
         b+Dc3AJts5fGZhNsX6uKS6W1hOCQfT5D+ZphVkpKf/3ePF5Gna6U5YxyUat+IvHeNdfL
         OckcRzp2fQlRXa/A7Yt1aD7halFnCrcFUATh9VYN+4tpa8RyX9nENbEi6VA8+pECgEfT
         kkHg==
X-Gm-Message-State: AFq9FYIgbNwaLkldWpqoMWdUVzv3lk+EYXHy6XQvVlMYuYtpZO2BIT/T
	XU6L85092/zvKKz3l/GGlOTvQZNw+l7YG2+2dX1q5tEgDYw2iXNyUDDIk2Pv8x4cKuY=
X-Gm-Gg: AYBFou32x9cPOumf2ARg/lBFdOUgPXV5QX/Xuy/aPHFTTFugHyBNNh6k+d2T03M/oFO
	Tnz65YIHt/Y1lhMAbJw4Q/9NkAxxLesg8ZlbRoSYpsoV4hoRbuO2NOwxeDQJmUUltirwN0FcxnK
	VKEK/s8Z3QUWfcdX4YaG6KF4CjG8nAKxpYp0p8x8rMgjoZEAQPC8uOs2LuKUoeNSXCaPBJxXoJt
	OFFifhpska/mJCOeZ+FtdjILKxftarPI1JYIBEyrKgaKp48QbLHWrrKnm2rNKMm+QZYLkqiG0Z7
	sBkaD/KAxqBWqm8LNAeojSxzPoSGdhpz7QeDNFjRendOZqpVKFvU0rv1Wqaoebv2H82w++9D7OA
	SCYhWwqaXumczYLkHaH7lgNluo1vMSu0E8ad1V9SjtOOenliKxeYtAnLjqAlU/zuySHfRDu8RjQ
	biLnVGN7lS0bHDfEkxFWD+RWGhmeyF3bjJ63DANHc3s9N+AnSberm9iDSB+XVBILJtS3yXMULTp
	/R3LVj5tJGOeymGoUU1AOjsa+ELFJLJqGyNZXnPgVVlAwYUzxXcadbIPNU9ZxTIzO8xQiG5idCw
	bhcaHzXvrEdnjzTIY1yDyurqyg==
X-Received: by 2002:a05:693c:41c3:10b0:369:efd5:9cad with SMTP id 5a478bee46e88-369efd59d94mr691961eec.8.1792843626034;
        Sat, 24 Oct 2026 05:07:06 -0700 (PDT)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d95e91sm8120722eec.15.2026.10.24.05.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:07:05 -0700 (PDT)
From: Tim Budding <tim.budding@gmail.com>
To: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tim Budding <tim.budding@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/4] sctp: abort unordered partial delivery when its message is skipped
Date: Sat, 24 Oct 2026 05:06:25 -0700
Message-Id: <20261024120627.837568-3-tim.budding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261024120627.837568-1-tim.budding@gmail.com>
References: <20261024120627.837568-1-tim.budding@gmail.com>
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

When an I-FORWARD-TSN skips unordered messages on a stream,
sctp_intl_skip() aborts the stream's unordered partial delivery only if
the MID being delivered is lower than the skipped MID. If the skipped
message is the one being partially delivered, partial delivery is left
in progress: the application never gets SCTP_PARTIAL_DELIVERY_ABORTED,
and the next unordered message on that stream is delivered with MSG_EOR
as if it were the rest of the abandoned message, so the application
sees the two messages merged into one. Until a later unordered message
on that stream is abandoned, no other unordered partial delivery can
start there either.

Abort the partial delivery when the MID being delivered is at or below
the skipped MID, as the ordered case already does.

Found by an AI assistant while working on the previous patch. Reproduced
on an unmodified kernel with the uo_pd test of the sctp_ifwdtsn.sh
selftest added later in this series, which passes with this fix.

Fixes: de60fe910543 ("sctp: implement handle_ftsn for sctp_stream_interleave")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Budding <tim.budding@gmail.com>
---
 net/sctp/stream_interleave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/stream_interleave.c b/net/sctp/stream_interleave.c
index f8c818a5533c..77fe0db5ff77 100644
--- a/net/sctp/stream_interleave.c
+++ b/net/sctp/stream_interleave.c
@@ -1246,7 +1246,7 @@ static void sctp_intl_skip(struct sctp_ulpq *ulpq, __u16 sid, __u32 mid,
 	struct sctp_stream *stream  = &ulpq->asoc->stream;
 
 	if (flags & SCTP_FTSN_U_BIT) {
-		if (sin->pd_mode_uo && MID_lt(sin->mid_uo, mid)) {
+		if (sin->pd_mode_uo && !MID_lt(mid, sin->mid_uo)) {
 			sin->pd_mode_uo = 0;
 			sctp_intl_stream_abort_pd(ulpq, sid, mid, 0x1,
 						  GFP_ATOMIC);
-- 
2.34.1

