Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285F4C14ED
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 18:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789497676; cv=none; b=YKTPmwwPcOw6nr0MbfYi5Rp9nPFIg7hgZayfceKOTtrFXKAXbVeEs4m6rSFDnh+cL+XA1yH2LLJbAYzlp42Gl4InXfZRAHhdMJvlxNhg20j/j2JVGXY6SIHHCtneEfxis0/y1IFz3R/HNfWM2fa51Tj0mokvFjQCYMUMhu21V4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789497676; c=relaxed/simple;
	bh=PYOWye1+Ykgf4RApCWHWK0x77oDpUj9fGgitfKXQsFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djUDO3IapZ+Bpmoiv0tXTgJ+tNqh4pWH/QG6Z3uV5sY+P/ZK1rC1Lf4/U9LFRC9pDmAWMwYexYfSwlqF6gqw97//4s2+Zmh3YsEvSxufewu5NoIr+zuIIYaeF36EpPkYV+wUdRMtbmKf1RgnOQ39qqiwlQSLZY3b5VyQToK9O3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPPeGrsx; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPPeGrsx"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85f0fc1fd8eso34294b3a.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 11:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789497673; x=1790102473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EaBCoujg1Md3+tcZVt/F9CgQEMG62zB5XWPw17HcJjM=;
        b=dPPeGrsxs90hF43yWtLdYTY4ZvNEA/cRSsLpXx8icUmsHBSSzF+/ImwIxk2zF5aTUC
         Y0r3CtGC/QCrbG8dV3B8+PY57AougSMzDQL48EA45u7wszZKxbhBSVE6prUv6+BLrzAG
         0u7SYOPHDXLUfL8GmMCLVNzkyNlZ+53iSFAN8hFC0Fn5J2utAC4eI1ZqlJDMdCmtAQqC
         rPzfSzRVj+9Cyl05lcOGzLmsC8Y+kac1/tUOgqyLBbyaMzc//IW3ov4T7BOh37sILrLX
         8Y6P4qAOXdWg0UoQCYia26E3djA1Xx/aUuCK5HUW1SqOBS417XpchMhKWljwUA9K219c
         xrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789497673; x=1790102473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EaBCoujg1Md3+tcZVt/F9CgQEMG62zB5XWPw17HcJjM=;
        b=0nvxuDDbkfdeIsky5sE1Qq0cABQOC5thjz6cy/+2Wi80Rb2IHYG/2V8U5Ehwj6XZR1
         M/SgQxSriY9eZny/l/6J3cUFPpyRhN+W/ja+PY7FYZ9AUcWg4BWUe76U69Do1TW+KSeU
         oraEcn3N3TfTdRK4vFJKlPZII813gZH71h+ZrDOIvdWMg9mBUUv9lfJx2s3Br99uNJka
         jzrEa7caJ6yPLyXHQi/f5FbRYAQKgdZXICSiXoaqzEHECpqmzPP6fLClhnct42WvFSn+
         bGY27eMhvrGD4NsGRmohCdh2pKUu3VSTDH2S4q67RLSnJ63CtviKhPafHoIEea/N+rwZ
         4jnA==
X-Gm-Message-State: AFuF++k8lm6ilvFjMFSTB8epfrHAHv8kwNJa/C50rfRVFa5jC5GjSHoz
	kq3T3YMktCGlr4mVs5FQMYyFm/ekNV8stvcYS0/vfByB+Bh5+9iurQ95cdu8LQ==
X-Gm-Gg: AYBFou3Q125NOVjYgx7R7IkKs54YHpix75nuiVp3eOj91YqGEGgQVv/bTVRAWE0WDQf
	Uo5unTT0pZcNbsKOco4kH1MlGt7vqq9yZUeanFRY079fBm7dwv/eEByGa79M6XautfJr2g54DPk
	02s0k4w2MP4rq4sj5WPLnJxnDI4fmaBkt6MKB4ILm6VaRHsJ3RmZ20gVqNMf9kxjD8MfUBmvqQ9
	HBfkdXmR331KYYB9UZHhHp+tj7mtBFMpbPN66Mir7lVklpNipHHTQf55HGs6RZOFHikuNBhRKr1
	5ym0A6fUm6M+PL9voKG0hlT4YFEz3DxG4zOnmPZpqpbxe935yecVqsKqLLsxFeLwE72GwYoQ7Ls
	ca+hR8Tpn+5oKc2QahzmWysvkZkVrETNazmYDf99IwqcU22Uxv4T9ksjKQKXFkzLmiO+l3j3Cfo
	j1YtYuWsXk3V3Pi1Nlu0jDm6IqlNe6B6+XqYSL/8cf2myIN6RdQ6b5KZZPRb4oopR3aC9BpQ0zg
	2gSNMDYQNsX35kpIG3bQUtqnfXVBSbp6XsHCJ/krw90p+ZPTnOmjntqgY9JpI75Vws8lNDf/rU=
X-Received: by 2002:a05:6a21:517:b0:3c3:a20f:f729 with SMTP id adf61e73a8af0-3dd52688949mr5369166637.7.1789497673304;
        Tue, 15 Sep 2026 11:41:13 -0700 (PDT)
Received: from localhost.ghari-thinkpadp1gen7.rmtin.csb ([111.92.26.108])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b030aesm772380eec.26.2026.09.15.11.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 11:41:12 -0700 (PDT)
From: Harshith Hari <harshithhari000111@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	Harshith Hari <harshithhari000111@gmail.com>
Subject: [PATCH iproute2] ss: add -P/--process-age option to display process runtime
Date: Wed, 16 Sep 2026 00:05:22 +0530
Message-ID: <20260915183522.63865-1-harshithhari000111@gmail.com>
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
 man/man8/ss.8 |   3 +
 misc/ss.c     | 456 ++++++++++++++++++++++++++++++--------------------
 2 files changed, 282 insertions(+), 177 deletions(-)

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
index 6c32455d..66fb1fee 100644
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
 	
@@ -2727,42 +2728,76 @@ static void proc_ctx_print(struct sockstat *s)
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
 	
-- 
2.43.7

