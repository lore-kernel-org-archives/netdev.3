Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3A42464B
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787042723; cv=none; b=uO6AQcoaAwWAvpEtTB1gxdkC3ZnkyUsXwXtsifVbYHbLGdOE8aJmota3hgZ5xKXmJXXzdxgXClZHkuWhLtCp9pB8f7Wb1U4LpDppIsoC+almYkDMeSTcVU08rgzYg3uE76oyxvPX425gwsqwGqN5syHwLoPJBRSFlxg2rrR05S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787042723; c=relaxed/simple;
	bh=1Hak+sK1AObHRlfR/O9TAETWPHGKoELjxohYzABOdLc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kCVMP/nlX6bPmS8pralYllsKKTXxhqgcou9AxBboBWseRePvH7Ojp5hk3YaOCCpy6jsl4PuozfZOUkB3qhOBcxqgzvovhBoCHL2gijOo3RKV/IaEdkkDpaGj4Hl3c/k4LLKdnFkDA9XdxbpF9YxWOjCeICrg9WyH5f11DctqZ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=TATUfMV6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="TATUfMV6"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so53926705e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 01:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1787042718; x=1787647518; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mRqu1Yx5HorjqSemdAiIQulC/QDv6fmNzSHtkTVqTB4=;
        b=TATUfMV60VcCrllqYNWQNUpHmWWNj2ESP5Sroym/wpZBLZpFZmuSm/dhT3KVAjhQS2
         ucYQKqPTTqKsjeWeRj9S4ITs9hrgQmkr1loatoaCyTw/jfehnQJatF/mOjQ0wbkgfsSD
         a69Xod6ITCeM2ve46OVcjioHB3Qqe83iaHFmb3bDu9qxmG2iHyU4wihxZufsMBkxeC+L
         AZpKLtbAMTfo+p/PlSv9iz22N+X6uWY8sNE1tUb3deZbm5CBqWl8FMkFszxz323elIyJ
         LnUS94I8DV8HTbtwzIBV5lcWgDuiWg9/rhf0wya+xLi1cj/dFYHOtB2ox+urLYuEAPSO
         0s7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787042718; x=1787647518;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mRqu1Yx5HorjqSemdAiIQulC/QDv6fmNzSHtkTVqTB4=;
        b=p1OQ1v33YtlRJtLZ7/OEUTDUYS1rMns65ADkSGejprYC3dNj6fG+AJ+5e8t0uy9D6A
         SMvcuWgu/XHXu7XVFUpXeIRLIiS1aCRSm3ZyyENFeC7fvGBqzezbGjKEdjexRaGVMkPi
         nscSAdZ2hxzO31UE+XHC6xciPKHopyEOcBh+AQ3KznqDeN8QoSMU3wafcFRKN4joXr8r
         sAnaOyY681uYx4rpWLXN2LDwFMy2rygs7D1SxwHgVE6nOrkLDtuawnK4Pm3G9OrFtZqk
         mOKe0gXrF5tVD5Hd6JGs7aLhjkzf0f4WxO2coSzyEuVI0BZWRouqQshu4zY1nk6nrD6k
         vZ0g==
X-Gm-Message-State: AOJu0YwzawO7zW8/gS7aUi5ub2UC02eXKGrLiT+jAS28KHzd3u/njVd+
	cQCybBX+7agzvMjuNh/ZtNEAI+mQkQ7rqbSzxbxXO0Yyjsi5egeZ0X7lXHm2NHhjEPPg2ZIxIjk
	guUVK1dWMMA==
X-Gm-Gg: AR+sD10kVSWlyERsZaL7HsjiogvQJs4ryoJJll2at5ZvyNB48zcRZ5eYvUBza6U+q0e
	rNsZ0l5W8RtnyIPNNcyVr1O1jlqZ2UnBUZxccla9Lgfqeq+G+xDSkdPajOyaYG23/65DHXGCsZE
	aRgR2uWaj6ogNY0SfESp+xo3QVwpWojrN7zBfE3+X6u2OcqPwKbwourwhD5lTGJSk7krRNFpCY/
	Zpbc90tzartcOHyxuKwOUHMaYGEUWYCcWZNpsgMQe3fzdokmfbajjujPaNZrs/mehC0Y4MEjUJA
	LB72wJARQvkKsn++8h8EFmjBHkvfrqU6aqUhA4j9TPYp81JMDyF1tF0Qvqbk7dYbhSvBHiH630V
	E6WrHePdZmj+xNQ6VO+z2D+AOnHuhqCTl2j/2sg0DGJgHBpOBEOBFoGTXUike3NjZMnsCzdN52b
	7HwYPwtubPk3/DztSG4Dx/xRhot08UocuRuVXuGjT4kBSO/GLpT69668F3DqHi5gzBA7l0NRDN7
	MM04HJ6GSVR4HLaQZOud+hE1rZZdOtNfH1JO1k/J6ZELBgzfPCVMAUr+AWtND4ciraLR+Xl7j05
	LKZnZhCe8i0ICSBwc16UKA==
X-Received: by 2002:a05:600c:34d1:b0:499:83f1:398 with SMTP id 5b1f17b1804b1-4999fb6d598mr111856735e9.9.1787042717752;
        Tue, 18 Aug 2026 01:45:17 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996188217sm512122605e9.13.2026.08.18.01.45.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2026 01:45:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net v3 1/3] openvswitch: only skb_tx_error() a packet we are
 about to drop
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
Date: Tue, 18 Aug 2026 10:45:05 +0200
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <5C0BEBF6-AF95-4045-8ED4-C6081C51E40B@doyensec.com>
References: <F3B9E5BA-0AC1-4AD1-A7D9-F38033304270@doyensec.com>
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
index ae69b2cabab9..fff75c3eed11 100644
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
@@ -601,8 +602,6 @@ static int queue_userspace_packet(struct datapath =
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

