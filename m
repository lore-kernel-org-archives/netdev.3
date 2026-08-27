Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097CA43E079
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824977; cv=none; b=ZAz9e7puYS3PCSh2xATnSeJKZT3s/+1zwLSQdVn6hyV+bsEy8fUI70UILXbAeAKpCtgLgopcO6UivEPsp6avNIVqevljw6vqZ4Jd3vDMWUI5mD4fwzun0GMgxLtsxMxvZUZTe8B+VBIfrenHumcio/OR88qmytEq3rE2YKs2los=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824977; c=relaxed/simple;
	bh=HwtvY54YILerMds9LF9Yu3gCgXZZKXoBbLTWiokxqus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1pKzSMbtyW3XYQPrCvsaKPa3B4uzPg6cJ5wnEgr3BiXWtw9bHW8oR0xNw3kSo/giIuCvsfhgj3xbbipcmg/uP/p12QJkNwGYsoQ+upIOFcIjOY55m6Orj/YPSNY21y9FvkZrxrTCi6HrH6HgU0iK1wye7/9G1QVn3cJf0FETUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRTCKShI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONO7UMog; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRTCKShI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONO7UMog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787824967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvpeT0h2n6Y7sPgbcxf3s8GKYOw/uhFq32dz5bbuM0g=;
	b=hRTCKShI+RJEFeV6V8MxAq/gNFh6PkP7/ddMFiXznVx9JG9mlEnvRMK1z+ljZhec6iX31A
	mW6NFX1iIgk6iVIpV4/SWcFQa6H2BS3QabN61zRTf2tqMWfixdO4F1o5S/B4BYsjQKIwhl
	TUcKVdOuefzKtqH1gF8YnhicMSSiT5g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-aWbiqFnTOBmCj-2vPgBAYg-1; Thu, 27 Aug 2026 06:02:43 -0400
X-MC-Unique: aWbiqFnTOBmCj-2vPgBAYg-1
X-Mimecast-MFC-AGG-ID: aWbiqFnTOBmCj-2vPgBAYg_1787824963
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954a93c565so11438885e9.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787824962; x=1788429762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xvpeT0h2n6Y7sPgbcxf3s8GKYOw/uhFq32dz5bbuM0g=;
        b=ONO7UMogKexkeATiJ9GScvagl52GtonoBhb/j52T1F7WtCzqlY6oSayp6589LOS2F8
         IiIWpRagsgKhnqjOS7NjI+WkWW+FN/YDhIVFHf/3LMkSsuoIQhpCfqk3LOVNY5Zz7Rur
         bY3bQnTt4Z8K0eJIX/s2DL1R9iZs2hSoO4QDEsyAGOWBNC2w5sv9wV37kz9+z4fxaqFu
         BB8dmp2K88xToa4ybtn74VjIGeMMwHQzEZKPy54SHjbKzHSNGcN1hr4pgTFc4ahUN0NR
         Wxbw7AB1IDpnYlwcGYL1Z4HKpmQtkSFMRGRO+6ldMLHX9tLvZ7hF+rUWUT4HyBMR5OI9
         rK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824962; x=1788429762;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xvpeT0h2n6Y7sPgbcxf3s8GKYOw/uhFq32dz5bbuM0g=;
        b=I5nr4ycj9cqYrVeb5F0R4tf/kYvzINIirkKvF3W9ff6oA1lMxF3GA4vg7Tg8yqOxfE
         pwEOk6Ud0sHSl7BF+xGIk7ZAYGpCYckbVXHspIB1CQuk862tVIOvU9LjuSyFZRG4z/FI
         KkIqDs4TCHc8zL81DQWYtaoKvDwzPtGBaFzD6nF2CN3MI/VMyDYJfIC6Isr0wxOcrafu
         LfsZP24IPCpNlmcjnV2avR+jj+x7V/ZfDrO4roVQZ+xPe/MM7ctc+1ca0/9lnjVYjIRD
         olFSu5oW3sF6B8q3qNpXciBznonba+Ts+8hEnIWaIn8bkDwLUlfZBtENYWIJGTEKZHsi
         nPlQ==
X-Forwarded-Encrypted: i=1; AHgh+RpCC5m1J4VUvcgyTzNyfGPEjYhnlacKtq2rHPSoppVq7whjlSktcqb8ICEdm1U4D8h6SabgcpA=@vger.kernel.org
X-Gm-Message-State: AFuF++n+lEzDTTzOOgZ10tVC5hkEnan48uOaZ9ORKskq6U5A9ZJXt8/c
	wG6ZVUbc5fsoRBslrwqLhPInr1oCVESMpwvdCChbqTvjquj/cSnWWJeslBewicIHXJ/pVWIfLex
	KfxwWvcEo+Z3VFR7/v1KmQd1EtbyWNTgDhKTg9QZ66lpZE8g0gJ1KVcTTIg==
X-Gm-Gg: AR+sD127f4LOdlQXLIPRgcCZ6K+7P+YcX9HGsbaAdZTm8AxQPge7Ay1GW/2+61SQD6M
	qlVOGo84iRapAqjwl2CBa0BhtYW+IgX1bk/b3vV30JWB7z0T/L7Q2xfi/ayrTRpTP4Mt9kJ+MUT
	GIb1ImUYPCHPA4jlxuMKdFfaEH7p6YOVXQfJto4qrr/fZlwbtVd9Jry1I148jBxK79SLljDXjib
	jnODX24ntq6PL5rJ+pqJp4MIfE1IonTPxrbhndoXZEP4KvNyRXLFvCoj8RCemQ3VyeATE58DtTs
	XF9IUh8eT/qRnrbkfWOdUKQJ25OBFtjjJg36sCGLUXPu369210dCCFImfZvNfnLXFLFVkG0V9ui
	If2gTul9hrBMgP76doZolj3BQ
X-Received: by 2002:a05:600c:4e55:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-499dc723fadmr162882055e9.9.1787824962375;
        Thu, 27 Aug 2026 03:02:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4e55:b0:499:484a:81d0 with SMTP id 5b1f17b1804b1-499dc723fadmr162880875e9.9.1787824961898;
        Thu, 27 Aug 2026 03:02:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b49eb3b21sm40420355e9.8.2026.08.27.03.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 03:02:41 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 38C38979E22; Thu, 27 Aug 2026 12:02:40 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/2] bpf: selftests: Check for XDP frags flag in bpf_program__flags()
Date: Thu, 27 Aug 2026 12:02:12 +0200
Message-ID: <20260827100214.169215-2-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827100214.169215-1-toke@redhat.com>
References: <20260827100214.169215-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a check that the BPF_F_XDP_HAS_FRAGS flag shows up in
bpf_program__flags() when opening a BPF program with the 'xdp.flags'
section definition.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
index fce203640f8c..a894b1ab46f4 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_frags.c
@@ -18,6 +18,9 @@ static void test_xdp_update_frags(void)
 		return;
 
 	prog = bpf_object__next_program(obj, NULL);
+	ASSERT_EQ(bpf_program__flags(prog) & BPF_F_XDP_HAS_FRAGS,
+		  BPF_F_XDP_HAS_FRAGS, "frags in program flags");
+
 	if (bpf_object__load(obj))
 		return;
 
-- 
2.55.0

