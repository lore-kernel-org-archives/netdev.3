Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089947;
	b=YArefg8ha81l1X+GDN8R0n/uwL3ZQ3hJGbj1KrshIlDfWDJmBUS8/7guUcpFbWwK7zfJ
	 YxYdlFQtai63svQ54MBvxCJ0LaIkrqLSzNfVXU7TOSy0CFGXPyrdOJgaUrqJMCt5hFPKq
	 aL1uzo5a4t8fAELGX/3PzCAEdqLNB0aSLSsKpcZpXpWSRw35737ZqILhj8m0GLdhGAJho
	 +ZO0G94QQYI3Zb+iF7mNPDfxrJHBECFeUzDMI+OKSQu2+LWWWfgBcDvnSQWQQokpZHS+D
	 UqhgjtXvCnkA0MEpWI84Xx8+FedJVcsNwdeCcW2ohHSBtcpqAxT7NAo6CyH1SjL8enw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bBDjCRfYv01l5K9nHrY3/Hd2EiV/PHl9OnpVwXCk3ew=;
	b=LKbGhRHPZnYR6GVE5mpgmEdmH2vcwZ1KVI0umL07lrYMzaXApfUHq4hzVYAF5+mmJMjI
	 flwUzzPM836IRb+cRDo/BloJ/4JqfctK8lnf/HCD2hYlUUkIa78L4iZGVtOirDcZBNQZf
	 oWNVkzSHASGwG5JFT77MzB3QvfKADTOCL7k1ySAi7jXCco2HxUQNOREC8XqLrB+0JGYQQ
	 /j12ijt0woBDL6Fb76AiAX3SeqjLEEhEXigrLyfbE4lTTx2WVF49N/ADYOS6Y0ONJXOAb
	 Ps2S+Rw116YaDU/xWi6e5TAi2iVNyJYMEzdir9EfK4FgyDsL3lkK5EDCW46/Bz3RcMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JGPWpZne;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974DB606A321
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 974DB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JGPWpZne
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso2297504a12.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089946; x=1793694746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bBDjCRfYv01l5K9nHrY3/Hd2EiV/PHl9OnpVwXCk3ew=;
        b=JGPWpZnejBl2k0E3x5C6PtwzodNl+Q6b5PjhKtsnInQyZ9bj2wkbTtLyQLZAowYhh+
         5VJM/JanbOo9njybFJ2DtZ28HRUDUyyqMPexFCPDyRFJ05VYZdlPn0g6m92b6zow6/k0
         PlQRpYhg/LeNrmbo0xy3ezH/CSGJ9Qce7+SegQRopKlzGMqP3202+L7N5xweQTOwDB8O
         KQsh54mTMnqvlHdLmMkf9ON9q1xGT8HFNoeYDZ4LOdzLXVYYBrkQoJ/XBZdk5EGkKD9T
         mai0dKeO8Y1pinqQZXi+FkGAN9IwN3Y+Q4kenrHua35qOCJAMYWb4qYP22np3BhqfBwF
         kVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089946; x=1793694746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bBDjCRfYv01l5K9nHrY3/Hd2EiV/PHl9OnpVwXCk3ew=;
        b=Ln22ZW5C0rB2AE+F0DRhfD6U4T9lYJxUv1u8O7SrcPPToCPUB1NVBno4cBNU94keVU
         kudHxr1EYiNl3OhGB9FdJLyHMCa0cTw2mIOR5vjY3QvLjjca0EUp4H5hzJeDpwr+tcaw
         4kAPqQU/87yLj45C+rAlqFF2u7vfgOy/eXI8UqlMChfMoHJn+iJ917w9LFwOCwC4Kovv
         JYmRtcqtSPM6czll4/46M9cfvFP/Yh2R2Ogd81sB/f25ijhBzStYc2fLzd6CAJVaraw8
         IcLn9478uJgSXIB840+WqSXe+sajc3h5f373pC3vyzumuaMb6ZybXzGqxrLEuYC/aKI8
         iiHA==
X-Forwarded-Encrypted: i=1; AKwUvBypzcN/53s2lN/vXj1WFXRUxLgoYcG1NRAdu9Ur+jL3X0Q+PjSXwTAtXhe9rGUrWOfmuEfaF4s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIedZXJQYPZPl8F9jHH6D82/yz02eM5oD6kg/Rm4yQluQc0imiG
	VkCf8Wn5k5SVnmsnFkJ4xQQZFjoZoO09/4giB/VkZTtkdQ1M/2L3fEum
X-Gm-Gg: AYBFou0UEKmewAUu0Dn0hoP7D58w2t6f38a9ijHe/NObbxORA3knYBT2beVWlU85Oxu
	Ly5XxtzYTonwUfygYMpcCcTgb39wGHbfr6eFwM2CrWx1JnbcY7TZAMebf60wSphVl2Fa5DcT5D+
	sXUu8HKjhCZjzMqpOSJGP8g8Sfopc9pP8wjscpE5yQCRa3UDO4OuHrPmJl4fcBAjsXNnVXVqirD
	Ffs7XO9/0DcorLv2QQS3p6TeGIVMS+J6Qmu8hzaCn+uK0A3h/odGfYBt6L4saBYVjqAFPhA8wjp
	hj+1dToIZUmbHTFrUR1hTAhocG22kLNLT6W4dL2PaK9za+4qA/hEyph9PFV0YcS3H04W/HP/avu
	e2xuCNZ9hwmR68BOo8jh5T87J/3EiJ3k6wzL/qh/2tW4Q8a+liS3K2s/S0FygYql64gKqkaSNal
	1xn/tEyhGdFiVLhAlnoRkpvnooW1j6dLacakTt2DnTiFCVq8xsAkE+xtEL9cLvudU6l2Pj1luYN
	SOm8Vu3kGZWNEN4cLRaAaQk5ZoVOGgmffIf6Dqx4FzZX/K6QGN5QiKZ2N2EbvRZhflMMqbmRbq/
	qjQ6T0WRHqpMmjR6JuahvIrJNvR0tuNfdciRKcasSUilq3NPB+0=
X-Received: by 2002:a05:6a21:880e:b0:3e1:c1a4:91f6 with SMTP id adf61e73a8af0-3e7cd4d9db9mr6517172637.13.1793089945941;
        Tue, 27 Oct 2026 01:32:25 -0700 (PDT)
Received: from WIN-L6GHNQALH57 (1-21-119-227.east.dxpn.ucom.ne.jp. [1.21.119.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36b37251fsm2018741b3a.27.2026.10.27.01.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:32:25 -0700 (PDT)
From: Masafumi Suzuki <shengshilingmu97@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masafumi Suzuki <shengshilingmu97@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: account for chunk padding in sctp_init_cause()
Date: Tue, 27 Oct 2026 17:24:05 +0900
Message-ID: <20261027082405.1297-1-shengshilingmu97@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

sctp_init_cause() accepts a chunk when skb_tailroom() can hold the
cause header and the payload. sctp_addto_chunk() then writes 0-3
bytes of padding before that header so the chunk stays 4-byte
aligned. The check does not include the padding, and the following
skb_put() calls skb_over_panic() from softirq.

Count the padding sctp_addto_chunk() is about to write. The cause
length on the wire stays the header plus the payload.

Fixes: 8914f4bace3f ("sctp: add sctp_make_op_error_limited and reuse inner functions")
Cc: stable@vger.kernel.org
Signed-off-by: Masafumi Suzuki <shengshilingmu97@gmail.com>
---
 net/sctp/sm_make_chunk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 84a4c97d0f75..8933caadcdb6 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -133,20 +133,27 @@ static const struct sctp_paramhdr prsctp_param = {
  * cause codes will be embedded inside an abort chunk.
  */
 int sctp_init_cause(struct sctp_chunk *chunk, __be16 cause_code,
 		    size_t paylen)
 {
 	struct sctp_errhdr err;
+	int chunklen, padlen;
 	__u16 len;
 
 	/* Cause code constants are now defined in network order.  */
 	err.cause = cause_code;
 	len = sizeof(err) + paylen;
 	err.length = htons(len);
 
-	if (skb_tailroom(chunk->skb) < len)
+	/* sctp_addto_chunk() pads the chunk up to a 4-byte boundary before
+	 * appending the cause, so account for that padding here as well.
+	 */
+	chunklen = ntohs(chunk->chunk_hdr->length);
+	padlen = SCTP_PAD4(chunklen) - chunklen;
+
+	if (skb_tailroom(chunk->skb) < padlen + len)
 		return -ENOSPC;
 
 	chunk->subh.err_hdr = sctp_addto_chunk(chunk, sizeof(err), &err);
 
 	return 0;
 }
-- 
2.47.0
