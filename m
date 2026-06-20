Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD1395DAC
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970539; cv=none; b=b3UkwQ2TdrKlScLq+Pfm/XCNCiBGT491H3300jABjTw7BrKiPCw1+/1X0MeMnEmk8l76/lu6wxk4QtOCKykUMzHnmGD3d51v49wlzZc4hJUjMBwxqe6T9faHxUAWYahEU2z1MaPxtyR1Qvt2D84ASEDeZSKluYyNYYelGkFO0ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970539; c=relaxed/simple;
	bh=y8CKsC4AcCnLZxu7FvlCaKBGb1tsp3+nM9n2z0emRA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odlKnVTDuz4GcdIjru1rWxLZNFVpCn0nvrrf8e3DG1CBldHqtfMaMKZ2NIDzmIwaaGQvVEnPQMQld9JyJW0stepE5z71tYfqZ5J52qvImDCsLUp18+WpE5ngFgsH4jxDMBfi6TNYajgZo8XCfTFUt72gGPy9z9nPdRLKeggFfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl7m9OKL; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl7m9OKL"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-91591f19c30so432378585a.1
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781970537; x=1782575337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCqX9SS0fcvxQj6cNLY7hXcBkW2X7Mm+a+jE+6aVrFs=;
        b=Hl7m9OKLPWIaBfSmlKEhnW6rkDmiQAn3sZ2VI3sgY9g/aLVBvAjoat3VyidxSAg4ve
         9ML3Jk5uId6lP13RsYS4a7ZHqI1mWfM63vUjd77Qg94jkULuVBACFKyPziw3iwaToDPy
         PdSzGmFUE+RAZ+LuyCzXly0H+p3zirCRZrAnNY13U7hhuTooaaVcTALiprUynePCgsTb
         2I/ZZ0CfT5jpf7Mfti1qqx3qyGsSpxrW1RWcPvhw9NXReO6OKJ9XFeU4i/lB3Wa3PKVh
         FNGf9IpLzUKridb4fN0nCRPxNjwLpHpNcvkyZ4zaPD8/K50g5luA5YGxwyaNlgoNA9Zg
         06Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781970537; x=1782575337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCqX9SS0fcvxQj6cNLY7hXcBkW2X7Mm+a+jE+6aVrFs=;
        b=iZ81z/WlafLbSShpUu8FsbVFmrbt7WGxYjyTKB/gnBkRWGwg4Dl/vVWNHuvIgav3BG
         LuS2kLlALEu/riAn7EuG0PSR+fE5abKKLQeztEbp34Ubg7e07PQI7rWIynEFDtVlwhxd
         +VApzSnetb+Q0gs/EYi6JRaqfAvARMou2pvmEnAM/gYXFyDoSc07MZQ7e5RQzJVXDCHQ
         TmpcT1M1VuuMjMBmlP2AoJiwu7QHb+UBmwxauV7PoAFaPgSQV05QnjyVEcRfbw/o5RfW
         +fqvG/X+330OjNoaeywW8rQ+v5JTB2Ex+pTpT6OdQXMnnz2bCIIfUwJaWdIzMo4AloNi
         pTew==
X-Gm-Message-State: AOJu0YyW7Gigc5rleyyqraGmDokVUDvskqrlXS0pux6btQVS55ZTPdsc
	tsXh36Uf3TAUd9ksYAvbixks2Lqq3pVVcMBNIko8edU95kuuMHw0O1SNJWHWxxTy
X-Gm-Gg: AfdE7clL6k1eZPU59th4fUozMYNjFpuZFT8YHZ7kff0hIqVcG/Jzc7tj5ekb1I7KGAD
	Fld9yro8+R3NnGgoMwjB+uW4dxoW7FwcN8NHF0uMRIbJMR2oMJjyyYDmwhICPdmywE4ac8ugDnb
	j32D4yyqJ/5qfkwZSmRZ+Vh/KEetWNMjnEtkZw9vrxEGIOmE1GNfckR+MP3SgGfyGWAKFTBtp1M
	ysXPdPWfG8S350eKM3U8RO/MreT6qrqPSIE4E/k11Y4HFnZlHdVIlmd731Etb77PtGn9+9Zs8kr
	K+A8sWsCZo3Z8rh2PPADHmD1atvIsOy+3GZ1EzCFTZfIquAevlgRst1htIZ4R+x2RqTpX1mendk
	Uh7vLX3pFPCXU9cTxdFkbHykXEvvezLSKSckMQLaZ0Nfzz27LB68ZvYB3StV/DhU+tJMKDf/TDl
	c7qE2j4Rj/WN6Fpez2XzjF1yAH9Edx5rn5/GUOp8HDZsfdmEGMj7domuI2SvZe8c2MSjclyE3jE
	mvWsJiyPNJES8v+Um93oYRFfDZTE8m17OWc1z7HIhEcvNJSjzArm+U=
X-Received: by 2002:a05:620a:278b:b0:915:94c7:5840 with SMTP id af79cd13be357-9208f1610f8mr1141369085a.1.1781970536718;
        Sat, 20 Jun 2026 08:48:56 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f015e50sm34809506d6.6.2026.06.20.08.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 08:48:55 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: fix err_chunk memory leaks in INIT handling
Date: Sat, 20 Jun 2026 11:48:54 -0400
Message-ID: <0656704f1b0158287c98aec09ba36c83e4a537ab.1781970534.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sctp_verify_init() encounters unrecognized parameters, it allocates an
err_chunk to report them. However, this chunk is leaked in several code
paths:

1. In sctp_sf_do_5_1B_init(), if security_sctp_assoc_request() fails after
   sctp_verify_init() has populated err_chunk, the function returns
   immediately without freeing it.

2. In sctp_sf_do_unexpected_init(), the same leak occurs on the
   security_sctp_assoc_request() failure path.

3. In sctp_sf_do_unexpected_init(), on the success path after copying
   unrecognized parameters to the INIT-ACK, the function returns without
   freeing err_chunk, unlike sctp_sf_do_5_1B_init() which properly frees
   it.

Fix all three leaks by adding sctp_chunk_free(err_chunk) calls before
returning in the error paths and on the success path in
sctp_sf_do_unexpected_init().

Fixes: c081d53f97a1 ("security: pass asoc to sctp_assoc_request and sctp_sk_clone")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_statefuns.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 6967e889d1bd..2f484c678093 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -400,6 +400,8 @@ enum sctp_disposition sctp_sf_do_5_1B_init(struct net *net,
 	/* Update socket peer label if first association. */
 	if (security_sctp_assoc_request(new_asoc, chunk->skb)) {
 		sctp_association_free(new_asoc);
+		if (err_chunk)
+			sctp_chunk_free(err_chunk);
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
 	}
 
@@ -1542,6 +1544,8 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 	/* Update socket peer label if first association. */
 	if (security_sctp_assoc_request(new_asoc, chunk->skb)) {
 		sctp_association_free(new_asoc);
+		if (err_chunk)
+			sctp_chunk_free(err_chunk);
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
 	}
 
@@ -1607,6 +1611,7 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 		 * parameter type.
 		 */
 		sctp_addto_chunk(repl, len, unk_param);
+		sctp_chunk_free(err_chunk);
 	}
 
 	sctp_add_cmd_sf(commands, SCTP_CMD_NEW_ASOC, SCTP_ASOC(new_asoc));
-- 
2.47.1

