Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792734432;
	b=d90SeQTM4CVE5WJHB6RN0/ZbXjEDrVwmTulD4Jy+vrOPxmRwdwiMK/kvzZvR/6li/o7e
	 wAgLNcdwClQSQmkhJetHH2iW903n8TDzkvh4BNDlBmIPKpT3P62q5RHzbM9Xy5GziHRW6
	 v9l/Ne8tTLexKGAr5q80axks9sSj0cF6cMLjP+jzXByhjek0BuWPJQ0GPieOQKvlh/fOe
	 +aFSahCb2nwZFG6mSWCey7nPn/RCPW6yHqx0biabQ3af3NzZfOSH8hjJYdIszK4Tgiz4N
	 htwN5RivYMGqG2mxbinkXg35iOHMN2h6C2y35pat8TeunG1Qf+G5Ff4MYvK1IgyKoBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792734432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0Nv6KdNmBMD2lXDTcLDmxM8deD0XVXnuQt7XYnyLZ9E=;
	b=BbU8bOOmyq2hi6RUcgDTKvlhmer900L18OJE5GBJ3DxbJDmNtQis19RJt3R8UTIwnCTD
	 nYTguT9M9msD8lCg4Wr3fSh3bisLcgKzzQC6tCBFni3Kei8MyRHSw22knuVPnhAEKXn9U
	 aXPljuwBIxTMrRiTkLoQpZO3UtvYieyQdwq7F/uhycbTaMEuGcnXUxVQnvPLfl9TuTc8v
	 QVOpPsPCFurBfRyH2gBTg8C6lJzfy0lT6dIvSgjdO8F3zfWGRZx3TW4ARjmzvAuMKErJ+
	 ZCpGuf727MOlijhB35R0jjpKmQoD7ZukC9jB/y9bvu8OedJTDLStLdn/WXcse6LGfjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=SqcTJpkv;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762A606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6762A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=SqcTJpkv
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-354ba08cfd1so948457eec.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792734430; x=1793339230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Nv6KdNmBMD2lXDTcLDmxM8deD0XVXnuQt7XYnyLZ9E=;
        b=SqcTJpkv5HBcy02byuM51R5rcoaGFMIlIsZJwtzs481Cp4yB6I5HyYbdcMJVT1zb77
         LoZvi9frKtcCXDK0tKiWS01H7Dul3iLsEtaPVwjFAIknlQe0k+GopSCriyb0oaSxTtNa
         2PGOGsMd7ZC2UN3ge3h2b7MQqf/XSgzQ178W5K0r+H2iTHFvOEehNTedcMLzeWpzj81x
         bkaIuv2/8GeYx4efM689sJJv7qgrwqueagJsN3amIfm8EPI+UA+gppztg70YprUY2vMM
         5dk1sovlAwrgwSApZehpf9bGPU7YLa+r6gs24gFCTkCvhtJyvanY4BeJ9NrLBhxshucA
         hXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792734430; x=1793339230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Nv6KdNmBMD2lXDTcLDmxM8deD0XVXnuQt7XYnyLZ9E=;
        b=uqDUdM0T+r/8kPBjdd7enYHuEzh0nFjyowLsJGiiT8KdwjUCBMx4ZEnCdvSn04BQm1
         HPtXs2ax90GkeXwUqro4z2TJO9d1Aa1Tz9cT842gFuoet/l1AgzVEw3MI/0gOY1HrhjV
         TiDXDkKhGM/E/qe1nN6F7w+arS1UOGbD9AY+9PATPvMdTPOOojj3B6UkwRKY6f6E6VTj
         4qepiZLvjzNY/rc6cKJ3T5xhwWpoA8YpEKsrxgfblinXI0jIk165/KQjoyaQcR8dJUr3
         IpUyDJTblma5JW44rz/vzAxsAK1Zf1ZeU+qAwV8nTptWPIjWUd1QufEjRXEeukBHp2BK
         Bitw==
X-Gm-Message-State: AFq9FYIGZvd4DWe29eG2wzs4NK85bIV6KswuCTh5rqmko+87QhoZP/2v
	HXgdOKOWwX/dRlL4QOibv2GAccP8gRRDQXAxTzdzYBQHA2/h4SANxGXSj1gNoaDgQNqyqWW6Cl/
	ZXOgm1f9X0Wc=
X-Gm-Gg: AYBFou2VYoP+DhDDHiEQaXXuvVV2rubaBqYUeavf9ZC+78Ki4YQyjA3boq+punR8ePR
	5J2EpRc3QkmAF2aPw3Eg0kEJTH5NzFrSpozxg+uaHkKbiLItDPxTHSQh9qicFv8gvipEEBvvAtU
	N2GbyJ6mnsXvVWRK4UNiqI3flxKwp1jmM9Ufl0LJVoof0hWhs+QxqB5pZF3xPji/K6G6DOkgOM0
	Gaz+mWvjUh3wIgYsXRJcy8f43M8swmYokQRYoJ1QQaa40nA4CkccofTv4tyEe/2C7ldWHu7Ql+U
	S0oyehTDpRVnnxh24jFeZ2MWw6Az9GyYsWknW7rbZ4yKRA0KxADI1Z2SX5AcAyopVYbd8D/krFH
	n6qU3aKPU9XcIgH2Tm0oH1wngrsOGVL9kwdtc6YTfQWpC3pQhsZ+rRas3wbfEhgsHk74cyFDxlH
	tWSrsE+fk9sBPDuPiq/WBdiN6Yd9067tgE6PSg04VdQ2K3zNW02W006XukGwregolEXBl26729t
	IsLcTTNz507+PRhcHqdWbTzZ1qN9gWDAfS1O2VkeRyPtoVms6x6zR13kSZ/u9QgNj9HQhJ4VFBB
	gs+fwN0iK7xnYdP3Fw==
X-Received: by 2002:a05:693c:6383:20b0:369:5583:bf48 with SMTP id 5a478bee46e88-369d975b14fmr1517647eec.24.1792734430266;
        Thu, 22 Oct 2026 22:47:10 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369d9d8978csm6252135eec.13.2026.10.22.22.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:47:09 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	daniel@iogearbox.net,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] tcp_bpf: sync copied_seq after pre-accept data
Date: Fri, 23 Oct 2026 13:46:51 +0800
Message-ID: <af73f81ba5060272e63bfe3757295fb09f5c6198.1792733621.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792733621.git.zhilinz@nebusec.ai>
References: <cover.1792733621.git.zhilinz@nebusec.ai>
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

In tcp_bpf_recvmsg_parser(), copied_seq is saved before tcp_data_ready()
processes data queued before accept(). The sockmap verdict path can
consume, drop, or redirect that data and advance tcp->copied_seq. The
parser later writes back a value based on its stale snapshot, rewinding
the sequence past data no longer present in the receive queue.

Refresh the local sequence from tcp->copied_seq after tcp_data_ready()
processes the pre-accept queue. This preserves progress made by the
sockmap path, including when the receive queue could not be fully drained.

Fixes: e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://sashiko.dev/#/patchset/20260630205043.184894-1-rhkrqnwk98@gmail.com
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260630205043.184894-1-rhkrqnwk98@gmail.com
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv4/tcp_bpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 0ce583f68d3b7..383ee167eb300 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -252,6 +252,10 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	 */
 	if (unlikely(!skb_queue_empty(&sk->sk_receive_queue))) {
 		tcp_data_ready(sk);
+		/* tcp_data_ready() may have consumed or redirected data and
+		 * advanced copied_seq.
+		 */
+		seq = tcp->copied_seq;
 		/* This handles the ENOMEM errors if we both receive data
 		 * pre accept and are already under memory pressure. At least
 		 * let user know to retry.
-- 
2.55.0

