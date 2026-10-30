Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334102;
	b=4qem4Ffdo05IJNpIn3IWsrD5fNTIKkGPgQt+urGHiiMYvfWOeaGltPvuYYxocrPEGb6+
	 236F/54/ccosiS+RguX8e+EkjLyGstXAn5/m9KKd32lmOfU4B+INVfBl4joi0KQjf6XEU
	 SGBSo9GFpkzwfKvXQ/mOuENArYmdw+RavgfZZjP+Zw8XGuEl5ntuEV5ypI9NPTAO2fEJW
	 H8vC2rq8+YwaaebIxUw9UU42i46ZD3965StDyvOW8rIIlZUUMV8bSanDIs2kvPDulznks
	 xxInp4xim1Qkn8Xlk13YbJ4yq0w1NQ/ATlgNCI/xDhSsHzqThy6mZrG58CrGls1/4ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PMpIblKmZXt8BOY3Honm+2Ww2wYw3iNTalEqXhUNRCc=;
	b=Wjs/SnR9BWEUnjqJ3qwopurgTvqeEt4XeyGKzfo/imKE4a9xla72gWgjRLSsOpBRdrNu
	 LGM1O4IDhrAko/+SnFxIY7pmPTeOTL5g/Isk1bxfoc4pjz22hBxiFitao91qAVlyb9Lsd
	 FC9Dv+v2MU5eJwqKbwvxkYW+pL/5Od5NFm4i32wU4wCN84WCA3DsdfSrIu7Nk86cMEmb2
	 Tu0Bhd+abDE4/AFux+mEjzXAWKFCl66C8R3Ik4kz1ZlbKqE6vUs2JEpXfu9L0X1YLGmVW
	 teTP5GfbLikYTFEXEWz4omcVvX3IYoT5bYiJ6zVNPqNwv3SXZ8r03SABt17bvkiGueQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=V2Tu+7XG;
	arc=none smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64077606A31D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64077606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=V2Tu+7XG
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4a6fb4040cfso89391fac.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334100; x=1793938900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PMpIblKmZXt8BOY3Honm+2Ww2wYw3iNTalEqXhUNRCc=;
        b=V2Tu+7XGLweuI6JuW4q0Atp29krGpuRTqzaj3uF28jN846RWoygzoK6hQsvoo1UC9X
         knJAdo9MZNzSZj+rmkB/s1YKmt1kHg8xySqg/Y7Ilb8KXauOASd9C4O2nnuE4TRK807M
         J6rcR7iWe6FJEElVS0i4BdLAwdMFYZoYnAJMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334100; x=1793938900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PMpIblKmZXt8BOY3Honm+2Ww2wYw3iNTalEqXhUNRCc=;
        b=syhfSfAiC+/pZcLFISEWoAbQp4FphZ1v/3HXIbXQLg4HtPmuQcMkjgb4SJCV1Hn/0l
         JRdiF/YYbN6u6ulZREN9qfiX2NF7EzhSGKuQA9G7Kfi82Ft2w0mUzrfTMDj0VT7VOs2N
         J3YXngv5+uWDS3nP0N0wcglNx2SHaPCPsbZAlOgKTJvavFmlVeOzJl3koqEzm0+3nb2S
         SMvKeoCFw+mfZVHXec2Xcja9McFyA29TkWrfak0YyMyxTeGc0h5UBDa3kt5jW4PoOXDT
         KL1fnAN65nnP47ZvQrZAG10Z8gmTtlK5p9OR20Xe99+kMjO0gbN0fVj9fAUOKdvpUv1c
         rsEg==
X-Forwarded-Encrypted: i=1; AKwUvBy46N2FlaSLimxGR414mEtBu1/AIzhA8mcyvGrikf0o9JleGOSmXZvYAaFAI4Ohw3TPvO071gw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6LAzK+IaDqApUCe8DNfS89NLHQhaet4zLYXOeODoEKkvbSWNl
	FLL+JfdwltHin15fHRRnkysfZ97t6TZ72Le8BXg2dMSF8cXXedSC8Bl0VUgAVdh7HOI=
X-Gm-Gg: AYBFou38eSAXgF2uDl1YXNQsrb46zrdMfPv5RMNDhm7Zc55KqkJDjk3aENe8TTqMscA
	Wt+UmBnjinD0qsmD5T826sWpI6qZ2UsrxysfTWbGrokf9ROI4YGNZK1sxbyNVCmpn6UOuuBbFuQ
	DQWaR1se1Wh8X+nALi5gNvCCUkH3NzkH1rScTvaNg59VQUhq2bCGhMBZ7UbruheuYAUsQ+Pmqkm
	QQMKGwhlWkgTco0P2tFGOF/Oyr4Jmi2qHj1LAFQM9wTIealcfbeE/kR1vAtWw8vMJ6b0M1zgIR4
	QgY1OTIZpf2RMc0Mrbx8nyakvjL5DWm+cEdqBIhqSv/PFifG9nubBlrj1e4jxlziPH+zpWc0LG9
	C82SGYXakcuhKPe8Dq7mW6Jdd9u17RIZ+/xkO/5GbEpn0c9+8aU6YX0O0cR8ie8eO7Ar9g9+nT/
	xfgODy8NYcSu6GO5oNSZySVmjR8CMmLJ8Rd/0laiuv7/kL4zBCQSHOeRIekcGcr2ez/9fdCk9fE
	zo63Vwbqnr0TNUgX66xtlBjmZztIg1B84+D43+VrkwZncfBR3xdvsoaYTdvmVkmNwrcfo8BG8xC
	PZ/QY1GaWoruwajYXNZL/hK80E52ytcDjKS18M5zlh+1jx0pJEjjqQrcFjeVpyC57ADmmVrM5+4
	WrGF1FAVOhChESnAg+6JYzkkYa43uFg==
X-Received: by 2002:a05:6870:1f0a:b0:49d:c8ab:967b with SMTP id 586e51a60fabf-4a907775750mr775519fac.47.1793334100321;
        Thu, 29 Oct 2026 21:21:40 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a90af650a1sm769349fac.15.2026.10.29.21.21.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:21:40 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: bpf@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] net: skmsg: fix copy cursor when coalescing clones
Date: Thu, 29 Oct 2026 21:21:38 -0700
Message-ID: <20261030042138.73739-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

A splice or zero-copy append can leave the destination copy cursor at
sg.end. If sk_msg_clone() subsequently coalesces with the last entry,
sg.end does not advance and the cursor still points at an unused slot.
sk_msg_memcopy_from_iter() can then walk around the ring and write into
older entries, including file pages spliced from a read-only descriptor.

Software TLS can reach this with an ordinary MSG_MORE send after a file
splice and a splice from another TCP socket. Both TCP and the TLS
encrypted-message allocation can use the sending task's page fragment,
so the TCP-sourced plaintext can be contiguous with the next cloned
encrypted-message range.

When coalescing with an exhausted destination, move the copy cursor to
the tail and set copybreak to its old length before extending it. Find
the actual tail on each iteration using the ring iterator, including
when end wraps to zero. Leave an existing copy cursor unchanged and
preserve the normal coalescing, reference counting, and memory charging.

Fixes: fda497e5f5b8 ("Optimize sk_msg_clone() by data merge to end dst sg entry")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
I have a reproducer for this issue and can share via DM

 net/core/skmsg.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5a961e..0e9ff4be78ba 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -103,16 +103,26 @@ int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
 	}
 
 	while (len) {
+		int last = dst->sg.end;
+
 		sge_len = sge->length - off;
 		if (sge_len > len)
 			sge_len = len;
 
-		if (dst->sg.end)
-			sgd = sk_msg_elem(dst, dst->sg.end - 1);
+		sgd = NULL;
+		if (dst->sg.size) {
+			sk_msg_iter_var_prev(last);
+			sgd = sk_msg_elem(dst, last);
+		}
 
 		if (sgd &&
 		    (sg_page(sge) == sg_page(sgd)) &&
 		    (sg_virt(sge) + off == sg_virt(sgd) + sgd->length)) {
+			/* Start copying at the newly cloned suffix. */
+			if (dst->sg.curr == dst->sg.end) {
+				dst->sg.curr = last;
+				dst->sg.copybreak = sgd->length;
+			}
 			sgd->length += sge_len;
 			dst->sg.size += sge_len;
 		} else if (!sk_msg_full(dst)) {

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
