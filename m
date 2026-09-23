Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C9253A397
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174304; cv=pass; b=LT0wu90+23ir2Mv6GhsC4AXRe2fMTwnAim42E3ULtsd0orNxRSadFeCAtof+DmKQeFyuxt7PPF4rF6iO/ziRZPGgjRU5AYf4i1gj10ibYrm5j43rZx9em9jsFbF5xA1+jK/R0EZmkd1W2r7r/MmqZ5IEuo1Y/RvgLMItkp3qScM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174304; c=relaxed/simple;
	bh=gV7R3bknjN2ZuwJE5G4cesZDpgdHB9sY7pAnhqX7wTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYRUNESoG6gXicITwTgj1u2Hj9gJ28/MSeEVnhbIGPeehpwVN2Vy3zL2/EJxh+SzhSlrAaulseNWSfchNkGaagxJX51nPZFrWAfo9FuZ0aKvNmt/r2/UbZPhWT9o3MoIXVJOcUliJdnl0pPNhFJkvlZ/ubtaYj+7K1d1a8Iqbg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKqJ4k3k; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKqJ4k3k"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d45ae011aso12576517b3.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790174302; cv=none;
        d=google.com; s=arc-20260327;
        b=WvFi3V+IW/YmdLcT8Lq1mZrYAy5AlEgqifbV7/S0pWBXZ1FGvhGK21YWcacco+vm3n
         ovEzAY4pYmkSK1dZs/rNjQ8lQBlffuNVQ0e0UGtba8deWxXrJ7Wic7t2YBuX94OGsj0O
         X6aeVz8YKNzUhUSa0zNz9KxAFaO+9JWlq3p579qKdOM4rgWdEFJvQCUmwJo26SDpfK6E
         uG04d8T+xOkS/P8m7WBoIWY33zFqb1yA/9/1wvQdJyyTeW/ADQ73xtM1QDPbRRFH0yeo
         piykR18vYRgL4G6tpbos1fgc5YKvVnalm4yHg0YQ6+zhaFZzvy9AFz4MpwwP+wYHzBuC
         sd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kis+TMW5HZCjInDKDAhOcTdWgOxAGINxUIFoNcQy0gs=;
        fh=rUyuqFadWA+Ejm9k/zWgxs7mI7X31DWBuMmLKGLVDg0=;
        b=aqsaPI9pruvFjxKLBUr55K3q6jUmLnKys7bd1a9wmYNfWxO4FrkS04eZVqeXnPN+Az
         jjOHfz0cmx6CISaUXe1gRJMSlMQk4AEAX7vvwvEwyDvWt4Oi2P6f8Rz+7PqhrDYi2XXV
         US07qiYiUwp1A4N3i9OHu4xfC4DzEvonb/e26fihCvvAj3Z+Uw9meiZ07DN080a8x0mD
         7Gmlh0rGSUZcA8JcwdzApwxY32MDY4DWx6qPW2xD4XwQUpf+k9KIXPfDPu44a0G7Z2WH
         gZbWiRD68UsnwWsuAmhj37QRR5KAQ55QweclRScVki+mu4jhNLsN3ZXJP8z8HKnuGYF5
         ffyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790174302; x=1790779102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kis+TMW5HZCjInDKDAhOcTdWgOxAGINxUIFoNcQy0gs=;
        b=BKqJ4k3kTQ9QboosIEifTwVzyMQrsAPPBAzRIWEvf9u5kaFz2S2CsNSWfQns+DJZlf
         2u+finIQV58Zo0KFGZ9K+hYutI5O8S7BYpXJ1RgR68Aazj3KiafEylN9rdCaQxL8XQ0n
         iTpExEfEq/pZsekQyK+mU/0SRPl1DEht1t4yr9KhE5vWKigzTwaOQNNCw8MWUkSHcmSq
         pGUxtTjx3IWydY4mIO/OsADWEgcaRwZt9MT+OcYx20DqIJTNK9SGR/xMP/4LpkcsayEM
         yzulA1tybu4RKBIB+L7WJaLJuIAluCFqLytJQhlX/gzSOaaTGZHJ4OYFcinlhRchNb1I
         OSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174302; x=1790779102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kis+TMW5HZCjInDKDAhOcTdWgOxAGINxUIFoNcQy0gs=;
        b=PqtQ+qyB9fB567ONQfIZ7A0lQ9uhclMMsz6qwv2wSOo2rZAMh/U7cU9XtkbOv12zcz
         fMQTltuqZ1GQB4ePJB5/G6EJ/9nP8U43+Ui5MxQTPbWD5ynRAuT+MTSGay+977EsZnAA
         WLDnBiDOwVy+L6aKhykqSdO3mZfYA9u3oPr+EEQ2++cZ4fIKMpVl3luGA052iXo3PVre
         vXsolN3t3n7Rwjs2NWu30NIh74FfEseH6EGvPJqIfSumvH0spOVgfNvEf/xxshrgNftW
         lJxVcz6hTlij7/AakSeM+lSFScTxmeQqmm1KMc1sxAC+zTMa0RdGwVaWf1pPvO+12Ikg
         387Q==
X-Forwarded-Encrypted: i=1; AKwUvBycKEgRQDS3b3kOW5LdWFgbcmLrA800lHqU9mLyAAM9N6kKfZ/zfrETaXwRXt6oSa+s5Ym7Buc=@vger.kernel.org
X-Gm-Message-State: AFuF++mGwd84R1dwNJhn8mX9Wwkf3cD64WrYDdxeVtUYF7gJ3+cLGY0i
	0YDznETgqSqZJifsXhIU9/bEnV7mxUkO8NMQPfZV+EyCbGBq9u1Wk2g5Bvgnc3NtCLKqv59kESs
	qIeUvo78NYxUquhYw6al9Rz1tXPUM1f3yHoDM0mv9
X-Gm-Gg: AYBFou0qNzxBo8erbYlCoeLZ9kkzOkwGwu4a4s8MhKIEBe9D1h9SbKmo/mv8N4+nryS
	TyyYYoO9jmcscBM5yWdjeOlKfg9TYSr+BFurVgVsSyR1D7vJmKFDcEjJGcr+LW14bizWKTohg/E
	NUtskIaytjQj8uo7c0ybRoByKc3DeUOsXjeszZ/kJQaYHTE877kIRNGx47dRNeJApoMVeXIX/gk
	EHhJBoR+juwU2MMFukoi6l5HPPBv+L5w2U1tKrUj88eHI2jJu7kchOdFrItIvDClJctX9SaCoTi
	1HLd0cL873cVl3JUgBU/zSggbRArj5wwrxXqPGdWSPimX451pMnqs6EKRxj2/HBQ9nywg+RBg+x
	Kzw327JBe3ZKfoxbFc0P5K5MIts/TaWl3JP7xxr/3yY+V0BYSUjc+j3m7PN2yoRh0lvWU
X-Received: by 2002:a05:690c:9988:b0:89a:63bc:8c9 with SMTP id
 00721157ae682-8a45c272e05mr15457727b3.83.1790174300879; Wed, 23 Sep 2026
 07:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923141047.14047-1-hannu@varjosoft.com> <CANn89iLq9kyTqUW4w46wjKNNr-n+jypQX-3hwPE2yjtSkLw00w@mail.gmail.com>
In-Reply-To: <CANn89iLq9kyTqUW4w46wjKNNr-n+jypQX-3hwPE2yjtSkLw00w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Sep 2026 16:38:09 +0200
X-Gm-Features: AcwNN1VXVSQ4KYz46yp1DVmqvdYNW6ITdvAxyjoCcdQywYA54dSi7QM1mbr4Dh0
Message-ID: <CANn89i+MS4L60sFQ49=-f-mibeveUfcrpVkD5X+Qy6SOnEpd6w@mail.gmail.com>
Subject: Re: [PATCH net] gve: DQO: accept TSO packets with non-protocol
 gso_type bits
To: Hannu Varjoranta <hannu@varjosoft.com>
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ankit Garg <nktgrg@google.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 4:23=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Sep 23, 2026 at 4:11=E2=80=AFPM Hannu Varjoranta <hannu@varjosoft=
.com> wrote:
> >
> > Since commit 014c607f86ab ("gve: add support for UDP GSO for DQO
> > format"), gve_prep_tso() matches shinfo->gso_type exactly. gso_type is
> > a bitmask, though: SKB_GSO_DODGY is set on every GSO packet that comes
> > from tun/tap, packet sockets or other untrusted sources, and
> > SKB_GSO_TCP_ECN and SKB_GSO_TCP_FIXEDID can be set as well. Such packet=
s
> > hit the default case, gve_tx_add_skb_dqo() fails and gve_try_tx_skb()
> > drops them, counting them in tx_dropped.
> >
> > These packets do reach the driver: tcp_gso_segment() passes DODGY skbs
> > through unsegmented to devices that support TSO, after recomputing
> > gso_segs, so drivers must tolerate the bit.
> >
> > This breaks virtual machines behind a tap on GCE instances using the DQ=
O
> > queue formats. Every TSO packet forwarded from a guest (gso_type
> > SKB_GSO_TCPV4 | SKB_GSO_DODGY) is dropped, and guest uploads slow to a
> > crawl of retransmissions or stall entirely, while the host's own TSO
> > traffic (gso_type SKB_GSO_TCPV4) is unaffected. On an n4 instance
> > (DQO-QPL) with a Cloud Hypervisor guest, a 64 MB upload from the guest
> > went from a 60 s timeout at ~0.9 MB/s to 0.19 s with this change, with
> > tx_dropped no longer increasing.
> >
> > Restore the bitmask test that commit 1b9f75634441 ("gve: ignore
> > nonrelevant GSO type bits when processing TSO headers") introduced for
> > the same problem, keeping the UDP GSO support.
> >
> > Fixes: 014c607f86ab ("gve: add support for UDP GSO for DQO format")
> > Signed-off-by: Hannu Varjoranta <hannu@varjosoft.com>
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> Thanks for the fix!
>
> Note the breakage is not limited to tap/VM traffic: gve sets
> NETIF_F_TSO_ECN, and tcp_ecn_send() sets SKB_GSO_TCP_ECN on TSO skbs
> carrying CWR, so plain host TCP with ECN has been losing those packets
> as well since v7.1.

BTW, there is another related bug in gve_can_send_tso()

Using skb_tcp_all_headers() for UDP does not look right.

I will send a fix like the following, unless gve folks (and/or Willem) disa=
gree.

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 80ab0a449ff54e3d19e9c69226949465d48dfe3f..0f6f7c5dbb2e027bb0a45eeaf76=
cfabff558ec79
100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -918,13 +918,19 @@ static bool gve_can_send_tso(const struct sk_buff *sk=
b)
 {
        const int max_bufs_per_seg =3D GVE_TX_MAX_DATA_DESCS - 1;
        const struct skb_shared_info *shinfo =3D skb_shinfo(skb);
-       const int header_len =3D skb_tcp_all_headers(skb);
        const int gso_size =3D shinfo->gso_size;
        int cur_seg_num_bufs;
        int prev_frag_size;
        int cur_seg_size;
+       int header_len;
        int i;

+       /* Must match the header length programmed by gve_prep_tso(). */
+       if (skb_is_gso_tcp(skb))
+               header_len =3D skb_tcp_all_headers(skb);
+       else
+               header_len =3D skb_transport_offset(skb) + sizeof(struct ud=
phdr);
+
        cur_seg_size =3D skb_headlen(skb) - header_len;
        prev_frag_size =3D skb_headlen(skb);
        cur_seg_num_bufs =3D cur_seg_size > 0;
