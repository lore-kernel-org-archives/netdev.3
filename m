Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3B13A6418
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559524; cv=none; b=HsLQHzX4zJVC0qRB7CRXvTBc1a9wdWlVByCpJkjcKmHBGJyRnEctRPb5BrFXep2ERHn7wloQ9ktkE/SGhza5kiCF0kksJSZ5rrERyBNZyn0Ma0HyNa7XN7VmGZFc6HWmUUVnM2mvTFOM8F01Vp17WCeDOJuVgDc9hdBUFIPEsSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559524; c=relaxed/simple;
	bh=pKuhV9/J7HbYsqBHlv/2CzsONpr/yBCP2mv3h9XkQng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOt+cVJgWzQ+gSN5ud7WitZRja55ly6mbRbvCSnz7Rq5TqWVzJXTlj9FkkXetVW/nL5xF96ovw7ThJpoFmM2KmBI2ARbUgXNN1MfXU+K5XmDjI4bTvdpD/f/pjNChAvfY+J/We9z9eKqtsmU1UReSg9/DI76I9CcnVDrtzRe8YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwOxInKs; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwOxInKs"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38759bcd877so3803956a91.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787559522; x=1788164322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RksCCBXE0XrMrTynxzNYUq/eoGnOg17BpZWifRjpeC4=;
        b=ZwOxInKsOo1RmwZX9vfs2+V1EnPMb4TkR1ugIk88lXUwTXwLDeJoMscQ8KVyzobyjt
         +1GICJSD4a/hkBacPvpVRUurnuNFvvETsiACnXeowGkg8epq3ZXUbmrjSQ/x+COZzqlz
         WV7P35iVq32D63qCb5+xx7J1xXxl1VxC1xhvXiDtGXEIVk1oOOXUxgeAEI28i8ZBs8qj
         BKw7ySX/+WUYE6gHRl4kOYRGl4Fr8V8QYipszjYq2RXOZchwe+Q1sXyPAP5gd6BSWueu
         AbfKD4MFbHhgueoaUvrCZR1ayvEKdy7tC5mjslPddiYIF/V6mxbBWBS8GgcU0ZQgci3E
         tmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787559522; x=1788164322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RksCCBXE0XrMrTynxzNYUq/eoGnOg17BpZWifRjpeC4=;
        b=WDKWXf72b4YMqjZWQpLLN57IQakDFlT5JCYC5KK3NaFaNt/iW1aEy7HN3SIRJIJasn
         tU1GP71mLbNtuqaVXq89Hm85Z50TVtJHnicAuTSUw+IJP/ktv4yS6QIsoRy8s+/k9nhy
         YIQp5EI0rrWpOt0FtHnYWANRnJOpYoCEWQfU2xrs2D4fpPKTfOVLLQQKEa3+sMKJy97Y
         KXFxFNgFUwDlgtwMo311zG49lHYgqS5ETkfetL1+NHedhVpz8bZJazYpL+Bz6RxAifjb
         uAxL0LHYqybB6C6CfOIgRDj24oIN6+VzkJtOm9S1znjaxIhtKBYBUFqCYNa1HWBDTtoK
         5viw==
X-Forwarded-Encrypted: i=1; AHgh+Rrs0w4Yb2HNio5Wv9+Cl6HGII0Yr6mZ/g7isHjgG223Sjncxdoka+EezGNootKHKngzu5CxE1c=@vger.kernel.org
X-Gm-Message-State: AFuF++lkILyB750AiIv412FQAExYg59eiweIoRymzAvejU8P2MBFQ+Y4
	wEzN3ybomPD20lqtbtZ0uHmCjJ60J6GD/ZEUXYpN4gTlyt/l0Nb8/xln
X-Gm-Gg: AR+sD10P6KahoYdMtnU/HXgo/zr6kIOmb5If7Xw4gWj8t5ZSAxzGQfLa0qJUB0nCsbt
	vmNpzulEf9136BpHGJOO0CL6sbj3iDKY/Tr+PePtZperP3vdekRFeqyfRSTgE93QAoaNwJMuRBa
	shUJZpj/1u+uJrV1BPJgKO/36AztbnKCfN68v7dYLG0yZaQArfxBvLbm/fAmG5d4hoEesGb+js5
	AxOuUaKzjECtuBe7UX/96koQicQDglX3oIicn6FNgPgSx9aacCFJLR2K6d8Nvcfvn00taJs7X/A
	TpZhXA/z/S3JcQsdYACGrbd9V4hQpNWb744NW9hTS/DJkIBTig5ddFg6OTMZrR6yERGlvu6Rrl0
	qZ1fO556iZuKIOu+0D4loX5gOo3T5LFrN4LQN8Wd/1yNHLrr/QZ/nWMdtZsf33MwrgZ4Lybf5tn
	a7xokYrTYxvMb2Izs5zsGJamA0y5IMaRUmz+QUGb2QWHffQxoNyCPfhygKTXfpsSTwUICLPzPuu
	Wb+VVMOaJubvQaO9cRp8eQz/qkQMKpaVxuAvto=
X-Received: by 2002:a17:90b:164a:b0:390:b41a:b92a with SMTP id 98e67ed59e1d1-395deeaa2dfmr28096604a91.4.1787559522156;
        Mon, 24 Aug 2026 01:18:42 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e4999471sm9079775a91.8.2026.08.24.01.18.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 01:18:41 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Jun Yang <junvyyang@tencent.com>
Subject: [PATCH net v4 0/2] sctp: handle wrapped and duplicate RECONF responses
Date: Mon, 24 Aug 2026 16:18:18 +0800
Message-ID: <20260824081832.98717-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

Fix response sequence zero lookup first, then make RECONF response
handling idempotent with an outstanding-request bitmask.

Jun Yang (2):
  sctp: distinguish sequence zero from wildcard in reconf lookup
  sctp: fix stream->outcnt underflow on duplicate RECONF responses

 include/net/sctp/structs.h |  2 +-
 net/sctp/stream.c          | 46 ++++++++++++++++++++++++++------------
 2 files changed, 33 insertions(+), 15 deletions(-)

---
Changes since v3:
 - Restore the SCTP_STRRESET_SET/CLEAR/TEST() helpers.

v2: https://lore.kernel.org/netdev/20260804113100.37840-1-juny24602@gmail.com/
--
2.55.0
