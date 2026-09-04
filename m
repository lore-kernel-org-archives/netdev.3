Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484A4071F3
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521533; cv=none; b=F/EK0gZjiYobFwjIUhEmmp69vUBq6sDS1qu26XL7LEfXMluR9S82wG9/gZI8iPid2wfnhpPUK1kFHSSwrveSCKrT85aC/+tCoESj1q0j0Et5I8CIMRfjn9+Y0gpAM//A81Ppn+N3GWxxK07cMW8n2RHYDWYQ4ichJ4VK8idaJkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521533; c=relaxed/simple;
	bh=38UgEEZiyW/NBOETLSrjwKZcVSZSRYGLnoLukZ2KR8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZQDpEijIwO/tSL5Oe7arhuf6tkRdPwddn4C4+gvCe1tbT/OcDTxbCt+VcKzEn5yt2+Dd85tDWydB0PN1oQwUc9xmOYg58KoYHq7SuQj73XIJ1+IYVufxPnTWZM9na7iTkeUBBWqrmXtxcSffBVeiF1AURVfRrPPZnNWTxZpKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFR76VWV; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFR76VWV"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b128dd0cb1so547304eaf.3
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 04:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788521530; x=1789126330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ASwWm2X7Nj827Al3HxyPXm6hFchFaQIpjPDkuNerF0o=;
        b=iFR76VWVeK6eDFqcM9+ZbVfWnTHUiaWnAFveh/7sISmFSxVnppg5fjDFxJwVDeSqLw
         QHsN78YpocBGTaQZZtEQImBQwmaFbXSMJmxkkQ31CT9FbNci4G9rKASOcL81PToceVe3
         ZT6qo0qpo0wcvv6OXlEfevjcQknCeA7vUZl1d+y5fUnvrr823OXAdbBd2FKmocNIQVRD
         vrTn/KhBT2rmRPM6msXPLZ65wFOxC+Cxr0OLET4lbjLHg/BAQlfJYhR6y6gOnGi1DBVq
         Lb2rTJnU6XL4SNQHgDIj5dxzYUwlNqaxnGpPq5X4nz5Ei8slUpRkQndRzMp1xPfOc8D8
         DGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521530; x=1789126330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ASwWm2X7Nj827Al3HxyPXm6hFchFaQIpjPDkuNerF0o=;
        b=OfsYaInx7NUwF5LJdaxwwuHU1ISDhtBMHPkuYod9DkvCieHfsIonD3CFa7FPXHWxof
         SB2/8SH7ogqmXYW1kS9d94gxzpsaNG0XnSE+b+YpESVUE2xWlw46DHseI57UqfVBOEfL
         lXrjsdNk4rvsEDTgIbqI2ZZmtD32lK9VH0/e6/lK+cYVRmDFpakE7qR+vVousy0zTnoi
         JZuBU8V0psXqZF+vdQvjrMbSZze4Ozmt/hOf6dbqpQWJaSVNEat3o2Mbz6VhEowT9DY4
         vkB7ClX7oAMRU6bUphvT/XGJO644sXI3+/cOUGd9VWvL5Zg5se981++PmSsnQgvDZLdC
         uUcw==
X-Forwarded-Encrypted: i=1; AKwUvBx6KEkRwQjTDWINzzJB/N31bl5msxbBWIm9gIiU7vlFw5GrxKTyFfJsrojwdBDOD7NdZ+K/WBo=@vger.kernel.org
X-Gm-Message-State: AFuF++kR3LfTT1O/JnwaKVo82Ojim5WxcR1HRLscvht8i0h6atm7gt5N
	9oNtPaDgfFQ3nFLcHIIZj7azivMNWYpOG6+gYmrXSlojUq48PBUZXC6w
X-Gm-Gg: AYBFou2zLrRPB2cj/2TJlBb8MOxZ8uiyaNiBXILNtCvZ3cg4kcw+2wYcC/fw510DoRL
	C7YiNin/D45c7gqNntYROTcfjv1qu1+sBLc8B1G8cscI4A0fAgQUSvXFO9XYq5qfq+O2GKM29zx
	r+F1O/GtiQafeMKBxmKyQ4aJAfqXGFN205bT2sUSxq9IOogGhIS4g4swTYU6Rwge92WmOq4NWyA
	IZH50CZcPd8v1AX5pWkEH+MZRRZn5/xVp/vpNiPjMAYBZ83gkThXJgodLSYQ7FiF/T9TFjOYvNe
	2MrA8JfcHIJgYmenHSVnnVOd58rZXuN5Mod/HYQYtfL2ZgLuGNWZpGIgWsMf6u1odEIKM6R69yb
	gmXACZJ+4jDRRK/Moo6otYZv63luHtjiIUI9hCN8MY6a4OvUJONuhXoEm/UtP610YiQpPT5vM3k
	h53HOsUsevhnIbYkJ+wt55wmY1fpqgJf398Ek5klD9LhBhpokNU2pp8w4msOFMgWMdFAjXnGtp8
	l0xAmUlBXqhGa4=
X-Received: by 2002:a05:6820:4d09:b0:6b1:a667:f0f5 with SMTP id 006d021491bc7-6b6fcedc374mr3749263eaf.20.1788521530465;
        Fri, 04 Sep 2026 04:32:10 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befdefcsm5259443eec.29.2026.09.04.04.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:32:10 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] nfs: fix typos in comments
Date: Fri,  4 Sep 2026 17:01:59 +0530
Message-ID: <20260904113203.12137-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 fs/nfs/export.c                        | 2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
 fs/nfs/nfs4_fs.h                       | 2 +-
 fs/nfs/nfs4proc.c                      | 4 ++--
 fs/nfs/pnfs.c                          | 2 +-
 net/sunrpc/svcsock.c                   | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 8fb08bce0623..ccc0a8a95af2 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -18,7 +18,7 @@ enum {
 	FILEID_HIGH_OFF = 0,	/* inode fileid high */
 	FILEID_LOW_OFF,		/* inode fileid low */
 	FILE_I_TYPE_OFF,	/* inode type */
-	EMBED_FH_OFF		/* embeded server fh */
+	EMBED_FH_OFF		/* embedded server fh */
 };
 
 
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 7fe8b91fa47c..5f25b881b9b9 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -133,7 +133,7 @@ static int decode_nfs_fh(struct xdr_stream *xdr, struct nfs_fh *fh)
  * I.e., kerberos is not supported to the DSes, so no pricipals.
  *
  * That means that one common function will suffice, but when
- * principals are added, this should be split to accomodate
+ * principals are added, this should be split to accommodate
  * calls to both nfs_map_name_to_uid() and nfs_map_group_to_gid().
  */
 static int
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index b48e5b87cb2a..3acc9f90c0e3 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -411,7 +411,7 @@ _nfs4_state_protect(struct nfs_client *clp, unsigned long sp4_mode,
 	if (sp4_mode == NFS_SP4_MACH_CRED_CLEANUP ||
 	    sp4_mode == NFS_SP4_MACH_CRED_PNFS_CLEANUP) {
 		/* Using machine creds for cleanup operations
-		 * is only relevent if the client credentials
+		 * is only relevant if the client credentials
 		 * might expire. So don't bother for
 		 * RPC_AUTH_UNIX.  If file was only exported to
 		 * sec=sys, the PUTFH would fail anyway.
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 04b1987115d5..917306055f5c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8358,7 +8358,7 @@ int nfs4_proc_fsid_present(struct inode *inode, const struct cred *cred)
 }
 
 /*
- * If 'use_integrity' is true and the state managment nfs_client
+ * If 'use_integrity' is true and the state management nfs_client
  * cl_rpcclient is using krb5i/p, use the integrity protected cl_rpcclient
  * and the machine credential as per RFC3530bis and RFC5661 Security
  * Considerations sections. Otherwise, just use the user cred with the
@@ -10154,7 +10154,7 @@ nfs4_proc_layoutcommit(struct nfs4_layoutcommit_data *data, bool sync)
 }
 
 /*
- * Use the state managment nfs_client cl_rpcclient, which uses krb5i (if
+ * Use the state management nfs_client cl_rpcclient, which uses krb5i (if
  * possible) as per RFC3530bis and RFC5661 Security Considerations sections
  */
 static int _nfs41_proc_secinfo_no_name(struct nfs_server *server,
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 4f9c0f639014..992e8b01b4d1 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2117,7 +2117,7 @@ static void _add_to_server_list(struct pnfs_layout_hdr *lo,
 }
 
 /*
- * Layout segment is retreived from the server if not cached.
+ * Layout segment is retrieved from the server if not cached.
  * The appropriate layout segment is referenced and returned to the caller.
  */
 struct pnfs_layout_segment *
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 50e5e7f5b762..0966d5cbcaa2 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1111,7 +1111,7 @@ static int receive_cb_reply(struct svc_sock *svsk, struct svc_rqst *rqstp)
 	/*
 	 * XXX!: cheating for now!  Only copying HEAD.
 	 * But we know this is good enough for now (in fact, for any
-	 * callback reply in the forseeable future).
+	 * callback reply in the foreseeable future).
 	 */
 	dst = &req->rq_private_buf.head[0];
 	src = &rqstp->rq_arg.head[0];
-- 
2.48.1

