Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62653CF960
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852665; cv=none; b=MG8dhYup2FhDi3578zHtWuAatvrs3IGjvYmY5mZAlQln+ZIVuAUY9YjWEeLUsyJ0NC6ME70q+HNl+g76gDuinMRXllr+RpOxcD9WXUuXUjWzLB1lY7k5gLe/wJnQt56hLxwQHqGLoZHvZwS8cZtiWjadzNLRWAR0qlG4gsbK4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852665; c=relaxed/simple;
	bh=9eRiyZzxLrtoYjnXIPP2OfGBo8eFMn7rPbbU+dGCphY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBE9URI9yFVIi+ZOEFMsMLpGdarLlC+0ukTxtsuJY/toJpa66YEDEgCfb7w2esZ8OfNqO11vY70U56CqjN+JOLaJePlJ5/vNitfsLW1F4ved8PwKSdp1bnFVRTijkUk3Pz0vjcAaJjqA4eJUenBQ/xLD3PVtXAUdlTK98MDHR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgcD2L+h; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgcD2L+h"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37e0a189b0bso2681869a91.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 13:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782852663; x=1783457463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ksGOdAvrWVQOc/6CEjrG1hzk2bKP0wufpP0CwkmqNo=;
        b=mgcD2L+hav2B/mkWsuviNSjca04X3W6uZ4tegXWTjbNDM0efnVGiMVgbVfKlt0VwYn
         MfYiFdgqMlYhlB6gVEfCZ3yEANbdJLUfogZDlU77xuWiE22w/Y1FB1RQabJbVCUleS/W
         JZW5KlmXNKv+wObKKyBrxGHgsePDV4OKxPSoVtHmwioalq0vUNVM+0kBEefJGsw0TmAu
         iPTl+1tJ/wObMDzu+1o6wSjj2KjDZJAZIE9Xd8lDuiEZa0T7dfeMbOpYMytWMDTzaV0o
         vYfXg3leMAID8npboUqEj2oLE6e+NdvkO0aOo6FZ3xF/H3WXubm1P6EnkhwJzyzmJ6aJ
         2ZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782852663; x=1783457463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ksGOdAvrWVQOc/6CEjrG1hzk2bKP0wufpP0CwkmqNo=;
        b=O3+GwE5NPZ6kF7ZMfW8cwxe9Wt8vdmN2iiSuYiBblMchiimvKL5EDpRxWsXp9y3mC6
         7i3mQ0HubMnMv1Cst3oaeBfYdujlL/oA/OlokX/aGE/Hi1XKkpQ8rtpxRhqqpCzdALvx
         +7fKHJbEgFuxT1hLVKiW6Wub4ROMKkE/KvmTwf1bVtY5NMX8CJEaLAXJY2Tq8pvC2TTJ
         yIWfZXVVcIDURRc2C6FzsJ6ofNIqIXuH5QBAeEIhArQYVU2gFUvf+9oarX/tDT4Bk5Ek
         OPRd3HxUU4ePW0qOs4XiuATr8B7lTqORx/Y9ltlGcuySvSNtlmpOKRFL85+rzKGOLtHO
         cdJA==
X-Forwarded-Encrypted: i=1; AHgh+RpN6KMPqK1KcEZVQ5uLIkLkRak/NEPdSJP3kNyBnhyDwfMnUMpw6UztfZK2/bUThYIp3VBBA7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFcHpAH+UdAcjV3ym16+7Oc1LKuu4g0iZ80H7vNAMqTYygSGj
	FPQ0HyXQk5IjoZXwB99IEQP7IZnXnDuH+hlULr5Tnj+qrG3bWT1ocw9f
X-Gm-Gg: AfdE7ckJUsrSMhuAWhZirdAQZM22mdZi4oo3mZ4bQx060+gbQr23Qwp1szCn6yHmg5N
	H/KnvIH21uLI0duzHF1KDiHSJX3scNvZHFe2YYd7nlvDsWp/DQ9DRj6GML9N93jhxj5j8aPSZto
	DVeeI9s5yYQJWDh9smVoM9G83xrL3BTB10kl9pamzkoTYi1SUAEL7Auhm9f8W+YJcm/Hw0NnaRv
	CulO/ASuC5uRfBstIJY9g0hpBPFWEE3gmlJpjIW4eFkuzL/H0euWc/3vbAgX1ql8elrpdWkLshI
	k0+zIsgOZMC1rCbNwDq13Ll40dIOslUshHgekqzyGHRyB/f++93v4tsKaikflrH3nJuQ+BdEZV0
	EcAPbkTrseChxFGcG9Wwjo7PklXj5P3rGhLEdK/vwxu+S//0IU9IbkNWZPbG5YURENRwIdSaH7m
	D22vmok1zYiBKbL3gJb8ju2qPkr/SemtFd5gZ5AqfD1siEfveI29I=
X-Received: by 2002:a17:90b:224f:b0:368:83e6:ca95 with SMTP id 98e67ed59e1d1-38052388689mr4254366a91.0.1782852662945;
        Tue, 30 Jun 2026 13:51:02 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca382ba1ccsm20322305ad.66.2026.06.30.13.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:51:02 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 1/2] bpf, sockmap: settle copied_seq when a stream parser is removed
Date: Tue, 30 Jun 2026 20:50:34 +0000
Message-ID: <20260630205043.184894-2-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630205043.184894-1-rhkrqnwk98@gmail.com>
References: <20260630205043.184894-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcp_bpf_strp_read_sock() rolls tp->copied_seq back by the SK_PASS bytes
parked on the psock ingress_msg queue; tcp_bpf_recvmsg_parser() repays it
as those bytes are delivered. When the socket leaves the sockmap they are
purged undelivered and nothing repays the rollback, so copied_seq is left
behind sk_receive_queue and the native tcp_recvmsg() warns:

  TCP recvmsg seq # bug: copied 66913561, seq 6691356A, rcvnxt 66913572, fl 40
  WARNING: net/ipv4/tcp.c:2733 at tcp_recvmsg_locked+0x2d0/0x1270
   tcp_recvmsg+0xba/0x340
   inet_recvmsg+0x7a/0x370
   sock_recvmsg+0xef/0x110
   __sys_recvfrom+0x132/0x1e0

Settle copied_seq to the parser's consume point as the socket leaves the
sockmap so it cannot trail the receive queue.

Fixes: 36b62df5683c ("bpf: Fix wrong copied_seq calculation")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 net/ipv4/tcp_bpf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..918f8da02c39 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -715,6 +715,15 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
 	}
 
 	if (restore) {
+#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
+		/*
+		 * Settle the copied_seq rollback for the now-discarded
+		 * ingress_msg data so it cannot trail the receive queue
+		 */
+		if (sk_psock_test_state(psock, SK_PSOCK_RX_STRP_ENABLED) &&
+		    before(tcp_sk(sk)->copied_seq, psock->copied_seq))
+			WRITE_ONCE(tcp_sk(sk)->copied_seq, psock->copied_seq);
+#endif
 		if (inet_csk_has_ulp(sk)) {
 			/* TLS does not have an unhash proto in SW cases,
 			 * but we need to ensure we stop using the sock_map
-- 
2.43.0

