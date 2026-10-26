Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.111.35.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009632;
	b=C9yRtPtwkpC2U6w3xGgP0IfvpIZ/Qf1Lq74w9W4+i/qTE3ZLC4le9GIAu8szRMb8bix1
	 MlonTJyKFfYzGdkHks0ZhDQ502gGvpRd2PFxQJbGIoB9bb0NX3liRUmhTFAj6rrGwy2uT
	 Qxj9AVgaOwk6cyAHTaUjkA2Pm27s9zn8mpDD2NA9xrT8T658PejlcM1B4x4VPGsxC7PBL
	 tPF1xikbt3DYUl9wKmj4Rq3h4NHy0q1+/VRPC9jnPlWanuPn24tEwOTZ8m1+/4QL2VUbu
	 wk1RyQVQIoFt50CEDrsD39n+a8uWIy//+3tmUQrXzpQqiH5d2FG+d2wbS/nFVOu4xOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009632;
	h=DMARC-Filter:X-Originating-IP:Received:DKIM-Signature:X-Session-ID:
	 X-Originating-IP:X-Works-Send-Opt:X-Works-Smtp-Source:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KHYNaLMhPcP0oroUjwYLBe/Xff4NpZms5BYnQSaUeFs=;
	b=qIZQoCwTW4riCMWz/bXGRcS7RC46pD9p7NPE8QBT/jed+jyT7K0vjVUIFdTxBiWCbRZw
	 znWbkSyvGb5mzCXQv0iO/r7OYseIYufC6hi4HmvuuZSH8Ujqj+usnv27yad7rqPchNyTg
	 wtE3eUepu3I5ekrlB66moT9O8bYHy0PK9hzEqQj4pKMbma4uDTfYlKjhx9vC+FxJDLAZ7
	 EEVHkuJuI2U9RDfmLLwcqzdoncFqCHePulpXaFijrrSnhl/LHsPQBIDiOF/5Gj83Tn3Oj
	 a2pyt2R5yB7zoZ5QLa9MWhg1BNn9MNrz4LSsnmFcegO2db7l5/QciT3lubhiuA2Jnvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=navercorp.com;
	spf=pass smtp.mailfrom=navercorp.com;
	arc=none smtp.remote-ip=114.111.35.57
Received: from cvsmtppost01.nmdf.navercorp.com (cvsmtppost01.nmdf.navercorp.com [114.111.35.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47785606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47785606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navercorp.com
Received: from kr0s-hmac-real-1 ([10.180.30.112])
  by cvsmtppost01.nmdf.navercorp.com with ESMTP id Nmfo1OpeRGSFnBonJN1+ZQ
  for <netdev@vger.kernel.org>;
  Mon, 26 Oct 2026 10:13:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=navercorp.com;
	s=s20171120; t=1793009619;
	bh=URLrTE/7n+/omBViu5VvD5nXJWdvITooqgzhIFLjUbQ=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=VglYu2CtbjKJRgU/l5oLc1exj0+YmkpmBywnMfwXJj4mywmxUNl1Rt5wqd7QOslpw
	 p0ctOhWa2kpqg5P1BhjMqN21fuyyW95iy2p7X2cglC11HRrUz9z+RcSOzYjKsF37OX
	 3GNVlvDQhxresy7dzyt1NhPF7ILj8VfaeAfLp9F38r/SgQfu5URKx0ipJH+cN/Im9s
	 so00FpNzfrCzJNrMpmlmKlhSuomsxuBE1BLf0VqAnLZQwN8FoHD3JZBOzhiTiHG1tt
	 rPdwd/bKYEwZaqq1L+exjiDhJSUErkymgp/eZmFFCEjL0fJySsHF5oVXsB8j3ETiQA
	 beVd6JWzikayg==
X-Session-ID: qo9U7QGhQySfr0bx3zSMnw
X-Works-Send-Opt: TPKwjAumKAumKAbZjAgmKqKXKoJYFHmXjHwYjAg=
X-Works-Smtp-Source: AqnXaxUlFqJZ+Hm/KxUX+6E=
Received: from localhost.localdomain ([10.25.64.175])
  by cvnsmtp02.nmdf.navercorp.com with ESMTP id qo9U7QGhQySfr0bx3zSMnw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Mon, 26 Oct 2026 10:13:38 -0000
From: Gyutae Bae <gyutae.opensource@navercorp.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Minsu Jeon <minsu.jeon@navercorp.com>,
	Jonghyeon Kim <jong-hyeon.kim@navercorp.com>,
	Siwan Kim <siwan.kim@navercorp.com>,
	Gyutae Bae <gyutae.bae@navercorp.com>
Subject: Backport request: fq_codel stale-state fix (815980fe6dbb)
Date: Mon, 26 Oct 2026 19:13:37 +0900
Message-Id: <20261026101337.22494-1-gyutae.opensource@navercorp.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

Hi,

Please backport the following upstream commit to 5.10.y, 5.15.y,
6.1.y, 6.6.y, 6.12.y and 6.18.y:

  815980fe6dbb01ad4007e8b260a45617f598b76d
  net_sched: codel: fix stale state for empty flows in fq_codel

This fixes stale CoDel state that causes packet drops in sparse
flows.  When a flow's queue becomes empty, first_above_time is not
reset, so a later packet can be dropped based on the old timestamp.

We have encountered this in production on 5.15 nodes using the default
mq + fq_codel setup, with steady qdisc drops on lightly loaded links.
A kprobe on the fq_codel drop path showed that every drop we traced
occurred with first_above_time set more than one second earlier.
Applying the fix as a livepatch on a 5.15 node reduced its drops from
about 50 per minute to zero.  We also confirmed that the fix eliminated
these drops in tests that reproduced the issue on 5.15.92 and 6.12.48.

The fix adds one line to include/net/codel_impl.h.  It applies cleanly
to v5.10.272, v5.15.223, v6.1.190, v6.6.160, v6.12.114 and v6.18.58.
Both commits identified by the Fixes: tags are present in all six
longterm trees.

The commit was merged in v7.0 without a Cc: stable tag and was
backported to 6.19.11 as 86b81a5c24ad.  It is already included in
7.2.y, but is still missing from the longterm trees listed above.

Thanks,
Gyutae Bae
