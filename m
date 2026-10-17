Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C236AB54
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200427; cv=none; b=gdQNspBHxEpxu/PRPQfH9kjaOJZrJe9cUJubSiyW3uULSNFnr5wVqJ/1q2p9YDkXDHCQzNCzMyLQ7Tvx5qvC4q14p7IyMR5R9YB6DtnMj5+ri3UKq+phEfoMLuN/b4H/eZ+bsHU6O8Ftry1p1yPb5N/OdAMyNo/oe03z97TLwrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200427; c=relaxed/simple;
	bh=zgAncej2VMKtRTstMEpHtZxGPB+wKyq/+2Fwhv76YLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1PuSg+cTU3uwsGYMhkf8EdTc9S/MqSWQCaDGYor05imc0vwpkpJE0O5ukkE6ZnmfxLN9USW/cuiaGH2hLfTdplx6oxIg7VEdYsybEisaIP7gkaCR9yKD1n9QGN6EQ90e9I1sR54yVbUX28jRiAlXghj+GgGMAWWe9tkzILZP8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJy0ZHQy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJy0ZHQy"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac5b090d16so362427a91.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 18:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200426; x=1792805226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2c71ftOjOMZN/elNUQWQLQS3OBsPaj6ABPEs543IIw4=;
        b=mJy0ZHQyiUPlmuo4i8/UDH25JlP7UnzsDt8lHJHCa9ewvKeQaj9ywFRsLtAVo51bYt
         q0XSvqIcg0h3KUq/N7qmJq8QHQu5+AoSu9X2gQ9mU18FJLd04bvgLzDqoEvbnJ+nX9n/
         P4aS7a3hDum12WUylsYunRW6MV2hKzuhg2aWXL/0/aCo379mflIabPGpQuPkP1fRkf3n
         QnkJaEMUfor4ICb59K3YTXkwMmXUKNcH2//eTmrZ1Rd23LNwPzJ12L9+zK/5SR2L4Ngi
         y6Co7RbvoGqX3Yfwo7OdwFnL21VXPzydjhTvQLvep9GxNPj1b4l833RVDsQTaZsb46lD
         Npgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200426; x=1792805226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2c71ftOjOMZN/elNUQWQLQS3OBsPaj6ABPEs543IIw4=;
        b=ab523P9h1i4x6hEzyN/V+oKBJP1GXhQjWJkfm2tSTYk0TBIrqfTczYcwgMQJwurka1
         0H0MQfbpDs1g65UgGMO9C17p+EPtfLtDgx6f3aJwuF5QC2Jt2uVAxweX/PTG7Dg759y0
         lnqvGvqXybpumwTQV8GeVAVBjpVMUF+V42bFnlUD5W65On6yyWTFxPfBW9Ee9WXEhC4/
         BKgNsu7oQcYPnzzVBD83l2pw0Mcd79/wWpwY5W3VcCOeq/LzimH4pn3u61cj1MttIYu8
         JNIT90v16Q/jX0Cc0qYjJ2Fw9UgDa4iqY1BtK1hbqhs3TzZ0VpH6WFraf9e7KvFtwcmR
         meUQ==
X-Forwarded-Encrypted: i=1; AKwUvByobCffVMinYNmpdREnMohW6tHNsitGzMb9D92BCiQotN0TbZ5E/JeErTYT1nvkELVKzPL4hdw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVc+qpLzMjJUl4qmcqZcw4SoABDLc9qdDsgVkIFGhTBwvew1bM
	A5P3KGVsxOo5mwq0KX/tKdU8YGvww4A3Z2rx3rFK4SnSgy9tp2w1FcQZ
X-Gm-Gg: AYBFou1KhLMKVkCwx74+HWoF//ru5G+25iXNoNwryQWC1ORTThhk0eCqjUbSG/WnfDl
	Bp4xfKjNelQKsD4gK5dc93ZN8enYZaEEb1Hdpw+MRhKxRfTtNbMrDkoaWeiQhsxoaUneilPdS3U
	lhFFTeaRCvKXwbu0Hz7gf0+D/Q9Mld4QR7XPcX8XFhf/8tqHDrCQCIWvgP0lGoojWkHy+KGIlLR
	S4rCwPRkBSIoiYB+KB5CcvmSHdpdfKzf1mLtBHROJbfufaIUSigNLJJGwv9p7Gdmy47vzuF1gZl
	c5WXLE2GCXGi9/VpTzggkQ2g+4DdNrCtj6MAqUmxbYawe5vl4Hpx1CbIVPHnds9LMZ9ileOfN9a
	UIKJEtEFkBXWAsHmaeDGaf3EMNVUar9g/MHZxVVH+JSISFXFIRy9ypAEYFuYJ0T1Gq6byfZSowJ
	NWCKHzGF7q19SQbeLjKWAXZb6l8BP4vtJ7yVe/klPA8zJUiI/ipsI5Zj05IomcsEsH0K2/UOcWa
	tTV+4+VgUoK5tgx9MYh/D7IdBqUDrWzGiNbw8eQqWyfMBxPHL3BCyazrqeBHNQUG64xE8z9lvdr
	uCoLyTvO2C2znFYiOZhuNNJVnDPjzD2L1j0h8WwkC9Q=
X-Received: by 2002:a17:90b:1d0c:b0:3a0:cca0:4a8c with SMTP id 98e67ed59e1d1-3aceefbd794mr786287a91.7.1792200425825;
        Fri, 16 Oct 2026 18:27:05 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc38b457esm6730982a91.0.2026.10.16.18.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:27:05 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 15/38] bpf: Fix NULL deref in the sk_storage map iterator
Date: Sat, 17 Oct 2026 01:24:28 +0000
Message-ID: <20261017012451.364800-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_sk_storage_map_seq_find_next() hands out an element only if its
local_storage pointer is set. __bpf_sk_storage_map_seq_show() then reads
the pointer a second time and dereferences it without a test.

Since bpf_local_storage_destroy() unlinks the elements with
bpf_selem_unlink_nofail(), the pointer is reset to NULL when the socket
which owns the element is destroyed, so it can change between the two
reads. Reading the iterator while sockets with an element in the map are
closed ends in a NULL pointer dereference. The sockets need not belong to
the reader: where a program gives every new socket an element, an
unprivileged user who opens and closes sockets is enough.

Skip such an element, as the TCP and UDP iterators skip a socket which
has been unhashed.

Fixes: 0be08389c7f2 ("bpf: Switch to bpf_selem_unlink_nofail in bpf_local_storage_{map_free, destroy}")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/bpf_sk_storage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index b5349bec5695..aea67b446c7c 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -813,6 +813,9 @@ static int __bpf_sk_storage_map_seq_show(struct seq_file *seq,
 		ctx.map = info->map;
 		if (selem) {
 			sk_storage = rcu_dereference(selem->local_storage);
+			/* reset since ->next() looked: the socket goes away */
+			if (!sk_storage)
+				return SEQ_SKIP;
 			ctx.sk = sk_storage->owner;
 			ctx.value = SDATA(selem)->data;
 		}
-- 
2.55.0

