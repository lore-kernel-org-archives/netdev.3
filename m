Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9F4EDCA7
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109867; cv=pass; b=kBCNMSzRlRTFhLWubpPvBDJyE9Mbx3Qubw48DZRoPGWXzADAVPTpwbFEWlIbAeE1TdTGSCnjd+pD5wFjmd8BFUIzD1H+PLMVFzD+4uSa8XzBmfwM13ZtCd67vaKqXgPuxQpNFWCBAQQsda8z/ddqP/w7hsZyFJoF4ZOkGh5hYow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109867; c=relaxed/simple;
	bh=P+lcMuK5hQh5O0IlQrlqy9m+daoCKm3PxvImyC7y6p0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cN7bPfNVpCC2tc9stxXymXgr4e6ImymZKdEl0fUB+QVTh/rBrhhMQaiLxY04LQcqLCScqvcJMQwyr5ixQm3CDjLqZq5nAfDd9r3Xk/5TqXHWir3jGUZpWDfXndhtBCY/QrvY7OfffXpP1aXBZHgE1wS+ghAsMjN4cjfxHijKgBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kN3AtHDp; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN3AtHDp"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5256c2a4bso210955a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109842; cv=none;
        d=google.com; s=arc-20260327;
        b=m41dFDmxSvPgJdxncrzjFt9WYJwuD6pYXaON5FTn0BkQACS5sSUXwy3L73761RI49d
         RwwlN9FELaS+0s6qsd08yXQG8iPAj3focpLnA5XUHuJvTLHT2R0TVgXWgU8UPrh42MOu
         DnPGAgQGAbnz9gVfnMI8dHE8uPnr2ctJJmZVJUtdT1ZsyCd8KTdK50Fp9Gc7W/42WzMm
         xfeY3neVVAxnnlxem/vXQPR+RQLbquEyjU6+HyzW9yAEOEHI+Dgb3gjcWGKDsBDf41N8
         sYYBYLxozUXfsQsDJZy7jv0U7WtXkHBofoabI07jeppkgQ+zshIPBz315asoIswtFzEx
         bAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9uOUnWBMatAL9szZ+HFkI4Lili+9ziWjf14eBlgXmc4=;
        fh=/8v+YHaMs1F6G3Gyv5g+3Shvs47IgpH+CZ3yYGAJswQ=;
        b=K8dbLPcg/YisnblaMBE4L4bw+QOBLuEMbOMjbZrzD7p0h3TjM+NmAQUSFXk+cOwIhn
         cGoXG5vnu7TFCIiIrT5iu9SqcY1i7i49xiBKPmL573irN2x0qhAUSLYfs013kKQczxDw
         bvFKS3D86GoMp7gXdSBvwlT2o7NZ9IPZ9vCojPBJEmtI6g8WyT8CmKGLtsP3AcYuiTIw
         DAJXnj7Urr8SUlprbcp5gIXkAJbhTVNTgTaqOFnw1hFnq8sFEJPl1BekBhtCaacEE7MV
         yoybJ1pN8YkUcKEscwG/8qJTM5bbfpybmEDuRz1hRf/LYgbO4fWOu6nYdEQTAtJosK3e
         hxrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109842; x=1790714642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9uOUnWBMatAL9szZ+HFkI4Lili+9ziWjf14eBlgXmc4=;
        b=kN3AtHDpVGwD+cwN/jEw0l059yxgDsYK/hwZ+xBcqWCvp/+PVZH8oiBYiOH9R+Xiwm
         shE9VjxZEllX95TKkzPfgAtVsJBVqe7g3antDH+WhsalUsopqvTIgrmPo9AUKi2SucYn
         6N2sHsFmhe290cp9GtygvUG9DOuBrqFgQhA5sP7g2edfEq3Rdj1BVm6Wgs96JRev4T69
         Sygz6yfy3MEAfBVxoXEyg/q9UQJoA9xuBnjY9qash4Hqznh6YpPTlYT9BTM0OHSVK9g3
         6T0nWp9czZq35/P26b0M2egkhf+RYRKxXOZLqWxvU9NXhnZplRaoEryIMmuFugH6laF0
         1UeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109842; x=1790714642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9uOUnWBMatAL9szZ+HFkI4Lili+9ziWjf14eBlgXmc4=;
        b=sYRae6f5ww/Q8ZE+edw68NFcPR6K/x6wIYTlj/GHTB/ZooN4X6Jzkw9ETJMQgZ4wMn
         sJvh79sm2jEC81LgBQSCqVWhVqlWD8uufKwGDDE60V+PPyrzCdRWAk3EpQtlfkkt8pfL
         ybRXIFqWjo1B+vAEV3guvimhbsWXFTMCebb+224KTKr8jDdeX0jytN2wLmIL/dxa4kTm
         bglpypTWUi3fDPAlSSH1izHAJ2WvePHaeY+vGU5ESBz4jJdNB4ONNF9uD3ol3y1+Uusk
         Jt82VN3y4KXSkYNhZQb2/HqqIBwz/aC8xjd7acjJu375AJUC8usN6YpP1b0ea4GCIMoz
         R8Cw==
X-Gm-Message-State: AFuF++l/Wx0li6wADe4vAemjBjHMLvA704QXZsIiDW+pqOTb5pJzBI76
	BQI48IjvaJGDG34uYopWwNG4KXsDJGxWRsZqlcBaIswwQqgSKG6ZhSUk5VMKQLfSYFLIC3AmdFs
	HyP45uz1xu13Iot/+fmuNr5JIJcOxLN8=
X-Gm-Gg: AYBFou1eYEZaUEAuhraZjPOgvb7/1VxQFty5JiSZUapduI2reGq76Q0MLa3fnMIDjJi
	gakA0VJXrwzkkHV/x13LAvbxkwrvivsJdDf1Ohyu+eRYmfTJIEoLKoZ++YtMDQCEK1C6N9xQpnh
	URnUIwHVtUok3uEV644XsAPBXKKgHHsT01gh9iI1OBlM1d5+13NKE/zCvABHg4HdX+7nfKBDJmj
	33wbstlTLL2Tx1q6gTyd9UiXEZv8ErxDqhJUAh3fXR1wAqoUvjL0Do5zGQcmYyTuPF/dOj6aBCl
	HQSjL83H2Ywf7BUxZVdDWZJAYmLGECqUTPq57uI8n5O24bCFlbNlnBkRjn8S0A89eZ1vIqIUzRa
	qSycYREdm8kOoJEWnYxZTAMHvUEtnH99BxfblnONm0iHjoDTIDQRyBGxo7bl7rEll
X-Received: by 2002:a05:6a20:7293:b0:3dd:85aa:4527 with SMTP id
 adf61e73a8af0-3ddf82adf58mr565061637.34.1790109842514; Tue, 22 Sep 2026
 13:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921145655.3167436-1-i.maximets@ovn.org> <20260921145655.3167436-7-i.maximets@ovn.org>
In-Reply-To: <20260921145655.3167436-7-i.maximets@ovn.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 22 Sep 2026 16:43:51 -0400
X-Gm-Features: AcwNN1Wxvg5q08SpmktKVndNHz2CGqilUY2VDTceI09JMLfUxf8v9o9CPku839U
Message-ID: <CADvbK_es1LF3eAnX2iTfZKeCxWFOt8cux+9F8E9OSN55SQuc-A@mail.gmail.com>
Subject: Re: [PATCH net 6/6] net/sched: act_ct: fix helper UAF due to
 extensions realloc
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, dev@openvswitch.org, 
	stable@vger.kernel.org, Axel Mierczuk <axel.mierczuk@1password.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:57=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> While calling the helpers, a raw pointer to the extensions area is
> wired into expectations list:
>
>   -> nf_ct_helper()
>    -> helper->help()
>     -> nf_ct_expect_related_report()
>      -> nf_ct_expect_insert()
>       -> hlist_add_head_rcu(&exp->lnode, &master_help->expectations)
>
> In case the connection is not confirmed yet, more extensions can be
> added afterwards with *_ext_add() calls reallocating the extension
> space and leaving the now invalid pointer in the expectations list
> that is later accessed while removing the expectation.
>
> Make sure that helpers are called at the end after all the other
> extensions are already added.
>
> Note that the helper rejection now leaves the mark and labels set,
> but that's not different from how the NAT was handled before or how
> the mark and the labels were handled on confirmation failure.  And
> there are no atomicity guarantees provided by the API anyway.
>
> Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
> Cc: stable@vger.kernel.org
> Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/sched/act_ct.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> index f62051ec9d57d..411e3dd92d072 100644
> --- a/net/sched/act_ct.c
> +++ b/net/sched/act_ct.c
> @@ -1102,19 +1102,25 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *=
skb, const struct tc_action *a,
>                 }
>         }
>
> -       if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
> -               err =3D nf_ct_helper(skb, ct, ctinfo, family);
> -               if (err !=3D NF_ACCEPT)
> -                       goto nf_error;
> -       }
> -
>         if (commit) {
>                 tcf_ct_act_set_mark(ct, p->mark, p->mark_mask);
>                 tcf_ct_act_set_labels(ct, p->labels, p->labels_mask);
>
>                 if (!nf_ct_is_confirmed(ct))
>                         nf_conn_act_ct_ext_add(skb, ct, ctinfo);
> +       }
>
> +       /* Run helpers for the connection if nf_conntrack_in() was execut=
ed
> +        * or if we're about to commit.  This has to be done after all th=
e
> +        * extensions are already added.
> +        */
> +       if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
> +               err =3D nf_ct_helper(skb, ct, ctinfo, family);
> +               if (err !=3D NF_ACCEPT)
> +                       goto nf_error;
> +       }
> +
> +       if (commit) {
>                 /* This will take care of sending queued events
>                  * even if the connection is already confirmed.
>                  */
> --
> 2.55.0
>

Reviewed-by: Xin Long <lucien.xin@gmail.com>
