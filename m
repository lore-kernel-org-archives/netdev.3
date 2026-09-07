Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77951D53E;
	Mon,  7 Sep 2026 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799277; cv=none; b=YiV9JvVgrhBwjWa+H1UWiZhl/9nr1wN6PAgDkI/02fJiDRMDPAs+S6Tw9uKKVbHYoE3/Io3N09xykwQ0GhADjZ66g91+7B3WX0WevV0PRHsSa52XhgjtvVgAK/1rfsJUBf3YhhM6iJnJtHyA+UjrjrZA3+eEfz8RhTVpQFXeuVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799277; c=relaxed/simple;
	bh=UoHpBG1EmiVOdhPb7J5x4J8jWfDcKghXrYJFoY9WAgM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XCly/NwLMjKSv+tOpLpGy6knLP57mbsDhTodaBrwGam7SKcWSifwsqzYGbJRIegX40N1xtUU0fv3Z2KmC1C0rKV6Cko4j/eRMs3VB5d3ZCIb4vH0rUPH9ZO3cxJlCbC5nLWqfF0bxmMdq9/2ZEAFW1Dte5EnFjf8B139XNx8+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Nw0/It/B; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Nw0/It/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1788799251; x=1789404051; i=markus.elfring@web.de;
	bh=0SQbeAtBHCXSvzvI+7XtdJpZusyVk0HByoa0f/HvdWI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Nw0/It/BUDhAGsqtCIPv/27YwQqzwUP9y/gxwawmYViYOaFa5AaIlhJSO4yKdGSe
	 fpmdiMPtRTb4Wd8IGfHPd+epLb/OgS7TWbLh7X53hU694N/7jUpaez8e3LMG9kCAX
	 /F33y9H4J3l6IsLf+7FmndDFAZ2sHTtgX1lci74nvmCYOmcSE91Gvdr+QrTUYm8lr
	 p/6dAJppCPMBzcvAeyHWaHwP5QZ83H6PvTchjxlVtoVUXe3sSTEZm2olk4Njr14cv
	 k9SuvEyI5ikXiQjW+QxRBhAXh5DzrHFJs914r6lvnpVFgCoxsUw4yNTjU3GvwyeUp
	 RuulDpaJ6fppsirT+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUxo-1xCukP10tK-00Jzga; Mon, 07
 Sep 2026 18:40:51 +0200
Message-ID: <1d943bf2-d027-41aa-82db-b2f0807a5e7c@web.de>
Date: Mon, 7 Sep 2026 18:40:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Qingfang Deng <qingfang.deng@linux.dev>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, Kees Cook <kees@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH net-next] ppp: ppp_synctty: Use common error handling code in
 ppp_sync_txmunge()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:enCcluioTiH2b1AfkhUd+DW9gZ3AmY7niQrH1IWLpOTE+X/Y2Pk
 Kn3muNA4iP0mg7FwMUU2ybvntuAwQN4FuV2w5i/H4+OvNwfucGKomIw/QaJjQ6gZ9T/6/Wg
 UYAI7pJ9m5DNJWMkkoEBR35z216/E+COY7nfo+h6+0hCBreq/CKJVKLxgKXHMDYGP6QRh3a
 33KBpCXgCG/FYXqZbZ1Lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zgnCXVVaZkw=;dMGCy1t9Gljw4TNk3yKNYMuYAP9
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 7 Sep 2026 18:24:38 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ppp/ppp_synctty.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index f87d43faeeab..270e0aae90a2 100644
=2D-- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -436,10 +436,9 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *=
skb)
 	int islcp;
=20
 	/* Ensure we can safely access protocol field and LCP code */
-	if (!pskb_may_pull(skb, 3)) {
-		kfree_skb(skb);
-		return NULL;
-	}
+	if (!pskb_may_pull(skb, 3))
+		goto free_skb;
+
 	data  =3D skb->data;
 	proto =3D get_unaligned_be16(data);
=20
@@ -457,10 +456,10 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff =
*skb)
 	if ((ap->flags & SC_COMP_AC) =3D=3D 0 || islcp) {
 		if (skb_headroom(skb) < 2) {
 			struct sk_buff *npkt =3D dev_alloc_skb(skb->len + 2);
-			if (npkt =3D=3D NULL) {
-				kfree_skb(skb);
-				return NULL;
-			}
+
+			if (!npkt)
+				goto free_skb;
+
 			skb_reserve(npkt,2);
 			skb_copy_from_linear_data(skb,
 				      skb_put(npkt, skb->len), skb->len);
@@ -478,6 +477,10 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *=
skb)
 		ppp_print_buffer ("send buffer", skb->data, skb->len);
=20
 	return skb;
+
+free_skb:
+	kfree_skb(skb);
+	return NULL;
 }
=20
 /*
=2D-=20
2.55.0

