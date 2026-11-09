Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188680;
	b=Pj6pweGCU8eYiV1eN2hfCXZIQ88MKI4vVsYFxN7J1TUYdEbIxgWYit2mKj08V67U08MD
	 awsKBKSK0Gt0DEiKRPEm2TFBgg/oze4CLUtqc7PfFfAAvIPgWe0Whqu4JZ3fadS9cT/fD
	 cGLJXcqaSATqGzBhbFExFgEgOcMDVlC28V26dFcEBWvNs1FgrgS1vvbdOsrhb3BXZv/EA
	 6InF0QigtdjxVc/3IOKbR3fHZjs0ZmErFXdDIwZwjyxhOCKbd2+PM9vyy3y8CpcREExHK
	 cd9w5M7jb/Lae9EyQly36z3jV5Ke7W2XGL3auhvAi9qXb5+Q2kfN9ae9l9nSrJAEN5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=g5J/aOBvgTo8YDMv6UDQhVKZORAcQYXvMorhpgrKPmg=;
	b=GCnupUEjAHBsWx5kMIx8LdHv1FZsH5FpX2UQQUnai5dnangcL7HUqGSXalRZdSUPz/iL
	 WSt7cIqczdLEMu0BdMqnkYZ5aiP0Lww+00tblDHYm1yhjqjpX+x2rPQcPr3UGPyr6/2o+
	 yn8LWvMXeFVR9D9tYSNfre2DvYBBMnEw3udPCw0S5GiPRMxGBlS6JcU2YG3Zy+Qnyhl5N
	 OAiIaP2mBn9NSSxlU7Xu4/mUXp9r23RtlhOIapR0RiJnrWRvKGW4nahOLe+zuhPtJF6/F
	 A2HTP/gu99zST6/KPhqv+08ick7u9KsiIIGtYcYMp1yIctdYv8YpMcgC7mVGq+wHIvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Zf1kA+cz;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692B5606A33B
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 692B5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Zf1kA+cz
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso94936a12.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 17:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794188680; x=1794793480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g5J/aOBvgTo8YDMv6UDQhVKZORAcQYXvMorhpgrKPmg=;
        b=Zf1kA+czPwCAVcoaRM3Jj1tyhP4DwcJe01mniu+e2gI1bPuBmTKY8YxRVSfAYlcJdt
         rFfHRZLwG16FM0zEmLllgspmfeYtY2vFn/HgGUUSzi6Po3XqhXgBWDXluXtcZy35VSQc
         9jAixggQR737mcDoFAUYcSRWQ5hto/HMC/VBoTbM5MSI4Hles23jKZPINs/0QgQnO1n1
         62rHbAUP7Y9WhoHHdgxxo8gEmcrsFaWGgFao/y5NbmZkrYbvi/bvgRaOXrBcTkHYessD
         P38nizqn9FiDe397b5whX6WK52wtbnfHmANe0Evxf0fj/+gmRqBsf/W5dQ6oLX3IAcyR
         gENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794188680; x=1794793480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g5J/aOBvgTo8YDMv6UDQhVKZORAcQYXvMorhpgrKPmg=;
        b=NT9Ky4tjTaV18Cb8FDe7fqhHGK11WLZWkV+hjPIkk14xjQkkCjimKIibQ+IRtOk1yJ
         NgaWWFKlRFbwW74/J4f3zihwftzNf2AZcGxP4u6kr5bj5ozoycwuRT/dWoKcMdIqOicl
         loH4rzQCrzTllYc/SSu6Sg6G+212GWYdq90wqss+J1yEBdObfOP16IrrNVcrDUUgTfqJ
         /H8fGQlPPirJB/WhRdPERbTHZXDGI44b71LBqfB6IfA9sgs0BGMhXRNoBp/QtXKfDFQz
         t/qCCmCvSXC8lSXsaIRKcub1CKn36xeDghkUkEJHCNP+n3DeBzoriKDmeNp2nZ9EZ6Gx
         k0cw==
X-Gm-Message-State: APuU4Z8CCOMdyXflKX1gSlkj8G8JKquFrNmOXe2PpS7Y7ZjOyZUJhQri
	r9RlSxXOg8keMHW91iIPN8CHONLewLuSOX6BhoMhK6fls6XqWzQsxANC8g4adqOPROGpBDH2PLj
	gRBcqt9g=
X-Gm-Gg: AYBFou1lFxSCus06G3KCHNwmiTDajVL+fTQAbXDKeRfURE0KmUWl+2F/IjUWtgU9Eu0
	t8TPHugpzrjiYW3ZosyUTbG0jBoLW3WyYTcji4mvhMIH4YDuZzeVpDWvnsd651NDYEdH4cibFE2
	JLsJzUUlr9T5stgO09t1Qrvm3FRAO14tdDEd7q8kztncZJ1bwcf0A6kQTZv837gP1sx3Zqy0WBN
	BP1Z5UrbO8yCP8pVxUnH48IE/dJPPHVDrFku6t/oxFPHf6PbrwMVcGMFRqfmYMFxt/eAK2UlFaL
	efXAEsPHUW1x0BvI962RgGAEYN1Tv/gcB7EZOMdQMDfF4okmtCM3Rx+otp55JdnRmWIg5WK0mjF
	k+MtZfjJ34G4055IGxFtwYA2RgjvB48TVPAPLuzgNAfHHGIN2te9WJ9adl7ynE5ATfK20qZ3ibz
	sW8nTBl6XidFmLuPYgbm0KJcSVRtbtJ1bVivxTNi1pbu1m3QkMvRlDTDwauzCrdGOrsT6oXt23P
	dbxHaYdqcEQ0pAGNGZMdT6n0LvozJzfRZgSZT1GondvZDR5hiskuSLrEzIWCsFkoWf2J9s91W07
	6PBBceL5vMUaUpt2JBgmrdxYHs9CH3mVpbTICP6Rae41psSOqVgYOLMTTKrRZTUxl4WmTLA=
X-Received: by 2002:a17:90b:47:b0:3a8:7096:9b48 with SMTP id 98e67ed59e1d1-3b12d105c47mr2369503a91.1.1794188679728;
        Sun, 08 Nov 2026 17:44:39 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc1bc1e6sm5641735a91.0.2026.11.08.17.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:44:39 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 2/5] netlink: ignore messages not sent by the kernel
Date: Sun,  8 Nov 2026 17:43:59 -0800
Message-ID: <20261109014434.115922-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109014434.115922-1-stephen@networkplumber.org>
References: <20261109014434.115922-1-stephen@networkplumber.org>
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

A process with CAP_NET_ADMIN over the namespace can send unicast or
multicast netlink datagrams to iproute2 tools. rtnl_listen() and
mnlu_socket_recv_run() never checked the sender, so monitors print
forged events and exit or overflow on malformed ones. The dump and talk
loops checked nl_pid only after framing checks and after ss -D had
recorded the datagram.

Drop any datagram whose sender is not port id 0 right after recvmsg(),
in rtnl_recvmsg(), rtnl_listen() and a new mnlu_socket_recvfrom().

Reported-by: Anthropic OSS scanner (ANT-2026-ISEFARJF)
Reported-by: Anthropic OSS scanner (ANT-2026-GYQAKSVI)
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/mnl_utils.h |  1 +
 lib/libnetlink.c    | 36 ++++++++++++++++++++----------------
 lib/mnl_utils.c     | 35 ++++++++++++++++++++++++++++++++++-
 rdma/stat.c         |  2 +-
 4 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/include/mnl_utils.h b/include/mnl_utils.h
index d809383c..19a49de6 100644
--- a/include/mnl_utils.h
+++ b/include/mnl_utils.h
@@ -28,6 +28,7 @@ int mnl_add_nl_group(struct mnl_socket *nl, unsigned int group);
 uint32_t mnlu_next_seq(void);
 struct nlmsghdr *mnlu_msg_prepare(void *buf, uint32_t nlmsg_type, uint16_t flags,
 				  void *extra_header, size_t extra_header_size);
+ssize_t mnlu_socket_recvfrom(const struct mnl_socket *nl, void *buf, size_t buf_size);
 int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, size_t buf_size,
 			 mnl_cb_t cb, void *data);
 int mnlu_gen_socket_recv_run(struct mnlu_gen_socket *nlg, mnl_cb_t cb,
diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index 6ff9cace..b923ba02 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -843,12 +843,22 @@ static int __rtnl_recvmsg(int fd, struct msghdr *msg, int flags)
 	return len;
 }
 
+/* Netlink datagrams from other processes are discarded */
+static bool rtnl_from_kernel(const struct msghdr *msg)
+{
+	const struct sockaddr_nl *nladdr = msg->msg_name;
+
+	return msg->msg_namelen == sizeof(*nladdr) && nladdr->nl_pid == 0;
+}
+
 static int rtnl_recvmsg(int fd, struct msghdr *msg, char **answer)
 {
 	struct iovec *iov = msg->msg_iov;
 	char *buf;
 	int len;
 
+again:
+	msg->msg_namelen = sizeof(struct sockaddr_nl);
 	iov->iov_base = NULL;
 	iov->iov_len = 0;
 
@@ -873,6 +883,11 @@ static int rtnl_recvmsg(int fd, struct msghdr *msg, char **answer)
 		return len;
 	}
 
+	if (!rtnl_from_kernel(msg)) {
+		free(buf);
+		goto again;
+	}
+
 	if (answer)
 		*answer = buf;
 	else
@@ -918,8 +933,7 @@ static int rtnl_dump_filter_l(struct rtnl_handle *rth,
 
 				h->nlmsg_flags &= ~a->nc_flags;
 
-				if (nladdr.nl_pid != 0 ||
-				    h->nlmsg_pid != rth->local.nl_pid ||
+				if (h->nlmsg_pid != rth->local.nl_pid ||
 				    h->nlmsg_seq != rth->dump)
 					goto skip_it;
 
@@ -1066,12 +1080,6 @@ next:
 		if (status < 0)
 			return status;
 
-		if (msg.msg_namelen != sizeof(nladdr)) {
-			fprintf(stderr,
-				"sender address length == %d\n",
-				msg.msg_namelen);
-			exit(1);
-		}
 		for (h = (struct nlmsghdr *)buf; status >= sizeof(*h); ) {
 			int len = h->nlmsg_len;
 			int l = len - sizeof(*h);
@@ -1088,8 +1096,7 @@ next:
 				exit(1);
 			}
 
-			if (nladdr.nl_pid != 0 ||
-			    h->nlmsg_pid != rtnl->local.nl_pid ||
+			if (h->nlmsg_pid != rtnl->local.nl_pid ||
 			    (unsigned int)(seq - h->nlmsg_seq) >= iovlen) {
 				/* Don't forget to skip that message. */
 				status -= NLMSG_ALIGN(len);
@@ -1246,6 +1253,7 @@ int rtnl_listen(struct rtnl_handle *rtnl,
 		}
 
 		iov.iov_len = sizeof(buf);
+		msg.msg_namelen = sizeof(nladdr);
 		status = recvmsg(rtnl->fd, &msg, 0);
 
 		if (status < 0) {
@@ -1261,12 +1269,8 @@ int rtnl_listen(struct rtnl_handle *rtnl,
 			fprintf(stderr, "EOF on netlink\n");
 			return -1;
 		}
-		if (msg.msg_namelen != sizeof(nladdr)) {
-			fprintf(stderr,
-				"Sender address length == %d\n",
-				msg.msg_namelen);
-			exit(1);
-		}
+		if (!rtnl_from_kernel(&msg))
+			continue;
 
 		if (rtnl->flags & RTNL_HANDLE_F_LISTEN_ALL_NSID) {
 			memset(&ctrl, 0, sizeof(ctrl));
diff --git a/lib/mnl_utils.c b/lib/mnl_utils.c
index 44e54aa8..8ddf2b90 100644
--- a/lib/mnl_utils.c
+++ b/lib/mnl_utils.c
@@ -5,6 +5,7 @@
 
 #include <errno.h>
 #include <string.h>
+#include <sys/socket.h>
 #include <libmnl/libmnl.h>
 #include <linux/genetlink.h>
 
@@ -111,6 +112,38 @@ static mnl_cb_t mnlu_cb_array[NLMSG_MIN_TYPE] = {
 	[NLMSG_OVERRUN]	= mnlu_cb_noop,
 };
 
+/*
+ * Like mnl_socket_recvfrom(), but discards datagrams that were
+ * not sent by the kernel.
+ */
+ssize_t mnlu_socket_recvfrom(const struct mnl_socket *nl, void *buf, size_t buf_size)
+{
+	struct sockaddr_nl addr;
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len = buf_size,
+	};
+	struct msghdr msg = {
+		.msg_name = &addr,
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+	};
+	ssize_t ret;
+
+	do {
+		msg.msg_namelen = sizeof(addr);
+		ret = recvmsg(mnl_socket_get_fd(nl), &msg, 0);
+		if (ret < 0)
+			return ret;
+	} while (msg.msg_namelen != sizeof(addr) || addr.nl_pid != 0);
+
+	if (msg.msg_flags & MSG_TRUNC) {
+		errno = ENOSPC;
+		return -1;
+	}
+	return ret;
+}
+
 int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, size_t buf_size,
 			 mnl_cb_t cb, void *data)
 {
@@ -118,7 +151,7 @@ int mnlu_socket_recv_run(struct mnl_socket *nl, unsigned int seq, void *buf, siz
 	int err;
 
 	do {
-		err = mnl_socket_recvfrom(nl, buf, buf_size);
+		err = mnlu_socket_recvfrom(nl, buf, buf_size);
 		if (err <= 0)
 			break;
 		err = mnl_cb_run2(buf, err, seq, portid,
diff --git a/rdma/stat.c b/rdma/stat.c
index f2c2d173..01cc171b 100644
--- a/rdma/stat.c
+++ b/rdma/stat.c
@@ -735,7 +735,7 @@ static int stat_one_qp_unbind(struct rd *rd)
 	 * then rd_recv_msg() always return -1 here
 	 */
 	portid = mnl_socket_get_portid(rd->nl);
-	ret = mnl_socket_recvfrom(rd->nl, buf, sizeof(buf));
+	ret = mnlu_socket_recvfrom(rd->nl, buf, sizeof(buf));
 	if (ret <= 0)
 		return ret;
 
-- 
2.53.0

