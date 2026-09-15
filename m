Received: from mail-pj2-f32.google.com (mail-pj2-f32.google.com [74.125.227.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2831133939D
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789507874; cv=none; b=VjbqtBk5iRo8CysuVgtKbd+1kwGLzC1mVyJK5TRChKUdDTBA7nTDaVc9hY+CGE2ZfpZdMX7FzPv7fFWg4B36MovD7MyHqEwxu5nt0/3/ebCcAr+Q6R9cacSdHUvOEbfrFtKsyRbJEKfG2pUhPhvL28A+zy+4omQxvH/r7s5uk/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789507874; c=relaxed/simple;
	bh=+88qVQ/MG+fXn3DpmU6lG7dXbJfPRK36DHq+/zc0cfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBCq06QzbhfgnDZHRqY++O60jir8yLOOkyqZ0eKcdeY05IMBEIHZEdDy9PjyAwD2dWjVQxN4Ip/a/XwyXR162/vQtcJfm5LrrMvPlhW80Tt80x3HvvdpDRwNkUA/9ijRyW7Ni7P8Z+d+5OyHxrL4z70SDx/FNhfagWqX5FzvXwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCXKaS/C; arc=none smtp.client-ip=74.125.227.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCXKaS/C"
Received: by mail-pj2-f32.google.com with SMTP id d9443c01a7336-2d747f05ffdso2119765ad.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789507871; x=1790112671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4BwqWW979HDRAo/COCZJ6fhYKUczjsWWG1tuqg6RtA=;
        b=TCXKaS/CvYBJL3gtjRoLbkWdgzxOeB86UNNk6c7H+TU5P3kK5vhfWKKo1UrPRhFgho
         RC+Z2bj3qDYzZOMByfO5zSo3Iw6LQrfnghhxSCx/b/3++81wyk2w6Y8mX75YIi5xiczT
         mY6fYqTKiCcTTG8CBNBl9z2uu/VPPM1VBUVPcqbWFZpni3romfrylflNQ7dRNu1Q2Jzs
         /uuAjDrHEPmG2U1HBerwSh8UfePjnsDhQ+2YA5SNuge5zWFHpNzGpf9hwNd8C7Tgn4hl
         Gi3TfllHssL7JC3TtIpcDCwxzw6SZVvmAzFUG7+Fyu0uHaylNnoawtClH0PJtjZ3eb7z
         FfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789507871; x=1790112671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4BwqWW979HDRAo/COCZJ6fhYKUczjsWWG1tuqg6RtA=;
        b=DbOn8XaLml5QAKNVlXqwQJVlIB9s4RHqSrVojZ97IOoa81sLZNXUX5BQomJC2aCEdd
         RRDYXh6vpG+TVE+bAgHfSebUu8Z+gQxznInU2IuYGKwR6xS8ihtjl7nn4S1x2u/Qp8D3
         Mqhi13AXRGwhv6l8rYolvX+bEjW2IfIi7TxAUehbhXDhHCPwhWc64CJf9EvasATwzW2d
         mO1kEOaNvivv/2fXq/+yAHaAp/OS0ISxtk8Y00I8dYISwN/5u6kD6TjrdjjuGAzeCtDE
         V1S4sjV64TDA585OLi2RjcpuScglSCzxyAvzK/dXA7cj8AjVrxEuamxIWXIhN8P5JdXJ
         9Q6w==
X-Gm-Message-State: AFuF++kr5wOeMjFhsOgs92Axt72aVpeET9Lkzk/iOKwF7CRVt5xU0Yjt
	wmFtpddDf1vJD3G2S0X8oHjNd7UnSDStUaS/Y2o2txAOPrCSAHK+W1gGk10YFw==
X-Gm-Gg: AYBFou11Dx7w4WOB5wlniPUP+jjvu7NoJ7i3OmwlKcL2yYe3Iha/dse1uzeYVSoe0Wv
	o2CwQbc5VE3yd5tl8KblRuSNunAgjouXSICK9bAazL7wWtB3q5w9bOK0aQO1hMOFsRC+5iRGjLJ
	ssS0iyoR2KQaMiXReuiS2Aou4UNuiZjrh+QTf7hCkmGndUe1rsgJYJYtXsagr4uxpQ3HPCJNIHq
	eJoPLBNRyp7MkWwyOoOOxB5U9gqD4TjNEAtoPTLYmZlRpvt1Eb6E6WDnPgXMnPqFr3tMr5lOQZn
	g793bkKa9H8oxaTEt8bpw6/4eixp239kDn3EKS8UIGFqprhcAzfbmFZ2t9HdaVNAo3XV8gFC2Az
	dTBwDh5i1T1bjKPwjnNGbSm4E9NxOp7BGXbh93pGyaNUxf6BUCKR6ae1Gai6FwU1MGrQ1pSXfCb
	pbDampBhwep3v4nQ2Pl6gu4YElt7Uyv4RFsHBdgid6+S/qsgkeL8XfMLf9u5Hi2nVflGxVX4xCM
	to8cpJT/A/jxpwNXNpO+nEdZdDqpt8H3T9qjdmOvXTiha016B/FO8k0albdp1PsCWz+q8Inbs6k
	QxIvIZ8tSg==
X-Received: by 2002:a17:90b:3ccb:b0:398:ba9e:75ff with SMTP id 98e67ed59e1d1-39e1e52627bmr358167a91.21.1789507870987;
        Tue, 15 Sep 2026 14:31:10 -0700 (PDT)
Received: from localhost.ghari-thinkpadp1gen7.rmtin.csb ([111.92.26.108])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d5d0f3sm1367060c88.12.2026.09.15.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:31:10 -0700 (PDT)
From: Harshith Hari <harshithhari000111@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	Harshith Hari <harshithhari000111@gmail.com>
Subject: [PATCH iproute2 v2] ss: add -P/--process-age option to display process runtime
Date: Wed, 16 Sep 2026 03:01:00 +0530
Message-ID: <20260915213100.77691-1-harshithhari000111@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new option (-P/--process-age) to display process uptime/age
alongside process info inside socket user context output.

Signed-off-by: Harshith Hari <harshithhari000111@gmail.com>
---
v2:
 - Fixed patch whitespace and tab formatting.
Signed-off-by: Harshith Hari <harshithhari000111@gmail.com>
---
 man/man8/ss.8 |   3 +
 misc/ss.c     | 662 +++++++++++++++++++++++++++++---------------------
 2 files changed, 385 insertions(+), 280 deletions(-)

diff --git a/man/man8/ss.8 b/man/man8/ss.8
index b0629b82..5f345c21 100644
--- a/man/man8/ss.8
+++ b/man/man8/ss.8
@@ -163,6 +163,9 @@ the number of packets dropped before they are de-multiplexed into the socket
 .TP
 \.B \-P, \-\-process\-age
 Show process age/runtime alongside process socket information.
+.TP
+\.B \-P, \-\-process\-age
+Show process age/runtime alongside process socket information.
 Show processes using sockets.
 .TP
 .B \-T, \-\-threads
diff --git a/misc/ss.c b/misc/ss.c
index 6c32455d..6058ca29 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -56,58 +56,58 @@ static int show_process_age;
 
 static void print_process_age(pid_t pid)
 {
-char path[64];
-FILE *f;
-unsigned long long starttime;
-double uptime = 0.0;
-long clock_ticks = sysconf(_SC_CLK_TCK);
-
-f = fopen("/proc/uptime", "r");
-if (!f)
-return;
-
-if (fscanf(f, "%lf", &uptime) != 1) {
-fclose(f);
-return;
-}
-fclose(f);
+	char path[64];
+	FILE *f;
+	unsigned long long starttime;
+	double uptime = 0.0;
+	long clock_ticks = sysconf(_SC_CLK_TCK);
+
+	f = fopen("/proc/uptime", "r");
+	if (!f)
+		return;
 
-snprintf(path, sizeof(path), "/proc/%d/stat", pid);
-f = fopen(path, "r");
-if (!f)
-return;
+	if (fscanf(f, "%lf", &uptime) != 1) {
+		fclose(f);
+		return;
+	}
+	fclose(f);
 
-char buf[1024];
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	f = fopen(path, "r");
+	if (!f)
+		return;
 
-if (fgets(buf, sizeof(buf), f)) {
-char *ptr = strrchr(buf, ')');
+	char buf[1024];
 
-if (ptr) {
-int field = 3;
+	if (fgets(buf, sizeof(buf), f)) {
+		char *ptr = strrchr(buf, ')');
 
-ptr++;
-while (*ptr && field < 22) {
-if (*ptr == ' ')
-field++;
-ptr++;
-}
-if (sscanf(ptr, "%llu", &starttime) == 1) {
-double process_secs = uptime - ((double)starttime / clock_ticks);
-long secs = (long)process_secs;
-long hours = secs / 3600;
-long mins = (secs % 3600) / 60;
-long s = secs % 60;
+		if (ptr) {
+			int field = 3;
 
-if (hours > 0)
-out(",age=%ldh%ldm", hours, mins);
-else if (mins > 0)
-out(",age=%ldm%lds", mins, s);
-else
-out(",age=%lds", s);
-}
-}
-}
-fclose(f);
+			ptr++;
+			while (*ptr && field < 22) {
+				if (*ptr == ' ')
+					field++;
+				ptr++;
+			}
+			if (sscanf(ptr, "%llu", &starttime) == 1) {
+				double process_secs = uptime - ((double)starttime / clock_ticks);
+				long secs = (long)process_secs;
+				long hours = secs / 3600;
+				long mins = (secs % 3600) / 60;
+				long s = secs % 60;
+
+				if (hours > 0)
+					out(",age=%ldh%ldm", hours, mins);
+				else if (mins > 0)
+					out(",age=%ldm%lds", mins, s);
+				else
+					out(",age=%lds", s);
+			}
+		}
+	}
+	fclose(f);
 }
 
 
@@ -115,57 +115,58 @@ static int show_process_age;
 
 static void print_process_age(pid_t pid)
 {
-char path[64];
-FILE *f;
-unsigned long long starttime;
-double uptime = 0.0;
-long clock_ticks = sysconf(_SC_CLK_TCK);
+	char path[64];
+	FILE *f;
+	unsigned long long starttime;
+	double uptime = 0.0;
+	long clock_ticks = sysconf(_SC_CLK_TCK);
 
-f = fopen("/proc/uptime", "r");
-if (!f)
-return;
-if (fscanf(f, "%lf", &uptime) != 1) {
-fclose(f);
-return;
-}
-fclose(f);
+	f = fopen("/proc/uptime", "r");
+	if (!f)
+		return;
 
-snprintf(path, sizeof(path), "/proc/%d/stat", pid);
-f = fopen(path, "r");
-if (!f)
-return;
+	if (fscanf(f, "%lf", &uptime) != 1) {
+		fclose(f);
+		return;
+	}
+	fclose(f);
 
-char buf[1024];
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	f = fopen(path, "r");
+	if (!f)
+		return;
 
-if (fgets(buf, sizeof(buf), f)) {
-char *ptr = strrchr(buf, ')');
+	char buf[1024];
 
-if (ptr) {
-int field = 3;
+	if (fgets(buf, sizeof(buf), f)) {
+		char *ptr = strrchr(buf, ')');
 
-ptr++;
-while (*ptr && field < 22) {
-if (*ptr == ' ')
-field++;
-ptr++;
-}
-if (sscanf(ptr, "%llu", &starttime) == 1) {
-double process_secs = uptime - ((double)starttime / clock_ticks);
-long secs = (long)process_secs;
-long hours = secs / 3600;
-long mins = (secs % 3600) / 60;
-long s = secs % 60;
+		if (ptr) {
+			int field = 3;
 
-if (hours > 0)
-out(",age=%ldh%ldm", hours, mins);
-else if (mins > 0)
-out(",age=%ldm%lds", mins, s);
-else
-out(",age=%lds", s);
-}
-}
-}
-fclose(f);
+			ptr++;
+			while (*ptr && field < 22) {
+				if (*ptr == ' ')
+					field++;
+				ptr++;
+			}
+			if (sscanf(ptr, "%llu", &starttime) == 1) {
+				double process_secs = uptime - ((double)starttime / clock_ticks);
+				long secs = (long)process_secs;
+				long hours = secs / 3600;
+				long mins = (secs % 3600) / 60;
+				long s = secs % 60;
+
+				if (hours > 0)
+					out(",age=%ldh%ldm", hours, mins);
+				else if (mins > 0)
+					out(",age=%ldm%lds", mins, s);
+				else
+					out(",age=%lds", s);
+			}
+		}
+	}
+	fclose(f);
 }
 
 
@@ -892,12 +893,12 @@ static int find_entry(unsigned int ino, char **buf, int type)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -1088,12 +1089,12 @@ static const char *unix_netid_name(int type)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -1114,12 +1115,12 @@ static const char *proto_name(int protocol)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -1147,12 +1148,12 @@ static const char *vsock_netid_name(int type)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -1172,12 +1173,12 @@ static const char *tipc_netid_name(int type)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -1224,7 +1225,7 @@ static struct buf_chunk *buf_chunk_new(void)
 static int buf_chunk_avail(struct buf_chunk *chunk)
 {
 	return BUF_CHUNK - offsetof(struct buf_chunk, data) -
-	       (chunk->end - chunk->data);
+		   (chunk->end - chunk->data);
 }
 
 /* Update end pointer and token length, link new chunk if we hit the end of the
@@ -1240,7 +1241,7 @@ static int buf_update(int len)
 	 * allocating a new chunk won't help, so we'll just cut the output.
 	 */
 	if ((len < buf_chunk_avail(chunk) && len != -1 /* glibc < 2.0.6 */) ||
-	    t == (struct buf_token *)chunk->data) {
+		t == (struct buf_token *)chunk->data) {
 		len = min(len, buf_chunk_avail(chunk));
 
 		/* Total field length can't exceed 2^16 bytes, cut as needed */
@@ -1656,12 +1657,12 @@ static void sock_state_print(struct sockstat *s)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -1834,7 +1835,7 @@ static void init_service_resolver(void)
 		c->port = hport << 8 | lport;
 
 		if (strcmp(rhead->rpcb_map.r_netid, TCP_PROTO) == 0 ||
-		    strcmp(rhead->rpcb_map.r_netid, TCP6_PROTO) == 0)
+			strcmp(rhead->rpcb_map.r_netid, TCP6_PROTO) == 0)
 			c->proto = TCP_PROTO;
 		else if (strcmp(rhead->rpcb_map.r_netid, UDP_PROTO) == 0 ||
 			 strcmp(rhead->rpcb_map.r_netid, UDP6_PROTO) == 0)
@@ -1955,7 +1956,7 @@ do_numeric:
 }
 
 static void inet_addr_print(const inet_prefix *a, int port,
-			    unsigned int ifindex, bool v6only)
+				unsigned int ifindex, bool v6only)
 {
 	char buf[1024];
 	const char *ap = buf;
@@ -1965,7 +1966,7 @@ static void inet_addr_print(const inet_prefix *a, int port,
 		ap = format_host(AF_INET, 4, a->data);
 	} else {
 		if (!v6only &&
-		    !memcmp(a->data, &in6addr_any, sizeof(in6addr_any))) {
+			!memcmp(a->data, &in6addr_any, sizeof(in6addr_any))) {
 			buf[0] = '*';
 			buf[1] = 0;
 		} else {
@@ -1997,7 +1998,7 @@ struct aafilter {
 };
 
 static int inet2_addr_match(const inet_prefix *a, const inet_prefix *p,
-			    int plen)
+				int plen)
 {
 	if (!inet_addr_match(a, p, plen))
 		return 0;
@@ -2007,7 +2008,7 @@ static int inet2_addr_match(const inet_prefix *a, const inet_prefix *p,
 	 * sockets. Fair? */
 	if (p->family == AF_INET && a->family == AF_INET6) {
 		if (a->data[0] == 0 && a->data[1] == 0 &&
-		    a->data[2] == htonl(0xffff)) {
+			a->data[2] == htonl(0xffff)) {
 			inet_prefix tmp = *a;
 
 			tmp.data[0] = a->data[3];
@@ -2037,12 +2038,12 @@ static int run_ssfilter(struct ssfilter *f, struct sockstat *s)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -2174,12 +2175,12 @@ static int ssfilter_bytecompile(struct ssfilter *f, char **bytecode)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -2727,57 +2728,91 @@ static void proc_ctx_print(struct sockstat *s)
 		if (find_entry(s->ino, &buf,
 				(show_proc_ctx & show_sock_ctx) ?
 				PROC_SOCK_CTX : PROC_CTX) > 0) {
-			out(" users:(%s)", buf);
+			if (show_process_age) {
+				char *ptr_p = buf;
+
+				out(" users:(");
+				while (*ptr_p) {
+					char *pid_ptr = strstr(ptr_p, "pid=");
+
+					if (pid_ptr) {
+						char *close_paren = strchr(pid_ptr, ')');
+
+						if (close_paren) {
+							out("%.*s",
+				    (int)(close_paren - ptr_p),
+				    ptr_p);
+							pid_t pid = atoi(pid_ptr + 4);
+
+							if (pid > 0)
+								print_process_age(pid);
+							out(")");
+							ptr_p = close_paren + 1;
+						} else {
+							out("%s", ptr_p);
+							break;
+						}
+					} else {
+						out("%s", ptr_p);
+						break;
+					}
+				}
+				out(")");
+			} else {
+				out(" users:(%s)", buf);
+			}
 			free(buf);
 		}
 	} else if (show_processes || show_threads) {
 if (find_entry(s->ino, &buf, USERS) > 0) {
 if (show_process_age) {
-char *p = buf;
-
-out(" users:(");
-while (*p) {
-char *pid_ptr = strstr(p, "pid=");
-
-if (pid_ptr) {
-char *close_paren = strchr(pid_ptr, ')');
-
-if (close_paren) {
-out("%.*s", (int)(close_paren - p), p);
-pid_t pid = atoi(pid_ptr + 4);
-
-if (pid > 0)
-print_process_age(pid);
-out(")");
-p = close_paren + 1;
-} else {
-out("%s", p);
-break;
-}
-} else {
-out("%s", p);
-break;
-}
-}
-out(")");
-} else {
-out(" users:(%s)", buf);
-}
+				char *ptr_p = buf;
+
+				out(" users:(");
+				while (*ptr_p) {
+					char *pid_ptr = strstr(ptr_p, "pid=");
+
+					if (pid_ptr) {
+						char *close_paren = strchr(pid_ptr, ')');
+
+						if (close_paren) {
+							out("%.*s",
+				    (int)(close_paren - ptr_p),
+				    ptr_p);
+							pid_t pid = atoi(pid_ptr + 4);
+
+							if (pid > 0)
+								print_process_age(pid);
+							out(")");
+							ptr_p = close_paren + 1;
+						} else {
+							out("%s", ptr_p);
+							break;
+						}
+					} else {
+						out("%s", ptr_p);
+						break;
+					}
+				}
+				out(")");
+			} else {
+				out(" users:(%s)", buf);
+			}
 free(buf);
 }
 } else {
 		sscanf(loc, "%08x%08x%08x%08x:%lx",
-		       s->local.data,
-		       s->local.data + 1,
-		       s->local.data + 2,
-		       s->local.data + 3,
-		       (unsigned long *)&s->lport);
+			   s->local.data,
+			   s->local.data + 1,
+			   s->local.data + 2,
+			   s->local.data + 3,
+			   (unsigned long *)&s->lport);
 		sscanf(rem, "%08x%08x%08x%08x:%lx",
-		       s->remote.data,
-		       s->remote.data + 1,
-		       s->remote.data + 2,
-		       s->remote.data + 3,
-		       (unsigned long *)&s->rport);
+			   s->remote.data,
+			   s->remote.data + 1,
+			   s->remote.data + 2,
+			   s->remote.data + 3,
+			   (unsigned long *)&s->rport);
 		s->local.bytelen = s->remote.bytelen = 16;
 		return 0;
 	}
@@ -2946,8 +2981,8 @@ static void tcp_stats_print(struct tcpstat *s)
 		struct dctcpstat *dctcp = s->dctcp;
 
 		out(" dctcp:(ce_state:%u,alpha:%u,ab_ecn:%u,ab_tot:%u)",
-			     dctcp->ce_state, dctcp->alpha, dctcp->ab_ecn,
-			     dctcp->ab_tot);
+				 dctcp->ce_state, dctcp->alpha, dctcp->ab_ecn,
+				 dctcp->ab_tot);
 	} else if (s->dctcp) {
 		out(" dctcp:fallback_mode");
 	}
@@ -2960,14 +2995,14 @@ static void tcp_stats_print(struct tcpstat *s)
 		bw |= s->bbr_info->bbr_bw_lo;
 
 		out(" bbr:(bw:%sbps,mrtt:%g",
-		    sprint_bw(b1, bw * 8.0),
-		    (double)s->bbr_info->bbr_min_rtt / 1000.0);
+			sprint_bw(b1, bw * 8.0),
+			(double)s->bbr_info->bbr_min_rtt / 1000.0);
 		if (s->bbr_info->bbr_pacing_gain)
 			out(",pacing_gain:%g",
-			    (double)s->bbr_info->bbr_pacing_gain / 256.0);
+				(double)s->bbr_info->bbr_pacing_gain / 256.0);
 		if (s->bbr_info->bbr_cwnd_gain)
 			out(",cwnd_gain:%g",
-			    (double)s->bbr_info->bbr_cwnd_gain / 256.0);
+				(double)s->bbr_info->bbr_cwnd_gain / 256.0);
 		out(")");
 	}
 
@@ -2999,12 +3034,12 @@ static void tcp_stats_print(struct tcpstat *s)
 		out(" busy:%llums", s->busy_time / 1000);
 		if (s->rwnd_limited)
 			out(" rwnd_limited:%llums(%.1f%%)",
-			    s->rwnd_limited / 1000,
-			    100.0 * s->rwnd_limited / s->busy_time);
+				s->rwnd_limited / 1000,
+				100.0 * s->rwnd_limited / s->busy_time);
 		if (s->sndbuf_limited)
 			out(" sndbuf_limited:%llums(%.1f%%)",
-			    s->sndbuf_limited / 1000,
-			    100.0 * s->sndbuf_limited / s->busy_time);
+				s->sndbuf_limited / 1000,
+				100.0 * s->sndbuf_limited / s->busy_time);
 	}
 
 	if (s->unacked)
@@ -3062,7 +3097,7 @@ static void tcp_timer_print(struct tcpstat *s)
 		else
 			name = tmr_name[s->timer];
 		out(" timer:(%s,%s,%d)", name,
-		    print_ms_timer(s->timeout), s->retrans);
+			print_ms_timer(s->timeout), s->retrans);
 	}
 }
 
@@ -3070,7 +3105,7 @@ static void sctp_timer_print(struct tcpstat *s)
 {
 	if (s->timer)
 		out(" timer:(T3_RTX,%s,%d)",
-		    print_ms_timer(s->timeout), s->retrans);
+			print_ms_timer(s->timeout), s->retrans);
 }
 
 static int tcp_show_line(char *line, const struct filter *f, int family)
@@ -3139,8 +3174,8 @@ static int tcp_show_line(char *line, const struct filter *f, int family)
 }
 
 static int generic_record_read(FILE *fp,
-			       int (*worker)(char*, const struct filter *, int),
-			       const struct filter *f, int fam)
+				   int (*worker)(char*, const struct filter *, int),
+				   const struct filter *f, int fam)
 {
 	char line[256];
 
@@ -3189,13 +3224,13 @@ static void print_skmeminfo(struct rtattr *tb[], int attrtype)
 	skmeminfo = RTA_DATA(tb[attrtype]);
 
 	out(" skmem:(r%u,rb%u,t%u,tb%u,f%u,w%u,o%u",
-		     skmeminfo[SK_MEMINFO_RMEM_ALLOC],
-		     skmeminfo[SK_MEMINFO_RCVBUF],
-		     skmeminfo[SK_MEMINFO_WMEM_ALLOC],
-		     skmeminfo[SK_MEMINFO_SNDBUF],
-		     skmeminfo[SK_MEMINFO_FWD_ALLOC],
-		     skmeminfo[SK_MEMINFO_WMEM_QUEUED],
-		     skmeminfo[SK_MEMINFO_OPTMEM]);
+			 skmeminfo[SK_MEMINFO_RMEM_ALLOC],
+			 skmeminfo[SK_MEMINFO_RCVBUF],
+			 skmeminfo[SK_MEMINFO_WMEM_ALLOC],
+			 skmeminfo[SK_MEMINFO_SNDBUF],
+			 skmeminfo[SK_MEMINFO_FWD_ALLOC],
+			 skmeminfo[SK_MEMINFO_WMEM_QUEUED],
+			 skmeminfo[SK_MEMINFO_OPTMEM]);
 
 	if (RTA_PAYLOAD(tb[attrtype]) >=
 		(SK_MEMINFO_BACKLOG + 1) * sizeof(__u32))
@@ -3215,7 +3250,7 @@ static void out_escape_buf(const __u8 *buf, size_t len, const char *escape)
 
 	for (i = 0; i < len; ++i) {
 		if (isprint(buf[i]) && buf[i] != '\\' &&
-		    !strchr(escape, buf[i]))
+			!strchr(escape, buf[i]))
 			out("%c", buf[i]);
 		else
 			out("\\%03o", buf[i]);
@@ -3225,10 +3260,10 @@ static void out_escape_buf(const __u8 *buf, size_t len, const char *escape)
 static void print_md5sig(struct tcp_diag_md5sig *sig)
 {
 	out("%s/%d=",
-	    format_host(sig->tcpm_family,
+		format_host(sig->tcpm_family,
 			sig->tcpm_family == AF_INET6 ? 16 : 4,
 			&sig->tcpm_addr),
-	    sig->tcpm_prefixlen);
+		sig->tcpm_prefixlen);
 	out_escape_buf(sig->tcpm_key, sig->tcpm_keylen, " ,");
 }
 
@@ -3245,12 +3280,12 @@ static void tcp_tls_version(struct rtattr *attr)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -3279,12 +3314,12 @@ static void tcp_tls_cipher(struct rtattr *attr)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -3310,12 +3345,12 @@ static void tcp_tls_conf(const char *name, struct rtattr *attr)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -3368,26 +3403,26 @@ static void mptcp_subflow_info(struct rtattr *tb[])
 			out(" flags:%s", caps);
 	}
 	if (tb[MPTCP_SUBFLOW_ATTR_TOKEN_REM] &&
-	    tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC] &&
-	    tb[MPTCP_SUBFLOW_ATTR_ID_REM] &&
-	    tb[MPTCP_SUBFLOW_ATTR_ID_LOC])
+		tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC] &&
+		tb[MPTCP_SUBFLOW_ATTR_ID_REM] &&
+		tb[MPTCP_SUBFLOW_ATTR_ID_LOC])
 		out(" token:%04x(id:%hhu)/%04x(id:%hhu)",
-		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_TOKEN_REM]),
-		    rta_getattr_u8(tb[MPTCP_SUBFLOW_ATTR_ID_REM]),
-		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC]),
-		    rta_getattr_u8(tb[MPTCP_SUBFLOW_ATTR_ID_LOC]));
+			rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_TOKEN_REM]),
+			rta_getattr_u8(tb[MPTCP_SUBFLOW_ATTR_ID_REM]),
+			rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC]),
+			rta_getattr_u8(tb[MPTCP_SUBFLOW_ATTR_ID_LOC]));
 	if (tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ])
 		out(" seq:%llu",
-		    rta_getattr_u64(tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ]));
+			rta_getattr_u64(tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ]));
 	if (tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ])
 		out(" sfseq:%u",
-		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ]));
+			rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ]));
 	if (tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET])
 		out(" ssnoff:%u",
-		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET]));
+			rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET]));
 	if (tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN])
 		out(" maplen:%u",
-		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN]));
+			rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN]));
 }
 
 #define TCPI_HAS_OPT(info, opt) !!(info->tcpi_options & (opt))
@@ -3558,7 +3593,7 @@ static void tcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,
 
 		if (ulpinfo[INET_ULP_INFO_NAME])
 			out(" tcp-ulp-%s",
-			    rta_getattr_str(ulpinfo[INET_ULP_INFO_NAME]));
+				rta_getattr_str(ulpinfo[INET_ULP_INFO_NAME]));
 
 		if (ulpinfo[INET_ULP_INFO_TLS]) {
 			struct rtattr *tlsinfo[TLS_INFO_MAX + 1] = { 0 };
@@ -3641,7 +3676,7 @@ static void mptcp_stats_print(struct mptcp_info *s)
 }
 
 static void mptcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,
-			    struct rtattr *tb[])
+				struct rtattr *tb[])
 {
 	print_skmeminfo(tb, INET_DIAG_SKMEMINFO);
 
@@ -3673,12 +3708,12 @@ static const char *format_host_sa(struct sockaddr_storage *sa)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -3738,7 +3773,7 @@ static void parse_diag_msg(struct nlmsghdr *nlh, struct sockstat *s)
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
 
 	parse_rtattr(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
-		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
+			 nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
 
 	s->state	= r->idiag_state;
 	s->local.family	= s->remote.family = r->idiag_family;
@@ -4125,7 +4160,7 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 
 			mask = rta_getattr_u8(tb[INET_DIAG_SHUTDOWN]);
 			out(" %c-%c",
-			    mask & 1 ? '-' : '<', mask & 2 ? '-' : '>');
+				mask & 1 ? '-' : '<', mask & 2 ? '-' : '>');
 		}
 	}
 
@@ -4145,7 +4180,7 @@ static int inet_show_sock(struct nlmsghdr *nlh,
 
 	if (show_inet_sockopt) {
 		if (tb[INET_DIAG_SOCKOPT] && RTA_PAYLOAD(tb[INET_DIAG_SOCKOPT]) >=
-		    sizeof(struct inet_diag_sockopt)) {
+			sizeof(struct inet_diag_sockopt)) {
 			const struct inet_diag_sockopt *sockopt =
 					RTA_DATA(tb[INET_DIAG_SOCKOPT]);
 			if (!oneline)
@@ -4571,7 +4606,7 @@ static int tcp_show(struct filter *f)
 		return tcp_show_netlink_file(f);
 
 	if (!getenv("PROC_NET_TCP") && !getenv("PROC_ROOT")
-	    && inet_show_netlink(f, NULL, IPPROTO_TCP) == 0)
+		&& inet_show_netlink(f, NULL, IPPROTO_TCP) == 0)
 		return 0;
 
 	/* Sigh... We have to parse /proc/net/tcp... */
@@ -4596,7 +4631,7 @@ static int tcp_show(struct filter *f)
 	}
 
 	if ((f->families & FAMILY_MASK(AF_INET6)) &&
-	    (fp = net_tcp6_open()) != NULL) {
+		(fp = net_tcp6_open()) != NULL) {
 		setbuffer(fp, buf, bufsize);
 		if (generic_record_read(fp, tcp_show_line, f, AF_INET6))
 			goto outerr;
@@ -4624,7 +4659,7 @@ static int mptcp_show(struct filter *f)
 		return 0;
 
 	if (!getenv("PROC_NET_MPTCP") && !getenv("PROC_ROOT")
-	    && inet_show_netlink(f, NULL, IPPROTO_MPTCP) == 0)
+		&& inet_show_netlink(f, NULL, IPPROTO_MPTCP) == 0)
 		return 0;
 
 	return 0;
@@ -4636,7 +4671,7 @@ static int sctp_show(struct filter *f)
 		return 0;
 
 	if (!getenv("PROC_NET_SCTP") && !getenv("PROC_ROOT")
-	    && inet_show_netlink(f, NULL, IPPROTO_SCTP) == 0)
+		&& inet_show_netlink(f, NULL, IPPROTO_SCTP) == 0)
 		return 0;
 
 	return 0;
@@ -4664,9 +4699,9 @@ static int dgram_show_line(char *line, const struct filter *f, int family)
 
 	opt[0] = 0;
 	n = sscanf(data, "%x %x:%x %*x:%*x %*x %d %*d %u %d %llx %[^\n]\n",
-	       &s.state, &s.wq, &s.rq,
-	       &s.uid, &s.ino,
-	       &s.refcnt, &s.sk, opt);
+		   &s.state, &s.wq, &s.rq,
+		   &s.uid, &s.ino,
+		   &s.refcnt, &s.sk, opt);
 
 	if (n < 9)
 		opt[0] = 0;
@@ -4690,7 +4725,7 @@ static int udp_show(struct filter *f)
 	dg_proto = UDP_PROTO;
 
 	if (!getenv("PROC_NET_UDP") && !getenv("PROC_ROOT")
-	    && inet_show_netlink(f, NULL, IPPROTO_UDP) == 0)
+		&& inet_show_netlink(f, NULL, IPPROTO_UDP) == 0)
 		return 0;
 
 	if (f->families&FAMILY_MASK(AF_INET)) {
@@ -4702,7 +4737,7 @@ static int udp_show(struct filter *f)
 	}
 
 	if ((f->families&FAMILY_MASK(AF_INET6)) &&
-	    (fp = net_udp6_open()) != NULL) {
+		(fp = net_udp6_open()) != NULL) {
 		if (generic_record_read(fp, dgram_show_line, f, AF_INET6))
 			goto outerr;
 		fclose(fp);
@@ -4730,7 +4765,7 @@ static int raw_show(struct filter *f)
 	dg_proto = RAW_PROTO;
 
 	if (!getenv("PROC_NET_RAW") && !getenv("PROC_ROOT") &&
-	    inet_show_netlink(f, NULL, IPPROTO_RAW) == 0)
+		inet_show_netlink(f, NULL, IPPROTO_RAW) == 0)
 		return 0;
 
 	if (f->families&FAMILY_MASK(AF_INET)) {
@@ -4742,7 +4777,7 @@ static int raw_show(struct filter *f)
 	}
 
 	if ((f->families&FAMILY_MASK(AF_INET6)) &&
-	    (fp = net_raw6_open()) != NULL) {
+		(fp = net_raw6_open()) != NULL) {
 		if (generic_record_read(fp, dgram_show_line, f, AF_INET6))
 			goto outerr;
 		fclose(fp);
@@ -4805,7 +4840,7 @@ static int unix_show_sock(struct nlmsghdr *nlh, void *arg)
 	struct sockstat stat = { .name = "*", .peer_name = "*" };
 
 	parse_rtattr(tb, UNIX_DIAG_MAX, (struct rtattr *)(r+1),
-		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
+			 nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
 
 	stat.type  = r->udiag_type;
 	stat.state = r->udiag_state;
@@ -4851,7 +4886,7 @@ static int unix_show_sock(struct nlmsghdr *nlh, void *arg)
 
 			mask = rta_getattr_u8(tb[UNIX_DIAG_SHUTDOWN]);
 			out(" %c-%c",
-			    mask & 1 ? '-' : '<', mask & 2 ? '-' : '>');
+				mask & 1 ? '-' : '<', mask & 2 ? '-' : '>');
 		}
 		if (tb[UNIX_DIAG_VFS]) {
 			struct unix_diag_vfs *uv = RTA_DATA(tb[UNIX_DIAG_VFS]);
@@ -4926,7 +4961,7 @@ static int unix_show(struct filter *f)
 		return 0;
 
 	if (!getenv("PROC_NET_UNIX") && !getenv("PROC_ROOT")
-	    && unix_show_netlink(f) == 0)
+		&& unix_show_netlink(f) == 0)
 		return 0;
 
 	if ((fp = net_unix_open()) == NULL)
@@ -4964,7 +4999,7 @@ static int unix_show(struct filter *f)
 				u->state = SS_ESTABLISHED;
 		}
 		if (unix_type_skip(u, f) ||
-		    !(f->states & (1 << u->state))) {
+			!(f->states & (1 << u->state))) {
 			free(u);
 			continue;
 		}
@@ -5019,8 +5054,8 @@ static int unix_show(struct filter *f)
 		insp = &list;
 		while (*insp) {
 			if (u->type < (*insp)->type ||
-			    (u->type == (*insp)->type &&
-			     u->ino < (*insp)->ino))
+				(u->type == (*insp)->type &&
+				 u->ino < (*insp)->ino))
 				break;
 			insp = &(*insp)->next;
 		}
@@ -5102,7 +5137,7 @@ static int packet_show_sock(struct nlmsghdr *nlh, void *arg)
 	bool has_fanout = false;
 
 	parse_rtattr(tb, PACKET_DIAG_MAX, (struct rtattr *)(r+1),
-		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
+			 nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
 
 	/* use /proc/net/packet if all info are not available */
 	if (!tb[PACKET_DIAG_MEMINFO])
@@ -5211,7 +5246,7 @@ static int packet_show_sock(struct nlmsghdr *nlh, void *arg)
 
 	if (show_bpf && tb[PACKET_DIAG_FILTER]) {
 		struct sock_filter *fil =
-		       RTA_DATA(tb[PACKET_DIAG_FILTER]);
+			   RTA_DATA(tb[PACKET_DIAG_FILTER]);
 		int num = RTA_PAYLOAD(tb[PACKET_DIAG_FILTER]) /
 			  sizeof(struct sock_filter);
 
@@ -5221,7 +5256,7 @@ static int packet_show_sock(struct nlmsghdr *nlh, void *arg)
 			out("\n\tbpf filter (%d): ", num);
 		while (num) {
 			out(" 0x%02x %u %u %u,",
-			    fil->code, fil->jt, fil->jf, fil->k);
+				fil->code, fil->jt, fil->jf, fil->k);
 			num--;
 			fil++;
 		}
@@ -5389,7 +5424,7 @@ static int xdp_show_sock(struct nlmsghdr *nlh, void *arg)
 	struct sockstat stat = {};
 
 	parse_rtattr(tb, XDP_DIAG_MAX, (struct rtattr *)(msg + 1),
-		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*msg)));
+			 nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*msg)));
 
 	stat.type = msg->xdiag_type;
 	stat.ino = msg->xdiag_ino;
@@ -5562,7 +5597,7 @@ static int netlink_show_sock(struct nlmsghdr *nlh, void *arg)
 	unsigned long groups = 0;
 
 	parse_rtattr(tb, NETLINK_DIAG_MAX, (struct rtattr *)(r+1),
-		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
+			 nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
 
 	if (tb[NETLINK_DIAG_GROUPS] && RTA_PAYLOAD(tb[NETLINK_DIAG_GROUPS]))
 		groups = *(unsigned long *) RTA_DATA(tb[NETLINK_DIAG_GROUPS]);
@@ -5626,8 +5661,8 @@ static int netlink_show(struct filter *f)
 
 	while (fgets(buf, sizeof(buf), fp)) {
 		sscanf(buf, "%llx %d %d %x %d %d %llx %d",
-		       &sk,
-		       &prot, &pid, &groups, &rq, &wq, &cb, &rc);
+			   &sk,
+			   &prot, &pid, &groups, &rq, &wq, &cb, &rc);
 
 		netlink_show_one(f, prot, pid, groups, 0, 0, 0, rq, wq, sk, cb);
 	}
@@ -5739,18 +5774,18 @@ static int tipc_show_sock(struct nlmsghdr *nlh, void *arg)
 	struct sockstat ss = {};
 
 	parse_rtattr(info, TIPC_NLA_MAX, NLMSG_DATA(nlh),
-		     NLMSG_PAYLOAD(nlh, 0));
+			 NLMSG_PAYLOAD(nlh, 0));
 
 	if (!info[TIPC_NLA_SOCK])
 		return 0;
 
 	msg_ref = info[TIPC_NLA_SOCK];
 	parse_rtattr(attrs, TIPC_NLA_SOCK_MAX, RTA_DATA(msg_ref),
-		     RTA_PAYLOAD(msg_ref));
+			 RTA_PAYLOAD(msg_ref));
 
 	msg_ref = attrs[TIPC_NLA_SOCK_STAT];
 	parse_rtattr(stat, TIPC_NLA_SOCK_STAT_MAX,
-		     RTA_DATA(msg_ref), RTA_PAYLOAD(msg_ref));
+			 RTA_DATA(msg_ref), RTA_PAYLOAD(msg_ref));
 
 
 	ss.local.family = AF_TIPC;
@@ -5765,12 +5800,12 @@ static int tipc_show_sock(struct nlmsghdr *nlh, void *arg)
 	sock_state_print (&ss);
 
 	tipc_sock_addr_print(attrs[TIPC_NLA_SOCK_ADDR],
-			     attrs[TIPC_NLA_SOCK_REF]);
+				 attrs[TIPC_NLA_SOCK_REF]);
 
 	msg_ref = attrs[TIPC_NLA_SOCK_CON];
 	if (msg_ref) {
 		parse_rtattr(con, TIPC_NLA_CON_MAX,
-			     RTA_DATA(msg_ref), RTA_PAYLOAD(msg_ref));
+				 RTA_DATA(msg_ref), RTA_PAYLOAD(msg_ref));
 
 		tipc_sock_addr_print(con[TIPC_NLA_CON_NODE],
 				     con[TIPC_NLA_CON_SOCK]);
@@ -5788,18 +5823,18 @@ static int tipc_show_sock(struct nlmsghdr *nlh, void *arg)
 		else
 			out("\n type:%s", stype_nameg[ss.type]);
 		out(" cong:%s ",
-		       stat[TIPC_NLA_SOCK_STAT_LINK_CONG] ? "link" :
-		       stat[TIPC_NLA_SOCK_STAT_CONN_CONG] ? "conn" : "none");
+			   stat[TIPC_NLA_SOCK_STAT_LINK_CONG] ? "link" :
+			   stat[TIPC_NLA_SOCK_STAT_CONN_CONG] ? "conn" : "none");
 		out(" drop:%d ",
-		       rta_getattr_u32(stat[TIPC_NLA_SOCK_STAT_DROP]));
+			   rta_getattr_u32(stat[TIPC_NLA_SOCK_STAT_DROP]));
 
 		if (attrs[TIPC_NLA_SOCK_HAS_PUBL])
 			out(" publ");
 
 		if (con[TIPC_NLA_CON_FLAG])
 			out(" via {%u,%u} ",
-			       rta_getattr_u32(con[TIPC_NLA_CON_TYPE]),
-			       rta_getattr_u32(con[TIPC_NLA_CON_INST]));
+				   rta_getattr_u32(con[TIPC_NLA_CON_TYPE]),
+				   rta_getattr_u32(con[TIPC_NLA_CON_INST]));
 	}
 
 	return 0;
@@ -5831,12 +5866,12 @@ static int generic_show_sock(struct nlmsghdr *nlh, void *arg)
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -5933,7 +5968,7 @@ static int get_snmp_int(char *proto, char *key, int *result)
 			pos++;
 			p++;
 			if (memcmp(p, key, keylen) == 0 &&
-			    (p[keylen] == ' ' || p[keylen] == '\n'))
+				(p[keylen] == ' ' || p[keylen] == '\n'))
 				break;
 		}
 		if (fgets(buf, sizeof(buf), fp) == NULL)
@@ -6002,8 +6037,8 @@ static void get_sockstat_line(char *line, struct ssummary *s)
 		sscanf(rem, "%*s%d%*s%d", &s->frag6, &s->frag6_mem);
 	else if (strcmp(id, "TCP:") == 0)
 		sscanf(rem, "%*s%d%*s%d%*s%d%*s%d%*s%d",
-		       &s->tcp4_hashed,
-		       &s->tcp_orphans, &s->tcp_tws, &s->tcp_total, &s->tcp_mem);
+			   &s->tcp4_hashed,
+			   &s->tcp_orphans, &s->tcp_tws, &s->tcp_total, &s->tcp_mem);
 }
 
 static int get_sockstat(struct ssummary *s)
@@ -6041,9 +6076,9 @@ static int print_summary(void)
 	printf("Total: %d\n", s.socks);
 
 	printf("TCP:   %d (estab %d, closed %d, orphaned %d, timewait %d)\n",
-	       s.tcp_total + s.tcp_tws, tcp_estab,
-	       s.tcp_total - (s.tcp4_hashed + s.tcp6_hashed - s.tcp_tws),
-	       s.tcp_orphans, s.tcp_tws);
+		   s.tcp_total + s.tcp_tws, tcp_estab,
+		   s.tcp_total - (s.tcp4_hashed + s.tcp6_hashed - s.tcp_tws),
+		   s.tcp_orphans, s.tcp_tws);
 
 	printf("\n");
 	printf("Transport Total     IP        IPv6\n");
@@ -6051,10 +6086,10 @@ static int print_summary(void)
 	printf("UDP	  %-9d %-9d %-9d\n", s.udp4+s.udp6, s.udp4, s.udp6);
 	printf("TCP	  %-9d %-9d %-9d\n", s.tcp4_hashed+s.tcp6_hashed, s.tcp4_hashed, s.tcp6_hashed);
 	printf("INET	  %-9d %-9d %-9d\n",
-	       s.raw4+s.udp4+s.tcp4_hashed+
-	       s.raw6+s.udp6+s.tcp6_hashed,
-	       s.raw4+s.udp4+s.tcp4_hashed,
-	       s.raw6+s.udp6+s.tcp6_hashed);
+		   s.raw4+s.udp4+s.tcp4_hashed+
+		   s.raw6+s.udp6+s.tcp6_hashed,
+		   s.raw4+s.udp4+s.tcp4_hashed,
+		   s.raw6+s.udp6+s.tcp6_hashed);
 	printf("FRAG	  %-9d %-9d %-9d\n", s.frag4+s.frag6, s.frag4, s.frag6);
 
 	printf("\n");
@@ -6172,7 +6207,7 @@ static int scan_state(const char *state)
 		goto wrong_state;
 
 	if (strcasecmp(state, "close") == 0 ||
-	    strcasecmp(state, "closed") == 0)
+		strcasecmp(state, "closed") == 0)
 		return (1<<SS_CLOSE);
 	if (strcasecmp(state, "syn-rcv") == 0)
 		return (1<<SS_SYN_RECV);
@@ -6217,10 +6252,69 @@ wrong_state:
 #define OPT_BPF_MAPS 263
 #define OPT_BPF_MAP_ID 264
 
+static int show_process_age;
+
+static void print_process_age(pid_t pid)
+{
+	char path[64];
+	FILE *f;
+	unsigned long long starttime;
+	double uptime = 0.0;
+	long clock_ticks = sysconf(_SC_CLK_TCK);
+
+	f = fopen("/proc/uptime", "r");
+	if (!f)
+		return;
+
+	if (fscanf(f, "%lf", &uptime) != 1) {
+		fclose(f);
+		return;
+	}
+	fclose(f);
+
+	snprintf(path, sizeof(path), "/proc/%d/stat", pid);
+	f = fopen(path, "r");
+	if (!f)
+		return;
+
+	char buf[1024];
+
+	if (fgets(buf, sizeof(buf), f)) {
+		char *ptr = strrchr(buf, ')');
+
+		if (ptr) {
+			int field = 3;
+
+			ptr++;
+			while (*ptr && field < 22) {
+				if (*ptr == ' ')
+					field++;
+				ptr++;
+			}
+			if (sscanf(ptr, "%llu", &starttime) == 1) {
+				double process_secs = uptime - ((double)starttime / clock_ticks);
+				long secs = (long)process_secs;
+				long hours = secs / 3600;
+				long mins = (secs % 3600) / 60;
+				long s = secs % 60;
+
+				if (hours > 0)
+					out(",age=%ldh%ldm", hours, mins);
+				else if (mins > 0)
+					out(",age=%ldm%lds", mins, s);
+				else
+					out(",age=%lds", s);
+			}
+		}
+	}
+	fclose(f);
+}
+
 static const struct option long_opts[] = {
 	{ "process-age", no_argument, NULL, 'P' },
 	{ "process-age", no_argument, NULL, 'P' },
 	{ "process-age", no_argument, NULL, 'P' },
+	{ "process-age", no_argument, NULL, 'P' },
 	{ "numeric", 0, 0, 'n' },
 	{ "resolve", 0, 0, 'r' },
 	{ "options", 0, 0, 'o' },
@@ -6283,20 +6377,28 @@ int main(int argc, char *argv[])
 	int ch;
 	int state_filter = 0;
 
+		case 'P':
+			show_process_age = 1;
+		show_processes = 1;
+		break;
 	while ((ch = getopt_long(argc, argv,
 				 "halBetuwxnro460spTbEf:mMiA:D:F:vVzZN:KHQSOPPP",
 				 long_opts, NULL)) != EOF) {
 		switch (ch) {
+		case 'P':
+			show_process_age = 1;
+		show_processes = 1;
+		break;
 	case \'P\':
 		show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
-	case 'P':
-		show_process_age = 1;
+		case 'P':
+			show_process_age = 1;
 		show_processes = 1;
 		break;
 	
@@ -6550,7 +6652,7 @@ int main(int argc, char *argv[])
 
 #ifdef HAVE_RPC
 	if (!numeric && resolve_hosts &&
-	    (current_filter.dbs & (UNIX_DBM|INET_L4_DBM)))
+		(current_filter.dbs & (UNIX_DBM|INET_L4_DBM)))
 		init_service_resolver();
 #endif
 
-- 
2.43.7

