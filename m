Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444113;
	b=vk8jTGi/lJsWLKGSlug3Qgr1ssBm7eyX8nAMw1A69v88Siq9ETb1zd/gpqOJRpfkYQZj
	 HCBbtJksJYPc8ziJhx/fw8P3TvbWyf9PQh2veynleNrFdu/W2N0QOJzFk6w2nNYQxFBgC
	 rUQLoEdhpIKLPLaWK9H9HbffP08kctbLYLVLqNv+0Nv9eeULAUcGxL+yglJOZM0imK1vi
	 vv9f5+a/zLouwIfQvl/9zZY8p72Ob3BXx4TnMrUC2M2EsVvrYz9rH3bXdAqbbiOdUsRVl
	 Dv+Liq42+/LEfOkqspCx9VY0S3wFH7wnfd6IZjea7RXASqI4ohsyAJMNcDdcBv38Wuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ESfMlZZa7GvA7bVf8WWgmWKykKfCLssrUodob8vna0g=;
	b=VbgYfjMWfqHgi+LuAYF9ks4N3Z7NXmxUrLIP6c1iz3hefpZDlM5MniDCQszpu9LUTq+0
	 c7E5XSP1cBiC7SHzcsEDM1xVmOGowNdVRoX3kRFylvllFHHJpAF1ytIPT03dmCkyOmEXl
	 E9q5mfaNrWG8Gr7SA/VaV/gsTDrqOoyWeOjAcrIAUXFbtIL9+JMaQKwAavg5/OpfaMVYq
	 lqUD02IunqNe5q7hBcf6wR6oBevgwz1xMh7/ArfteoUgO1J2d71ThFyzf4vQN+0nNMgGO
	 Y1rARxnJ+jfumCTKEKPHWx6lxaXfXbVxFAWF8bq49XthLGWso/JZsVQ3REc2HNCk4jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Fpf8oxkD;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDE9606A319
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFDE9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Fpf8oxkD
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd60d155070so1137309a12.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792444112; x=1793048912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ESfMlZZa7GvA7bVf8WWgmWKykKfCLssrUodob8vna0g=;
        b=Fpf8oxkDgQ8CQNIz7ZYYnRGYtYU2+GJmGN58W440OWloj8rVHBSz6XyqbkUuRdAJnz
         S1jWoBAHLZOE/4RzrgBDUHqcWwPEQxWL1hvWFXepOXK9NqFepLmgDRp4HmjAnoNKkCbI
         iHA0p+cL3//cTdNPidFR+H80zqLLI8ZgANNeL76+Nw7c6vMMlImPR9QWaXqILLwcN0k3
         HSrmyhO0Je6/qNbjpuusGpBkMXYE9S3vawnHsC28rLXaidnDpWa+Hzlpx4FTT9+Tv9Dg
         8dxCMDITleD6zKGgGo6nAQB2X0LIIrPxlrhwRDgr2/SFafZjNcgy87KuDDQmy0OB3TkN
         BGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792444112; x=1793048912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ESfMlZZa7GvA7bVf8WWgmWKykKfCLssrUodob8vna0g=;
        b=TulQ81tKiyLfj+JCmweqXn/WpZ+mifwjZPgBGc7HMTZkZkUMDV+oN0yo/f1b4AiKBi
         To0Kgvi78yMsCBP8tbMoomrYIj5ZkitvVP35fajZkGXxROm46HsbyAZ5O3JB/jbDpH6I
         HC9YRiWFp7xx1JpvNcLHYZWh6b1mdo0ZtLYtejpJbJWa/0ig5kYqFveHKFcm2teR+tHn
         9GgGkDWF7MupCphHU99fDEXE3mpjzX25oW3eyRGbJlPO4Y+QzYIrK1YrgfQH7Hd9PRWa
         T0eQtYfywgIfIym/NNQ9hj8ag0uyFgnTps79wwIGfFDEjBPaQdl7XT+E83xRTl+XA6Mg
         6RkA==
X-Gm-Message-State: AFq9FYLmzQiFTMN5Mz3sa6RjOwfzc/jP1qQ0xK7BETiTgcR9JouJsqSa
	csR1HoVDubQiRfEksmPdByE5WPLdp/AwCNoC0P+D3D4nS1QY6FsPBThs/YXzPnrOW13MM/QG9ua
	jx6J4zTs=
X-Gm-Gg: AYBFou3+rmoTIGl/5Sb5seVDuF0NArZsYtLk5sVZnlYXVGPBmiG7we3j2CqLGfKSZCL
	DXy7Cei3LoTT6v+lzHAXX0q45D/OAYuEObEn7OzQzQkLCWbdoJKlk7zUEcb/nPejfE6mheIiR6M
	OYCys8lpUDALHM6jswoCBUntOwAVzk+X7CRm7CI5ijjq6RIPMV/NAt/xSLhG3U5YHgv134sJr0w
	m+/lyeI3jZN44KP24MuFlhPfokJO6yJ7zAh/ShQVqnshg1R40fSVLE7X+JlVSVsDv4OG7UsSKtk
	I6xsiJ8B/m6bRyQBP8bpe4M1da81E5yr4/q+kRZJtue/2W+21zmp1qosHfm0aYxizQ9wkcuGiJP
	TIBXV1zR9ku3t1Vt8sy5DEpI+IAQO64DGcMNIfzuuYm5KuUuTVNpvGiL9EwWc5c8UR8yeJIQThn
	q/+OqyaJMEt/G3FLNhvFQniSaQ114F3eCiRpZJgXs2tFkChkU4KCCC8npud57Kbmi72cO6NwKYJ
	gJEx7Nu7c2VHdn5MAonIYqD4id9UwjhNdRwtw==
X-Received: by 2002:a05:6a21:1f88:b0:3de:51e1:e7bd with SMTP id adf61e73a8af0-3e225fbd745mr6753507637.47.1792444112153;
        Mon, 19 Oct 2026 14:08:32 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549eea48sm4480123a12.19.2026.10.19.14.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 14:08:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute] libnetlink: ignore netlink messages not from kernel
Date: Mon, 19 Oct 2026 14:08:29 -0700
Message-ID: <20261019210829.1019715-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

A process with CAP_NET_ADMIN in its own netns can send forged
netlink messages to a monitor, by multicast to an all-nsid listener
in another netns or by unicast to the monitor's port.

Filter on nl_pid in __rtnl_recvmsg() and use it in rtnl_listen().
Dequeue the datagram when peeking, and restore the value-result
msg fields before retrying.

Reported-by: Anthropic OSS scanner
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/libnetlink.c | 51 ++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index edf3a8ba..a07cbeef 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -825,13 +825,21 @@ static int rtnl_dump_error(const struct rtnl_handle *rth,
 
 static int __rtnl_recvmsg(int fd, struct msghdr *msg, int flags)
 {
+	const struct sockaddr_nl *nladdr = msg->msg_name;
+	socklen_t namelen = msg->msg_namelen;
+	size_t controllen = msg->msg_controllen;
 	int len;
 
-	do {
-		len = recvmsg(fd, msg, flags);
-	} while (len < 0 && (errno == EINTR || errno == EAGAIN));
+retry:
+	/* value-result fields, restore if discarding a message */
+	msg->msg_namelen = namelen;
+	msg->msg_controllen = controllen;
 
+	len = recvmsg(fd, msg, flags);
 	if (len < 0) {
+		if (errno == EINTR || errno == EAGAIN)
+			goto retry;
+
 		fprintf(stderr, "netlink receive error %s (%d)\n",
 			strerror(errno), errno);
 		return -errno;
@@ -842,6 +850,19 @@ static int __rtnl_recvmsg(int fd, struct msghdr *msg, int flags)
 		return -ENODATA;
 	}
 
+	if (msg->msg_namelen != sizeof(*nladdr)) {
+		fprintf(stderr, "Sender address length == %u\n",
+			msg->msg_namelen);
+		return -EINVAL;
+	}
+
+	/* Only accept messages from kernel, discard anything else */
+	if (nladdr->nl_pid != 0) {
+		if (flags & MSG_PEEK)
+			recv(fd, NULL, 0, 0);
+		goto retry;
+	}
+
 	return len;
 }
 
@@ -1248,27 +1269,11 @@ int rtnl_listen(struct rtnl_handle *rtnl,
 		}
 
 		iov.iov_len = sizeof(buf);
-		status = recvmsg(rtnl->fd, &msg, 0);
-
-		if (status < 0) {
-			if (errno == EINTR || errno == EAGAIN)
-				continue;
-			fprintf(stderr, "netlink receive error %s (%d)\n",
-				strerror(errno), errno);
-			if (errno == ENOBUFS)
-				continue;
-			return -1;
-		}
-		if (status == 0) {
-			fprintf(stderr, "EOF on netlink\n");
+		status = __rtnl_recvmsg(rtnl->fd, &msg, 0);
+		if (status == -ENOBUFS)
+			continue;
+		if (status < 0)
 			return -1;
-		}
-		if (msg.msg_namelen != sizeof(nladdr)) {
-			fprintf(stderr,
-				"Sender address length == %d\n",
-				msg.msg_namelen);
-			exit(1);
-		}
 
 		if (rtnl->flags & RTNL_HANDLE_F_LISTEN_ALL_NSID) {
 			memset(&ctrl, 0, sizeof(ctrl));
-- 
2.53.0

