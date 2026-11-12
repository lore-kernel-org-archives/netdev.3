Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513657;
	b=KO5NrKMnkh1sEkvYAlaLxIacxZUy9CGIVl8wlgr8ROgOFhUNYgyP8dqnaE4Wim0o1RYH
	 WhfNTTJcQKFcT33/YwgMsQ/n5QLxMLkq+HcEGFl03v44fzPLgsjbAFUhsnM/ltwyLOTtr
	 aZdx0G7kJXvfkbAv2v5bs8qUXSfKCqnYPp3oDJs7nkXEfPx0cFAhs8KKhCZGrZQhVmhKb
	 QmFMeARkd1rOE3NagGXktC8630GvLrOVyLGLjuz8JYfiNsnXQLEvj9rn3sU89LBt0LN2H
	 fY24iQUhkhSavOwwmkv9exVhFUAb5hB6BCw1TQV+lesnKt/0IGA8Nig+8YKx3f+MxiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WdvdDGSFWIEla4D7hHqsS8B6Zb6SHYxSoLi9gbVDLFs=;
	b=Xfa2iYmj4Xqm8Na0uDyqZjFhQoLjSXjAN+LlfiyDgBX8Id3DJHqbh2uj+bbOedG2E00c
	 75rQ03klfgYZduRgMPwcDp0aJt5ltz+hPuG67OBHwweqIOORwFKWzr1zJFb19NPx3ytDB
	 pdLvFIM3H8gPLAGitWA0GcSxMP7fHhl58bj6hTmToDF2wpjMxV/IiduaLNzQUMRs8mX68
	 jueg7eBaU74L6yTi8SrrNw0ZYgkyVT45x/UftqjKsuwpL73rIlGXDE8FjRlWvhaCicZuK
	 JN6Sj8eBnV1NXEirqQoTleeZibTZCqhwU6oDKFxjPADnH4oa5w29JOyN+y/jxIJ2LXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZTqLQVAh;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6FB606A8BA
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F6FB606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ZTqLQVAh
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0b3438540so150977a91.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794513656; x=1795118456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WdvdDGSFWIEla4D7hHqsS8B6Zb6SHYxSoLi9gbVDLFs=;
        b=ZTqLQVAhMFA9aa7X+aFHrsCURiAdJZtGQiuORETcx3elZaycJjK1qHKHI3QdMxX+CP
         0Df+y9EnEUq+Dbznsjv6sl+3HXNI3t8mg4+KEENidgmCDesYdANNVIVzUBkHBOH5Qe/d
         KhY/nQCoPtgc+7w7WCP1HeEGApRVBfCUcXz4mwU7YJHgWxvJWUu1/SbE2qz9q+CwOkAx
         FBxVsrQW5H9dkrZw1UDO1fligpYfPkcqYB8u4aOWt/32a+VeK1edVdYDHopYDZZ+kYtd
         qnW8/U8Dpt9FT7LZbjJ8Qn/Lt4IzTQe6mYL3Vgs/RKXt/8F7Xb61wcqqo1wQyNRasHMc
         M3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513656; x=1795118456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WdvdDGSFWIEla4D7hHqsS8B6Zb6SHYxSoLi9gbVDLFs=;
        b=txlmKyfmubIl0dhVYZSnp23obmtzYn/5jtR3K9q1tFQ9WSnDArmrQznhV9w+Mv/i1w
         ySZvTUWU6MJ0QxIUrHCaUrxazAKu8aTgm1MWqtLVHuDiMlFi7oQzpzmeryslj+OEIN1a
         4FPnJ/m6tbrpPXS/+5+ZdwDLR706QXelnTrtMxcuY23JPnUkMUThIxpCtl+Sl0lkdrxd
         dWimsohG1GFQ2ZbpHbrYGQIuLsHZ6WxpEdonqONXIoT8XRqCTA5lIQseSLpGJbxT80b+
         0perLiX74WwIURkDwIq/S/9zbn9exRHUHkcd7GNiV2iJl2qFQQvkccFVSOj1LaZbAgI6
         ZMhA==
X-Gm-Message-State: APuU4Z8MI64tB9uKE1Nz3z56NjrccAQEcjHt7KyMARGHuqG6jJ5n/QUW
	VNs2a9xKx6sQuWiBJOaZE1qhfAA2pwtrRPpn2y04ljchwW5j2DjqLhUcehsfP5LjBjcha9XmJDj
	uQfLii+Q=
X-Gm-Gg: AYBFou2fR3XInNqj6Wq3eAPRc5FO/qivKjGLyCNW0eU7xUBbq395i5kfAEQnPDGew/G
	4z6wL2ge7dzz0/4cB5x6it4yJYOn0zFmORU+ALQFRDu4s+6+f+0ebAFK71zvdQaS0f6QaGr9e3t
	ArZ1NgNoSwnxJja3m6fRVapjySlSaAZaIXrgHErYuxcX+02wTx0MKlEXzmNUipA3jjWDj2U63tY
	mSTFDD9GjKmNwf0++O2g2dbpEOaEKPbG/CTeHNQ5vXc/i8obGVoMMF4SFwZu2G2qpPAy6RNJ6sv
	MuaBMtDJSRbRV7Ep1E6NJijsfPsdoy4qXTkgdtps9sWWU7LqF4AgFjhF7kBEqKhtMFBhombr1q3
	yRQiv6dmymqiNXrEcgqf05BiTCozpMFucVPX/SPDjROqFKBS8EscxsB/nXOvZ9ordsh2WWRd0I9
	ZEt2bdG9Ln6PxD/iAtBoeFQeQhmYwZYKpovziD5kHTzcZbDy0kLRYMab/zDgsu6cEJBHjmbVRsz
	WGbJK8b9G2ZvJt9CELYinDknWssbmjQRwCeRVjDC9peUdHoYBaAeCnaH/D7ZQqiNOPtDly7/9ip
	htGqCfOE9Rmzmf3DU8umGRzlLTiv7Ozfm8hZjLEMdnmtfK7JVdL0HrJsjhjRZuoeJsmjPfkvWkW
	96Jk2BQ4JUvN/A6o5
X-Received: by 2002:a17:90b:5546:b0:3b0:bcf4:6cde with SMTP id 98e67ed59e1d1-3b1b0a46cb4mr154735a91.45.1794513656523;
        Thu, 12 Nov 2026 12:00:56 -0800 (PST)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d27d26sm5967123a91.13.2026.11.12.12.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:00:56 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 09/11] ss: check owner before naming a netlink socket
Date: Thu, 12 Nov 2026 11:59:22 -0800
Message-ID: <20261112200046.2164391-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112200046.2164391-1-stephen@networkplumber.org>
References: <20261112200046.2164391-1-stephen@networkplumber.org>
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
index 9d2f9891..6d37f676 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -4662,10 +4662,47 @@ static int xdp_show(struct filter *f)
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
@@ -4679,6 +4716,7 @@ static int netlink_show_one(struct filter *f,
 	SPRINT_BUF(prot_buf) = {};
 	const char *prot_name;
 	char procname[64] = {};
+	bool is_owner = false;
 
 	if (f->f) {
 		st.rport = -1;
@@ -4692,6 +4730,9 @@ static int netlink_show_one(struct filter *f,
 
 	prot_name = nl_proto_n2a(prot, prot_buf, sizeof(prot_buf));
 
+	if (pid > 0 && (!numeric || show_proc_ctx))
+		is_owner = netlink_pid_holds_sock(pid, ino);
+
 	if (pid == -1) {
 		procname[0] = '*';
 	} else if (!numeric) {
@@ -4701,7 +4742,7 @@ static int netlink_show_one(struct filter *f,
 		if (!pid) {
 			done = 1;
 			strncpy(procname, "kernel", 7);
-		} else if (pid > 0) {
+		} else if (is_owner) {
 			if (get_task_name(getenv("PROC_ROOT"), pid,
 					  task, sizeof(task)) == 0) {
 				escape_str(procname, task, sizeof(procname));
@@ -4734,13 +4775,13 @@ static int netlink_show_one(struct filter *f,
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
@@ -4779,7 +4820,7 @@ static int netlink_show_sock(struct nlmsghdr *nlh, void *arg)
 
 	if (netlink_show_one(f, r->ndiag_protocol, r->ndiag_portid, groups,
 			 r->ndiag_state, r->ndiag_dst_portid, r->ndiag_dst_group,
-			 rq, wq, 0, 0)) {
+			 rq, wq, r->ndiag_ino, 0, 0)) {
 		return 0;
 	}
 
-- 
2.53.0

