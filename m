Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334073;
	b=ld7JdzSy0vkhislG4YZcntLX+8aOglb+8kSFar3Qapa9Bt4sqd2Ei+a3jisZmlvLSAYo
	 nooV8grrFmKDsenN8SAofvEw4rbok56Nm1Tr7ZKHuWvOgsGoexUKlxKQg+cIQ4GvKtVK5
	 hEiitbVNGTPFKGMm0InFs7pFjcyY6D9GUlopppHos6Clonq9EgN6khQP7qfwexKMpYBkz
	 sFY7MtmjDacYFaE/DMpQhCR8WS68Mne4slweuQBDbH65kL691OaIVQMtD1O4JcfTOTHdy
	 X7h+EiHzxn56LV7azld2hdKOn2KGvatf2pbPFrPI76rHWYzupTRz+RqizdyipNnKZIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334073;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NZFxhxetntJ4eJV30GVWChY5vhsarJj0j6bepxHT7hE=;
	b=r0KNlq+jigCU27HISW1TA18DEnCs4mDD4ScdY843rskGGwUTMMo7QId2N88GRxDCYR2u
	 9Aq3qCh96NQxaAsdyh4Z5mdwX7Ap1cI6WKQ8aHKIowd6qkEdshpySNZFjKcXlxKst5kiJ
	 jJbitIGj7Qm9fCnRMKmVUCRGe7X2oj1GcsCX1zHeyxgRKNoH93b9SVN7u9Ue5g1M89csp
	 GjM51J5EznqadoVbMosq6v3MzXU3zBXYfmhxZAL/Nog7b11Ks9FdESXS6angSgkh1j/VO
	 qOuauSPRQcH4AwuXBVWIB2gWNJDd9qWKlf5gGiS1AqS+BfQKu9wVmbppFeWG1xwypKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Cib7M9RO;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278FC606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 278FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=Cib7M9RO
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6d290b10a35so102762eaf.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1793334072; x=1793938872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NZFxhxetntJ4eJV30GVWChY5vhsarJj0j6bepxHT7hE=;
        b=Cib7M9ROjjLXZ3Um+4q0PaXIHuP48lDm8G9SQnQIStFIb7n0L7DduWd5JL7qHKgguB
         LwvOyZ0U9h4+3/gcSqnTmJ6uEGbU/HDoMG0tC2dlYBTxljc41dljju0e0MSR4dH9coFT
         FRY0+RTE1CC2znYpjXqKuxpSgTvZ3hi8iacGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334072; x=1793938872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZFxhxetntJ4eJV30GVWChY5vhsarJj0j6bepxHT7hE=;
        b=i5Gbb60QQdbKnN3sUPbLlpPngU/7SVZWVnO91IK1tTN6H7H9PAKQH03irhxrxXf299
         vF+DlD5/ex3oVteWAqI/z8TqjE6s64kMNfVnvRzwUQeloyHIA0d+zaDHp/ECX/jGsFea
         7btBlvA8QWhtzPpTUYYXJNqU/KOFgJG3SRPAD59ksmq+lNhKy3BozfmBdUefsKK3lUsL
         S45HUnBmEfTOM10dyyhdX3BThcPjEqJq12lc/oGej/mcN8hXknMeJ0rEgvIZS6XkCcBf
         1Aur88odMLith0fsa8gU8yiNwY+gfunjYDC3E+D7cPlqNwv0ROiFD6aTc6cp8n4jQwaH
         4qjw==
X-Forwarded-Encrypted: i=1; AKwUvBy8wLZBsan3kBLdeAnhKFUD8dMbYjTrt9WhZ4glpr+SZ8m6XxuSh0ZtTDL8mgnJ0wOyjM+aLx0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIIwlEFH0azwHsw46Uhf8yG7OOq/Ga0HL0uQhAHjknoI5YjxVEg
	q99/zcXYWc0l8BiW0wwkSIF7C1OVFga98LbdMDKNb+6AqSpKdv/Kj53F8NkDDSJnJKw=
X-Gm-Gg: AYBFou2y0MAYh0leATlKUFxbh1MNPhmBgw2G5ff7R0Jer3qXKhsEA7eyqLuoIZDlBkQ
	r8q35DlYhnlATGtISS1XpVAb7eLVE3cYJ1s8CXGgS0XSPP9fHLfZPh8rwQPnGO9u2hvhhd0pW/c
	Deo0Lix2DnfkhCS9WlM7MGhqxKDLMdSidLzexalF7ZqQ6sHo0KJY413Lev4Modn7I3gsptmhZGz
	Yq05PZoUhtAVsXVb4dWxWWVV+G2juckBW30bCcEERYY88VHIwrw5aCG6LSvazlxoCBfLUYso96P
	PTReWYWZghw15hwS+vRtHw8dn45nyXrNyjKhpTOejHqOOTmbFSKawlsRo1yL+I091W+lbhylfdZ
	LkKPkTQpU5RMUUI8eyD0jD2z3FDIwFH/2KxuqSbEhSxnPN+ITfT0qlCtGXgP85xPIr3dJ7PTS6X
	XJ8ROEhcCPduBDcsK2zKxeqXVcjrPF7IeHDJsKtDs63i+2b0eTDtnlTaYsqeBBRn0xMZ03tS8j8
	u0ZW4U5/QL6aeKgn8LyhCHcTBH9DWGN+QlgjDPGVfwxysKab4DupXb7AwaxqPei4lBRev5DdsRn
	d//mHSIKjnofRbxizRWM6jsn8hxL5g4QzAqpK9IhVxpN1jMhTSTw9a5ms7LvTj1AIQVrZABG6UT
	Ep6NaoVshnGRz/Cvw6qgtz6wUuW3Xjw==
X-Received: by 2002:a05:6820:7093:20b0:708:d862:7b6f with SMTP id 006d021491bc7-714f24ea1a3mr577516eaf.6.1793334072102;
        Thu, 29 Oct 2026 21:21:12 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a90af650a1sm768615fac.15.2026.10.29.21.21.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 21:21:11 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: rds-devel@oss.oracle.com
Cc: Allison Henderson <achender@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	outbounddisclosures@openai.com
Subject: [PATCH] net/rds: Do not unpin a page after a failed atomic pin
Date: Thu, 29 Oct 2026 21:21:10 -0700
Message-ID: <20261030042110.73571-1-kylebot@openai.com>
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
This can consume another subsystem's pin and allow the page to be
freed while it is still in use.

Clear page when rds_pin_pages() does not return one. The error path
continues to release the page on errors after a successful pin, and
successful requests retain their existing ownership and behavior. All
four RDS atomic ancillary operations share this path.

Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
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

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0
