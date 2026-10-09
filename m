Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81364E2F16
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546626; cv=none; b=Srd8C37fV0QShYj4myE0nV8m6bxyB9X/3x5nQr9GxWvMexdANxqqfp8sC6j0tFOtFq6OYm3+XGEV8JS7d7KHRKl0n5WqJkOm48KWcZ3y5Qnohdl4vSX9UdfmcYF9LQPcLmb6eSTKJhWG88PAQmVCx1+O2TLe+EWviGh1pM0D4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546626; c=relaxed/simple;
	bh=eEYk/WUBoJNEYfRAjecrPDziLiZTHm5p6P1tZdTsKko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRJafIKgBJd1HIVFKraxBdadOXC478+fixXAiZ+S7ZNS+tjUZiAHiKwsI9/s7VCLzy4UQQCN33NL36iPXPaPXwOKsayyccj/OtKRri4wH+PN7L6wTcLZvdoQYnbI1NoRzAGHAOMJ7cuDan3i2HS6hJqzmRVIId+mWHAId8qrpVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XodLqo6w; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XodLqo6w"
Received: by mail-oo2-f7.google.com with SMTP id 46e09a7af769-8210db80578so2770704a34.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 04:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791546614; x=1792151414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QrkQmyqxC53pOYj/1KIRQgog5GJjTm+HpEKGS8SAvH0=;
        b=XodLqo6wd3q5Ar50Plp/kt8C2fEEeLppk5MpuSIrqgodD4Ie5wvUe/cqrxh0CKuNh+
         1GMIQyfTuFsRZSj1ESj+Gq+Va51C7YO1Qk8b7Ln0onNMVzGHpR2pP6x9z9sNX8ha1uQu
         DYZJo8bfKP/EpN8eU+BcLzBx7Aw4yroets7tUMCRdyBwFtqRAPH+zCzgtitnKQh5uIT5
         pQPO1gwAecV0nyy0BCcogD3XtKMR4tFy7fzlGhll6vGBsIW/LW/CebWh6yYGR3NiWPJJ
         U1twE3KqZfBql2Cb3eWxnDrk7Cq5Fnwv0TxMXN9JDkRnbnNESGvAE/czwTcUlp21QTPw
         3pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791546614; x=1792151414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QrkQmyqxC53pOYj/1KIRQgog5GJjTm+HpEKGS8SAvH0=;
        b=Um0RV6BsKKorSrDZDYU1UmINIFzW233CWnAmptdqWaUAOENcl2ewmdvFtdqItvORVT
         56Rc+t4SckdYSgUkYwDqwoTWFGHuFemBRkTPoKkLTYNsCJzryRVHEOJ9o9ebXu1bhfLH
         Jyk+XzKijSDwfwd4MWcEYR7MO1gPDn5m5stkFM/mYyGhRgsCkJEiSzrQteV4TVHMioI/
         5v2YHL8Yovm/lMFMfLPUjHY3O3dRpU6syu8Lk9c3lwxJ57Xgduc2RFNC39lXrZuAXtBK
         jy+tCG1LFhaEWUJZj8mfPCLGbUe+P0IoysoNyoxGkyP3C5t45DUgC1F4Py6nR8DkiK/d
         F81w==
X-Forwarded-Encrypted: i=1; AKwUvBxWSnx9ChMTRUdi/rRlDITWlncBaxyIFqE6DPUK5YhcQIpJb3kPQhsuZ21TowdMghX3RgnLrDY=@vger.kernel.org
X-Gm-Message-State: AFuF++nuWiUAAP+dx4C8g1MLjQaZ2AJFdm3cExPwxaXo6F/AZelUO7QJ
	/Gfcbat3kyqJlfRMSJCH4tVI5URu3RvxUZksDtAM0bSbSfmR6MXki32N
X-Gm-Gg: AYBFou30aj89b9DLxtNvX3cYXJ6aGMZrXOVsUrjR0AoA/K318BEKJgvmG1/u6vGJA5j
	uhVBtyFviDwDJQcMKjbYIzURkbAQBm4NlKmoLWn2UoYcbKjTDi4G17g9+aVN1RkVosIUQGM0duN
	VGiM7GaZldRrcXsLbGGfi5AoFTHErHMV+HVtn+/C3yRv3hAB4IrIAAQbL41Mc5rZogBnttmjArc
	8hVs4meVYHGVvLkzQf9d/YCERTZnCHiosGp49DmtsKa/QmD+WyXAhycf1MLt4CNFrvG2uk5UPuJ
	qJPabyN1Lg61//BrBevOVdWmxHxfDMB8XzMh58TMc/HQO9nRlhmSgjzO84uV44bRtM0BLhZQ/Gg
	6cnlBFnqmDP0Sn1w7fM44nLI1Bvmfs0aNDOuWjFWUhxyuFFH848HQ+mGyMnH4A1xpQqrgeKwmsx
	2lRmAfTH7fIIvdWAHA+Y4Dl3upwthWDQyZuwG7q8+Z9LrQpVsy8CwwY03v/l148Pn/V62ByOPjO
	7bcxw/qCPJK2DWqNMKceQ7TXqCfu8bXdrYa
X-Received: by 2002:a05:6830:2b23:b0:81c:a945:60b7 with SMTP id 46e09a7af769-83090c286e2mr1321835a34.2.1791546614333;
        Fri, 09 Oct 2026 04:50:14 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830385b9c4asm1480984a34.9.2026.10.09.04.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:50:12 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rxrpc: fix connection reference leak on aborted CHALLENGE
Date: Fri,  9 Oct 2026 19:50:03 +0800
Message-ID: <20261009115003.3696517-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxrpc_process_event() returns -ECONNABORTED before reaching the
CHALLENGE case, skipping the rxrpc_put_connection() that pairs with
the reference rxrpc_post_challenge() stored in sp->chall.conn.  The
skb is then freed by the caller while the connection reference stays
held, pinning the connection forever; a malicious server repeating
CHALLENGE-then-ABORT leaks one connection per packet.

Clear sp->chall.conn and put the reference on the aborted path.

Commit 092275882aec4 ("rxrpc: Fix oob challenge leak in cleanup after
notification failure") handled the sibling leak stored by
rxrpc_post_challenge() when its socket notification fails; the
early-return on RXRPC_CONN_ABORTED is the remaining, still-open one.

This vulnerability was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 5800b1cf3fd8c ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/rxrpc/conn_event.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 611c790bc6d0..56503a05d5d7 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -272,8 +272,20 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 	bool secured = false;
 	int ret;

-	if (conn->state == RXRPC_CONN_ABORTED)
+	if (conn->state == RXRPC_CONN_ABORTED) {
+		/*
+		 * Drop the ref taken by rxrpc_post_challenge() on this
+		 * CHALLENGE before bailing out: otherwise the skb is
+		 * released by the caller with the connection reference
+		 * still held, pinning the connection forever (leak).
+		 */
+		if (sp->chall.conn) {
+			sp->chall.conn = NULL;
+			rxrpc_put_connection(conn,
+					rxrpc_conn_put_challenge_input);
+		}
 		return -ECONNABORTED;
+	}

 	_enter("{%d},{%u,%%%u},", conn->debug_id, sp->hdr.type, sp->hdr.serial);

--
2.43.7

