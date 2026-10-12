Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6CE3EDE78
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849337; cv=none; b=Wsau4JbVyy9C2Dh2Iv65p5PyLOMg+Ld4hVtNsWIpS69R30vtvKBozwc4ZlxWDEuwC9lL6k8LN/rQkxZr8AUwqbzCxZ1Nq/ngh3w2mPijF0wACl9OJQ8VanaHe38t8CabeFd9jgCYas5LCJCqR9ceKdNF1/rA47C6kNsqvEitwgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849337; c=relaxed/simple;
	bh=VqE44AehCssWJGWUs9PIZgPZFXsZKmwiXJFANrHmelk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luQWDJRkayCJxcAXMSOrwH4Gtm5hsX1VEjaniz+cmy92dw85DlCyOIolcU2vyJXfQUqUlXbB41LY9PaMVq1MTpioHunQ3805t5/NMFqQyOQ5dQGX2sGmDM2oj5qG6fZd2nguwgTPJsgQtxQr+bOoofMHIjBS9wQQ+bvo3u5lF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ox9hkLEM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ox9hkLEM"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a02718da81so18139835e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 16:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791849333; x=1792454133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECNai7xooL0OUYNeTiNMYW7R9qWrmdzEAeiMs3Y4J3w=;
        b=ox9hkLEMbGjTqnmwQ/qup48AHnVeykL+HWI7J4Y+Jt1bKqNhm1ZXPnjHF/1wYzw2MC
         u47QPXrI/iAu4p6/7bw1+C0zsO1s+s2K8KGkWTqXx7uIPtMhVVElUdX5Hc30ho1WSzOQ
         iLbRyE8DJYEnZdtffHH2Rpr6E3BNiYkeTQ6Z14DaAlN4GebQq7nYnigtctUSIdyLqbtp
         s/oHCI5l+WWMz50GNHhSSP75dH1XQqtYqrt6mMpWEqPMOfBJ3f7MUXLwzryPWpxc+aQ/
         /QA+dkrnVL3kjM7JSBOzTu344ctnU+ICoFO13WuaxVsXy6L/FWJcTxJvaHmHD6e6oom7
         /xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791849333; x=1792454133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECNai7xooL0OUYNeTiNMYW7R9qWrmdzEAeiMs3Y4J3w=;
        b=poki35xb2nDeUiowqiA4UFhy+5JR8tlWN//WkkjOidgSTfuInigd+Wx2IgH6Dk3mwZ
         4mj3y7N6lzPWejV1TQwOJdur8bKBx12ZTZHauckrFkDxU5cDcefrFXQ+wVZGN/F11hjc
         2BHLNP+dCCyNSrwqdatlfMYJg1euxhrJm36w81mjpWg4rdiKyaWIpFXPeKSLSnoRBi2R
         WM5+yfz+vXN5LPPJF00b6hgV4GHTVZcccydkxVaZ4z+4JyGOeFw9Aw0LdouW5vmqQabG
         z9nJX1jw/dJ/6tMeEVhVtENQKWBsxPJkeCeG38K5Jch7AXxGvzeRdS7/fOlqpmyjpVjX
         xmig==
X-Gm-Message-State: AFq9FYJJOVxcj4vSszVSO6wzin6a5+Vark5Erswsy/G7N9rL65A1ae8Z
	QUm0JaSDTxd24O6bjAy5MSpe6ZUhYAGHc1F4cJ8CmcZL0v3MgFvHf0oeeeOpcA==
X-Gm-Gg: AYBFou2tCn6qFxHyNWTjer1NCGkbYrlV5jfNS+9jwu0CwPNsiEJH/UeNAwl+iMAMFQn
	CV/sOoyXlIqWvqtOnn7pqrhjAUkX0o3+QFfWFDLIaiWBWKvtcAkNGUWeiqoeQIVVNAadIzYH/Nn
	lxHkxP/fXGlbLbkDOO9MyYsUAhL06jVgYx9g7Vk7zBE8gsFPqWAIAki4re0mqFZTg+P36Yw28FP
	GA9FG6RDTqvsDmM3aaHK3jhB/KUtHCwc0oskKUOSQbqw8grykjGLNGiWPv7r2kvi6hN1ggSxG5S
	7cbVN2brb2YzoYpKHg09aQnopLn2es77OOkdxTGBNEE0GByxUvPs9wnpPj/0J1yR8OYFgxqnoMl
	qELHG/hSPXkz9mZ3YD+uM4168te2msoq95Ra74AX/B++UDcNzeIlvpLYCxF05c/LNHMDLyn11u+
	f6WvFKxUWKb8r9qrAiOCPwI/+k1+AmajEhNi7rO6Cz8ar5EN+ST4bdUGkFwEfboq1V5wI7+OOp3
	//jQcssaBbxZTsahn9Q1he8MKCgNSxooU2WiXBnFAAeTLkeVruLZjbMMAM=
X-Received: by 2002:a05:600c:5391:b0:49e:7a10:1b71 with SMTP id 5b1f17b1804b1-4a18e4a003cmr208047905e9.11.1791849333467;
        Mon, 12 Oct 2026 16:55:33 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967a0dsm1933762f8f.3.2026.10.12.16.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 16:55:32 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: sgarzare@redhat.com,
	bobbyeshleman@gmail.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net-next 2/2] vsock/test: cover SO_INQ
Date: Tue, 13 Oct 2026 00:55:24 +0100
Message-ID: <20261012235524.41468-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012235524.41468-1-devnexen@gmail.com>
References: <20261012235524.41468-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the SCM_INQ value after a partial receive, after draining the
queue and at EOF, that no cmsg is sent while the option is off, and
that out of range values and SOCK_SEQPACKET are rejected.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 tools/testing/vsock/vsock_test.c | 191 +++++++++++++++++++++++++++++++
 1 file changed, 191 insertions(+)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index b4ff9f946565..00bb68c00c07 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -2429,6 +2429,188 @@ static void test_stream_collapse_server(const struct test_opts *opts)
 	close(fd);
 }
 
+#define SO_INQ_BUF_LEN 64
+#define SO_INQ_CHUNK_LEN 16
+
+static int so_inq_set(int fd, int val)
+{
+	return setsockopt(fd, SOL_SOCKET, SO_INQ, &val, sizeof(val));
+}
+
+/* Receive @len bytes and return the SCM_INQ value, or -1 if the kernel did
+ * not attach one.
+ */
+static int so_inq_recv(int fd, size_t len, int expected_ret)
+{
+	char control[CMSG_SPACE(sizeof(int))] = { 0 };
+	unsigned char buf[SO_INQ_BUF_LEN];
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len = len,
+	};
+	struct msghdr msg = {
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = control,
+		.msg_controllen = sizeof(control),
+	};
+	struct cmsghdr *cmsg;
+	ssize_t ret;
+	int inq;
+
+	ret = recvmsg(fd, &msg, 0);
+	if (ret < 0) {
+		perror("recvmsg");
+		exit(EXIT_FAILURE);
+	}
+
+	expect_res(ret, expected_ret, "recvmsg");
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg; cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level != SOL_SOCKET ||
+		    cmsg->cmsg_type != SCM_INQ)
+			continue;
+
+		memcpy(&inq, CMSG_DATA(cmsg), sizeof(inq));
+		return inq;
+	}
+
+	return -1;
+}
+
+static void test_stream_so_inq_client(const struct test_opts *opts)
+{
+	int fd;
+
+	fd = vsock_stream_connect(opts->peer_cid, opts->peer_port);
+	if (fd < 0) {
+		perror("connect");
+		exit(EXIT_FAILURE);
+	}
+
+	control_expectln("SENT");
+
+	/* Wait for the whole payload to be queued, so the values below do not
+	 * depend on how the transport delivers it.
+	 */
+	if (!vsock_ioctl_int(fd, SIOCINQ, SO_INQ_BUF_LEN)) {
+		fprintf(stderr, "Test skipped, SIOCINQ not supported.\n");
+		goto out;
+	}
+
+	/* No ancillary data unless the option is enabled. */
+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, SO_INQ_CHUNK_LEN), -1,
+		   "SCM_INQ with SO_INQ disabled");
+
+	if (so_inq_set(fd, 1)) {
+		if (errno != ENOPROTOOPT) {
+			perror("setsockopt(SO_INQ)");
+			exit(EXIT_FAILURE);
+		}
+
+		fprintf(stderr, "Test skipped, SO_INQ not supported.\n");
+		goto out;
+	}
+
+	/* Partial read: the rest of the payload is still queued. */
+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, SO_INQ_CHUNK_LEN),
+		   SO_INQ_BUF_LEN - 2 * SO_INQ_CHUNK_LEN,
+		   "SCM_INQ after partial receive");
+
+	/* Draining read while the peer stays connected. */
+	expect_res(so_inq_recv(fd, SO_INQ_BUF_LEN - 2 * SO_INQ_CHUNK_LEN,
+			       SO_INQ_BUF_LEN - 2 * SO_INQ_CHUNK_LEN), 0,
+		   "SCM_INQ after draining receive");
+
+	control_writeln("DRAINED");
+	vsock_wait_remote_close(fd);
+
+	/* Nothing is queued once the peer is gone, but 1 is reported so the
+	 * caller keeps reading until it observes EOF, as TCP_INQ does.
+	 */
+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, 0), 1, "SCM_INQ at EOF");
+
+	if (so_inq_set(fd, 0)) {
+		perror("setsockopt(SO_INQ)");
+		exit(EXIT_FAILURE);
+	}
+
+	expect_res(so_inq_recv(fd, SO_INQ_CHUNK_LEN, 0), -1,
+		   "SCM_INQ after disabling SO_INQ");
+
+	close(fd);
+	return;
+
+out:
+	control_writeln("DRAINED");
+	close(fd);
+}
+
+static void test_stream_so_inq_server(const struct test_opts *opts)
+{
+	unsigned char buf[SO_INQ_BUF_LEN];
+	int fd;
+
+	fd = vsock_stream_accept(VMADDR_CID_ANY, opts->peer_port, NULL);
+	if (fd < 0) {
+		perror("accept");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(buf, 'A', sizeof(buf));
+	send_buf(fd, buf, sizeof(buf), 0, sizeof(buf));
+	control_writeln("SENT");
+
+	/* Keep the connection open until the peer has drained the queue: an
+	 * early close would turn its last SCM_INQ value into the EOF one.
+	 */
+	control_expectln("DRAINED");
+	close(fd);
+}
+
+static void test_so_inq_validation_client(const struct test_opts *opts)
+{
+	int fd;
+
+	fd = socket(AF_VSOCK, SOCK_STREAM, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (so_inq_set(fd, 1)) {
+		if (errno != ENOPROTOOPT) {
+			perror("setsockopt(SO_INQ)");
+			exit(EXIT_FAILURE);
+		}
+
+		fprintf(stderr, "Test skipped, SO_INQ not supported.\n");
+		close(fd);
+		return;
+	}
+
+	if (!so_inq_set(fd, 2) || errno != EINVAL) {
+		fprintf(stderr, "SO_INQ accepted an out of range value\n");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+
+	/* SCM_INQ counts bytes, which a message based socket cannot report. */
+	fd = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
+	if (fd < 0) {
+		perror("socket");
+		exit(EXIT_FAILURE);
+	}
+
+	if (!so_inq_set(fd, 1) || errno != ENOPROTOOPT) {
+		fprintf(stderr, "SO_INQ not rejected on SOCK_SEQPACKET\n");
+		exit(EXIT_FAILURE);
+	}
+
+	close(fd);
+}
+
 static struct test_case test_cases[] = {
 	{
 		.name = "SOCK_STREAM connection reset",
@@ -2633,6 +2815,15 @@ static struct test_case test_cases[] = {
 		.run_client = test_stream_collapse_client,
 		.run_server = test_stream_collapse_server,
 	},
+	{
+		.name = "SOCK_STREAM SO_INQ functionality",
+		.run_client = test_stream_so_inq_client,
+		.run_server = test_stream_so_inq_server,
+	},
+	{
+		.name = "SO_INQ option validation",
+		.run_client = test_so_inq_validation_client,
+	},
 	{},
 };
 
-- 
2.55.0

