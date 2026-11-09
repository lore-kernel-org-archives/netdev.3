Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221584;
	b=io/VwfyTkEaPRqHN6tJIwY1G3521NeKkFFzwc4/MgEc3fAW8R1QZ+smrfS5w+2wANosH
	 XxD0VAQ4SMXW4ZI7kMwXClPKlEYeawUbTb5Dh1kqyJ2u/cP9zZeD5Qz2fR4xdshdNW2Q4
	 xlrpkEiiSZbUkR+Lm3Za22X7yfJVuoYoDJ4nBQxtGAMwIV6c7MzmqaY4R0mNouhG6rmFX
	 MKSaWaXCxemnAjN3/XCU1oXfyV4PpoutNyYA1VPLNtWokSALS0xM+pDSVbrEw9qiG3xLH
	 dFZ2t56ptOn222Z/RoNdhnG6+f4wgJig4lpMpMSN1OLce2SNfbQGiVqniRJU1z1UEMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7gQkAftGc6feY9izPoJt+dP0xjoWhSwyQPi0WVN939U=;
	b=sKcfLhS5weASWM5OvlVjKpQCQ7c6cNvJRmLWodtAh7GFvBR3xDcBejHHGOadGxMEUJr9
	 ybCNCqFg3tv2dE0DPQp/HklagTNn7og2lWV/v9gQyhhBi83hBWsBlJQL5XNM4KOAm6oH2
	 VNjHGHYbQnsH8EioHNfmWr8pqVzeRWmI7tufq4C8JaiIyyRpzmjC+5ojBCS2aOM8JuVRv
	 yIexYVkVSX5D38qDH5QaOPDZzqZyrjl1fp7wEda3VM4+kU4d+uhd7VKXOl+pDJG+9fAgd
	 5DfOl0TsC/JkfvztxAFWadtpU5i8ROvlI0/4A45Lj1600h8Gx9lD+sLLvFRP0M431UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=iuwFimSr;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE37606A323
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 10:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECE37606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=iuwFimSr
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso388398eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 02:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221583; x=1794826383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7gQkAftGc6feY9izPoJt+dP0xjoWhSwyQPi0WVN939U=;
        b=iuwFimSrqv9XlDbzpW1iOYqtZawE7Uk8u6Mmd5lCyb4oscwXFUkWIxbvE8TtA+B/9S
         ZL/mgAeaqdw29LV4vO7pODn1BiuVvrQYpM5sTA8f6DbqEXfoEPeko4goDe/x4ErWC+zg
         +mODSEvFq5ljQbezobel1yT8x9XnU9x+FhdIYHgKNmWpmC7F8BECM6OYnhPOsQ0fyeVt
         YBJ4g1M23Apn+MSghcLnFUBB94s470TgEjMgU1+1iA1sU3XnwxLiIm1wyvD8SRaXtyZS
         76WQ/wBqIlMIyzzqrowOvVe0TL6FFxqOQ3bRWcwgVgz0HYZ+5GzUwjs8CYqUjWpOrh8+
         uHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221583; x=1794826383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7gQkAftGc6feY9izPoJt+dP0xjoWhSwyQPi0WVN939U=;
        b=nderBYGoFsfDNXGP5TKVcBL9Qn1R//xAvjAt9cwMB7WpgawT59fOrfdRoqsBoGDQql
         FSpMNcNW8h6+OKf+yV+EOAUu+YM+xYhgsekszs1HZg3UabNdXD/27907AK4vDfLPFsB2
         oU0Lsfv+Dkb7Xh4iH/W2EKFjlyyoq1c3YYPd2NpeeSlgzIxPQUSA7HH2BheMqCyOKTf3
         U8E0pVEP2n0yFLSB/FBpmhQsgwgb1qu1YxvTIoGygie2AzyF2oSdmCze+aHf55HhVthk
         jjqLo8kNOmDFUrjFoJbOLFQtxVLOGXhl6vX4uivRi2LXYfFhhNDR19ifd3UekRt2J+/T
         Pwnw==
X-Forwarded-Encrypted: i=1; AL+hErEtRq3/XpHsnEEQVhQHo+zr2A8xBYvl1nlBIY58Tg0o/VupouHOweztBxnOPV7py3qPeOe4Xhw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rPGYCnByUCyXf4fHWqdf0OFK/QtYAcjG2tbYRVejCesxoc37Y
	bDZRuBnZ6cjj/eBx6rXtdStoU+RMGdQFIc5NNqJhtJ/DrpACYmgpXpeJzdL9NlF0Fg==
X-Gm-Gg: AYBFou0tA7Af+21AlNsk9Bf/MW0V0IN5IvT3y8eRoftSUy2fyMn6jWcAplh+NGwNzV+
	nIshm/d1BDWkBDKWbE5FohZHsH5kqg1evo7ewgBOs1EEfbJP/HBcWfFxcr00/Zay7t1aHTcRKaZ
	DH+bWQOj39sWDYJHr3ICzgt0k7ZgIeFN2YOElH7vT+063E+0chH05BjcQojoZOWOMw2/so92g5M
	nDqUvcfTqiofQYXh/bN4cWDg4aFwkhOE5K8hJlppBVIcxIebReS0LZTx+A9OqSbnM16r3BlEU5G
	3wdkFGe+hEexoc2en4p/yOfFKFnzYKC0X88plf8NZSVIB69AiOEbyPISk7rS4w4eq5DGUbSJ/M0
	/WCxyIl1qNNYLliiwOKDna1C/1iRg4elYKpRuBy30/prnF0Uvt+RkXGDJV/MP22VY7mJv4fbNJy
	n2Y9Sm3DRQ/+zQqvmUAEnENqJJLxqyBycz3XQ3ppIpj81rcOnI51VzQlwnZS2vJ+X+fhVSOCR6g
	sBtBoMcxoOHwg1YWwN9O1ATmTZKZdEYPYzI9M49NSQTnqyuhzF8CK4kBQVMyMbN2hH6ZyQW8Qfl
	uAiDBsUKK9x7fpSIed7ayum9LSsyGjcai/wdNop3NN35OTF2OvX5So5ZS9zU
X-Received: by 2002:a05:701b:2214:b0:16d:1e24:5cc3 with SMTP id a92af1059eb24-1b39feda859mr6171128c88.19.1794221582983;
        Mon, 09 Nov 2026 02:53:02 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:53:02 -0800 (PST)
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
	stable@vger.kernel.org
Subject: [PATCH 2/5] 9p: ignore a zero-copy reply that arrives after a fatal signal
Date: Mon,  9 Nov 2026 19:52:48 +0900
Message-ID: <20261109105251.2545764-3-lian@is.s.u-tokyo.ac.jp>
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

When a fatal signal ends the wait of p9_virtio_zc_request() for a
zero-copy TREAD or TREADDIR, the device can still answer the request
before the RFLUSH, and p9_client_zc_rpc() parses that reply.
p9_virtio_zc_request() has returned by then, so it neither bounds the
reply size nor moves the error string of an RERROR from the reply pages
into rc.sdata, and p9_check_errors() skips its size check for zero-copy
requests, so it parses the error string of an oversized reply past the
end of rc.sdata:

  BUG: KASAN: slab-out-of-bounds in p9pdu_readf+0x151e/0x1c50
  Read of size 8179 at addr ffff888004724009 by task zc9p/155
  Call Trace:
   p9pdu_readf+0x151e/0x1c50
   p9_check_errors+0x23d/0x510
   p9_client_zc_rpc+0x4f0/0x970
   p9_client_read_once+0x237/0x6c0

Also, the error string that fits within rc.sdata is parsed from
rc.sdata, but the device wrote only the header there, so
p9_errstr2errno() can print the error from uninitialized memory.

Fix this by ignoring the reply when a fatal signal ends the wait of a
zero-copy request, since p9_client_zc_rpc() already returns -ERESTARTSYS
when the server cancels such a request.

This patch is assisted by Claude Opus 5.5.

Fixes: f615625a44c4 ("9p: handling Rerror without copy_from_iter_full()")
Cc: stable@vger.kernel.org
Signed-off-by: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
---
 net/9p/client.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index e63e8c2a853df..66980ad52bca8 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -706,10 +706,11 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
 
 		if (c->trans_mod->cancel(c, req))
 			p9_client_flush(c, req);
-
-		/* if we received the response anyway, don't signal error */
-		if (READ_ONCE(req->status) == REQ_STATUS_RCVD)
-			err = 0;
+		/*
+		 * err stays -ERESTARTSYS even if the reply has arrived, since
+		 * the transport moves the error string of a zero-copy reply
+		 * into rc only while it waits.
+		 */
 	}
 recalc_sigpending:
 	if (sigpending) {
-- 
2.56.0

