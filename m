Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943444E643
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249378; cv=none; b=Cl7fNYzGBB3tZN8xG/ngrKtZ9qiZZc9lAleG1yVL6KIGrqbG08dWEb5l8inlJOvbU08CX6oSig73qP+zquC6QNe7iBdvbuEZrN7bvDPUx45MkVmi3LpuptiAZu0Fm/+K0CtKYg7k8hZyICliULeAREuOKP1VyfeghFoLTlkSTOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249378; c=relaxed/simple;
	bh=JiBrAmbJiM1RtUF5EuCg38M4dOYobpLpQnIXGn0FdnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pelrgT7OHzNMFwe1ytHXVgu8t3polhfuyL9bOF2+zAr842dOZwJmdxs3Vn6bxA9ACjsANQwdIaT3xThVBF4aTqAJQtNqET5KintvGG6P92BncsPfT7nxaENRgAzlp1nx8Nv/Ftf9dzjfIiTbajz0ErnGEVG1oNcpK+Bk6NaSlR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVvIC/ug; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVvIC/ug"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47c2ae992beso187539f8f.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 07:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785249368; x=1785854168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6d67jM+qK7S9AuBw7ITUYXOxF3mCoNausBAPxmDUU8=;
        b=nVvIC/ugK+BqRz+APF+di5HzEzJFLcgmhGLJAM1iEBLFcXZvxQFxmt/IsfM8F14mhl
         7Abkr7IpMejsTzTpXQg9YK0R2T2v3eO/RihVGz6epPXI5CthzwLU+kETMwyy31osS6A+
         uUeyE/AUwc3YhKsY8ienaZ6lGyn0seUsehorKAJSb0aT4dAwY5dLe7sZUOmtrvKyJHK3
         c7VPk1g4+YBmkSKQcpEHqA1X2FXBAR/Pxxzd5NLoBPQhqFB9ctQDYItXr4lnR3RFadzO
         ngnDgiFLopIgaIOZt9R/Ad+P7ZKpQOutSRT+Jig9FL0FxGjNzVlncZBWlc7A/Yg+SGjt
         L7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785249368; x=1785854168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n6d67jM+qK7S9AuBw7ITUYXOxF3mCoNausBAPxmDUU8=;
        b=k17LNncADPBGlFFK7KTjJka5AeokJkGO+2RMYT4PhNyAW3YCor8ZjaVa0hacNSN1Ox
         gxCOVJSPpUpv+2552NpxtlVyso1eR4Dm9oa0uoaUmj0cXEmVF1F+mEwLeu1IGq0hf8MB
         /Nq4GWVOC49wBj1cARIIi31JJKsW7N942bhoARSX8y6yPTto9d5WoU6RLJQuq6tjZGzv
         +hlgdLagBNkTp0XwJgU+7LT2DyCqOmBCsytX4vOOov/W0PXfRGsI4EM/2RvJVU+KkXPg
         Qhgqi5OBnj8od7jECWUBFpC/OV3oB6kG5c5r4Reh79r/ztAsaBXW2F+WYRcPx4IdAzPE
         c2zw==
X-Forwarded-Encrypted: i=1; AHgh+Rqvdhpeh0Jx+/V3HAI8wHGnrDc/tPgpkt/mNYp+aHj5duXMHjYIi1ARck37fL8HHXIdBGGLQHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxSV+C0XpmBm/52NL4iRoPbwwCeL7lMkVJYEYWtrGJlCXrsNSc
	hgb/h4oOepnGkjnNtusl/TfxT9lMt05n9o5h90ssh0bn+GlXR6CAmgx5
X-Gm-Gg: AR+sD10xmRTuVoNMeJvM43PesDtDQBL+Phb1H3E+JFFB5eK0AJmXaehwOJd9vjItaOW
	oup3o40NPwXKHqmso1M3Q4o4hBbNUPh80+UKtIa/bQIrHn6gMiJ3/xr2tDl065tsJa8/+7vvE12
	sp8AIjutPXr6RvpFIeJkep+e1qrzII5ZV4wA+XuQfSmcD/x1c/TyVxQD9AolQK/1iBZa3mcsyhj
	p2AemVDRauHZ1BOaGJH3v0QevqaK6qu9gJDT+XbDDDDtkdMTNLnAZQQgBi5FI5MIAwTpL6BC5RF
	SOTXsHFGwsendMeO5VIC/dhSWpdr1U6YzvCzjf6F/lFNrqmLZwNYGqSjc+jc6hdf3ZK/+MLa7sQ
	BA0N+BS8BIIPtjQjNPF/wvFHxuKO4QSGc9n36ZBy77WMBTwW6ME/+Xj5bG+UZCC4TJfsvyV3Ibz
	zAoJhPzVRZW5dC/yb3XCtNAfFOVn0ZRhRDDxpdquteRRb1MAw2HlbrjyY5XeK6Py6hWM4/jz34f
	3WQ1dVQv49eGwt1V6fyau5cJK9szCFn359E42U=
X-Received: by 2002:a05:600c:548a:b0:493:ec89:db4a with SMTP id 5b1f17b1804b1-496c60c2746mr17907035e9.0.1785249367859;
        Tue, 28 Jul 2026 07:36:07 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-179-168-074.77.179.pool.telefonica.de. [77.179.168.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfe07e1sm303390105e9.3.2026.07.28.07.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 07:36:07 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: edumazet@google.com,
	horms@kernel.org,
	shuah@kernel.org,
	lukma@denx.de,
	m-karicheri2@ti.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net 1/3] net: hsr: privatize interlink-bound skbs before address mutation
Date: Tue, 28 Jul 2026 16:36:02 +0200
Message-ID: <20260728143604.26-2-xiexinet@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728143604.26-1-xiexinet@gmail.com>
References: <20260728143604.26-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On an HSR RedBox, frames forwarded to the interlink go through
hsr_get_untagged_frame() and arrive in hsr_xmit() as
skb_clone(frame->skb_std). Two reachable alias cases make the writes
there unsafe:

(a) A tagged multicast or broadcast frame received on a slave is
    also delivered to the master through another clone of the same
    buffer: hsr_deliver_master() writes the node MAC and hsr_xmit()
    writes hsr->macaddress_redbox into the same six source bytes, so
    the local stack receives the RedBox MAC instead of the
    originating node's - deterministic without backpressure.

(b) A master-originated frame forwarded to the interlink aliases the
    original TX skb, which packet taps or the TX path may still hold.
    The master-origin substitutions (hsr_addr_subst_dest() and the
    outgoing-slave source write) and the RedBox rewrite would all
    modify that shared data.

Privatize the interlink-bound skb with skb_cow() before any address
mutation whenever it can alias a live consumer: for all
master-originated frames, and for ring frames the master also
consumes (is_local_dest && !is_local_exclusive - the exact inverse
of the port loop's master skip rules, so the condition does not
depend on port order). Every interlink skb reaching hsr_xmit() is a
clone from get_untagged_frame(), so the selected cases always pay
one private copy. On the hardware tag-insertion path, the selected
master-originated and locally consumed ring frames are now isolated
before the interlink address write: the interlink write can no
longer change an already queued clone of the same frame. Ring frames
the master does not consume (is_local_dest == false, e.g. unicast
ring-to-SAN) keep the zero-copy path; aliases that already exist
there - for example between the interlink clone and a peer slave's
hardware-tag-insertion clone - are pre-existing and unchanged by
this patch. On allocation failure the frame is dropped with the same
accounting as a tagged-frame creation failure.

Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_forward.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 0774981a65..67aaf5a862 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -420,6 +420,22 @@ static void hsr_deliver_master(struct sk_buff *skb, struct net_device *dev,
 static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
 		    struct hsr_frame_info *frame)
 {
+	/* An interlink-bound skb from get_untagged_frame() can still alias
+	 * another live consumer: for master-originated frames the clone
+	 * shares the original TX skb (which taps or the TX path may still
+	 * hold); for ring frames the master also consumes them when they
+	 * are destined to the local node without being exclusive to it.
+	 * Privatize before any address mutation.
+	 */
+	if (port->type == HSR_PT_INTERLINK &&
+	    (frame->port_rcv->type == HSR_PT_MASTER ||
+	     (frame->is_local_dest && !frame->is_local_exclusive)) &&
+	    skb_cow(skb, 0)) {
+		frame->port_rcv->dev->stats.rx_dropped++;
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
 	if (frame->port_rcv->type == HSR_PT_MASTER) {
 		hsr_addr_subst_dest(frame->node_src, skb, port);
 
-- 
2.43.0

