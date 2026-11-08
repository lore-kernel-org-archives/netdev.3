Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.121
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794176744;
	b=mB1uZeBvWA1mS2aLpvklpkRPGulevFb+fo/CCjJJYd3/D2hN64MPNH2LAiJ5exKKoaNs
	 dEMVPmhWJIZdkGBmDZZeynr76bfwj4o5aPe6sjkjGwTo/NN8ApMJLZZPrnvftPG5RYJOd
	 NdqddWblH+eEx6JvXOukhJaFo4vHsYxwLETxODp3ilBbBYND5DQu5a3Dh/q4ay4rqfUHp
	 3Igx50tmYnkJGiQ70EEjsbwSriJl9/QHS5R1qBVUlUyATVDeT19233Txf/cyFETcFToUo
	 qctRWIWgfVKgpdhtx8QEwar4i7KVFBFJyA3Aeom76slnYjWacb4Q04cFWu+GcRgaSJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176744;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AaBrpfH0IYUixaU7BA7hLUWArC2gpbyzJoT9RsAM/a8=;
	b=QZZ1ioLyMyx3+sF0y8C6z9wqrWLEnX1NxkXWvXvwHGiKiWFaglDHumwvhOq07AmDjmS/
	 4pgdSkIWypzR98EaOUS3F2YULuZZXLiLvumoD+xfsFiuaH+TwLBsYOA3sK0nlwEhkYdAT
	 NudfdConwnbxTwaciJMCUQ0pg0fNH54kJNBRAMzA4YTqFwBWxrJGXah6fT3plYAzWYS7W
	 H6rBwZIyLzY0Pv6ok4DaGN4+3Ni/7PEVns8XwwY9qOyjJ6HB5IJmZNogBhSIZ6x8W4paM
	 5DucPiXuQETHJKC9o26kcIovrG+LKIsDIu0GO95cUMrz2gspG0m8i+3iajWAc33/zyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b="ow/c9rhb";
	arc=none smtp.remote-ip=79.135.106.121
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4A606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 22:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD4A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=ow/c9rhb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794176740; x=1794435940;
	bh=AaBrpfH0IYUixaU7BA7hLUWArC2gpbyzJoT9RsAM/a8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ow/c9rhbSx2K0anrX6/02QCKhiYhpO27FfKm3pRzeryPSqYTS43mbcC5phPVsrJQl
	 RZoUtgrzYW26iQKcYOaJN2yC57JQj/0+AiNxzDMVIv2Un4Cz4QrRDthZLc7s/eqQQ6
	 QO7iFFzDGuaNEClO6FgE0+/8EOpy0FvXj64VJVocZvPNAXnh8VeCvBq5JsF1iFj+JU
	 t4mqVzQKI4RwYr1Px4bNHM030PYZTxZrv5Ni3wzN5T+jhlKoP082OgeA23fvF5g+qc
	 j/a6UYxU53ViCREVAGMo1jueA6kjqB9IdfzXBEjBCHnYCHh4f8k6j3CJWKkhixI0im
	 obW9Dt7K5oDlA==
Date: Sun, 08 Nov 2026 22:25:35 +0000
To: "david@ixit.cz" <david@ixit.cz>, "davem@davemloft.net" <davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] nfc: llcp: drop socket reference on undelivered UI frames
Message-ID: <-mPkBfqn9vzam8gV7Gbd5HGTPILiECmnRoTWiEESIGtgUyQCeZ3cmL9anfsTEqgkI_OIepj_Pf31PXrps4461AE48xq0Vp0R1dnAuSYk_8I=@proton.me>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: 14992636808d9ec8645918bdab1a94ded0610819
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

nfc_llcp_recv_ui() looks up the destination socket with
nfc_llcp_sock_get(), which takes a reference on the match. When the
socket exists but is not SOCK_DGRAM, the function returns at the type
check without calling nfc_llcp_sock_put():

    llcp_sock =3D nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);
    if (llcp_sock =3D=3D NULL || llcp_sock->sk.sk_type !=3D SOCK_DGRAM)
            return;

A remote LLCP peer can arrange for non-DGRAM sockets whose (ssap, dsap)
match this lookup (accepted stream sockets take dsap from the peer's
CONNECT ssap; connections by service name use dsap =3D LLCP_SAP_SDP) and
then send any number of UI PDUs addressed to the socket's ssap. Each
frame leaks one socket reference: the socket is pinned forever, even
after close, which is an unbounded kernel memory leak from an RF peer
(memory-exhaustion DoS, rate-limited only by the LLCP link).

All sibling handlers (hdlc, disc, cc, dm) pair the put on every path;
recv_ui is the exception. The patch below puts the reference on all
paths and only delivers to connectionless sockets.

Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd =
(v7.4-rc1, 2026-11-07), net/nfc/llcp_core.c:902-936 (nfc_llcp_recv_ui), llc=
p_core.c:218-251 (nfc_llcp_sock_get/put).
Longstanding code.

This was found during an assisted (AI-supported) static source review of
mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); e=
very code path cited below was re-verified by the
reporter against that tree. The patch below has NOT been compiled and has
NOT been runtime tested, and no reproducer was produced - the triggering
conditions are described above instead. Please treat this as a report for
verification rather than a battle-tested fix.

Reported-by: Noah Weinberger <noahweinberger2003@proton.me>
---
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf817..78f80c4 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -917,9 +917,15 @@ static void nfc_llcp_recv_ui(struct nfc_llcp_local *lo=
cal,
=20
 =09/* We're looking for a bound socket, not a client one */
 =09llcp_sock =3D nfc_llcp_sock_get(local, dsap, LLCP_SAP_SDP);
-=09if (llcp_sock =3D=3D NULL || llcp_sock->sk.sk_type !=3D SOCK_DGRAM)
+=09if (llcp_sock =3D=3D NULL)
 =09=09return;
=20
+=09/* Only connectionless sockets receive UI frames, but the
+=09 * reference taken by nfc_llcp_sock_get() must be dropped on
+=09 * every other path as well.
+=09 */
+=09if (llcp_sock->sk.sk_type =3D=3D SOCK_DGRAM) {
+
 =09/* There is no sequence with UI frames */
 =09skb_pull(skb, LLCP_HEADER_SIZE);
 =09if (!sock_queue_rcv_skb(&llcp_sock->sk, skb)) {
@@ -932,5 +938,6 @@ static void nfc_llcp_recv_ui(struct nfc_llcp_local *loc=
al,
 =09=09pr_err("Receive queue is full\n");
 =09}
=20
+=09}
 =09nfc_llcp_sock_put(llcp_sock);
 }

