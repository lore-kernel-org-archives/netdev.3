Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EFF2C08AC
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789867334; cv=pass; b=MaSK8FqrCEYegLQ6HFNCsMAnc7v+sYbVuIq25sj1xb/mpjd3SmhTfqDpYCJ8rtGi3Xyg463cO4fcQsJWaPjSBQ+zOxXhOu1LNOiTwrcrtw6Tn6hu304cCBFAbWQIzWbVz/jZE7CSa/scUt9/FbJRdZ2RA7oTuO4kdC81tweRmxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789867334; c=relaxed/simple;
	bh=2VEm69UeAdHkIwbBU0Ergf1rGXkHAkJuOFSQAiSO0p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Peiw2GfpB5LCJe0o1xqRVcT6XpFfO2rv9BhdDCieUh1Emy562xSwvTJZwJdfARukNnEliG78pkyadrTHzfsesRqid8Gq/O78Uu+yi8EL2Xr0BpY82bM/A9Zy/sCuVMs1efMC457ywp28bXY/iLVFz4z4qpzaA6Vq7RFydD4+lcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=L6O+ve67; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="L6O+ve67"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea50db3so1075577a12.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 18:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789867330; cv=none;
        d=google.com; s=arc-20260327;
        b=fJcl1OqMRPqY7k++RWbqldlS9QomyGx9+3efznmLS7yaXH+FWF0SDs3xjaROpZFWDv
         iatuP7FzYpSTzQgdB/JoH5jkIPDXqc2M+KHC7jRnYVzz+qyt8sPhivkjfpxeu0KB7afH
         a97UFLewglk5jWwqSNJeqB/ZwqJBA9qVhZVxW1iP7UPQ2iD5GA6lUWrZgrQoLF5CEqSn
         WbLP47ww5dXc3YXif3dMHHJ/snheVZjTaSwrvgDZVS5ka5nliL6NXaZSwpq4f8kfdL5W
         kJz+PbmG4ds3RUaJgnQQ/YSdl+MKYqN5kn6HXz8ZLPvNt0o8z5SVraz4TpnbeRmyd0VQ
         Ucjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zXdKuOcPQjh4tFULSVStg5yQtDl5Sivh8Z/3KuFYKs0=;
        fh=XGMUx0CeATCwsHP+d6MvbAtDRUFJPIpV7fVmZmLJULY=;
        b=axAWdVfOeN8vTVgz1UVW+5yOAhcCKDIwmdtjn2//QhesIvjpEe4BFAuILbRZRtB7i1
         mHEZmZcc1Fo22Qbu3Y2f0xZr3mZiRkVyFGfUgl2MCEBtKZrkWb1+BGJlJE0XBxvWX9zU
         Jd+ZeUhBoGmO0eamOAsUo+sQAUmO03SuF4ddHmdNzpD2jZDzOQ84PSuojMQqPFiZBMDX
         D19oRDY23OwxMeUYWw6qKMNKVzVb1Sp9BwYKALk621nlTb3lQTQn4qxWiRJq97vlHfn+
         wIHdNwJFL71Z779snpvtGvANyxIayf3h7jpMl8eu94aMJ08JTpQ2P6jYS8wdb45Bjwdl
         Q3UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789867330; x=1790472130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zXdKuOcPQjh4tFULSVStg5yQtDl5Sivh8Z/3KuFYKs0=;
        b=L6O+ve675fqEPtcUxqXtqgUQOpms6zlKaUIVzibB6dwlz8UfhHs18NE2LQUD0Itsbq
         AmXaRpmqj59ev0o94mh3ukN0p/YT3QVdvoOrUJ1MdZT9J/lGPqVNQkvOsxD5rhN+A9eL
         LSsfQ6qJGaQTDNhZ2QQWWEBDV889TT7n/YsnabMngyUxuZlKl/P1C3y/n3UyrpfAOlcN
         MOBAOUOJScs7eRYBD8xg0ICP/+2B7tz/TIyD6q5N1RhFcabKg9Gkct3n4hjEokIhjm3X
         69PzVQcrIsgtUubhk1bGHZETjXsz2Or2LbKOUnyrb7IK1ddnqQG3J9tdZG88507MKWLH
         P/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789867330; x=1790472130;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zXdKuOcPQjh4tFULSVStg5yQtDl5Sivh8Z/3KuFYKs0=;
        b=YO9OYuPmOQCM3vVTiB6F+Di1YflZZYxCbPiZOUdqKlmlzDMnJ04xpH1P0+H3exqPng
         ZCg5PzA7Xm13iATz+cMNI1xQwTbYLEZWkODPxAkeZURnoljt6HCipG3ajpqu22twg5Hd
         PP3njQLcKkdjGeeV43WtE2blSqnNqyTJQCkboTIPXUpspBG0mqesxcsdn6sm7eoYV8ws
         vJHGSeaJiiE2hFbi2eHgoIlAiQlvf8nnHyXSWHHWAcJI6ACmt/YMJXzDVbCHhUiLK4Gu
         0aWUmbZ0HIYeO3qgJD68pzyN8fgUJMP9AaviCu0kt2FVxPRK2sR63xxKIly7BVdP0Jyr
         RK3w==
X-Forwarded-Encrypted: i=1; AKwUvBz0StAPCkD/boE+1b5nsBnuXXgu92O+3VtthxjyPy50U9jqMg9dNyxq7X1y58MdXS/w0uVQmlU=@vger.kernel.org
X-Gm-Message-State: AFuF++ko101PzW18FdvWh6Mnk37JuGoEVAzuLTV1LHFIcJksiiih43El
	vr9o3AbS5dW3BDSa8H+jjJCyPP8tAKxn+0iOkQLKLxaSqs3NaPw4VOwicj2HIghjFoKgr9mxhsu
	3RK5H8Ip5+jZjkeDGTkfCuV9aWHb1NGImgUZywRWh
X-Gm-Gg: AYBFou25UK9YaImo42UxGhqkG287KDUC87107yE5yRIL/nkNy/HL3k+QYSJ+0hsi/Yv
	B7P6JBQ4al4IoJUL/Kqz2XOmPdaV307WnzChLFDpiIGL25+rlSlAfzGjZGesa222r5O+SSYDY3m
	TbJmDd/VOet1cD6QKv0/BccPMs5yODyBROjUpk2xV4IagZeg91gOI3R87bc8iZhYhvjNWWSafhg
	Itph4w1K+KhmO7leydiALv46+UUNpmHXjWhMmU+SVgHBG7Fdzlrk4Q5oGouMsLESNyk1ug6hMsF
	NJfp4rrpTWy7fdqc3vOFt5znZFBe5LMcbsHtalKtCVKf6vgsUVL2zgS1ik/Qa9jHM9xL9ZqCp7c
	ab4D/YPOGrsQ=
X-Received: by 2002:a05:6a20:144d:b0:3dd:a008:dc39 with SMTP id
 adf61e73a8af0-3dda008e131mr6498106637.39.1789867330527; Sat, 19 Sep 2026
 18:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919223438.3883567-1-benquike@gmail.com>
In-Reply-To: <20260919223438.3883567-1-benquike@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 19 Sep 2026 21:21:58 -0400
X-Gm-Features: AcwNN1XYIQ_wBn8i5ggt4CeI5Ch8V6l0HMTPG10aIvqe5hBWEiugJPjmk6GI8NQ
Message-ID: <CAHC9VhS7sZQaPaRswKQ1ETrReEPB2f5buNAMGSXqZ1iBKTs+bg@mail.gmail.com>
Subject: Re: [PATCH] netlabel: calipso, x509: clean up ADDRSELECT on DOI
 removal and check AKID len
To: Hui Peng <benquike@gmail.com>
Cc: dhowells@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 6:34=E2=80=AFPM Hui Peng <benquike@gmail.com> wrote=
:
>
> Fix two issues in netlabel CALIPSO and X.509 key parsing:
>
> 1. In netlbl_calipso_remove_cb() (net/netlabel/netlabel_calipso.c), also
>    inspect NETLBL_NLTYPE_ADDRSELECT entries so IPv6 address-selected
>    mappings referencing a removed CALIPSO DOI are removed.
> 2. In crypto/asymmetric_keys/x509_public_key.c, guard against zero-
>    length signature/AKID fields before key matching.
>
> Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink p=
rotocol.")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Thank you for your patch, but as NetLabel and the kernel key code are
in two very different subsystems, please split this into two patches
so they can be properly reviewed and potentially merged.

> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric=
_keys/x509_public_key.c
> index 25cf8ac7f257..5c9165a83f91 100644
> --- a/crypto/asymmetric_keys/x509_public_key.c
> +++ b/crypto/asymmetric_keys/x509_public_key.c
> @@ -53,9 +53,11 @@ int x509_get_sig_params(struct x509_certificate *cert)
>
>         if (sig->algo_takes_data) {
>                 /* The signature algorithm does whatever passes for hashi=
ng. */
> -               sig->m =3D (u8 *)cert->tbs;
> +               sig->m =3D kmemdup(cert->tbs, cert->tbs_size, GFP_KERNEL)=
;
> +               if (!sig->m)
> +                       return -ENOMEM;
>                 sig->m_size =3D cert->tbs_size;
> -               sig->m_free =3D false;
> +               sig->m_free =3D true;
>                 goto out;
>         }
>
> diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_cali=
pso.c
> index e1efd888b4a2..3756193b1c49 100644
> --- a/net/netlabel/netlabel_calipso.c
> +++ b/net/netlabel/netlabel_calipso.c
> @@ -283,10 +283,21 @@ static int netlbl_calipso_listall(struct sk_buff *s=
kb,
>  static int netlbl_calipso_remove_cb(struct netlbl_dom_map *entry, void *=
arg)
>  {
>         struct netlbl_domhsh_walk_arg *cb_arg =3D arg;
> +       struct netlbl_af6list *iter6;
> +       struct netlbl_domaddr6_map *map6;
>
>         if (entry->def.type =3D=3D NETLBL_NLTYPE_CALIPSO &&
>             entry->def.calipso->doi =3D=3D cb_arg->doi)
>                 return netlbl_domhsh_remove_entry(entry, cb_arg->audit_in=
fo);
> +       else if (entry->def.type =3D=3D NETLBL_NLTYPE_ADDRSELECT) {
> +               netlbl_af6list_foreach_rcu(iter6, &entry->def.addrsel->li=
st6) {
> +                       map6 =3D netlbl_domhsh_addr6_entry(iter6);
> +                       if (map6->def.type =3D=3D NETLBL_NLTYPE_CALIPSO &=
&
> +                           map6->def.calipso->doi =3D=3D cb_arg->doi)
> +                               return netlbl_domhsh_remove_entry(entry,
> +                                                                 cb_arg-=
>audit_info);
> +               }
> +       }
>
>         return 0;
>  }



--=20
paul-moore.com
