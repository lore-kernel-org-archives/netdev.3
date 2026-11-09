Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794221578;
	b=5spaIjOVaLxv2eN5VB7ufdqeET8JINud/QHkeV6MGXojXXdbliBJ40hxQGRR/Ym9U5ag
	 ohsIhfdywYIZOTtLejlZ6ehgRnl1pjAPVz+LAyk3/ywMXA+fPqmj0I1UVMBqSkK2JQsrH
	 oTyzyHCWRmAzSFwxqaFXmtIs9Z84ttGDhjNjHlaDxLHoXM4dZ44HLb2iFNpOdvyQTLckW
	 rM8TvKbP7NMCWwUPenggwT2Nrmk3EBMerG0X8J6cOVg0fOxN/OHw7ooLtMvhZKOe0r0+E
	 GJD6pqaqN4TnPgqTIfmyznmR/QwD3h5XNwGd/uLHUsODm76A80SAzJ95Cxrvd3CEh3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794221578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1zQyQfd7Pg+TzVSNkwUE2q6hgZHqlG+eVtCLMd8G0fQ=;
	b=4dM1vc4Bzzq4JID6wC8JBEDSwXUMyfNv/J4mjaJgJsSrw2/xEoyFxwu/F+TgvQhTVM3e
	 55Hg7MTNcd3aBZTD1m0YFZ1CKN/oIJdt9ooqVyeVy8E1gJoiwflYuJIcQrMgwxomGoAM0
	 cySCuAlfubn2q7zI88zp7iITuzs4uA/63pP6/Ih8j3TVhX6agNfVZipx//5fZLJHra8Bv
	 hOnrOj4RIxgCDNLcgXqfQ6i5Nmk9+7IEOhlt9oTi/jvbKH8gF3F/IyzIIVc2l065wivvK
	 gxXCcBii6jhyKFGpQnUA8NF+iL174qHeDrvnXUkNr5alLs7I1Jmu9kY/OH5kCVLjj2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=is.s.u-tokyo.ac.jp;
	spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp;
	dkim=pass header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=mrbtu23g;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983EE606A322
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 10:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 983EE606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ecc.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=is.s.u-tokyo.ac.jp header.i=@is.s.u-tokyo.ac.jp header.a=rsa-sha256 header.s=google header.b=mrbtu23g
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1ae18eb9b69so701199c88.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 02:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=is.s.u-tokyo.ac.jp; s=google; t=1794221576; x=1794826376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1zQyQfd7Pg+TzVSNkwUE2q6hgZHqlG+eVtCLMd8G0fQ=;
        b=mrbtu23gmpxDhvj9lIuLzVAcy9ggR/dACUCylfJdr5HPlW7rbfwu8g7y6HvT5aCGLd
         EVv2Mq/Uqm8mrnmUcoSZkM7in1s4s9q47VGjkIfbLhcbJYpCrA4mGcVVo4vjd6fnrpce
         UHC4Tncg/hnG3BZSBbRALWFbLbTOd5B4RyFy/BtFzoP2k6xjKNQPcnIQGvL5oSkXbtRP
         ZMpCCx8vTsm1yg5tyx2DkAtTUA5EkLqkb4o9KChWxZRoLw09fDagWW5/mPV4ADn1VGze
         tCgtC+9kVwqxgIGUDbEDBH1BfwFoCaYdI6yvrPtaOODI8fZmLx9X8zCKl8K0pcOSYsyn
         tQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794221576; x=1794826376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1zQyQfd7Pg+TzVSNkwUE2q6hgZHqlG+eVtCLMd8G0fQ=;
        b=Ci3Eh3/PES7nE7wIinupQ3PJr7KTxsDmpF49BqK7j9fT+BqQdR/IM+EEMo/2MmSw1R
         N+R9+0ZaoXBecCIyUw78tPWdnHWZaQGrmFWXrh2hRvpFQP4zAriUgNBV9tCY5JgeO1wF
         wYKVhOOEwrbzcRJr/lXW08Z2TmTuX6nX+CucmYgL5S/5L9EixvTyl1pAm1pGE03Lq6DE
         YxIWRalSHoJgqXfRpyiFGvEgrbY/DBQIDVB2yAvgyTFOHL/1vZmw81I/be86qGazvPdH
         skXjAESRQ+Aw7qyhr7wxxk/tKbecJliXYVM2m5tCErGxEBaLw+QtLQ1W1OqA+R/qQH0o
         smEA==
X-Forwarded-Encrypted: i=1; AL+hErHJF0o4UYRxRckK3wvNZAoitxit+4Z7aKff3tAR/IWA1lCap+lvIRyn2y3F/nJpbv92TVk/0JA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PbQZD3/YBEE0TqO5OZEE1aMF/5HeQso+KZXsMdT4ZX4syEJ36
	vtwxAQqUCHvnvuTap2yiPXEv8mz+ipoVBteViJjLta8mkBxetvLKHtojAI+8oXn9vA==
X-Gm-Gg: AYBFou3ab4xmSAjd2q3wbCqgkRTDVIv73T0++NQeLRqflrSQOoUmsEuwOSkAPYO3kkU
	SXmwOyXfuwbycwJrnjYqpVV59bvzp9H0DYnffU9TfVWmnn8SM2hrf8BW/iQwwpm02b4IJVfgqcM
	VP3cXjPq2YsU3jvqYOpLyazzRy3lfuoKDnnpzKkkQMmSe+pi2l6unE8N5DbwwVXh2/rpryZB0rF
	W3du6NuWGdGp74YbTBEUPTN+W5b+5h4Rjbf3iC9sQFmgP711yzc4801WR5xqgTmRdS/gk83duKo
	Tohno6yn49YM9VBVaU2yKH5cVXlcw34IKkjs6V6+CHJv0IpSgrzQaLMnyWXSAt+gxHHHp4EUesq
	gyLyIoPcQL0qBEIUFpTln09V21UR4dnEWVTFDwtBTt/0ZeEoNa4Frv9Nl0SDt7ZM3frYI6uXBzD
	TDYJQOMfZNm50FKZ4sS/fzDP4MFS6VKN95CzKQU1lIcBkFjbLQLL5G5gv3O5KBHn89YCTKPpYyz
	OvruVEtZbxgYIojYoQsnHErNAkkKG28BTXaZVgO8VB5Hhm7AmeP3p7HyTiEU+vamCrw1dQNEXJA
	KlMFi8Wzx5ghvelyUW12YIlbYkYKDgq5O1falQ==
X-Received: by 2002:a05:701b:464b:b0:1b2:6855:99ac with SMTP id a92af1059eb24-1b39ff1d913mr5044256c88.46.1794221576448;
        Mon, 09 Nov 2026 02:52:56 -0800 (PST)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375726fd1sm12228744c88.14.2026.11.09.02.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:52:56 -0800 (PST)
From: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lianjie Wang <lian@is.s.u-tokyo.ac.jp>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomas Bortoli <tomasbortoli@gmail.com>,
	Chirantan Ekbote <chirantan@chromium.org>,
	Greg Kurz <groug@kaod.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takahiro Shinagawa <shina@is.s.u-tokyo.ac.jp>
Subject: [PATCH 0/5] 9p: bound zero-copy error replies and keep flushed requests until the device returns them
Date: Mon,  9 Nov 2026 19:52:46 +0900
Message-ID: <20261109105251.2545764-1-lian@is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.56.0
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

This series fixes memory errors caused by a misbehaving virtio-9p device
in zero-copy requests and in the flush of an interrupted request. A
correct device can also cause a double put, which is fixed in patch 3. A
zero-copy write interrupted by a fatal signal can also overwrite a later
write to the same file, which is fixed in patch 4.

The patches were tested with QEMU modified to send the malformed or slow
replies.

Lianjie Wang (5):
  9p/virtio: clamp the reply size of a zero-copy request
  9p: ignore a zero-copy reply that arrives after a fatal signal
  9p/virtio: keep a request until the device returns it
  9p: take the tag of a flushed request from the request
  9p/virtio: keep zero-copy buffers until the device returns them

 include/net/9p/client.h |   6 ++
 net/9p/client.c         |  19 +++---
 net/9p/trans_virtio.c   | 130 ++++++++++++++++++++++++++++------------
 3 files changed, 106 insertions(+), 49 deletions(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.56.0

