Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259570;
	b=p5/8yNp9D880hMZ8jEEO0fB3x3j/rGoz+pdf3kPoYSsybUavtZAtc3y5r3BSrLEAt0UK
	 a8nh0rMioBe6s44/RCICi0z/+YTfVixLSGzSWRgcxUMuHioBnFkyS8ff5aOVTGuxn9c1k
	 cUrtGj7DTU3Fmj+ri8xVHFC3EJVAMDs6Fqmp2tMDZ6jKtOXah7HpFJ3j2QvlnTRvbzKe7
	 H+b23acbCBCrKi8rsfcspDiXJEQkQprya9BQ9gX8Z7FOIgpyOCRUN+xlHsZmtLnG9iCxd
	 ZlDW2D6CTiv5KXMNbeCsfkK1qM6LUx9y0LgBxVW2bqP+VqytuAovFGSDI6X6AMqj6dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N+d+91PhCWUl3CuzecX7us1SjXVKhu3jF5V2pCa29i8=;
	b=VYQB9k8RUbzhSrvBSRtxzP8HeALncCB7Zwb626hRC6ldu4cWkThDkJ0FMB2CW1EiAXlP
	 ciozJOhh9jXcQqLHuObVhB1ayi96GWWHRkqUn6F0JEWyD4nUPhzh9oIpEwHrrnA7YHq15
	 3BagI6Jqtefl5S8meiC5GYmSkMEnWLZmjsvYJafGlpHZkVqKjhD2nsW3KE5KffTg9gaDl
	 +rSQ79HzjTWZ+mhQYX5Zu5W3tyqZ/NPMkNSpaszkoDsBdPAwTGSqWOFnGMjlGnu/zcPPD
	 lk/tQl2MfP7Y9gbIQD4gSy24X/D1e7ygiYPxXaCqvdlC0/D7gnuOBEB2sLLKewC3c7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hmnYIbZM;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF875606A334
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF875606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=hmnYIbZM
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a058315c79so673604b3a.3
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259569; x=1794864369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+d+91PhCWUl3CuzecX7us1SjXVKhu3jF5V2pCa29i8=;
        b=hmnYIbZMiwB3MBwucpNduZuhBYzd1JXGrvRLAGCEciK7z1saDK7keKF491423RS1gu
         3CTWII3cTfHl+jio541hnecmiyCtbv5xA3fFf7Y4PvYTcxI+Dyv7OhKUegu2NaVD7321
         88Q4RGJmDK9CtnRTsvHUMin8LHijeLstT+rsB2AZUju9Mnks13l3HM484yVeWv0RXEcZ
         KllMVFyrY2O9Q/ZL/CQcZpPkXFFihlWcPW3QAeIPxYYL9bKI3HBgeiaRNCO/lGrAJrl0
         ftsZgdcWoLoLz6Uw6m5mw4/Wb3mynzIv8C0uEKQgpXPj/984gVKqfzTocMO4iXd7TA2C
         TFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259569; x=1794864369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+d+91PhCWUl3CuzecX7us1SjXVKhu3jF5V2pCa29i8=;
        b=iI4ZVTclhvpjW+6Qxd6ML9f2Jsuwayv5qfIYy/oGJkS44jpgYYoL3Buhzer9ybmGge
         E7yjZTh+YvdvbD8UgNRTS4MInupI+7NhU2Fd+L01UwwMscSs0HZh3fUcNycJECETWQ5o
         6ibQXdUp4ajYpG1Z+DBXCc1YYxWqUStrLMSxC0wKmekk27YBvVVQcJ9iP8u1tmFSFJNh
         ol4v/8oo45E7dV4EpvqXPPSzkGwas6/kq9J3A1jCYEBCHS/6XMXd6k21J5VukrkB4YX0
         Kcr0o0+xitEkJwcz1NjrGT1gw1/utrHc1EYL0XMZfM1qsYCnRALny1U3VCMglnSytcHU
         Ixqw==
X-Gm-Message-State: APuU4Z9TCyafq7KxSgpuXARSZkSATsQky2sjV2ZD6eVc04l8ZsqUT/eG
	pKJQudyhOonm0PU0JWHeB3VACFPc9AVopdkMildyPKFYjjeJ7HD9mZPdAz3Fo8fkO6i3QcTK9z4
	WJmgZcsE=
X-Gm-Gg: AYBFou3KqFy+PxMNSYLRPvWk1kTM4Y7aHWc3t06sS8tXs3fflgBgVNlHarku8F7tVSG
	T6mQv30kdmkthkOuGSMDX+RC5EuYaAPc+gMeYVrxxQtjDk/iQFwlp+ChK0SgkIYqdOk0h6SUFaq
	UH7eLXssX8WavB7yy0PEmUHD3zLwLcZ+wI7cP0li40aXyJxm8qy8i+AJBlAC96EXB7jHj0myjxm
	vA63DMS2CCWurszFjRsvlUy8RrNFCTj4o0DkS31T2Gw5ntM9u6e/mUZkiqnezpiPGq2FTc8uJkO
	cLQCh2lY1eIiNhwBxAhBJrxfe7PPnlh1fq1iuUtTmRm4l2PXBS+SSik76bDmfbCQP2CubxNUpjU
	0ik5a3hOp4DDAbfXzmH0MvneLLthPplEZlmTIrX0d/uESmssunmNWOvyoxL0T+0xOs0xuqggS4U
	laFkEMAg5KX9sg77+OE8dwU9LqpkEdXVcBU5NgTZJHWRloMLgFiSi7sFXy3HJqY1qxt3BylU7W4
	YUxnrvz+5zLDBgENAwk07jOnA/fQ3LNQs7nnD5Ihpd7ADrugz91zWfD6/qiLzgVQoQLgRx8GngG
	Dby9bAHOY+6aU4TShcJ0boWhsm0b6dTcIAMxSd0VPaFeDWu1CZi+52knrB22cUxDrLC7Kg==
X-Received: by 2002:a05:6a21:4916:b0:3de:b95:d50f with SMTP id adf61e73a8af0-3f18f3a46e4mr330352637.24.1794259569229;
        Mon, 09 Nov 2026 13:26:09 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm122854b3a.5.2026.11.09.13.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 06/11] ss: bound state and type name lookups
Date: Mon,  9 Nov 2026 13:25:22 -0800
Message-ID: <20261109212559.39661-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109212559.39661-1-stephen@networkplumber.org>
References: <20261109212559.39661-1-stephen@networkplumber.org>
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

The socket state, SCTP state and TIPC socket type come from the
kernel (or a TCPDIAG_FILE) and were used to index name tables
without a range check.

SCTP associations were detected by the inode matching the previous
row, so an endpoint dumped twice was treated as an association and
its TCP-style state indexed the SCTP table out of range. Use the
INET_DIAG_PEERS attribute, which the kernel only sends for
associations, instead.

Reported-by: Anthropic OSS scanner (ANT-2026-GDQ1INKZ)
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 527725bd..e0b26586 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -107,7 +107,6 @@ static int show_proc_ctx;
 static int show_sock_ctx;
 static int show_header = 1;
 static int follow_events;
-static int sctp_ino;
 static int show_tipcinfo;
 static int show_tos;
 static int show_cgroup;
@@ -766,7 +765,15 @@ static unsigned long long cookie_sk_get(const uint32_t *cookie)
 	return (((unsigned long long)cookie[1] << 31) << 1) | cookie[0];
 }
 
-static const char *sctp_sstate_name[] = {
+/* Names indexed by a value from the kernel, which may be out of range */
+static const char *table_name(const char * const *names, size_t n,
+			      unsigned int i)
+{
+	return i < n && names[i] ? names[i] : "UNKNOWN";
+}
+#define TABLE_NAME(names, i)	table_name(names, ARRAY_SIZE(names), i)
+
+static const char * const sctp_sstate_name[] = {
 	[SCTP_STATE_CLOSED] = "CLOSED",
 	[SCTP_STATE_COOKIE_WAIT] = "COOKIE_WAIT",
 	[SCTP_STATE_COOKIE_ECHOED] = "COOKIE_ECHOED",
@@ -805,6 +812,7 @@ struct sockstat {
 	char *peer_name;
 	__u32		    mark;
 	__u64		    cgroup_id;
+	bool		    sctp_assoc;
 };
 
 struct dctcpstat {
@@ -880,18 +888,6 @@ struct tcpstat {
 	struct tcp_bbr_info *bbr_info;
 };
 
-/* SCTP assocs share the same inode number with their parent endpoint. So if we
- * have seen the inode number before, it must be an assoc instead of the next
- * endpoint. */
-static bool is_sctp_assoc(struct sockstat *s, const char *sock_name)
-{
-	if (strcmp(sock_name, "sctp"))
-		return false;
-	if (!sctp_ino || sctp_ino != s->ino)
-		return false;
-	return true;
-}
-
 static const char *unix_netid_name(int type)
 {
 	switch (type) {
@@ -1437,14 +1433,14 @@ static void sock_state_print(struct sockstat *s)
 		sock_name = "unknown";
 	}
 
-	if (is_sctp_assoc(s, sock_name)) {
+	if (s->sctp_assoc) {
 		field_set(COL_STATE);		/* Empty Netid field */
-		out("`- %s", sctp_sstate_name[s->state]);
+		out("`- %s", TABLE_NAME(sctp_sstate_name, s->state));
 	} else {
 		field_set(COL_NETID);
 		out("%s", sock_name);
 		field_set(COL_STATE);
-		out("%s", sstate_name[s->state]);
+		out("%s", TABLE_NAME(sstate_name, s->state));
 	}
 
 	if (show_queues) {
@@ -2498,7 +2494,7 @@ static void sctp_stats_print(struct sctp_info *s)
 	if (s->sctpi_tag)
 		out(" tag:%x", s->sctpi_tag);
 	if (s->sctpi_state)
-		out(" state:%s", sctp_sstate_name[s->sctpi_state]);
+		out(" state:%s", TABLE_NAME(sctp_sstate_name, s->sctpi_state));
 	if (s->sctpi_rwnd)
 		out(" rwnd:%d", s->sctpi_rwnd);
 	if (s->sctpi_unackdata)
@@ -3622,6 +3618,12 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 	if (s->local.family == AF_INET6 && tb[INET_DIAG_SKV6ONLY])
 		v6only = rta_getattr_u8(tb[INET_DIAG_SKV6ONLY]);
 
+	/* SCTP assocs share the inode number of their endpoint; only
+	 * assocs carry INET_DIAG_PEERS, and only for those is the state
+	 * an SCTP_STATE_* value.
+	 */
+	s->sctp_assoc = s->type == IPPROTO_SCTP && tb[INET_DIAG_PEERS];
+
 	inet_stats_print(s, v6only);
 
 	if (show_options) {
@@ -3709,7 +3711,6 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 		else
 			tcp_show_info(nlh, r, tb);
 	}
-	sctp_ino = s->ino;
 
 #ifdef ENABLE_BPF_SKSTORAGE_SUPPORT
 	if (tb[INET_DIAG_SK_BPF_STORAGES])
@@ -4908,9 +4909,9 @@ static int tipc_show_sock(struct nlmsghdr *nlh, void *arg)
 
 	if (show_tipcinfo) {
 		if (oneline)
-			out(" type:%s", stype_nameg[ss.type]);
+			out(" type:%s", TABLE_NAME(stype_nameg, ss.type));
 		else
-			out("\n type:%s", stype_nameg[ss.type]);
+			out("\n type:%s", TABLE_NAME(stype_nameg, ss.type));
 		out(" cong:%s ",
 		       stat[TIPC_NLA_SOCK_STAT_LINK_CONG] ? "link" :
 		       stat[TIPC_NLA_SOCK_STAT_CONN_CONG] ? "conn" : "none");
-- 
2.53.0

