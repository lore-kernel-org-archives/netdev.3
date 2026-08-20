Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDBF47D46A
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244071; cv=pass; b=FeT/3am99PyUlVd/rGQ2mGGLJKJn11nEtvNs21jg0+EsE7ihRGW9KoIFJUtVhl7qqvq6UGfmQI1AgWCNia30QfUNFnZihEMIcRdXPdp69uGbs3tSc4ACsZV4ZkoelrN+OloZHzq/ZPsvidVc+Z1aPeh3y6c7qxbxUR3LGs9vQU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244071; c=relaxed/simple;
	bh=QGoE36Oi3i1r2LKhGapVr0FhKkU1kolz900HBp826AE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shzPkSLdsUl9z3QoZez9x8yLzfEhqZGOQKree+FkWxHu2QFthF76lkWZEDuFhwqPTZ36MIsy9BU60mw9Tznly+YPp9vIXDbKgfFuOw+taNe+3Rf7tbdqlIhuNT+UC1zmDHUMgnxfblvj1vvvlN6NQpyjhCoGCsIgrjteWZlWG08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=kCkfchZ9; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="kCkfchZ9"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84e507b079dso16471b3a.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:41:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787244069; cv=none;
        d=google.com; s=arc-20260327;
        b=Id+KfHoEC8O64LMz1aEnDBTybReobjW87/BrNwjnDndHv8qkUvPxVpchTuz94l2RfC
         dL04iSyvBao3G4imzvWidI2p++GawJRH77Wn9BBXIcXGke3y5gS3Mq4UdQGfv3dplToC
         YYT4vD+X9bj6ZjVksx7HxOlESLDKshopLzhEW4mkKgufYcSnCRc9xHwYukxUaGDNYC6O
         ZnQ0+PHbRvhTAzdrqQRw361iNZAvaq3KteadHOHL+wALst8HJyOgOUIGBxPMN1XbUrb4
         eW+xVUH8b5dgQS/vzHemPVGAGwEL+qHDuYrTSZllkFvaU271B3m7mWjHVI0NY9LVl9lW
         mPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=POqqeduVarme1JDPk/PiGoV8uXno46R5fPI2JhAIBls=;
        fh=D4KZ5Ohru90pleFtQIlYZ/nRnLVaougvxGKb2H8ndLA=;
        b=Hzz63ZwdF++xI0ScEighVLKB2DwiFOW2x5xQUiZE1wC761R1nBlLEd7lr5riCQ4e2S
         hHlcz9zez1PpZwn/qWK7BgpMHh5Xdt8cDFIdCmJAmx+zSYHw1m8thw+pNSaGQiHO7hNb
         Xq8ot3pJcRSME3JrmQT76NU1b23WmEjoTYFBoS/LWFK557cghg8S0o6WciTOkf2MeogV
         DF5VCkq/kZ1Pf0KEbheTpg7pnW7Dp2WM4Cxo+KU7TK+T9e3ZSXV2mPd7qPNzBSqx5EXv
         MCyKv+bftan6ygDwddU3P8VAgwZjGG2WHkJUwu36Ken9Pb/FdE20LihUwgH1KfotKWtG
         1cxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787244069; x=1787848869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=POqqeduVarme1JDPk/PiGoV8uXno46R5fPI2JhAIBls=;
        b=kCkfchZ906cUs8f9V3cMRe0AG0mBRKvGtokchfm2GrHL3c2/hKMXzIR77exWyu1bSN
         Z5D4ln5NF8vS5OFn5vwGn3gL4cnpX83qTecwqJCYlWbMok/TcxplE2SacYHSEbxxsqD4
         bEaiT57McD7gGO95yTHy37bL0H8xffDe/M6mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244069; x=1787848869;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=POqqeduVarme1JDPk/PiGoV8uXno46R5fPI2JhAIBls=;
        b=mbao0kCl/WKSGejJ/F1SUMAkscm3Kafxpoj43zstmWzrhau0/VE6tWc+i3tI3PMM13
         MKbcFvn654SgU1DyMpNbCOxMzAsM3AR7wW+IYT5pwk3ZEc2gA6g7tUrhCOwthxIbtqOC
         QVGIsIuOPF4WbY0uc6oZvCyQNTWU0dg+/Q+tYcJlADyVfYJGvDe47Pcp3zIyxwullE4n
         JC0BAvRLtsN8nnDT8tqWFHz3xlGM1dfgH3r8DKocYzSCcgkfQ/0OTdleB/sWhSdm4sDj
         AYBOGtySAZMIDW3j5jXSNDm01eF8QD6JvwrEAKC/vJPqmk/+LFHCxuRYbk1a+v03h0AT
         3MtA==
X-Gm-Message-State: AOJu0YxzPpQNKJKQbkm14MmsWlfjlCxZx3tSCE5MjNur1Ix6hOQtK23n
	MJz34l2uBST0zQaAzDxUgNLlR7nRxS4TgeJDIj6n0Il2npY7SUqfYzhF2auPod0IgVHixnH6MOj
	M2PKkrN+c71suc+82fvqSTVFzv4yv902+gBCL+2TB4NMEMdOs9SGBQn5H
X-Gm-Gg: AR+sD127QMZzcwB2NdOkctGVLjqlwc+OSOFTgpTgJpv0gUhjbxiN7wMXtY1Woy8tj3s
	OVK94dYGNP/1SgaAn5VVReFqP8VMX+q+TJYaFRsWk+sklSNUBMpcbkkms7KQnGROo7PWq/Z+omG
	PyY7JqLNvS24p+T3LNE4AQ1ItdWNgy1Cv7g+Wk9Tw1l2vayAEpbmsXOzuzA4yH1GKH9ZuPzj/JZ
	i5hYDxHB24e1Zsv9gmUxCj2Zczje1/W+gGMXEhzFjOYa85Xix3+jWTmt9Rt8ZForFyjrFhoanFs
	S0e9blzxoAcfosp61iEQHdvWmXd9fFTlO09xObGRew==
X-Received: by 2002:a05:6a00:4103:b0:845:3d82:10fc with SMTP id
 d2e1a72fcca58-851d34fe328mr24544084b3a.0.1787244068712; Thu, 20 Aug 2026
 09:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820095236.68390-1-jhs@mojatatu.com>
In-Reply-To: <20260820095236.68390-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 12:40:56 -0400
X-Gm-Features: AcwNN1VPI-xd-BX-vUgpsw_tMZF4mBxFPnqUd6pa8Liyc-baUCYx0j_tD9G3DWw
Message-ID: <CAM0EoMk8WU-D_gvw=McTe6eaQyFb-Mxyaf+x1DmiCbV-hLTHSw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: cls_u32: fix duplicate handle when
 node id pool exhausted
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 5:52=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> gen_new_kid() tries two idr_alloc_u32() allocations for auto-generated
> knode handles. If both fail (all node IDs in 0x001..0xFFF are already
> reserved), it silently returns max (htid | 0xFFF) instead of an error.
> u32_change() trusts that value and inserts a new knode with an
> already-live handle, breaking handle uniqueness and allowing the table
> to grow past the intended 4095-knode cap.
>
> Conditions to recreate the bug:
> - CONFIG_NET_SCHED=3Dy, CONFIG_NET_CLS_U32=3Dy, CONFIG_NET_CLS_ACT=3Dy.
> - Create a clsact/ingress qdisc on a device (e.g. lo).
> - Add 4095 u32 filters with auto-generated handles to fill the
>   entire node ID space (0x001..0xFFF) for the root hash table:
>     yes 'filter add dev lo ingress protocol ip u32 match u8 0 0' \
>       | head -n 4095 | tc -batch -
> - Add a 4096th filter with an auto-generated handle. On the unfixed
>   kernel this succeeds (silently reuses handle 800::fff, creating a
>   duplicate). On the fixed kernel it fails with ENOSPC.
> - Reachable from an unprivileged user in a fresh user+net namespace
>   (unshare -Urn) with namespace-local CAP_NET_ADMIN.
>
> Fixes: e7614370d6f04 ("net_sched: use idr to allocate u32 filter handles"=
)
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/cls_u32.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index c297d7dbcf91..13ffad47cad4 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -695,16 +695,19 @@ static int u32_delete(struct tcf_proto *tp, void *a=
rg, bool *last,
>         return ret;
>  }
>
> -static u32 gen_new_kid(struct tc_u_hnode *ht, u32 htid)
> +static u32 gen_new_kid(struct tc_u_hnode *ht, u32 htid, int *err)
>  {
>         u32 index =3D htid | 0x800;
>         u32 max =3D htid | 0xFFF;
>
> +       *err =3D 0;
> +
>         if (idr_alloc_u32(&ht->handle_idr, NULL, &index, max, GFP_KERNEL)=
) {
>                 index =3D htid + 1;
> -               if (idr_alloc_u32(&ht->handle_idr, NULL, &index, max,
> -                                GFP_KERNEL))
> -                       index =3D max;
> +               *err =3D idr_alloc_u32(&ht->handle_idr, NULL, &index, max=
,
> +                                    GFP_KERNEL);
> +               if (*err)
> +                       return 0;
>         }
>
>         return index;
> @@ -1079,7 +1082,9 @@ static int u32_change(struct net *net, struct sk_bu=
ff *in_skb,
>                  * handle which is used to uniquely identify the match en=
try.
>                  */
>                 if (!TC_U32_NODE(handle)) {
> -                       handle =3D gen_new_kid(ht, htid);
> +                       handle =3D gen_new_kid(ht, htid, &err);
> +                       if (err)
> +                               return err;
>                 } else {
>                         handle =3D htid | TC_U32_NODE(handle);
>                         err =3D idr_alloc_u32(&ht->handle_idr, NULL, &han=
dle,
> @@ -1091,7 +1096,9 @@ static int u32_change(struct net *net, struct sk_bu=
ff *in_skb,
>                 /* The user did not give us a handle; lets just generate =
one
>                  * from the table's pool of nodeids.
>                  */
> -               handle =3D gen_new_kid(ht, htid);
> +               handle =3D gen_new_kid(ht, htid, &err);
> +               if (err)
> +                       return err;
>         }
>
>         if (tb[TCA_U32_SEL] =3D=3D NULL) {
> --
> 2.43.0

Some of our long running tests have failed because primarily of the
tdc test in this set. Will resend with a renewed tdc test.

--
pw-bot: cr
