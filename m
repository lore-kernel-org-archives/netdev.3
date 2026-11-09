Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221581;
	b=fivtLhtKYKNswWvJgRGcR7ADm2jb/vOM0Lip8VhKYHeJCQsLXaQ/SfTIG7ZiBwKYBXQY
	 pHZHvz8VpfPop26fvYgz6ZSOtR1Yk1hNwziuK59yCxiCynGfwxaGLrnZvMW54Hc4KX9oW
	 DJkOqhbUhnH/tbXOkMCN8dmtGeBTEOwGyr2CoQbpf6034lJwz1gyIfjo/NgLSj4LlLZ6J
	 v3qyGqsMmac4jixwQeUdoKq09fYPR64bGSWbVpV19FhrLFWI8uj4Elu3pW+Izt6QUAxek
	 QYb66sJFOXGYh0n9Ff4QWex1yWpWgcGNA/VbkooKTF9792+tD2A+q2m3+BCY2hGopiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P/abH821CfjTbteejdVkVCp6wEUnORlLvnsQVPFmNfs=;
	b=0Y50Fj374/uqy/dR465iVxFzdFTUzL6NkIn4COJ+6m8H8jepQFanIBeb3rgK4mpPXlOV
	 4qGCUK5IJJ+CI8JP/x/ALmp8waKTP/UzBAgECSfecVgLuBT5k7pFB0eTxFStF6VI8Bni8
	 d1GFSnNQF6MKaOfDer6GJYdTySd4HV8jZoLVylzcyn2cq1l6/6ozFEmK/yWCAU1fTvEzK
	 dK3R/8gRnyp2wguS4sX/WejY0Ov2CBIvUcG7D00xGSiF1raVQpaI0I9tqP0ex6x/G1tuF
	 83ivmq2VvRPYoMa9qe5flaEBtcXl7AcQGKMF3xvfhuii6y5rp8tmqHnF8BPOpXpMtgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=StIPfKYY;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7504606A325
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 10:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7504606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=StIPfKYY
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b3acec6677so839913c88.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 02:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221580; x=1794826380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P/abH821CfjTbteejdVkVCp6wEUnORlLvnsQVPFmNfs=;
        b=StIPfKYY0Pf7oESixa8VrpAIMTjIbazHOQ8STdsjPvFKdOol/sVnmE+8+sSvl//8IU
         Se0fKXdvw3HY5rm2+78JchT8kHvhE3ovYvbj9y2vzUHs2Dfl2A9QTJ95K+ADpQcFaH9P
         1c6or5xnNkY/p65dius0nEop+n72ywszZEYESyDcFUgo7dPovFT3ZplKeT9k63pxpgJp
         BkIxFXywA4FeI3pdXUZR3dCW142SykEQUw3Tr/76Ebqshbv1JEKpWZ5psqO1Nj8n+XtB
         GOQjRBXU4nT+7TgJEUUOC0Z+qh7qF5qyU3pqROke5ugJa/5pM/9dWvFLi6NhGSPcEonk
         0jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221580; x=1794826380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P/abH821CfjTbteejdVkVCp6wEUnORlLvnsQVPFmNfs=;
        b=N1COiY8YEUSiCAMMdxjfcVj1PcRgVoA7TjfeBfJ1ylDnnqtW3JlvkC+FRzJz32utgF
         9nDh5j4u+GmMMFitG3Cvb1YNJj/DCDctfNt7H+C0qM4KIeFf10t46ts6apLlonaxlCXF
         /rCNydtBOjSEvPEswSqC/tGJHi+HcYcHAG5/EnSJjJi9f6L5ctgZ/RXup55Jrzzh4sYC
         qzNJyJ01o59u9uBfHVcAclQ0iHwtyVpCRCgmaUmZqiWvUSYvyH4Sfgg6yYF3Mvupc36e
         TtibplPAqMuHE1QhP+auvkiBQyNGlher2O9uvjZCqAnFNQTwVXmegBcjuR+4PoYQbEen
         u2IQ==
X-Forwarded-Encrypted: i=1; AL+hErFea4I79UyAfr49x48zPm8MUA2P2olmNlE6T7RTrC7S3I+s9ybeQ6J/zemlC0N6XnrEPv2BwbI=@vger.kernel.org
X-Gm-Message-State: APuU4Z955uO5iX8ifWM6Qjc8pH1OW29aHk4/dDDe6ZcJk6YdgC5yJ8qo
	jzobrPRi25lyx27I7TcT7tdPzkG8RRX+z69Oh/MhlAKhgDTWjSpwaeal37eixUyU+Q==
X-Gm-Gg: AYBFou32ljRoBTzGo9J/zMalqox9pJ5kNTTZzMBuAl32+gV86hIdzvU/vSF/j5eWqKi
	G8Uh/KxehASLB+JegBSKeou8XzGs6BRL6nNWtKngKh/P8WKW8sSjhflnkYQlUt0a6Q1H44yQdNm
	MI+QsDjS170KG5+03/SxklheJnjX7BfCGxo2DrtrQeg2eSxE7PLgmo70mrCmddIu+ZHi43n/PPz
	SyD+Ezi9/JEtV+U6vOcccL54JzwtKYx8bSMMva+1/xGaI5HQvoXwl3kJBt8wyHhkCOg16ewkmwG
	FUTThfccx5nwr8btgKo0cLeu1uvDflS06qKnOcQZvWJX6TvlW/JxK3pVfBT2JLEDg0Cc7LyIPAv
	dju3V0Yy3pev9ckiTG0M6YO/D+EVCX3FzNP3XVGxfZ5EBuWBbm4VMUAICaUYWh0ke+sPJ0Dii6Y
	wL0GK864Fzd39X9bOcmPaHebgCC51u+un5HOw2AaZgeYD9xQfuNvZFFi0VY8SKjj+nTzp06TZqP
	g8NLLE/LQpfu/vOy4EEJPWmn1wR+cGX77Qb5RLkkBZI0Z1AZ6xoSXeBkXTNPJwbl3y4JFAlG/ln
	sIOJNXh+/azh1sJIIkq3P3XckI1WVGAwjXjE1w==
X-Received: by 2002:a05:7022:4588:b0:144:fb42:52 with SMTP id a92af1059eb24-1b39feb42f0mr8095312c88.28.1794221579708;
        Mon, 09 Nov 2026 02:52:59 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:52:59 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	Chirantan Ekbote <chirantan@chromium.org>,
	Greg Kurz <groug@kaod.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] 9p/virtio: clamp the reply size of a zero-copy request
Date: Mon,  9 Nov 2026 19:52:47 +0900
Message-ID: <20261109105251.2545764-2-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
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

req_done() takes the used length from the device as the reply size
without checking it against the posted buffers, and p9_check_errors()
skips its size check for zero-copy requests, so reading an oversized
error reply to a zero-copy request can overrun the posted buffers:

  BUG: KASAN: slab-out-of-bounds in handle_rerror+0x144/0x230
  Read of size 8 at addr ffff888003065768 by task zc9p/157
  Call Trace:
   handle_rerror+0x144/0x230
   p9_virtio_zc_request+0xb8e/0xd70
   p9_client_zc_rpc+0x21c/0x970
   p9_client_read_once+0x237/0x6c0
  The buggy address is located 0 bytes to the right of
   allocated 8-byte region [ffff888003065760, ffff888003065768)

Also, handle_rerror() returns before truncating the reply size of a
zero-copy TWRITE, which posts no reply pages, so p9_check_errors() can
parse the error string of an oversized error reply past the end of
rc.sdata.

Fix this by clamping the reply size to the posted buffers upon getting
the reply.

This patch is assisted by Claude Opus 5.5.

Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Closes: https://lore.kernel.org/all/20260607140603.24342-1-zhaoyz24@mails.tsinghua.edu.cn/
Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Fixes: f615625a44c4 ("9p: handling Rerror without copy_from_iter_full()")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 net/9p/trans_virtio.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 9fa63e3ebf673..53046668c16b1 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -537,10 +537,14 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	 * threads - echoes to wmb() in the callback
 	 */
 	smp_rmb();
-	// RERROR needs reply (== error string) in static data
-	if (READ_ONCE(req->status) == REQ_STATUS_RCVD &&
-	    unlikely(req->rc.sdata[4] == P9_RERROR))
-		handle_rerror(req, in_hdr_len, offs, in_pages);
+	if (READ_ONCE(req->status) == REQ_STATUS_RCVD) {
+		// The device may report more than the buffers we posted
+		req->rc.size = umin(req->rc.size, in_hdr_len + inlen);
+
+		// RERROR needs reply (== error string) in static data
+		if (unlikely(req->rc.sdata[4] == P9_RERROR))
+			handle_rerror(req, in_hdr_len, offs, in_pages);
+	}
 
 	/*
 	 * Non kernel buffers are pinned, unpin them
-- 
2.56.0

