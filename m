Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF684F4D09
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109825; cv=pass; b=RZthfS+I5uq7bUhI+7W1weKMOfvpFc6UCGgHDZ0AqmuGgN2vLplefpH5B51u3JdaZEiXAS1byqHAIvd3GjYl6RRC3ZNTUL0jGQcPhDwE+VygRGu+huCQkLDV7uQg6F/9SkgpJ5faD3lyW88AJIUH6GSeG6uXyoEl7UXXJ0z4kn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109825; c=relaxed/simple;
	bh=p21WGTeF5sTqb4Jtihp5eAQjvRYAP+4+Ui1owmVnpJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qn0R8mUP2EB8AhtovnCqnzH5nyKXtrr/pb411j2pu9O2z/ExCNQnNlK9rPn26LIHbNLMCOnLFWJ0Y0D0RmvLEQr4Wa4zeH1CPU0mG1bKD84+74CXP0WRj+fDsr4Y16FWAfg6KlNJrNCMAI5qEbhyWnyydFY3EWTVOJBQRaxgZPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KahFfhVA; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KahFfhVA"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8674704dab1so339974b3a.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109818; cv=none;
        d=google.com; s=arc-20260327;
        b=LP8ua+eIDBE9qjTcR1bjmsluvM91VJIR1ryrhV3nXVXnWywHhpB+7oCbd9OvkR76EV
         +AzvIvxOhrxs5Cb305nEU6oWPTAPq3+sG27euAqCSmqt69s4u5y/uHPkRQ3eW/PRXZum
         AqRF6kN11tuy6vXpA9baWBfQVudkboGPAOfEJE5ZzVlhEZ2r5ku4B+TZz0irFR/lRdFC
         WGPWoSZwV0ZeFHHY2AneJraHPvv2hvvwPmB8jU2bLcDIXMnrv33rXhcvLVaqFe8zPLQS
         fsdga3r5R1lZsRXx6V701nlNHqwlo4Il+topuyKCMz8SqmM2uBsZnbBCIrXFgp6hzFPB
         j3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MfcOIqK9du/rFNRW98A9Zkgq23mL6C9Bh17nvMfYECA=;
        fh=fWuSsuF59ivUGTIONwwuwfVd7/ik6qlg02X4LWEKp74=;
        b=IuUq/oLQct58smOeO0UY5AIbnhdXU0gjyTMoVKrf/3swlKp8p/kobz+17/u1IuQ+GL
         WzjQhzjnCsdDTbgg6V1xWYrzgeiHW+KERxg2qawN6q5i31AddcTxLa9SSiGtkKLxxgTL
         RpsqX+xsBTAVG+MPAua+PGuZR5rTVohh8VNuEiaQXXCZUAmTm1L0qTlZnOp8uS5spmoy
         pG6Al3DQDEauEQYPZkovQatpbmsvnBoGDbYtKqMTzL5I5BN339kWST5Yj/zPJyHcXcRJ
         4+HY9SZuEX3abFhq5qYBrqIMe8gnNGRkVOn2m7NjUACFJjmLxvOZdKrQe7uamHnPli92
         oeWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790109818; x=1790714618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MfcOIqK9du/rFNRW98A9Zkgq23mL6C9Bh17nvMfYECA=;
        b=KahFfhVAl1zOli4/f84UtPothikHnIrypswEjYPe+dRdYAEigooZilfTr7SFP9NFUG
         7pep1gMTIXj34rHWMSZ5GI6UT8oTXrSoIT0PijLBS8zex5XIjVb5qKW4uYBPPedAZvpy
         PlygzzcRzt2eGe3feCBETaFYJkp/EIL5QycMtiFt1oufRbMFM9vLY0etZfyS9iMe3XKb
         8AUndaKPeR3Vay9BNHBJBtSb3YqnZHNBW52bAzwrga4kt++tF/JHKctz7RasW0GxlM/s
         oXlajhtzwgqVaodFrbCS0SpKJzdl0YMzlW/4qY+CnVqmSUVS9AQLkWn929LbxCLOHYni
         gvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109818; x=1790714618;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MfcOIqK9du/rFNRW98A9Zkgq23mL6C9Bh17nvMfYECA=;
        b=yoAUxf8qrtihd6a05Kmjm4DRLYItHgdVDql0ZfTYt1IwVXDBU+O1zlK+8YHGUUp9Kf
         FQ0ro5CGKuE9+6+YiatRyvBd2C6hbBtGqFxPS9h8egQz5y/905A3w64v3ENkqNwOt6wR
         NFv+QdKet+VLxEksWrr7RR5GsBkJvZl4SYgPJ/PeiZFDyQh/EgOACrY1WwEIBYhMIVtT
         jSEVVZgAJ8dhJSzodEj2GguUVkAys+sEjjBHdeU+iAAcBYw/jVLvQM2XUnfcR4RAlwvB
         5KPzAG/JqMasXQyjNjLcj9K8VbDJCU+0s5lvjlq54N3TKKONJtbyWyox1++CotnEF8ig
         hm5A==
X-Gm-Message-State: AFuF++mXS/u5kNYAe+HJBqF3uqVDjXGqZDiQGXQGo2ivncUhJbHS0EW0
	hR3w/BERG/KH/j/FB/WyorafWwOA3l30JjyqluAFxVSmkl+h8mVx1wUNU11lev0DRHKQvMCwllr
	xNRnt6tUrvVDPFXTyLAmXZDVaZGw1RTFAWW4n3ak=
X-Gm-Gg: AYBFou2jQ4r4g2IocQx2vGNzNEFQqWfBVi3cXEGvf3t/pui7zN3LdcgWm3AC4NlMWO0
	oztAxcZHWFjOeONAiR5pfT4Rtfp32uCxWkSkjUtlq0R8vxwuHyAc3hLTJxv0jpQErxfrlE/YMXf
	tMUMoM9/RGBddIw5k+fOJOu4hmX7SVWLD6Kahv1Jd8zrHu4IJ0nJnqB0SDZESwpAsqXnvS41D6/
	zozZeEzAaWacKr1bgj4s98EcVQI00zkrJCLIOegDKwaMHKMxZeKFrVUz5QwzwGq6+pwejaGzs+f
	O6J37U6Oe2iy4fAelsi2YVZZtLHxx7BXvxJ+WQ7fW55kZTpOZJkx+1gfnSf+1HIF9GoFEivU48X
	xeTAEVGRJQbvoUKYkXk7IIwLDDPFIMMie/8XM6s24eHrWs7J/C9xM8PZLOUnHwiTt
X-Received: by 2002:a05:6a00:3d4c:b0:873:2525:9a00 with SMTP id
 d2e1a72fcca58-87d178966c3mr805402b3a.0.1790109817966; Tue, 22 Sep 2026
 13:43:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921145655.3167436-1-i.maximets@ovn.org> <20260921145655.3167436-6-i.maximets@ovn.org>
In-Reply-To: <20260921145655.3167436-6-i.maximets@ovn.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 22 Sep 2026 16:43:25 -0400
X-Gm-Features: AcwNN1XXS07Kn-HMsx7mvoCbQqlPeyYonKF1juQSv29HAtUDdVHgyk--e7m0r5w
Message-ID: <CADvbK_d1zZp6ajv9p8S_AaWZpH2aw7WPF5=TomCFxX3yioVw_g@mail.gmail.com>
Subject: Re: [PATCH net 5/6] net/sched: act_ct: remove 'add_helper' dead code
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
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

Reviewed-by: Xin Long <lucien.xin@gmail.com>
