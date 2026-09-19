Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3951360ED0
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828741; cv=none; b=Mq/e69A3JtI+qiecc5P9zsOkCfsPchcCL2WGfbM1MvOYbiJ6x2F7fepBlcXVGVNsP3St5IdDzM+jOhE/Vm4vontMdo0OtFLPwn/MumkdQhtL9WKq/+3n8Hl594+yAYOJgIpLxFRLxffsz/x+Qi24WbY999K5khfkhHGZlXuIedU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828741; c=relaxed/simple;
	bh=av8t/T6ZS5uCE/nEyR9vVivlj8OSsiMscYwP23L8oIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFL4SzyKQKfaMbyVgmsh6v9LxsRfMLniQKBFDwgE8pnzzZVUPEbNhbiY/Byjj/IAf+px5qACf3dO46Ucp7E8BlWe+6q4NrtjWnaaRuu3T1gZkS7siJDDoU2CsDVoJVH43O5YuCp81PsqNKvB5cRLAzqGLIdPk/+7rscPBkh/me4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdBd7JFg; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdBd7JFg"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca069c8so17026345ad.3
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828739; x=1790433539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mg7vwSHdpgkjHuAuSf6HmJMBzQg1Mbs7T+3qFylATrw=;
        b=gdBd7JFgIWkdZvt42Vp6+76AsV3stf6PB10xc19jamFxAZiJwIIUw/O3TiHbO0FmkG
         x9xKyHu8X0NhN1/GYSB6+5bRI1ipGv4/E9aohY/jd6Y6i2qantHU+iiE7u2Mi3fYq3Au
         rHVX6BBEBDjMrSoBK7+gTKiXWur9DTQc0gjzumYS0WUCytmernbI+8VUazwFIHSB3PBU
         lwwCR1WtgjhTPtrtvJRPNuSr+jIW3ghFMPWrk0NpvevEDnCByDFCsQ768Fj6IPQ+kDUy
         rsKiPz65bVzjd0jwatMLq2AgyW73YMqKVqwxexLxXfU1H/lT+EVLc5DNdlq7g1tSlby5
         c4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828739; x=1790433539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mg7vwSHdpgkjHuAuSf6HmJMBzQg1Mbs7T+3qFylATrw=;
        b=2kmaofZrc/XqNRIoTmCQ2iddaUDFCeSBlVSfxqmcO5Vpuea36uj+xkniBrIc5je3jb
         PbroQjDNxv2lXxZxZSvdzBOyGfKVUJOOgKEU+cFuyhizJ8nkXKnBaOVZo+sYHX/NJeN7
         cP28XcbKXt66YxG4WqxSAiHrWY2zd2vVx/BqL/Q/c13oGlx37lVeFP1FmWh5sgXAMW7T
         KcL6NN0VxsHZiG05R65PkV6dcyJZEkmJYx50AOmV3aZDwr94s3nkM0PsfQN6dz5b8nDk
         7Gdqh9CslcSWzR5JUdlF6V25TxY+J2zS3slZt6ZQ9HsRwjwlXTi16WcgFiX+TGD72rG0
         64wQ==
X-Gm-Message-State: AFuF++kU7tAHh07HH51UYK7ZPdygE06cssAZu6flYcmYNzbqJyBpA3ks
	zB3uyaqDA602qvfreLILvXSjYbVf6lQ02nT0y8UiOce0mRQ+m4Q6DDYH
X-Gm-Gg: AYBFou3F/cLcmteEy/H5EUajJ6So+qgg0XpsOBnFTWXgqzMxdBElxelYXde5EIbTXEF
	ilmbsU/oOf1VBC3gWlZIabUnBdLJlZTWaCOxHJflRFlNTSaDFMgJxRF4OPZGzsyklFrlb95aZZx
	PwhSCyA/76Xt7YaykR2ztBu5KQB9e7zJH/SBe85csR+AHeSvKUcK7YcwdLxTkJiphj9NKe8CTo9
	5Cgr0qrBlXoApR600+3uO70Br15Wzp1gmusby09aDrNSmc2ilYqs/6FBffp3QmS805WHObZSPi2
	jLeJJQKCdm33Hyfbt5WkPM63GvfQjMejPVvFS8NuMkLIKcDDCtIl//z7tX9sHjRIwo/5xp/+ymc
	Ca7FnWjqMLm4S+/qGNvO3zgAj2msi0RcaY3XzScokLk8tC2NIJ//EaDgvycgPMoV3VE/7HDB6wx
	36L7e6JhYS2ik31kpPFvXBbfUDXRaU2G4NnCoq6HrqBIZLl957T99NM3F4/h3+m2qao7LhhSZuZ
	6Be3jGPPapqZf55tTv4bShxnlIxWEPhiWS/IxbG42dcJ6iUcqrBFJSZICU/DSe7LaI6Bv4Mb9wS
	dL1cFFUbIYe92TNODIjLe5UMj5tNcUOTz3rR3ZVCeMUtvLi22pYfsct9K8A=
X-Received: by 2002:a17:903:1112:b0:2dd:c053:c20a with SMTP id d9443c01a7336-2ddc053c2a1mr41919155ad.38.1789828738993;
        Sat, 19 Sep 2026 07:38:58 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:38:58 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RFC net-next 3/9] tcp: record a start time in the tx path for SK_BPF_CB_TIMESTAMPING_V2
Date: Sat, 19 Sep 2026 22:37:26 +0800
Message-Id: <20260919143732.11772-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new field sk_start_time to 'struct sock' to support different
types of sockets (TCP/UDP/ICMP...) to record the pre-set start time
value and then propagates it into skbs.

Start time might vary across different protocols, so for TCP the
patch picks the entry of tcp_sendmsg_locked as the start time because
1) it already holds the socket lock,
2) it nearly reflects when to trigger a sendmsg syscall from applications.

The value for TCP is a real (wall-clock) time from ktime_get_real() so
it stays comparable with the timestamps produced elsewhere in the stack
and can be consumed directly by a BPF prog using newly added
bpf_ktime_get_real_ns()).

A later patch copies this value onto every skb entailed by the TCP
write queue.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 include/net/sock.h | 2 ++
 net/ipv4/tcp.c     | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 51185222aac2..782ad5fc8ff5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -314,6 +314,7 @@ struct sk_filter;
   *	@mptcp_retransmit_timer: mptcp retransmit timer
   *	@sk_stamp: time stamp of last packet received
   *	@sk_stamp_seq: lock for accessing sk_stamp on 32 bit architectures only
+  *	@sk_start_time: start time recorded for SK_BPF_CB_TIMESTAMPING_V2
   *	@sk_tsflags: SO_TIMESTAMPING flags
   *	@sk_bpf_cb_flags: used in bpf_setsockopt()
   *	@sk_use_task_frag: allow sk_page_frag() to use current->task_frag.
@@ -552,6 +553,7 @@ struct sock {
 #if BITS_PER_LONG==32
 	seqlock_t		sk_stamp_seq;
 #endif
+	ktime_t			sk_start_time;
 	int			sk_disconnects;
 
 	union {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b4237d0e994d..28730a3e4473 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1129,6 +1129,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 
 	flags = msg->msg_flags;
 
+	if (static_branch_unlikely(&bpfts_v2_needed_key) &&
+	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TIMESTAMPING_V2))
+		sk->sk_start_time = ktime_get_real();
+
 	sockc = (struct sockcm_cookie){ .tsflags = READ_ONCE(sk->sk_tsflags) };
 	if (msg->msg_controllen) {
 		sockc_err = sock_cmsg_send(sk, msg, &sockc);
-- 
2.43.7

