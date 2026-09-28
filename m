Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B184D37B7
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 17:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616185; cv=none; b=aFJP26Tl22699Qs2YyZ3Zm5sOyGajy5FsxI3PvjuilxmLWbBmw1NcErKYaKhPpIvBDPP3B50ebCo9WviWLDge8C8eQTnx3jfp8IhaUF8MEhx2rwKXuVnc6URw7H5kLjgFBKbOw0VHxUPvYffNzDsMeviishJiR9kuzLH3nAr6UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616185; c=relaxed/simple;
	bh=lCXyHm+iaIL3bQ9txdLtXflEDH1wllb3V7pgxbd6W7w=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=EgAB4pBiAXAR6Svy6RxLjQgZqPNQopJ3/ue4vdqzqGyC+J8icS6A8yiVuBABr7B7cuyaE4iR7+ignwbTXFjUEqntX5vKuIWKPv1rZd25ybAyX1K+E6qoX+plAzRXHYi68lC/H3TE/Sy1aIuc+rsoH2yGvz6F70iT0UcCACrNLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=AFNlRC61; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="AFNlRC61"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2dcdc386ddso207203866b.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 10:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1790616171; x=1791220971; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sx2gaek3RzQGvXZj14sm8lya8hmYE5akZiXZO8UHtHc=;
        b=AFNlRC61IYKycta3I/AyUv0om1YYDS91qiWzotFvEyvlidIshv6Fb/1BBglFvxfCp6
         CZp2dtlPV1AJU/gdh/HFbaE8XDhMvF46Z4YjANHxMZ1BgfMXeIgMP1hJDOPQgMmO9jKZ
         vcXk9+4t78x1fYuRfSa8VXzacmk9h10JMX98IDtx044VCZET9+49ooyNGBBjay80Kn1e
         +rPaKFJwdyk6KfyatvMaNL5OjMe/05rBxW9ncAzKEcuiVOAPXLQIM0PvqGnNIXTrQxom
         xoREPlR9Tyk4G+2xto0XEUdkb5HUJ9EYhL99uFBponUA+b5IDkd8j0rthaANTye3SqkL
         c4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616171; x=1791220971;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sx2gaek3RzQGvXZj14sm8lya8hmYE5akZiXZO8UHtHc=;
        b=1hHWuz2spWkWiJC6koCiLNnShj9gS500zYv5cGhCBvMwaW34rTqZZIVm59qybiYQJz
         f/9xtfxMUli+ndniivkvOEawSaNazo1cDuFmyoLG97bVibHbo8/XUJrPXVryqXoNF+j4
         bUR/EJd1UsN36OFfghURb3woOJq48sLrCZUiLkfMeaxxWOBHrsgNuNgY7W63NI647aev
         1Awrb8EcPoVdfWghzYkfC0KIwH1x7PkP44lfZdNYavBXrtD3Sp9orxEuh5Lp5MiLDmOc
         U3tgUru7ryfVxRCGZWmiscVvRJ7vea3BE5Iaa8thkOHVA6ha2pMD/6NKrmNVbZya0fS/
         gNnA==
X-Gm-Message-State: AFuF++nHr0bXr83ZitiDHWeMQO/AP6RwnS9pihXKSno2iYveJh8XaC25
	XklZieRJ37gbAdgZn7cp+lcgIkGdD1zWWeg0Io2JlMDdJd+JYT4KimzFxVHSKstqp9KsgbSrCe5
	X2JEPxc6xaw==
X-Gm-Gg: AYBFou1+k+GaFAVwFpf9aCvK5ebgjE2cM25+TqeFpLi0GPGZOzKEWPtJPVH32QzXXGO
	R9xe5nhpaQn6wGSj+q0l1vQVT8JQTDVvprSev/8PVatycAAs1ehgRY0o8QkRpCk4S5TNBSlSbu0
	ePmYpVBn1uDA28OIgRsH6NiguYiY8ZUjhK7U/l4BYXH+cf85uWSqDw8NDDSpy3m4p26Mq/QKFSS
	EYZWxdC1AaD7+pVUdKkZRDLRgMhh98P2JaywFx26k7KjzcQvqSURViTMFOX3J2DmGoOwdtYCjIT
	p6K70vvclxdy6Q7hyFk3+2hlRYGVlpvTEwpe1+rCU1BBWbsiEZFFeQs/NG2j0iWawi1BByw5p3b
	2HZlEdU1Mr0S9TyxPQ+Zc5mlC+9gqbci0yCTD6eq+QJvmfasjofWBxPZMp/TcfsOx8xrj1w6d38
	QAz57z7qSMBOTRf8IzCKlSuUHe1kwE37I7OODc3PRb/6i1L7Fl55/3D7JjZvbc3426paARvEBq+
	HSlu5NUF8KEDcog1eE43zHraiuE4K0QfFi8xINaR8M6FfDdGeaAW3C88TWJpQ==
X-Received: by 2002:a17:907:728d:b0:c29:f5d5:5a94 with SMTP id a640c23a62f3a-c2ac23ec0b2mr1066751466b.30.1790616170862;
        Mon, 28 Sep 2026 10:22:50 -0700 (PDT)
Received: from smtpclient.apple (80.49.145.194.ipv4.supernova.orange.pl. [80.49.145.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dc8b71b4dsm275758466b.1.2026.09.28.10.22.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 10:22:50 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: [PATCH net] soreuseport: Fix use-after-free when a socket is added to
 socks[] twice
Message-Id: <6E4F8645-9453-45F1-B068-52E1B14E8B0C@doyensec.com>
Date: Mon, 28 Sep 2026 19:22:38 +0200
Cc: Eric Dumazet <edumazet@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>,
 linux-kernel@vger.kernel.org
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3864.700.51.1.1)

reuseport_stop_listen_sock() moves a shutdown()ed listener from the
listening section of reuse->socks[] to the closed section: it removes =
the
socket with __reuseport_detach_sock() and adds it back with
__reuseport_add_closed_sock(). The return value of the removal is
discarded and the add runs unconditionally.

The socket need not be in the listening section. inet_unhash() calls
reuseport_stop_listen_sock() for a listener whenever sk->sk_reuseport_cb
is set, but inet_hash() enters the reuseport path only when
sk->sk_reuseport is set, and SO_REUSEPORT can be cleared in any state.
Clearing it between shutdown() and listen() makes that listen() skip
reuseport_add_sock(), and with it reuseport_resurrect(), so the socket =
is
hashed as a listener while it is still in the closed section. On the =
next
shutdown() __reuseport_detach_sock() does not find it in the listening
section, returns false, and __reuseport_add_closed_sock() adds a second
copy of it to socks[].

sk_destruct() calls reuseport_detach_sock(), which removes one of the =
two
entries. reuseport_grow() then dereferences the other one, because its
loop runs over every slot up to reuse->max_socks:

  BUG: KASAN: slab-use-after-free in reuseport_grow =
(net/core/sock_reuseport.c:291)
  Write of size 8 at addr ffff888132359988 by task poc/621

   reuseport_grow (net/core/sock_reuseport.c:291)
   reuseport_add_sock (net/core/sock_reuseport.c:350)
   inet_hash (net/ipv4/inet_hashtables.c:810)
   inet_csk_listen_start (net/ipv4/inet_connection_sock.c:1359)
   __inet_listen_sk (net/ipv4/af_inet.c:225)
   inet_listen (net/ipv4/af_inet.c:247)
   __sys_listen (net/socket.c:2014)

  Allocated by task 621:
   sk_prot_alloc (net/core/sock.c:2246)
   sk_alloc (net/core/sock.c:2308)
   inet_create (net/ipv4/af_inet.c:333)

  Freed by task 0:
   slab_free_after_rcu_debug (mm/slub.c:6570)
   rcu_core (kernel/rcu/tree.c:2919)

  The buggy address is located 904 bytes inside of
   freed 2624-byte region [ffff888132359600, ffff88813235a040)

Only move the socket to the closed section when =
__reuseport_detach_sock()
reports that it was removed from the listening section.

Fixes: 333bb73f620e ("tcp: Keep TCP_CLOSE sockets in the reuseport =
group.")
Assisted-by: LLM
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
 net/core/sock_reuseport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index 29948cb44b7d..031b641be317 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -479,8 +479,8 @@ void reuseport_stop_listen_sock(struct sock *sk)
 			 */
 			bpf_sk_reuseport_detach(sk);
=20
-			__reuseport_detach_sock(sk, reuse);
-			__reuseport_add_closed_sock(sk, reuse);
+			if (__reuseport_detach_sock(sk, reuse))
+				__reuseport_add_closed_sock(sk, reuse);
=20
 			spin_unlock_bh(&reuseport_lock);
 			return;
--=20
2.55.0

