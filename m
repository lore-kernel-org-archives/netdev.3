Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D8E400E0D
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791762412; cv=pass; b=f3bOsoPvTNjmGnxLwwwST1E2mc/P6dlbwYHi0D+mjsIe5YCEV9559DmnbslMJNfCRTfSEw5ncxgfF8RiXZdR6ZdhpIFXv+og8PQmUf3TVP09rwfAbPh8EJ51Mv1cO2C0VSnISCr3wvh9wpnVMVuA/dBSDl1/05e2KCvGv5iRzRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791762412; c=relaxed/simple;
	bh=BRj+LKfnehsjDl/PKtVEYHuWbB8hMyAaL5EdDVQCgKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiHUoK/6qqY3J0CBhdMf0pxTcdjE+Po6EYkSXekJCrcx0gGkgCydKvxXyHQfMLqw0S2rxU0PtrqV2kOntL7+y+9hR528GfDWKFBMHSg9b7qdujKXoWIzt2D3D0ahXqGJIbO2r2v20gGB1EVP/hAH9NdHiqht0RltbxPd6noYQzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=MXAg/T3k; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="MXAg/T3k"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-890d52c7c7bso1129299b3a.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 16:46:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791762409; cv=none;
        d=google.com; s=arc-20260327;
        b=SX+Le4Xu5at1uMbixq0zRGvHMb2YZhbQsDmKEnTxf8v01p4NMiiDRhiKBrggMMVgdp
         EW5dh+WOyVX44qPCLjjm1oWhnL9N28bQ7FL4XmgL34Dhfz8Pkw+WjPuom9L65vnZp0iG
         9OTwjqFXfgYm5Gi0pNdqW1WFspFEMMiCX+hR8+BUFqGYzFAiT1fPxe/TiTPZWAxHaWw+
         TZBlQEEEVhFCT/LBrTD01KKr4X1tuuDcUQCsBJ7sIcjnpPaXds9G5imNwPIL7bhBxYUc
         EATSvHC/Zx/vR0o6GoY7onSBGbV7+gxraGfUgFsrWO/cmrerbZLABlaltWVaa1wyhTJo
         qkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KKgmFOu6bVAbbbCc5+OLEESffaB1jRdaI14yS1RT518=;
        fh=qSN8Tu8kUMXv0dO3DDS2w+kh7gvrT9lKk2YqT5YMO8w=;
        b=VQ6R4sR4tzlN4iTIF5cwYZV65iQwL2CIQHDtcYUa/e2hNFO4xrwsWouhpV71c7AaAG
         o94NiiP5RhyNy+aO6ICF+Vy7Gv1x0qPljJsPZu6JEfo4Os6SXJoCGZklyzbNC7mcpW8x
         x248MCT4WQvNpPREymDcbNriG2obrmKc1Ax8RqHJ878BY2QCmN3sMLZLZYdXEi9hvMz7
         ckocoYlvF4MDc0aMO/KgaDEnw1sJDOPHjeOAtdAo7hhN8AsK4Z99VQYC7Y6p5Zm9j+wb
         kCRkR7Ytji4FibkpbZd9+LOw39HkENv+0V1Qj4aQGrKE9uhdWLWxRFWghRiIEVo/YLEL
         FQ8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791762409; x=1792367209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KKgmFOu6bVAbbbCc5+OLEESffaB1jRdaI14yS1RT518=;
        b=MXAg/T3kybt7183nBRUChErctYUZl4OwvWFwoQo+7WcuPptSwwgIWJiSbw23Um9pSv
         Ww6CrQtfGrrFdGb447dZVhs7w69FFPX/bwP4MGfRMDHiFN0rhbXBJ/Pihqo2FxDGC4z8
         ulGd+TdFVTpzyKkNkiJqE4h/zW/uKF1vo+TgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791762409; x=1792367209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KKgmFOu6bVAbbbCc5+OLEESffaB1jRdaI14yS1RT518=;
        b=hUQju12TNqgK5ve0SlJYivlkyuttoqUR6h9QB+qpLq6udhEX5aX96uBPXd8po2kpmC
         DQfwokH4uAFkVK2IwMvj14RvQcsiNCxr6ygxCLD+H9qN8flggwos2fSu1EY4HhZ5QEJm
         UhClh8T0Ehp0RXPOLYBxHzTeGHZ7j+KN3JXPTzXwjhZcIWwZ8zAe0mDe3TisuG/KGwbi
         ZiDoiX8eQxAur44Sg1SdOrm2EeRURY7PKFzShtDzufBg6h23FLPsEBwEuKA+9+EvMYco
         TXB9bAwSu+OHIO33TyALVEFkGZ9cC/Ok1AZZhD5SUu94vV/TBbzVElPjad3Ft+8XzD6S
         IOmg==
X-Forwarded-Encrypted: i=1; AKwUvBzDiBWtLyqIg4fnEVBBbPTP834zABA+zX6l00ggIDdtkg4cnnviC0b1CIkLL7+/gRceOK6oHUY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhCZnX5VadA1gmbkZoCevX+6DLxRYn1btZcjcSRvQEbBAdDPyx
	fwTVZFXFFY5sdfEzk8IqKOnxb0ynpkCKo2u+T+lGLVEk/KzmywJCn7XBz56G2DLYSqdqAoo490/
	Y/HE9cETRbArpdpqe/tW/tW0ysMzahGnK7JUm1ito
X-Gm-Gg: AYBFou3I5z50vm+8uCET2/cKNnt1GPIdg+Gan1YIH1fp/+75iaLn52KgtWB1B2x9amE
	fS9xW9GvID1/RFIPJtg/NxG1nu1Qcrgi9eXKCYDStxpUrswqoktQlsHnNhh0LiVpvw1CcP+L4VE
	ldoRU/8KvFfNMqUmHbhY6LFohJxDwRqEPtVVEGZycpXIxQCj5NUT5CNiaNSNVRCJq8Nga6OU9K/
	82ipApZeeK90d+iT9SrgYL0w0J86nad++DfDmpTcW22NkyHpfKTZEELoEARfFuVm/X7h1GutfYF
	deuo0/C/gIQCyhmuZVdf15H58Frzg6Ph5GtKteOTzR7b2uBLm9VYdNXai3quC7BiCfs7P3+aqS5
	YMescJQn8qC9kBsZPNUebhF/AgeTTBWoF5w==
X-Received: by 2002:a05:6a00:17a9:b0:893:1336:481d with SMTP id
 d2e1a72fcca58-897c76e3c04mr7088669b3a.24.1791762409068; Sun, 11 Oct 2026
 16:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-H19Z.v2.20261007062551-3@mojatatu.com> <179171627521.434549.2707902365679392275@kernel.org>
 <vPFrhbkwAui8zFPcGQTUDazQfsFDlr5GYuaYQ5BxJcrDiT6x1EljEze4cYadHqbeUW2ivLdpa8eC_cXC6ceACswgb-lW47aSVkHvHjhn_X8=@1g4.org>
In-Reply-To: <vPFrhbkwAui8zFPcGQTUDazQfsFDlr5GYuaYQ5BxJcrDiT6x1EljEze4cYadHqbeUW2ivLdpa8eC_cXC6ceACswgb-lW47aSVkHvHjhn_X8=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 11 Oct 2026 19:46:37 -0400
X-Gm-Features: AclHuK-Hca3Oo7y22WkV-IQ7NAr03GdhhTT89LU4SzyRqKnf6bnxpVjip1zAEao
Message-ID: <CAM0EoMmWDYmJjTGq8t7bdS9-rzd-3o0qQvsw4OKMwPCD2JAsFQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/sched: act_gate: cap the number of
 scheduling entries
To: Paul Moses <p@1g4.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, olteanv@gmail.com, 
	vladimir.oltean@nxp.com, eadavis@qq.com, dcaratti@redhat.com, 
	dsahern@kernel.org, stephen@networkplumber.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 2:56=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> > [Severity: Medium]
> > This sizes the cap against the u16 nla_len of the nest. Should it also =
be
> > sized against the largest dump skb?
> >
> > netlink_recvmsg() limits the dump buffer size:
> >
> > net/netlink/af_netlink.c:netlink_recvmsg() {
> >     ...
> >       max_recvmsg_len =3D min_t(size_t, max_recvmsg_len,
> >                               SKB_WITH_OVERHEAD(32768));
> >     ...
> > }
> >
> > For RTM_GETACTION dumps, netlink_dump() allocates at most about 32.4 KB=
.
> > dumping_entry() emits 36 or 40 bytes per entry. A gate with more than a=
bout
> > 810-900 entries therefore cannot be dumped, and the new cap still accep=
ts
> > it.
> >
> > When this happens, tcf_dump_walker() trims the action and returns witho=
ut
> > an error:
> >
> > net/sched/act_api.c:tcf_dump_walker() {
> >     ...
> >               if (err < 0) {
> >                       index--;
> >                       nlmsg_trim(skb, nest);
> >                       goto done;
> >               }
> >     ...
> > }
> >
> > If the gate is the first action in the skb, n_i is 0. tc_dump_action()
> > then returns a skb->len of 0, and netlink_dump() sends NLMSG_DONE with
> > success. If earlier actions fit, the next callback restarts at the gate=
's
> > index and ends the same way.
> >
> > The result is that the gate and every later action in the IDR are missi=
ng
> > from "tc actions ls", and userspace gets no error.
> >
> > The commit message lists this truncation first under "The bugs:". The
> > Caveat Emptor section then says the cap does not prevent it.
> >
> > Should the cap be small enough that a single gate fits in a dump skb? I=
f
> > not, should the commit message stop listing this truncation as somethin=
g
> > the cap fixes?
> >
>
> This is the one I encountered, not that the cap should be smaller or that
> this type of dump needs to work, it's confusing that it returns 0 and sto=
ps.
>

I will look closely tommorow - if i can reproduce it i will add an
extra patch to address this (already adding one for taprio with
similar issue i caught earlier today).


cheers,
jamal

> This needs more review with regard to other callers but to give you an id=
ea.
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index e45a63be397c..4dfc050c48c4 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -589,18 +589,13 @@ static int tcf_dump_walker(struct tcf_idrinfo *idri=
nfo, struct sk_buff *skb,
>                 tcf_action_update_hw_stats(p);
>
>                 nest =3D nla_nest_start_noflag(skb, n_i);
> -               if (!nest) {
> -                       index--;
> +               if (!nest)
>                         goto nla_put_failure;
> -               }
>                 err =3D (act_flags & TCA_ACT_FLAG_TERSE_DUMP) ?
>                         tcf_action_dump_terse(skb, p, true) :
>                         tcf_action_dump_1(skb, p, 0, 0);
> -               if (err < 0) {
> -                       index--;
> -                       nlmsg_trim(skb, nest);
> -                       goto done;
> -               }
> +               if (err < 0)
> +                       goto nla_put_failure;
>                 nla_nest_end(skb, nest);
>                 n_i++;
>                 if (!(act_flags & TCA_ACT_FLAG_LARGE_DUMP_ON) &&
> @@ -616,10 +611,15 @@ static int tcf_dump_walker(struct tcf_idrinfo *idri=
nfo, struct sk_buff *skb,
>                 if (act_flags & TCA_ACT_FLAG_LARGE_DUMP_ON)
>                         cb->args[1] =3D n_i;
>         }
> -       return n_i;
> +       return n_i ?: err;
>
>  nla_put_failure:
> +       index--;
>         nla_nest_cancel(skb, nest);
> +       err =3D -EMSGSIZE;
> +       if (!n_i)
> +               NL_SET_ERR_MSG(cb->extack,
> +                              "TC action is too large for the dump buffe=
r");
>         goto done;
>  }
>
> @@ -2260,6 +2260,7 @@ static int tc_dump_action(struct sk_buff *skb, stru=
ct netlink_callback *cb)
>                 msecs_since =3D nla_get_u32(tb[TCA_ROOT_TIME_DELTA]);
>         }
>
> +       ret =3D -EMSGSIZE;
>         nlh =3D nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg=
_seq,
>                         cb->nlh->nlmsg_type, sizeof(*t), 0);
>         if (!nlh)
> @@ -2303,7 +2304,7 @@ static int tc_dump_action(struct sk_buff *skb, stru=
ct netlink_callback *cb)
>  out_module_put:
>         module_put(a_o->owner);
>         nlmsg_trim(skb, b);
> -       return skb->len;
> +       return ret;
>  }
>
>  static const struct rtnl_msg_handler tc_action_rtnl_msg_handlers[] __ini=
tconst =3D {
>
>
>
