Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15DE3E3DBE
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713135; cv=none; b=AeivcVopLPukduNKfDDNJTjZ10SFgv2JyibXPr7Yf9JUnRWudeg2U/N9zwtSGyLoplhOlwVEJLQMK3g0DfTUGoQgBlquzjWRFv3LnpafNhg3s4qRLthzzqjrqezfKps1BzG1HcosGhll+wKzHnrSdcSjJY/eJQyHV6+t0S3u814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713135; c=relaxed/simple;
	bh=fOYUXFxzMlIrZRNaGySjVStUMYoeSUybT2qH4zkI9vI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=cOxRvq4a1tbNSpmdlP8hZCYHeRjckRTFwJBGEb3o11UdHPJr6uQhzygPMhQ3lg8OyRofOaxAUT0XxEdAyQYt6VDYM9IIXJOksRGyRNoufH4xDAELMm7tRmkQHwcvlCLBM8n5qv4skT8EFqdzn48jLIiRs/4Zz0Hpx34rs9G72Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=b79EDeI1; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="b79EDeI1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1784713130; x=1784972330;
	bh=fOYUXFxzMlIrZRNaGySjVStUMYoeSUybT2qH4zkI9vI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=b79EDeI1iVQVD0uMettFUSe2eZBlbEYPpRGt119OGCLLtyctJKN88zzeOTrbA9hSy
	 AQn4TP2uhNKiGnT5M0CTtgXzh0+m1mj1sbgBab4Wi+BI7/HJV4syzx5xVOHK3OZaMh
	 bKCaj7E3Xz0oB++6xDp6tSgfIU8Y86kenHx3HkwvTctRzap2V7rgK7cz/xaaO1BnGY
	 wtfvfkjGjcnrYnrfqf4EsLnXxF4lIrMYqawc16Pdgc+rMtuM9UVEl0e7aOLYxgoavV
	 YKzB+pNYn8MLs8fkcTwbyQw5mUQ4zdqwTx9rPCrBdV82q0xsDvwhkXpOK5vFxFzs02
	 5uTnxrTi7nzhQ==
Date: Wed, 22 Jul 2026 09:38:43 +0000
To: netdev@vger.kernel.org
From: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net] pppoe: reload header pointer after dev_hard_header()
Message-ID: <20260722093814.3017176-1-manizada@pm.me>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: 4850bf205e36bccdfcd22f210f069b52a6d60b96
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

pppoe_sendmsg() saves a pointer to the PPPoE header before calling
dev_hard_header(). Device header callbacks are allowed to reallocate the
skb head, invalidating pointers into it.

This can happen when a send is blocked in copy_from_user() while the first
non-Ethernet port is added to an empty team device. The team's delegated
GRE header callback then expands the skb head. PPPoE subsequently writes
six bytes through the stale pointer into the freed head.

Reload the PPPoE header through the skb's network-header offset after
device header creation. pskb_expand_head() updates that offset when it
relocates the head.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>
---
 drivers/net/ppp/pppoe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 4a018acb5..6874a1a8e 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -825,6 +825,7 @@ static int pppoe_sendmsg(struct socket *sock, struct ms=
ghdr *m,
 =09dev_hard_header(skb, dev, ETH_P_PPP_SES,
 =09=09=09po->pppoe_pa.remote, NULL, total_len);
=20
+=09ph =3D pppoe_hdr(skb);
 =09memcpy(ph, &hdr, sizeof(struct pppoe_hdr));
=20
 =09ph->length =3D htons(total_len);
--=20
2.53.0

