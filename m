Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293133B9956
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535322; cv=none; b=EuLXcXY8BSCombpm0SgtfWwjtlnSY/0StWY3eM+Ql7aH7S7HZFaD3ACt8NpJhMYCoI43NdEmdDesPMkZKOrY19PX+dvP34v3rvZ9OyhLLKMIh7x06u7SRYfpDf9gyDH69EKaB78YQYttbvBCt7d1z67/EYeI+c7m7MAk2WG0c9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535322; c=relaxed/simple;
	bh=RCAx16luTF02kZgEZ0D7CHSImQt7iTlNbzO7mxUy3ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fpuo8hUdrg8DTeF6zqeXmPZ7KzoVBj7lQYd2tcTePio1+N8/SIt4lmASkEhezTtlR683eVUEzRxhi5cUXAab9+DNJAfnUIdLC01hXrGSHdk928XsHEdwPwQrl2cUiWnC2YbWRkYLK7lts7mKB9ddR2+bhD7M+GWBwRUpss/qwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=OxPPh95V; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="OxPPh95V"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso524207a91.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 22:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535320; x=1790140120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8uvju0VQfszCfaJ5PHHj1YzIoy00iEV5n4pCl9kK1c=;
        b=OxPPh95VKbBNNDbkUKzIXhA9JRSi8dRCtRWokBGbz45AXCMNb0PQXGhqp2hnJW4J8u
         1HV6sa082mtOtRwFf12j8RscEr8vzpXIngCi0Hd2B5uyVQMXv2AFoDce6IbGX5q6ciIq
         LI/61bf/6M89bKum+lIxyCCatIhW0aOB2OtbPfgdZPVkWRzPpuM5f+fdoz16u54xJGl5
         JBTuLswOMYIP4LPm0YGxSuxOBdPhC2aXqSrZs+8VLTCrXEzEOT0/1War7PsselthR78H
         M6hq9h8pcKdbMwIvhcDtXv6fcrBxoE0FpNBRpA4cDev1MX+TA9D1dMIGgdggo/rEUbX2
         m+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535320; x=1790140120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8uvju0VQfszCfaJ5PHHj1YzIoy00iEV5n4pCl9kK1c=;
        b=ArV0+ceaHOmoRO4XDkBhYEZK80KW0T8nCC+j1XR5TqT2ehP0FS/XieyqrZ3Qp1MU19
         08oQAKXI8zF8zyH0ftJDEFrry7/41GNIW1jZwUGNPz4G7WnBvlvLUvPp12BUo/p8PbwR
         o8Wt2pLfkfprWQ/2nFicwdFsCWv7NcNTpqfqNflux9VuyV5N1E2GtLS2TnFXxSnuoh1T
         YQHEJGGw6jdRexK5fYT7559WFaP3ZQaoRWjCXdXsHbmZ3zTylegA5lUthAeDZdWstiUN
         BOiBvsAeN+USBGooZ/Mk+/tY29O+HhOg4L/BmiSX4kyIzjKvUR7iBThK49P8iw6wDdea
         FE5w==
X-Forwarded-Encrypted: i=1; AKwUvBzPo8Zguf6uhmZUwp9iK0p1WvmQW8qNQjIHyuAFH3vJbGYSEGlg/h2c+9A6JdcInsyxbx/xKXw=@vger.kernel.org
X-Gm-Message-State: AFuF++l2CSahv6ZNYncy+oGzLUjEyAz9ayDtTVC2lfXYU5Wftt2FrGxI
	+6wJPTV6OPd44Q/qXorWbYDR2nexHj3rxIZSWoVf3hTEXQmu3nH95xoDtz8XsxUsvgu86FadIp/
	CHxgU
X-Gm-Gg: AYBFou3rf1Oa20d2/833tvnmmTpexTP69OQiQ3ncBVFJE1CrDY8QsP3azzPFGxHYrh3
	qn2o51ZoHVkOoha7vhEKDAPmMyhNJGAocb5a4aq3gu+NDUcDYHJR0B2xvzIbkcxW6me6OhcKzSn
	xT8oMlFuEBSLabDsOCz85NIAPXDenZVlHyQcbX9tYCC8118nLIyPzehqCdNWFowS7Cnqw0hhP+v
	nFd/KhSi0gxLSS5eJ8EIkhzUUOe/EcZATVisE7qJGlRrIPkscimmA5QvV+mgpsphlMVFPehMrqD
	QUmT3BQie6j1GK9f2Knzz77q6ppbIP9CVjNfAB3GQiWrSNv4tLyXtQn8PmlyDxV5ZBdKdzVW4k1
	621ISDqRWcQwsOhRA2F+7QRSdljaYcD+FXqi0W4ABugK7ihgNlIFrNTBc+wDPcwNapRGjYeYjUT
	cHmyV8HrBmn2PfST+ku+gkl2TneHc6B8ulUp0B7vd+CvEi+zNfU+W2oEMvY8nwybn2NXcTkw0yB
	aNtcVvkIasJbqnHBLuDsLQmulw9eMQyNQa5R1qjkta/m6IK
X-Received: by 2002:a17:90b:3a43:b0:39d:f5b1:e365 with SMTP id 98e67ed59e1d1-39e1e559b78mr3162444a91.25.1789535320402;
        Tue, 15 Sep 2026 22:08:40 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:40 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 06/11] selftests/bpf: Test rejection of pkt args to mutating subprogs
Date: Wed, 16 Sep 2026 05:08:24 +0000
Message-ID: <20260916050830.8774-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftests that ensures that PTR_TO_PACKET arguments can
only be passed to subprogs that will never adjust the underlying
packet memory, and are rejected otherwise.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/progs/verifier_global_ptr_args.c      | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index b277b1efb..10019af5e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -350,4 +350,57 @@ int anything_to_untrusted_mem(void *ctx)
 	return 0;
 }
 
+struct pkt_arg {
+	__u64 x;
+	__u8 pad[56];
+};
+
+__weak int subprog_pkt_ptr_no_change(struct pkt_arg *p)
+{
+	if (!p)
+		return 0;
+
+	return p->x;
+}
+
+SEC("?tc")
+__success
+int pkt_ptr_to_global_mem_arg_no_change(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct pkt_arg *p = data;
+
+	if ((void *)(p + 1) > data_end)
+		return 0;
+
+	return subprog_pkt_ptr_no_change(p);
+}
+
+__weak int subprog_pkt_ptr_changes_data(struct __sk_buff *skb __arg_ctx,
+					struct pkt_arg *p)
+{
+	if (!p)
+		return 0;
+
+	bpf_skb_pull_data(skb, 0);
+	return p->x;
+}
+
+SEC("?tc")
+__failure __log_level(2)
+__msg("R2 is a packet pointer, but func#{{[0-9]+}} may change packet data")
+__msg("Caller passes invalid args into func#{{[0-9]+}} ('subprog_pkt_ptr_changes_data')")
+int pkt_ptr_to_global_mem_arg_changes_data(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct pkt_arg *p = data;
+
+	if ((void *)(p + 1) > data_end)
+		return 0;
+
+	return subprog_pkt_ptr_changes_data(skb, p);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

