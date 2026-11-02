Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604084;
	b=AeYy+QzNR2vgpGad/DhiQnB4mjRz36ds+81UpKsxC+if5j+x4jMmJKu5fbT1OhgOEoM6
	 +zpEDKYPM8p5giesT8ZHYqI7M17jSljOt+j411XrNM4P3nlfWZtZo3qf97i21q+C/A4Vf
	 m5NCstpR16O+jkTmHuu2fm9gfyH+RnrxgiuQC5HkazrUsdP2uVEf3Pieeq+2TPafmNyCr
	 mIGHkuAXuu76uQvrYqRpDZKQ+Ei9bpumeK9UmuHnvUK87BQ6RzUexKBMY55nlDh/XvAdZ
	 wMOHsVOtuCetEDluieKbdcBloNuWBjUbzCW+oq8e+bbcw6DysICeoFdePF97IeTD0Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
	b=urkHE89VMrVNIHi0fvD++shEwVcggTb+j0TWK1zfZNkp7lMNSHL84VDjRnwoOmOQcc95
	 H49AV4ODxP9q0D7SoU18URdjc58wdudBk+UTyjakX4oaAaNtZOfISdilRqGjuLLy7SEuM
	 bgtiYAKO6SQeFaX7ZRNDljWE7ot5YUgkBL2gICoWRz860qKsg2UR+K8Oj6c4ZQTQNgucW
	 lv+ECOuv8ozqsBmcK85HanNp3/S51TJASesIy4NKdQWKnjmlm8qCXa0AtRuvbA1Tddo6C
	 xOFGSIx2NQ9E07p7NUYVJtcZkJ/smx9YNBM11FxupVoaccztIncUfyEKHBQLoMRxOTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eJSyx7TR;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661E9606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 661E9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eJSyx7TR
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so3226447a91.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604084; x=1794208884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
        b=eJSyx7TRNJ+iKyP0JOkLH3MqYgNU8rRheJ7RoNPil0uheKPeT3rFg7jDgqGDxqARI8
         NUc79/B8R/5mXmaOrdUBb+JMbawAycIXZPV/MjQ8cZetEddKzKIc8+D9GUi+xnloWq/j
         GGudAmMviC6J3XieznA3NFiheP9KeBICvW2kPk8EeddVv3XmwA/26DtzEIttvJVVLV4m
         3hRQGqOmd4iIZ8wManSIGzvo+gQ0IcqJtf/KsmkC/y0v3GRqppCD64IaJYnMviSzGUDG
         mZXXRz6VwhZOX9ziK65RMhucePYFGaus8dd1qtXtsgmbOTyrkXhf9zCNhrDu4u6tCuoX
         uC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604084; x=1794208884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DFLLbX6mAbQ0jCV7LiEZmOooBbXiKj6J/ISxTH/9yE0=;
        b=BJISlnykYkzFtpu+NOxcBwFycfCA0bbIUlfrX5KzKYV7q6bjL/E2bwYgW6+SMRqFsJ
         yp1pw7rj6G5+NU+h+uSrGgzgCe8LqIayDxbd+b5L/1RIWKJGWo2WHiocgiPd15EHPGtz
         27I2sZVJF/vj8IahI4p5fTU31XBVv6QH/WpGRqc0QU3rMdTvS3DgKLrmx5jqwBuI2TLh
         DYK2UD8kGeqCTWD9mBIic34+G9an0/FEEGYnYlm7pp/oVUz2mgxE1TsmerQkZWylQQgU
         sSR83cOPDFWLdvIUeOXwiL1bZ7w0ZR26JOrnIacAPi6Z/+uNntTy4yPeF2er7CfVm5ev
         i6Ow==
X-Forwarded-Encrypted: i=1; AKwUvBzke5JGY//7SRzMQstXsCj8LD6DjuZ1Gsfgz5WiXqMXPdrhogzhSf4YmKI+npTFmeHZrwXFMig=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RJcNUZu4b4bCCBg3cE4tdeGWYQoh4UWAk0i2jqy2TPll8ewzu
	AC00dESr5RkNU8kMBIv4DxX2+4c41TVkLFzDMarh9FLoUyE2u3qwjnbV
X-Gm-Gg: AYBFou0jmm1pqaF2vj8VFXiog98pT0WLqH5Ao1shH3LRGxTC5/z5j5xoFSTwYoJPnC+
	7bRfZQpCvOad+Cav/9JFKxZ6hNhX+1GnmTFD7Ez6XG1A/tN/01naq4FbmVZlJBlx//ZIk2JLADH
	SvBbm+FzQy8YmMu/+STYKN2rC1FwRxoVTk6FE2WVN3Qi2n/s/k5nUSdHbmBq0L8+XZoSf66XnE6
	r1jX+mfZX0KeoFQiMvy1ZqRYWuGrOQOoVincNHyQussaBActQmAZOl2e3fPfldy/ciwnJnkFhuT
	LzlVsXLXjVG8tD3BcZFDRZcrAFkwnm3Q8ShkU7teXbHowD89DtgeXzDeJd2gX18+EJI0kyNosGw
	3LBnIhuYs7/uk1KC4I64X11go2umsUMz/IjKzXj0tNOSKDSBgO3sAljdqhnBphMa2YvKkyMoJ7e
	8AH99lCMwaqN9Cdh1/PG1MrReEPlmemrQ7qTNsCtEW34p5y9TkTo+G0AGOfpF8fOISvjQVUquUi
	OQyWqYHO1X6ivVNdMEP2Pt5nK/5U+8oRTUuGvFcviPI26nWKSTjqxRNww6taRUL6ZcjgOFnhG32
	Pdu86i1jRF8SyIYvwL8pVAbUxA5kaBw38GSXsgtGp0I9CXU61Q+HmbZaIh9v4dHmShbRYDZG0JV
	GMCBccQKns0o1KpKolTSFh/I9mK5EPotdEGnhizNumiAAm1n1xSFx49h4/h7I1KimmQ6sZBv70h
	U=
X-Received: by 2002:a17:90b:53ce:b0:3ad:6090:a190 with SMTP id 98e67ed59e1d1-3ae89817b01mr7725554a91.41.1793604083734;
        Sun, 01 Nov 2026 23:21:23 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9426ffsm17877536a91.7.2026.11.01.23.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:23 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 01/15] bpf, sockmap: Write sg.start when recvmsg() faults
Date: Mon,  2 Nov 2026 07:20:58 +0000
Message-ID: <20261102072112.4160195-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

__sk_msg_recvmsg() copies an sk_msg to the user buffer and starts at
sg.start. After a full copy of an element it calls put_page(), unless an
skb owns the page. It handles 0 copied bytes as a fault. It writes the new
sg.start after the loop, but not when copy_page_to_iter() faults.

  element    0: length 0, put_page()   1: fault here   2: not copied
  sg.start   ^ today                   ^ this patch

Each subsequent call copies 0 bytes from element 0 and returns -EFAULT. The
user cannot read the rest of the data. sk_msg_free() starts at sg.start
too. It calls put_page() for element 0 again and can free a page in use.

Write sg.start in the fault path too. The commit in the Fixes tag removed
this write. Do not write it for MSG_PEEK, which changes no element.

Fixes: c9c89dcd872e ("bpf, sockmap: Fix partial copy_page_to_iter so progress can still be made")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5a961e..f03519468ad1 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -443,6 +443,9 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg
 			if (copy)
 				copy = copy_page_to_iter(page, sge->offset, copy, iter);
 			if (!copy) {
+				/* The elements in front of i are used up */
+				if (!peek)
+					msg_rx->sg.start = i;
 				copied = copied ? copied : -EFAULT;
 				goto out;
 			}
-- 
2.55.0

