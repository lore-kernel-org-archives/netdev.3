Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863D3F86EF
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 02:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812382; cv=none; b=Wh7QYoTjhg4Vd/qxnzpHLHLb8+9GD0SUNOZUZM6aodB8r78+XEwHAf9I3jrgwXCVL8Ge4agoJV9Crv35BVZj740LjMcHQrm1ziMndjqYHLCFFz0jdbg4jmj3wOg1q26nc7vNlWypZ/Yw1nMbNd+dp01yMXj0bBjowC5uwBM4Jiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812382; c=relaxed/simple;
	bh=H0UkMIe4CsIcpxmyZN1Ww99+u120SPTOqvKQ5GFRMAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G48MY2bhDu0V4rd3O9kBbrQ+cNepKhxra9dSTkyFMy8W10PE6pPjldbPp8ZMT3jZ5kyx6Mm/sPprKC0dxON+/SvkkmFz4EZLGqDV8jdaGkzG5kfD4Pz6BNniPqf2uLUOABfoiU4/v5dAdjDIbAS206TNGlVdTqRRRA4KIyxu7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLVNK0jc; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLVNK0jc"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso383256a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 19:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785812381; x=1786417181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jmT/3flv0l5fERcYAXy6zGT7XeDtm3nxWHOeoNo8+6g=;
        b=SLVNK0jcCd9rz4z1O9bVlrwxWuIGHtT7Ov3Wia8WcOx7cah/lrc1t9r+jplPbJ5x91
         mp3DQW4EKBiWZX9ZUVw3DVnr/Pkvaw+wU2syXou1ul2+5qY/b6fj9hVAHWJD4VYYr9hx
         n8WVjRiask9+XzHyE4d9stsKEwbJ7Ye8jI+xEsE1fTWfxbCuDxyvNEswriY4n0WU3yLN
         gXUFF/JwWIklI1NqQHo8pszitiX5cC5KfnEaRZJ2+1QSOd1Cod3maTW7KG3yZrEaAX/k
         r5DDD0iBZiOJvrvH7+vxIMC0vEV9xGRwOfh1TBdHCgcKKU/A90Oo1uKMuLIJz9s0FCuz
         pS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785812381; x=1786417181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jmT/3flv0l5fERcYAXy6zGT7XeDtm3nxWHOeoNo8+6g=;
        b=WtawguqGKmYkLRidl7URx3H3YqIEnCTkAQR+qbiS7JpctoD4H3J19cwSGupG1PcfLf
         RmlBMc3RtBwCu0KwIDb2pkxJr/QJ5pXVbZXd2Sqv+XAYHpPfGCRm/xgnNDYUgfMEOnZj
         eplC1/wdITJr3CKRVQF0l+b02hzcGxwyFz5MNKu05bicoNO5alD/Ou87hk/hTZGfOPlp
         oL1VbcnUYOha1aG5E8KBcvvNVS5aqU3IYceyb0Izg0EAZlIrwSckZ244bUUR/TNnXZeW
         fezy3EIo3fJRFMThxvsFJSY5tJ3IBr2PQqXkJWOsANZVQkF2pQ9Ubg7eB8z7/SA0EoK4
         TmSg==
X-Gm-Message-State: AOJu0YwQPxB+OD+zFmh1FSDMDfgiMnAjaNQP6nu8Z5uRTKxOh/suo9Vv
	YNSNymJlTuOBS/Qfc/YylW+KhMnwA5vzS/xrAq+W0Vn8x227BhBqh85urh6F+63O
X-Gm-Gg: AR+sD12bQs1H3hzoV3FmyH3ZhEQeBQGsvvAOGQ9PO/4wwLUpOkopZ/KxfiC0JInHyWS
	14ZHL4y3xHNZHAmkHOjE/HIrx3edu8KjqznsPEwteoKWEElGfy5JRQmH75QPTJhDErRmOobXsPn
	C7SokhO+5m/fp0lPft5DjcwT5IoQSgDCyp3XY6rCt2xa1TCD1j5dkGwzzsH2+KAjtEKlgplrDqN
	zIYrNzIsO5O/UV4Ck2iln+Yc8jPMcBgyxCAsISiVszNjQyjjfb6K5zYjp1ORFf0uoNvBeDQaKNz
	/S1N07Hnj3QeQBQmUXyy1jf1CVLqtV53bNooJXFhiYap0uVXQsRFx0PmXqTp7MTREDE5B+fyax+
	psEs5a1/IMQSbFqD6KyP8W03lXRymXFPiTKsO3OeSS+n1ODj3C2SFDwKe2z5zgJtpXSvMhtqP8U
	DJTdYHKPLQs00VDbKHuLy9wy0IC3tgedC12YAC/rr+WylADGZ3qFLLwHbv/xy0rsBd6g==
X-Received: by 2002:a05:6a20:9e47:b0:3c0:b598:4983 with SMTP id adf61e73a8af0-3cb6ca54d23mr2124033637.30.1785812380841;
        Mon, 03 Aug 2026 19:59:40 -0700 (PDT)
Received: from fedora ([2804:1b3:a8c3:8ee5:1c39:64d9:e257:73dc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab2530c0sm35974758c88.8.2026.08.03.19.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:59:40 -0700 (PDT)
From: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
Subject: [PATCH net-next v2 2/4] selftests: net: test IPV6_FL_F_REMOTE
Date: Mon,  3 Aug 2026 23:59:08 -0300
Message-ID: <20260804025910.50145-3-marcelomspessoto@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804025910.50145-1-marcelomspessoto@gmail.com>
References: <20260804025910.50145-1-marcelomspessoto@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag retrieves the flow label seen by the socket at connection
setup via a getsockopt query. Therefore, the validation of this flag
requires a brief connection setup (source code for flow label shows
it must be TCP).

The simple TCP connection logic was wrapped inside two simple helpers,
because there are other uncovered features of flow label mgr that
could benefit from it (such as IPV6_FL_F_REFLECT).

Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
---
 .../selftests/net/ipv6_flowlabel_mgr.c        | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/selftests/net/ipv6_flowlabel_mgr.c b/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
index 01fab414895c..d482be2e9f9f 100644
--- a/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
+++ b/tools/testing/selftests/net/ipv6_flowlabel_mgr.c
@@ -24,6 +24,9 @@
 #ifndef IPV6_FLOWLABEL_MGR
 #define IPV6_FLOWLABEL_MGR	32
 #endif
+#ifndef IPV6_FLOWINFO_SEND
+#define IPV6_FLOWINFO_SEND	33
+#endif
 
 /* from net/ipv6/ip6_flowlabel.c */
 #define FL_MIN_LINGER		6
@@ -95,6 +98,66 @@ static int flowlabel_renew(int fd, uint32_t label, uint16_t linger)
 	return setsockopt(fd, SOL_IPV6, IPV6_FLOWLABEL_MGR, &req, sizeof(req));
 }
 
+static struct sockaddr_in6 loopback_addr(void)
+{
+	struct sockaddr_in6 addr = {
+		.sin6_family	= AF_INET6,
+		.sin6_addr	= IN6ADDR_LOOPBACK_INIT,
+		.sin6_port	= htons(8888),
+	};
+
+	return addr;
+}
+
+static int tcp_listen(void)
+{
+	struct sockaddr_in6 addr = loopback_addr();
+	const int one = 1;
+	int fd;
+
+	fd = socket(PF_INET6, SOCK_STREAM, 0);
+	if (fd == -1)
+		error(1, errno, "socket listener");
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)))
+		error(1, errno, "setsockopt SO_REUSEADDR");
+	if (bind(fd, (void *)&addr, sizeof(addr)))
+		error(1, errno, "bind");
+	if (listen(fd, 1))
+		error(1, errno, "listen");
+
+	return fd;
+}
+
+static void tcp_connect(int listener, uint32_t flowlabel, int *client, int *accepted)
+{
+	struct sockaddr_in6 addr = loopback_addr();
+	const int one = 1;
+	int cfd, afd;
+
+	cfd = socket(PF_INET6, SOCK_STREAM, 0);
+	if (cfd == -1)
+		error(1, errno, "socket client");
+
+	if (flowlabel_get(cfd, flowlabel, IPV6_FL_S_EXCL, IPV6_FL_F_CREATE))
+		error(1, errno, "flowlabel_get");
+	if (setsockopt(cfd, SOL_IPV6, IPV6_FLOWINFO_SEND, &one, sizeof(one)))
+		error(1, errno, "setsockopt flowinfo_send");
+	addr.sin6_flowinfo = htonl(flowlabel);
+
+	if (connect(cfd, (void *)&addr, sizeof(addr)))
+		error(1, errno, "connect");
+
+	afd = accept(listener, NULL, NULL);
+	if (afd == -1)
+		error(1, errno, "accept");
+
+	if (flowlabel_put(cfd, flowlabel))
+		error(1, errno, "flowlabel_put");
+
+	*client = cfd;
+	*accepted = afd;
+}
+
 static void run_tests(int fd)
 {
 	int wstatus;
@@ -204,6 +267,27 @@ static void run_tests(int fd)
 		expect_fail_errno(flowlabel_get(fd, 6, IPV6_FL_S_ANY, IPV6_FL_F_CREATE), EPERM);
 	}
 
+	{
+		struct in6_flowlabel_req freq = {
+			.flr_action = IPV6_FL_A_GET,
+			.flr_flags = IPV6_FL_F_REMOTE,
+		};
+		socklen_t freq_len = sizeof(freq);
+		int remote_listener = tcp_listen();
+		int remote_cfd, remote_afd;
+
+		explain("Prepare TCP SYN for REMOTE flag validation");
+		tcp_connect(remote_listener, 7, &remote_cfd, &remote_afd);
+
+		explain("Query for label sent by client with IPV6_FL_F_REMOTE");
+		expect_pass(getsockopt(remote_afd, SOL_IPV6, IPV6_FLOWLABEL_MGR, &freq, &freq_len));
+		if (ntohl(freq.flr_label) != 7)
+			error(1, 0, "unexpected remote flowlabel %u", ntohl(freq.flr_label));
+
+		close(remote_afd);
+		close(remote_cfd);
+		close(remote_listener);
+	}
 }
 
 static void parse_opts(int argc, char **argv)
-- 
2.55.0

