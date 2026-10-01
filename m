Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547D4848AE
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841292; cv=none; b=clryus+KszS9aOGB8FdsgxPEffppE31qOsZNDzdWeF24nKgo9BCz/EPe4AQBnkkg0IxMEPajSw1FfOElQsrii1JK9eCd8+5YItWheSNvMLu0LkJepp/p7hHXscUcIReL/OqLNgtvui2giHnqEq/knNe34vhLfc4mAEHi9DNYxEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841292; c=relaxed/simple;
	bh=xQiLAOSzJja/qkz56a+Ck3jCxm7VjHe3Q+mgnBh37iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8x2HUb9kuQSJy+zZobUvLE4AVL4iC5lsZQxwcVXDK96LG4Bt2RTr8Su74eUV+JHgzf530Lt+wgDbE6qU/BH3fsw4LzETIo4xp42s0WCvQ018+r3V4oXkIll4xhOlVz+72RkSrm1S09mXrZT0zFbkFMvTzJ8UtIoVt5EK8+ErpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=FUZorDh3; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="FUZorDh3"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2e2e0d89e58so10890915ad.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 00:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790841290; x=1791446090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QMXoqpw6FOLBOmXzdFc/iiWz6FxGumoXwyUDZJfyTSk=;
        b=FUZorDh3FwEkeXRb6/CmqI20fNmDYZiw31t/eH6PkRYy+kSIvfgE/iLB+gUgqXBx77
         Af2PUZ96X3mu/r/Ixj97ZFaAifcpz7RC5WvsnuM+mW1YF8fIbUb7DiromO3sSyK1iWwl
         uNSXzDk67zvJ+6wsJQS9lFVECx61QR0aB5ZAWLqXEjT0GL7OAF+kcc2QV3Gp9l0p6sI9
         RPQmJAFgckU2LhiX28HEkoCPIDdtaXh3I8ao8NgMlFiauA7Hb9zGcw6zTAglVqvqXxfe
         VpnR1RrEdx4Q6XA6IeG5S3iHe8DiYZlHnx3MWtgj6kv7owEvtUdZyED99VP6NBNM4aHO
         2Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790841290; x=1791446090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QMXoqpw6FOLBOmXzdFc/iiWz6FxGumoXwyUDZJfyTSk=;
        b=hKCPQCO077ZJmhR2sWLH5iSFQw5OBm246JbAJ2F9eHVTQtHOVRkYGyaPR94S1qHfDF
         VI/I7bRzJ4wXKcah6q+pWjlhDzGMfUBUtwi9cpQtbCEomqfhWIjeODT/q0xRsHav7wEf
         mkZcmZOFSY3oXzERhcJ4A7Jbmi54LF3bb30bSXFW4ja8t9z4eSTJQMoG2DI8mNPzwyYg
         DefxHw+sry3EDOoEYDSYcwM4gN3EMDkZ8uVpHo3zMX9se9Dt6jeNNZxN31N+KgVTBjTS
         KipMkbpMnBKY+QztGtEjZbcwakL6PN4Y0uD8M78/qHezYE9q3nLqYo37X27obkioxW21
         9ehw==
X-Gm-Message-State: AFq9FYIdn8LjogWDpNHW0smxz+rbTcFUt7ZVZjwoG3o3MzTyoQSSuoIs
	st/F03GfaJ1Tj3oLcLUmhg80NymH7FOWpr7CbLZWyKCHuUC/T534WrRGWHSAu0PBgHwfYLaWQwz
	90ce9qw==
X-Gm-Gg: AYBFou07FTPtecb+PzHDAJLHDAbO225J6YkNzgx2LUnhAMqc2I1zfVWx+UeII2zjpyr
	3JuTfVCBK4c0Hd6XLD5nP/ezm8/rt7Y2LhHLs8rl9epd5Ged70HYZ3rbxnx5LY/97Jvj1FwlNTq
	UmS739AnWAlNaHyJ6kdOAO9EWQCitRj1q7gYhYvWISthP/keVeGdQAToS7z0GCxocKV0HmuJplp
	gQGvCNCxkbupMOCKOP4b4RQUSbBOaopzUHjg4RlAQnH0tT25hgU9pysV801REabyyY9V2DUvuzI
	AmtSEq77kw87VdfxUndHAI6TyVJWfQBcFQMQF7vYwyeHE3A2vo2pTIBPXxehN5qWcZ2uo7wXIdT
	efmZodm6Dhah5TwYsM4e+OnaNmlGsjFhvqwz8u2nb8q2pLUgpH5ndo24iYgJYUmV69hgTFvypzu
	HvG0vjqIkrLeRZQ81hRu3cn+V50+QVxh5qWOpi5MFTQ6LpcaPmX5jHjjehLbDAYqz2f8cFR5V9q
	7/Hq4PC
X-Received: by 2002:a17:90b:574b:b0:39e:6c69:9b8e with SMTP id 98e67ed59e1d1-3a4d18ed925mr3551465a91.51.1790841290165;
        Thu, 01 Oct 2026 00:54:50 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f46bc991sm3060243a91.4.2026.10.01.00.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:54:49 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	herbert@gondor.apana.org.au,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] inet: frags: orphan non-wmem skbs before building frag_list
Date: Thu,  1 Oct 2026 15:54:39 +0800
Message-ID: <11a750c626d9a100259dc0b32e330f5429773320.1790761119.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790761119.git.petalzu987@gmail.com>
References: <cover.1790761119.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

When a fragment skb cannot be coalesced, reassembly clears skb->sk
before linking it to frag_list. If the skb still has a non-wmem
destructor, the callback remains installed and may dereference the
cleared socket when the skb is freed, causing a NULL pointer
dereference.

Orphan non-wmem skbs that have a destructor before adding them to
frag_list. Keep the existing skb->sk clearing for skbs without a
destructor and for wmem skbs, preserving TX accounting.

Fixes: d15f5ac8deea ("ipv6: frags: Fix bogus skb->sk in reassembled packets")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/ipv4/inet_fragment.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index b286ee429da8..cc6718f579fa 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -652,7 +652,10 @@ void inet_frag_reasm_finish(struct inet_frag_queue *q, struct sk_buff *head,
 			} else {
 				fp->prev = NULL;
 				memset(&fp->rbnode, 0, sizeof(fp->rbnode));
-				fp->sk = NULL;
+				if (fp->destructor && !is_skb_wmem(fp))
+					skb_orphan(fp);
+				else
+					fp->sk = NULL;
 
 				head->data_len += fp->len;
 				head->len += fp->len;
-- 
2.34.1

