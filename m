Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D633D6F9
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787390123; cv=none; b=h3m0EWPd292GKmHDad2dEhK53j5KrlUsu5zvLLr+1g3C6eN+yJ1Sc0ROJgHDNtGUfbhMP3HOGWjQFVzHTX3GX1C/0QQM/EcfMy8qz891sSUIPn4jtpHZtdGhLg1shWr/EbzxzRSSLMjDBDehp0/yRpMKa/D5AbaDIpVynHvcTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787390123; c=relaxed/simple;
	bh=ppRIomUQhBNFC3z0nFKkGR0Lp8EWpbYgo5TTz3do1Xc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=keRTToI1xj/i9CwLpOGhBJ4R0GDhWGRi5ZJ855s2711GzcMs8O87SiLVhvCFKp9vfiJKDtRlIEjG5XydYcZQfXztTyOE4Ub3ilzKyGn1hQ79un9KtLKGL9fEDvVV159jbMqZkIK0aJ8Xu1KnsLu/JAsxdtrSUdIPeZ6Smj4q7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=Ncr+v2Fw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="Ncr+v2Fw"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso3374918a12.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787390120; x=1787994920; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e2WiQ+y65OMTsDA3Cve1BDKJD3PESaPf/ssJwSf9IjM=;
        b=Ncr+v2FwZhJzshJsmMbQm8xlfSRab8PWPD6rocWDegFdcf7+f88YmLdO03ZAue88nn
         tGCZqe49lEquZUdNaKVOSz1BaNH6L1b4p9oeBqAykZGjn2cmy1WwQpdoyqk1aLGOO438
         t52U2Ju/TtPmFxkMhsRvglEHfXF6lIKk7y48zR3qd9pqWD7gogpTHYXXWryQn/CuZnbe
         k3eSAIsFEA/6qagSPJNA3UGyPTzELbUTjXrltZ+gaCuf4JJJ1XFid9TzipchJ4IIFAB2
         Anqt6GSypa9xwK2Lwg1vepWBA7A/nQgwK3BV9t8O0wxHr1JrOMPudk9Fydd/QS+WVI+5
         AbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787390120; x=1787994920;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e2WiQ+y65OMTsDA3Cve1BDKJD3PESaPf/ssJwSf9IjM=;
        b=mEZfsd7ECA45GQms1IOUqQvBXyONYTghRGs6u+RkmAg317JY6SXWibNIoeHoYs7KRd
         mljVT0a7DaWZ7827oSjPc/Jx8sepF/iQRFfMN9xK8DvSEIybZ1IlFPMCR9HWGRY3NUjd
         YD6HS5omXNFfjBJwX3Bwc/NXYMz30g9pMJ2ggOsVRAW/F5brpdzlhlN357wTEvl0/UjW
         ueVhSlEs6OJai96sjGVCTt0hHXsFY0Cxq4CObS3c8Ja7bujhXHJ6Bd37+QuqIKmO9/X4
         lqAVDXJ2YSONMERv52TwSzHqakw4BYYm4QW0y7GBGIsgZUKFx7prRovsXVYy4GprUm3/
         Hl0A==
X-Gm-Message-State: AFuF++mlj9Wwe2aK+ZGjkLQGi9iM9CG2ar3j+8hyugmCCpVqR5YnQSFq
	yrDJzXc8Hs3w9+ejLMAqMVE5jJwDebXMSpGHpjUddLzQLB7PN6yisaLZOWOn0VcUmVB70nlxKui
	I4Xavt25i2A==
X-Gm-Gg: AR+sD11RZNmKQxRBs3JDZ7ZHiOFy+FQbKmgBJlvCaKHbcyeD5+/kb9pgIM2a+433wBz
	uPk2B5waUzYxFxK5jmefI3OIY78Kpb5Na5ixzhOwaUr4kq8jHX+Il+TQdnB8QLGArXtZrjRrUOV
	Qs2OcZ8rhIgCzTqawE2kLdNL4BWE8FDAe9m0JjQsXS6xcfpJeYxFrAf9YSCOmL5oHXe+xW7XPjJ
	S0U0FhCtL0FHK5SWZ1/N3Jb46onk2REiLNVAJL9JonFbACoScH5+QzigB/ag9ocGm3QUwlWPwSe
	Grg1nfSMLJH7+Nes514u44zu7wfjooZQbrFUHad2rJ+Mm0MRCXaFp2uUySbZ5D8MgTZlYu0Zhrs
	GXuV3oiwxiBA9f/edsf1MoUqxLeUbMhG9n+YmRc1dL1PLxmjkeWxIEHv6IFVcHlTkYA0IbgiWE8
	lXFUdeK5B3eB1a9+fOcaJ1tHMAsV/3trXw+9lCW6zfrJWmcjc2sKsTa99vMDyfPZ8czKovZBMFO
	eFU2agyvAH4pEq5V6KIe7B0Sy6XeNJxxgY3u0CqskwEAPv6AGNM2mTRsPz7mJKHUgvfH/sUYPcV
	rVPVLxSwOHEkRd463wCjcGqop54=
X-Received: by 2002:a05:6402:354c:b0:6a1:b0b:bc2 with SMTP id 4fb4d7f45d1cf-6a582b7daedmr5038325a12.10.1787390120108;
        Sat, 22 Aug 2026 02:15:20 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff177b1esm11330272a12.29.2026.08.22.02.15.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Aug 2026 02:15:19 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net v4 3/3] net: skbuff: don't touch shared zerocopy state in
 skb_tx_error()
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <4B5CCA6E-2C49-4F86-8C4E-E1BE15C16C0A@doyensec.com>
Date: Sat, 22 Aug 2026 11:15:08 +0200
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Willem de Bruijn <willemb@google.com>,
 linux-kernel@vger.kernel.org,
 dev@openvswitch.org,
 Jongmin Jang <payload.jang@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <CFAB292A-674B-4C14-BB2C-BB8830AD5659@doyensec.com>
References: <4B5CCA6E-2C49-4F86-8C4E-E1BE15C16C0A@doyensec.com>
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

Fixes: 25121173f7b1 ("skb: api to report errors for zero copy skbs")
Cc: stable@vger.kernel.org
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Tested-by: Jongmin Jang <payload.jang@gmail.com>
---
 net/core/skbuff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab3d161247b9..b9541329f1a7 100644
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
-- 
2.55.0

