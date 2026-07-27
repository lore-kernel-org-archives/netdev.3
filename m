Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E03C584B
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 03:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785122761; cv=none; b=eI0XfUVqy4IJYyehfUlLptkI49pisPQcyrKqlX+jzoBPnSYsTlv51GbEooIzWsqKXrcaNIw205l+y3WJ2ABhZwWVa5a/4FixksAIQnnFq0DrjMnmToRY0JW0ZdV8H+2Ii6DduLj2eKvYa0y5d5BwM49n/sr20uevYCYghu1kZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785122761; c=relaxed/simple;
	bh=TLBHEwurgQziqWx4UnTmWoSnTjmL3RZWqj617YleMw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh1htOVKMoa/gKPLy2aUHDQbHmhyHy8Bxfe2RY/gE5dLsh1klcmiDKsO03wc1RquRUEReXfNgbG50yebf4tuctkOBbvcspuOO+6kleKRGMv7wX1O5wrqTCI9HCGwFOGJFMuANEfNGX56y1EqSJY/EjHagSrNv0DorbGl3cxDXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md4b6HFr; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md4b6HFr"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1835191a91.0
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 20:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785122760; x=1785727560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GndXTNcjBl1F9tSRNZnoeQNk1C6gSDLHLuihdVEQ2Ig=;
        b=Md4b6HFrPHECuIHXCddq8N7NyE1HD1cjI1Iuxv/Y/02ZFxpsIQJQ9qaHZIIN7Gzdp2
         EPjvKW66JbrOY/2vA4Xlv9pLH4kUPkkCVOMKgQtZg7G7JT/MgB4z3azP9rgU0OInX3B+
         RbCnJmQxFjOjexIuapiZE4oxDGpSncdgbi4Iq8UUUgVH6u/odP/y7f3xWBf5TooUjVOX
         6QfvEFJciSwdrE97ZGnCH815DriYxTQOEzkGWfJRAgzE9zJu04gRf2UGdQEpP1AAMWTF
         5X8lmhMwhsxaYnP6N6TYrBQUzDDRk3lOczqfMOiEKXpglAudibQrzuljeEM+nlrSjYFC
         tk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785122760; x=1785727560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GndXTNcjBl1F9tSRNZnoeQNk1C6gSDLHLuihdVEQ2Ig=;
        b=KPr/3cgOP5SqUNpbDekQlPp25kF+NllK/H+xma1KXUnvNx5rALOmwWPH7jfKnk0hkX
         gnUm5XgjSJZdugHyiDWHK37MLovFhOAsTIk1XWzMlIGU7yaC/dS6FxNaqczaFxxFJxbM
         OqJn+rnCRXHPWCaYxbZ6ZZUbRqJDYVAvdeYv6sjp7FbZIIw1Ihi+nXUsv0uhTABDMwqn
         nWQo6IfC+g+221WEHhtU/7SZ+5PszcBou7+uVCzf0WgtgGR6Ucl+WPxtRGCqNIFjLzKb
         PJVa4pCG7M5o4G0PbWeqZEE2mO7CMcHJbp1QVl6p2exWq3d0evaGSzZ5FLzZodw2E8hh
         MWZg==
X-Gm-Message-State: AOJu0Yyp5Sg7YInkBObvs2NcfGAhLnvW0c8szxRDLa2L/rlJRI6tuqhl
	Nv9EuJX5bONPVBvNyYYluNPnl1v0JDtajF4wxLT2GTjHiBMb+tXBiVBYD97z6+MfwcQ=
X-Gm-Gg: AR+sD12Er9AF/G5gcnoq5nuVr758ZCIelLomrIb8QTbZmhvJSA4h7oFfqlVv8dZZzsm
	Rrcyx8jzanajBbKS/1kuWaTxQpNVmdwAGY+0Z/FKV7j5YdrcliJTI7nbXWxL/N8wvXRPGcuM+2o
	yqTmphNneBJiS7MprXuazX5EM4d1HS/z6Zg5ATrHEXufRhh2ftfBsqbVnwh4avbvViyb7UcU5uG
	XjpiReZ0Am3puWlAgJx9DTVUhYZnC8Ro3ApYnxZhejJAg/G5K8QQU08fXOXJzm6ob2lQixFLh3L
	nF55MaL/Hk8LQCcHUjMcowqhYBNx8f/F8A1BYsvCwZJkru0Ai7TA6Mv8grQCmVVPPmDesw8tHJ4
	PhIq8ock2sLqgaJE1kIIV18jFnn/Bk2T/ChNT0m6hla11yZ8+9qobQ6Rh1DS9g+REJvHASwXFOd
	Sya87mkxB8xjrrKjN4LQkBOV0rITVt1nFO4YLxNSvAWn8KyJlY2PBLzbFt/ZGgbG/MHnpi75lq
X-Received: by 2002:a17:90b:5350:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-38f29399845mr6685365a91.2.1785122759724;
        Sun, 26 Jul 2026 20:25:59 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.119])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f2951f0afsm2381571a91.16.2026.07.26.20.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 20:25:59 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	stable@vger.kernel.org,
	sun.jian.kdev@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	lorenzo@kernel.org,
	toke@redhat.com,
	maciej.fijalkowski@intel.com,
	matt@readmodwrite.com
Subject: [PATCH net 2/2] veth: fix skb length accounting after XDP frag adjustment
Date: Sun, 26 Jul 2026 20:25:35 -0700
Message-ID: <20260727032535.13469-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
References: <20260727032535.13469-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veth exposes non-linear skb fragments through an xdp_buff. If an XDP
program adjusts the fragment area, veth_xdp_rcv_skb() copies
xdp_frags_size back to skb->data_len but leaves skb->len containing the
old fragment contribution.

After a fragment shrink, this makes skb_headlen() larger than the actual
linear area. In the reproduced UDP receive path, __skb_datagram_iter()
copied 1024 bytes past the actual linear tail to userspace, starting at
struct skb_shared_info. The copied bytes included the affected skb's
nr_frags, xdp_frags_size and a kernel pointer from
skb_shinfo(skb)->frags[0]. Real packet data was displaced by the same
amount and truncated at the end.

Subtract the old data_len before replacing it and add the new data_len
afterwards, keeping skb->len and skb->data_len synchronized.

A 60000-byte UDP datagram on a veth pair with MTU 64000 was shortened by
1024 bytes from its fragment area. Before the fix, all 10 runs produced
corrupted payloads. After the fix, all 10 runs matched the expected
payload exactly.

Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260720141859.19FF41F000E9@smtp.kernel.org
Link: https://lore.kernel.org/bpf/al9T9Eto%2FhRIzP5W@boxer/
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 drivers/net/veth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 00e34afd858e..a956498a073b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -871,12 +871,14 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 		__skb_put(skb, off); /* positive on grow, negative on shrink */
 
 	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
-	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
+	 * (e.g. bpf_xdp_adjust_tail), update skb length fields here.
 	 */
+	skb->len -= skb->data_len;
 	if (xdp_buff_has_frags(xdp))
 		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
 	else
 		skb->data_len = 0;
+	skb->len += skb->data_len;
 
 	skb->protocol = eth_type_trans(skb, rq->dev);
 
-- 
2.43.0

