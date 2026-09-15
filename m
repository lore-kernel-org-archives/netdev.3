Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76243F8DE;
	Tue, 15 Sep 2026 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464206; cv=none; b=adV9UJ4xcgP1wd0V/y0mgaiRZbmDK+ec0m5793+GgchPOJU+3B0ydJ5doMHjod2iil0qW4rMGeqOodbW2pkWp4i/UtqK19loK7jCjsKw7KBOLWO9m/wXDtcOU5lH01z0W0kVHYS1p1KPRJFwiEXfu0Bp7o+NvyO2pk2fq3SBvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464206; c=relaxed/simple;
	bh=TsRXaS9SZYfDbO7W+pCGc7Nt6LwfyKt9qqW8YAiQGQA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nLL4/enBIAfNEVWFdwUAdxGNp9iT3uob0m03Fkh/yYVHQ3V6wG2B6E35hPK7MW2p+HMJNmuwZws6c4t7eX7jk8SJLRpcas1JfU7jztWi6byr2UTftd2HkB5SkpKRnIhCGXenW2HMXeb2Srq1hBDq96N8SMYsitXeCitNX16kqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aUbpdO/a; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aUbpdO/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1789464196; x=1790068996; i=markus.elfring@web.de;
	bh=J9SsepJGlYSye8th6dN3yKVP2gjBVCtwjfWDerILqYM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aUbpdO/aKTkIOd6Vbz4BYac6jmfRWvz3hfKK9SDljX0kNtPoDekXKK6WipgvLaNF
	 9Jrx9mW0haGD7al1uZ/wxgPAW7hyY/c1l8GgUKzEMqsnOXgd3h1Oc4K8z8RFPaMEe
	 7cfzZG0kaMYqbxs7uQzwtZB2F1cxxDMe0WPb82tWvsIAwPBdoivjhO0QxoUnpQM7L
	 XHOpYmKMFFeEl/1xgMEuIUlSrMHZSM+NRHGCtmmo0J8pIyrnR7xanHLYyvYbLG7U5
	 t2BTLWhJzit9IZKc+TD9eRuXf17hKi4YF9DGiTS0Ak2t5mBDCSQ2JdtcDe/xgMpR0
	 gVWw36q3VYWwFvuvog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7elj-1x9RGA3vsz-003Hqp; Tue, 15
 Sep 2026 11:23:16 +0200
Message-ID: <15f151c7-58c8-4116-8a03-e985fd132b0f@web.de>
Date: Tue, 15 Sep 2026 11:23:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Qingfang Deng <qingfang.deng@linux.dev>,
 Tom Parkin <tparkin@katalix.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Kees Cook <kees@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v2 net-next] ppp_synctty: Use common error handling code in
 ppp_sync_txmunge()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rrk3iWXrhJYEH/uxx8Dcqu0F9y4Jwap4VUU0PwCRGfhuPqS+2nh
 DkSmxdgaQTHAMGH3MBD6K2K40nvnIJNdV7BNsjujWHNLuxw8hrIfCdUW8u7uUBtNSrBoNeI
 EWDUp8Fr69yXKq6MGSR57iCt6WCedbiu8OV8XKuqQ2wfdCGlKy+n8OjqYEa8rE4R6xB9u9r
 syhCGrkon0Eh7D5FtuzsQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MFrb/7U7jBQ=;C/Z2u4k/toe88RtLz4zVf9yMIEr
 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
 wJRT/Qnfmb0nh

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 15 Sep 2026 10:48:11 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
The application of a known source code transformation pattern could be rep=
eated
after the commit 8aaeb56aff2a557a88f83ae866da2c91ad247e59 ("ppp_synctty:
ensure a writeable skb header") was integrated.

 drivers/net/ppp/ppp_synctty.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index ebd62a7ab54b..9e440e110e9f 100644
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
@@ -455,10 +454,9 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *=
skb)
=20
 	/* prepend address/control fields if necessary */
 	if ((ap->flags & SC_COMP_AC) =3D=3D 0 || islcp) {
-		if (skb_cow_head(skb, 2)) {
-			kfree_skb(skb);
-			return NULL;
-		}
+		if (skb_cow_head(skb, 2))
+			goto free_skb;
+
 		skb_push(skb,2);
 		skb->data[0] =3D PPP_ALLSTATIONS;
 		skb->data[1] =3D PPP_UI;
@@ -470,6 +468,10 @@ ppp_sync_txmunge(struct syncppp *ap, struct sk_buff *=
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

base-commit: 8aaeb56aff2a557a88f83ae866da2c91ad247e59
=2D-=20
2.55.0

