Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D856407CE4
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095212; cv=none; b=mnYb30jSEcG3l8C/5lr6JRV5xjz83fHfMP2WxS84beHSvtCC+Nefy5+ex8xKPXd2bbug9vyeVoKuflHZCTna49OEPhdeD3LRQGsF6qDnrsRtcSDekliPQzBHKVQfS6xY7iFyIN59Fxb8W+KJKE1rb+vGsFMMS5xv67TA7mR+FoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095212; c=relaxed/simple;
	bh=VG0IT3yM50Mq4JKm2XtmCthKoI+vTzER7R+mKGMJA1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQmp8g1vDWIxQJoNmZdBRl6nkXS52TnvaPWETxSGmTBjQmz5JvLslrjKUewyIDU1jZgrSQSVHM5k5lv65BudogzskAQ3umQvxFemGxINJWZCc7N2kIO6Dr4lXAO28deeBADMAau2FcIJUdTwBaGlLWnZk9YNFZeBBiF52rDvP6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCZcN+0b; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCZcN+0b"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91578122305so1065569285a.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 05:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095210; x=1781700010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkDiv7TejFrxyS+xIMDLxRZI5NicDdqKAe8ljgeC4Bw=;
        b=rCZcN+0b7LWLNOtAYZ+H5BO5calzFQk7x/urk4XBxgQ13wXiFQ4WdvmYTM2nnTuaA8
         7raZdFwIehIEytEk/ijlA7QQjj9OR7NKpMBIpRPPmtnkTkFs82YyYIxZcswV7qE4RHE8
         otuZOL/eUnPnXE23GE0Wdhpy2mk4GtXszJLE9bC2cJV7ZCMinGO+E1R02EpkE9aw3RN5
         +n2f288TYb0mWDUb3ONyOd/U4i4dd4UiEAz9ME141JyyTSG1uzz1U54agUpKNnWMEJp6
         JKjQb7wuzKQ9hCLXGSIBaUVswljieUoacu0IBQxgOxM+9pTyN0mcxXZgR1S+U+DHcWZt
         5ttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095210; x=1781700010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DkDiv7TejFrxyS+xIMDLxRZI5NicDdqKAe8ljgeC4Bw=;
        b=K6XgdBRlVEjs6nFEj5dwzetMU7nCnmsKfDMuJ39BwbRBZQrm7vlp0XSJ1qEkn0wQ+s
         9Ntw4yul6LBPDuSB53dNIYddUKK+aGcGXHh3AnPP18rggaCW8fuH4wTaElneOwfPlNor
         XLyIHSw6rsCYjQanUbEGhcSNSNCV7sEnD2DSMMsCtS2JfPTKGIEsIbpjg7++pESIVRap
         uOrpLQEjYrPFoy98jspx/X2xUT2xkbiht0JyAPi3Njiz2NAdSrkvcgCOCqVMtIkq78+V
         kXOoJbRpdwEn7tQB830dm7Y3iinnTLn3RzMZqjYA/1+toDmT1ZholTp/st15uA7JAvf1
         Xdrw==
X-Forwarded-Encrypted: i=1; AFNElJ8OzU7kegJvFqEzPX2Z0cMKgvj0zpDwnT+hiaSEbY5t30kYQk3jeKMmxt1Le0IaRfyyhh/ma5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQWJCGOWBPV3/YuJROgbI8n6cYMfCp/xG9TpCGd0/yLvQs2teH
	NqvN0tQvMDp54U/c0RjRRkrrYzCHazzA9Y9pBFkC1RIR58WdKJY7UK/Q
X-Gm-Gg: Acq92OGdPBBL0gf9+8MezfSHm6tXp/BkVXGc/6NfJQi1mirRzSQujEdcjru8mT9Wh0W
	dGuhadfVlzfxBvJRKJvUcb3Mi6yk2EP2qyakidVdcjIwkLrCSN5MxSwfHKZc8XbzgRu6fbGo9Lb
	s7NI0hn5FQWPw/OcWnlMGIccL4ElVh5RWe7wjg1AxjYcD8IvXJssF8q47tE0mZ+zauzTZzAqi2T
	t+p56u5IQMTju6I04VPFZqA/MZZLnek9VSLWw2jHp1M+zd3x5I+/jQxjE7OPOdwWin/YxAmzqzx
	Xs+daVWpWDW40uxqUOLvA2MWD2ECSLwuHAarDUTVOWLoUzxPb4t+7OoSLuM3OF4b4pPPJ3dagD8
	ifxO11mcvNl8ZqO93j6FkoSZCFDCJ97DMnLFSpCQNZZenpLrsazFqOo1MX44mZ9pEVRhH8/uedL
	FU2sILdsmDsGQdAgDnlujP2+JiubuvKkJIPKu1xhOPhaZRj5F5N3LprOPN3Yd9tmyN3wSK1rowl
	Ou/kdxqNUfRwQ1VcG1AIBWX13Lfldk=
X-Received: by 2002:a05:620a:290c:b0:915:db15:a24c with SMTP id af79cd13be357-915db15a309mr1828466785a.37.1781095210451;
        Wed, 10 Jun 2026 05:40:10 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a237330sm2499096885a.16.2026.06.10.05.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:40:09 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 2/3] tipc: prevent snt_unacked underflow on CONN_ACK
Date: Wed, 10 Jun 2026 08:40:02 -0400
Message-ID: <20260610124003.3831170-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610124003.3831170-1-michael.bommarito@gmail.com>
References: <20260610124003.3831170-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

tipc_sk_conn_proto_rcv() subtracts the peer-supplied connection ack count
from the unsigned 16-bit send counter snt_unacked without checking that it
does not exceed the number of messages actually outstanding:

	tsk->snt_unacked -= msg_conn_ack(hdr);

msg_conn_ack() is read straight from a received CONN_MANAGER/CONN_ACK
message. If the ack count is larger than snt_unacked, the subtraction
wraps to a near-maximum value, leaving tsk_conn_cong() permanently true
and starving the connection of further transmits.

Validate the ACK count at the start of the CONN_ACK block and drop the
message if it acknowledges more messages than are outstanding. A peer (or,
for a local connection, the connected peer socket) can otherwise wedge a
TIPC connection's send side by sending an oversized connection ack.

Fixes: 10724cc7bb78 ("tipc: redesign connection-level flow control")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/tipc/socket.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 9329919fb07f0..f64f7a35b5c91 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1362,6 +1362,9 @@ static void tipc_sk_conn_proto_rcv(struct tipc_sock *tsk, struct sk_buff *skb,
 			__skb_queue_tail(xmitq, skb);
 		return;
 	} else if (mtyp == CONN_ACK) {
+		if (tsk->snt_unacked < msg_conn_ack(hdr))
+			goto exit;
+
 		was_cong = tsk_conn_cong(tsk);
 		tipc_sk_push_backlog(tsk, msg_nagle_ack(hdr));
 		tsk->snt_unacked -= msg_conn_ack(hdr);
-- 
2.53.0

