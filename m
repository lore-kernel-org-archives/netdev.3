Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259573;
	b=GhDbFDVtpELZG1bUxkdUdUCr2EHtBxfxd4JjRGvwupw0o70eDyvGBpU/ZoRbYl8L+oX6
	 lng4SA33s9UR95LHgwBrTZ5GdKFE8NtuZp1EkdZLLyS+wmIiLuJi0ufh5c2PqC1zRP1Jj
	 fqEDPgptp3K7WpBHUdpc/TNwfFrMrVHf4gjybSAoo68gG8cIP9PmY5OEUOjH23mYCWxwa
	 BgFwvLrHwVJnCI+u1ZQKcId2+SD8Ot77FiM9Nnq2CvmmC5rZ1Yw9I8GMV9iyXqAkJLHkV
	 nVaIE7Wl+HEKRURaylQvvq6EvMCpuge4M5K8MfDk7a+lf2P4ZjxywzcGDj0TKFjyVnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mZ/XVHxP8xkaAyO44y1XqNgYJid9xKBVEpQvxExE+Z4=;
	b=y22so/y2oyvHYxWBUTyZ9H0eiRoeqjs/z+oVFZ8tRvMMCAXN1HnodUA+N84+fVHdnCQf
	 R4x3paKDy1eEPXpdIvu2a+/w/spBq9VAAlRjJsCp/4qA/PMT1KJnIO4i+00AtnRckGaek
	 Nhe6DcGGzARv1PNzxNJNxe3E/8YyeJjBQSlWEElSFiMcx/HJtht9HidO1y4ANHWiA27++
	 PgvCvEWM9DXhRWkm5iEHwHK2nfTiefpCFEWA9II7hAh7B7Oegog50Y8rrxLaNoTEU+adi
	 hsHrhwTyH1LbZBRKmTa2KWa4+xUAqgZv++iXInhn8/aecckimoRjA6PGk9LR8KPtLWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="M/577zeL";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6AD60A260F
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 21:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F6AD60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=M/577zeL
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a070755c8cso673656b3a.0
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 13:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259573; x=1794864373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mZ/XVHxP8xkaAyO44y1XqNgYJid9xKBVEpQvxExE+Z4=;
        b=M/577zeLwRVnrYcqYk5S63zlpkH55Ef7jlVQWzO9XfIo3DjMho2EpQitITOO5NVkvL
         64ic5ZdQMoiV1Qi4gITcadKbOm2vrICvI8qFZGre0rDXKmV9rQdGQbWc3mdcXojPd6DC
         khio2drP3l3zMsOuMiu5vq/7hq8HcQ+CBuKGlLWQ+oyBOZ/02Dj9NQbNHYPFOtKcFS5U
         75HfcXoUIEO7oT/9Wij0a2qqConXOumKkzCw7PCTswzGfohP8O3HkflqrQ7UYE/pU7cq
         NmHyuwnhooP09bASk1skJYb84r6482NBcrcA1az9/c/RkSo8MSkMroMMimMz9IhkwCXI
         X4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794259573; x=1794864373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mZ/XVHxP8xkaAyO44y1XqNgYJid9xKBVEpQvxExE+Z4=;
        b=b87SofEx8pEckz+qZJHLdQA0BqNdUt9cwywqaw5K/BpVjzAd6BbKqkNxHCLjfLLYK0
         uSf24F/pwzflbbr+fk3V+5AxoYvnwzE24Q2UNxhlbAGYUZ7UDGyxiMEd8o/9bGODhbyq
         dT7k0Tu4jXOfdaAS8xy+2h3bTsmKipasuVxrTcNWo7BNxfGSL9vQY6yCjvMoAE7uNhJz
         YPDyBb7B+MbGOcUWZUXiZlpk/QZLDlvB+oOqoyCSIdzvmoGVU/zszR3R2LEm0affREiR
         BgrIbXKxnHIPdHV9TmPgdVIK657cvmtYS3SncRJ3LDDEhYITjFjoKE81+q7qrAyJAhmH
         cRuQ==
X-Gm-Message-State: APuU4Z/JcxvzZpW01XYbigu7cxzajk6CYF1v08F47FlNFcdFf84eijDK
	IhHfVr/ja/inJoBHOLcqo+wcu8AuyjkJb9MLQw08Zq6gqeXrU0oQvNuPh+lAL11z4u1jhgjBbMz
	oz5ID01M=
X-Gm-Gg: AYBFou3JDFtAQfMTNiDQHr+v52VCsqli4Mqe9Vq15CBQ0j8i9bTAJyd7Gt4hDWW3Cid
	T3YB4NXeaXeJFtMxP2YlsBNlvOJ40O/t9sEtQwTxpJVN6fZy1Sny0NAieTk9yrGL0ZIfk78/KaF
	8FDNwO6cOLBq3htkW/jw7NytRJKXKmCpO7PUyGbf4yOzZk67Iaja7QMyjeveXfgHNuOVmYG5Dff
	9IV/6OcDVt9TdGNKm12r1i+sh49TU/n7JD+pTpYnM8YnCwS4lrW31JYcorfxqB39XVx8cXf4zkN
	DA/MygYYz4p7egqcOQTM0GYE8a6lErT9wNBYkX05Xi7uCmMBnEs+LNc6+nCxLUF3QrSy8ayiFfA
	AYgz7/2YJZrqv7AVSMaWzAnoZ/2g9XPdq+ReXlLtGmDovWalwp/4S9Q2dCpfPtMN3NrugQK7Ljz
	oY+NtU3D1vc5ZgyLtJ0gpqRMtNU89hwZ9qkZE5TJktxged72S8HgqfV9KwEt0yv5mpmCwMytRUV
	z7aCrdPBnY9NOaV7YY5C9pogE4yD4xg6Se76DTdAgriQ/Wv/qDDNbnOWiPlINaHqP0xEQAaXIHU
	dYORcdNNIX/FVqxykPywWRDV8sCBamyoUVwqvVuEAHAz/TnSriuePJ4k4XtGBdZ1k4lJ
X-Received: by 2002:a05:6a21:3944:b0:3e0:d508:59a6 with SMTP id adf61e73a8af0-3f18e1df4f8mr382265637.13.1794259572804;
        Mon, 09 Nov 2026 13:26:12 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm122854b3a.5.2026.11.09.13.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:26:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 09/11] ss: check owner before naming a netlink socket
Date: Mon,  9 Nov 2026 13:25:25 -0800
Message-ID: <20261109212559.39661-10-stephen@networkplumber.org>
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

The netlink port id was taken as the pid of the owning process,
but any process can bind any free port id, so ss could show (and
report the SELinux context of) an unrelated process.

Only name the process if it holds the socket. Port ids that cannot
be checked are shown as numbers.

Reported-by: Anthropic OSS scanner (ANT-2026-1FCHVE1N)
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/ss.8 |  3 ++-
 misc/ss.c     | 51 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index 54af744a..96d25ab0 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -337,7 +337,8 @@ sockets the initiating process context is displayed as follows:
 .RS
 .RS
 .IP "1." 4
-If valid pid show the process context.
+If the port id is the pid of a process holding the socket, show the process
+context.
 .IP "2." 4
 If destination is kernel (pid = 0) show kernel initial context.
 .IP "3." 4
diff --git a/misc/ss.c b/misc/ss.c
index 4b3d1fa4..2f7c891a 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -4652,10 +4652,47 @@ static int xdp_show(struct filter *f)
 	return handle_netlink_request(f, &req.nlh, sizeof(req), xdp_show_sock);
 }
 
+/* A netlink port id is chosen by whoever binds the socket; it is the
+ * pid of the owner only by convention. Check that the process holds it.
+ */
+static bool netlink_pid_holds_sock(int pid, unsigned int ino)
+{
+	char path[MAX_PATH_LEN];
+	struct dirent *d;
+	bool ret = false;
+	DIR *dir;
+
+	if (pid <= 0 || !ino)
+		return false;
+
+	snprintf(path, sizeof(path), "%s/%d/fd",
+		 getenv("PROC_ROOT") ? : "/proc", pid);
+	dir = opendir(path);
+	if (!dir)
+		return false;
+
+	while (!ret && (d = readdir(dir)) != NULL) {
+		unsigned int fd_ino;
+		ssize_t link_len;
+		char lnk[64];
+
+		link_len = readlinkat(dirfd(dir), d->d_name, lnk, sizeof(lnk) - 1);
+		if (link_len == -1)
+			continue;
+		lnk[link_len] = '\0';
+
+		if (sscanf(lnk, "socket:[%u]", &fd_ino) == 1)
+			ret = fd_ino == ino;
+	}
+	closedir(dir);
+
+	return ret;
+}
+
 static int netlink_show_one(struct filter *f,
 				int prot, int pid, unsigned int groups,
 				int state, int dst_pid, unsigned int dst_group,
-				int rq, int wq,
+				int rq, int wq, unsigned int ino,
 				unsigned long long sk, unsigned long long cb)
 {
 	struct sockstat st = {
@@ -4669,6 +4706,7 @@ static int netlink_show_one(struct filter *f,
 	SPRINT_BUF(prot_buf) = {};
 	const char *prot_name;
 	char procname[64] = {};
+	bool is_owner = false;
 
 	if (f->f) {
 		st.rport = -1;
@@ -4682,6 +4720,9 @@ static int netlink_show_one(struct filter *f,
 
 	prot_name = nl_proto_n2a(prot, prot_buf, sizeof(prot_buf));
 
+	if (pid > 0 && (!numeric || show_proc_ctx))
+		is_owner = netlink_pid_holds_sock(pid, ino);
+
 	if (pid == -1) {
 		procname[0] = '*';
 	} else if (!numeric) {
@@ -4691,7 +4732,7 @@ static int netlink_show_one(struct filter *f,
 		if (!pid) {
 			done = 1;
 			strncpy(procname, "kernel", 7);
-		} else if (pid > 0) {
+		} else if (is_owner) {
 			if (get_task_name(getenv("PROC_ROOT"), pid,
 					  task, sizeof(task)) == 0) {
 				escape_str(procname, task, sizeof(procname));
@@ -4724,13 +4765,13 @@ static int netlink_show_one(struct filter *f,
 	if (show_proc_ctx) {
 		/* The pid value will either be:
 		 *   0 if destination kernel - show kernel initial context.
-		 *   A valid process pid - use getpidcon.
+		 *   The pid of a process holding the socket - use getpidcon.
 		 *   A unique value allocated by the kernel or netlink user
 		 *   to the process - show context as "not available".
 		 */
 		if (!pid)
 			security_get_initial_context("kernel", &pid_context);
-		else if (pid > 0)
+		else if (is_owner)
 			getpidcon(pid, &pid_context);
 
 		out(" proc_ctx=%s", pid_context ? : "unavailable");
@@ -4769,7 +4810,7 @@ static int netlink_show_sock(struct nlmsghdr *nlh, void *arg)
 
 	if (netlink_show_one(f, r->ndiag_protocol, r->ndiag_portid, groups,
 			 r->ndiag_state, r->ndiag_dst_portid, r->ndiag_dst_group,
-			 rq, wq, 0, 0)) {
+			 rq, wq, r->ndiag_ino, 0, 0)) {
 		return 0;
 	}
 
-- 
2.53.0

