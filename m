Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A86576EDF
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097648; cv=none; b=pZHILWW3/tPkkcgvGbFjVFKkyjwyvbgYwytb2GjZsW4jhKRhXuexni2b9Sp8zwjyLEns6de9K57q4m10znYcEaQ4NvCGRLHkSfa+27jJ+cKriRfoaUcjZEvSWIEoJ5+9eArFcVI8Sy6oASJJwTh28Nls3J/W63ovYFuCajzNyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097648; c=relaxed/simple;
	bh=RCAx16luTF02kZgEZ0D7CHSImQt7iTlNbzO7mxUy3ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhlaIEGGr/NF1dNl72mBKVxYLnaBY6UGrVt7eYw4SOVBdiXQ7KYkzQxy0CH6dvlHnQxoWnUwIXaSxCfLL74Gk+EMa05QgbBG1/SJ5/seKQfX6t1gpjKXywDqwNW+NEQw06taQM1ybVfc0X787tFkcXPpRgMXfMIVG/l82o+j5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=lRpxDeAk; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="lRpxDeAk"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso117689a91.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097645; x=1790702445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w8uvju0VQfszCfaJ5PHHj1YzIoy00iEV5n4pCl9kK1c=;
        b=lRpxDeAkTCt/8ZOgLl6Y5rDsc4wlVC0mT/JqFPX7ZCF+rGCaYLbL4rxZeg1n/LjzPR
         E6NGqk2eRBp5cC+qgtcLAW0jP/pj2jxvJ84Cb7b+2UocsysbcsYj4BQk0T1ibi1kMdEx
         iauoopYolANp3lKGZ2osqz5n44Is22gV6nUiUDvr/Cfkp0+jbfqL9conZ2QI6ATPUwwV
         3YUocPaJ4i/lMSzrB8ONNuGJ0r56nLK456Q7jq53mlJ1968V1MCeLt62dcVoAXtoDkoJ
         xsWTy/x7sul5fCpwqEIwKJzpRC1cpBPegEWN+jgcoY1q/qjBrH6VErGzjGmcFwX5GrRR
         ph+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097645; x=1790702445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w8uvju0VQfszCfaJ5PHHj1YzIoy00iEV5n4pCl9kK1c=;
        b=Up1kLqYwb95RmeGLRPmZkNBUuENOnk85l8oDPMF3J59oweAaqakJN7E20BSylCeLvG
         Po2zXczq3QUrdLARcnJTBblXq4tOEr+DZN8tyd2OeGCV9IQJiTRWpW5xKwEFLsJKtgMk
         gvdvmQhZnNEDbE7Hh4L3vAKzVGOEd52PpLOjVciXYoi8RmhDp+ufNZuYvECJxgc+/c0D
         vonN0ozofvX2SHoqSgHND7S/kAs2Thb2YbSyT7U7Y5lkLoE4Wak1vwG2Q+tMd85QbQY/
         A3a8q5rdSszxAksPUcvRNg1Mb2tSoGOZfbd9kJVYVQfcXs8g6/lpbnZC9RhYwYIZQfzx
         h0MQ==
X-Forwarded-Encrypted: i=1; AKwUvBwuOT6tBJokIUOvxWTvNXjtUVYjXcpECcO/42HerQzazckj0oczaZreKP1niS9OU5kecZ3MX2s=@vger.kernel.org
X-Gm-Message-State: AFuF++lqP2xXuXvhYixuwWf0nZ9m/ct3nkTbZH1tUM0LPVT2b5+GW9e7
	BpJo+deQz4THGIANGpMtkduVaFG/TjUXcGPmyluCgCXbLKJLG5dngBoCMk3hfpBvnNA=
X-Gm-Gg: AYBFou3yfMKNmxp80zl43XEUJDKM9gE6PSMDFnJcyzX0F2oZMki872nzmvpTrVbDxho
	/s2a6P1dt6a86eOjcX9/S7L7z+uTe5EUPS4uzHRHJWZLlNiNUpivkDFfk01PzOg7l5O9ikvRLHH
	7pxBhdbAy9tt4I2rRxyiOa1lzRMf9kTH0jDlziovqO2OqKtGVRq8hiRIKJQvitgofLod9RMsqux
	HIU2xKLuyDCIJMR6Yp9Tv7NWjrniqo7rdyfL5RCgJ6IbdlhZJ/sGR5Rr14zrREtUYs+7VhLiaz/
	HxtqJ4FzMwsEg6CEPHdXOYqL7KkWmNTlMsJkQxarnPoFYLyWk9nL2up4i9g7zePtNAmX0lbl/1B
	dCvkpWfL5eWcabWSrUgtO0HMWoJmYAmMraUxM9mhLIpwTBVUU0RpKMPVGxH3y05C9PXdK9TGBZF
	LF2+0lBiQADO/Bf4Zyjt6ESmyGE8fq7Pmo1Kc1rM4KOYFHjTTAKH7pkZ1LiF1Qo0id+nTZ9GqJG
	apMz0xUdvPS/Ay1l1hcGWCMiFWSyi36i+MVXNrMcQ==
X-Received: by 2002:a17:90b:33c9:b0:39e:6c69:776f with SMTP id 98e67ed59e1d1-3a07e6a66c2mr94952a91.24.1790097645388;
        Tue, 22 Sep 2026 10:20:45 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:44 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 06/11] selftests/bpf: Test rejection of pkt args to mutating subprogs
Date: Tue, 22 Sep 2026 17:20:23 +0000
Message-ID: <20260922172028.6269-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260922172028.6269-1-emil@etsalapatis.com>
References: <20260922172028.6269-1-emil@etsalapatis.com>
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

