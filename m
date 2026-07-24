Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E6435A85
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908254; cv=pass; b=SUZUdBmuF37G+E6F7Ec1z70obehgmC0z6wtdKnUlpN+Iz2On2gcTK4Nf/wsbXY5JPv+97bZGBnguRB5xXuHUDKU7MI444OczQPMUANRlXCILTTUyDvMms4E6Ya45JHzSbCMy69lqtV/UmDZaIX9rFi5s6lLSY8RbjQV48yZlI4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908254; c=relaxed/simple;
	bh=DtY+qlycA8sKe9IbDu6QRKlwDMMJRaIboWmtSuiq2oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJ09HWy6qh5yakMU3il3yHAb9nXeg/RpMXMsxk1MQ7YOjLL3fPMmmKd6pHvZ7YrZKcC0Pew101t5tZJdm9xVRVwQJWA2xgxWUOVKeGgWTXRt1wkhYacdzkoJFzPj9d0ZxJEWqveM0EFiM+1ZjaK6kMKBS1hqbIUSpFQdCZmipMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vl7QaWkL; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl7QaWkL"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8485ef63b68so576865b3a.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 08:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784908252; cv=none;
        d=google.com; s=arc-20260327;
        b=bCsJimMqVtYydKQHAn43ylgeOR22uQOVu1iNL5sgxQxwzptGsmQtbS8XoLrPVQPOOw
         K7K/YmGoFRZhV7eg9Yc5t6KIvbiVKRwY7wZrz0BxhVnJcrD93ER6VgLSj43kBAtVW5F2
         gclK7dejYBr2aJ7gEK5E8RV9CTmEYcrOym/n+b7dPK69vhkpUwhou7EKcOggplTlezMw
         tPvSorwtsvpYsJ5sSD5ThCfmDNVA1Ona4njln3zBaXQL71qPXM9JzjId72IvHfoaFCae
         rMEEh6U48Ji8hYU4I+sELH5m61AX/cUVvSE/cIF1BK8d5mvEkNVwlabbupXPEcs4wb81
         /16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=22g5M3c/mLsTYrzjzilT0LK0IfEiamlYKdy5FiZ19K8=;
        fh=xHJREzrnoG72wszA4I6R8Lz+DaTS6gsWzlFKNu3rTzc=;
        b=QEklPgVP3Itk+26rF+S3AXTfVMSAKXKc8iB10ws9NodAQBS3dC+z+xK3Ot8k+45J6m
         GdgKRnvg00N0GUZx+QmXev+1buK1HbaOiIW0i81J8DNbKaVFXahZitwhlZsmz/JU5BbG
         pZCyA/RW0amuPzL5PqeKrYna41USz3UB/tBHpT5UTD4ulbjrv0vcYO091F2kntSgBQAs
         mGAoC2yFVf+a5JiqYZOKdJUSs3WBhKKQ+DG91E71+lIEZUcU1K4kD5hnmsbqKBfy8Ome
         d8t0EtCzNZ5R9qUMB3B2HsJyG3U63nlpTJE/4ldQTkqI9U733Xh8p4PFrMiZvxm9C7K0
         72gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784908252; x=1785513052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=22g5M3c/mLsTYrzjzilT0LK0IfEiamlYKdy5FiZ19K8=;
        b=Vl7QaWkLIsSEH7RdWLO4skNm2SKSt4AE3Yp+yomw25arPdvrShdPUlEqGO1RdIFE1G
         2i6pnBgYoBRUWIkgBDE+KhwhDZHxHpIc2f+Xs4TdslZ1F/ee7C9pIyzbtK01ErGU1tJo
         HV7FlopEGPkgQJVu8yIYcZLikxZbTe7XK0IFq10Ya1MuWUA+7LmYp3ej7bNlSlvu2Qv2
         DHZ6ePiR1y/E4U5keKzWGGiK9CXt6hqdR9UQ019HltUQOY0tPaWtT+aAx8aTPlMIW3z5
         CFpI+bbWL/G/OQf/6mdIUbu+afWIpQkK+noprgep1Mph2mcH53ja/0NmX1ZbhiuoSoh/
         13qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784908252; x=1785513052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=22g5M3c/mLsTYrzjzilT0LK0IfEiamlYKdy5FiZ19K8=;
        b=OmcwrTFs/syymhkRmN0+QvNPoPWnaoq22uU7yWkp6NBQDvK6bGIPI+T71xcUhnHkKX
         p6grMuAJR28GIiGuxUA+nJfUYiChRE2eE5ZxTo40vlrJIn4Ogfi98ekqhTpzs857seor
         B+Yya7wfJ8DPuNPq0Tv2QExim9VEBW99JL5qBR4szyASADuBAa39jaaUouYRc8I0mKh5
         TD1sBvb9EqIMJXf1idPebx0YaqBp1Azj1F6YENunzfeQLLWLuQtpU9fvbDZuK7Oy/L0g
         4Hgff7nDpkF48ogGsR4f9sIRf06qEpTA5AfKjTC9/cowcD6ieyUvI+wkycp2fe7LwK+0
         ZFpA==
X-Forwarded-Encrypted: i=1; AHgh+RqBllktlz9nys828QRcPait3lzRjvBEcoG2mgsN/67yPhRehX2womLNRsH0TFClObKvxVT6rNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx64nVf8hfXmJ5KLSNhczf/KzcQqykl50a8pcCAFc1zfN0PubIo
	rO67QYHSf1/Wj1HLcrI/ZmRjjUyrY8IJX9p1BuunuqE+xio8TJHlYBe8futi7tDGT4B1+8LmyS2
	DQMuLdDVk3n5LfMp4sQi83mJl1Rv8zwg=
X-Gm-Gg: AR+sD102E7azVa9y58c4HwcT3WNCB6no/0ZlsCn/VZKjWP0J2n4dR/h5C5HVwnxrrcq
	d/lC+SPV4j5i9QEEl8I7eH7aNdM6vvWC/v2l3vEif9KPCn606FGXfsMe0QPe1xrUO84TnD6UYDs
	ItU0DMI6aSEcXifLproQq2qPTgRNyRPIQuIVGXM1UVBQHaHUxBkuirxC4XeGk11Vy26lcqhqCxl
	xyGX6Y9G1GFxvhegpjHoPwNxO2aiyyki4DQZJF90cNJ93t5m5gJowsxXTylLD7EcoeP3pQS3w/k
	f18cGvLt7LoacOssrV0RPQ+x8lmqKPgWKOvqQb1IEirf0/FuK8Kyk0t1EA+G
X-Received: by 2002:a05:6a00:ab04:b0:847:8ccc:d7cd with SMTP id
 d2e1a72fcca58-84e2bb3735fmr9076142b3a.37.1784908251769; Fri, 24 Jul 2026
 08:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723225623.2658868-1-yangyx22@mails.tsinghua.edu.cn>
In-Reply-To: <20260723225623.2658868-1-yangyx22@mails.tsinghua.edu.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Jul 2026 11:50:39 -0400
X-Gm-Features: AUfX_mzEbrwyfLUvnhHSCgLlu1BtCAf5DRvWtt2CEl26of6A0RaacSspcuznkno
Message-ID: <CADvbK_d9Q=+dZKy306Bv+PV2AjYbdo0WvX9w7t2=zVMbc=UFJA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: reject stale cookies with mismatched
 verification tags
To: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>, 
	Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>, 
	yyxroy22@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 6:56=E2=80=AFPM Yuxiang Yang
<yangyx22@mails.tsinghua.edu.cn> wrote:
>
> sctp_unpack_cookie() skips cookie expiration checks whenever an
> association already exists.  This is broader than the exception in
> RFC 9260 Section 5.2.4.
>
> For an existing association, Section 5.2.4 permits an expired State
> Cookie only when both Verification Tags in the cookie match the current
> association.  Otherwise, the packet SHOULD be discarded and a Stale
> Cookie ERROR MUST be sent.
>
> The broad check lets an expired Action A restart cookie reach
> sctp_sf_do_dupcook_a().  In a runtime test with the default 60 second
> cookie lifetime, replaying such a cookie after 65 seconds returned a
> COOKIE-ACK and restarted the association.
>
> Check cookie expiration unless both Verification Tags match.  This
> preserves the Action D exception for a lost COOKIE ACK while rejecting
> expired cookies in all other cases.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> ---
>  net/sctp/sm_make_chunk.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index c02809264..a1c0334a1 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -1802,9 +1802,9 @@ struct sctp_association *sctp_unpack_cookie(
>                 goto fail;
>         }
>
> -       /* Check to see if the cookie is stale.  If there is already
> -        * an association, there is no need to check cookie's expiration
> -        * for init collision case of lost COOKIE ACK.
> +       /* Check to see if the cookie is stale.  RFC 9260 Section 5.2.4
> +        * exempts an expired cookie only when both Verification Tags mat=
ch
> +        * the current association.
>          * If skb has been timestamped, then use the stamp, otherwise
>          * use current time.  This introduces a small possibility that
>          * a cookie may be considered expired, but this would only slow
> @@ -1815,7 +1815,10 @@ struct sctp_association *sctp_unpack_cookie(
>         else
>                 kt =3D ktime_get_real();
>
> -       if (!asoc && ktime_before(bear_cookie->expiration, kt)) {
> +       if ((!asoc ||
> +            asoc->c.my_vtag !=3D bear_cookie->my_vtag ||
> +            asoc->c.peer_vtag !=3D bear_cookie->peer_vtag) &&
> +           ktime_before(bear_cookie->expiration, kt)) {
>                 suseconds_t usecs =3D ktime_to_us(ktime_sub(kt, bear_cook=
ie->expiration));
>                 __be32 n =3D htonl(usecs);
>
> --
> 2.34.1
>
Acked-by: Xin Long <lucien.xin@gmail.com>
