Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5E14A21
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790489633; cv=pass; b=bhbGaQUNEAWDELkakbrOL0cKmb3Of2QShBojrwpk7adUjzYsFw8vZUXBL0pmpA0xLUxy1r/52l2wkuLSwcHjbDHyYUBy1rQoysZesGamEG4W4po9PY0IHdSc/of2rzwVPkhcNQ9901/tO3N7uP6SHTAAHIlALO4rb+bHIfL5uWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790489633; c=relaxed/simple;
	bh=sr4Z3lGmEaVF984a2Rc9vpNw3cyNxpoqGCKnkWqzbnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTzbZhKzkjnQliTIqp5ordaOKyf+KwcKJowWl2h0P/nn3Eyj3uM5z+2wJ5bjpVHDiJrUcKOzPgvejTzDGkkJ+0iVnsKIdBjwkwbmOpqHGpeFXpGpT1e4eU76Zlhb1hMt8ot7yhhI6cHBogPH7qwx4rzpiJAiMjYK1JrSNXwWnkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIfo6Fdf; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIfo6Fdf"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3425f2b24a4so794461eec.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 23:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790489631; cv=none;
        d=google.com; s=arc-20260327;
        b=L7hc74mGHrCmUK0LOBqeWo42yTy9duRtV4XYDrE5CZ8mEAw+RrAikv3H33pluQu3xD
         SdkI99b4PYhMzNibQ2gdl3Il5viG37Dxgf24aAUvx1jTncTTxGjNcZFu9Fk/cbcXX+7d
         1e2ef5t6NlZvII8tJ5+bJmCyfOVmkKoAgAzpk9ImCvzhcrNoSxCeHHa3EU27yoMxJKT4
         ukmPoEVbJ33V+UnRsZ6McrRbrYqncVFP8GyamThJ4CD2jnMiW8tQqOaFT6S+LzmV7QXD
         Lz9gcAoQ5bxfK+Iv7P8iAnFcddzF3CS8hV47yomsxabRzqrd9FrZc8+EEgHd5Mpcf6RF
         YSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sr4Z3lGmEaVF984a2Rc9vpNw3cyNxpoqGCKnkWqzbnA=;
        fh=vNi2ytF3h2ey0PlNGrnQghq0jxf3DRawEZ5ksl6yRwc=;
        b=cOBkuzO5OC1oBgJEKl/pWVNY0x7o1t12cEaIsos0/WJ13LfzDgEGdJCxaIZ4jJ+P9N
         rb08Hum2MvxFwLjHSi5VdKbDc+vdGBVbHn7n6fWnHTf/9wC4SIzIexGedTqRPEECGEsb
         ZrWrhNwgzY1oNq3LWeTVnkVX74yEzvDkDdgWmYm2LJSca8b7loXNrpYql4R0oHyRs/OP
         AW0FtWAfcWPxIwS5YlvQigpn0aAv2eWDzPJzVWqvpKXwOPyok6Ctw+8YkiK950n0QgrT
         IuBYd8r7lDvgvkpp6K5CtR/ddGq+k1lDUR63wsdxMswXpqn9F1PMScUGV1s5Ph6JIv84
         WIRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790489631; x=1791094431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sr4Z3lGmEaVF984a2Rc9vpNw3cyNxpoqGCKnkWqzbnA=;
        b=BIfo6FdfW9YzBUAJa9Bh2IkhjazzGe+0+EQjjp6qGgaX1iZh1DITClCAsvFsqSPItb
         8wBDm5wjaEaXpnuQxIjrgCwiTxh1I61CSJJFpOZ3XaPIxYPvrF3qqExFN2TvCTeRZDBy
         6D/dT0ULYH5jPQnbr4/azQewLJDbiAbkbroStRxmnwiCBEAx1WdiSQ4GEnd+lh0P0vDc
         7nKuvr6p3ok/0usRu9JxwASvwdedRH16cCuKmW+pjrIdpuOV7cYEBNBGFllg2YFWYVKf
         riuSpebv7OkVe0JvF79wIdpxuDoh4ao4VYBnash6MMhr+mZhd/yxoTMhDESzkTFIjOPt
         uE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790489631; x=1791094431;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sr4Z3lGmEaVF984a2Rc9vpNw3cyNxpoqGCKnkWqzbnA=;
        b=aGVjktRfzAxPfk4+LRGcE+PAXt0bL8cJbz477/yfdO9q3ssBt3YeTi+igFa9acs7gh
         g+RL14NKCQpgtJxV5KlTMlTan5YJZiDG7n8lfTdreHzwX9whoPIGdMm/QXzXrun+GR/m
         iLm4o/zHS0o+QZ+gVsnRShZQXzWVwDr4end3ixeB8qfGSF1ExZAZynx0spiFAM3fOTbo
         rbgGWmq5vyc6HnpWMNyzROV4gyAdw+kDt0ALuKxvxFPzBqf6HTDSU/Ki34OPL4HSs8hH
         CdNtnFLsXoudQWyKKwbrcZF6G11cQKmJkOMweqWixj+btdm18BP4gK5UELAKCfFMUy6c
         EYyg==
X-Forwarded-Encrypted: i=1; AKwUvBy3pLcBUtYQ1yZafxcSvu9w0qoHTRu2HIdFbxM/WlFPF40+a5rmOdXq78yQtUc+YatRp2Uqw/k=@vger.kernel.org
X-Gm-Message-State: AFq9FYL70Af4y2G3Yl+yIROwJZIVMbO3/JfMWTCkcX44rm7tBPhr3A4u
	SjdrSUNhakHEyi+JJwe8ceqsONCmRHxpxg07pt+rHBgYSIuUT4F1i1w0L6ZvaFSjOJWQy04YIUe
	HZUL16FhTCvqH+t95O68ZWwt+jwY59Ms=
X-Gm-Gg: AYBFou3TXvhMipO5idjzb5q2fMqbYHVUuU69rXGZvz9kF1LuVBqNfjvqPuGRIv/S+5a
	yfxOlkb7uDoqocArnsc54s7jO3v5KWucfdSTONsvBJhWVuxrY2AETFA5upuZjsDu7P56JU/Y1Rj
	+VYgGW/g2iVzMEMiDBNP6WVGlzQvxx/j4HXeOk9SqcoCamSw8ksWde+uqRuLEAb+utfLocWBa/L
	Q5wo5KFiergL8WsLcY5/Z+7LO+FG44eGCLZySZyqa1Defj8Zswb6xxtq5ceEn246BKDIXp9Jb3V
	TzKmfoHS8S1OhvB8vh2J/Z6Tbu0ajRwLBkssbQNh6ZXWfrVY/Yxwa2I=
X-Received: by 2002:a05:7301:7107:b0:341:2c6b:8c97 with SMTP id
 5a478bee46e88-34270ab8e8bmr4558045eec.12.1790489631424; Sat, 26 Sep 2026
 23:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926210757.2152159-1-thisseanzhang@gmail.com> <DLPTN52TGGMY.TPWL2GZA38RK@gmail.com>
In-Reply-To: <DLPTN52TGGMY.TPWL2GZA38RK@gmail.com>
From: Sean zhang <thisseanzhang@gmail.com>
Date: Sat, 26 Sep 2026 23:13:38 -0700
X-Gm-Features: AclHuK8wXN2xAfp9zc6K6pU-EYUnBl-bodxzJ1vo68HRxFJW1oVa3YT6t8_CCik
Message-ID: <CAEejd4QjwcjMNKuwDYBV_u4XJ_CfzGZGR5MXGtOgM+BoAMP23w@mail.gmail.com>
Subject: Re: [RFC bpf-next 0/3] bpf: Add PPPoE encap/decap support to bpf_skb_adjust_room
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, netdev@vger.kernel.org, 
	Nick Hudson <nhudson@akamai.com>, Felix Fietkau <nbd@openwrt.org>, Qingfang Deng <dqfext@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> =E4=BA=8E2026=E5=B9=B49=
=E6=9C=8826=E6=97=A5=E5=91=A8=E5=85=AD 21:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat Sep 26, 2026 at 9:07 PM UTC, ThisSeanZhang wrote:
> > Hello,
> >
> > This series adds PPPoE session encapsulation and decapsulation support =
to
> > bpf_skb_adjust_room(), allowing TC BPF programs to update packet data a=
nd
> > skb metadata consistently.
>
> Why?
> Is this a research project on what llm can implement?
> It certainly can, but it's not a reason to add new uapi.
>
> pw-bot: cr
>

Hi Alexei,

The use case comes from Landscape, an eBPF router I maintain. Its native
PPPoE WAN mode is implemented in XDP/TC BPF.

The motivation is a bug we hit: forwarded GSO packets larger than the
negotiated PPPoE MTU are dropped after the TC program inserts the PPPoE
header, because the stack cannot segment a PPPoE frame. This was
reported in https://github.com/ThisSeanZhang/landscape/issues/57

The reason is that the PPPoE metadata transition cannot be expressed
from BPF today: bpf_skb_adjust_room() cannot set
skb->protocol =3D=3D ETH_P_PPP_SES, so an eBPF datapath cannot use the
kernel's PPPoE GSO/GRO support (55a5d8fca836). Our egress program uses
BPF_F_ADJ_ROOM_ENCAP_L3_IPV4/IPV6 as a workaround [1], which marks the
skb as IP-in-IP (skb->encapsulation, SKB_GSO_IPXIP4/6) while the wire
format is PPPoE. On decapsulation, a TC program similarly cannot restore
skb->protocol to the inner protocol.

The flags in this series let the helper make these transitions for
skb-based datapaths; if this support is merged, we plan to switch
Landscape to the new flags.

[1] https://github.com/ThisSeanZhang/landscape/blob/80bc43eef7143ad029283fe=
2a8d510718c22af12/landscape-ebpf/src/bpf/tc_chain/tc_pppoe.bpf.c#L38-L47
