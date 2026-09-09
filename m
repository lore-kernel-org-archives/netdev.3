Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42FF342151
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 04:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926927; cv=none; b=WjycI5OO36IzEpY5cG0/wWQ9VbSjFreh6ao742feTELSqiT6xnQRmGwQSppdT4zdQtghRCce0E1bk/07zCumWkPME0y3vMImPuxM5q6uCmtDIBP/DYc3/8ZvBIiMYeTQI/cIn8Nx2OtDFhkapQwurcrBg5VOtzxqq7RyoAB6KW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926927; c=relaxed/simple;
	bh=lHA65J/4a9O7FOIrwW3VPTBo9d0EBd8lH7ceA+nclpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhkWaMK1v10u+rOxQxdF0+CnMQUmyIiyD+F4PSvSjtHQD9J0IVJiW9v0kuKUT7xsVRXkbsaE99/6NsAm6lL4wuacF72gFrOngV6WWaKIQ2fCy+y5Zas8088ECtYucHPC7LQnR6NIB7BCJgIwMYK0GvgPnbLHHSJJyJUOToPmql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfhKZ3kn; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfhKZ3kn"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso5678836a91.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 21:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788926925; x=1789531725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5OlD5gWWssUWDFczse9ZxRfKKog9YLB57/AAsUi+8E=;
        b=YfhKZ3knOaU8utuUtRRGo0jkTw32ZrgnlsQSSMjSP2fPOKy9RJbELRrl6evuChmdO5
         PoS3KMxfaI3oORtfK7U7fsI9LYS1JmhDymwF8z2xOE8YvCBASic2+QQilNqfpfFdd/I/
         DpQ04F97xABd6+FndUrGcFNBwIXLMQhetNcFFueWpK/U3iA3GhYHtArhPx1jUgDSXCMS
         D50zm8wDVoWy9WW2Mdr0wsb3gOt6Y7GNEXwLL24a8WzPo1T0W0r31UQWqLmWfoO4j10r
         dDWQtzSKNOKkRfjQ5jiW0rnVAqmZP6j1xbg1Me8oHfyF4PjWQxQyETXVcsLAMtrZougy
         RqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788926925; x=1789531725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G5OlD5gWWssUWDFczse9ZxRfKKog9YLB57/AAsUi+8E=;
        b=ik426ZOx4pnk/v57LfKloGEv69+c2Hp38/wiBFujWOj7dCxL0wDO9TtTnx/vquJQaM
         ZforOu3SFyEMuLqvuK6lzOmsBibZgLpOnSgj+BbFZ9Btp4GdI1TCRR00golFBceXVSLW
         k4abjJI1jCD93m+4sXGqc/xog3mycMls3mTT1z8LkCCWXtOp5bdEazv2j2x1/aTI01ia
         qKUjukZzHtPD54DNZHYhuCvoPrWFlr5VnFVcLzqqynwGZjbwxSCGxnClxkL4N2b+QsmB
         VMM9IUeJyr1zotL7WO+AqvnJID8KSljQQJtqbSTUlbBiTeRBT0zUulJcyec25tfPWlWR
         aumg==
X-Forwarded-Encrypted: i=1; AKwUvBw9VMBXwOKZw8iUk7PGJRT6aMqIRmU3qLhlM28PCcuBaHrxAHDxMq8L62+XllDStt/LnRDBMYY=@vger.kernel.org
X-Gm-Message-State: AFuF++lzQj1HXKrD5mDwADWEU1uhR6P/uPqcC5O6frqPUPEnBga2CH04
	zBhM7Rh1zoSPv9F1t3Afq91FqwwK/TXbNqyFEtubZYA1/wo4qMyPUFvb
X-Gm-Gg: AYBFou0wR0dvU5siHWcEh6O3ZmU8Vwz4gQ29mZxosJr7z/BO81s138Pt58b35ZRqW04
	p07aD0hVva/KQxZ857oXkuTYYSL046p6MNCpEFg5LKX9nzYGZ/lHiUYh5GRS8TY71tuiDgp8JVK
	le6aptVl3rPvu7S3ghV9VOpFyg14n7StbL9ysH1TGaBezeWnTJaFYjXh1inJDb1I/G/PuWOOxsW
	GTizqBW4pnhlRz8KEQy7gibjb4J87ZTjwshFnkTTEfdCFX4bTebYXQEwKdj1CFgORXR+JZpz8mW
	JyLDyNYXq2TR3A/aXbZm5uxWOWN6MifFL9/4lGFdjR+sZ9Z0aoGsaTcafgFet/6AnM+BEXC/Yu8
	ASvZZGRL+ZKHSwrc5sBCRL9uBenD4hR60TupFrK9VRN5Q/8IRn//CMkgCzF7rBZFD02o6eCkiBY
	18xWvEih7sdRyaT/TjsdMWA9d0VtzrnSJDDhfj9Z3lWI/tnTS55b2dm3Sx7wkzkb5kGoH757Hst
	/mGaTCEkkUGA8RGksy8I0mtYh3KcJCG
X-Received: by 2002:a17:90b:4c03:b0:398:cb56:e92 with SMTP id 98e67ed59e1d1-39b26130698mr45997775a91.11.1788926924938;
        Tue, 08 Sep 2026 21:08:44 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2615039asm29766867a91.15.2026.09.08.21.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 21:08:44 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lebrun <dlebrun@google.com>,
	Mathieu Xhonneux <m.xhonneux@gmail.com>,
	co+adfca3e91be95776@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v2] bpf: disallow bpf_skb_pull_data() for LWT_SEG6LOCAL
Date: Wed,  9 Sep 2026 12:08:08 +0800
Message-ID: <20260909040807.3885815-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907192129.557377-2-bestswngs@gmail.com>
References: <20260907192129.557377-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An LWT_SEG6LOCAL program can invalidate its cached SRH with
bpf_lwt_seg6_adjust_srh() and then call bpf_skb_pull_data(). The latter
may reallocate skb->head, leaving the per-CPU SRH pointer dangling.
Post-program SRH validation then writes through that pointer.

Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL programs so the verifier
rejects this unsafe helper combination. Other LWT program types continue
to expose the helper through lwt_out_func_proto().

Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")
Reported-by: co+adfca3e91be95776@bugs.sh
Closes: https://lore.kernel.org/all/GCy0KRM2IcQGoJQTjJEU9D0maBxXzEDHuQpq@bugs.sh/
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Link: https://lore.kernel.org/bpf/DL9COXZQXX4V.1FN45QO2Q77ZH@gmail.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- Disallow bpf_skb_pull_data() for LWT_SEG6LOCAL instead of adding a
  wrapper to refresh the cached SRH pointer, as suggested by Alexei.

 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8513167a858a8..2a84f9d011314 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9044,6 +9044,8 @@ static const struct bpf_func_proto *
 lwt_seg6local_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
+	case BPF_FUNC_skb_pull_data:
+		return NULL;
 #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
 	case BPF_FUNC_lwt_seg6_store_bytes:
 		return &bpf_lwt_seg6_store_bytes_proto;
-- 
2.55.0
