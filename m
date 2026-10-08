Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BA3AFD1D
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478381; cv=none; b=hSr1bxbYkLdB2xSQ6ynQFIkB2S8/fDdBy9QTEaGu8ec/DM9TAi1AfHsHlGbaq2oYXia4N1+E5q7zUcJ9lcHZTnmqc9wPz5L6duKxSNfYV+mAv2x4Qu6SsyzTQfPQIs16Kx6BQ+hZmvuOkDwSMc17/moVgdywLRMlj/6HMqTkngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478381; c=relaxed/simple;
	bh=K0v/ha8FuVFLJOV7NM+u9GAXy6iGXOQu/S71aMmoIZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt8aZR3GxOaElcL+7J1QlcMbmd9IgT8ovXHoy1h57xJfUytAo6u96dEsFrSP8LtWeqanhdHyHQ8jUJUrFtck/ktUKF0IudxsUiTViMnkvT6ibBqt9hxdA3aSxUzj4cHqHmYl/VDlO7bTrLj/Mj435qhzr3zZvNGN4Rx31YnqBlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=aYYRI477; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="aYYRI477"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e4f0d7d77so461286485a.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 09:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791478378; x=1792083178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f5pOddU8U8Oh/2KTma9N3+HMOEKnqqX5XS4uN84yG5s=;
        b=aYYRI477EUPQtPfH1BujYGuEeDTzXYgoCxZ+5n5/VaPX5NEKH4L6XsdaA2aerx28sR
         2HtOSBHxKEofKo/ivkMvrTxMumU+VYWtkhUYguFyS9TxmXKGwQGdmIo+iszdIF98y24b
         gHlUllarjrOHUrQEwqXNCP5KnJRkQ4kxwnPd2Ywaa94gx0HWCfMguyJfaRnF3V7E5/JN
         lQ4rdVW+i3CbLf47HVVe/OSm+CsdEh9U7sQGn/AqwX/FNq5HLQiVqTeWXTfRpZCQg2xU
         ZEva7L4NBLNdL0H/dU9A65Qr4EDkoJtBs1cvAwEtjRlrZ4qFF6m+eoCQJqIGGLGdgrAP
         +BSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791478378; x=1792083178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f5pOddU8U8Oh/2KTma9N3+HMOEKnqqX5XS4uN84yG5s=;
        b=JTTKc4MUZkMKK3rDtasIjkqo46ahJds8r+xMaqedz+6WIMvu1GPy5PnBdaoW1euLVZ
         ShUVL1KtllXXcXBpsqLCze1bjpquI+AqxbFI/qRkuw+9VRi0wxkikI+7tWSmGSfRQUxI
         A+3jbYFsRZo+FxPzVkBKa4LhPY6durvWOqR1YGQHF+t/DxwUW+7kvDtdDwilbU+1CSTV
         aiqXT+vbKkC0jqnLnA1jJc7hILH0YAnrKR7myJ8MSjtg+2tsojq2k+fh++7Z2ADLWIfz
         8mUG1CEp19YM0HvYVBgd6xO+KsIuYYHqSbHcO0FH6mdMZtfYMkrqlH8LI9kqYprp06OA
         GhVQ==
X-Gm-Message-State: AFuF++neIa6g+vgS1w16ZaXjHKryld4SOxJ6ZdcFqXvMcnfhOUWtOvAV
	yD5VYZ0ezG+TecTAg6Aig/4V4sjJXTPx5w+GAmUffVPdimh1aekamhwmXOls6pxdQHFUf14W9J3
	RIwt5AV9myuU=
X-Gm-Gg: AYBFou1Gl26wRam/iWWrdSza7WpDTxK/whf86dsPq+4Bj/4OUQWZsWB1YrtNJv4poN/
	E/AzUCk6bm2wv1YOGO/d1XrdnFChu0cHSGiem2gerkgdxJB4M/eSv4bxyhkXh6utzuZnaY7mrkg
	OGxCP4D/+RYOeq/AvA/S9eEQcCTM5OtTLB9rutaUWnh6iaJJA0J/uy3EF6yyg2TpQfMa9rUBVke
	Tfq1H7L6UwyMvcTxYrItINSVKD5vMT91fgjmZ68hV66lZQBpGKDYeDkYtbs26ky6MgCTMk56SbN
	RTvUtw2ShYCm6knAlc/UOTR7I4GO+oDNkKXkFZZXdKFYIsdJoXbMSj1yUpEQ1heBY6D1U12V+5s
	kjeXRkStyVLWfG1zP/0deOD8o7/DZphHjg+DD0t/O8sOTN85mSdrKwKb8u+XDTxBKy+5hQ4gst7
	F2QQrJg10MErWziF8Oa6wvYy6LlarA+X2worVC8dJHY3raRwjWvjsq68Z/AnFwSHybr3VQvxxFH
	tvdwkJB
X-Received: by 2002:a05:620a:17a1:b0:939:2b7c:34d1 with SMTP id af79cd13be357-93eaadc6856mr544323785a.15.1791478377683;
        Thu, 08 Oct 2026 09:52:57 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e9914f7e0sm519467285a.19.2026.10.08.09.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:52:57 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	edumazet@kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	joe@wand.net.nz,
	ast@kernel.org,
	kafai@fb.com,
	vega@nebusec.ai,
	fmancera@suse.de,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v3 1/1] ipv6: defrag: orphan skb before queuing
Date: Fri,  9 Oct 2026 00:52:31 +0800
Message-ID: <5c396b7011168cd98b9812df4d6bbd00a96048e7.1791008591.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791008591.git.petalzu987@gmail.com>
References: <cover.1791008591.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

IPv4 and nf_conntrack fragment queues orphan skbs before returning
-EINPROGRESS, but ip6_frag_queue() leaves the socket association intact.

Commit 18685451fc4e ("inet: inet_defrag: prevent sk release while still in
use") moved skb_orphan() into ip_frag_queue() and nf_ct_frag6_queue(), but
missed ip6_frag_queue().

Without orphaning, inet_frag_reasm_finish() clears fp->sk on frag_list
skbs but leaves fp->destructor set to sock_pfree. Freeing the reassembled
skb then calls sock_pfree() with a NULL socket. A socket using
SOCK_RCU_FREE may also be released while its fragment is queued, leaving a
stale socket pointer; this is a second consequence of the same missing
orphan.

Orphan the skb before returning -EINPROGRESS so the queued fragment no
longer retains the socket association or destructor.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/ipv6/reassembly.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 05c51f669754..a7964125c764 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -232,6 +232,7 @@ static int ip6_frag_queue(struct net *net,
 	}
 
 	skb_dst_drop(skb);
+	skb_orphan(skb);
 	return -EINPROGRESS;
 
 insert_error:
-- 
2.34.1
