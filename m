Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854969;
	b=uChE/2ceOwQkNRe8L3pCp/vDO2O389gR+lin989nMa7Y0sSsKaf7CMa0CraUFcKdYkcz
	 za9maxbgEp37E+BiY/8VjvDTk1lBYnPEaGlnhdKGUQeD05uvW+6V1OZ+/F2tt25DrQpoB
	 gm2ibygD+5kjOGDlw/oWBm/ecrRRefzxsIQPHEiuxsCERpke/cvvJoLZgIOoxNNX2hA72
	 6gmP06QXmkVjEcEJ2FSJjC5iH+6TL34CUo9W9FoMVS6GIOj5CUvh5Nhw+T0JU8gtbHA0i
	 5QLoiQ00z3bGzUrWODESMzU+XnZmooknsueX30WL+g9hKUFaVvJO6fzMprYIxMLv+/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZvR6TskZdWW0qqXirA6k1L3BiqLi1sfGsfq7tJ5wLss=;
	b=EUtaxfMOMqFCAj3lvBiQlBDZFD4Hk8xj9ZKGQ0SkaKOy0HnP1Y8wie1BvC2sEd4V1ht/
	 F2hQW3af3GxmI+TmzSJXcXXHSUjFzwb0bD2JqaWA94Ic1yWtgWo4gitTFVD5JJiuRmGg4
	 q4IeeAALAZFfOWdUKqWZl7G9EGEfn9sYUYcic/l0mu/Ru7mb3EFLM4syFzQnK7RrvV6dj
	 IX10MHSBEcEA3JMzZa24zqki4+xB7ijLMds60Ffk9tvs1eJaLLY7N9Z+xyEYVOpEOXQgr
	 xtPmMSS7ToO3mqBkQ1yNw/et04NFiVRft3cLIALDYqYvjrNSExmafYzZrCqEpXiYozQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iVqH7DZb;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B97606D807
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 05:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86B97606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iVqH7DZb
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-15dd124bbe7so601371c88.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 21:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793854969; x=1794459769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvR6TskZdWW0qqXirA6k1L3BiqLi1sfGsfq7tJ5wLss=;
        b=iVqH7DZbiXYw9I1iVCOjZ4e9C4Zj9/4MJHBezBN7pD87q4SvUWBwXrtJ0712sceVUR
         gTEj9SaTAXSRg78VMKO4rSzGIfEO2ZIsAhKT9Lqersq8HIbzx2VfuBENhnYee6LUWo89
         Mzg5IVoS2EbjHSPJYEnrLr9ysmuj3LZBkFFEv/iw8HhzS/ss0woub3STdsy4wtFVaEr/
         CfPkxVsI2GMqdOmgw2y+ixrXPdzoeBktMtV9flcUiuk3csIXxTkESHrHRxV6RwZj7Ajk
         ff97Mr2c5lUhf8VKXAZY/9FUMhbt4fdBemrTWsuvFmY2Ok75cUH62NKj0dfX8ogFPceX
         3dWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854969; x=1794459769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZvR6TskZdWW0qqXirA6k1L3BiqLi1sfGsfq7tJ5wLss=;
        b=2j6O13M11QiJebkt4MseCbpJUNor5LpDnlWqgHvtkF8r+zKI6wlxqYe5+JN3FlIKRd
         rGQCWEwsRac+jl5huMWKjIhM2RT9sQMx2bE4WANCXqs0i6KrNNcQiC11qQBg9j4qDhGM
         3bQinRIlNZ+wkrYYhlbQJMVRMFK99S87sCTF1YR4uyJAFkxvbpIT7xE2YEH4ZFid+mnT
         o0S7Qhmr4N8IsBJqoH9ZFZnaA7RSf2G5WbJZjzCLkdJqq9Xw4FxPv3mAiGc8Vyd0btBu
         HuNEVMK/nXGyAq0bi93MEPX/AAOo5g3Rl9bLKzk0rdFU6dkIzl5yx22Br0+mcR7+sS8t
         T7jw==
X-Gm-Message-State: APuU4Z9rBV+3jfKQNVmjllg5r5eiSNmcn8/cO3niyVLTH1zQb1XBJ3uR
	/VKklkDryJOTthhctuIKjuA+M0/A7f8IuMpxTcDIHSPjt80MJKqXSP2HIPF8Om9B3aY=
X-Gm-Gg: AYBFou1ykrfuSRVrhmtOBZwY34GeFJXfIjgdMNC8IQRP1y0MVvjccBhNbBhMB6iefI6
	WClUdtUrjUAbdsD0Pg6gr1BvUvvnYxZqcjWU7X7F3G5b+/Yi7vaV2Iw7J6mlJ0cXYmz0lKlu4SR
	6Yc/VLuDjzv3V9nWn/w8cSS9XnQlKT/5Q3Odo7sg3VLfHt9FkN387GxHTRzNuYJtaapjt1ZQzha
	w/pc8LX4VLRiVU309fORWhQAgGkcCttwMSarr6GZOZ7NTkcdCY547yVGI3KnvNNGd/+1s1eRvZA
	+VFBPyHa11PUxtTnRFchRGitCDOZNThr5kNr+p3cH2xv/grtceb5NNqoTUKhzgjD0lWS4N4EOb2
	ivEfkC9mZnJweUkZau9qEWsQmFqRW5lBoMW24kJh2H0f9AaRXZS7wRWvGZsT+l0wwVFUweofwrC
	TSWVEaVh4kxvdJfnsi1VwOyrrTmvdi2+oi7pSd9L1exfvelVGN7M3S1170ZV57dO/SY6vlW46pS
	sRB2qO/vYCOaR/6Jm3eX7PVu1y/FINf2VYUkxc4AsjQM1p7gCJHTg4OFa4FQE0REu8ObJMsEmVA
	6MAPxvlcwXTR8S84hdIJrCgbZp2RZiQX9UfyaTcI9h6/8D0ZqdzUogL6mQjwLG+tMlQ7DP94rHY
	=
X-Received: by 2002:a05:7022:29c:20b0:15a:9834:73f2 with SMTP id a92af1059eb24-1ac5c5554eemr25709808c88.38.1793854968501;
        Wed, 04 Nov 2026 21:02:48 -0800 (PST)
Received: from localhost.localdomain ([136.25.42.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c283sm13626735c88.4.2026.11.04.21.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:02:47 -0800 (PST)
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
Subject: [PATCH net v2 1/4] sctp: abort unordered partial delivery when its message is skipped
Date: Wed,  4 Nov 2026 21:02:22 -0800
Message-Id: <20261105050225.49292-2-tim.budding@gmail.com>
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

When an I-FORWARD-TSN skips unordered messages on a stream,
sctp_intl_skip() only aborts the stream's unordered partial delivery if
the MID being delivered is lower than the skipped MID. If the skipped
message is the one being partially delivered, partial delivery stays in
progress: no PARTIAL_DELIVERY_ABORTED is sent, and the next unordered
message on the stream is delivered as the rest of the abandoned one.

Abort the partial delivery when the MID being delivered is at or below
the skipped MID, as the ordered case already does.

Reproduced on an unmodified kernel with the uo_pd test of the
sctp_ifwdtsn.sh selftest added later in this series; its partial
delivery checks pass with this fix. Reproduction and fix done with AI
assistance.

Fixes: de60fe910543 ("sctp: implement handle_ftsn for sctp_stream_interleave")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Budding <tim.budding@gmail.com>
---
 net/sctp/stream_interleave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/stream_interleave.c b/net/sctp/stream_interleave.c
index 840f24045ae2..869940001588 100644
--- a/net/sctp/stream_interleave.c
+++ b/net/sctp/stream_interleave.c
@@ -1255,7 +1255,7 @@ static void sctp_intl_skip(struct sctp_ulpq *ulpq, __u16 sid, __u32 mid,
 	struct sctp_stream *stream  = &ulpq->asoc->stream;
 
 	if (flags & SCTP_FTSN_U_BIT) {
-		if (sin->pd_mode_uo && MID_lt(sin->mid_uo, mid)) {
+		if (sin->pd_mode_uo && !MID_lt(mid, sin->mid_uo)) {
 			sin->pd_mode_uo = 0;
 			sctp_intl_stream_abort_pd(ulpq, sid, mid, 0x1,
 						  GFP_ATOMIC);
-- 
2.34.1

