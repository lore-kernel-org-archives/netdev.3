Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4783C3792
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790495316; cv=none; b=UIuZu5cRrxP86XlROTk943RhNTy/ikrrBs9zS4YWW6nWN91Hz1HXgEMl3Gk7GZICsTXoNUOeBEm3CIw82G7KKb5SgHJT7/928kfOBWD5YktGWAOM5V3vyPZWUTNG6vtEz9TvFRiDTy8g3TAtnpOzuZ3GA+FtIC4cPMCUiAsoork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790495316; c=relaxed/simple;
	bh=QlXZLc1ldzqTCA4Tjq0uFeQhHf0Ycrwc6JhSayp6bT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KryCtOViskB3JtknDT/MEYkuVI3B1u9GmbMxxxG/KHngVcAO14AQ1MJqKg+MHzfeor6xGxBmC+DTZBHDbe6pkC46vmuPn4sW0QjXTbWkQCpLwRUJ1VE9Gjtfs9myIu0cCcUMZyWNGIfqHh3DfrqgkLdMD4P50d4stL2vTrTsmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEzRZx3V; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEzRZx3V"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso23018695e9.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790495312; x=1791100112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jwf2/23SjrBtgOOR44N50l1FCtrYpbibyjJyaL6BnVU=;
        b=KEzRZx3V5tfbaV25DKNZww5KIX3Ixzf3CAazzP5EibHzeinAzc1NNrZ6AVJ1lgrOtj
         Kl3vvE2lEMQcUIkGTnjcnEHdAybNXL6gwuBOMBH13va9ghe82d1pUmaPhOzw0wgOEkg+
         PNtOFR3ywCuRtJ7TFZFHDJZffqPSujLBOTHI2OAyrhJRqYTWrkvEEv1VnUoNw4Zbbq+k
         nJqKfjAGvIfeyJX/wDOWYqoVqBdqf+Lrph65ttKlgg2iRWuLxL+EH0XIHu52xZQrBYbN
         fOp1FkGA5K+MfQlssZtus5tF8YahY/XmiN4ffjgKZ4RY2nhRrTHzCWlGO2btFM/NErdQ
         60Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790495312; x=1791100112;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jwf2/23SjrBtgOOR44N50l1FCtrYpbibyjJyaL6BnVU=;
        b=IwkAnXT0wnBO7gFMSh14hy/5Jac1Ai43o0tJf998fu0kJ/t1+9i/AFhNuZj3SA5/Vq
         buC+H6vPxpD99SkQgWvQBm1I1N6PpYI+uCHQ7tQ8lb2JXdFxsMXl4aeWX1wuSoaHT6oV
         xdC9tmv0j79siL0dhHpvPDqE1vSmo801pUY/p70+OBjMk5Lzi4kN8QvNzQLlnQL/pq18
         UU5P6uNth7XuohSARIuMrV2Ezzy3w85hYOmKbXt4HZlYWmUeM2ikIELiwKcQR7qilv/T
         Vh9cpuke24S7395tZgSFELLT5OEydzqTlRDgbUyTG01jJBJfNHbRYpQ/EtFn9Vvt16BR
         Jr+A==
X-Forwarded-Encrypted: i=1; AKwUvBz6IOJAWsAFnvOb82Vyb0iKZvWp8ljK1Bk0daIM7kv+0Cz/pP4p54Tz2AfvIekumE0wzd+CpvQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kNJKUaA8dd16ziPDwGskAzx+LalvPlM4oFwnHNHO2ppBZPfBmk
	c8srY+N1eTdmnf4uFmySPtxASrxya0KJ7U5lIVSTjkjOgPMEO4/nbK1geyJbOfrD260=
X-Gm-Gg: AYBFou2xS5u6ttNz3hQ6ocM9jQQW/lvqFX/rCcDQNtc1pKWPCnd62sOpcx5wlLn8tRs
	uFK+wTBGbNMm8MIGClBjWg5Z4yg3foSCcR4PwIjVGm2P9iolT/TlgDRbVTOE7UteAUVg7aC7Cf3
	MtzS6t0eNAXPOP9PmQW6Hbyy4oKc3+LuKGMBkVLhGACMTQfQID4hhHfzB+CuksanSv5YoN7S8PF
	Fd/gTmMxMT580uXSI6VCfLRVFSkMtlcooPLLm6txW9RFXcb1N41kxwJocESZ9YxNAk2RfkJ6tTa
	pI5mrX0NZfJaIVlBXISJr1WPR7OwG4bhL0SS37N1cLNJiWw3NlX8z9jVIniAsmLIHlNRUzVNU0C
	xSa2jlg/EreuhGrnJmpZE82NPKAc674ySzMuI3NydHWfFlvtLp/M1BhcibqL8bpuyFv4envEFzp
	4SZoeeF3KZ3Op+p81lFdPAF7izArAmQK5nz7P3BnPr+S2lj48J7uOLbuL/jaI=
X-Received: by 2002:a05:600c:a413:b0:49f:f21d:b504 with SMTP id 5b1f17b1804b1-49ff21db60bmr100062465e9.4.1790495312237;
        Sun, 27 Sep 2026 00:48:32 -0700 (PDT)
Received: from gmail.com ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0016fd7b8sm42561395e9.2.2026.09.27.00.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:48:31 -0700 (PDT)
Date: Sun, 27 Sep 2026 09:48:29 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: syzbot <syzbot+89001660f14fb7684c83@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [afs?] kernel BUG in
 rxrpc_destroy_all_connections (2)
Message-ID: <arjJwc6yl3RkOTRK@gmail.com>
References: <6a73d174.5aeeccc9.207e63.000c.GAE@google.com>
 <6ab29768.514bccd6.255447.001e.GAE@google.com>
 <6ab8c8cb.e548f532.1ca396.0037.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab8c8cb.e548f532.1ca396.0037.GAE@google.com>

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git a7bfaba4823e

---
 net/rxrpc/conn_event.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 611c790bc6d0..111f0844b0d6 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -272,8 +272,19 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 	bool secured = false;
 	int ret;

-	if (conn->state == RXRPC_CONN_ABORTED)
+	if (conn->state == RXRPC_CONN_ABORTED) {
+		/* A CHALLENGE packet queued for processing carries a ref on the
+		 * connection (see rxrpc_post_challenge()).  That ref has to be
+		 * dropped here because the caller frees the skb as soon as we
+		 * return.
+		 */
+		if (sp->hdr.type == RXRPC_PACKET_TYPE_CHALLENGE &&
+		    sp->chall.conn) {
+			rxrpc_put_connection(conn, rxrpc_conn_put_challenge_input);
+			sp->chall.conn = NULL;
+		}
 		return -ECONNABORTED;
+	}

 	_enter("{%d},{%u,%%%u},", conn->debug_id, sp->hdr.type, sp->hdr.serial);

--
2.55.0
