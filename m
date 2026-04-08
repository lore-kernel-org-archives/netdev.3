Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F333D1706
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666323; cv=none; b=pGrvWJg7sBMipz8gWHkgeRITv/IypXIH0vN1f5KuvARkylpt213NcucwY5BzFjBpgDTa3x9VVN0jna/uT2in/C1ruSYovxFBEnGyFZi9EkjrtCirr/l52xD9wBxo60wystSp37OIg7lWv1ExOLiVlmE5wYa1lQlwsE7KdUJwjMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666323; c=relaxed/simple;
	bh=cXXZUSL1smmZFhqdpYGc7t+gweeQOEmqzUR6awCPVQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGxVQ2j5F3ALiE79XKsBVhExmMKWsSf5THfzWFiEF/xUZM+ANbFxJ6ESerPeqHvacS9NX4AaW+bT/tC/3WHqy0Cy22zEx85ns+2zE05m7Tn/5Kib0aTzaep1f1fg/CEAac/ShFqGx17nlrBUj2DKJtP7DHXzbdABB0svZfzZLtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fVLuiOLT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PbYf5VqI; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fVLuiOLT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PbYf5VqI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 69108EC01BD;
	Wed,  8 Apr 2026 12:38:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 08 Apr 2026 12:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1775666321; x=
	1775752721; bh=H+j+s611clEmcSSNSg+t+CUd42NfASjomiawft8fqSI=; b=f
	VLuiOLTUej2m0DM0LSk0neoTXwa0kNIjl6Qgs9LUpkGhAs/kL66WpH5VM8+G+QBC
	PJUa/Vssr2CyVqxX+8QslC2PxHkl5elEsly4rTl4hEn775z3FF5J1Cd7zOQARM9s
	MXYWNBM7fongQtQ+aU87wzByfi7Z/yrG1D2DlSortyar48Yc/7zduxlBHewS3qXg
	KFHHTU28AkIJt8o4uuIjAfPRQfmyRK0wh+JglUYZaZR9nanesmEcsXbbpKRvryvJ
	UwDFUKBfbOw47FduPC8yfogvCQpLLIbAir7i/C/TiMTkFtwwB3I7PQGmRGu6t0QS
	KzZjaLzUWyiebYJlFnQIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1775666321; x=1775752721; bh=H
	+j+s611clEmcSSNSg+t+CUd42NfASjomiawft8fqSI=; b=PbYf5VqINtm11KvDY
	cYTALVJtgWdN7Rbjqwlc6oQAS2TQb74GdgBwXuZYQENs5TloQVejmtf8/MCiA+qV
	H5Nqq9Vm7k/f3ZFTWQXLvkXeNsZW0Iy2F3Tn0DqgPuES8HIf1xU7Ug64a6XJvS17
	lrasd7nVqdWnahRG7LL3pOzrsRCmbhJlelqwVergmF/EC7rEup5ZqL1no5qm0v8x
	wG7voP0ZcWNzgyVWu0k/QHb4aAWaDcyvarQ7ttO0OKC9JaSSkdcAqUAtaPb8UTGS
	T6dMmsBrglPL21VjBqwYHnmJ9R+/a1I0KLV3HkSN1e12utzNc6K3z0ZgWV3Fqb6V
	J8aYA==
X-ME-Sender: <xms:kYTWabR08BXm6jqux02WEVI3GXIXfk9DL_clxTDmBd4n_N19fMtq2A>
    <xme:kYTWaSwIv-ZP_qX-10mzT-EBtz-ehwRItMN1IOqSudVUHG90gERPQAT7lXKZaqYzz
    BX5z7tbV7mqSirlFxS7b1nv5unyEFN9z0vD8H_P0bwnNlYT4rGv9Pg>
X-ME-Received: <xmr:kYTWaef4hsXdUWsUsD4tazQAmk5i5pvyxHU-A9W9C_dBwRwcFZgkQjiFWMLgTVn0ZnpQQTdx1ypauvo5a4tqMQi_7BW06Y0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhurghnlhhuucfjvghrrhgvrhhouceojhhurghnlhhusehfrghs
    thhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhepgeeiieegudejfedvheehjedutd
    fgffekgffguedvhfehkedtvdekkeehkeefheevnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepjhhurghnlhhusehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhurghnlhhuse
    hfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:kYTWaWLN5UxBG_EmQsqbpJ6r_YB17d7vW785EmOCYlyXisZxTI-0uw>
    <xmx:kYTWaXH8fHBLwbaZWt1vrIX6fgF3LdyQydfZBVs-SUOLgIXaxH9uYQ>
    <xmx:kYTWaYrtyIPUeiJs3RF7M_94PmfKOSpZTHDOEHRgOPucYl5O5et5Jg>
    <xmx:kYTWaYTSwyTlk5OvDoW9FdT_9WAh0YCb_s6YJYVcjW84y5w4YTmINg>
    <xmx:kYTWaersQZDdIVeJA3ZfSjX45dkt8UTF_QWIdplnnXjsf-x21W76b3T3>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 12:38:41 -0400 (EDT)
From: Juanlu Herrero <juanlu@fastmail.com>
To: netdev@vger.kernel.org
Cc: Juanlu Herrero <juanlu@fastmail.com>
Subject: [PATCH 3/5] selftests: net: remove unused variable in process_recvzc()
Date: Wed,  8 Apr 2026 11:38:14 -0500
Message-ID: <20260408163816.2760-4-juanlu@fastmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408163816.2760-1-juanlu@fastmail.com>
References: <20260408163816.2760-1-juanlu@fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused `sqe` variable in preparation for multiqueue
rss selftest changes to process_recvzc() in the following
commit.

Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index de2eea78a5b6..6185c855b85c 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -276,7 +276,6 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
 	unsigned rq_mask = rq_ring.ring_entries - 1;
 	struct io_uring_zcrx_cqe *rcqe;
 	struct io_uring_zcrx_rqe *rqe;
-	struct io_uring_sqe *sqe;
 	uint64_t mask;
 	char *data;
 	ssize_t n;
-- 
2.53.0

