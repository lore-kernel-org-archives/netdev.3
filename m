Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E4346A0A
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789221389; cv=none; b=NqpuulanxnxeVAMOAxU9YwKpNEzeRIPgXweTM8DGVfBD6ibWS40LfOTC+LOQA6uLiGTtP0Pz0VKN8xmrh5fgoh6r31Hh/UUV31D31Jn2sYDUMRirNBm0tNCkOXLdvfawTmZKlrjEwKkrZIKjXOrToqHO3xYXAC4jvFtq45RPtuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789221389; c=relaxed/simple;
	bh=r4qr1atOhqzJgVEOo1uT7xsHaD3qDrrY/KwK5TvOYyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCiT/TOUEQYUg+W/BzSqdTwiff5+nXetmIkEH/HqvczmaM5G4I/RmJMB+P7E11/1DesfCfnovCCyJSWW7/j4NFB/iWRRXMADbNpdiW7uQly0uYgskSKG9FgPnSrFx5PgnGgwtFxg1A02Dg9iK4vVOBx7cDBJub6QbKFNMXvllTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=kOcOcjPx; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="kOcOcjPx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d6e954afbdso14336135ad.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789221388; x=1789826188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z8PisNlwgdN5z8oDrbfsU7/ISYrUrPGO/VaKKGw0ObA=;
        b=kOcOcjPx/ZeLEKNNSDRVp6GB7/jn9JbSi9KSqVRbeHVUtwc1s/ir/T2rYngf3iXpYK
         X1OAR1vct2zntnVmdP9ojVX/Liuast9YncwylLiyx6+5RzOl1zdMZjlx+cLbYHjKSQCg
         +y4MtXBKoCUuCQMy7eiL7vnQuIQbVngYkfWHSiRirv6J/RvFvRudc5NFxdP58xMUoco+
         Sbajo/SdKX0nYUX4ntCH8g85A9+CTi90CdYCQbGRj3hHpB25ua9OUPaJA6dxhQ9A0C27
         g1MMGcrqtCwgETbxgmXw6F5LDsT3RG73Obg1keQuih57K8L9RWXHUGaYYOi6ScLRfZcq
         FM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789221388; x=1789826188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z8PisNlwgdN5z8oDrbfsU7/ISYrUrPGO/VaKKGw0ObA=;
        b=oJIbRQwHrtG6bC8frv1qr7Uk7geUJ0uh6n/CypfylerF2AH/BCCQIawsDfDBejJb+W
         M0yNHHIu4LKGt+u4b08VX9f+vGYP10ktZL3SYaLoOo8s6ZdtLD9PcgZp79RkuW/xSlmr
         X6MB5obRmIASdZ3vXEioWGHBKR6iwPKt4Rl6m4ZQ/r9Yr6u+H/JSWgjORjSAzrkZSS+W
         5OMEQ84/AIxW+QGfxcR+TqVhOOxIUi+1FW2NLaWsthn3JERLMwrwE+WB7xiA/eVhLSTC
         k+Jn6c3TQE9YYtSPWfeznJhgC3ZYFwca+1+JVh+uE8uDdiAmSC9Z5Lt7UhNLQ2ZrdxCg
         JrDw==
X-Forwarded-Encrypted: i=1; AKwUvBwf4qN0rVs/hnX6WOUKbdnUCZ5AyeaRXvEASRf8UB/GTCjFlHmZnH4kbBSJ5urgKd81xKejmG0=@vger.kernel.org
X-Gm-Message-State: AFuF++mtgcU20AQe5owiUlqFWqUPU4C+rcs5lehZX4Z3ZD/mQTpUyTSY
	so3r7wPrMr4AU4LZSnILuwBORUDRlIDKImYMTSiJ8HaSNkY22Jhukep6sEizvC+/pZlp
X-Gm-Gg: AYBFou0lAgyXmAiQG5Duja0j75R2kXiVywlfyxkR+uHwNg6ZaFIVdjlqXa/OBLZeLc6
	w4ORKA6ZvkqIUt+2XiSjknFZ8687+hnKBri51CUwWthLYB0z9wgThz/qRs9QRnACzlNJTC24L8s
	ZxBkWA8nbnb1w2r7CoR0fRFxwjUJkf6/uZCLY2/tc72l3M7QolvNfmSK2+kMovN0R+vVOkL4rLl
	zLxzYcTWiYIz2j/wOR4UWf1flYAnVYMGj43aO8OArk8ZZba+QG2p7B9p4jmd8rah5Cylm+iggX/
	RO9yh4gz5JdtYRf6vvyFUK2nFyYF/pDrk/odpwnXzrxhRjQWSi24eIpGDQgv/Z2sIdjzYFWDLMq
	obuZ6oo40fU/4eKufRP4T6ti9pnxmB8XBH66M08XgIYkdU/k9jmN+qlD6e2XBBPLHpBnF1sq+cO
	YO+PIQTO0Gwe9dr3qDxfIL/RgBH7LV87eElmxdEyxiSa02tuT4pa3IFz9ftYee2gxjlwE1h8JXh
	1r3VqQ=
X-Received: by 2002:a17:903:178e:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2dd2a336572mr174031925ad.10.1789221388042;
        Sat, 12 Sep 2026 06:56:28 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f1e434sm13947833eec.22.2026.09.12.06.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:56:27 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Cc: trondmy@kernel.org,
	anna@kernel.org,
	cel@kernel.org,
	jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] SUNRPC: hold a reference while tracing accepted transports
Date: Sat, 12 Sep 2026 21:56:09 +0800
Message-ID: <d15495bff2247e3f9d4f9ef36df8e246a3898380.1789220778.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789220778.git.zhilinz@nebusec.ai>
References: <cover.1789220778.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

svc_handle_xprt() publishes a newly accepted transport before tracing it.
The publication can make the transport available to another worker, which
may close and free it before the tracepoint has finished reading it.

Take an extra reference before publication and drop it after the tracepoint
so the accepted transport remains alive for the tracepoint dereferences.

Fixes: 11bbb0f76e99 ("SUNRPC: Trace a few more generic svc_xprt events")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/sunrpc/svc_xprt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 40040af588fb2..9370401463b6a 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -852,8 +852,10 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 		newxpt = xprt->xpt_ops->xpo_accept(xprt);
 		if (newxpt) {
 			newxpt->xpt_cred = get_cred(xprt->xpt_cred);
+			svc_xprt_get(newxpt);
 			svc_add_new_temp_xprt(serv, newxpt);
 			trace_svc_xprt_accept(newxpt, serv->sv_name);
+			svc_xprt_put(newxpt);
 		} else {
 			module_put(xprt->xpt_class->xcl_owner);
 		}
-- 
2.43.0

