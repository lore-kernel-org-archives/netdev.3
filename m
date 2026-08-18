Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF243B6CF
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042876; cv=none; b=uuIHeA88TvOySJ2otAHZM8lkCCLPwtmmEIonRYzhJB/V4gIEDea1+mapsunbICfYgOZSqiYl7tF6Itrc30zLavbiGZLTa3c4zUp6TtmgGfjcFaSoW/9/+vs7QeMsEiZrPeJ2TwUe9qyhbEg51QgnkUZb3l6z1ngAOud+AQhL+1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042876; c=relaxed/simple;
	bh=jq44illgW0PY8H3areDJs61Qx3jgTr2nLguNWng4mwE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EF3/WhDWYvAq/ulHL8AoLU8iesqAm1cItZ06F8kqUWpWla0BdgGLDVH11PxbpfV61D4A6EKKder3l8S8YmlDgaFyQfqME0q9CTdSuk7i7NylIrdaj7sxcehWcRtsHot+6RTL3pkJ7iBuwkm7M6zM3nXcRKNbSPd2icUbh8E4mPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=fK+K7cYI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="fK+K7cYI"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-481412f1828so1445784f8f.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787042870; x=1787647670; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1F67UUCLxuWMVKHEvlzFMLbN/5jPWi3pvGWjATgGVJA=;
        b=fK+K7cYIVx78gsFO1lWSOchujkMtohupSSGzDi3C2Sl/vFTBx4yC0j08NjV+si3guB
         6XoudAnNxIc6AnfiIcWeLPq8EDbO7Ytr8jqrdV1yFb4flZBoZOJZH1PG9cQE6dgcTBHp
         JkRHPlKZhbTiOrX7nVl/2iwJKWwxGaZhXQbTV/SHwKHEm2FlBWbyRcPSl6ZVsPJsRkj/
         r5uc/JiXvOYyUjH6FRWPmZOcBov+zqFUlQbhgAEH1NH5WglZH31TgMqOwRa5ETiwDV85
         YmCJB3Mlvx2/6HvRWnt5RtzWJ4ewXa6XC+K8iVhvoee1MGihiU//hrNBDV4oNvlUPHY8
         PtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787042870; x=1787647670;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1F67UUCLxuWMVKHEvlzFMLbN/5jPWi3pvGWjATgGVJA=;
        b=YrY2mtQav8rXWaL4xZOGSRkQoMniaY0GuEAjeZvrGSVEGYIcr+jVMhogyAnolXvsF0
         vUtKH3sSZITRul8l53C16P3Rp6pD12m3HEi9cZ3DnK3ccEMbwppFkGqog4ytoWs9jp4g
         SCoeebmT83wFhrQ0QNrzue34Y0bcTbYfXmBOZV54enx2vmpm3v1xL9725D6y1Ii+M9Pa
         LIRCzek4lz/bdyH2a4ctBGV++bWowq+4o4hPdcIsOmQvNTxs6i0Qrd5RrDIi3Cj8W6GB
         md1mtNKDvb/Aw9OWOKfe2HiSt8wR5d7XRQ88QLwgGEsxBaPY7zbIL0doAQnjM6WLmfgt
         ro8A==
X-Gm-Message-State: AOJu0YxOXNw+nsv93IqFetJQ+jxXuZfzdCx7rriqP3kM520viezac20T
	jFXoMqJ2JaQGVrOQm1WzSvA4csufnAAn+0froje6sKiETkzsnMG8koiS3R+OhCCnG047Qv3DWnX
	y/0vVokxwHw==
X-Gm-Gg: AR+sD121u7TnTytmrZPO/tThnQbFZY85i6k19lcqiiEPyzPnWZlufvzx6ENynV1qxrg
	cwETzkmuUVvMy6DP5e3tz8SfSVjHU28LTocs6MOCH7jtMD3PXaZlKtmQaKqDI7Uc3AeZljS45Lx
	Ix8vd6Y6VgZHqr8eVFJ7peNtI6RLKorSKKdQ3HU40y3799BDS1ME+4Knt0LreLjvbWotvkFih+J
	7pfF/1dU67MEtZxuKHhYiBPWitdsv/oFkPrSaQCGd9M/ZhLgZC2Nla3+vhM5q7iDM6Y2m9RWIs4
	T6xsN+NQ1Tkze3CszYaX7OtW3NFfTrAEO/jmgi8zQSxO6wKq2eE0Xu9RbuMCoT9cTPgReU+R3X5
	O82EMIwDcPxTypyTsuG7ihJKtdYaJVIhzO9JPxRvQSu3qtQp+t14qAKOpnm8j4jSfnlG6j1fG3+
	oKqzuUXIvevkTtEXYXHfLTvxYbIgx3DC6sDSdijwfj7zv3LtNdIh9teom3BKUQ6z7DZf8fISgTd
	YBHTtRG/cBvUJf0mxDb9VZgcbuuEsO6GKTJ2JjwEYSMDNPOo2CcIOVONza6DM5GPWRVUxLyqml1
	/lt5JS88I0Ha8l0SyZvJVQ==
X-Received: by 2002:a05:600c:4e56:b0:499:a69d:e14b with SMTP id 5b1f17b1804b1-499a69de2fbmr11541395e9.4.1787042870069;
        Tue, 18 Aug 2026 01:47:50 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d078517sm103942915e9.5.2026.08.18.01.47.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2026 01:47:49 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net v3 3/3] net: skbuff: don't touch shared zerocopy state in
 skb_tx_error()
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
Date: Tue, 18 Aug 2026 10:47:37 +0200
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
 linux-kernel@vger.kernel.org,
 dev@openvswitch.org,
 Jongmin Jang <payload.jang@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <45B00A1C-A331-4982-8317-592EEA59426A@doyensec.com>
References: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
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
Tested-by: Jongmin Jang <payload.jang@gmail.com>
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
-- 
2.55.0

