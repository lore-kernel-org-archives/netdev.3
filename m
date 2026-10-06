Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989554A0913
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306642; cv=none; b=AP6TAq3uf3IQzrNtiQNqEiiCjPvjKVhxiVAHAk8XtQeKYPpI2/Om0faKua4R7tHSH64DzkkXRk+aV3LXfd31xjDkJZCTPHrrjnGImffUWl/rX0QCxdr1GvCwdaRjSbjf23OzY8HYWmr+FPQr2u+W/r6JWGZ4Z9y1FC9Q9CKzxos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306642; c=relaxed/simple;
	bh=LvUip6sg4zC8MHIDQcH+Q74Y1I2oBLSsqvHL1CWpu/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L+J3xXp2u4CgXJkyvzOonpeB/0X00F3NhAbI+CEJGjNgwajCRP3GbaNDnP5+iO3vrjcFkEENisYe3kDOpjo4Sch+z0jNKFlndLJKuNIZq9ERG5vvWN0dEenMlNbJgn8umDVwt5h7HRWmobdWuUO5svGBo2hTxDgIJIzkHZv4l+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZKDZj4ju; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZKDZj4ju"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9178d514951so25014836d6.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306639; x=1791911439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IRSEhk/ukaPGF86WvMny5m3lspAeG/UVjcvU5kzCm7o=;
        b=ZKDZj4juxFetqSB5ljPiLSZIVQWHpkNcktmeEyUIgaKFOCLIJ1UpLXobPFuNsAYvOn
         Z0FtLRF68ehEHpIFxgK81E+HtrpNbbHAlwqqKDPI9VgHcF2uAxpAPLXbC0zoZj3J0DPY
         7gfPr4XwdMI85zLOveww5aQSez5f0r62i4c0fVnOStnMnMz/Wn4pLmHY9BLiwSYL03lc
         PkNFYhJfSIuEfFCvYBlGeZUfhCPKUh4cugvxyqxtW5txGeYF7p86RD3QK1VKgLHeFwTn
         cxxX1MlTLDudaEeJZgw6BKKd/2DkrvgG9iXaOmZSa7MEklf5XdNnSmfwV94iR3nenyaz
         +Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306639; x=1791911439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRSEhk/ukaPGF86WvMny5m3lspAeG/UVjcvU5kzCm7o=;
        b=NDChs/vgpJNOl4kMTS9ObQShyciZRo/AKhFeT4s9tE0zs8TrBgq0wlf2fGPLUz5EJK
         5+5jAMLwR55ai2quTk6kCAsG+VRiZY8G97ni5GHurxHYe/6JE3sRhcC8OG8me6jR+OhT
         EJGtmgnHQmFY0/tP4nm9Mh0+QHRU8hOFQ+e3bIByTFrRpVLoT7rAjxExTORFGT5fEGt2
         MfCBgK+DTy8+a9Sp3rCwS6oOEYyyBTMyzg6bhxRbzDJaxQ76mnT+mUrCDBLCjWoai6BR
         S5TcNVqL62z3CTzDIDiXjlsVMVC/KSa6bjGaa1snXPvw2CseH/eTxminKo5n64/6ZhWS
         syug==
X-Gm-Message-State: AFuF++kXJt+FT0iUGVSJcsNcsNpEKTECFJCd2bcMcMAClriZhQ0Q3NRG
	6WNHjDTUUhVdP9mUcoEHiZaN7i9w0cPUXa1Qz4qB4NzD1OiIEGkat1W/QA34PxLlSnA=
X-Gm-Gg: AYBFou3eA0EFfNm2l/6MN8PjdIBmt9RpYDnrAmcsjz66FsI0OAd3e0CbT1Q0RsiYBql
	C+ghJWFviHAddafieFKEtUSChQeQHu33pPuMB8edoG8aqeFF5DQ6OCWbBPxGUwfIzayb9mzIUl3
	vACZxoW8hacmUE2RKV54bliYvKGmfACKiDBZylx0VKyDmDM6fM676exVgbUn1CpMInZhRxWbsYQ
	o4JFGzsJZGg60QbgtaKd3vRz7A9NIb9NGaFPoIy1l2EOB8uU2WIdy5Gfv3yC2ItTIp5eNqaNz71
	IZKrUqLLzaXvlwLdifJ2EDUGL2DwPEx+NurepPEykSzPqabHmhLZ8emCNNL2S/xuc+OgsY9SO0l
	UqrVkZRdsc0fYq8ehF2eN4/4JHl2JGb4rLjL2ulzrnnnihMUJV7HqT7ADZGxi/XrMWp+nW/MnxS
	xeR3JKRS+1nFUOdb4Jxh/cZWKbAKMz0Ig9YBobYHnBQS/vxF1Z4v5L+7/iEhCApphUpsZ3QPt0K
	P+IRYYmuJKCNdM=
X-Received: by 2002:a05:620a:6914:b0:93e:9808:b9e3 with SMTP id af79cd13be357-93e9808be3bmr95038885a.72.1791306639172;
        Tue, 06 Oct 2026 10:10:39 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0bd29b1sm117233516d6.34.2026.10.06.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:10:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 17:10:16 +0000
Subject: [PATCH net-next 1/9] net: skbuff: don't leave stale bytes in
 skb_copy_and_csum_bits()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-skbuff-bug-on-v1-1-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791306633; l=1482;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=LvUip6sg4zC8MHIDQcH+Q74Y1I2oBLSsqvHL1CWpu/c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDmkAUy8kW3bakdV4LNq46AXJrMyBElWpcUZtAqWSXkkZAnpkvnxX0s6FBBSWcXGzGVtOhKQ1lX
 yTbXr2FmIgw4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When skb_copy_and_csum_bits() reaches unreadable frags it returns 0
after copying only the linear part, and the rest of the caller's buffer
is left as it was.  The callers copy into a buffer that is about to go
out on the wire: an ICMP error quoting the offending packet, or a
driver's TX bounce buffer in skb_copy_and_csum_dev().  Neither buffer
is zeroed beforehand, so whatever was in memory there gets sent.

Zero the part of the buffer we didn't fill.  The checksum is already
wrong in this case, so the packet still gets dropped by the receiver,
it just doesn't carry anything it shouldn't.  Only zero for a positive
@len, a negative one from a broken caller must not turn into a huge
memset().

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5c4024a03e10..512ff9cfa269 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3633,8 +3633,12 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		pos	= copy;
 	}
 
-	if (!skb_frags_readable(skb))
+	if (!skb_frags_readable(skb)) {
+		/* Don't hand the caller a buffer with stale bytes in it. */
+		if (len > 0)
+			memset(to, 0, len);
 		return 0;
+	}
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;

-- 
2.55.0

