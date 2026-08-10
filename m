Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE8B30DEB0
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786396429; cv=pass; b=MkRhPpBtIPdUmVcmgbTcMGIG/rUNeWSW8lEnHE7VVZv1Wezm4EfEXRtzKO9QI0EyOT+3hmfan5jIsF5ylYHML34OXjfDV9NXY+WNEg9p9ySBtnCVpeY9g+YUS9lwFc1efd0zwSbhFcz90k6tcSKh+LajnDYJK1zFjd9Z85EAAEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786396429; c=relaxed/simple;
	bh=ViBTTpKwgqCGk6UOMYF+rOX7b1qAKV133cb3UUhQihI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKEwXT5uJVHbabDNxDRN93Oq3Ao7hhFsF4SKFS5PizSBtcJ3fD+ue5HEwlUYfNAYjuUiMbR49MEqyxPPVIAvqhX6GwXVdzp0kfczu/We728KYOOou7HjoutizUYkdsj2yKedprurS4ZFT+RXvZgYwNq8kXBLhRp5xVvaXN9sTj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7Ob+JWT; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7Ob+JWT"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cab97c86bdso14115ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786396427; cv=none;
        d=google.com; s=arc-20260327;
        b=Gs/i78z+axXg5bi1WGSgYfQ7+lSHO4jX5RR1Z0TbG5MzSnH9YOvQ+RA48AEHNRckTG
         yIg7vWE7w0Cr0VmWV4s0La+AyvyHJFckhlUdWTutx6Pmhcixveg+YQ/G3NJTChcAPSbW
         j2IngxP7ni4fjJQYbIR9RnA3sbb0EkgZ76K6VKXyiuzkeghX4YjQarIwGP4Q3sypvbnj
         2MRJkz5wMSIZ89jMkuHQlZ0e61xzLExgyltXxf+5ivR3ze5Qf+B8gM823fk/PMH+YAcu
         ztIHP8Je4AfDS1mK/SX5rgT2uSy5/KakwXTQS0OsKrnmvg3Plnwzr8vQ8/FmtU8hZf3o
         7lSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AuZslUMmpMmvobY/cUdXUGWL6HwN5vSrlhfd2Fnajxs=;
        fh=IDAOupe7Vk3kTZ4Vg6viONHI6So8JmBa8pJMbF/irtE=;
        b=omXDi5kSDpnZBGHPFMuAtA3UMk8g8P71OMhr2yig8j96wcr6M36bWWUY/njU9htahT
         uzx1Y2RU+p8I5c5mYkGZcI7DbwvkufZm7FCv3SRWynEeLpUURTVXeOiZqZ45oIgxSZ1Q
         wHXLl3WoQGOLeTLa61r/pB4PKf2Ja6AfN22UXxc3h4oqTie/0DK5raZyvn9W8thrz89m
         YqvIqkNrCcEJq0FUCTmhgQGVJtMzYr1KQtuMTVWeD0AgRWRwJYyNG84F2T2YXqe8D75d
         QQTYCI/HiEqKO0Cjq7qPYbJ4eavnxEQciRK4QOswd6PXOAZJ9vw0LyWBThdPOKwNt5nd
         TDSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786396427; x=1787001227; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AuZslUMmpMmvobY/cUdXUGWL6HwN5vSrlhfd2Fnajxs=;
        b=n7Ob+JWTD/XR9WYr+xeQrezso01BRderaAAtgzQSWiXMax4dVyiONCrm0uOgnDkaQJ
         +WkiO5AyIGPp9UfqknwpNeEgJUFkjDmqfsbtcbUDN3bEo1KTeosHiVEKl+/6Z5RUHVhs
         YGxatpHjTrKbZJFQSLZ9wduntDODW0e+0HmDci8ju/LpXAVc964gQFQ8x+yVRIa/6ZWx
         gpXVerx1075ZIjfNmWoOcNiH0EXYPW0m41otKZHyh0hJei6+iP5wURhK6CrteNE3WAH4
         jyjGgEEg9gzm4zwavyqnUMJgjtRQb8WBsvy664sB2ZE219hoD1pMJsz++KFXSICgp9PL
         DA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786396427; x=1787001227;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AuZslUMmpMmvobY/cUdXUGWL6HwN5vSrlhfd2Fnajxs=;
        b=YURmj079zyIxxaWLHpk7L/0gs1gH5EVU99TFJ0tncPgKS9K33VW/Fsb867nF+qrUGc
         anBdjBqvl5gvO4/QMpAlaxz6Y5BiseYMZtZvP1YnCq/OrePmDDQqQy3KEFPGRV3T1YFZ
         K0eWHVtMCK2qsPbzAi/xjNxR5nsmwQ1GR/F13SbrDokzEqMF64sBKoUae0cco+/0LOVj
         Em3mL0gK1vOvUhtbplobtRmDl0euzq53ICf0PFvnAJNwafYTsb6nMZQMvNjbnC/kqSbg
         MJbub0om/mYZu2Ui/0QcFPrGqpA5QLMVGmxAGu1Ae+SZ5+Y1mQD47eBbStK18wVsdhIa
         LfGg==
X-Gm-Message-State: AOJu0YwgGp3TRyde290A03njDNDzcxc/GAPo2FCeu4tBSmSWYhn68TPd
	NrXZvAZ6dYekM0hWwGq8kQ1RU1ADkjvH1RE05MRo8KDHJ6fEgh+hAHZTBrXaGQeKo7YBTHOQs0k
	YWgDw74p161O+RuJ+HIcw1a5gQ1jsQKIJ2+rFNSWO
X-Gm-Gg: AR+sD10SoAXPPXFKIJvAYBRyYD2KJAVR7Y5YoffFXysaUUUsfX52iEv+1nkLD2x2xNm
	AsusU/TcYks70RagULc31KLWdd+ZsVE5SNB8pnw8XcOFDmnUy/+Eumc10pUyx1hNzSacE+nUYvV
	7sAdLP9aCLzzv7ITIjpVHUqaH89zkk8liOnjLyKWorHekZh5pWmRdXsCC9mQKoskbUeoCVSB8ra
	YpN3hNvUfxRFrtSDCIwWT3slal6Pl2emAh17FR6E1AiMvCS2AWqQjZd9YjmCJN85XniPTtgCpnZ
	Pbbk93ded+ocuRkEpvv/IK/Foqj7nLGnUppvJZpJ5I+FjsB/VxnVriJmWrpyDm/AQouGRFaAxzK
	4aCq8bw87j8A+tqfQ1AxT+OK0gYHd4gYi4D4F2/netMlzLmReVNyEyPiU1bQ=
X-Received: by 2002:a17:903:1983:b0:2d0:1aaf:daec with SMTP id
 d9443c01a7336-2d3131ddd85mr414305ad.9.1786396426699; Mon, 10 Aug 2026
 14:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808002136.2064827-1-renich@evalinux.com>
In-Reply-To: <20260808002136.2064827-1-renich@evalinux.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 10 Aug 2026 14:13:34 -0700
X-Gm-Features: AUfX_mwcdS309wt7oqg0q_MV1aOMJQudoy9lrLc5AIaspfGizY76xf8h-k7hEm4
Message-ID: <CAEAWyHd=28DXLT2JoHun6PRWvCRSnmnNbi3_+BjSYx5A93KEKw@mail.gmail.com>
Subject: Re: [PATCH net v2] gve: use gve_schedule_reset() on AdminQ flow rule timeout
To: =?UTF-8?B?UsOpbmljaCBCb24gxIZpcmnEhw==?= <renich@evalinux.com>
Cc: netdev@vger.kernel.org, Joshua Washington <joshwash@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 5:21=E2=80=AFPM R=C3=A9nich Bon =C4=86iri=C4=87 <ren=
ich@evalinux.com> wrote:
>
> When an AdminQ command to configure a flow rule times out in
> gve_adminq_configure_flow_rule(), the driver currently calls
> gve_reset(priv, true) synchronously.
>
> When flow rule configuration is invoked under netlink or ethtool
> callbacks, gve_reset() attempts to acquire rtnl_lock while already
> executing within an inner driver lock context. This violates the driver's
> lock hierarchy and causes an AB-BA circular lock inversion deadlock.
>
> Resolve this lock inversion by replacing synchronous gve_reset() with
> gve_schedule_reset(). This defers reset execution safely to
> gve_service_task out-of-band under the proper lock ordering.

gve_reset() does not acquire the rtnl_lock(). Also, there is no inner
driver lock context that is acquired at this point. The inner driver
lock context that the AI is complaining about is possibly
priv->adminq_lock but that is already released on error by
gve_adminq_execute_cmd(). gve_reset() is also written in such a way
that the onus is on the caller to acquire the appropriate locks -
either through the ethtool core when calling
gve_user_reset()/gve_set_rxnfc() or explicitly by gve_handle_reset().

Sashiko has also called out a few issues this change could introduce.
Considering this issue hasn't actually been encountered in the wild,
there is no lockdep splat and the commit message is inaccurate, I
don't think this qualifies for the net tree.

For the net-next tree, a more holistic change is in the works for the
reset path that also changes this path and removes the synchronous
reset anyway.

>
> Co-developed with Gemini AI (Google DeepMind) for root cause analysis
> and patch formulation.
>
> Fixes: 57718b60df9b ("gve: Add flow steering adminq commands")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: R=C3=A9nich Bon =C4=86iri=C4=87 <renich@evalinux.com>
> ---
> v2: https://lore.kernel.org/netdev/20260806085112.385934-1-renich@woralel=
andia.com/
>   - Update Fixes tag to 57718b60df9b per Przemek Kitszel review.
>   - Add Reviewed-by tag from Przemek Kitszel.
>   - Remove misleading GitHub Issue #93 link (opened for CentOS Stream 10 =
NAPI bug).
>   - Add explicit AI co-development disclosure in commit body.
> v1: https://lore.kernel.org/netdev/20260806085112.385934-1-renich@woralel=
andia.com/
>
>  drivers/net/ethernet/google/gve/gve_adminq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/e=
thernet/google/gve/gve_adminq.c
> index 08587bf12345..2037b1767890 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1322,7 +1322,7 @@ gve_adminq_configure_flow_rule(struct gve_priv *pri=
v,
>
>         if (err =3D=3D -ETIME) {
>                 dev_err(&priv->pdev->dev, "Timeout to configure the flow =
rule, trigger reset");
> -               gve_reset(priv, true);
> +               gve_schedule_reset(priv);
>         } else if (!err) {
>                 priv->flow_rules_cache.rules_cache_synced =3D false;
>         }
> --
> 2.45.2
