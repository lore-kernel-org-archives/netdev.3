Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CD3B19AC
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332373; cv=pass; b=rMyvCwnHL9ySCQpFcMsv0DjGIcMrCPoeA24AzAqBHIQkhf6/GDzsqE44XAllVEtcuoJCOddxWXgXqom/m+k38gIAZQYs2VQOIAFbefUW/HNVXI8j43K2Khinl8ZGndVCgErJdwWibwe96XqCJgCEu1cmmlylCKf0oBERuR0jfvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332373; c=relaxed/simple;
	bh=N85RJ+R7r9Ai0hOOjY7YpH5Ytqqm74t2AFNML4GFVK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSYqFtgVqsbypEMGUn6Ctl6DwgXTZKwAy4PTbSqW+6GO38cEgXweeE+CU6US0vhmZNhYr+NmiVs9v3U9E6t7wLVo/VrpIrVhAzE6l3H/ELpWCfhKZ+KZW+ov72wATjpV532G59e+WTyegmmFayJZ6c/8YjU3qqDootl6xpfY2vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rz0ubruT; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rz0ubruT"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5301a453186so5726361cf.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 23:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788332369; cv=none;
        d=google.com; s=arc-20260327;
        b=pTO1FD0XAmadT0AbDe4sRLxeBapvWpGd4AgwmtdppSYaTpEtF2wt9fHOfnKtL/ZDrK
         eUSDDGCgPcvIwSwDRIFnaK92giJpuyQgfIpac88IljZlcGcyNUOTxLPBhWpPfj6nfJne
         cUqLYpwJ/RC7zLtbgFBPtoRJ1aAKanJ7K5sEHWauxNrhHaNtqGJmrFjvWxlfheG1WSfX
         GvspNHzFcDsgmTwFi5QuqiWpVoewK4mFKlHSDgEPHmtc3kyNfSA4Av0VyxxrG6dI0Uqo
         QLALptPFlay7QyFrQdQJwJEJrHih58G8rNLlhXGO43S3e6t5BKw7pawI09kXZLS5y6Wm
         gPpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oOP9Z7HNYiswXIyPHT63AslF3SPZRjDN0nxwMCDDVtk=;
        fh=GtqmlVST52xlXeFvszKCotaYXz7B2c/j5C4Dc2AujuU=;
        b=QlzJMu7OTeTB0iX/GeFOhDZ7I2tv6amUDq6a9Amvk46S3C4CyDuG94LTs3aA6ZsuRp
         LuKesN0+lqI6dmZ39+nYcqZtu7sA7yDQHpXNlmNB3R7uIKm5e9U/sTMs2zfhMhrtXigL
         dD7dErDDXvriumDvocyk+Wx+R9DPvzpk+JpFuZgMXvLTCcEY98eYII1tyb5jcB89G60W
         8qYegrxNgp7odm/hybv6TTg5w8906evmM0nUF3oOujtvxtF2gHwmRDT/nw6D3I6ZgQ47
         V/dy7ftMjMkDJ7JbdPfCQofLJNLejxqdWfL6+L+2eUkjuGspqAkmFoMdRCD/uYtqbJQl
         8aiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788332369; x=1788937169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oOP9Z7HNYiswXIyPHT63AslF3SPZRjDN0nxwMCDDVtk=;
        b=Rz0ubruTCj46vPENnFbN8lNeC1130gr0rjTez8fpJn3zcAMEIafczV5/ZNacYaKS9S
         U+kC6hy1i1d7bPee5vNLYdmIUcnrgXdqdHeyAhcCJApPeGAPFqnMad1XuSGCjbgU4DmV
         597DuWf27eWXJVz/Re66pvpjste/d23C5DI7M1pM0uW2oiWjY4s/CveUj4Uq6WnWtB/Q
         FNda7zcUBvtncwOS1WJsY/vNgsxtaqvF+k3+G7C9JchAEhOTc4Zm49sd4i9a/PKEDnh3
         3jylk/d4s47yOI47dnOWgdkBCHp6Gb7i6hXp3AKp6DYHdnjODIOEEW4QRRybTphSqOhQ
         1WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788332369; x=1788937169;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oOP9Z7HNYiswXIyPHT63AslF3SPZRjDN0nxwMCDDVtk=;
        b=R09eLGPUlHh+MjvoJUr8sRvtHxi+gBwKiXEomgwBNXlw3/4ti/BUTiPr/zT9PoiGZo
         tA9Oo2hreSgtNg0chFVH2GA/vUHy9/YxkHb3n0F2iQaqjdBX5dtpSAdcsejaV84Wo8IR
         Q9b3jQaX2OCRD6Z0WOQ3lk6Edn7G7+7A6MKALdjEW4ls42BVN+YoDzc8j0yixoWBfn4j
         kB0CO/L8PKVyOo8zR/VVTkVRQghm4w/40IOkzuuAKGzmHfxINwe5GEDhukA/CTjN8u3J
         B81M/YC3gyjnE0MMUeTlTl6ZJ9DACg6quESNizvuNV5wSPwkavv18zfeIlUZOjJQDEO6
         8gvA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6xV5cjKFXMv/rvCtVK+9FKSmFqUCbrpSjoHc04iTXgjaB2WTgGFI3V38uPptQxzEjuK+8Ls0=@vger.kernel.org
X-Gm-Message-State: AFuF++mAMHa3vL1IhDQwZvGlk5toCluGHbcTpYsbY/yza7goo+eQe1Np
	uO5sbuLOG+keAcuL3lCvH4PnrSOC2SncVI2r8/iLl6pPe2Pbnr/B637V3hK5Gzfigsna+aPm53L
	3/wg2vdkeN7UyEpb/ZgfSsMV0VHpd9mJUzsUcVUov
X-Gm-Gg: AR+sD13n5gmIsN4sSIIvlT46w9VSl6drEqCB8TwoHUCIbZkUgshK6veao1HDYgy8+on
	QRNBz2JcI7kbKdwf69DP4ph7Iiu1ULjJ/dJZDuSu/sGjG/zE8TafvCU/FrD/9nCMO1jWvYP274K
	1ajXJfyNg3iY6DQmskMA7rlo1PoK4l2XQpQLf75LeaWMh9UPqe3sQG6WnK4B/pNFZTMZxl3RhEa
	m2tiI3ttVELGMqAT4Jjbdd6w7P9vCZwsEVdFqk9z7Fe+hOywfUIAYkONERMGwVF1r7kmxaeJ9cv
	iLpNpJCXB7fw+0WZZjqR5ptgh4WmvwV67OkwBQlsgCMxOQFpWKiV15xiTnSbLwKCkp61pSXK3by
	a0UqJqxA2hC4bPPBApja1knpAYaX40JjUjNMtQXAmpsS4yysPumRebaMVkg==
X-Received: by 2002:a05:622a:5507:b0:52d:41d0:89e0 with SMTP id
 d75a77b69052e-53036d2c227mr28091701cf.40.1788332368021; Tue, 01 Sep 2026
 23:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPAw8HE6QgnePG=UUfU2d9mYXNpY2O_kp5v0J82VuVoR6gwWOg@mail.gmail.com>
In-Reply-To: <CAPAw8HE6QgnePG=UUfU2d9mYXNpY2O_kp5v0J82VuVoR6gwWOg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Sep 2026 08:59:17 +0200
X-Gm-Features: AcwNN1U02nwDwCEqUG4sFb4t_cF5nFyslgDL7EwSIZZtJOIgdGasms2FHyekyOE
Message-ID: <CANn89iKHVP_opOhoeNuVQEORu3_haw0+4Aao6RfB-kN=_fd5Pg@mail.gmail.com>
Subject: Re: [PATCH] ppp: make room for the filter tag instead of assuming it
To: Vlatko Kosturjak <vlatko.kosturjak@gmail.com>
Cc: linux-ppp@vger.kernel.org, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:22=E2=80=AFAM Vlatko Kosturjak
<vlatko.kosturjak@gmail.com> wrote:
>
> ppp_receive_nonmp_frame() prepends a two-byte direction tag before runnin=
g
> the pass/active BPF filters:
>
>         *(__be16 *)skb_push(skb, 2) =3D htons(PPP_FILTER_INBOUND_TAG);
>
> Nothing on the receive path guarantees those two bytes of headroom, and a
> peer can arrange for only one to be available. ppp_async.c contributes tw=
o
> halves of the problem.
>
> First, the frame-error path resets a reused skb's headroom to zero while
> claiming to restore it to a freshly allocated state - but a fresh skb fro=
m
> dev_alloc_skb() carries NET_SKB_PAD:
>
>         err:
>                 if (skb) {
>                         /* make skb appear as freshly allocated */
>                         skb_trim(skb, 0);
>                         skb_reserve(skb, - skb_headroom(skb));
>                 }
>

Thanks for the patch and the reproducer.

The analysis of the panic is correct, but instead of working around
this root cause,
I think we should drop the packet (like ppp_synctty does).

Resetting headroom to 0 completely violates the NET_SKB_PAD guarantee
provided by dev_alloc_skb().

Not only does this lead to the filter panic you observed, but if CCP
compression is enabled, ppp_decompress_frame() passes `skb->data - 2`
to decompress()/incomp(), which reads out of bounds before skb->head.

Use in V2 : Fixes:1da177e4c3f4 ("Linux-2.6.12-rc2")

Also please target [PATCH net] in the subject prefix.

Please wait ~24 hours before sending a V2.

Thanks!

I am guessing the skb_reseve() could be replaced with skb_reserve(skb,
NET_SKB_PAD - skb_headroom(skb));

But IMO a drop would be better.

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index ea7fe9608ffd6580f584afd3c61cdd29e67474d3..6e6e2b9441285d6e16ee7610bd5=
9344b9e3d3e52
100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -742,11 +742,8 @@ process_input_packet(struct asyncppp *ap)
  err:
        /* frame had an error, remember that, reset SC_TOSS & SC_ESCAPE */
        ap->state =3D SC_PREV_ERROR;
-       if (skb) {
-               /* make skb appear as freshly allocated */
-               skb_trim(skb, 0);
-               skb_reserve(skb, - skb_headroom(skb));
-       }
+       kfree_skb(skb);
+       ap->rpkt =3D NULL;
 }

 /* Called when the tty driver has data for us. Runs parallel with the
