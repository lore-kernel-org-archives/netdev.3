Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD63D9050
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786863117; cv=none; b=SfCsAtaE/+loXzXE3dmeKM9fF3sg/UC06Z9Y3WhnWwQ3FhgrK5VHP874Qu8lLDylWDQFa7CFLkKyiUqDvySgHUnN/+Lvk5hFuXBo+90VpxFg4fzfFBI9IF3m3n+XPGj2TX+wxV9pl7W9AyKQpFpgwSpQgxI7RYQkM5yhcqdan4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786863117; c=relaxed/simple;
	bh=srCYszWAcdgznXWtRfGPPvWPK2RnT/DOB9GIiYtsDbw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Slm8Pp9B+i1dIDLH5DgNqN2g0xP/1yTDXWaRBwE6EQmhtld4CjjWjp/nr8Unq4d2UFuC3Y3fS5h+Y9CA5UXBm+sIMuR0TCEBSXKP4W79Jkc2EFnf9KXTYrZ5e06q84aKPkryFJmHtm37tw/eEabFua5OW9ML6ClPFaufEi/EIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=RBv/UoFb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="RBv/UoFb"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495590dde14so30088425e9.0
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 23:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1786863104; x=1787467904; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7376kWLfWmn46Je92wOLnlrU4XOrzSlKYQnPz7TuXoc=;
        b=RBv/UoFbC2+xQq6fwBlbLdKPrbn+jhHlU44VwYFZQGAFMlSvNllTf9RDgH3D+VyzIe
         A8Y6DGMynzv+YMqSK0b1CnJfWXSw6Cuy+TwMjUqz1dIeCZoQXvRJ4ZrfM4mKAUHscrea
         Q1nqjl4d3MO18ynANL3UXNsLUw19O0//YiPQ2Ym5ULZBP+R+ksDTk2Ryezr66RJ/Dyjc
         O+qGVcz6psPlimAhteaXQxjBK73XIwHEX2D3BNccIszZX6okpOujm5W6yMfCg89YAdm2
         hoNzZH1nd8gXt47jA28c8dBtyL7Bxuh5QXapnzoJaT9qV6xsIYYGAzC+gCBxSjZNApau
         RJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786863104; x=1787467904;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7376kWLfWmn46Je92wOLnlrU4XOrzSlKYQnPz7TuXoc=;
        b=qZ221TqlSPJyF40g+qfoph9jlGkHnbwqqGhxO41yKwgvYkP06v6b9ZJj+VpVOI0ewj
         0+4Qzi5Bpe1+raUss8UIAgMnPdh0T/t4ACW1qYdiwiCyawiZWaKdv3zsUStL5pt2gxcv
         TZUU13fc4hsQ8xR7oxhCFZU3geyHM6yOOvQ84cBlf5uUgLRhax1o74Yav/y9pMWkz1nR
         Jnr8x0JjIUHITkKUBWymLom+jQZsSZYjKr7X+uNruAMuYVdUiEwyqgLuoQwCrjphK5LH
         NPMJ2sA4cemQ2f1MvfZrUZxpG1QRZC39VcZwHt3acdjbAXtAXx/cdPQA8NxERrV9XBWa
         ARmg==
X-Gm-Message-State: AOJu0Ywo9gs5tH0mraCaBEPqBFG08ITc/4KGXHl14fgS61DhxHm0uqEf
	aG7gjB2gYdd/414BF4BxvF8450ZF4IlXICpJ1c/9ncgW39aA/JUWbQNs/FXwqDdy+GNtZYw1pMB
	IAL1AttVulA==
X-Gm-Gg: AR+sD12k7HtCUZGCx20tjvEDGMD3h3tQyw03yIV3PuybJ+KwghJABVXzfnHqkSClICf
	kl0nRMU4Z0TY0fsDJkRI/NKdKwxd7pz60czX7nhYQINx4Ht7Upz5RjFA1j0CpKWsjpWtcs7NoN3
	bCTWoYFUfG49RUKPPysEjAbCfIBBhJhsomh+dT+yYTfcrSzBv7kQep6MX7AmaiZpq4hj7Po592a
	BNtHyTA6k1VU87KO2eUlvFGd884XnYnWGdwEm440RUwPu3lib7JwsTWYsstE46jGIDRwijcAai/
	UdxYEB2WRjpqqdlHWhVOTrobMrw5IYxCJbsyewRx+9Xa/smdzq4bvkkFqQa/rKRurYguVYg47SQ
	kQZv9RElvqoA2oxiedjKX6iH0QN63HroIeK1yqzxsRo1J9ExQzYyjjQcZw9INDfV+JItbPtieEv
	UCtHMBgfqTkvD9mCPlvuJ71J5NRH5wEBxS7RoJ/ZLGTYadqIHs+sAwdguHZRHuQ4sQU/jQ758Vz
	DDgmHM0ZxiLyld+yCzV0nWtiVqdje5/FlG5chxsnI9f161mV0ZfiIsX4cS4hjMvGSQ7sfP/pKSs
	fWA/Pkv0x3lMpD1mMwDfdg==
X-Received: by 2002:a05:600c:6a10:b0:499:79ba:a754 with SMTP id 5b1f17b1804b1-49987973094mr211636735e9.11.1786863104314;
        Sat, 15 Aug 2026 23:51:44 -0700 (PDT)
Received: from smtpclient.apple (78-141-71-213.dynamic.orange.sk. [78.141.71.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996128cffsm18511335e9.15.2026.08.15.23.51.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Aug 2026 23:51:43 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net v2 1/3] openvswitch: only skb_tx_error() a packet we are
 about to drop
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <AD1B7BEE-C04C-4A1B-982C-8385F1908911@doyensec.com>
Date: Sun, 16 Aug 2026 08:51:32 +0200
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
Message-Id: <3766FAA3-D915-4ECD-B51D-DCF390F3C03C@doyensec.com>
References: <AD1B7BEE-C04C-4A1B-982C-8385F1908911@doyensec.com>
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

