Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420549363D
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790097644; cv=none; b=C7I4u9Ykbric3GvVRd0+tg50ftNkHJoxO484TO8zKN2MvAKTnOKTRFXagAjEfMduevOYjkLcQq1rWkc4+o2jAGei4U9k9TNfZsfKyh1YShsjBAh16rYyEEsIt2tBFpPtEQNl8438PzPTIGs0BhAT85YLbOgREebYrkIzJcKRvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790097644; c=relaxed/simple;
	bh=v9l7tVvrVmZba6RbmYUyb8MQTP/pDEanXcjNhFrjUxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkAcTOc5sJ193Td5af9i42GKikiofPXjY8IkPcacudxwcbEA1uh1fOL0HWqfipiDzcTYZ+nXkZyJV+Nb2JbfvXztIbukukG2G9X3NXbfXwRkSXe9uCebPMKv7VW9L6VJLXzs1h+gFNdDwDb1LeZP5utZA1RP19GFWqG+vIwTONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=g9vU4f6z; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="g9vU4f6z"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398c066106cso117281a91.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790097642; x=1790702442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wuJ2qCnS/wmK7OW9fsN5CCesdI0U+o2AEkrSo+G4ms=;
        b=g9vU4f6zfjepL1ahYJocF3Sol+ULi9lCoUTkJjMeJ9dZFcYS+dojYQbSxhuwLaNtZW
         KITnksRdABgOIWzx8I3jB9y+VLn5OST2baq6O/4PTLqIpFFS1sg69c/u3gO1oDjDHr8W
         Oag00tGWQbWLyqDCJeIv2ZB8v4VYvobTeH3gAjj813Vk+zcgEfgE5HcURYqzjRGZ33kh
         yKWbfqK1cELLiprQE8kVobL1kjtCTGKqa/AK0twku3DL1Kimf/XG6FoGTfAt2yPN44hj
         RzZDIkMc1zacuCDSWM2FeNRZQuJ5iM3YYy3b1jRGeqbbB9J0d/fMrc51R9pdHH+RazFn
         m0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790097642; x=1790702442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wuJ2qCnS/wmK7OW9fsN5CCesdI0U+o2AEkrSo+G4ms=;
        b=dslgdW0NL21qT6eFKSUDsRvrIOMclTxhH7vYW7UlGs5kCeG3zY2vFrdzhejPesLqod
         I0EVEQeYjvFMEHjWPfNuOPo670PHh0MylyRDnLeUGwA0kKR7OMIc7L1oTDNc587KLCtI
         XlSMvwjHuK3OzE+rNqno+pjO+O43KgU1+888jFvKiOdvG9bqPXblsEHdnC8IUy2h2os8
         GhboA4uSfK3k9DeXHPWdm9KL+/uGi4xCZAyEjgksE2yZo5XNA+pu2K/VCSFLQ+Utq/mo
         erEF2Rd5TO59niIiGq1VA8ERQyiaN3UvityZZ7TpostzdTgfBW9foV5SeQ+rn4Wlwp3q
         UWug==
X-Forwarded-Encrypted: i=1; AKwUvBy6gBU7L8XEU+Da2Dcb/TQnb7BASGkG2WeqKAgIK8RcYSE9Do7Q1w7xu0d/+eA/J2nKHsjom7w=@vger.kernel.org
X-Gm-Message-State: AFuF++k9tfJxsBf2xeF+L0ICYeebx/LBuvpXYC6MJOJyTSqU1Mq7x7i/
	Lm9Ftg+ROe8JjE9SoKF4Q6ARrDXSUJKgZAGikg4EzHqfD4XJeJMV8N2SfNY3SoMb9ko=
X-Gm-Gg: AYBFou1iboM+QNdhYhqRGxLkjGR8rEiRwlRDYUyfi7SJE5XsoE11lrPwCKZvy2PghlZ
	r7AlOZgv/0pnaEBeREbB2Qc0AQRNmhEyF/9KYcwjhW4V7NYXZXo4rMyvsOojGZkbY/0BakqWBWg
	oapqke9YmQxucq3aL1dC31O3oJ+FZEDWn0aSRVuYHae35jratK79MD500Ez75/rk6EP+FFAU2Cz
	I4GePtDyifU2ggchRqJS5hN06FmZcSFWst8FDE84PDkbHaVGga5uSEiopBc8Z1OGOmLX1CwhwGv
	gvLAe9llkOK7AP1a7ymE3xWarglqQAUh3oc4Ofi2mqq1MgHUmMmImwHczaRRWJZCeoXgU2YdVej
	ZPGWodaSYkDOQl9oy1N07I8VpqqBC/ZU6boPkXv/Ff6nao0w5cif+RXm7R8t2HV6xPtX8pFpmQQ
	zSvxVhIDq8umPAG+vT6T8P0Khcvk2pVzaGvJ6q6rhqhT8wyjdlEyI0GMultmcNLoAQHOPtTrTzz
	e2LL4napDDyvQi5CpszbGBlhdx9D43nd0y98UOFqg==
X-Received: by 2002:a17:90b:1c06:b0:39e:3554:4d0e with SMTP id 98e67ed59e1d1-3a07e4f0355mr133318a91.1.1790097641471;
        Tue, 22 Sep 2026 10:20:41 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cb7159fsm1774824a91.4.2026.09.22.10.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:20:33 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2 02/11] selftests/bpf: Test dynptr slices past end of skb
Date: Tue, 22 Sep 2026 17:20:19 +0000
Message-ID: <20260922172028.6269-3-emil@etsalapatis.com>
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

Add a selftest to ensure dynptr slices cannot include
past the end of the linear area of an skb.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c | 10 ++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 20 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 5fda11590..439656036 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -9,6 +9,7 @@
 enum test_setup_type {
 	SETUP_SYSCALL_SLEEP,
 	SETUP_SKB_PROG,
+	SETUP_SKB_PROG_NONLINEAR,
 	SETUP_SKB_PROG_TP,
 	SETUP_XDP_PROG,
 };
@@ -32,6 +33,7 @@ static struct {
 	{"test_ringbuf", SETUP_SYSCALL_SLEEP},
 	{"test_skb_readonly", SETUP_SKB_PROG},
 	{"test_dynptr_skb_data", SETUP_SKB_PROG},
+	{"test_dynptr_skb_slice_non_linear", SETUP_SKB_PROG_NONLINEAR},
 	{"test_dynptr_skb_meta_data", SETUP_SKB_PROG},
 	{"test_dynptr_skb_meta_flags", SETUP_SKB_PROG},
 	{"test_adjust", SETUP_SYSCALL_SLEEP},
@@ -94,7 +96,9 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 		bpf_link__destroy(link);
 		break;
 	case SETUP_SKB_PROG:
+	case SETUP_SKB_PROG_NONLINEAR:
 	{
+		struct __sk_buff ctx = {};
 		int prog_fd;
 		char buf[64];
 
@@ -106,6 +110,12 @@ static void verify_success(const char *prog_name, enum test_setup_type setup_typ
 			    .repeat = 1,
 		);
 
+		if (setup_type == SETUP_SKB_PROG_NONLINEAR) {
+			ctx.data_end = ETH_HLEN + sizeof(struct iphdr);
+			topts.ctx_in = &ctx;
+			topts.ctx_size_in = sizeof(ctx);
+		}
+
 		prog_fd = bpf_program__fd(prog);
 		if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
 			goto cleanup;
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index e0745b6e4..b668ebd61 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -10,6 +10,7 @@
 #include "errno.h"
 
 #define PAGE_SIZE_64K 65536
+#define TEST_SKB_LINEAR_SIZE (sizeof(struct ethhdr) + sizeof(struct iphdr))
 
 char _license[] SEC("license") = "GPL";
 
@@ -211,6 +212,25 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
 	return 1;
 }
 
+SEC("?tc")
+int test_dynptr_skb_slice_non_linear(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	void *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* Ensure we cannot read past the end of the buffer. */
+	data = bpf_dynptr_slice(&ptr, TEST_SKB_LINEAR_SIZE + 1, NULL, 1);
+	if (data)
+		err = 2;
+
+	return 1;
+}
+
 SEC("?tc")
 int test_dynptr_skb_meta_data(struct __sk_buff *skb)
 {
-- 
2.54.0

