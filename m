Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F33203B4
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867555; cv=pass; b=Sq6wDgzUH/Cq5RF3McKYmorZu1wHboGtGftFDkny2r27veeoD47fiKJvCnInrhd7LfJUlE8Sok8+Bp37VL90G8PQItBEOqPCaP6d6r7sbFdYV7w9Yd5VT6JDvbqHivHr0r2PK1h6KnyQCmmj1WLZaIjf8V5fBMa+iFUsrvUQbww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867555; c=relaxed/simple;
	bh=rE0jWmiH8mZl6rl9Yc+bmfiJlsxIdVsL+Q8JnRqVZlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLo21NKbQ+M10FIjIKXj7qpa/cKpDYDUmCT7dxvCesfATWgBOfe7x4fWV0WBnCrEJldeVzHdKtQFpDLRXSEA8fGsDKp0aOzoaIvkLVSRrcYB63ussVeUuAFApiUUAzIH1hWvXeF23RRjIq/jv3otM6TmOJ1Hntd38CeCNnKGkCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ITHPYTFY; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ITHPYTFY"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e211a0so2204490b3a.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 18:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789867554; cv=none;
        d=google.com; s=arc-20260327;
        b=rNwd4QqoEdfxIXX8xUnhvs4Z+zUtirPpADKFKfldLOEr93ZPy4jWX1ptGPInaje3Jq
         5WJZ9aW9GmimcrHTuyR3vxvwHEW3CkCjkJDP89HDVrW++BdkIkbf1K54RoiZzSSa7al3
         PlTshovmetPgz7OV3MwAQJS+9GKrXZVAsLQiEFWp/sgDUoxQ7lCuhB197M93MY5crGMI
         cMg/zWZSOGTpUJspZMOwKB4s7cdLcO/t4bA5jgMiZwb9NdI8uI5DEJjwlu7dRjuLO5AH
         dJEw/N/h4FzKiRlwd21Y9ucNvMkoRTiRA3wTd5I+dPa0Yn5cK3zPgkWA2TTSdXaOa9kH
         Kzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MNRnVH7wuWaValEcQugtvoveGgv+gdl3RdPnin3h+/k=;
        fh=ST5MA4+dA4V4G5jPPzBGdpM587b/JH0D3NACvK1eFks=;
        b=dbm+3QMQnfx9TNiu8zLlvB20xgpPA5VKnyAe42VAKLhFj7rhVCJQ5wqdhyXHStnpht
         GDZRbDzZoaW25bCJbJHLtgi6d0lvKi7Gfopiz9rzeZ39q/zNrqBik90q3X13zBCYG0bV
         A29pnRbmeBF8ZPIum8mONWhHYPNY8YL5gx8bjgfI0q6ZRocD0Nsrh2Ba4Da5kde1IXU4
         sM6uFmDyTDFF5Az1/DkKhtufZhw6nA7GMeUQNcDUrZq+2rIYlJflVP3jx1BfuXg3iISg
         XBoyTj7tv3OTvGPfsky7GKohjiu02JP2V5iQ5sYpXrQqwWozCK508qa21Z+j7s0Kr/OV
         dESw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789867554; x=1790472354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MNRnVH7wuWaValEcQugtvoveGgv+gdl3RdPnin3h+/k=;
        b=ITHPYTFY09cCVl7MzEnnEta1wLZ5p02SW98zHa6QunF+numSL9lPPU4myPxlSfOfLl
         t/JmSHSAVyQbDhi/qHx3XPUGYsX2gK9uHWaQH5Dv5foU3w0OYj15QfNQT3tmnf3v6QbV
         /Nu70CSbVpoEUYbdGO8NXLo1msD+kx6hEJ2YRa147gdHzQvzoE70kNUV0MTzy5Jfk3co
         z71fcZa0+7ecmLeuzQX7dR1BYgng87bqOJb4isuTy4Di0sUt9DSeaVotZ4iM5nZTKxC1
         YcTxV1NQOVFz4PJdbll8YVdbkiD84HvZoKnvGbRkPB3fBkPonGlF+qxs0SlgH07xShhX
         4Duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789867554; x=1790472354;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNRnVH7wuWaValEcQugtvoveGgv+gdl3RdPnin3h+/k=;
        b=XqG5Mb3GbzQsnN3Mp01r2Zzly6RAd4N0wPQe4lh1hREsgWUcsMHqc6wiSBTV3G6oo1
         PI4gxqF5Zn3ys3RUdXPn3e3fvGg5RmvjU3o5XWnoivQFVlzMvoAJ8spRm8gTvERKhKRD
         mSA7h4oaXCQeUV5kGxRZ9sH3qFwj8T9pf1uS0qqMFuOTPsggYRCQGl1GR0jD4HFG0OTr
         pz4yY2cwvrqTI3v6OAYtbCJ1vhsBnGW4Jfnkn0GEBaodc7NUQWwRzeCbpBrw1klHOZPO
         DFspl/XoMb/2nKfIHfusQG+esi5NggLBddfTbjRbUJqP/xp5orTw1reJ4QiYEYWBEfs2
         eQSg==
X-Forwarded-Encrypted: i=1; AKwUvBwo1S0X1pa2dO+s43flxHVJ6va7AMaXdEcSms8oLS7r5CG+dx4QtzfwmwgVhfi3Zn1m7JtvjQk=@vger.kernel.org
X-Gm-Message-State: AFuF++kco9i8MuW7cQScqKBatV1Zp6bK0GvV7dzdNUQSuDjp5Z/zgBdD
	iY8eiQHxuE7LgQtlLLEIqpy/crrRDPuLy1Ae+xz34pxijwwWiJSmRAmDJSgnyux1WoLl15adH0A
	B7yP5XlU6BmQ3pflusejaL3lvGwguTA/3Mz00u7XQ
X-Gm-Gg: AYBFou1CViHDfN5pnyQBvWjHu9dG0bUfCcdYacACA1sAqdfSiJF5p/G2Jyk7gvMuXHC
	0H1ywhocvRTDHJFf8F+f6XgAd6DTu34HXvhV6zHCev2ujdQ092Ntzyo962cxa2+2pb8bZOGI1pz
	FQ02vtnptDlOoxggVLezll4JmGR0dPgEGE3BnaYkCDICK1MvK06muW/GvX6Fcz0c2lRsF5pj+wW
	Qv7Vz4KRhkotSrDolwdOuxZ3jeuHkw84oB9JsACd3TD3TvzHivbxkfwg+BknrrRcFUOrD159BiN
	9OX+1/J+5HnCudbgMMMvi/4JY61tcSQeLbKI3mTg5nRRI99pmpKB5zUawSxHkQBsfgAo05zUF55
	UOBcGMlNGfb8=
X-Received: by 2002:a05:6a20:7f8e:b0:3dd:a196:907a with SMTP id
 adf61e73a8af0-3dda196a7a5mr6025808637.68.1789867553821; Sat, 19 Sep 2026
 18:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919215243.3472150-1-benquike@gmail.com>
In-Reply-To: <20260919215243.3472150-1-benquike@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 19 Sep 2026 21:25:42 -0400
X-Gm-Features: AcwNN1UUreSec9NyLkvaWFAQ9DB9RVlT6GgTGCc3Y8l3T4QYDUJMKR-P4SIbpMM
Message-ID: <CAHC9VhSxPmufV8Xve=kFX3kH6aBztyH9+tSynrXUEXcgTuw5Sw@mail.gmail.com>
Subject: Re: [PATCH] netlabel: cipso_v4: reject empty MLS level/cat lists and
 zero tail in cipso_v4_delopt()
To: Hui Peng <benquike@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 5:52=E2=80=AFPM Hui Peng <benquike@gmail.com> wrote=
:
>
> Fix three bugs in NetLabel CIPSOv4 handling:
>
> 1. In netlbl_cipsov4_add_std(), an empty NLBL_CIPSOV4_A_MLSLVLLST or
>    NLBL_CIPSOV4_A_MLSCATLST leaves local_size or cipso_size at 0, causing
>    kcalloc(0, ...) to return ZERO_SIZE_PTR (0x10), which bypasses NULL
>    checks and installs ZERO_SIZE_PTR arrays into cipso_v4_doi_list. Rejec=
t
>    0-sized level or category tables before allocation.
> 2. In netlbl_cipsov4_remove_cb(), also inspect NETLBL_NLTYPE_ADDRSELECT
>    entries so IPv4 address-selected domain mappings referencing a removed
>    CIPSOv4 DOI are properly cleaned up.
> 3. In cipso_v4_delopt(), zero the trailing cipso_len bytes with IPOPT_END
>    after memmove() and pass opt->opt.optlen - cipso_len to
>    cipso_v4_get_actual_opt_len() so stale tail bytes are not re-parsed.
>
> Fixes: 96cb8e3313c7 ("[NetLabel]: CIPSOv4 and Unlabeled packet integratio=
n")
> Fixes: 389fb800ac8b ("netlabel: Label incoming TCP connections correctly =
in SELinux")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Generally speaking, unless multiple problems are tightly related, one
patch should focus on fixing one problem.  As you have identified
three potential issues that don't appear to be related, please break
this patch up into three patches and resubmit.

Thanks.

> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index a05aa075de1a..4ac1a4965abe 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -2025,9 +2025,11 @@ static int cipso_v4_delopt(struct ip_options_rcu _=
_rcu **opt_ptr)
>
>                 memmove(cipso_ptr, cipso_ptr + cipso_len,
>                         opt->opt.optlen - cipso_off - cipso_len);
> +               memset(&opt->opt.__data[opt->opt.optlen - cipso_len],
> +                      IPOPT_END, cipso_len);
>
>                 optlen_new =3D cipso_v4_get_actual_opt_len(opt->opt.__dat=
a,
> -                                                        opt->opt.optlen)=
;
> +                                                        opt->opt.optlen =
- cipso_len);
>                 hdr_delta =3D opt->opt.optlen;
>                 opt->opt.optlen =3D (optlen_new + 3) & ~3;
>                 hdr_delta -=3D opt->opt.optlen;
> diff --git a/net/netlabel/netlabel_cipso_v4.c b/net/netlabel/netlabel_cip=
so_v4.c
> index b080e666523f..9bb28236b8fe 100644
> --- a/net/netlabel/netlabel_cipso_v4.c
> +++ b/net/netlabel/netlabel_cipso_v4.c
> @@ -185,6 +185,9 @@ static int netlbl_cipsov4_add_std(struct genl_info *i=
nfo,
>                                         break;
>                                 }
>                 }
> +       if (doi_def->map.std->lvl.local_size =3D=3D 0 ||
> +           doi_def->map.std->lvl.cipso_size =3D=3D 0)
> +               goto add_std_failure;
>         doi_def->map.std->lvl.local =3D kcalloc(doi_def->map.std->lvl.loc=
al_size,
>                                               sizeof(u32),
>                                               GFP_KERNEL | __GFP_NOWARN);
> @@ -260,6 +263,9 @@ static int netlbl_cipsov4_add_std(struct genl_info *i=
nfo,
>                                                 break;
>                                         }
>                         }
> +               if (doi_def->map.std->cat.local_size =3D=3D 0 ||
> +                   doi_def->map.std->cat.cipso_size =3D=3D 0)
> +                       goto add_std_failure;
>                 doi_def->map.std->cat.local =3D kcalloc(
>                                               doi_def->map.std->cat.local=
_size,
>                                               sizeof(u32),
> @@ -680,10 +686,21 @@ static int netlbl_cipsov4_listall(struct sk_buff *s=
kb,
>  static int netlbl_cipsov4_remove_cb(struct netlbl_dom_map *entry, void *=
arg)
>  {
>         struct netlbl_domhsh_walk_arg *cb_arg =3D arg;
> +       struct netlbl_af4list *iter4;
> +       struct netlbl_domaddr4_map *map4;
>
>         if (entry->def.type =3D=3D NETLBL_NLTYPE_CIPSOV4 &&
>             entry->def.cipso->doi =3D=3D cb_arg->doi)
>                 return netlbl_domhsh_remove_entry(entry, cb_arg->audit_in=
fo);
> +       else if (entry->def.type =3D=3D NETLBL_NLTYPE_ADDRSELECT) {
> +               netlbl_af4list_foreach_rcu(iter4, &entry->def.addrsel->li=
st4) {
> +                       map4 =3D netlbl_domhsh_addr4_entry(iter4);
> +                       if (map4->def.type =3D=3D NETLBL_NLTYPE_CIPSOV4 &=
&
> +                           map4->def.cipso->doi =3D=3D cb_arg->doi)
> +                               return netlbl_domhsh_remove_entry(entry,
> +                                                       cb_arg->audit_inf=
o);
> +               }
> +       }
>
>         return 0;
>  }



--=20
paul-moore.com
