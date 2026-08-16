Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF375396B9A
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786863443; cv=none; b=fD7FVwEMgs9B7yWHdIhOlfHYqVEmpOdrwygA7N2IUky/Afbn3D4FurVu3/9s2JiHHfnuCq+MzV4xaR/nXW+Cgf41zvkJEtcj4GIJCLelhPLPwkxezQTl4SVylFibl2PN6LxBFlrtJl0EaPbudT8JkfRTrfJKhsaqDuqYqaonQ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786863443; c=relaxed/simple;
	bh=53qYBlGV55O0oPM6z/iZlmjChX5cBKr1By2eAdAIGzk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=l4RbaCqXJyf/hwKak0ZDAdhFgOomUviGLG/EIOl16ntBDUj9g0W+WzJWlkFfVXKOTt/z2+DvJ7koLOx1oXe7hi1OATw27k88AZbGXSnfl2fvRAdpPk09hf9mMSCReAPVxJsrRWSd8ZrfCTPT/WvR9HrUnx/wORvwFk+mkeG2uqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=HvSzcjwg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="HvSzcjwg"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1265250f8f.0
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 23:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1786863440; x=1787468240; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t7w6rC55cE4ciQbglNZx5NJEoEU8z/3RqBJj8wCuTBw=;
        b=HvSzcjwgHv+7tKidMzhwWOH/T58GSVTBlCC373z9G8KORGpn7LNcRQududUPry9Ljy
         KtHTLZ/6lyQLuSddFMO8Qr33WUtCLW+iD5KP3ezi78BikMYb5N/2g+VqEyhujg9j8ZHl
         B9uk1L1C8wHcQlwvjR3wXEs2l8jp9VxjVWmwX2agWo3QXc/wbr8ZUYTBcsheSFVrSUmF
         cHuTcRiBnOOkSwCq5H2uuM14X/cn3xWeXRV0Z3UFkXfLgxTwmZapXtFwNOmMWk+TBgF7
         flbFfi/HXLjR2/RECo1xCzyDhOHlPMab9SlSOBqax7eVCOnyS4Ir8fz1fZw9VfiGU7ip
         pyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786863440; x=1787468240;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7w6rC55cE4ciQbglNZx5NJEoEU8z/3RqBJj8wCuTBw=;
        b=Gt+qsEWBoOFD5thH+nWqbpHzksZUFnAE00zsrw5a662DiCl/+y42i2O7CIIuMGq0aO
         Enk77BEsKjj4HlnAysTy3ot8DCC8R+lDBeiLXm7ma9xzgRZZcWQScoGpkHl9GvFRuVrc
         p6/TKBQSD7Wy23lzbo7dCQmzjBIitqeU3ngLQRhJ6bi9R5twYU7L2kSkfK+Lt8iFh4tO
         P0WqWTmdxIkepr1rden4lINnCqD2Lx5fp3+5J6fqgFf1r2LZw7jkKoRHlAsKPocJNOpl
         nyfEeatjZ+ujeo7CJsgxnAIzbwnD/Z5408U09pSs9f/CeQX5y9N8hTb5mf/nZzR7U9Rm
         xQAg==
X-Gm-Message-State: AOJu0YxPFvp7EyVcS+Ek5UIjIRlzeJHbHFuOPoFnVkramWe/b8ISgofw
	i7W0f+E9zz36g6L0Q7lnf/TwRym0UFQRdXzfBoMlBJeOidbRu2TDBhdqa7d2jcdM4TPXrsyXASi
	nhI82WMQNZw==
X-Gm-Gg: AR+sD12IDnsZgauP9UfuZGIZmDTEs0I1UuFk79ThUpmVkd0RU4V1rJPWjZpeM6n5s8I
	mBFuNNZHERdMHmdi0v7W7pL66JUllULHNofllAECO8NX0Qwh9GBSq5CGmYbX6GIwMlwLQG4iZUf
	weDTsuFgNSmw+GspyHHLH6Bn9KWMdgYS49qz0jgnGveRUfbHcvAO81uGnGUtLbqNBjVGUpI5BbF
	T404IxNUoW63FCNFXhC2nJywzhNtXod/Coq1V+PYPGjg7XWKC+emupnCGBwJPBMSLJ1t5mrPqMU
	uE1aVlJQvH70hwkhF8QARHXejgt8L15kWK0VwzvIDxHM7hORxozYPyuTWJjKEmWP7WDqmZ/MYQz
	llX3t/fhRWszDzq4/kOqWI++bs8XforMK4pzVN0QK0aJonPdWZ2K8+L59BZAJ9z+bGiFcil+jJM
	OHl5FQeAl9R3yr7EDrEGL4PAC/pysZ5bJgb8iPMj1oucTsXf4qii2EUH1hTi2j/7ij5sxdHK7+Q
	z3wC5u6mYFO1VKh5kDENjDkZIlGKTwRq7q1q+jW0AlYg1KipsEMIT+cVAP715V2cJ1MgGjM6A0p
	ZkwrZ7yaIE4mAeQ7DGnagnO11g7SG/fuAA==
X-Received: by 2002:a05:6000:240c:b0:47f:80d1:be0a with SMTP id ffacd0b85a97d-4816074889bmr21131883f8f.14.1786863440038;
        Sat, 15 Aug 2026 23:57:20 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2b1a91sm21297727f8f.21.2026.08.15.23.57.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2026 23:57:18 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net v2 3/3] net: skbuff: don't touch shared zerocopy state in
 skb_tx_error()
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <AD1B7BEE-C04C-4A1B-982C-8385F1908911@doyensec.com>
Date: Sun, 16 Aug 2026 08:57:07 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 linux-kernel@vger.kernel.org,
 dev@openvswitch.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F34B6E46-6B01-4106-A1DF-1BB9E29320BB@doyensec.com>
References: <AD1B7BEE-C04C-4A1B-982C-8385F1908911@doyensec.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

skb_tx_error() completes the zerocopy uarg and clears
SKBFL_ALL_ZEROCOPY, and skb_zcopy_downgrade_managed() clears
SKBFL_MANAGED_FRAG_REFS. Both live in skb_shinfo(), which every clone
shares, while the caller only owns the reference it is about to drop.
Through a clone it tells the producer its pages are free and drops
SKBFL_SHARED_FRAG for an skb that is still in flight.

Open vSwitch reaches this with a non-last OVS_ACTION_ATTR_RECIRC:
clone_execute() sends a skb_clone() into ovs_dp_process_packet() while
do_execute_actions() keeps forwarding the original, and skb_clone()
does not privatise the frags here -- skb_orphan_frags() returns early
on SKBFL_DONT_ORPHAN. A flow miss on the clone then strips the marker
from the packet still being forwarded, and a later local ESP delivery
decrypts in place over frags it does not own privately.

Skip it for a cloned skb. Nothing is lost: skb_release_data() clears
the zerocopy state once the last reference to the shared data goes.

Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in =
skb_zerocopy and handle errors")
Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb =
frags")
Cc: stable@vger.kernel.org
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
 net/core/skbuff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index db62ed6e04b9..04776a112334 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1417,10 +1417,13 @@ EXPORT_SYMBOL(skb_dump);
  *
  *	Report xmit error if a device callback is tracking this skb.
  *	skb must be freed afterwards.
+ *
+ *	Does nothing for a cloned skb: the zerocopy state lives in
+ *	skb_shinfo(), which the clones share.
  */
 void skb_tx_error(struct sk_buff *skb)
 {
-	if (skb) {
+	if (skb && !skb_cloned(skb)) {
 		skb_zcopy_downgrade_managed(skb);
 		skb_zcopy_clear(skb, true);
 	}
--=20
2.55.0

