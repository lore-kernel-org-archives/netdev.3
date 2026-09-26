Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B073DBD5E
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790416574; cv=none; b=UEWNfong+QdYrPiLZ9msCmLNFW+eKXzmy0hptl0Ghv7n8AnLXvo3HcPkzZhE0oyoZaz+y+fQepTqj/WJsLbPYfN3nEnQcQ31l6ZCNw2sYLTXA+JvsRNOf/BLjOwcoaK0Bi6FA8Vl3zWuxH4sD3IY9p5DX27dnB70qUq07g9RDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790416574; c=relaxed/simple;
	bh=3CS+HQmjBl52m4CqYlnA7nOrv8anzA0BVQsCvgH+SAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ijtQ9Y0XcWDMNkdeQxAdq/Okcs420kvjrWWwajWcryZ+spZhdg/XlcyEXRChhFehikbFfTe3rRe4xwgDlT84Lh/T0FjsdL6LVyo5E3d7u6TeHazPZPDCw6iKZlPNPzBic2LsKM6vQrYR4Eq596ni+rIJT8de3+J/UrUzNorTP24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qc+FMbVL; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qc+FMbVL"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc7901f7971so422669a12.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790416572; x=1791021372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v6OJthMlr/f101i8o7uKwd+owesuh/rzBHv4PGBQmQg=;
        b=qc+FMbVLNU2+VFRFFghHpWZP7+0XXjMnKy3U3xkEI4qG07jfRlFMBaIDti+S4Wq/ZX
         1qs6EX1W7vIc6og401xgPMhfRHgigWrP+Ir2695047bCQqmPquYELJw/kxN/B8+2kS41
         b652GJRRaUHDdwzWVUezpj0U66Ed+3y2aQ1wuPXoowiqe0DN2pr6vkTO8ddf8GpyR37E
         SOysyQi5l1znjFGbEq4ojixuXIvCi4DhEkCScPKfqgxkoNrWk0NwkMIiA2BMW6YDxNpK
         O0usNFuEseda7tWdKWdt/SZ41ovvCEyv95Yc+qebmanzy2KwRCbs0B8pMboJYotRs4Tm
         hNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790416572; x=1791021372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v6OJthMlr/f101i8o7uKwd+owesuh/rzBHv4PGBQmQg=;
        b=GyHAkCrPWNlI9WB1em7u2OwKxxTEdA3mdXQzlYmOy6tPK4u9DGQACWjoPVLRlcb4DV
         Q0qVEA++ErAaYxNRPkEU5QQytWnmFp/mpD6to+nPvfiBEGkY0R4U8hmqFxuzN2dHn62N
         v/5aniVJ8ulj5xxnljmLg+lpUjZi2+yj3yHXkuuCNxk/AhpDurqUoDYjewIdH/a/Jlbr
         iV0UFZYi18ermCs9mnpTc1TTCWt2AIJkPyFQDYd44jCX2IL3/0G1CDCPhS3qYt+APwBG
         K1egrhsmf712qq0sGE6dbn15GZKs6+qOgEkB9WNcoyIZlSZ6mjbfwtZjaeBWLIPgUQAl
         +RNg==
X-Forwarded-Encrypted: i=1; AKwUvBzAss788bUSO5tbVuRrFaJT+AW/7Gj4BkpDLlT9KHLyXw+4o48X1824vrt9TTTbUlwf4scW2eM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcJ/7OXiFv7SkhR+Aesii5B5cpb0OtHf/HKS49RLPMfxJ21u8U
	bm20YOD7KtFZVrn0Il1aBEfCcmWog2Jg91eGUNCFU6OI8BiuZNr5ct/l
X-Gm-Gg: AYBFou22025ChEYGDVl3tDf8kVehPiabRV9J7gR8jNJCyYtfNasC54MreLOI/WQRC4P
	owFGgcg9kE8dP8iUFDEkAkVDo6/U7safyvjytQit8KwsgW3LrArCtIOIDi2HSC4FStbzN+JPXfp
	2C0ayl1YkReLOb3/CaYLS9KmbzKFnr2dx4eJGJzAONUtSPFgDLO4NiI51BNA7C4mkMff/OP/aM8
	rABmn9pEq679b7mjQpj0UT70vSXLfRVMUgutn8tmXFH3vjdVYNuvH1tQmQ/G4Vq9386sOI5+sfY
	8S8rkeRm/iOGQvAlUU9urkWo08Nl+krmP/DVeOVAcRfEY75tf5f9N+pdOLoAUdrfI2O0+Dmb2jp
	9mLHEHKNXFRrkfMbgajpBbVykRdkm0wwY0G8uLqIrG7+9egLN3VCLaVLdFqvq3AI++QJiz5TZ5S
	VFRBM4osfca4Ap+hhstOk5Vqp8KAFBatYRON96byB7xB5suxf6zCJt7eBqX+1rWUNOUeA4qRNdP
	VrOZtAOEowgUE8shbIgj8HkcMgFfCmevFKcBBtQdQR+jw==
X-Received: by 2002:a17:90b:51c1:b0:39e:1692:34bc with SMTP id 98e67ed59e1d1-3a098ad4cd1mr6376096a91.1.1790416572070;
        Sat, 26 Sep 2026 02:56:12 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9481e17sm8774670a91.8.2026.09.26.02.56.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 02:56:11 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@vger.kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net v3] sctp: check RCV_SHUTDOWN after the sendmsg connect wait
Date: Sat, 26 Sep 2026 17:55:15 +0800
Message-ID: <20260926095606.68601-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

sctp_wait_for_connect() drops the socket lock while it sleeps. An
out-of-the-blue ABORT can then be processed from the socket backlog and
unlink the association. If a concurrent shutdown(fd, SHUT_RD) sets
RCV_SHUTDOWN, the waiter breaks with err == 0 before checking
asoc->base.dead. Its final sctp_association_put() can then free the
association, leaving sctp_sendmsg_to_asoc() to continue with a dangling
pointer.

Check RCV_SHUTDOWN along with the wait error in sctp_sendmsg_to_asoc()
before using the association again. The check only accesses the socket,
so it needs no additional association reference. Return the existing
-ESRCH so that sctp_sendmsg() skips freeing a new association that may
already have been destroyed.

Keep sctp_wait_for_connect() unchanged to preserve its behavior for the
connect() caller.

Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_interleave")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
v3:
- Check RCV_SHUTDOWN after the sendmsg connect wait, as suggested by
  Xin Long, instead of taking an extra association reference and checking
  asoc->base.dead.
- Keep the shared wait helper unchanged and retain the -ESRCH error path.
- Link to v2: https://lore.kernel.org/all/20260911090039.75646-1-juny24602@gmail.com/
- Review: https://lore.kernel.org/all/CADvbK_f=S-2waid_92PbOCh-LWjU5oiZT+__xWfttVeTHEPQTg@mail.gmail.com/

v2:
- Leave sctp_wait_for_connect() unchanged to preserve connect() semantics.
- Hold and validate the association in the sendmsg-only caller.

 net/sctp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325ec1c..4652fd90d9a6 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1844,7 +1844,7 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 		if (asoc->ep->intl_enable) {
 			timeo = sock_sndtimeo(sk, 0);
 			err = sctp_wait_for_connect(asoc, &timeo);
-			if (err) {
+			if (err || sk->sk_shutdown & RCV_SHUTDOWN) {
 				err = -ESRCH;
 				goto err;
 			}
-- 
2.54.0 (Apple Git-157)
