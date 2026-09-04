Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF6D449B0C
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520869; cv=none; b=G7dnSRs/Q2Erzw/RhRq0B6WsEpW6eHQ3Brf49M2kyPb8Q9T113RY0MMMKwcNLUPxS0xtgR70c+krB9di+NHWK6CuhltNn2VDjr3SpRJWA0de6SWUOXNL/NpAof8/cz0cXt0pSqAOiMhA02UTAE8E+5QNxJ9RlfuV4/jiUXeS2dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520869; c=relaxed/simple;
	bh=YHUSWncJG4kn/isoSLhwcXwtOQwWDC1msBJis3Ldk2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knuwCXvjH3PXppHTcyY77UhfOjqEGnTrjfZ4inVoBhCQ/m4R8pbKxccOtZuvy+3w6wGUU40qYhJxnPQ+U3lSRrcyGCclIM5qyV2Fx0pjf5tAOzp44nu4LD7dzVplPnB9JfpgNxsl77ksXyJ4UGE3xTEfaQHD+PIrBKD5ckLpPOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9SYetot; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9SYetot"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e58034d05so708551a91.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 04:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520867; x=1789125667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lnTyvksY7pfKvaenvyNkrisVTNLge2aOUQRRsR1U+eg=;
        b=A9SYetotE2Um2CEQf4OJi5hBvWpfc+jXsYZfH79TRbhGS6r5mfJ5M2DRjj6WJrl2zE
         r9frymriwQ5Cy2YIu+Xx0DbdZdJvzxOkigwqlYLHHV6pwjwVBkG6r6vP91lPD1qiJU35
         pfZRuoWltvJhBfVLF4SedtlaEkE4AIFYCRNNFcbww/y164FLOOCbGJC152hBX/lKwLvo
         yTdWJwU+rd6Pm9dwjhwEdFPGqdohfP3sr8Ze9UY4f1P18p+AY6xqdHchpcO58BAmfowQ
         lvl0AGde0JNdulkrTdvqHRlXLueZEGg0Vq0yPrgzrReCcxg4g+S9jkZjO9dy8K/lcvyV
         kHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520867; x=1789125667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lnTyvksY7pfKvaenvyNkrisVTNLge2aOUQRRsR1U+eg=;
        b=VUr3H6BDZzUfqoAPAD7E/PvIMB3fEwk91+/IFJPbkQVBbsxf2pTCUurcPH906EDSNd
         6mA8efYfIdnOdEIvcRyuApqUa/1qv7oHhwS0gbTGXSE/2iJdBUiFe1+zsv1cGswaaDBL
         STc6u9ztB4BsI8tOcLw6pupu78fOFITFjY4/AyOvgUktOi0/FbOC/N3YhrNPoUPNI1bS
         v3chtPMFJ7sVUkeW9ZLVNo70WnkYG1wgTxlsouPcF9bxLvEo//q0FcXyB52CrlYWcfqR
         Xu1ejaAvpcIF9AdHsDBdlFAne1KZa9tJoojeCtkVsUb5YqMPk0CbkDjTVnP1DyxHI/sM
         4bBg==
X-Forwarded-Encrypted: i=1; AKwUvBxI/6zlw3iU9r/p54QbDyt8J8fjQ46oiODIVsXyfdNUBtwqMdYLAFUPup2GIIXTCFVDbBhKJxE=@vger.kernel.org
X-Gm-Message-State: AFuF++myKzQOvOfdpNTSkgoW49WpZ8f6JCIaWQPscFxrM+PoCtSQ1/e/
	6P2LVCtrBVpAl25im0OcPE1ujsVsK+t+SG9ZvspT3VsvzY1/B0x0bvOk
X-Gm-Gg: AYBFou0KWFUv+2N0vAkTEkrRnaqluWJkMTP2eyv4ej38oS9d/sMDe2zJG+KyrfOn1x9
	3vLgcJAIaqsx6zQdWiujoVxTwmAfKeeubJZLRHgmuPYd8NjHK9TPIoy7ggszmIQq4vqv60GmhQs
	C/XHc3E0mNDphz7oZ9idNh8ilLi5Byc+u6ACTWCtKCyNpqZWHrZsTmpT6alanI2RuRuGXOgEAGH
	vUimOkert95bm6C0m64LLFl5RxMu0/nJzPmzE9ey0hyzYSohM2cY0MtamnmFDodOFHaejC+xI2i
	sgobh03yxthKcAJ0vO++w7XmdMFOhkELVIqfyXqxeV2lEBvYZULHNiiK3NgBD7pm8mXRlJHDJtC
	SDbn0y/6VTsodz6dle1vqkr7WfTeXCQnllteWecgcKVgU5XP19RKBDo/2TcVtfQSP7zjxOObpdk
	U8OkME7oy0mYmMUOduWirEunu1JxE2Vg3TpD5Fp+ysyez/ZZo5E7uEwOiaroZfhNN53qXzIK/Zb
	kxr1leMcAog1MU=
X-Received: by 2002:a17:90b:2e4b:b0:398:a145:5d3d with SMTP id 98e67ed59e1d1-39b26151b89mr8733669a91.6.1788520867353;
        Fri, 04 Sep 2026 04:21:07 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm5805929c88.0.2026.09.04.04.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:21:07 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] net: fix typos in comments
Date: Fri,  4 Sep 2026 16:50:59 +0530
Message-ID: <20260904112100.34541-1-hemanth.selam@gmail.com>
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
 include/net/9p/9p.h     | 2 +-
 include/net/9p/client.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index fd7a034b8278..22ab7486795d 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -120,7 +120,7 @@ void _p9_debug(enum p9_debug_flags level, const char *func,
  * @P9_RCREATE: response with file access information
  * @P9_TREAD: request to transfer data from a file or directory
  * @P9_RREAD: response with data requested
- * @P9_TWRITE: reuqest to transfer data to a file
+ * @P9_TWRITE: request to transfer data to a file
  * @P9_RWRITE: response with out much data was transferred to file
  * @P9_TCLUNK: forget about a handle to an entity within the file system
  * @P9_RCLUNK: response when server has forgotten about the handle
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 55c6cb54bd25..f3aead8939ef 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -97,7 +97,7 @@ struct p9_req_t {
  * @proto_version: 9P protocol version to use
  * @trans_mod: module API instantiated with this client
  * @status: connection state
- * @trans: tranport instance state and API
+ * @trans: transport instance state and API
  * @fids: All active FID handles
  * @reqs: All active requests.
  * @name: node name used as client id
-- 
2.48.1

