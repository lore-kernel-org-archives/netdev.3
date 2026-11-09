Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188681;
	b=ToiBBnVJCwp0I4H2rZZAyDerhD5P0reAeDlpnH5JHBTAweeXVpPeX1MTzhtSG2VgstjF
	 o0vIzL17rHG3OEvqIIeXfgSyAWrYSsPVgC2lTDkx7/nQRyDhByZqEqXqdk3lJyooZD3Ad
	 72OYZPtp46W8y6dBtDH20LTEbanMRnYgyB+oeHCMmbeZk1+ecj87CRtLFV+1rWjT9l1A9
	 jamSKIAqjuJy1cObLmYKAPFxetlozhq1S4VHaDq+0s385lQ4KfmACcg+5M5V4rMP4HkGu
	 ALOfy6p8MyEE83MXd8PZF0fID/HqrCaVGQ1CE+Eh3CaVfzkkptNfgkjmqCbOmarCMRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NNwvO7TmJQtnxU+ywtGhB/dcWKqg+cfjcl1zoCnHJ0g=;
	b=XLj62TUbEuLsGjPeURz7ljrtzJ74kwIb6OOb7YO+ufpyq3V32UvlVy13SEc0R8UjI1S9
	 prxJEYiCXZ9vesJwX3pzvsjCmWm09Rjq3xr0vUORGg4CQ+kC1zQ0WcgUYPYdLqdB0G8yb
	 I3PLLEAUEp4KEBHmt32L0quettgk0jRdydHEeABhOd4264uCnOvVTI32ZxABBA2JmtfWw
	 Xf2aSa8zjghmHi2vvPOAYPA859F8OqWYKfwuSO7b/Kr5H/S1E0MsFAeAL3+zI2xADd1GZ
	 Z8wiV946wh41bXYguIpPt93F+OHxXRcifJ8N/cQSP6IW0uD/88iQfiiU3un0/bE5pbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=W5yQOp6N;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2147A606D801
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2147A606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=W5yQOp6N
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b09c07b3d2so172965a91.3
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 17:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794188680; x=1794793480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NNwvO7TmJQtnxU+ywtGhB/dcWKqg+cfjcl1zoCnHJ0g=;
        b=W5yQOp6NHFlKMpL/T9+IXosVn/BSCaTvw8o4jeHuqTBLWHmaVKQoXkWBojAsfGk9CG
         KWQvKnoVf4z6VjtLnKnxlRN+SgMpcu/DV2UJ0jilCwUEU/IBUe+n5WQWaabZeWlC/9vt
         UsYmtOwLQ8qO0ffff2XM4wFGDZyQ9WJMH+lhqUWN9U30rni/HAY3d6d1P0rvgKBiOk/x
         dXhk++4cCoyuOd/+F2vGIgyhU4hI3Ctb3OFtNLyRA6/ESmxCozV0kQV0+Tnf53oRE9w1
         2P/qprrjkz/X6mfr/AeX+OyxhQgz9x7qCKWAoQdLuD3NR0eFoOAQVWKUKSQcvUzs73F4
         W/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794188680; x=1794793480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NNwvO7TmJQtnxU+ywtGhB/dcWKqg+cfjcl1zoCnHJ0g=;
        b=wanCtYtgGh6Mxj4uv0bxtsyRLo1AsvtQWoldoEYkdbAsW/86shxTRpVysmjYOqBvz8
         BCfE8/CwPAvi/Vc2GvWuO3xSoNNoVMVXW+NS/l9iMYI8lk1HDGo5/w3fSIor0TauigbX
         dovkGWFNqRSqquC6FFk6jqL+5zhdDbp+/HdjHmtL+fPYYOgNYbFxhw9LpLKaNX2uktHj
         ipqbyD+0Q0Nt9aa2C3zxDvQsNU/WWmblWIzyP3LS4BaD0sSfAYwuEm7N6NxQP7wasF1l
         D7To+KvhUYsdCwo88l0tefmWZrxHm1miWIQopiJate/UGkCg/eu2hFwmxqaQZaPpCwQA
         uE/Q==
X-Gm-Message-State: APuU4Z+BL4xx5bbnnobBSzlhos/LEpQbTo0OkprXcjq+gyp4OvQc6cIm
	Q+sea7obgBukT09DslF8CGqZWMdbBVdLkk3I0EPuewRJK+TeD0GgRpDxFE1jIWHmUQyJLX0QG5w
	NF9G0
X-Gm-Gg: AYBFou0L8dRxQMC1gIOvcXW9/teeged/ENPDtegMAvZ9jHe37yaUvc7TRMjwdG5FiW7
	3I8pgHEU07uK78tqdV0yM+fnmLYfnz/23AiaiYZ1fa069Lq6uJj3/7SH4NqQnl5wnDiHsjfBVvD
	XzUR8lsD2Huds1yR4dNBgMqATtwTSv+l27kc4GWjuKH2Bmr1uULdf8OUuaPAwizcseEOhm6y9My
	aiJ9VWT+E9wKz6FjIqDltgf2d21i8NgbfHK1vW1tedH7fbDTsu9wtwPuxM1XTmpAmIFvnN4AhPY
	5pPa6XWKt5ZLrH4M1EQQuUnX7hWciYV3KK3uH9IyMTufQsQS2DpkyfMCjkbCVSC3UOXhV3UozVx
	YU5Y6mFSboNwBUNGh7GD8+K+XJAdiMqr6A7s/8S3f/ox6MJScz6O7g1gntv8FgJ8iIDnkgTI15J
	VJr0NJ1/KQfPhGnR5RlWcRVhz3USPsAuN+xeDtNfxHovBE+HDN9CVwUw3jKHDxwBYhb3Ws0L1FA
	q9fHSvYUMR2N7U+ZMWRJyDmpkwiWk9hEyAsRlF1GmkF/4VfLhXRDXPzfg8NjZM1hxrTZalN1Awy
	elgWYyvxXngDBoRmtDp+ioXe/kfb3F89V8PM3xsIvT4lG2jLIehBEMht2S3owoAMWbivHpM=
X-Received: by 2002:a17:90b:1c09:b0:3ac:ad90:7090 with SMTP id 98e67ed59e1d1-3b12d59374dmr2471753a91.67.1794188680387;
        Sun, 08 Nov 2026 17:44:40 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc1bc1e6sm5641735a91.0.2026.11.08.17.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 17:44:40 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 3/5] netlink: connect sockets to the kernel
Date: Sun,  8 Nov 2026 17:44:00 -0800
Message-ID: <20261109014434.115922-4-stephen@networkplumber.org>
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

The netlink sockets were bound but not connected, so any process with
CAP_NET_ADMIN over the namespace can queue unicast datagrams to them.
Even though they are discarded, a steady stream fills the receive queue
and keeps a dump from ever completing.

Connect the socket to the kernel (port id 0) after bind, so the kernel
refuses unicast from other senders. Multicast is still delivered and
is filtered on receive.

Reported-by: Anthropic OSS scanner (ANT-2026-WUWQ5598)
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/libnetlink.c | 8 ++++++++
 lib/mnl_utils.c  | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/lib/libnetlink.c b/lib/libnetlink.c
index b923ba02..6432d537 100644
--- a/lib/libnetlink.c
+++ b/lib/libnetlink.c
@@ -192,6 +192,7 @@ void rtnl_close(struct rtnl_handle *rth)
 int rtnl_open_byproto(struct rtnl_handle *rth, unsigned int subscriptions,
 		      int protocol)
 {
+	const struct sockaddr_nl kernel_addr = { .nl_family = AF_NETLINK };
 	socklen_t addr_len;
 	int sndbuf = 32768;
 	int one = 1;
@@ -230,6 +231,13 @@ int rtnl_open_byproto(struct rtnl_handle *rth, unsigned int subscriptions,
 		perror("Cannot bind netlink socket");
 		goto err;
 	}
+
+	/* Refuse unicast from other processes, only the kernel may send */
+	if (connect(rth->fd, (struct sockaddr *)&kernel_addr,
+		    sizeof(kernel_addr)) < 0) {
+		perror("Cannot connect netlink socket");
+		goto err;
+	}
 	addr_len = sizeof(rth->local);
 	if (getsockname(rth->fd, (struct sockaddr *)&rth->local,
 			&addr_len) < 0) {
diff --git a/lib/mnl_utils.c b/lib/mnl_utils.c
index 8ddf2b90..c49afed7 100644
--- a/lib/mnl_utils.c
+++ b/lib/mnl_utils.c
@@ -15,6 +15,7 @@
 
 struct mnl_socket *mnlu_socket_open(int bus)
 {
+	const struct sockaddr_nl kernel_addr = { .nl_family = AF_NETLINK };
 	struct mnl_socket *nl;
 	int one = 1;
 
@@ -28,6 +29,11 @@ struct mnl_socket *mnlu_socket_open(int bus)
 	if (mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID) < 0)
 		goto err_bind;
 
+	/* Refuse unicast from other processes, only the kernel may send */
+	if (connect(mnl_socket_get_fd(nl), (struct sockaddr *)&kernel_addr,
+		    sizeof(kernel_addr)) < 0)
+		goto err_bind;
+
 	return nl;
 
 err_bind:
-- 
2.53.0

