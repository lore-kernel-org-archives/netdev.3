Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794176943;
	b=q7FIyyE8mBoQdA0atSolx4LXJ08hcS92U5xfcLQEy2TgP7AYIJmu5eWD26PZB6omg4qi
	 WUS+opng2tzAkPTs4gEpA/QrGVik/AfugmhLKp+X/4nJDbEytqO7vd/ac4Tcl9hqGsB1J
	 QmYZsMhXgu9LK6YxgzAnESkDBdchpRRxpZG7iL89KaVXFookIpS0SYVzZ3LoayuPDHjo7
	 zYCeR9dIkwOGkpR6v0L2c2vI8kbY+n9JTUgJBPsMXEe2eeZvB5xkVlelYTjuPOgSyhejh
	 Wt90eLxwk50s33SgGQFViE9o/xPkNCBs7YZNKId1S5aDXD317gIkWk6EvC+aQNd1l2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794176943;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dTgEUA8Whje8A1OUq4d6k9QZorEeZrIRrczqzkk+kks=;
	b=Kyjre1rBt3oAetzfZELt6CTEhLZDLfuUswzMzizoMgBO/g/1owcWbSVWQjcJmo/negEH
	 itFx4uBClDnK6ZpVnlmLH8kD6IhoOm0UuouIboVyYdFURrTUelWnkanEiIlsGXUAd5dXP
	 9Zyedix5aWKXD3KdaCi3WWyHIYf4WNyFOGZGRQUlUnxVYkxfzvZq0RHji8KMN9DFrJOYb
	 jC8KkdH0PYEX7edBbIaSjAxME+Mz6IkC74zePCY+0Zc0jl9YKShGpnHlER6Q/elb2bj1L
	 7W9NvwAX43PuAOWmB/JL4DzG9LtZYJMASOXaoKFc0bBBRYJig9GQRUtWkY8zIx6o85Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=B8LxDbZK;
	arc=none smtp.remote-ip=79.135.106.29
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086B606A334
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 22:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A086B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=B8LxDbZK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794176940; x=1794436140;
	bh=dTgEUA8Whje8A1OUq4d6k9QZorEeZrIRrczqzkk+kks=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=B8LxDbZKxBRfDSErb38VaNElqbgnbbOZ4ivQgdMmZ0FWlIu0Q4JisWUPCrpQqykx8
	 mrKY1UI8VzPMzwLkvmG/4+xlkLBgQiwt+26gES4TM4OX2dN9qrQT8Hb8wkB1uRYhab
	 wWLWy9Sv4VbHnMKR3/SlWV8JZvjScKv0fp9lnPYv6ewaVPqquAZFAxXaH2iRealge1
	 Wh3s4MnIBOtj7ucWDvba7xDA8XGiXKCZveVG3GEbcb2uyPI3NRAWKEpTXDcPIy6bEF
	 FwQh1zXnHDOvdMZg8dZdQV+HszujY5Bz0cyf1y+65YHpMj9IIr+r6V231FTqV0Z9aU
	 73Ha28pCQ+3/A==
Date: Sun, 08 Nov 2026 22:28:57 +0000
To: "david@ixit.cz" <david@ixit.cz>, "davem@davemloft.net" <davem@davemloft.net>, "edumazet@kernel.org" <edumazet@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
From: Noah Weinberger <NoahWeinberger2003@proton.me>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] nfc: llcp: pull DM reason byte before use
Message-ID: <mcyWWpY9VDnsb1o6EnHOMwEinRkPRORIx9_O6DMiKhWHsDIrbITdgbL2PkFkJKgxIIs_0euqmOIT9eCZVFZ9-F8y_g_dFysV8EEOHP6UxmY=@proton.me>
Feedback-ID: 186545857:user:proton
X-Pm-Message-ID: 65cf35a35a1c99d57c2a0634a4bf03a81f010983
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

__nfc_llcp_recv() only pulls the two-byte LLCP header before
dispatching, but nfc_llcp_recv_dm() reads skb->data[2] for the DM
reason code. A two-byte DM PDU (or the AGF-wrapped equivalent) from a
remote peer therefore reads one byte past skb->len. The HDLC handler
pulls its extra byte; the DM handler does not.

With current drivers the read stays inside the over-allocated skb, so
this is a KMSAN-visible uninitialized read rather than a slab overread,
and the value only steers the reason-code switch. The patch pulls the
extra byte first.

Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd =
(v7.4-rc1, 2026-11-07), net/nfc/llcp_core.c:1278-1290 (nfc_llcp_recv_dm), l=
lcp_core.c:1620-1633 (caller's pull).
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
index 74bf817..733e643 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1276,13 +1276,16 @@ static void nfc_llcp_recv_cc(struct nfc_llcp_local =
*local,
 }
=20
 static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
-=09=09=09     const struct sk_buff *skb)
+=09=09=09     struct sk_buff *skb)
 {
 =09struct nfc_llcp_sock *llcp_sock;
 =09struct sock *sk;
 =09u8 dsap, ssap, reason;
 =09bool connecting =3D false;
=20
+=09if (!pskb_may_pull(skb, LLCP_HEADER_SIZE + 1))
+=09=09return;
+
 =09dsap =3D nfc_llcp_dsap(skb);
 =09ssap =3D nfc_llcp_ssap(skb);
 =09reason =3D skb->data[2];

