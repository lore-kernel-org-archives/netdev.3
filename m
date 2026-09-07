Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A13955D9;
	Mon,  7 Sep 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810225; cv=none; b=psaIdRZSEdXCBpvpsh/33xnKc7I9fNTrJrfAugxAra5pcn6kJ+FqchBm2MtH0x96HkrYzsNeUXWAW8RJdApXBK9JlUpkVvsZecaXb42KC+oUXeiLni2LXkK+bY+vS52i9vck0HmDDBtaQZkbbfVbXx3+yHs+Quw3oodbjuxmbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810225; c=relaxed/simple;
	bh=yAfknsLPmbIWAlI/2afqywxZAGm9moBG7fBTGcS4Lv0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JN475y69pdalJPE6mEFuqN/gztadJV83UhZiGc8eQEKKPT4Sl4qkV3EPGu6flNhCbawuCBFNIKjy7xo1EN/N9s3CCAH3E4MRTH7i1lrgaK66zHYTRh2mtTOmTw+vytALwx5Rt0d+T5kX/gTVmn0LyeBIO+jpgAxzSjx1/I3l+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Z/Gi+CVG; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Z/Gi+CVG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1788810216; x=1789415016; i=markus.elfring@web.de;
	bh=G5TDMFjr1AZfg0U/0W8c9L0N6yU7LustaR6IXwJocH0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Z/Gi+CVGLwwHRV7tcQWc5KrXBT2zjYbQPeuPSxwjr13eLxhOXwba/vCWgTSG8mb3
	 f/baXwnx9cDfYlxwIy1FkfPVvsDWFVFdveby9ROkD/iApntKzbsieC/17cwFX/Q5X
	 wwgxHe9d4+lBxYV5iYgmfDSmVfIHeNqglmlyvoBCZhm/b7l6xANHlt3AFB1C7u2DV
	 VPb53/prgJOP7dToBMVr5m7DF7FHvTanlU57KkTMauX6WSNcH5CubMGKwHptGtRYs
	 apNwK++/G7neYZSBx6+8QKLrMC6E2oEAIWzYEqhyBleROoNS+J+xJjyOTDY2zEF38
	 xMz2QF+UZhvk9R3gLA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav6f-1wRaHM3cbL-00h1k7; Mon, 07
 Sep 2026 21:43:36 +0200
Message-ID: <3a1f99f3-77c7-475c-bc2a-3eb764cfe77b@web.de>
Date: Mon, 7 Sep 2026 21:43:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Breno Leitao <leitao@debian.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Norbert Szetei <norbert@doyensec.com>,
 Paolo Abeni <pabeni@redhat.com>, Qingfang Deng <qingfang.deng@linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Kees Cook <kees@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH net-next] ppp: Use common code in ppp_push()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TKbtzvYZc7PiEIXw/T0rTvXaCeAnCptic93AVFzrv7k9EQBUBa3
 bnz7MXZkRDDQMKQEcmyRuaKEODpYaUTPwn+wZX3swtcQnx0TlPbMKC9i/BTP4eY7hS+f/6A
 LIZFBUTGlstayTxod2ZJkpasAYQh9VX1Eg9RcJuvylTh6YQO/VhD32h1FZm/GvqtzXjPWjj
 Aj3Kt+FipEw+xivC0tRTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wb03N21csQk=;Y6XzlBg9SXI9KDfPYGz7hReEK2f
 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
 UJFzZhXL41YLLTNgx2082x

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 7 Sep 2026 21:32:36 +0200

Use an additional label so that two common statements can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ppp/ppp_generic.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1a610a18893b..6cb1d4cecce9 100644
=2D-- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1908,11 +1908,9 @@ ppp_push(struct ppp *ppp, struct sk_buff *skb)
 	struct channel *pch;
=20
 	list =3D &ppp->channels;
-	if (list_empty(list)) {
+	if (list_empty(list))
 		/* nowhere to send the packet, just drop it */
-		kfree_skb(skb);
-		return 1;
-	}
+		goto free_skb;
=20
 	if ((ppp->flags & SC_MULTILINK) =3D=3D 0) {
 		struct ppp_channel *chan;
@@ -1946,6 +1944,7 @@ ppp_push(struct ppp *ppp, struct sk_buff *skb)
 		return 0;
 #endif /* CONFIG_PPP_MULTILINK */
=20
+free_skb:
 	kfree_skb(skb);
 	return 1;
 }
=2D-=20
2.55.0

