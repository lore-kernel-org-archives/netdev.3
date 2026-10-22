Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683619;
	b=iHGYrgkyIdtMDbC/x2F0Pl9Rf5vpcsMeEPnDcGlBdol6JzmXo82eAEtDhbenvUs0FLQg
	 M0g2Zk8QRZ1iesJQMV0WugKFAeUHacKC25PYEszHoX4SIGGENXXss9+H42eYed/Fl14Fw
	 VdGvGqPJSC9yvPtq5ojzAVUlpJXITnS/0Oa6mW/gmTmJLxCmuFcI36EdGm6lLqiBfb6qG
	 KEEukzexVjg6EBHpE5JiX2y5lR3/NzW9LtUI/4ArPwfKq3tf1fsUo9dOp+loVEFx+HFYB
	 mqSAiJw7qsB1LHsfWgvqYbDZCoj+7m7/QL4odV8j7BIvHnBv1xRpM6WFEy9+qj3UyhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:X-Mailer:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1VvzaG7f8kY8sdU70SP4PWgnMmzOl8H/DL+fBRJI1W4=;
	b=S8Qhq9aaTOLQIswx3lv/y8ZTyW3EgAZliFRoPCRK4eBrdSxzQC39h7GsKBBwMbJ25VkK
	 WPfg6H757Uc/Tlw4JSnKbLUoOeYpFz32G5hGL6kib0b79XNIZ9HLQHdCZ0lXp1EbDHMyH
	 gw2l8l+cPdOE7INXIeLVPzS3uT/rRkK7BKrZo7J+KUC9lHZbmQRDV7qYTmmX8/3lLEl8a
	 xrK/xiyiq3Jo9Dkus0135Q8xRRIBM1OqMnMggckGLGqZ3fBxzb6RQf1v/MUlD1eK/47FL
	 ZMhOykJ9yJ7Neiuh7uPYLwzTYzuKXyRBrkP337L12jUqKL/z12DZgtUj4FKOFRhY9IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kwFJBqOQ;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946B1606A321
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 946B1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kwFJBqOQ
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd61a2dfd7aso502907a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792683619; x=1793288419; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1VvzaG7f8kY8sdU70SP4PWgnMmzOl8H/DL+fBRJI1W4=;
        b=kwFJBqOQVs3qGLjatUX6GWXX4U9ulGUGae1UxOzFPgXpOVoCqe02Mgxk9JxQeviFD3
         4wgeh9TbIYED8+iDAeNLJO4LuocPEEIUTDibwhoxe6yBUqLII6KJuP7hTPDTN1DqI+UA
         +Z84VBM99+U8UTUNpDadWoXaHi8cnxND6nkmxb9B1l0LhpzuTFm/MqP2QMWLRn0xZiqi
         FhSytOBMW8WrmF66OAaeFT4HI7uRhKf2LAW8y8B8aH+CnEcKCc7ip7Afwj3EQSPdytR4
         NnA5tQL8QCRRrY4ifhsxJ2G4/5tmI12DMT8gPJDfZCZIujAPzsZ+WuJ/OoQhnhdi2dfy
         LhIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792683619; x=1793288419;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1VvzaG7f8kY8sdU70SP4PWgnMmzOl8H/DL+fBRJI1W4=;
        b=nank7GdEUrrd+yW0dnLATXnKVJ66TWlAg7yjQddf3W0S2nenxVmAmNC1nvy2rXb8pl
         2vmGRkib6YALiG8P7HTj0jJtzgJn9txvxi/gaeEm1MBKswzY50B+KCtFX6FsFdTfGoTA
         lfnQdPZZiiZm3TicevxmYJOKBRxyvRY4L7lJitKXmdmh+VhteUHtodp+N1+LFqVZNVL4
         ohZCM1SfXRuaR0g2+fFnQrBgjG4WjOkLgUSnh4HcIxmwEWm+QqYyKbml78xDdZ2P7Lw8
         1dHIgxSKKY/5MPu/iB+jeLypISENk1tnSCsK+SuvjWUqww0ER3fMCL+oTYGgU+/+ED25
         fRmg==
X-Gm-Message-State: AFq9FYLE8oDyoUljCMaCChbPizkg31CcjhHL8pjZ6AUUtjtDehqOVXSO
	G0BZDDCxxvfbgy4MOpwzzqTIV15WhkTT57xlPYfQOM5EAfx5jFMEKpTAFjsgzw==
X-Gm-Gg: AYBFou29P5M8utU6ov9/Da5fSXCMK+an1LEdhADm1jjBwYBUBpVP2LP3Obzrrr70vUG
	VWYGe+p80N74GgawAnydC8F3e3ofkxBqXsLaoTiQJzrGv5uaYoTAshgpUmus4lZJQcVuxIK6Eow
	cP0QlkuoEUHf8gDWqb0TQnKt+g3nzMOTeNAHZenLInXIEf9HKZxVRu3ZQuo93J6TCDa1sSsJubL
	sUMatxgNtKoXw7wKRbolfqfPsyAjYonNCYZl1U/ptGlC06+5fm9qgCycbiMuuIUa1GAaTVleCtc
	heqV/nZrSe5TeiSJDwN5vjxhsWegiGH2DxCLY/LxALb6/eOL/ipbeXw3Zi5VTHvziHA46NzimTk
	vj8pZ1vO/binRfjI9ihnr1jD1cWqR40c0VXYfgqWQXa6ewMpaRJRvx7k2FXpgQ5V40E51nOjjCY
	gaHyYqTYfgHEMExIXInm2tDhS0Cbvrbo6/H0D005qRQzXLuaR1ehIAbgiufODZGwu/BIpBvgmiY
	HYgYYo3ZnuLCSxqjPT7zUYfdxzN7UFx9fD9JUFFoCWIXj7Y41pdgzW7WKJOCwGBdw0v5jwY+O+r
	FDPmTlKV1DCq03QBk+i7GFEcF3hfWNR32DFSXqkdskeIANmNmDO7FBSNDMkZ
X-Received: by 2002:a17:90b:3b44:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3ad86d50c9dmr4757070a91.26.1792683618714;
        Thu, 22 Oct 2026 08:40:18 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48876ebsm4728238a91.1.2026.10.22.08.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 08:40:18 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Oct 2026 15:40:17 +0000
Message-Id: <DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data
 races
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Dudu Lu" <phx0fer@gmail.com>, <john.fastabend@gmail.com>,
 <jakub@cloudflare.com>, <jiayuan.chen@linux.dev>
In-Reply-To: <20261022054811.35008-1-phx0fer@gmail.com>
References: <20261021155629.68813-1-phx0fer@gmail.com> <20261022054811.35008-1-phx0fer@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 21, 2026 at 10:48 PM Dudu Lu <phx0fer@gmail.com> wrote:
> Annotate every one of these accesses with READ_ONCE()/WRITE_ONCE(),
> matching the existing convention for the same fields: sk->sk_data_ready

This makes KCSAN quiet and leaves the race where it is.

sock_map_link() runs under the sock lock. sock_map_delete_elem() doesn't
take it. sk_callback_lock is the only lock they share and sock_map_link()
takes it after psock_set_prog() and sock_map_init_proto().
So two tcp_bpf_update_proto(sk, psock, false) can run in parallel:
  cpu0: sock_map_link() for a map with msg_parser sees
        psock->progs.stream_verdict and picks TCP_BPF_TXRX
  cpu1: sock_map_del_link() stops the verdict and stores TCP_BPF_TX
  cpu0: stores TCP_BPF_TXRX
The socket is left with tcp_bpf_recvmsg_parser() and no verdict prog.
That's what commit c0d95d3380ee fixed.
Take the lock earlier. Then psock_update_sk_prot needs no annotation.

All accesses to saved_data_ready are under sk_callback_lock except the
three reads in sock_map_del_link(). Move that check under the lock instead
of annotating it. No need to touch skmsg.c and skmsg.h.

Only the two lockless reads of sk->sk_prot need READ_ONCE().

Something like this (compile tested only):

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 38df842..20fb605 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -152,11 +152,11 @@ static void sock_map_del_link(struct sock *sk,
 			struct bpf_map *map = link->map;
 			struct sk_psock_progs *progs = sock_map_progs(map);

-			if (psock->saved_data_ready && progs->stream_parser)
+			if (progs->stream_parser)
 				strp_stop = true;
-			if (psock->saved_data_ready && progs->stream_verdict)
+			if (progs->stream_verdict)
 				verdict_stop = true;
-			if (psock->saved_data_ready && progs->skb_verdict)
+			if (progs->skb_verdict)
 				verdict_stop = true;
 			list_del(&link->list);
 			sk_psock_free_link(link);
@@ -164,8 +164,11 @@ static void sock_map_del_link(struct sock *sk,
 		}
 	}
 	spin_unlock_bh(&psock->link_lock);
-	if (strp_stop || verdict_stop) {
-		write_lock_bh(&sk->sk_callback_lock);
+	if (!strp_stop && !verdict_stop)
+		return;
+
+	write_lock_bh(&sk->sk_callback_lock);
+	if (psock->saved_data_ready) {
 		if (strp_stop)
 			sk_psock_stop_strp(sk, psock);
 		if (verdict_stop)
@@ -173,8 +176,8 @@ static void sock_map_del_link(struct sock *sk,

 		if (psock->psock_update_sk_prot)
 			psock->psock_update_sk_prot(sk, psock, false);
-		write_unlock_bh(&sk->sk_callback_lock);
 	}
+	write_unlock_bh(&sk->sk_callback_lock);
 }

 static void sock_map_unref(struct sock *sk, void *link_raw)
@@ -202,7 +205,7 @@ static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (psock) {
-		if (sk->sk_prot->close != sock_map_close) {
+		if (READ_ONCE(sk->sk_prot)->close != sock_map_close) {
 			psock = ERR_PTR(-EBUSY);
 			goto out;
 		}
@@ -284,6 +287,7 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 		}
 	}

+	write_lock_bh(&sk->sk_callback_lock);
 	if (msg_parser)
 		psock_set_prog(&psock->progs.msg_parser, msg_parser);
 	if (stream_parser)
@@ -298,11 +302,11 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 	 */
 	ret = sock_map_init_proto(sk, psock);
 	if (ret < 0) {
+		write_unlock_bh(&sk->sk_callback_lock);
 		sk_psock_put(sk, psock);
 		goto out;
 	}

-	write_lock_bh(&sk->sk_callback_lock);
 	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
 		if (sk_is_tcp(sk))
 			ret = sk_psock_init_strp(sk, psock);
@@ -536,7 +540,7 @@ static bool sock_map_redirect_allowed(const struct sock *sk)

 static bool sock_map_sk_is_suitable(const struct sock *sk)
 {
-	return !!sk->sk_prot->psock_update_sk_prot;
+	return !!READ_ONCE(sk->sk_prot)->psock_update_sk_prot;
 }

 static bool sock_map_sk_state_allowed(const struct sock *sk)

Pls run your reproducer on it, post the reproducer with the respin
and target bpf-next.

pw-bot: cr
