Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3681943E062
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784228838; cv=pass; b=t3GYlcjuZV9Bf+XZX++uwacysOXR434hClFVxDROhJNTyCXZh9U4cUR3pw0Zv+T7DheuIczql+Z0pFfx6nxtnS7Db6M24uP0UOQcebDqt7CqXHZxLoSvcrJQNVlGd3BUMfXyHk6iLdBFtkq/Crawj47gVakHHW9LuWfnwPPlAdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784228838; c=relaxed/simple;
	bh=AamOLsb1Z73lgIGEnHDE7brMzUBN4s6Bz0X93FLdAkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmsEXvqDADloqzufgGoOO0dkvS7xyPzEwe5ceJm4cexz8xl1ekjG1otpxjdDouhT2wNX6Pe48Sd9LQPcfXmU1ChBznYdHecLaef+70ugpsM3ftyHzavGjORPecY3tTlDdBxLym/+2QF6kcIx72f2jLLmofQlai0Tl3sUMBls+5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KizT/ls2; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KizT/ls2"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c160420289bso976959766b.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 12:07:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784228835; cv=none;
        d=google.com; s=arc-20260327;
        b=DfrZQik4LJtS711PFCRpnuXnxosR7RtqxGYWwgLuY6fjXl8al8lO7juSQN8r9t9YcG
         PzPIgkuXbFdDS14qImDPZmZrN6XWeFgiLL/VtOnUD+k6fAexOFrLgsWj3oQqk7ovylfN
         M5lyhyuFxPE64iD3nRVLzVouJE4DgVzJzcHCNXzPgSKq+4oO5ltS53ufNdy8fpl6o+eM
         tzJH/J1cxgXx7Z5QCRRRhISZbVRqAEEC7D5e+uWncLjrwMmwueOet8Ltqy6RhmpSAFrn
         FFPjNcME730Oc7sxlIjfINqbFGA1sOy3GUVMnz/FGktVI6Hgea7slAQ7yNHNzeICaK5P
         LXjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9k8UPFAuqJmuiQbWbqgtoiBAi+ZMtlsQI9qF0mLRLAs=;
        fh=9dcgNF3zLZ4mmv8AYhyJjqPKc9lpqhbZLvtkuYT5sM4=;
        b=G433GXaGIYnh/Ims2Pvi7OU7i2OcS15IrmfFwmu8AjGwQOSwQ8ceRqH4QlDRtmtUNn
         zeIHw1udT57X7YgNUNf8AlQJ5CqyebbqNh68FZu3ykG68KRrs7DW0neVq7pThbQtjT2f
         2rjzzW0DAP8JJ79+J3wAPIaRzNBYGFEuTf5wZIPJ59UjjRE80lxOSRWol25Y+vnazfyg
         cnTuNWHwU9VLy6273tror1g+2PKy8GqAxbBFO+OjS2pvEW3VJSHjdA34dHCuvE36UoU8
         OpNlq7yb/F0V+RNFcIxMJK3h41z7A2E5lwxDU+cPUjpCrbGYqW9D94KxZ5kr28gTmO46
         40HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784228835; x=1784833635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9k8UPFAuqJmuiQbWbqgtoiBAi+ZMtlsQI9qF0mLRLAs=;
        b=KizT/ls2TcaW+6HUUdiOhJlTd8h+/LP3MpS8nAheb/6mGdp/a3CpYXi3TnCIuB0YuL
         WgMtRKKKoT7Lxv5NK3SAyspQUO2Z49ZDH8NusHk0696zVovMbnN7fAKIxMHWBwUivSMh
         47imr+PRmHJy8gxPOUpVbof2UUpwVeWTf5OfM35hnm3yB4n2uIwIG3/ghQxBNu1R7RdV
         axeH41Ma8z9ETyD731T4zoaloeS/o1AAz2i+Jkj6+FCBn9VDoNWXrT1aMDrhFQPB4M4W
         7G6cZTgQsUbQAJol/JV7XiLWCrQ/wOANVQo8Hm6H1wUwY53VrU5PGAMYsiYh9vboEn+z
         1F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784228835; x=1784833635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9k8UPFAuqJmuiQbWbqgtoiBAi+ZMtlsQI9qF0mLRLAs=;
        b=tMbiqHCc9VPg5lBDYT2LzkqzTt1yFISMyKwwvIytu0kOWauwPEN7D5vgDHzO6cxRBa
         DBTGzWLhxGvM/9oW8bUTvssamny3bi2NM6n+7x0wV2oRcqF1nd5QQZtQ2xGJdDRVNWi2
         3MyX5nRZ0MhLzRtfHg/EESeNnTk659BVdNzEj5VRjY0k2J5oSJGr8ZBEMxb9gD422bpl
         DiE72MRgKxbvVtuUAaMSYkXWC1LB2FnpOdjF3FPjtc5tnGjiNz2a0qdgZf8jIuYb8fd4
         lLd/UoyFFFXNgaKkhAw1gz+6zKfBaH8wHj55wYxDLh63S8VFvE1yNjAvrRxROPRWQP8I
         0xEg==
X-Forwarded-Encrypted: i=1; AHgh+Rra+4wGQvZyCvTnyLI4GWXWpISC08jsdcHd0J2jGDu9F1m+bwjxaSy/OagWH53FlXEeR39UG3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHd5k3jIVDiuFn0T6rVW38GVb/MC02h8m2MYswSWJ9maQDCkG9
	0JeXT87DVnmnY2cC/EVwK6fgRu7v71keUxI2HdYNtmZL6Hts5KQFJe1iM307M8RzAB1DqGvdG7Q
	8/rpezi7xrgRYUhspFIK7L37/3Qx6gpw=
X-Gm-Gg: AfdE7ckvXhF9wrEF61CrvpoULf9MulXvt2xsOrhNpVQiKp4WqLOBeY/V489evKt4KJj
	k+S4zOI0rgFEb2aXE21O6EA5NYtEkEE+6PXYi3b93WnnVpycg/3EZM5yjcllZ48W86edEWwXDyv
	7WC2t0f717k8IEgd6CpSx1SPzTpCn9EZGiiCPVhbmuceI/9/d6B6R7swDo8WCVr/suSwekA5Von
	fOv11SJzXMUcDKpIAM4Rd2WbvXxHmIYr5iS1SCbuHx+p1noDSvrLHwAZV0jqH4wedHEbFDARUUu
	Evh1sRDU80/AE1XffQ==
X-Received: by 2002:a17:907:9628:b0:c15:e8c8:340 with SMTP id
 a640c23a62f3a-c16679ffcc7mr635883666b.23.1784228835222; Thu, 16 Jul 2026
 12:07:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714174110.1571033-1-bestswngs@gmail.com> <20260714174110.1571033-3-bestswngs@gmail.com>
 <GV1P189MB1988239A710C4D42F6DCA15EC6C72@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988239A710C4D42F6DCA15EC6C72@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Weiming Shi <bestswngs@gmail.com>
Date: Fri, 17 Jul 2026 03:06:38 +0800
X-Gm-Features: AUfX_myFMIr5jXhQJpkTup4K1xFIUqsOeOVkSMIcDxOpENOPBMtZSSyqan8TOyw
Message-ID: <CANgPUi1YA6NuvH_r5srnXAn_tL8pypxqp3Dcn_digWyBrk0zkA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Xiang Mei <xmei5@asu.edu>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=8816=E6=97=A5=E5=91=A8=E5=9B=9B 17:28=E5=86=99=E9=81=93=EF=BC=9A
>
> >named_distribute() ends by stamping the last_bulk flag on the tail skb v=
ia
> >buf_msg(skb_peek_tail(list)). When the publication list is empty no skb =
is
> >enqueued, skb_peek_tail() returns NULL, and buf_msg(NULL) is dereference=
d.
> >
> >tipc_named_node_up() runs this on &nt->cluster_scope. With a node-id
> >configuration cluster_scope is populated only later by tipc_net_finalize=
(), so a
> >peer link that comes up first reaches named_distribute() with an empty l=
ist. It
> >is reachable by an unprivileged user (TIPC genl ops use
> >GENL_UNS_ADMIN_PERM) over a UDP bearer in a user+net namespace:
> >
> > KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> > RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
> >  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:22=
1)
> >  tipc_node_write_unlock (net/tipc/node.c:428)
> >  tipc_rcv (net/tipc/node.c:2185)
> >  tipc_udp_recv (net/tipc/udp_media.c:392)  Kernel panic - not syncing: =
Fatal
> >exception in interrupt
> >
> >The peer holds back this node's later name updates until it sees a bulk =
with the
> >last_bulk flag, so simply skipping the empty bulk would stall it.
> >Emit an item-less bulk when the list is empty, and break out of the buil=
d loop
> >on allocation failure instead of returning, so the last_bulk flag is app=
lied to the
> >last queued skb.
> >
> >Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
> >Reported-by: Xiang Mei <xmei5@asu.edu>
> >Assisted-by: Claude:claude-opus-4-8
> >Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >---
> > net/tipc/name_distr.c | 16 +++++++++++++++-
> > 1 file changed, 15 insertions(+), 1 deletion(-)
> >
> >diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
> >ba4f4906e13b..dbcfa965de34 100644
> >--- a/net/tipc/name_distr.c
> >+++ b/net/tipc/name_distr.c
> >@@ -165,7 +165,7 @@ static void named_distribute(struct net *net, struct
> >sk_buff_head *list,
> >                                               dnode);
> >                       if (!skb) {
> >                               pr_warn("Bulk publication failure\n");
> >-                              return;
> >+                              break;
> >                       }
> >                       hdr =3D buf_msg(skb);
> >                       msg_set_bc_ack_invalid(hdr, true);
> >@@ -192,6 +192,20 @@ static void named_distribute(struct net *net, struc=
t
> >sk_buff_head *list,
> >               skb_trim(skb, INT_H_SIZE + (msg_dsz - msg_rem));
> >               __skb_queue_tail(list, skb);
> >       }
> >+
> >+      if (skb_queue_empty(list)) {
> >+              skb =3D named_prepare_buf(net, PUBLICATION, 0, dnode);
> >+              if (!skb) {
> >+                      pr_warn("Bulk publication failure\n");
> >+                      return;
> >+              }
>
> This approach is wrong because:
> 1. When 'list' is empty, it is caused by memory allocation failure before=
. So, it is likely that 'skb' could be NULL again because of memory allocat=
ion failure.
> 2. Even if 'skb' is not NULL, allocation of non-data (zero-in-size) messa=
ge will break the receiving peer when it handles this message.
>
> >+              hdr =3D buf_msg(skb);
> >+              msg_set_bc_ack_invalid(hdr, true);
> >+              msg_set_bulk(hdr);
> >+              msg_set_non_legacy(hdr);
> >+              __skb_queue_tail(list, skb);
> >+      }
> >+
> >       hdr =3D buf_msg(skb_peek_tail(list));
> >       msg_set_last_bulk(hdr);
> >       msg_set_named_seqno(hdr, seqno);
> >--
> >2.43.0
>

Thanks for your review. Fixed and v4 sent.
