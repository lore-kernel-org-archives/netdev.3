Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10483EF663
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 05:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786600058; cv=none; b=ZaxkJVA5Xe9PJY0p2z/cUOsPy4bUkDcjnte8m11MfAf4PSouk8BMdJkheRTOmWUabsBpqLgPbSGXk2XjDxIDRTQDm0yZBGostjtHoms5qRiRs/POHvMgb2wEK/gE22JL0LOOEsxYR8oLAQgtC39p68hwAidEdAtI2a+SG8JREtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786600058; c=relaxed/simple;
	bh=21S1qZnq2KQIxbCTlIvk2KBTg6PbdZU54hPR6uEl4dA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cxzrX/V+0JPMb8vtWN2V2jBfZrxgGjVChp5ixqUOa2k6Xav8ftxKK4oTorBhfHjH+RVlZv2QcL34QnvsSbOPZFziiQ7F10rsgaENdCmGcaEnXXL20UhN4GXGAQuVRKafqDe9Hurja25nZPJZpGzq6z6bAONyckeTyjGUHYhU1Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=dMSEAhKi; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="dMSEAhKi"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so264585f8f.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1786600055; x=1787204855; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kJdVd9JEvLI+gAaAJA/YXYI/7MyW6Qd+/+zQWas02oU=;
        b=dMSEAhKiFqSD3nOjRkrxWi15OdNFqZnZ2xnc1RhS615WnYIfrOpkLs0Ag4I6ZviaND
         GRYhHCmt2aDXXphTuCmdTnzUPOx634Wn5bhxj8rXv2GZ9FJmGYWr2ycmnhr1sgHhgdEw
         3SgdnFxWKL/NBqAb/13OvH9DPspFEZz84m6MR+Wh/Iz6zFOR12urbMldd/0sjbwQdlH8
         HmkNQJxq0ll9/+ZGA5q2bKOz1NgPmmg29Zho80XIi6sePwAMso8mRPixnqD0XDfDpfIs
         Umy1JpzpUJv+i/ojn8m5Olf55jTJ1FZs0y9hODsIxf0dHGJojy3EVy64njkKwFzaGQV3
         Mr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786600055; x=1787204855;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kJdVd9JEvLI+gAaAJA/YXYI/7MyW6Qd+/+zQWas02oU=;
        b=V7RR4Hx9EZmhW3WxDKNn4ocDwEQoNqvUnvjSzInab3twYff1AiO2D2lXMTJDajLwuZ
         oFTVnx32q4NC1US531EkocR9XBKXu3lOO6IdypjDWo862XkznDvaBblwBhOYj26vAOil
         LexVHsWTG7kMuNa412sNW2yx8sVenpgu5X9cfAI0X9Vw2FUYkfSJtcKI6W/4RhBoZemB
         oGEP7KTPGkJuQLE4Hri1PyPCTUMkLMkD8SdI2eaN4XAog7BUDxb5lKxvC5PKtkT9xRpL
         m72IJQTdM+IdccQboP8YJFO7e9WKQD5k4kgOJSbg0RNAXbzKWq64km4/Cau8FF7VHHJh
         X8Dg==
X-Gm-Message-State: AOJu0Yxr1xn7cwPoRePUf1dJJ+Rvy2CADkDtQ/ZgzrpYQtGUJveYUB1O
	gUYUsmDfRqtBJPLoErSZKMkpIETLybxXZ/f+uaeL7wMhcAyy/tk+UXZav++xS/44FZifqBnNfGG
	hd2Gm0Zeahw==
X-Gm-Gg: AR+sD11itjiF6MDgB1Uakk/1mfoOEBJ9DhaARqE+Yc5vCg8d/Yjz4kYloBmVOBB9G2t
	f4nkQHNe23zLS7beaj+GyfECwwdY/Co2mcq780ZXW0sagwWFwL1AVto5jJ6sJEgvrz2KJQ7w7uN
	Shj8EWUnKky2/9wiuQqxq5OrvbM+FQdqisfIh4xyfnKQSb6dhAnh2OzOxv5aAFdvL2++wSxyTbe
	cHvgGfLeCjKsnFT/wiEOG2CKyAmTozq3lv8MOE8SnTHcDt+opzNgazIka0/jWr/cQTB+VXRPeWu
	B2lajH3tKQtDMYJKqsEdUGm26EqqqTVWUVCrC/vS+VgFSecktx/Ws731QuOkXMXmhZwwzaIS+iv
	4JOGREQcD71WyGQuWKQTdlMpqFDc113xkRGifeVwdl32pi66d5vyi2N7tkUFkD238F8pzxqjfTA
	AomR21/1mXFZRMVheso6aN6d2vijun23/AdKu/RvzVOHCwggCfa72cOXSANJV+XKRKvfxWM6zF8
	PZQUCfdUaZsnCPxJkjVoU79F7AYb2wyrC6IT8pQUN8Q+I62BrorDvGdRGnTKDGM3+5wMpyGnDhh
	lpIXosFmAZA3zumuQL4rxQ==
X-Received: by 2002:a5d:45ca:0:b0:47f:ddc0:602a with SMTP id ffacd0b85a97d-4815a01ba47mr2905789f8f.18.1786600054954;
        Wed, 12 Aug 2026 22:47:34 -0700 (PDT)
Received: from smtpclient.apple (ip-88-212-19-42.antik.sk. [88.212.19.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5af441sm3741295f8f.22.2026.08.12.22.47.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2026 22:47:34 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net 1/2] openvswitch: only skb_tx_error() a packet we are
 about to drop
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <8063260C-05C9-4997-B9B6-2135063C4858@doyensec.com>
Date: Thu, 13 Aug 2026 07:47:23 +0200
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
 Zoltan Kiss <zoltan.kiss@citrix.com>,
 dev@openvswitch.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C35992B1-7740-4886-94FF-F85DE8B0106F@doyensec.com>
References: <8063260C-05C9-4997-B9B6-2135063C4858@doyensec.com>
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

