Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C589E3C6A57
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099971; cv=pass; b=VjsDtPKmy1kRmnyT8RchOFK3YXaIFHlx6iByZRFeSGPEMhkKmcZRkim2lfjPaHn9IWAnUm2SKR3jguo5Q2txE4MIVAWXwidgORv37IOXgvxIajyXE5aPbhlVZpEoD98m6W9tBMQY6+RIHD0ejTXFOKT/7ZEapQWBUmsjcShfuKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099971; c=relaxed/simple;
	bh=JOPfYMY0t10rtaToFl+YuQnshZGyBfYLLr+eiZvzGn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liH5INyfqF+NYDrtWJ8/Uqf12dwJ3rhsIL2EfyHWdAA5OSr6Fahd2J+/19gS1TIQfDszQn6PfD9vs71qcS2EBhBXds7X1RLtXT4H/JVf6WKAfjTYHchI72Ma5G5K5cLXs93fYxGk9w/okk0QaK2mfzxzlbzpLLpl/8J6orZq6lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ur4Xewa8; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ur4Xewa8"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e50a650a0so174780285a.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 03:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786099969; cv=none;
        d=google.com; s=arc-20260327;
        b=qyWCcrPX1kYC1fNEpGTdni6f5ZbARVz4jbVPle1qHv7F74gvvAUettX12n3RJZprPC
         TrGbgo1HZNqEDdOtmPEOBNKhczNY1sxfuUqiAaZEaZ2CZi0Yqzwa3/YZrBjEiW1JrMps
         ILJArQWoW22wM7MxItCCpTze9kmAOTuhYbWbCaE5CllBFiGt6V7Cv/RFkYKrnkt9FVky
         uINoD2EZpAW4i5z6MONpri3tX0gcJs3OocW8XP0tEF8Z8gfapPgjrDw6fqFDLFo+MVpV
         hAq3T0IFbCk0sXoaoXGWgiE/Gcpaph1M/9rwL1/tZdL+lOnZg0pK05V6cxcTu9P9mM7T
         /bqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hQ0c5ajHoRAqu5+TxzBEWaUWKNbl8UxZvFXxusiZKRY=;
        fh=Ow+UsI7mXNgiczJPQtgxHQcuwxcEjbVRoihM0UOtm7Y=;
        b=B59nvatfnLG3EoKy26l/8zNvQ4xWsa4IVE4ImOGuRcon93QwVxlvxiQxeoKMOyuoPj
         T3nAoi6XXGtkTusjTuBwgmIOJ3Mz4B8qCEaGLLFUsuR3A/MYCtvFbeCiZIBSi3Cq0fzi
         Iny2wSvA88j/QAPAYak5UMgyFGoud7DTdAH+Qg+eVqTyTxjxTuFZn7ILkmIm6l4WiWGZ
         RKiGtQ1JQllOOvDU9mNrO0rqT14Do2VF52pNwYJB6RLfHOMcg9sjH0/MOl/Piv+xmqot
         1z2rxBYGKhuyXsj1mhvC7qsA8w2oCy9X7/YpR8J1gxYIGQB8wFB1YA5CbBFmzbBc3SfV
         Ve7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786099969; x=1786704769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hQ0c5ajHoRAqu5+TxzBEWaUWKNbl8UxZvFXxusiZKRY=;
        b=ur4Xewa800+whD/3uM6IxW4IJRmbW/b/C0+nq1ErcNLJExrYs9FYyXEfAf8vwxLnaJ
         GNm7loHwutaq4QnNn3Z7rgZn9WBSj15Gcq4vim9Ywp/IBygNd73B2aLpU/kR8tIDepPF
         QjwSqTEhqxDh1VrZkt31s4zZ5ul4a3XtUQzuxW222uuuY/VSN8lbFu71XRk+TVEI3+ci
         h81hJlwISFJUbWrNBNJZNQOenGdUk1XekPikb7L2/YB0+s5sjpVHejfYtxV10Bd2mDay
         R4ayqSaLi3N0b6DF27OkLXeRvU4CPcR+zFiZkUiy7DeQApLTczk5G/FJsFhZgJ+VKWXj
         Rzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786099969; x=1786704769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hQ0c5ajHoRAqu5+TxzBEWaUWKNbl8UxZvFXxusiZKRY=;
        b=EGBjbLfjNfO2UJWJ09FKMJNzE/aD4+bQOrtFGcoFk16yxZgt/S8OH6olDTL/PkN1uD
         XgY/IExAcVEZ69Jt9Zij+X+UyWemLvl6Giv+oGVCK75Vo1oCMaLEw7FrbRkdOnmxzePX
         llkHhl8UfjXBF6YDeqRlBCFSCjh5fA+WEYkNeWM3MJ6knbyf5d78W4Lo/ey8czFXzmc9
         PegIZGcd1WjtUE0zPWfeFp++epMTnFh/ofNDCcUIF7GBjjnBK7ELS7oWg1DAKyp7zZU2
         Pp5j9o8odtg4yeR3+UzWXd7x9fhR9phYi3eI/cHG13FybQ01zjihlZayl1uW6RE1HCt2
         Gj8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rptp/4XdpjQaZsqT+fwee04jhtiVqH7d6s0ViqsJqdmCPtV7QAiRfVxA16JDFI/D+x3mhxIoOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFw1aukvysuQjOw6LuwNkWXKO1RiLH337OKY42mMpejHovUk6R
	OD3D9UFGmBDWiRVNWqXjpQlnHUK+w+cvVFOLyaB8jOAO71hTVxk1+GI1mZ8n45WqBaUwao4KG8d
	jVQJGfi8JRkgyaQfd6jJZfvPG9g6vvYY/CMVaW4rn
X-Gm-Gg: AR+sD10gvGrs73eBwoy63ChtXXuVZODskkOjuuNmH5YV7CyH04mqARBx7Rt/+ssEJxq
	uMaLES1AbvBdSqgfTCX/esuPW0gASg5sS+7Gsg7d6qYJnFjDVoG03FlofZyXt+GzqqDDgcX5gr5
	K5qW//sqVip+qweHQhVNuogsdYslpovFk1u71SNDOY2xcXoLDAoLg5QkKn/kH34k8bQ6T90wjeC
	REbuzmj+BQ1j30JAq2uNUXHJFf0rZhFxC4vuQR9F0IfPkwPC7UY6mfUfOO27pnNAUwgNqhFl1UX
	9HNTjbdwUParxuCBb76gHWwkyuAhB8Hwodgy7Y8r+akWBrmGJxz6MrMA/J/zy0Qch8w2050h2xg
	n6Xjg8SM+KjPl2ox9bVMK2zUPnT4aeigHDmyIelgQVqPH3MXQcAIqcd8=
X-Received: by 2002:a05:620a:3989:b0:930:147c:84a2 with SMTP id
 af79cd13be357-93649266f01mr1676458685a.32.1786099967912; Fri, 07 Aug 2026
 03:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807102802.1696827-1-zhangfeionline@gmail.com>
In-Reply-To: <20260807102802.1696827-1-zhangfeionline@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Aug 2026 12:52:36 +0200
X-Gm-Features: AUfX_mzSMpUQCv06Wy26GHfIm0nFy7PCL5fYHhg5VMZW2T9FoI34L9S5HgjTTyI
Message-ID: <CANn89iKByRiWyVdPCzvb5+0WWrPcaeLSXDqP6GqUHbqRwMF9bA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ethernet: drop skbs with a short linear
 part in eth_type_trans()
To: Pengfei Zhang <zhangfeionline@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangpengfei16@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 12:28=E2=80=AFPM Pengfei Zhang <zhangfeionline@gmail=
.com> wrote:
>
> eth_type_trans() pulls ETH_HLEN unconditionally, but never checks that th=
e
> skb has that many bytes in its linear part.  Only skb->len is checked, by
> skb_pull_inline(), while the __skb_pull() it calls requires
> len <=3D skb_headlen(skb).  The two are the same test for a linear skb an=
d
> differ for a paged one.
>
> Drivers using hardware header split, such as amd-xgbe and dwc-xlgmac, can
> end up with a paged skb whose linear part is shorter than the header: on
> certain frames the controller reports a header length below ETH_HLEN.  Wi=
th
> 2, that gives len=3D56, headlen=3D2 and data_len=3D54.  Nothing is wrong =
with
> that skb, but eth_type_trans() on it hits the BUG() in __skb_pull() from
> softirq context, so one received packet panics the machine.
>
> Drop the frame instead.  Test skb_headlen() rather than skb->len, since
> that is what __skb_pull() requires.  Returning 0 leaves skb->protocol
> unset, so the frame is counted in rx_dropped and freed with
> SKB_DROP_REASON_UNHANDLED_PROTO rather than discarded silently.
>
> Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>
> ---
> Notes for reviewers, not for the changelog:
>
> We ran into this on a platform built on the Synopsys DesignWare Core IP,
> where a single received frame is enough to panic the machine.  Nothing wa=
s
> corrupted -- the skb was intact and every invariant held.  What is missin=
g
> is a check that the header being pulled is actually present.
>
> The length in question is reported by the MAC itself: with header split
> enabled it writes into the receive descriptor how far into the frame it c=
ut
> the header.  A MAC reporting less than ETH_HLEN there is misbehaving, and
> that much is the hardware's problem.  But eth_type_trans() requires
> ETH_HLEN linear bytes and tests only skb->len, so the short length reache=
s
> the BUG() in softirq context, on a path fed by received traffic.
>
> The same failure mode was CVE-2024-41091 when it was reachable through
> tun_xdp_one(), and was fixed there by dropping the frame, in 049584807f1d
> ("tun: add missing verification for short frame").
>
> amd-xgbe shows the same shape in-tree:
>
>   /* On some frames the MAC reports a header length below ETH_HLEN in the
>    * receive descriptor.  The driver takes that value as-is; nothing boun=
ds
>    * it from below.
>    */
>   xgbe-dev.c:1901
>         rdata->rx.hdr_len =3D XGMAC_GET_BITS_LE(rdesc->desc2,
>                                              RX_NORMAL_DESC2, HL);
>
>   /* The length is passed down unchanged and used to fill the skb, throug=
h
>    * the ordinary core helpers.  The numbers below are one instance of it=
,
>    * hdr_len =3D 2 on a 56-byte frame:
>    */
>   xgbe-drv.c:2355
>         skb =3D xgbe_create_skb(pdata, napi, rdata, buf1_len);
>             napi_alloc_skb(napi, rdata->rx.hdr.dma_len)
>             skb_copy_to_linear_data(skb, packet, len)    /* len =3D 2 */
>             skb_put(skb, len)                            /* headlen =3D 2=
 */
>
>   xgbe-drv.c:2370
>         skb_add_rx_frag(...)      /* the other 54 bytes, as a frag */
>
>   /* The skb is well formed here -- 56 =3D=3D 2 + 54 -- and eth_type_tran=
s()
>    * pulls the MAC header without testing that it is in the linear part.
>    * The patch adds that test in eth_type_trans(), just before the pull
>    * marked below.  Without it the pull takes the machine down:
>    */
>   xgbe-drv.c:2435
>         skb->protocol =3D eth_type_trans(skb, netdev);
>             eth_skb_pull_mac(skb)              <- eth.c:164, unguarded
>                 skb_pull_inline(skb, ETH_HLEN)      /* 14 > 56, false */
>                     __skb_pull(skb, ETH_HLEN)
>                         skb->len -=3D len;            /* 56 - 14 =3D 42 *=
/
>                         if (skb->len < skb->data_len)   /* 42 < 54 */
>                                 BUG();              /* fatal in softirq *=
/
>
> Every step there uses the standard core APIs, and there is no skb memory
> corruption anywhere along the way: the BUG() fires on arithmetic that
> __skb_pull() just did itself.  A driver doing nothing unusual walks past
> the one test there is and into it.  A received packet should not be able
> to make the stack panic on purpose, so the check belongs where the
> requirement is -- the stack has everything it needs to reject the frame
> itself, and should not have to rely on the hardware or the driver
> reporting a sane length.
>
> The BUG() in __skb_pull() is deliberately left alone.  It is the backstop
> for the many skb_pull() call sites that discard the return value, and for
> real corruption it should stay a panic.
>
>  net/ethernet/eth.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index d9faadbe9..84914709a 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -161,6 +161,12 @@ __be16 eth_type_trans(struct sk_buff *skb, struct ne=
t_device *dev)
>         skb->dev =3D dev;
>         skb_reset_mac_header(skb);
>
> +       if (unlikely(skb_headlen(skb) < ETH_HLEN)) {
> +               net_warn_ratelimited("%s: dropping frame with a short lin=
ear part from %s\n",
> +                                    __func__, dev->name);
> +               return 0;
> +       }
> +
>         eth =3D eth_skb_pull_mac(skb);
>         eth_skb_pkt_type(skb, dev);
>

This is obviously a wrong patch. Please fix  faulty drivers instead of
adding more code in our fast path.

If you use header split, you are supposed to use modern NAPI api, like
napi_gro_frags() which will take care of that.

pw-bot: cr
