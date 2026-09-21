Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B390F2571A0
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789953074; cv=pass; b=N6cUX0fWw5xVZfnrWVFhGhp3gMYOgOmn5xYx3PP4A3fODma8GwplDqdsZFJFy719VvBA80zn6/JnpOojqVhURfj/E69ek7Nbnh2FU0Nkq4jFsLPgLqYM6SMFxF5b0zKJywDo85yRj2FtxmqdQUOUjH6UhbSfL24uC/0YjCCKReI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789953074; c=relaxed/simple;
	bh=vqSNtO5meV4+WE7DqbwAyZZIifzcRSiOkZ5BFW9yVaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOFo8PDUBG5zYoQ0V/5o/qTHy6UjG3VUsxfwnlMNIfyA7HC0/2eWcDx8bCv6px4B/qXi0YWDWopCZokyhgeKfSuS8ZPpIhElnGssQODMu5mml/SvF2uO0mWEYVdY2Igfnf6G2vQ1YHjBpuW+yj+yL+kAYsNm2+jxFq3KH3HNCp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcxXH3Zs; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcxXH3Zs"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86e6d007703so2048581b3a.0
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 18:11:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789953072; cv=none;
        d=google.com; s=arc-20260327;
        b=e/8tGxWYgZd/P6yNPyEf13hJ2qlNosBjJUa+mS4aSGtfwbeduDobFATLRZhRKpCL4x
         ebAIpVEU30SzLCStmTd7yRNQyAxji7kyind8sAUiyLPxLRrv2DaZad2Fv5lQ/FACLT0v
         dnZU88Vfyr4zhcHXX1kHqs102l39R8alZECeXEKZwSzjKNvVuZ3iUx5VLAcLR0GyyGxd
         XpWGw0+9gUYq2HhGTE8Cf5IhBJxsVmgeZqcgzBzjeEGxHWSf/VTx9Q9UIWVNZwYPxgkW
         Cqu0vzZUQiLREH2c4qJL+re64Cxd7qffkgXBzB4abIcHmDp0+Pd1PY71jobkzknW+HhC
         QHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vGHQdXbKnraga4vIbrqTjYF7kHOHm2BrE5St1NlOjh4=;
        fh=hRq8U/jDwE1WMd1E6z+ZlFyQV3WsvEaZcz7gN6jKvBk=;
        b=c2wdFCWX6Rjl6NbpxFsGp9MsMkZeq0NwRFd9YoOhm/Xf3iNhogkt3oNc9X3Yd/Me9z
         rBhafbp6KAXWZXf/42x3F6TswRtG1IW/DvY/+0IUD4YpX6cdFNvJJD1l6iJtit5tHesa
         l3IqVVHqtTRELpPh8iaQgI6wE0rmA2nAEF1jmJSF4Cqy5SQWzSjL5EK2RFzz2WixZ9AZ
         chbjFUXqwiZaC1i/LVjez5agSlf+gN5437fklA9GA9Ear9x3XuhiGe/eulBrbzYtRnHK
         kTSDEMQusEPC7rXGI7GrRSGk5Kerlez2lY9/5xilNGIUCHLn+IfRX4zsn0NNXwAlHfUZ
         1yWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789953072; x=1790557872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vGHQdXbKnraga4vIbrqTjYF7kHOHm2BrE5St1NlOjh4=;
        b=AcxXH3ZsGJPclkmKNeh02pYkKnjDt6sXrrW/Uojdq61t9Nw1vx+nC9l7mybm/JrR26
         64G+MSZ7xA+JvRjWNJ4/rh7hT1YzUdz399FByjk38a5qp3xhy8rUh9J4VX07L9ySFsXo
         dBQ/2TnIXvOOxSBQyyD7qAcdZ66dm9CgmWwuk5SwiOK/iBDlwV74jJfpVFW75XS+R2J9
         NosfTZ5y5NTuR0EqijQa1wIAkUHYSxiwSn9nTv9aG7LZYwKNs2qS30qLD/VdGIPEE3+U
         hojoPuWuiyzPHv8cSbktvrgF2hUdEGT3p+f2d9mRXUjgc98j8QHtuX08jn5lE0mGorJM
         sW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789953072; x=1790557872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGHQdXbKnraga4vIbrqTjYF7kHOHm2BrE5St1NlOjh4=;
        b=TuYhhmxb9AVcTg1iiw3fYeWRtWZy5leoaUozTpswvLX3uXD3iLqqq1hoZTMZuwOiED
         KtfXR7jRsUzzyXtQaF5k1gABR5cR+XF3IthfPCFC7GIk7mF9kw2tuWTZBSS8QgNoBNR+
         UUz5KTJPrc1G9sNGeESf8KSN8YvvpgchoN8TIF+M8EV0GA2+8eSco8GxpBlvz55GQJx6
         PODoS2dX8T/pD294trHwVkFCuXNssLIg++1mQDBpOzzsQpQ7arGhRcGr+dg96KeRH7LL
         sQ1xQ7aPISxbPuFtGT7YlT1eDU8jmN24IdSGXJuB+X4LCBfCxoIaKYtC4+FLMatxr9Wx
         JprA==
X-Gm-Message-State: AFuF++m1wrfpqQGLpNp7ZhLdDfpsLO4tow4fc57cGeEbgR4V/7VTFa6i
	SMZ0etyeahTqTlOB8uXOOo+UrtJpd9ICnLW+qkpXEzPzm+DTeXIEmq/vY2tqzG97BhvIz0EcOMd
	8mmmGVQlBNdDZfazEGwT9KlxrIgvQqO4=
X-Gm-Gg: AYBFou1sUy1IaHfqdm66VT7T0NxZksjfztHP4vr7bTveS+OgaKRQrIqIeYvvDizaSQg
	2Tlx0egOb6PCuA6FveEiOekqLmQJ/mC22NrutHe2VrTvK3mZgUhE9S2ymb8h7QSudzJCd3JLgFG
	uB+g4lYq7ZJ8KJFohipkam5g1XV/nAxmtwf7K0K9Mk4rHubnvdJn2DUktiGIxnaT6TnEMA5eaMJ
	l0RhBtD7csVYTwI86sTd92hquHUPMdnayD5COiJbLx8y+PnclCDgpWLoq93Q6qcSEdkWW2XhCLK
	MWpwgjWVjJeFR/OqthJoVMMV2+wmcmk/oTRi5BRf/Z3dcjQAvSUsWJHiYEf4MSS9BN+A+wJ2CON
	Gbky6wVv6/XJIrBO3wlJOqHdqOeuzOwvl/8vzr/eLccRVeMqFWim8
X-Received: by 2002:a05:6a00:8089:b0:878:3830:a487 with SMTP id
 d2e1a72fcca58-8783830a797mr5720424b3a.55.1789953071869; Sun, 20 Sep 2026
 18:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-4CSL.v1.20260917072652@mojatatu.com>
In-Reply-To: <QDISC-4CSL.v1.20260917072652@mojatatu.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 20 Sep 2026 21:11:00 -0400
X-Gm-Features: AcwNN1UI-U9ZqzZRxGhcIy7flkhSjNQcvMfpBQ5kFBv0ac2yJrxJgEr6og10bsw
Message-ID: <CADvbK_e0-1JsCSMAQXGP3yxrvmtJDvG3TBShft=EfLKEGkBR=A@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_flower: exact-match ERSPAN key when no
 mask supplied
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 5:51=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Commit 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
> removed the unconditional memset of the erspan_metadata mask in
> fl_set_erspan_opt(). On the mask-parse pass, when userspace supplies the
> encap option key but no mask (TCA_FLOWER_KEY_ENC_OPTS without
> TCA_FLOWER_KEY_ENC_OPTS_MASK), the !depth early return leaves the mask
> zeroed -- a wildcard. A filter keyed on an ERSPAN index (v1), or dir/hwid
> (v2), then matches every ERSPAN packet's values instead of exact-matching=
.
>
> Mirror the with-mask per-version defaults on the no-mask path, keyed off
> the key's own version: v1 index to 0xff, v2 dir and hwid to their
> exact-match masks. The mask cannot just memset the whole union -- that
> would re-mask the overlapping timestamp/sgt bytes of the v2 header that
> the fix (292207809486) deliberately left to 0 in erspan_opt.
>
> This is a follow-up to commit fee10655709c ("net/sched: cls_flower:
> validate mask pointer after nla_next()").
>
> Conditions to recreate the bug: add an ERSPAN encap-opts flower filter
> with a key but no mask (raw netlink, TCA_FLOWER_KEY_ENC_OPTS present,
> TCA_FLOWER_KEY_ENC_OPTS_MASK absent); dump the filter and observe the
> match mask is zero (wildcard) instead of exact for the supplied fields.
>
> Fixes: 292207809486 ("net: sched: fix erspan_opt settings in cls_flower")
> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/2026082602512=
3.62758-1-ljp1205831794@gmail.com
> Link: https://lore.kernel.org/netdev/20260826025123.62758-1-ljp1205831794=
@gmail.com/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: hybris <hybris@mojatatu.ai>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/cls_flower.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 1cefea571efd..f5acdeb0e2a6 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -1358,17 +1358,29 @@ static int fl_set_vxlan_opt(const struct nlattr *=
nla, struct fl_flow_key *key,
>
>  static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_ke=
y *key,
>                              int depth, int option_len,
> -                            struct netlink_ext_ack *extack)
> +                            struct netlink_ext_ack *extack, u8 key_ver)
>  {
>         struct nlattr *tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_MAX + 1];
>         struct erspan_metadata *md;
>         int err;
>
>         md =3D (struct erspan_metadata *)&key->enc_opts.data[key->enc_opt=
s.len];
> -       md->version =3D 1;
> +       md->version =3D key_ver;
>
> -       if (!depth)
> +       if (!depth) {
> +               /* No mask attribute supplied: exact-match every field th=
e
> +                * key set, keyed off the key's own version so the v2 dir=
/hwid
> +                * bytes are masked without touching the overlapping
> +                * timestamp/sgt bytes of the union (see 292207809486).
> +                */
> +               if (md->version =3D=3D 1) {
> +                       memset(&md->u.index, 0xff, sizeof(md->u.index));
> +               } else if (md->version =3D=3D 2) {
> +                       md->u.md2.dir =3D 1;
> +                       set_hwid(&md->u.md2, 0xff);
> +               }
>                 return sizeof(*md);
> +       }
>
>         if (nla_type(nla) !=3D TCA_FLOWER_KEY_ENC_OPTS_ERSPAN) {
>                 NL_SET_ERR_MSG(extack, "Non-erspan option type for mask")=
;
> @@ -1509,6 +1521,7 @@ static int fl_set_enc_opt(struct nlattr **tb, struc=
t fl_flow_key *key,
>  {
>         const struct nlattr *nla_enc_key, *nla_opt_key, *nla_opt_msk =3D =
NULL;
>         int err, option_len, key_depth, msk_depth =3D 0;
> +       u8 key_ver =3D 1;
>
>         err =3D nla_validate_nested_deprecated(tb[TCA_FLOWER_KEY_ENC_OPTS=
],
>                                              TCA_FLOWER_KEY_ENC_OPTS_MAX,
> @@ -1607,9 +1620,11 @@ static int fl_set_enc_opt(struct nlattr **tb, stru=
ct fl_flow_key *key,
>                         key->enc_opts.dst_opt_type =3D IP_TUNNEL_ERSPAN_O=
PT_BIT;
>                         option_len =3D fl_set_erspan_opt(nla_opt_key, key=
,
>                                                        key_depth, option_=
len,
> -                                                      extack);
> +                                                      extack, 1);
>                         if (option_len < 0)
>                                 return option_len;
> +                       key_ver =3D ((struct erspan_metadata *)
> +                                 &key->enc_opts.data[key->enc_opts.len])=
->version;
Do you think it would be better to pass &key_ver to fl_set_erspan_opt() and
set it there, avoiding the dereference of erspan_metadata here?

Thanks.

>
>                         key->enc_opts.len +=3D option_len;
>                         /* At the same time we need to parse through the =
mask
> @@ -1618,7 +1633,7 @@ static int fl_set_enc_opt(struct nlattr **tb, struc=
t fl_flow_key *key,
>                         mask->enc_opts.dst_opt_type =3D IP_TUNNEL_ERSPAN_=
OPT_BIT;
>                         option_len =3D fl_set_erspan_opt(nla_opt_msk, mas=
k,
>                                                        msk_depth, option_=
len,
> -                                                      extack);
> +                                                      extack, key_ver);
>                         if (option_len < 0)
>                                 return option_len;
>
> --
> 2.43.0
>
