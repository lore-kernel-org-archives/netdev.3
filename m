Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794025087;
	b=dqToaY2bXxHz7wowL1v02shbtyhTyyLjACfs+PGSkA+dD7RvfMQCe08pAtrNDYtY9JO4
	 FYuJVxONmMmXBOzt/XjAca2zHRp4q27WOmg+2jhGIfDGMBS6YKfJzymMot649x6cQE9dU
	 9Q7gYdWdliE0BwId5SHdCUHgLrxsrZAJIZbdXXbJOSmIG9z7tbXm2/oNk/MtXJJSQVFOV
	 Gh6EWAQ/5RgyLjubbEFH6GNeApyiM/yhB1199CHd/MH4aYAH9WF8v8jCLIlSkUpIW2sLi
	 OHWGzceKH1VRMLqJ+wwc8IPUVha4Y9yUvwzNjmGMFVnJmRfL5aZ80Gne5nGpC8Wn0dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794025087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cuN/Wu6kktf8GRN0frnHoHZPEmUKd7TSmOYwdClsOmA=;
	b=SBFl0VQvg2RUyg/awU/CWqv+WxqvQ9XrAIIkF+tmM91iUcj/aB+yiCst5T37QHOiXPVx
	 r/Z7IEEq8RFvuwdenVSDaNhT8Her/maUuLCbTBLicE/sT6AjdV6eGyE67qD2gaqCRDTFo
	 7/2EgrcIqRhPHCreHA2j2EosZBtH6b9Hhg/s+dOpYr9JvPHWVz6005O8x1euBy/uZiCbO
	 By3mSHgBWVnZdCai/exgUxIUq3TgU3OvMF1iVWaKT9ZV53DFB0K65lEDkTYLFVetSbRJw
	 cC8tg55G68tQI0NiarX94uXvUX7Q0Fjh+vosTI0lageOQR2Cwqo1x4SGzBWlzBJI91w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b="aSOI3z/i";
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85736606A32E
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 04:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85736606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=aSOI3z/i
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-843a4ca671eso569638a34.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 20:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1794025086; x=1794629886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cuN/Wu6kktf8GRN0frnHoHZPEmUKd7TSmOYwdClsOmA=;
        b=aSOI3z/ivB3dLGUeIFD60/qU+RZHCfSGJam7HUGnDYE6+Cxb0ESvpaauNmGnAy85CX
         fWEwhNdKw1xAwlpNmPmGfbJ2wb6OWAgDmSJVVbVTd++//Kf1luBFiIOGzM700MLMS8gK
         72gMqOTQ4KOv69G1T6Uk6xESdIEbXLQUQpMzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794025086; x=1794629886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cuN/Wu6kktf8GRN0frnHoHZPEmUKd7TSmOYwdClsOmA=;
        b=wYK38UGsUSuoYMKLnmnx48obEW60vpxxjWB6+iasAwl6xdyH0TP+OnuoRcBSgsyee/
         dQzdSuDfaSufDm7SLkhW13JeDOOiwcgSXu1k0a3CIq6ZK/6J4EeY1PmVpFXG44hZs5qm
         QvLoQR1AR8wlXqP6D4t0v1rniecxJP7H3BWGX+9ksDOwzLbD0ZZXrlJ0iVhxN6zna2HI
         fAhkNHPR8MBjwBZ50UdsBHex1V9CgxlQB8wcrSoxDrNojOClMIE8tT7ZnVdxH6EEdoyT
         xaZPfDuoJMGdJP505nl9GnRlZPsphY8YjNnwoRyeRhy8q6wwOgdksCuSuE5UcyGGtc9j
         mkQg==
X-Forwarded-Encrypted: i=1; AKwUvByQvUI7WTgQ4MH9jinoVLeqCocyYciNQtXuADztwQFnqLFglAyNLHbdO7Gv/gpnXsWj8CEkME4=@vger.kernel.org
X-Gm-Message-State: APuU4Z88XlnzNAbpw4dl1JgrNXyIpg382air0j+vnMwYK34V4Sw9jHAY
	Okh7V2ZXHxkWx88/NOp5R5WaWiTF6m2WK/la5ezJmadhnjrgSoHb/PwNJdLh1IG6ZqM=
X-Gm-Gg: AYBFou21MYXJrpTCeFSlt5O/X3GLcUoz0t0PXpyIro1c6+aewl0DG2hFYPVKkQ+cEEI
	IJB76AVpvp/yVPgsupUxh/7FD5qJmsCiGyueaE1pZPm+nS3dNxzQL4tZ43DlkvWqWlgXuF3AqQ0
	yO1HK8IEWcs8gH5ozdRv2vh/dFgZXFaCGfElzCKX8YIOUvQD7riL5tvejs1L1LsibaXFL9dPPjR
	cWSzK/58dCnqfQY85LqMDn13z1LD23jfGikv4Qa/qq7kATe0tuC05WIpb9TDec59wu5hX9y/hHd
	SjLIK6iE+MySGa85RDTd9qWe3r7j61Ca9G+zxDzuM163tE4Rok26voNjXakI9LRwrPAg01hwF0j
	VGP7JYdqDVrRVDKdrT5iUjARYpzi2AGpOjftlArmjfnSXlkAzr0B8HFKVHy3N556Q6++DR2oDi6
	kS84t6w6K4Ba/G7zRrisnzB77rYhKpBKhdblDNvxbD/Q3yRkKoAjB7dYARm529UWRrcQ0/qYOW4
	+oTm7ZHfIFwIjlWi93YUPPYIE8SgCkwXm4aMN+yv6KerJ/vWcZ5+7jEkCt2g5O7wdTJRO58B5g/
	rMDR3aPqAT8iOpTCvMV3PzSs3oX8xY56tD77mnWjQGHWANpWjfe7PuEZdaEzPCz/fB+k0oZnV8G
	yCiwhB6FFXwBXIbU84w8GzkVzzFp8uw==
X-Received: by 2002:a05:6830:2315:b0:81b:bfb5:26cb with SMTP id 46e09a7af769-85f1cd702f9mr4751617a34.3.1794025086363;
        Fri, 06 Nov 2026 20:18:06 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1d951a8csm3575210a34.3.2026.11.06.20.18.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 20:18:06 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: linux-rdma@vger.kernel.org
Cc: achender@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net/rds: Do not unpin a page after a failed atomic pin
Date: Fri,  6 Nov 2026 20:18:04 -0800
Message-ID: <20261107041804.64213-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
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

rds_cmsg_atomic() assumes that a non-NULL output from rds_pin_pages()
represents a pin that it owns. However, pin_user_pages_fast() can roll
back a fast-GUP pin after racing fork() and then fail in the slow path,
for example after a concurrent mprotect(PROT_NONE). The output slot can
still contain the already-unpinned page.

The common error path calls unpin_user_page() on that stale pointer.
This can consume another subsystem's pin and allow the page to be freed
while it is still in use. A local unprivileged reproducer triggers a
KASAN use-after-free write through an io_uring registered buffer.

Clear page when rds_pin_pages() does not return one. The error path
continues to release the page on errors after a successful pin, and
successful requests retain their existing ownership and behavior. All
four RDS atomic ancillary operations share this path.

The issue was found by an LLM.

Fixes: 15133f6e67d8 ("RDS: Implement atomic operations")
Cc: stable@kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
v2: Use the net subject prefix, add Fixes and stable Cc tags, and
    include the validation results.
v1: https://lore.kernel.org/r/20261030042110.73571-1-kylebot@openai.com

I have a reproducer for this issue and can share via DM

 net/rds/rdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index 078090d292fa..71b57abb96c4 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -957,8 +957,11 @@ int rds_cmsg_atomic(struct rds_sock *rs, struct rds_message *rm,
 	}
 
 	ret = rds_pin_pages(args->local_addr, 1, &page, 1);
-	if (ret != 1)
+	if (ret != 1) {
+		/* A failed pin can leave a stale page pointer. */
+		page = NULL;
 		goto err;
+	}
 	ret = 0;
 
 	sg_set_page(rm->atomic.op_sg, page, 8, offset_in_page(args->local_addr));

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.55.0.openai.911.g06873a30d2f3

