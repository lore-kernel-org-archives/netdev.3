Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793736057;
	b=tia0zvd7IAtaw6aznIMJYgGPRvhATrYjUWcMT4zjlcBDLNV0Tg7d8ZPL8WqPjFfuCgc+
	 0IS1uzsALg14CMUdFQeDIvLezRGwcZOs2ayE8heBz9AQOFOIQ5lvHHXkOixw3aKECzekW
	 Fow+WGxnd77SVsxSGMVuvrYieC+cHdJO/x06AgHc6gW10q0Tnv7inXGqFNSp59FSawuwe
	 7K6vFGJZtaUGC5/W8jvc4VzBF6zMt7hUztPhov/03VXTUqspWCaGESd/H2tdvMLmIHO7Q
	 0aZgAU/TuqkC9ZO8hvgBbRuQtTqOwbILZDfA4xZLRLWVtdTDh5O2KxPBWSaazBPR0Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793736057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mlFelYWIRdulUJeu8Py+aDXguvFlkxFE6N66Qy/SxHg=;
	b=Z0O9y2lapOtnFsKFb+acciS9udgiUMxUExx7v0GRC92osct4INsTB2S2Gy68TJG3+8ha
	 eg4lcofeVcC4whSPemhyMgEM9LZdCspTw29PtZTw4UkCyvGZU55c8t4PETMkT27H/XQhs
	 9X+QfDr5pfwiNiq3OpGfWduazIMLZXKy8YzgchAdXCCIzzSZ+jQ5cpZHzOk58NIFRtthz
	 JRGM+YHkQ3AaioVNt/JO8iPHt8IRfFEmsjBzzGjVBRea0/fzh/P1/YxeUuwBnVtAdinGM
	 2fL9B7rZONfZqKCto8ohDGZ3Md98Zeo8Jj9NXMypM6XFiuG6r2oUELl7UCY25gJDAfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=EsO0dbm1;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68537606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 20:00:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68537606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=EsO0dbm1
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c315869241fso658802166b.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 12:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793736055; x=1794340855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mlFelYWIRdulUJeu8Py+aDXguvFlkxFE6N66Qy/SxHg=;
        b=EsO0dbm1bGfsye5KZ5OcUac1g8c2L+thR+EhdMijecI0VJbL7V5fkwDw8RfXnY/n9j
         UeLanVc2T54tOs+nDeuC5VCmfeHa4WWKilz+y+xDCR/CsADLAA7uv5EP0MpGPIvrCqGV
         OyhNt7WVn49m4AXx1OptwoM1YhTlkIUWvzC42rWfQ0pOrO7SNeKZCNMWVwjzKvgdSDfU
         1Y2uK9BZEBgRSwopY2C6/tsWaTJ2pTk+m6wt4d3uTXt3eXDJmqWV8LU+3c2tjzSYTDu6
         FG5hmQ2cYfIUWL9sxyFm85UV9UClkg/b3az+1/DEhRNKd7VOmKfvTcGTEKUpX085TPrT
         TYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793736055; x=1794340855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mlFelYWIRdulUJeu8Py+aDXguvFlkxFE6N66Qy/SxHg=;
        b=0cSy3oBShqulVb/pviovClLxfYggpnSBZNwU+JEPj6Cygw7fb4LrDOcCPjHtFCzlX2
         UhR41lpLk9IgGafMaWEOjdFbaIoU4PJwSBvE+Q0wrw237evVzrhpxaEItvaKHxWWbOPF
         iDYwPJqoJ9/pmffcc9P6cWIGcvLpxD35LEa3DMDn3flCDhRSCXycQVUjq6z0EQSZyzm1
         e9/388QG4QfL3sM18FOiwvOp7Zv08O15FrpTJ8oswgJf4o1p9Qll+XnRPIk6ZWr7LNWX
         zDI2Gg/uPuUOhJGjOqY5AEPm4Oa5YjUR+hdnxmZrWEuNjz9nuQ4hHYyMrz4wgjibBsj3
         +rPQ==
X-Gm-Message-State: APuU4Z+pqOp1eQbh62sET0sYJC8ZE8rfSB+co23sYJ+TcN8wDlg19gYw
	RCjepdHX88MJRZITsTfltyx7TspLqqH1bLQtuY0AbqQT/kPDTKj3SR06NI4SNtIfuQgiox+mKkC
	4MQ6CRGQ=
X-Gm-Gg: AYBFou1rA3WwpSkL5tsy8VjNBOOrwpju0bOLUXDgluDMIMVdpUPf+F2CVR4oqTOumrB
	HDomXb2OyD54yuxfEhCtWsN9nVh8KiDkhAoIp2Inqf4btlLQg6TfDXYXW43G37OjQtmPJia0xEc
	xwzFYwzoDBOiUIDXtDCGaGXl/CT8niDpqQa1MbqtsGmhRuw35/15ImgOTYZ0SBC3mahR/wr2kbq
	/5PB4WkLIaT5uMQuFO6nZFe5k6jeoeRBlHG82XRK6JVRPn8OybuobABo932NENhHt+WsSN9qlVs
	MG2RqTGJOAIQRsWWjXDroTR3h7eJulPIs/v6ht2oNGsLVJzNju2wOf+HWcVAtwp+CGZxjOo5y4p
	d/kPh3Un8sKPbJX3sS8aN1Y239DPvI0wZ7iMOg/b7F4bQoEQXyfWWi+k/8b1XfOAyQizXNSGtUX
	U6I0zmhxjs3nLykHBrCZVfrgXAToi9cPzpD04Cv2s+hFep+DfK7sWuEOl8hHBfB+bj4MlrVKUX5
	gkI+Pj03iRyQeX2KGroiKgZTkTL/EAy+wbCuZLOQ3zI3z4gBCugTmrUvjJfCbc+vQPuiYiUj6A2
	CM5l+QIEaY4hF3HVFrpJGUHAQL+dMOgEDvYkZbsk8mBw0Ux0RBCoyarUhyjsG9HYgcWD
X-Received: by 2002:a17:907:9607:b0:c2e:2d8c:4585 with SMTP id a640c23a62f3a-c4ca7a9b17dmr1299809166b.36.1793736054809;
        Tue, 03 Nov 2026 12:00:54 -0800 (PST)
Received: from D90XRJJJNQ ([2a09:bac6:37af:1e5a::306:a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4ec91e2f2sm4499801a12.0.2026.11.03.12.00.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 12:00:52 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 1/2] net: fix mac_len of skbs copied by generic XDP
Date: Tue,  3 Nov 2026 20:00:36 +0000
Message-ID: <20261103200036.65764-3-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103200036.65764-2-tianyi@cloudflare.com>
References: <20261103200036.65764-2-tianyi@cloudflare.com>
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

skb_pp_cow_data() copies the header fields of the old skb with
skb_copy_header(). skb_copy_header() does not copy mac_len.

Generic XDP uses skb_pp_cow_data() for programs with frags support.
After such a program, the skb can have mac_len 0.
cpu_map_generic_redirect() and tc ingress then get the position of the
Ethernet header wrong.

Copy mac_len in skb_pp_cow_data(), as dev_map_generic_redirect() does
after skb_copy().

Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f676411724..aa0b11204708 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -967,6 +967,7 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 
 	skb_reserve(nskb, headroom);
 	skb_copy_header(nskb, skb);
+	nskb->mac_len = skb->mac_len;
 	skb_mark_for_recycle(nskb);
 
 	err = skb_copy_bits(skb, 0, nskb->data, size);
-- 
2.55.0

