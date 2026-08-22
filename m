Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1DE36B910
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389947; cv=none; b=JxVWzWzyu0iihdDyfIk1V3Wef8KUcboeMR2AqU5DIIITmYYYsKcDWHxAuzmT0Hn9P9gwDbVpzzaNE/rLiZD7GXc4ifqHqcOB+O+IEHSXrBKLJXxnCGh1HZVtzuOjwXNxXmm4vM0wPgXXHyMlfw7Gkwn+plGkA3cPtcF2unANgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389947; c=relaxed/simple;
	bh=XT5S148/6y5PD2abIdBJGe7naJ1gCbCR2/WdiwBaWPg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NFvtgLIyVxPWndpR2eQYVdxVj64qOSuEhAN4gMZQfW8yPBaRVSvkdSyMbRBwNwfOrUm5b8/H9agZ8nCBOrTpY9tuA0/pV6G9ezTHWH6+4N5M05rzgWvaa7hUqK51IPNriP3QpuS88B+yODksvVN33x2tlc1sIsfur5uNsBo7dRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=iEG0di0y; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="iEG0di0y"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a17cb94b26so3724150a12.3
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 02:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787389944; x=1787994744; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uQFsMzRQ7qJG+O1uCjBI7iyW2F5zaHwuZq7leRaTSoY=;
        b=iEG0di0yoPIKluDXmcb1o0tKC0u8Xe/Gf9JGClCuRdkOeXKx3rVcLnZeaOIiJoPHVA
         Y0K/xUDsI/UeBjz6EDhpksaIk/eBpwXu5TpKzWv+DYu8frS+IeQJGmzGqO+GlhYWFXJt
         t67OaeFiR5q5r/Uxjw/Dl6eQkfP7e+DAY+Jq3u52TPU8nfGL+R2MXQ+2ay5et1sNLzBY
         bU9W8kSZYZPXb7m+ONKSEG+W0MWNm4kKz2oJ4juCS8loUDejgTlbGB+rToxetuZyziwD
         DKCExU/88ffZHQq6TYg7paZxuTGupCTPyYEvbyek60EgEplxgdqIfI15K2VnjeMxcKyi
         7uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787389944; x=1787994744;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uQFsMzRQ7qJG+O1uCjBI7iyW2F5zaHwuZq7leRaTSoY=;
        b=XWZ8cUEn5DZrb2JBHSDINL6jUh6p52v6hL9nn8VteTBa2AhnZCsghePX2mA7re/dUE
         dQtvF9ZcsdO+qVEhqERwsNDTncYzEk9BH9E60TGBJoXgpG7hDsaDRjY1cDevgskDY0Ya
         o84CYdH+uQybZo9Nm4ADxYPlag36oFVxGfk45iwdHYkw/N5KRdNu0jqt6ETKSGcvrMqL
         bCNzFE74xNJ2+o4z+O42UmVEA8GlHdFBGps1OWmZlVn8q9oyYkfjxxlwSZbv/OyOx0ey
         lC6E8lr4NH6/dCaaydXDVAA45zYv6lD4oKpFJiMPt0OtIuzN3EQ+KA5lsEihu+SCKJuA
         mj7w==
X-Gm-Message-State: AFuF++nj3U6dKVPTG9oyJ0hI0AiVjVT/bzZ14/AKCYb5+Seu4DrltlJR
	8Oizugbl14+m2kc9wetwCx1ks++9UW/S/S1coZRrZgF1F0nNwnS/cN2FCSgZj149MLFFkwpBQoj
	D33lHCy2C0A==
X-Gm-Gg: AR+sD11K9nflQd1AmUdUBvaOOo+R8f3m5EBAJOVBrImJlhhTY/FavYTPw2Rzk1X70rS
	oT/4C0h/N3dqFMiiq5KPPpVOmiWHF6sN4ah7MlrzZcLRdgnQtJDblMkPtJCfx2USSi3ORjnwWyf
	sBoEfpkS+0LTupmrY0cVxvkXDhFxaK/AotKTmf9fxcXppAO9E1q5ZSGPyBt0jhWFm7+sjUCKvOQ
	9ScHS5quadvgwRqF4feZ/0zsZHqB7zyqpqPhZCX0VpPCtE2bvNdeiLidf7/cOrLOd21Glyc1RAT
	UmP2nb4zXxCg8VJFpp7KFKQRF5vTO3R2YaJ+nNhn4zRARauh1l88oyEmCtDJUHSf2o2hJk5fUsS
	oOKapqUVpnLJ/9XKAsmP6w9SAxJIRxu/m0iBGwvvzwVcr84TKsicY2h12dm14kwfRPI/U9hIqVF
	G0StfKYbX7nil6+2cQ5ust8UUA/N1s6BZogaCqmNmlmfb+5vnBkamiunOU8WutRdQ8xVczf0pe7
	hegcYal1iYmoDECHAU+OYG59Ww8T43bkmshBzslOth6e0uwdhQEyCwlucSNNYfR2ZhwYPxG5jez
	GjdIKvBz1lo6rcnbMl10dggsuEBF+bh4VamwFA==
X-Received: by 2002:a05:6402:3784:b0:6a0:eb:ae41 with SMTP id 4fb4d7f45d1cf-6a42f2096a5mr14464320a12.10.1787389943816;
        Sat, 22 Aug 2026 02:12:23 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff16c546sm10836738a12.21.2026.08.22.02.12.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Aug 2026 02:12:23 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net v4 1/3] openvswitch: only skb_tx_error() a packet we are
 about to drop
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <4B5CCA6E-2C49-4F86-8C4E-E1BE15C16C0A@doyensec.com>
Date: Sat, 22 Aug 2026 11:12:11 +0200
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
Message-Id: <55A52703-7548-4A55-A9CE-2A37145BDCAD@doyensec.com>
References: <4B5CCA6E-2C49-4F86-8C4E-E1BE15C16C0A@doyensec.com>
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

queue_userspace_packet() borrows the packet skb -- it only copies it =
into
a private netlink message (user_skb) and does not own it; on return
do_execute_actions() keeps forwarding it through the flow's remaining
actions. Its error path nevertheless calls skb_tx_error(skb), which via
skb_zcopy_clear() does skb_shinfo(skb)->flags &=3D ~SKBFL_ALL_ZEROCOPY,
stripping SKBFL_SHARED_FRAG from that live skb (skb_tx_error()'s =
kerneldoc
says "skb must be freed afterwards").

For a MSG_ZEROCOPY skb carrying page-cache frags, SKBFL_SHARED_FRAG is
what makes esp_input() skb_cow_data() before in-place AEAD; once it is
stripped a later local ESP-in-UDP delivery decrypts in place over pages
the sender does not own -- an unprivileged page-cache write (the
"Fragnesia" primitive).
do_execute_actions() ignores output_userspace()'s return value, so any
action after a failed USERSPACE upcall inherits the stripped skb.

Move the skb_tx_error() to the flow-miss drop path - the "default"
branch of ovs_dp_process_packet()'s switch(error), before kfree_skb().

The call has been here since commit 36d5fe6a0007 ("core, nfqueue,
openvswitch: Orphan frags in skb_zerocopy and handle errors") but was
harmless until esp_input() began relying on SKBFL_SHARED_FRAG to gate
in-place decrypt; only then did stripping it on a still-forwarded skb
become a page-cache write primitive.

Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in =
skb_zerocopy and handle errors")
Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb =
frags")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Tested-by: Jongmin Jang <payload.jang@gmail.com>
---
 net/openvswitch/datapath.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index f2d5b5ab38de..2fc9ef6c321f 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -285,6 +285,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, =
struct sw_flow_key *key)
 			consume_skb(skb);
 			break;
 		default:
+			skb_tx_error(skb);
 			kfree_skb(skb);
 			break;
 		}
@@ -604,8 +605,6 @@ static int queue_userspace_packet(struct datapath =
*dp, struct sk_buff *skb,
 	err =3D genlmsg_unicast(ovs_dp_get_net(dp), user_skb, =
upcall_info->portid);
 	user_skb =3D NULL;
 out:
-	if (err)
-		skb_tx_error(skb);
 	consume_skb(user_skb);
 	consume_skb(nskb);
=20
--=20
2.55.0

