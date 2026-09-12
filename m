Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2030B47D922
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219382; cv=none; b=Qu4Th3tqLSpQkwBhYAuLm4j1+M3mHm4aaIDrywSQcB+s8hpSqx1U9GiPU/rWq0Jl0DMmL/AOaSfnYSHSkmHyB69iUFCjx4WXGiLy5Omx99AbOK7M+sMZJDjHev7Lm+ycYHrLaqxavPf6UnPLXWb6iY9DMLw4eSbhALnK8fxaxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219382; c=relaxed/simple;
	bh=kRrS3tvJDYV+8wkX/YT9yRW+k98iVnivMItfFpaVjPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSec6WwHQWmHDuUkRpTYZGTeLjOms7bZ5Ysdd2+sh+X06UAKosVqybVxEbZrHCoO7EnJZ9LdtFQsccTprpyDOJLpUPsZEVbW++a1TPMOwKnqEpYEWWM5KSNALtWGFmj1yLNjVhBfRU9dsnA67CfMyeNzcYZtTFzGwezhZ0oEZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=S8e9ahZM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="S8e9ahZM"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1866233a91.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 06:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789219380; x=1789824180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wAtjDa3kisizFhZiZYbc7YLNcOhXt5GzOAFc4BOPpDE=;
        b=S8e9ahZMuDdH03qtKEjj1mL585jcNllG+Gopl/TqTTBNxgfWmgaOPUz72ZcC6IFYAX
         8zwPnyzu4Zwg5hvSsXjdwRmqyBbCuvljhUYtt7ZNmyj8s+HUo7YXc4XFMT+q0JKeXRw2
         YDMFWW57bMD1amy9wC5MqQ8dScDyuXLMnweaV/VrYR205UQCfiXOgoj5gDtXt1RzUBAs
         vFaNPMWBe0nuIgHB438O1uztmfhcLT0oYoY4Irz+l1mzuEIcxIGUU1zAee9kNwpmuDtB
         b+1a6x1wgSi9U/aH8GuB6HR61g3QzOET1berVev9P270R5s+lKs1mBvMpKZUmRiYyvRy
         7w7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789219380; x=1789824180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wAtjDa3kisizFhZiZYbc7YLNcOhXt5GzOAFc4BOPpDE=;
        b=VpLSb/sjMkzoXqxjGS0nRa36JcwS6h+FgoJPqXCSKZhgAqHbM+ktKi+e+IfXQgJErD
         7FRIIkXXqtucOM1fY7jvo+JUQCC5U27wKm5Vav9DhNEBHUBGasKq7qw/mWoBfh2IFvb/
         G6u9HTS4c32eRIRxSdW8Q+eLqKRdPItsj4Qa+PnjCpAWDZlfBcbVFoaxthYdIG/pnH/x
         bCDSAWdro5G8sSZ+q6ZAEyNRz1U+4q9FiOtV49XlxnIjnzKGebAEQcHQ8GriJqWoBxyI
         AJoE9Q7A39Q8Ovk/jqp2qk3Lqy9ZN+ifdRLb20ncWCl2J3opF1YDSkXacQ+z1130QpMU
         FtsQ==
X-Gm-Message-State: AFuF++nlrQzJRVzmoT7MUsVb20pvEAgxjgEMmRWeJYxYGmSzH+CbOtpX
	oGm/c4xjpJ/i+OLc1zSb0eEiESt9fA7vEUgfl5grfsLryq4x8SQY3xdxaYggS3lNXp0jeSAyyPV
	r5mjiv38IEu8=
X-Gm-Gg: AYBFou0R2vEO9JEKUy4HX+Br993SXE5EP0KGvXmxR9c6np8O6mZUcXqGtT1Rokt6hQh
	XWNLS08r+xXMJ573Wpg5jrffIVpDggclQEgKt0iGxPbGs8WVn93DhG+I8wArFl9w05t3QWoQqMX
	RkqXIcR9P2PVwDZEvBAPvXv7gbTxsa3ITiq0KFaTKq/dWPKWyu4sjVYZ82VJ+M0zXceYlzCTI5z
	dbl7LS0ri5FmQbbdzoOiiB8RQKSXklovBr9v4qtXBt27sCZDtGCwGYgIDgjeY5HMHK8/Ywmr+pC
	OQ7WSgJbqq8PumI2d2yAOmZX4srz5ahePN9mOv/J1eSGGTjUpVmbTC1TbkZ8PD0hZXfdAw5q8Nj
	5QJmUDpwnnL2IJk+vpkDu6oMLweZg4iFQfmccaArQdIbhuCGRmjeccbVu97Pro4cMsphxVOlOUC
	Dx88AeOOaFlvpIJN3xwVQmsUOnq2QjduZAmWNGg2PLlOc1RbKZQmoGSYmoqa47c3Cr59Y+6XIRb
	ILqoC6xqpmmJTgM1A==
X-Received: by 2002:a17:90a:710:b0:39d:c3bb:98e7 with SMTP id 98e67ed59e1d1-39dc3bba118mr1914059a91.6.1789219380143;
        Sat, 12 Sep 2026 06:23:00 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4b1f409sm15957666eec.0.2026.09.12.06.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:22:59 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	dev@openvswitch.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	pshelar@nicira.com,
	tgraf@suug.ch,
	joestringer@nicira.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] openvswitch: avoid reallocating confirmed conntrack labels
Date: Sat, 12 Sep 2026 21:22:43 +0800
Message-ID: <372fbb062b40ae6723684f55484be86ff0064f8e.1789218015.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789218015.git.zhilinz@nebusec.ai>
References: <cover.1789218015.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ovs_ct_get_conn_labels() adds the labels extension when a conntrack
entry does not have one.  Confirmed conntracks can be read locklessly,
so adding an extension may reallocate and free the extension block
while another CPU accesses it.

Only add the extension for unconfirmed conntracks.  A confirmed
conntrack without labels now fails the caller's label operation instead
of reallocating its extension storage.

Fixes: c2ac66735870 ("openvswitch: Allow matching on conntrack label")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/openvswitch/conntrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 27115967e5d93..0f433688e17b9 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -366,7 +366,7 @@ static struct nf_conn_labels *ovs_ct_get_conn_labels(struct nf_conn *ct)
 	struct nf_conn_labels *cl;
 
 	cl = nf_ct_labels_find(ct);
-	if (!cl) {
+	if (!cl && !nf_ct_is_confirmed(ct)) {
 		nf_ct_labels_ext_add(ct);
 		cl = nf_ct_labels_find(ct);
 	}
-- 
2.43.0

