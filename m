Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F2945D5D2
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705335; cv=none; b=QVQPj+7iqGKBl/jRraz6GacxuABjFhQZRzGW0bUThwst2AKMLO/pjM6O9bQ9v4bRUgpSNKSw5hV71oVbrv5CIPidVzpuICkNDGPMbHnkUk5mtELIbp5NZLnlRgFoIW11ApAUOpZ7QUl7AgNGonAnCBKO47el13r766diID1vxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705335; c=relaxed/simple;
	bh=+bWiNOik+q50L+Rqo4L0aat23qr7vzWhlqwMS6QFHZ8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A/yMwnSPbETJyPz6mOtvUALRFg2uIqSp/EbuxinsFOBsPGw3n36B65Fj09GUJkCAnMQPLdmq81C5wZQRgL8Dr35v9ygaYF2gpqkz2Wt87DeppuCaaTdauiFt825nzoLik9+6reL60eICeOHjpwDJ9okScHEn7kN2sH/+mR6bLqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=P6HhFqwP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="P6HhFqwP"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4980dc26022so9289385e9.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 04:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1786705323; x=1787310123; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+gRbGCV0XxLdSaF9vYVqo8y9b5Wisj9Pp825VEoZ6Mw=;
        b=P6HhFqwPciepmA87l8MnANTlMFqBizlX/AdJjhmjqeEnVcHABgd5vMuuYAYPTQgSUJ
         hQSypaVHw6bAzkTs/wA53kIKCk6WsQeloxMNQJkmHWYfmeCEOB39Y57+6SBVJb1U7AFo
         axuNFbibpeXAwQfLS+xNx66DSGqccwpELiCLoEfziUraWRfqt2vX4/vvapVt6+fXDI7u
         4fqvAmC1nqMYkQg6qK8YqwxgaRCtskxCi2z1sSVhn1RhLGJn1HbgYYYD2Md1HVtPcL/g
         SwacYOf3EafwUF5pj1nwSnpkIss5F/yo/B0ZzKWe8RthQeeR0xW2Hki+ghMsoxt4W3YG
         CrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705323; x=1787310123;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gRbGCV0XxLdSaF9vYVqo8y9b5Wisj9Pp825VEoZ6Mw=;
        b=DUjZT8uydu1ueFw+JWB1qHdXMOpFaABkUtRbRt42MvZqTYVBeEk1r+7/jLNXXJtJBv
         adP0gTIReW1onT3f0IrGkozSjz7hYH4bKbAYhCSM4dwUTkjplYb7uCl61f+gu6ltRQNV
         CSoV6Ik6eq381Z6yfwfzyg10VkfUTOWKBBnA2P3JcM+G4ufAg0nhfYtnga4MJG9O1kRS
         tJpindtrapOXoa7lZHMzqtYZrd9nw8vRQq+8FBEmvMInSpqBr2fZnqTuB/7FIBQKF1y0
         mUM+4/eiWc2f8wakRVvmJKyKylCSE8DJ1IDapsKkTitynYn4oWHqQyImDznqsK/EEJgb
         +z8w==
X-Gm-Message-State: AOJu0Yx1V+Yg0L2AfAUdoedaz4Co7dvb2lKYBzgUIzYO2oZGxlBcsjAq
	YfSaFiUvOLCuUjYfbJe6kEhoUoABLP6MPWeDUkuVqxxgPSWF9Z0324qdwY9spV7NQ5g=
X-Gm-Gg: AR+sD12lga4ECITQik+r67joS+8415/3n9m7/CY1YqXFrdwM1PS/pURXiUuCFjZ7VtI
	sTHjiuJc6AmhwMm4qVydRb4cSxLpWXteKOj4m/ONph4IYLTHAcmsCG/6IsNpw78kUlihWO/vK6H
	s3Eq0rYAUuuWVnP40P0sE8KG9Xe5KAZ+rOMSSVgtPI3YJ+i/a2hfdvCpr08lzp1vLuRPYCB/y70
	izC9umAnMY+fC25dfignMdWELSCiltFbmO/741RG97/hK8/x8bsgL580ujKxGO/QhqN2hfkMclM
	PL0yPgrTTCIZH8VhR/+DhkrCayNQyvNuvSX3XBlMTIyYsX1Nkg2KRHkwTrIfNa5l9xy9qIHsvv1
	R4zVu6BKLI3QrDLDgIm1bBWB79Qoy3VvycLgxtqDoThI+tftQOwwnXFH1qs+RScLUuQ1KsMrluJ
	DvEWUAn7uVob3kuou7suznGlKB+QvIRAgCrEaqfBwefnAqmtDqG7SoIXaMWpxZdHXeojIVR+4Zh
	v5SkF6wcPxwaRxK0tBiE9TjYBRYnzdHpYUuv4LuVyl6SfgwZ4jxkKUSYkie4lA96sUFTbF3acjR
	cRU+Vnl/6Gnksoyg
X-Received: by 2002:a05:600c:1395:b0:499:872b:abd4 with SMTP id 5b1f17b1804b1-4998797684cmr58239365e9.6.1786705322547;
        Fri, 14 Aug 2026 04:02:02 -0700 (PDT)
Received: from smtpclient.apple (ip-88-212-19-42.antik.sk. [88.212.19.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499899afa39sm24363595e9.2.2026.08.14.04.02.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Aug 2026 04:02:01 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH net 1/2] openvswitch: only skb_tx_error() a packet we are
 about to drop
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <b20650c2-1adb-4902-b2b1-9bca91b95dec@ovn.org>
Date: Fri, 14 Aug 2026 13:01:50 +0200
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Kuan-Ting Chen <h3xrabbit@gmail.com>,
 Zoltan Kiss <zoltan.kiss@citrix.com>,
 dev@openvswitch.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <741D4072-50EE-437B-BFC3-CDFE94C93F8A@doyensec.com>
References: <8063260C-05C9-4997-B9B6-2135063C4858@doyensec.com>
 <C35992B1-7740-4886-94FF-F85DE8B0106F@doyensec.com>
 <b20650c2-1adb-4902-b2b1-9bca91b95dec@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Thanks for the review. Sashiko flagged that the moved call may still be
reachable through the RECIRC action, and I confirmed dynamically that it =
is.
With 1/2 applied, a flow matching recirc_id 0 exactly, with actions
RECIRC(1), OUTPUT(0) instead of USERSPACE(unbound), OUTPUT(0), =
reproduces
the same issue. So please hold off on 1/2.

Moving the call to the "default" branch assumes that branch only sees a
packet the datapath owns. For a non-last OVS_ACTION_ATTR_RECIRC,
clone_execute() does

	skb =3D last ? skb : skb_clone(skb, GFP_ATOMIC);
	...
	ovs_dp_process_packet(skb, clone);

so a clone lands there while do_execute_actions() carries on with the
original. The clone shares skb_shinfo() exactly for the skbs this series =
is
about, since skb_clone() -> skb_orphan_frags() returns early on
SKBFL_DONT_ORPHAN and does not copy the frags - so settling the uarg
through the clone clears SKBFL_SHARED_FRAG for the skb still being
forwarded.

Removing the call, as I originally suggested, does fix this in my =
testing.
If you would still rather keep it, how would you prefer to solve this?

Thanks,
Norbert

> On Aug 13, 2026, at 12:00, Ilya Maximets <i.maximets@ovn.org> wrote:
>=20
> On 8/13/26 7:47 AM, Norbert Szetei wrote:
>> queue_userspace_packet() borrows the packet skb -- it only copies it =
into
>> a private netlink message (user_skb) and does not own it; on return
>> do_execute_actions() keeps forwarding it through the flow's remaining
>> actions. Its error path nevertheless calls skb_tx_error(skb), which =
via
>> skb_zcopy_clear() does skb_shinfo(skb)->flags &=3D =
~SKBFL_ALL_ZEROCOPY,
>> stripping SKBFL_SHARED_FRAG from that live skb (skb_tx_error()'s =
kerneldoc
>> says "skb must be freed afterwards").
>>=20
>> For a MSG_ZEROCOPY skb carrying page-cache frags, SKBFL_SHARED_FRAG =
is
>> what makes esp_input() skb_cow_data() before in-place AEAD; once it =
is
>> stripped a later local ESP-in-UDP delivery decrypts in place over =
pages
>> the sender does not own -- an unprivileged page-cache write (the
>> "Fragnesia" primitive).
>> do_execute_actions() ignores output_userspace()'s return value, so =
any
>> action after a failed USERSPACE upcall inherits the stripped skb.
>>=20
>> Move the skb_tx_error() to the flow-miss drop path - the "default"
>> branch of ovs_dp_process_packet()'s switch(error), before =
kfree_skb().
>>=20
>> The call has been here since commit 36d5fe6a0007 ("core, nfqueue,
>> openvswitch: Orphan frags in skb_zerocopy and handle errors") but was
>> harmless until esp_input() began relying on SKBFL_SHARED_FRAG to gate
>> in-place decrypt; only then did stripping it on a still-forwarded skb
>> become a page-cache write primitive.
>>=20
>> Fixes: 36d5fe6a0007 ("core, nfqueue, openvswitch: Orphan frags in =
skb_zerocopy and handle errors")
>> Fixes: f4c50a4034e6 ("xfrm: esp: avoid in-place decrypt on shared skb =
frags")
>> Cc: stable@vger.kernel.org
>> Assisted-by: Claude:claude-opus-5
>> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>> ---
> Reviewed-by: Ilya Maximets <i.maximets@ovn.org>

