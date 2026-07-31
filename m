Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE61743B492
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511645; cv=pass; b=h7VUjBRUzvgvlS/g0qrOkV30nBtZV/RqXxOMNLAMBgeSzzHUe39f6+UZYclgkpT4x9JPj9L4X0bvqx2Ura0kf2haPSVj8ov0PXQA7LgS36wCXLgr2lMN1l0nmMidCVaDyqVxZfIN4dyOhSgKreQrkjIsoEXkhfDwqiNygOBtnME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511645; c=relaxed/simple;
	bh=O3BQ3jZ6tOaEQn6y3cDLly/xE1BrIxn+Q4iMGzfBJeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltNljSFN2la7G3GzvPGpNjAq3TRJMlnGTsMkdMtF39R+WTg/AgmLRhCTMg7Eo4sb5SklOsRvUJq9mtMk5xwd57dD5FH/bSxAAAblDI33+1iohbcOZdT0AVwvQ9t5ttlCj2MMYuNkpRXOxgv9FnStRQTnvr8liE2lZd1tYrQA2js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvzMsdOZ; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvzMsdOZ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8487088510aso1246169b3a.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 08:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785511643; cv=none;
        d=google.com; s=arc-20260327;
        b=I48WEGEMSDLDUvK0t1bHomy0xNeVqi99XO8rK223vHT5nVv9etqDVEvwp0dUNt3ITw
         Ko/TREbA9TcIhV8gJ0/F+v8eOh/WB7Cj6WSQrZ7TfNGPnf3vKL/50YTTxD1bEIokLecb
         j39LHx8gZAuDWANLgbx4aM7Pmf7ywfYmlurIhfs8mZevGP4OPK4ND45OAjcaCAoPFIQn
         ggGkU8OQRcfHmhS+pJFHAuTpTS1VViPWcC0HnBRdjSiqD87WeCpjWrsrdDSneSy3+QS9
         RlstsR5ta79DphyixkEoKGehf5CH7QGuoTpgPrbY9vyjzaQ9fDhNH+pNk2LnKvc7rIgW
         8tuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bo32CreubqYXJNbokFXe3UB03tI4c52nlVDOvA0DsHU=;
        fh=X0ClIGQ+u5C9Y3AyMn9OjfsOkp1MxwXHU+JaqLSzlk0=;
        b=k9sv7Z4ZKrbQiDolpt6ppFAXvmgAwL7ygxazudwc1nmbWkLOv8lXYAEu09PStsrtFc
         EtjQ0xMbPgrTIqtgUwlXwvfJtmNXduxMLhUdKRUcy0vV4z1KPE+xc1D+H1Nn5Inxp4XD
         LJAnuQ5EWTmhYMp/uVfZ45eAZlB9JqGk9dZZYiWGChaDoXHCYQBAgEn2jrfmhAKRi/pj
         XqddEn2XzuG8fM2sUA92KR+bjLvgulWLw4A7ZouYM5d/nkSG3u219KoWMhnYxrcl5WJB
         MKLAq74Cy38Rt6eIsMI2JZMHk6ZOWaUe4+8YZolnNTcoMIcIJTS6AqT6VztwdIG5Nwmz
         OMog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511643; x=1786116443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bo32CreubqYXJNbokFXe3UB03tI4c52nlVDOvA0DsHU=;
        b=lvzMsdOZeRkpYWhaRqj2A/WKm2J8iYcRsQS3HINMWoO5R013DU8rA6yRaIfzq92XHD
         Pgu6G4VD/Pcl785aoyIJfN5pj7C1uZy7uV83J5wQNSlm4Gf4pf1UyShayhCHlmY8nrH1
         lBUx+cOg6680kCFjT2JBTiCMhfvtfM1uB+T2i72gSblOq1NhrYjBHIpUvJcJduS0GVJh
         wyDBiQba2r5wkLLo3fSQ8Q9ATabI5zBfjOx/6Hm5L/ET0iGLmdnIUhlh8MF9dCCUKH4n
         4BDKaZNm8+iDvtJUyOJdrDGmEgVqsvr4C8MuPHwO7K2SrGUCnXqs0Txv3R5XU6WZZA4I
         VcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511643; x=1786116443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bo32CreubqYXJNbokFXe3UB03tI4c52nlVDOvA0DsHU=;
        b=KrAFlJ5CJB4nGraJNXUNtlCsa9dN662p2S7PTH4IaY9DXmMd+2qdldEP6oFXpw2cEv
         Cr/HujKnWLgLzQFosjbI4/hHboLVz3jRjhSYUSIDrNVVYpL9M+K0kysUDTSHeHKLJTw8
         amqcnlEdfh+jsV5iAys8ZsoCWioxHf9H8DjzrW5UY5VZowQixzkFxn9cYZoITk3JD9SS
         82AMCc0ISnsl2uPbF1wQTPnT1yKt+5KpJUJzwWgWf8nxyar4N/G/0sUEYbmRKLf3org/
         YmRmG6wT8sxaNyGNA7xjRnnx//126WccO99OOAh0tdYnHE+LmTtu8O2+y6dSyHjyYvIJ
         GxWQ==
X-Gm-Message-State: AOJu0Yw587edjNeDGb6ow45kmaFQIKHxKEGxGMnrOyN6Q1lq0dcpGMen
	n3JfdwiuaYwQOjWSWE8O+rDbruUtBaAxsRAbzByou+YeyCTI08KbWCkok/fr6351atW9fBoajXo
	pOvRt9MGc7lfOqp+dfpka78DMAq0u4qU=
X-Gm-Gg: AR+sD137eFBPJYWauza56gr8HGqap/riSwLjTS2l3MEXGPDFhrbOpFOoG+tM3fn0oHH
	XivstwkLtoHIcGOUOH8TnHyhphD+Fva9+0jCvPKyTVRI1P/yXpv7VRz8Ptlp72bjvZbEFTNwCZr
	JH4E8uof8ZZZBx/d4zHUuxiPe1ZvKwMlxAn7GUXX73PE9nWC/Jrj7o7dqjDVXNlXJqq0A42H9Iy
	AKrN/+b5wufbqyzA7LfWYd28WtxJilKR1QcPbqnPjxV8bKpH7cvMnbo2nM3XahISlnAEDMqNDP9
	YUW9TLiLsAplzynrnWb7OI8fMyDMbp9gd8qBi5+whkAbHcNoWrjcaKT1/yriO3oL/4miM8zuo4o
	dMKQaL8OmBQunoFuzb+Bqfc0FiUSYeXex0e8XM3K83P+Y
X-Received: by 2002:a05:6a00:1906:b0:845:e501:568f with SMTP id
 d2e1a72fcca58-84ee48a4a4dmr94534b3a.47.1785511643012; Fri, 31 Jul 2026
 08:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730090149.24040-1-juny24602@gmail.com>
In-Reply-To: <20260730090149.24040-1-juny24602@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 31 Jul 2026 11:27:11 -0400
X-Gm-Features: AUfX_mwSd_0ySL5ztSl5IL_zEeDZrHxteTKNfpt1bcMBfrZSskYYUInT9sXKpv8
Message-ID: <CADvbK_fx=1mQZ4LaSvQj=3jW+=1zCUuAf1xZpiez7Mag4e_GDw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: bound the auth_chunks copy length in SCTP_LOCAL_AUTH_CHUNKS
To: Jun Yang <juny24602@gmail.com>, JEAN Jeremy <jeremy.jean@ssi.gouv.fr>
Cc: netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>, stable@kernel.org, 
	TencentOS Corvus AI <corvus@tencent.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Vlad Yasevich <vladislav.yasevich@hp.com>, linux-sctp@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 5:02=E2=80=AFAM Jun Yang <juny24602@gmail.com> wrot=
e:
>
> From: Jun Yang <junvyyang@tencent.com>
>
> sctp_getsockopt_local_auth_chunks() copies ntohs(length) -
> sizeof(paramhdr) bytes out of ch->chunks without bounding the count.
> For an association ch is the fixed-size asoc->c.auth_chunks[] array
> (sizeof(struct sctp_paramhdr) + SCTP_AUTH_MAX_CHUNKS bytes), whose length
> field is restored from the received state cookie by sctp_unpack_cookie()
> and is not validated against the array size.  A cookie carrying an
> oversized length makes copy_to_user() read past the array (out-of-bounds
> read).
>
> Bound the chunk count to SCTP_AUTH_MAX_CHUNKS before the copy.  That is
> the most valid chunk bytes either source can hold, so legitimate output
> is unchanged, and it also covers a stored length smaller than the
> parameter header, which would otherwise underflow.
>
> Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.=
")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Signed-off-by: Jun Yang <junvyyang@tencent.com>
> ---
>  net/sctp/socket.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 9a6da4e0d741..3e9dacb772a0 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -7109,6 +7109,12 @@ static int sctp_getsockopt_local_auth_chunks(struc=
t sock *sk, int len,
>                 goto num;
>
>         num_chunks =3D ntohs(ch->param_hdr.length) - sizeof(struct sctp_p=
aramhdr);
> +       /* asoc->c.auth_chunks[] holds at most SCTP_AUTH_MAX_CHUNKS bytes=
 but its
> +        * length is restored from the state cookie and is not bounded he=
re;
> +        * clamp so an oversized length cannot read past the array.
> +        */
> +       if (num_chunks > SCTP_AUTH_MAX_CHUNKS)
> +               num_chunks =3D SCTP_AUTH_MAX_CHUNKS;
>         if (len < sizeof(struct sctp_authchunks) + num_chunks)
>                 return -EINVAL;
>
> --
> 2.55.0
>
The issue requires sysctl net.sctp.cookie_hmac_alg=3Dnone, right?

If so, Jean Jeremy has reported two issues caused by the missing validation
of the auth params in the cookie. We may need to validate all auth_random,
auth_hmacs and auth_chunks in sctp_unpack_cookie().

Let's wait a bit and see if he proceeds with the fix I've suggested.

Thanks.
