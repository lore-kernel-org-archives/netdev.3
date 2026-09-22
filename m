Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5010851FCD1
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112972; cv=pass; b=Dr4QQqpDeEeXlwmiQKxOXYP1OfcdzMqd8w/RvvWVEdGb8r1qgx5HNZ8ROC7L0FnQ2syD2BR71Phxp7uH66a9pAWFh65cZrTEKJVj6iU940zHPG17MJma/ma/o7lJxOT2hlBrOGGrYiK3ixItJJlDCts3GarmcyW6BF5QiK0X/UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112972; c=relaxed/simple;
	bh=EvbVhKnw8RPUu8cuHWn+MNXVd2g9HdJedBQyZE6JTgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/wQaCKa2kV5SGFA3H9v+Vx/wsFtKusfScSLGQvBoOeGQJGAH36Vz/7sNn2ciMtuQHo4UdiYhi4gulTwro2B+kaQdALUFR4o0bTF2azMr/GvREUNttBqv9OuPRdgDhhY7hZNyiPL/pZeiPFKJ9vP1AAYgawB07Te7I0eRgG8nCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=pRGsaBRY; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="pRGsaBRY"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469a34908so257775b3a.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790112946; cv=none;
        d=google.com; s=arc-20260327;
        b=RG5k3ouQhNQF8TE/3iTq7fJmJpjuOkWl78d3vmipEKxtoVfFc6vw5ApRLrUWRg2KYJ
         fXBjIPt1oxgSsRDt+wX/f7pgV35F1DL7mv1HbuzEzAKH4KWpt1JtGM3B/t4sjCMtMafz
         MgdzGdsd1GXN69dR2nWLdS1P24BjbEoAL0fLbv3KldPUcrjpdEhySD54WKANjoupRPZT
         cnGpHPeIW8Vbmzgn6BKJD7yh62RlI2RzkZr7jn/IRTBP6wVt6sJJTgXKEhRkeQv34Jb9
         shbh6uN2K/rjOHYNwY6exbFAGwlnfyyfyUobbR+AMeXOg+2R97yGhiL6S17zZXm1btHy
         ivqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kdPzg2Ix4c1W2P1TMypn/Rnc27FR3sHCxu3cYUG6UQg=;
        fh=+xmTZ7ykNKN9TZYPyD82apT8XDwTpB7IvSmMjCF8Krg=;
        b=RURpilLUiZ62BbJBHCDYYMmwKkizNXcQMfk/NOgBY5QTBk2PnSokNVkFmSC6UGbUAA
         t2HfxdF/+/EONjt5XiBgvZ81pnvodq9KCplGhvxBX5odAPLoiiejb8f8Vvlj30C6sGQY
         jgO5iVUdojilClq+8mF+g8FWyAAIgoChFrNizwGh/N60j4dt9xswRxIJIDrzUnvJCEn1
         kywKJVnvLzdrjTrolLDILMwESgspvTfsp5JynazIMzStTcdTOnEJClVZ+GcwTO/Wph8+
         KOBQmXeAaIpHwvzJxUjqAvr9caN9j1nVWC7LKt0/uZcW/GFUJmGiAp57WnLXdUiKDKj0
         X1RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790112946; x=1790717746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kdPzg2Ix4c1W2P1TMypn/Rnc27FR3sHCxu3cYUG6UQg=;
        b=pRGsaBRYSvxMldzbDqdEd7zA0NaPG5yV2fFyWkTysyim6pKP5b4hW+wl7ulo1n+cnr
         v9MXObxGKIz3n4AyzHuBF9WPKT045/6pIHdG2sQuId8zQtEoP29tmrW5tHOAzvsvgiDY
         bAoeDEMcAkMdlZNA9c9v2rssZyhC2DMWOFd3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790112946; x=1790717746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kdPzg2Ix4c1W2P1TMypn/Rnc27FR3sHCxu3cYUG6UQg=;
        b=mzLp47fknLYE6mJM1f8+KnMFUwea5cyJvF/j+W4gxaeESgB+O+6bSoOZavZpoqweRO
         r6ZbuWKJ23Pp0aZvBX+Eyd71LgYZuvsX7zS5ETIdaLuqrgmG8VWITeE5wPXWYcklGYJr
         Y1afRVpP5Et9+eczOMoVh/j2euchmj7/3kCXsMDBbw5K+8siv0oGpQ//jelpkTQeL1ae
         8ckQQDkXu01kUnbVL8YVjPlmPJp3xwbUZdsH/Hew6YF9LC1QuwGr3rTkQ+9ET0SO29Wo
         KrToSvmBeW5yDUurY1UK0U19Iflu8TEQBQIywUtrASy14TSHU0RhXgiN4yOXooCcxVhq
         GRIA==
X-Gm-Message-State: AFuF++nXuFQX6T5SGxWqE0zRe77NhIzg2QW3XIlWG/uzXg5oraSJgNFt
	5H75mUsfgTbJpajCsW8/Y8ynNkgbyqlqg191gLrE+bOe7kFv6CdQccWTL258k8sC5LXW2Ur1lwW
	kM5Dz4XYe2iS1V7u9hNYxEPr9ox8ZUX04X5kJwmGg
X-Gm-Gg: AYBFou3zoFdL3ki2DIs9X9j7V1LLvLLWVtVarGOUph36NdUU6j2yooieHwd6E+N3+DQ
	GQr0WJ6NacEVbN4e33MCUUMBGtPx9CCsLaTQm9EBDS8q1a+uyTo1mJPGEuYRWXRTF6HF4MiOolC
	y00agHoXpHqzvzUuXsG5iidQKKr2hQ+1LTFVFUVwl6NmWqyGfK4erFa8ZapCEWgX+RJi5nYOjxD
	jzA20MdKJVfhjCcjCuq6Fh5fRe2gJQAdQaF69JaFdoOgYBID0VljDBrtzi6elriD+muCFCg57oz
	I6o22JhxQ6oSDAk2Vuce+MYbi91LtOiC5jM6EY0IhrDFylkrVyfWhJewTrzgQM1TiLOQv2rtOZx
	4v2sVLskyM2tX1daMMYj1m6oYCroYVludrXYhukocFk7u
X-Received: by 2002:a05:6a00:44c5:b0:874:708d:b62b with SMTP id
 d2e1a72fcca58-87d1b8a15admr654286b3a.32.1790112945505; Tue, 22 Sep 2026
 14:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921145655.3167436-1-i.maximets@ovn.org> <20260921145655.3167436-6-i.maximets@ovn.org>
In-Reply-To: <20260921145655.3167436-6-i.maximets@ovn.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 22 Sep 2026 17:35:32 -0400
X-Gm-Features: AcwNN1WPL-vgVShl6hqSyik6C8tmu3eMWMaigjhCeY6OG6KGXvvi-22yq5biirU
Message-ID: <CAM0EoMk96wo2-kupgidntihfxij_zffq2v=ddH-mGUNUH0q7Wg@mail.gmail.com>
Subject: Re: [PATCH net 5/6] net/sched: act_ct: remove 'add_helper' dead code
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Xin Long <lucien.xin@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:57=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> This variable can only become 'true' when the connection is not
> confirmed, but it is only checked when it is confirmed.  So, it can be
> treated as being always false and just removed.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
>  net/sched/act_ct.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index e72143d36b119..f62051ec9d57d 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -986,7 +986,6 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb,=
 const struct tc_action *a,
>         struct nf_hook_state state;
>         int nh_ofs, err, retval;
>         struct tcf_ct_params *p;
> -       bool add_helper =3D false;
>         bool skb_is_ours =3D false;
>         bool skip_add =3D false;
>         bool defrag =3D false;
> @@ -1096,14 +1095,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *=
skb, const struct tc_action *a,
>                 err =3D __nf_ct_try_assign_helper(ct, p->tmpl, GFP_ATOMIC=
);
>                 if (err)
>                         goto drop;
> -               add_helper =3D true;
> +
>                 if (nat && !nfct_seqadj(ct)) {
>                         if (!nfct_seqadj_ext_add(ct))
>                                 goto drop;
>                 }
>         }
>
> -       if (nf_ct_is_confirmed(ct) ? ((!cached && !skip_add) || add_helpe=
r) : commit) {
> +       if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
>                 err =3D nf_ct_helper(skb, ct, ctinfo, family);
>                 if (err !=3D NF_ACCEPT)
>                         goto nf_error;
> --
> 2.55.0
>
