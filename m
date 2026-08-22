Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB80A36B910
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787390044; cv=none; b=R47xIYqqJjXIMeYLlb1E04nPZsvyjQGDVx6WhnNXKnKW/af4DHJ2X0D4PkOGNZXPiZXqFe6qGDs06Z94BzanLPR1ddkGBa4zj7NCUQSwcwb69FcglJAT2gOs2AkX7m1lciwKcbXymR2HfJQZ1Y6Yc4iSWP1C4y3358b2EnwW7/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787390044; c=relaxed/simple;
	bh=YGQckMbqnllO9cEfuF+Zcd1aPYYBxFpLUZxJ3rmbmKE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fOC0mhnEsqeG8mkTtvo1tTy8kg5HwHtJXLxtziEuEa5f5Hql+JvUpjVuyq1dPHvkBd1wFja6UpZbsEdTYt3kbtfzdWmzUeS6Lw5p/9EjCUvxGIUdQ7bSDhDr/Ioo/RmtnRISNLvxJXGo7YDoJH4iU/usiv8pGTQ8bB0mxA8KWls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=WKsdCzsD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="WKsdCzsD"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so209035266b.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 02:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787390040; x=1787994840; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=syWMrXd3oOZ7WIz9yPYxecNXYsjgH/7HiK2KDpGXAks=;
        b=WKsdCzsD+lxlKTtc9t9c6GC2Ou312UX6tPe3J5ZTgMQGEevB1KUMjZgy+Vskywmwss
         lJl4CZpixQSAnuDEKUtzrpJ6aQ0H1dNTO0w6DJGWvWNuf/oVHrylDz4aUYPq7y+MO3Cv
         1RWWb1fYU2i8+FrCULOwn9ifJE/rmcnQMeVe+7cWdHrDHldOg3qUFhjMlaHoxQSZATEL
         ixSou0eTTik6Yv6enZrcQINWV1RTBJIV3XCAfU+krRkCK6rNSeP5j1F+YdJLdXXEc0UI
         69Ey81ZsRT7uEcX6F4WuknB61u86qHgbIH5gOU4oTcrXeU1oq/M3uR+/wty4gBRi0d4w
         Hreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787390040; x=1787994840;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=syWMrXd3oOZ7WIz9yPYxecNXYsjgH/7HiK2KDpGXAks=;
        b=YbrxlpxjYzI2R61VeugOskE3sxbY2vW6zn/ngaMZt/SES9eZP9Krq8u19d1yjAXGD0
         f8gl/iMZk+QxOzX0wdRcJ/HV652H0gLVNouCrwhb5N1mB5/YCUFxlAi+johYArznMC5h
         lX7MH1LZY7L9vAsRLJbHszy2RdH1abIe0UriR0+zJmEQh0+KJGSHMJ68Q7jJOEk8wYoV
         VDum7EMsBzNrWmPjyTjo+ikqA+d/g0U6Wh+5ueB4iIZZ64fPBO+WqDBiy0uAg321pziN
         9v5qncNV7d7yYIxq0GqUgWryALNKnhjVgnTDmI0QLysZGi/FPg3u1kCISld/6xZCHvU3
         9f6Q==
X-Gm-Message-State: AFuF++mrOJRFORMH22X++i4xEKstQ5VhYYJlHIbDhAeASWDkPL6XTFUI
	boJO34iEcffxI1vxwlmqHe1seWCTWmlmu8tZxi2l5FQrFU5JZCsPbhcSLoo5hNiljRvVpoGsuSh
	ke5Jd/mUKLQ==
X-Gm-Gg: AR+sD105FzKI4DAaCSyFKNLOUkq4Uz6eL9+Gxy4cCfbbYXic6Ymsw9pNJ62VpSZcbC+
	vksVQA49svI08PxD+DX1ZlohqNAJ4g8nW2vodKY1ICK3L4hCqCLAjiaRIwdoemyXJsOngKylLTz
	5ne77fKRrEf/84EC5jx7nmfTiXpLeVGPbLpvhIljUYY7ewwbQ7uWsTicg1+dys8vja1k8/hC6DO
	jk6WMeZ8112mrBtfFVSB3B8KaVGjj0cKvdJQVWiS2Yv5snQfAXbNfCzlEiOQuOvnVlmKlisV54H
	RBLlvhZ8K0B3hwgWXSkAdEs+QboFjZ9oNIUy6yMTckDnp5YUa1yFICLjvgscKTNIwDYh/kGaJhx
	gBIbRRJ7XdJBThIxqQYHqsO5yWhP3vJZOKxPJkU0kmOge6LDq2RQeAY/sFr65xFlcbDxT74X9gX
	ea9cQOpN4e9t8s+SZfd5OqxqfLx+ZhxgT+bCSibMZw+E7oDEU2FqrHZnbgu6bCpBhQosX3SiQgi
	IB3q0CPvxA0N2lLVj8b1M+5xRJpt6AlL+ZH9dXxWMD4nbS2dzbAGt6V5pqOns7djz7vGrdnvrWp
	x/kQzmkQwBpH6XqnJdaZYCA1mlRa
X-Received: by 2002:a17:907:3d0a:b0:c20:83b1:396c with SMTP id a640c23a62f3a-c246a62b68fmr1266504466b.17.1787390039880;
        Sat, 22 Aug 2026 02:13:59 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff1565fesm11013626a12.17.2026.08.22.02.13.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Aug 2026 02:13:58 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net v4 2/3] net: skbuff: don't skb_tx_error() the source skb
 in skb_zerocopy()
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <4B5CCA6E-2C49-4F86-8C4E-E1BE15C16C0A@doyensec.com>
Date: Sat, 22 Aug 2026 11:13:47 +0200
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E3A780D-FB87-421F-9964-B1D457D7D106@doyensec.com>
References: <4B5CCA6E-2C49-4F86-8C4E-E1BE15C16C0A@doyensec.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

skb_zerocopy() copies frags from @from into @to. On an
skb_orphan_frags() failure it calls skb_tx_error(@from), a destructive
operation on the source skb the copy helper does not own. That completes
@from's zerocopy uarg and clears SKBFL_ALL_ZEROCOPY, including the
SKBFL_SHARED_FRAG page-ownership marker.

Both callers already report the failure on their own drop path.
nfnetlink_queue does it at nla_put_failure, and Open vSwitch does it in
the flow-miss drop arm of ovs_dp_process_packet(), so nothing is lost by
dropping it here.

On Open vSwitch's OVS_ACTION_ATTR_USERSPACE path the skb is not freed on
this error: do_execute_actions() ignores output_userspace()'s return
value and, unless the upcall was the last action, keeps forwarding the
same skb through the flow's remaining actions. The uarg is completed
while that skb is still in flight, telling the producer its buffers are
free, and SKBFL_SHARED_FRAG is cleared on an skb the rest of the stack
still handles. That flag is what makes esp_input() call skb_cow_data()
instead of decrypting in place, so a later local ESP delivery can
decrypt over frags the skb does not own privately.

Leave error reporting to the callers.

Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in =
skb_zerocopy and handle errors")
Cc: stable@vger.kernel.org
Suggested-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
---
 net/core/skbuff.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d4382b68d56e..ab3d161247b9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3914,7 +3914,6 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff =
*from, int len, int hlen)
 	skb_len_add(to, len + plen);
=20
 	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
-		skb_tx_error(from);
 		if (j > 0)
 			put_page(virt_to_head_page(from->head));
 		return -ENOMEM;
--=20
2.55.0

