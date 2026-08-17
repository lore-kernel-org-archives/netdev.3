Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEAA448BAA
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981832; cv=none; b=WcwEEgZE3//9pPqRP2GzzneUO+lq2q1ZPpMplqzwAQM6J+jaT9R2nTe9WzUFkNorWaA7sCBvpjcHTP7CcGefk/xwJRBIVpG73DMGLho10gN/AXIEFFei+gU6tyzd5o2oFKcc6vo0Dj0CWgCrHdKTOBas7I/TWZEFLZ86O04W+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981832; c=relaxed/simple;
	bh=UGaXKViydcNHgiIYJqkogJCCwyxdJr51ddIZCkZf78c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWmDYeqa4BuFEDhO6Dg4OlHBzxioMRCJtPx3TMXYygM5XjVQoQipixDWjoD/DEJ0ieeqC+zuev0KG5u2M8wbe8srEvOu/no0bCW0qr+3naXf3xf43hzbBdKY25kYK58N4hFh822nbQmjGv3JPGHuxDmuyst+0/eletDAVyysDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al+0ZHDV; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al+0ZHDV"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso3661162a91.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786981828; x=1787586628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bm6tU6uRMhMFMi+BnhXh/n8qQcLZIiln365T8/pycxA=;
        b=al+0ZHDVRdxYbYdXpFtNT9yfLmChIiI5RiQ392qfOYF4+zr8F+21rmu8+bv1BCnbeM
         4X/ETUbL1x6YtYQ4r04GNvdyNcYMK1FZb2qgdqS+UW9M+ZHa6LY6+vUsnbAOCLWro9Zc
         3YyDx9TnMGAkY5+zfB9fTWYL2zLq/mouTT3B7zGKLDdHrbxCtziEo0Of6Xmd0XEkkRE3
         5zNNJFgke6TyptSaQNZisOYTWuLRp8MTT7K1K6s1IBHMxZo2HU0gGDXej/+JLt4VGtAX
         HoiadL4OMcUlBspVtWTWPRZryZk865D8BDpg69secvNlMge6P50buRcLtLk70Uv2UFeK
         e8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786981828; x=1787586628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bm6tU6uRMhMFMi+BnhXh/n8qQcLZIiln365T8/pycxA=;
        b=nVq6RPW6gditq1ZcF+Ek1zFG22l0Cs7yaWZtHpTT3sdqYiUijnf1sFIHJzcDRwQgL0
         DoxYpTjPxhm3MFq8ZE9VQ0oJo4TTli303gM6lmji79lV2ugnT22MeTYtBuGdLTqiONLz
         6hr2i25frewnhSuNRkbD4bdDUswHsI/pemBA/+oX1V5hQ4nzX3hpxmG4jKCklN1cAkwx
         j7TKO+KEGQHFvV4AP+HsbDnmfAmYkUOvzXk4qdUjyi0nk+zw3cPGavWJIUy1Kh1RbNUO
         G4f4Z+7hFjaPsf1AO+SRkMHCh7rawxo/jqFI3rPEu6BPMO7z3PBLP2Phq2dav7lQnR8I
         0tfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAweacfxbGc6h4L050a1tn4cglUFsA4/Z9KiyjYyIra58MotS3v3DXCnNOXdlok1B/GaAhwc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9xC0IO0Wb+k76G0SJJzgBk8sem/FIcagw3pxNrQri0oOErdv
	Zuka31lEK7if2gkXVB7Sy0q4U25bXuuH6do/vM9MhnEtbfmvQxwO6E2Q
X-Gm-Gg: AR+sD10qosqro+SvID4/wMqjdvaiD2xRr+opKNEbImg8p+v/IFLCu3uaiP2qeW5TThe
	96CEATqi0ZX+uFSd1fAwn97qCPDI2M/rf5i7IfP7oMCbSkFE/vtjidrLcVvirr3MdFD6Uo613NU
	gV/k3Ce+ib1W1Xy+UTzD0n7SQywggQhNH35N9DVBGaKP4pWo8QtNEBfuqp9Ojpd7T6xqJK1lRWh
	88kobRTim8fY70w/KTWllABYO4gXCgCfxrIfzLHNzcCp4qhBjsq1ssdsXVdA3810nJVnsaYCyv5
	JJgmj1Y3jIhbOPjZj4qVUm8iybvzuCAlNyyJ5eayB6pqupgUS6WERWEmHlMWkNW7/ATbGPILh3Q
	hg+BNTmobdEbknbkW/GOyVKprswMRlkH5C6ZwuUkUyZlXqWUhBDuPZDO3PDqDegS88zJI2b16N5
	xZ0D+jj1Ok1EEveNYStzP/q0SQOH5mWmjNFL+ApExwWBfY5BA2JtYg4s8=
X-Received: by 2002:a17:90b:4405:b0:381:792d:f993 with SMTP id 98e67ed59e1d1-3933b8c4cf1mr23467515a91.17.1786981828382;
        Mon, 17 Aug 2026 08:50:28 -0700 (PDT)
Received: from omen-arch ([211.58.239.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339b0d6f4sm4682766a91.0.2026.08.17.08.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 08:50:27 -0700 (PDT)
From: Junseo Lim <zirajs7@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Cover strparser self-pass forward allocation
Date: Tue, 18 Aug 2026 00:50:09 +0900
Message-ID: <20260817155009.232670-3-zirajs7@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817155009.232670-1-zirajs7@gmail.com>
References: <20260817155009.232670-1-zirajs7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a sockmap_strp regression test for strparser SK_PASS delivery to the
same socket. A one-byte stream parser splits a single write into many
messages, repeatedly exercising receive ownership transitions while the
skbs remain queued.

Verify through INET_DIAG_MEMINFO that sk_forward_alloc does not become
negative after the self-pass path is exercised.

Signed-off-by: Junseo Lim <zirajs7@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 171 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |   6 +
 2 files changed, 177 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
index 1d7231728eaf..c7ad21d0bbf4 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
@@ -1,5 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <error.h>
+#include <linux/inet_diag.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/sock_diag.h>
 #include <netinet/tcp.h>
 #include <test_progs.h>
 #include "sockmap_helpers.h"
@@ -460,6 +464,171 @@ static void test_sockmap_strp_parser_reject(void)
 	test_sockmap_strp__destroy(strp);
 }
 
+/* Read sk_forward_alloc through inet_diag meminfo. */
+static int sockmap_strp_get_fwd_alloc(int sock, int *fwd_alloc)
+{
+	struct sockaddr_storage local = {}, peer = {};
+	struct sockaddr_in *local_in, *peer_in;
+	socklen_t addr_len = sizeof(local);
+	char buf[1024];
+	struct {
+		struct nlmsghdr nlh;
+		struct inet_diag_req_v2 req;
+	} req = {
+		.nlh = {
+			.nlmsg_len = sizeof(req),
+			.nlmsg_type = SOCK_DIAG_BY_FAMILY,
+			.nlmsg_flags = NLM_F_REQUEST,
+			.nlmsg_seq = 1,
+		},
+		.req = {
+			.sdiag_family = AF_INET,
+			.sdiag_protocol = IPPROTO_TCP,
+			.idiag_ext = 1 << (INET_DIAG_MEMINFO - 1),
+			.idiag_states = ~0U,
+			.id.idiag_cookie = {
+				INET_DIAG_NOCOOKIE,
+				INET_DIAG_NOCOOKIE,
+			},
+		},
+	};
+	int diag_fd, ret, err = -ENOENT;
+
+	if (getsockname(sock, (struct sockaddr *)&local, &addr_len))
+		return -errno;
+	addr_len = sizeof(peer);
+	if (getpeername(sock, (struct sockaddr *)&peer, &addr_len))
+		return -errno;
+
+	local_in = (struct sockaddr_in *)&local;
+	peer_in = (struct sockaddr_in *)&peer;
+	req.req.id.idiag_sport = local_in->sin_port;
+	req.req.id.idiag_dport = peer_in->sin_port;
+	req.req.id.idiag_src[0] = local_in->sin_addr.s_addr;
+	req.req.id.idiag_dst[0] = peer_in->sin_addr.s_addr;
+
+	diag_fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC,
+			 NETLINK_SOCK_DIAG);
+	if (diag_fd < 0)
+		return -errno;
+
+	ret = send(diag_fd, &req, sizeof(req), 0);
+	if (ret < 0) {
+		err = -errno;
+		goto out;
+	}
+	if (ret != sizeof(req)) {
+		err = -EIO;
+		goto out;
+	}
+
+	ret = recv(diag_fd, buf, sizeof(buf), 0);
+	if (ret < 0) {
+		err = -errno;
+		goto out;
+	}
+
+	for (struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
+	     NLMSG_OK(nlh, ret); nlh = NLMSG_NEXT(nlh, ret)) {
+		struct inet_diag_msg *msg = NLMSG_DATA(nlh);
+		struct rtattr *attr;
+		int len;
+
+		if (nlh->nlmsg_type == NLMSG_ERROR) {
+			err = -EINVAL;
+			goto out;
+		}
+		if (nlh->nlmsg_type == NLMSG_DONE)
+			break;
+
+		len = nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*msg));
+		for (attr = (struct rtattr *)(msg + 1); RTA_OK(attr, len);
+		     attr = RTA_NEXT(attr, len)) {
+			struct inet_diag_meminfo *minfo;
+
+			if (attr->rta_type != INET_DIAG_MEMINFO)
+				continue;
+			minfo = RTA_DATA(attr);
+			*fwd_alloc = (__s32)minfo->idiag_fmem;
+			err = 0;
+			goto out;
+		}
+	}
+
+out:
+	close(diag_fd);
+	return err;
+}
+
+/* Test strparser SK_PASS delivery to the same socket. */
+static void test_sockmap_strp_self_pass_fwd_alloc(void)
+{
+	struct test_sockmap_strp *strp = NULL;
+	char snd[4 * 1024];
+	int c = -1, p = -1;
+	int fwd_alloc;
+	int sndbuf = sizeof(snd);
+	int zero = 0;
+	char rcv;
+	int sent, recvd;
+	int map;
+	int err;
+
+	memset(snd, 0xa5, sizeof(snd));
+
+	strp = test_sockmap_strp__open_and_load();
+	if (!ASSERT_OK_PTR(strp, "test_sockmap_strp__open_and_load"))
+		return;
+
+	map = bpf_map__fd(strp->maps.sock_map);
+	err = xbpf_prog_attach(bpf_program__fd(strp->progs.prog_skb_parser_one),
+			       map, BPF_SK_SKB_STREAM_PARSER, 0);
+	if (err)
+		goto out_destroy;
+
+	err = xbpf_prog_attach(bpf_program__fd(strp->progs.prog_skb_verdict_pass),
+			       map, BPF_SK_SKB_STREAM_VERDICT, 0);
+	if (err)
+		goto out_destroy;
+
+	err = create_pair(AF_INET, SOCK_STREAM, &c, &p);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto out_destroy;
+
+	err = xsetsockopt(c, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf));
+	if (err)
+		goto out_destroy;
+
+	err = xsetsockopt(p, SOL_SOCKET, SO_RCVBUF, &sndbuf, sizeof(sndbuf));
+	if (err)
+		goto out_destroy;
+
+	err = xbpf_map_update_elem(map, &zero, &p, BPF_NOEXIST);
+	if (err)
+		goto out_destroy;
+
+	sent = send(c, snd, sizeof(snd), MSG_DONTWAIT);
+	if (!ASSERT_EQ(sent, sizeof(snd), "send"))
+		goto out_destroy;
+
+	recvd = recv_timeout(p, &rcv, sizeof(rcv), MSG_DONTWAIT,
+			     IO_TIMEOUT_SEC);
+	if (!ASSERT_EQ(recvd, sizeof(rcv), "recv_timeout") ||
+	    !ASSERT_EQ(rcv, snd[0], "data mismatch"))
+		goto out_destroy;
+
+	err = sockmap_strp_get_fwd_alloc(p, &fwd_alloc);
+	if (!ASSERT_OK(err, "sockmap_strp_get_fwd_alloc") ||
+	    !ASSERT_GE(fwd_alloc, 0, "sk_forward_alloc"))
+		goto out_destroy;
+out_destroy:
+	test_sockmap_strp__destroy(strp);
+	if (c >= 0)
+		close(c);
+	if (p >= 0)
+		close(p);
+}
+
 void test_sockmap_strp(void)
 {
 	if (test__start_subtest("sockmap strp tcp pass"))
@@ -482,4 +651,6 @@ void test_sockmap_strp(void)
 		test_sockmap_strp_dispatch_pkt(AF_INET, SOCK_STREAM);
 	if (test__start_subtest("sockmap strp parser reject pkt mod"))
 		test_sockmap_strp_parser_reject();
+	if (test__start_subtest("sockmap strp self pass fwd alloc"))
+		test_sockmap_strp_self_pass_fwd_alloc();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
index fe88fa6d40bc..682e53d40751 100644
--- a/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_strp.c
@@ -50,6 +50,12 @@ int prog_skb_parser_partial(struct __sk_buff *skb)
 	return 10;
 }
 
+SEC("sk_skb/stream_parser")
+int prog_skb_parser_one(struct __sk_buff *skb)
+{
+	return 1;
+}
+
 SEC("sk_skb/stream_parser")
 int prog_skb_parser_resize(struct __sk_buff *skb)
 {
-- 
2.55.0

