Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1093054C7
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340836; cv=none; b=B7OYCoo5in1RfQ6eFE0y12vHSo29rRASIjsdoiZSF2rkoYe9LkCWThYlu7WXEc2uRE4QYWBpCO1ZJdIYCc/BEb9Fdq9AQmYnq008UxzSE0K6hnIHqGP6F6IlVkRO/1sGoicsBfwKv8SFk9RMkX8Nhu6cmUW/Atu8DX5rSfClTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340836; c=relaxed/simple;
	bh=wGk13vL35KwG3l0xTxS+K1aQKa+KpFO1SrTRXLK0xuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YjwA4bI4rnr4ouToFlx/5m0XxcgK3MpnhSdYCV+eeKNgfpc9XIF6uLlKqxXabh6+/mFbhDcD1+3CEk2WsXdhUkQvWZbD8tdCjfMFgJ8HWSOxHS6w0/aheIx2cZU4iOV1n44EqFcxtf8dAWonvO6AQxjRTB9HgZB91GBlUXfu2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=kHzVSBmM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="kHzVSBmM"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38101f85591so2065746a91.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785340835; x=1785945635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mi7DTUQ6I2JLv7hCuqy916IrqtjL9UgcrN2Dk8y583M=;
        b=kHzVSBmMze66yf7sXerQmvWqALFENLBE4hemGdXQ/RqF14VblyD5kxugNeUyOo6mRi
         sBbd2CvHXIqGDPiaMCHXyGgJq3WlL5OzYbUyoxNpqu6vRzKv7LfoXezR6iP62xg17D2b
         o7r6E6u0/xi/WFrHKNPA2KeoUKO+Z650Elco7LhE/6I5GqnRZSXEPVyT9FkBEtEOFp4b
         slfaOtB4mk3oh5F9pt3TSgTMv2oWgIpkxRK5L2kAid7zXkx+9nChPV2WeH1RcnU70yiU
         wKaIMbluEfn5oGrNSeEPJAyan5+XrzZqiDN/wOE2ofOP3IZfERS+N9p0qut/A5TKJYUC
         cD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785340835; x=1785945635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mi7DTUQ6I2JLv7hCuqy916IrqtjL9UgcrN2Dk8y583M=;
        b=jwLwyPBZG+rqIFEGaVXEXIhPDkkiTEQcGLEHXIGRRhJry7tDObxKiG/Rpqq4MOV69U
         1ixveyPwuG0bhNoN80i/BeSEFnFmT5RVRmFc2VSQvUp6H3UHuyXUocG1UfaK7lSRzSKq
         +HDpuslE4uW4As3KRh5kcfhwuVORKEXrLYMDZgdCtFKxdfx+oiuFVEYToPb+c+BajKZa
         GhSGts61bE8+MODfzTUen5+HlHICBa4wJGs3sA9riEf/5eO1eGhddgUdI2+rn0jg2+Eb
         jymTganiIyfD88p3L7qZH1D4LxPJsB5hZtRGp0SmrGS0d6EQQudZp5lU/iyRinkxreP2
         ZpuQ==
X-Gm-Message-State: AOJu0YyUepIMwW+K04QAsDEeIY7UpNVNn9qjmASKSj1FbsmYWXGtUkoj
	No9iuhZjZc1SqKkF5uQ5kjRYLme19Xtf7K7pdQS67OosbsYKF8cLN6/BnAHR/wruiINOVzhjEOK
	ESXxXqVQe4A==
X-Gm-Gg: AR+sD113rKn2dsLlvxISrBf7SSxtpC5WrTD0QbPfrSKPmfPdM9qPCAwq1B/PEbTGu+j
	pXdnBgv/pbFpmvsoZDlG0kYBQcweQNvcRGSMRZ0uSNtZsQdqZs8pir6ohB8qkoJTkTX0nHWjexo
	bzDB+gRHYMP0W12557R1A/2LTBlhLrs6+lpgoMLaQ9VhCihusWO4hNdYYqjK96u5ofEJ2SJJuwx
	qPJFTz65/JJYI5or0QDW3WDW4pYqnFZVP+xfvQYNmBO+Rqzbmj7lA1Ogq1r3n452XypVvc9DnXx
	J+QmfPc1APx1G+msXMe9guLtFBlgT3CQ1xE82w45J1HuQPnhfE8m1EkKymm1DmM1BADQd6m+f5x
	XJwKo6qQ0277ypEVV1Q7XKN3qOECPj30+N7t8QIM/nvUBydyqrQ6+TPyqcUUavfJ9AWYjWqgPEN
	Jy7Az5sbkrcn/N5Y0P4jE6R3x2dU7uEzhbuvG0v5Z2b4K79rgCs/nKsjZO64izu1mwHgrJGhP3J
	PUqjvE2a5mRviO2E1gIq6adu9f0
X-Received: by 2002:a17:90b:4a90:b0:37f:9e21:91d6 with SMTP id 98e67ed59e1d1-38f8368746dmr2143556a91.13.1785340833898;
        Wed, 29 Jul 2026 09:00:33 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f12f965sm1615685a91.5.2026.07.29.09.00.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 09:00:33 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH net v3] sctp: keep chunk->transport in step with the list it is queued on
Date: Thu, 30 Jul 2026 01:00:28 +0900
Message-ID: <20260729160028.54546-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__sctp_outq_flush_rtx() moves a gap-acked chunk onto another transport's
transmitted list without updating chunk->transport:

	if (chunk->tsn_gap_acked) {
		list_move_tail(&chunk->transmitted_list,
			       &transport->transmitted);
		continue;
	}

The chunk then sits on a live transport's list while chunk->transport still
names a different one.  If that transport is removed - sctp_assoc_rm_peer()
from an ASCONF Delete-IP - sctp_transport_free() RCU-frees it and the chunk
is left with a dangling pointer.  sctp_assoc_rm_peer() scrubs
peer->transmitted and asoc->outqueue.out_chunk_list, but the chunk is on
neither.

The pointer is not followed while tsn_gap_acked is set.  A SACK that
reneges on the TSN clears the flag, and the next SACK reaches

	tchunk->transport->flight_size -= sctp_data_size(tchunk);

inside the freed transport.  KASAN reports a slab-use-after-free read in
sctp_check_transmitted(), freed from sctp_assoc_rm_peer().  Both the
removal and the SACKs come from the association peer.

Set chunk->transport at the move.  The ordinary resend path needs nothing:
it reaches its list_move_tail() only after sctp_packet_append_chunk()
returned SCTP_XMIT_OK, and __sctp_packet_append_chunk() has rebound the
chunk by then.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
v3:
 - drop the redundant assignment on the ordinary resend path (Xin Long)
 - trim the commit message

v2:
 - fix the root cause in __sctp_outq_flush_rtx() rather than scrubbing the
   retransmit queue in sctp_assoc_rm_peer(), which cannot see chunks already
   migrated onto another transport's list
 - correct the Fixes tag

Link to v1: https://lore.kernel.org/netdev/20260726060453.42730-1-baul.lee@xbow.com/
Link to v2: https://lore.kernel.org/netdev/20260729124929.5885-1-baul.lee@xbow.com/

 net/sctp/outqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index f6b8c13dafa4..e92fb9da4647 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -650,6 +650,7 @@ static int __sctp_outq_flush_rtx(struct sctp_outq *q, struct sctp_packet *pkt,
 		if (chunk->tsn_gap_acked) {
 			list_move_tail(&chunk->transmitted_list,
 				       &transport->transmitted);
+			chunk->transport = transport;
 			continue;
 		}
 
-- 
2.53.0

