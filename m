Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792724875;
	b=W24Sb39qNDv6NlwgGgDEHq3CjbtgRhKK/KU00ioq2LjucSqOotHOh3/6/H5EGPa7b8wv
	 /sIeVBewtVWvYdflgClfIdmkrLSnI54ep7yxZxHipSW2gCkSgNPbniA4l3WLHhHQM37Tp
	 VLKISzIcOg/alvCn6QW+y+R6xUQ+03DITuMGYqAIaHX8+QEJidjUUj0yuiSmPZOeLV/z+
	 9K9+UDgAIfch55UIVwIYIg1cVW60ww4pAz7n6rxFuYh0jsb0FAHYrsVhaFp81c9mTT7ga
	 C02nzhmLfgZKYDvWge7tbr477j9xQHraoVR/W1MNpwJ+y9TMpxXrJoNyLMIGlV1B6Rw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hgV4FpDL0VDAwuHx+GSLC+BPtqKn4ASJs6Viz9YKJlE=;
	b=yJv/cO8MeBau2jTSAq0XVvQNg1HqJbTNXTaFvQ2yEfN+YmW+G0kGij/5ZPT880LS7dwo
	 2MTcar0TlkLrqyxkqKslIKnUZcg95CMWM/vd/HN5RHrAJtcMJfk5vl+QB6znOTFiJb+GY
	 zuSPcAFTIqhc+q7OAr/uqRtr7jofYAEG86iCrq2+x3u/RncfNRblpaCbPzM2wrosCgI1h
	 zReXXD23/mqIiveoWy/DoY9XlwM0yLqRWdehura8cplf19rQe8TB3xcFk718/omEqYVAH
	 sbaSHmY6HZJB+U9UKjWj2PqCkGCVl05XN8NZ8b5oSmwlJzVq84Fq+9puXJ7kGWX0U6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O3jS2DFf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF3606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 03:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41EF3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O3jS2DFf
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67989a98f8bso436269d50.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 20:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792724874; cv=none;
        d=google.com; s=arc-20260327;
        b=kmbM705XN7HL0D84qF/yxvu4l4vhF7fG6QCsG5TUictnASh1ra/ktycRTLu4Y2jF3u
         CJZM8/C67Dnx7OGIJLTEyPDz97jExtQycKs9KkyKGeL2PrUltLIf2yNPSiGmNwXuon4C
         tZ4wVWZiwZW614tnPsBPDpyVh4bxdR4qEYcER01KKmfE1ac0cbCaS/3nRbzaZLKDQ2+V
         JMmxxjilYOwKROqvDlNZ1QIwJVYI/oAA9P48NfgO1LahhfE/dMJTmoTiOK+4dEVKi/yR
         3nhLtcCLExftTpFzHwiokLad0SayirDPo+q5ICNDjS4FWkPsvoMQXQafnWGqqp6L7JF1
         Ktrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hgV4FpDL0VDAwuHx+GSLC+BPtqKn4ASJs6Viz9YKJlE=;
        fh=R+FqCrQWnZUIBAs5K53dhWxAJfDLXx4t8wCz0bLnDKM=;
        b=jMbCdT8URHsohxa1KLKIBXERrTv7O+/nKie+/OsT1lzgV4TTxrhKgruwfmxw93W6f2
         uTeJ2DWHudHX1vNJXBs89wa7t73SkEZ212hGScNPkgzHYXzReCJaFSOtI5qxk01kpndE
         tKak7pEc+KC9UTfBXhGemVslQzwfIg8bqsfyChuFHbF2DoYcVMjh/2ob5fYhv1/i6o6b
         840NzmnwdeHtEQgBcrqxWdkCfHjFxszBCAyTPScpJVIvLyPisijGhfBtVl6yNjgO2Om6
         DOzx1zvmGN782qpYtwUh7dHr0ZsV7fTTKea9PAomz5S1FuEMazSoNA6LkazmPqWiagYq
         WL3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792724874; x=1793329674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hgV4FpDL0VDAwuHx+GSLC+BPtqKn4ASJs6Viz9YKJlE=;
        b=O3jS2DFfcWEdNUpFy4Kz6tLRy5pjm4CoGTi3nUK+bMcPv8vEccjcuaCYprqk2oCGnd
         SGG3DteLuK1W6+nobfZwimCXAeLv9h1squT8jMjoUzv8BsTeiIwmqi1jAxK5LWTlLUpt
         VTZr0Tfpz12CBPgSR+PQhnRQkN/81fr6ETzmPR8Op7O4nrWlv0X3j4H34ot7/fS+aaUp
         m1UgSUp5BsTrVkYdvXxHQUdlTTOdbl4GzUxgDK5afH7qshq1fCFEyAJi7q3shZNkHpQj
         TYstceQf+BdE8fdlX0nIxOctEPONiHNTW6P35r3eTt18xCX8P5NicvYWRsO56QnCh7j8
         +pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792724874; x=1793329674;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgV4FpDL0VDAwuHx+GSLC+BPtqKn4ASJs6Viz9YKJlE=;
        b=kKbNxdqxXK1mbDaKIoY2GqRbSon2CENAO+mX38QK3XIFbyP+eIY2GgwnZajtePqB4S
         p7uNPq00oT7ORJmDXvW1A6p3D9CKNBwX1nKfrzzNrPGvpgv5FTSEwrDtoLo8uwrPfl5a
         2A1zxVJL59yGX0M28e5LGGq2oUOPgW4oEnNg5VgrP9jczbV7HWTpDGIHr5bq2DTKm5bO
         VK/I27vsuKnc/iqhCetBpakZ8obxjeBPHKgJopZJylloN7WO5ktF8GZuHTpXwvezoeUT
         BJxt38LjoaB75jWrxkAQFEQwiRlf0TMc+ilIO6y5Ub9SmBj58JoBe3ER/E28y6DSBv7z
         +GBA==
X-Forwarded-Encrypted: i=1; AKwUvBx5Yc8gjWhXWJ7iwxWwYLBIL1qv+Mxff3oarYgFTqRWxFGLQAbE9dOaLeHnuVaagL0rETAYESI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ7U7u+RUb1YQTuuWIZMjoVOrVcxrpiJ9A+lU+1OJ2jLX/cOScX
	IWeZ7c7WZKluBaIGc9waZZF00+UMHYMiicr/GZRGJ46vWvRDuPx4JPcEKlOkcVYLiNeS0SwBY+t
	YXFAPpvSMv0bBkU/jZCp8kGcBsJ1fJYw=
X-Gm-Gg: AYBFou063vaYj0d7vZqPkYTxlMazE3r9ntPJmPjzqMnfSlGqJcpQR5IhzzrhqGdTkO5
	34vaBkfOY8jIkbQKK2AqHnq7vLtVKRGq7BKf9hR/fEMgfmgbOIHQ1PfhUcjPSbDHC2vV5MiB5l4
	zq6HCy3ZzoYjYKmBTUFuPobwdNfrD+c9ff+a8Z62WFOEV+wpD4CHF/Bfff7J9j67rn+2DciuPzz
	SZX7jBcIpQcLAW2SJtkCR6IFp8TOqrqvJAy1fMQDHpxsQqJ/R53C1IMDBZzy0ewpndOPBda6+p5
	thdY5do/y++v+bepu0dhEXAan3BDpMTimyPIDY9Y990q1yefPxT2rK/j/fieQifis06GAe7uBp6
	KaKsToBBDyIAnCmjWvIOEmSSoD1NUqlEpFplpyG8drT8bkP/fHV0S3hvpyH/K7ScFxKXleaeAjy
	+mjIY1WelRAsrufHobu6ueDutuHG4N4QCt6x7+SHsXHug4Gizwi/rUy78=
X-Received: by 2002:a05:690e:458a:10b0:679:ad95:8ef8 with SMTP id
 956f58d0204a3-67a35c2885bmr500156d50.62.1792724874233; Thu, 22 Oct 2026
 20:07:54 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
 <20261021-b4-skbuff-bug-on-followups-v2-11-2aa780a03524@toxicpanda.com>
 <willemdebruijn.kernel.11bad1f39601b@gmail.com> <179269910950894.2.12425346173477603662@toxicpanda.com>
In-Reply-To: <179269910950894.2.12425346173477603662@toxicpanda.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 22 Oct 2026 23:07:16 -0400
X-Gm-Features: AclHuK-kPKdrZO6IqfAWEst6DHPn5D-__xAfjpDX0uBuJFbspUZGaComuYzzAUg
Message-ID: <CAF=yD-+1YNpOpKF+E2kk+W4PtKovfk=mXgLP6hw9811Ez6DXKA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 11/15] net: skbuff: refuse to segment a nested frag_list
To: Josef Bacik <josef@toxicpanda.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, Fernando Fernandez Mancera <fmancera@suse.de>, 
	Mina Almasry <almasrymina@google.com>, David Laight <david.laight.linux@gmail.com>, 
	netdev@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 8:44=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Wed, Oct 21, 2026 at 09:47:15PM -0400, Willem de Bruijn wrote:
> > This patch became quite a bit more complex because of my request.
> > More than I anticipated.
> >
> > Are you sure this first block is needed?
>
> No, it isn't.  I took it out and ran three KUnit cases with a nested
> frag_list under GSO_BY_FRAGS: a linear first member with the nested
> bytes counted in its len, the same without them counted, and a paged
> first member.  They all still get -EINVAL, from the check in the clone
> branch or the one in the frag walk.
>
> > this test for list_skb !=3D NULL is new. Previously this code already
> > tested skb_headlen(list_skb) without it. Likely not needed for
> > anything new in this patch?
>
> Same answer, the cases above pass without it too.  With every member
> checked as it's taken, list_skb can only run out if head_skb->len is
> wrong for some other reason, which isn't what this patch is about.
>
> So done this way the patch comes down to the check you suggested in the
> frag walk, plus skb_has_frag_list(list_skb) added to the existing
> headlen check in the clone branch.  The second one is needed: with only
> the frag walk check, the frag_list_nested KUnit case still hits a NULL
> pointer dereference in skb_segment(), because the linear member is
> cloned, list_skb becomes NULL, and the next pass reads its headlen.
>
> The other option is to go back to the single walk up front from v1.
> It's an extra pass over the frag_list, but it's one check in one place.
> The difference in behaviour is without SG: there a nested frag_list
> whose member doesn't match gso_size goes through the copy path, which
> recurses, and a KUnit case for that gets correctly sized segments
> today.  The in-walk checks leave that alone and the up front walk would
> refuse it.  Nothing in the tree builds a nested frag_list either way.
>
> I lean towards the walk up front for v3 because it's simpler to read.
> Would you be ok with that, or do you prefer the two in-walk checks?

Given the complexity of skb_segment already, and how non-trivial
the added inline checks are, I'm also okay with the up front walk.

It only adds cost for GSO skbs that use a frag_list. Though that
may include some relatively common cases, such as BIG TCP.
