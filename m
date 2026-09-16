Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB08350EC13
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566871; cv=none; b=MPGDtwAFKsl4mgbnKnmYkpmuO7kPM2CDT1LkoMJgVmjkzvReHbrxQi2vVEGGoJDW3Bs9myG5WfIJJ4vQXIyC7dzKxFuGsJIRMmNxCSQxKSrZahYvRtFLdoxRavCfLIwy05FTmxwTeOVpNwzmDpbtc2nOCnYLB1Hzf9bs7pl2zBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566871; c=relaxed/simple;
	bh=jC/eT3Fgr/1jGBrC1VIZPt9+PlqYd+hn/B8/vrobjbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuYLPMrtTvcqsjsqscj3ZBRIgYTB76Etd1VARt2iDnQbZi2hciSPVgzOKU5oJ0Wag7d76gPvqzmEQ6pvZvv3LW2VCmam8rlEun9jhtugTF55qZFNprZFtJ4Qr5OO1W4IJ7YHudos1PPo9J5gzvMwYWkfJd8x/wPInEDnyib4Dqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0NCIdSm; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0NCIdSm"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso21302785ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789566862; x=1790171662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ImWlbvVcHi4iWjIU7vTeQNiHcv8LdakD2zLIePBrQbQ=;
        b=K0NCIdSmFO4cgBpDTzSLvdpksxO9lbypHHgNpfEEtLGCIbyWVlPq+3MvtBrkCQ4fLa
         sUDwl3Kx/T4c7GYz2GsZcYmNLlDYkLhQmu5wKMwEIOdsIhjVFIrAuXJwKuUbaFYQtXKt
         vKEOSD02ElnnziJWNJhvun9REhSS2wrAK/XyCnJ4z2fcXBuBB5ewiRyKGjroOmiBgjuO
         3O1sc07O1IUWl6IPuMKSpPbyvs49EyzFg6qre1BlettVwmd4U7r/AxX06zZJ2av4lhGO
         znQJ5RbgD3cUn4tLIHBCCCmylGEwGzUcsOEpNlHBikPpAMW6oW8h6W8O1Tx/aGqSwfLJ
         n+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789566862; x=1790171662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ImWlbvVcHi4iWjIU7vTeQNiHcv8LdakD2zLIePBrQbQ=;
        b=RsvDMWqiKXw0DvtTlMhasQBT+zi5oeN6K/77nAiElZWZlQ4E92BI/HJf38Ncppd/iM
         sVKuSLVdijJOZOK0qRFBw9f67xuxGQ6lnDYGdW8a7mx9kClHFBkMdSILdz+93HVtOsp9
         lS85V1xlKDRcPmeneC1UZHjFxYnmwGFnnWO+axmCrR0fTSJkzyp/kF/qzmtc/bBfSoBr
         n11un+0rUIn+rJIsiFLnGy7YG2KaDrhjutSK3QlJXBBUL69Ppnr5YCJptfM7lVkps7U7
         S52WLzWfLq/Rqt6E7lPoJDLfsAng9tAGBjSBB1A+GNwJuRkZHc1JyRbcqw9BAcXxIfft
         C3tg==
X-Forwarded-Encrypted: i=1; AKwUvBxm2pwhctfPbTxeSTy8Y07RKy3QNdpDy0MU87FfBNFcRd4F9+lTDCnhQbukXiNZUoJkQfnHzJ0=@vger.kernel.org
X-Gm-Message-State: AFuF++mkSP4hVqthFhNBnurmOMSWV9wWrbfSDzPtpGeqjz68GfYFdkLT
	7W7LzYobCPVOkd6a2i6rDsrdtBgxGmbQq8poaG3j0rHZ+Qhe85AFCvPd
X-Gm-Gg: AYBFou1+IYaOA9oLCPmOgmVp+0L4wlcFUnOmt+4zQDvfnRM/Ilfq9/nN1fTgwBBdagZ
	sfNpGr4A5uca0CAYo/3wOZLU8o32eGa3xmoSZ6xdslv+EEmpla6k+AFhvQfBHr2R4cRpAHDfaOu
	YoWCPeHeaA/98HYxx9MOtTvdTYmizuH6qNZECqOku2bFo6ZX0HRp/7x1ifLpw4QVgvyFpyuClkK
	egPzFYAfqxq8+GTkpUe+jW2YyuMwQ2eQPWvdG/Q+iHbefna+lppAMajGxSeFx7FqIseYIlsVoE2
	WZ2zUo2mlZvJjqVen9LbPC9ukIjks5N1tOVCT/kPaLwM/D3Cd6MSp5kGcgCb/AdW+Nhacp1fYEn
	8EWsD2rmPOW/PPuyaD1KPZZQjUtRSd7WcX2AaBY8HhXpkoUkyIA4KmVepJ1bfsUZZI4El8jWhD8
	N2tDQjYeMNMHnYMb8SMBHXrCTOcj9JKsMfx3WkbMs5ICTzYVDxHtDeF0BDHrWTmkJJLDwsU6SGJ
	cF/kdz+Gc9Jeecg+gr9yB/taWDFi14ZSLTeLut8Icts/7SA
X-Received: by 2002:a17:902:f64b:b0:2c8:f34c:82c0 with SMTP id d9443c01a7336-2dd8dd0b0b9mr58603325ad.2.1789566862228;
        Wed, 16 Sep 2026 06:54:22 -0700 (PDT)
Received: from localhost.localdomain ([38.60.126.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f0592asm12070425ad.62.2026.09.16.06.54.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 06:54:21 -0700 (PDT)
From: Haobin Wu <853555@gmail.com>
To: ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Cc: linux_oss@crudebyte.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aneesh.kumar@linux.vnet.ibm.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	dhowells@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH v2 2/2] 9p: skip directory entries with names longer than NAME_MAX
Date: Wed, 16 Sep 2026 21:54:03 +0800
Message-ID: <20260916135403.15789-3-853555@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916135403.15789-1-853555@gmail.com>
References: <20260916135403.15789-1-853555@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 9p wire format carries directory entry names of up to 65535 bytes
and nothing on the client checks them against NAME_MAX. Since the
previous patch, v9fs_dir_readdir_dotl() passes such names straight to
dir_emit(), and the VFS only rejects names of PATH_MAX bytes or more in
verify_dirent_name(), as -EIO, which again fails the whole getdents64()
call.

A name between NAME_MAX and PATH_MAX is therefore returned to userspace
even though every later operation on it fails with -ENAMETOOLONG, and
POSIX requires readdir() to only return components of at most NAME_MAX
bytes. Nothing can use such an entry, so skip it instead of returning it
or failing the listing, reusing the strlen() result that was already
computed for dir_emit().

Suggested-by: Dominique Martinet <asmadeus@codewreck.org>
Link: https://lore.kernel.org/all/vz5bum547fqyxf5z4m3x7tuqkuq52jlopm65t7hvynqeulh7i3@2t4wnhfxs7qv/
Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Haobin Wu <853555@gmail.com>
---
 fs/9p/vfs_dir.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index af00b79d801e..ad6fdc99883d 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -173,6 +173,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 		}
 
 		while (rdir->head < rdir->tail) {
+			size_t namelen;
 
 			err = p9dirent_read(fid->clnt, rdir->buf + rdir->head,
 					    rdir->tail - rdir->head,
@@ -182,10 +183,14 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 				return -EIO;
 			}
 
-			if (!dir_emit(ctx, curdirent.d_name,
-				      strlen(curdirent.d_name),
-				      QID2INO(&curdirent.qid),
-				      curdirent.d_type)) {
+			namelen = strlen(curdirent.d_name);
+			if (namelen > NAME_MAX) {
+				p9_debug(P9_DEBUG_VFS,
+					 "skipping entry with %zu byte name\n",
+					 namelen);
+			} else if (!dir_emit(ctx, curdirent.d_name, namelen,
+					     QID2INO(&curdirent.qid),
+					     curdirent.d_type)) {
 				kfree(curdirent.d_name);
 				return 0;
 			}
-- 
2.54.0 (Apple Git-157)

