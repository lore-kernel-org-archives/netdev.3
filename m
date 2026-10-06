Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385641CAA78
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 03:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791258325; cv=pass; b=skdVzpxe8NjosiiGuhGF5wWvNW3UyYybvWsM6He8jqt1Z362y2CqmwJoM3vCT0f1Gq3okyrcO4btf+fEaVAPtYDeog/K7+jrDLyQDAfCR4L6+5gxrNAENsod6sETV2MmvMIchxpnv+79dxnFiTYHnPeKSWkbxPqHtk8Y+aaB9x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791258325; c=relaxed/simple;
	bh=tCf9zcdPXyYE0i1nJT6GMpiiD0IaiKN9eE15bB7ZvtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=j/W1A1OEAa2s7BcXI2r8zHVbnN9Dlvl1L1uBolRX8MhGadQNc1c7XGxCpPUsIAs4dSiJ2p+wjCh2NNusBlDTqdnto3dCaHx3zc1jux9t3tvJRos+KsOsuFy2lxbqYjI10vAdlR5pFOJmRJPEMSgUneCNaryTYSIUKP7tAHGONAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gINf+cPz; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gINf+cPz"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bcbb82dbadso847379e87.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 20:45:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791258322; cv=none;
        d=google.com; s=arc-20260327;
        b=nGFzzlUCt5h9M6EksX3wSniPaa7RxKGqWo3BbfX0tLDN4J6MSIqAa0bVetxXW5eiIr
         WCBtqYFPiGDYTjcJM89wlWGVMJzka5JNGjQVDmlgQQgl2ReqKAqGwB71caJsqfJdRhgl
         YUzQfl68a/Hl7sDI55UhcvmhGfauoVCT21jZ5TVFND7eZ+UUzZPsN0MHDBgpoZ4USTeZ
         jKqsiBf41I9DoVyQLR59MWJb2Tj8iA4nJNyvESilC4xx1BT3BERT71V4wE6xOGkJOTCF
         dWXNPCKne2W4FVNbPmhj14XT7DtUk2QB0Z1YkME9LRcmEOyPiX7910mxQrvRNGFpEo1U
         Kvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b2CWcYPdL0RmTHJYZikl61tiiXDfBQjGyNirYnlHw3o=;
        fh=P8Y6eqyWJSFhvPIZjOVYEtY4pVBDVg6Z3PXXhMmFrXM=;
        b=d03IO2c1uz8Doc275n5HnlCgd8CcxjJMA2jJ/z59BHvbTTeCWB3f4s2Bvl+KB0HdS+
         D8Njy2nO7DVyl/ugiTR36r4USXUD5QYa0ALwELFAP5tdrcWxp62Q7AXB4eLlESZKoK9i
         hmaZhvLjMn/3ycoVoP7mZThxXgXa8AgUWPjuSe/dmLY+loF4hx1NpzXDGJcXHdG4Ypyx
         4ktMSt80e9Gf8qg3iFZ0WuFfNJncmzZIGJ3riGJqc9oxJCoTnle8bwdkFlXyxI7lokv6
         6VcZBpbpS2Sl0Uwa2St1T0VAVFbqgmQlcH/cmI4cD+G8kKYwvWThN592Ss9vq02AoFdY
         ahZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791258322; x=1791863122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2CWcYPdL0RmTHJYZikl61tiiXDfBQjGyNirYnlHw3o=;
        b=gINf+cPztFZw4hSHEb9nEDfdOhWco1GgnzLOnScT9vCL/yNusituI6cIEruqu2GhFN
         qyA9PQPMx/ULHMA1CCDeCzAjusxpMIcxHvEsS55+jt6hSS6IJcmdVvmZo9Hpd8cPEEhm
         qYOrCV+hUCOYrP8pd5ZoBUb+u2VRZIpbbx3cO6dEfqt24vMYiNC0GxPiK48NJbgtnZbs
         AeSvKjqoU067AzSMeEF3So9r3mQMi454fOu6jNv+IBSuHVtlImRP/oXZHNcQliujF88d
         4hvXA/d/5AS9IBs/74Rhl6GlbG9jOqbirqzghX9x0QOY/oxYkfmrMwAr4ZsEPtxb1rz6
         4FsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791258322; x=1791863122;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b2CWcYPdL0RmTHJYZikl61tiiXDfBQjGyNirYnlHw3o=;
        b=ykwddz2ZeQasXCXItSz4/6kFUwQ7tUiUUQgGHwsF0pu5wpQpaQl3fzOVL0A2ZoxPm3
         ZiQ52y9ueP3pgSQ5rxhzqFQUOxn0KlRu9JHmvA8dzlIIWL24yC9V+B5EoEoTrPA67jB5
         aPCJEWVEgduiWgOc9YReUV1ip7bat5eO1GYoUw1TmXHU3UmGBhtNKsUUyrBOC8VnYbqt
         dBGz7FwJDASH05lxrGTFPw/fm7QvrcAtdQJ3Pmj3VvppYr/JL79xwbJ/RN/307+UDQ3W
         yWJW7edwHdYh1Wb76Gj3D73rg3Pon5fv4JUjMkrvJrkH2Kh8mjIG3+x3F5RAKhSzMTBI
         RS6w==
X-Forwarded-Encrypted: i=1; AKwUvBy8jSTtJ2xqkmGm9uekiOL1NHqRqo7P6gp/Xnjfn0RHvB7Fe/R5aNds32dwLfS5fpRNbPLxwsY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVt3cK8uRlTxW16FVjAcOacvVuUNc1OmvHehsWNpv3QKV3/0KJ
	vqrl5wp+VUlwbgzHq3eHc3huyMtqKOOaYTaUJ2REdNsIpOPZkJu9sE10399Yc9iKLlcrgQOnKxA
	58JDcmU9LUw09epbOUyWre4BqqDaK+AE=
X-Gm-Gg: AYBFou0UCC0Lkn41W4g0TlDwUO44cpV3LUnS1zWbCkQuXdH8+MWp1EhWyu5D9jtVDEz
	t/VR7qW5BestAIf1L5Q11rn8po6yuEULuwEe1o5ycwBoHGqrAtp+90kzdG30qj6IZHMa9g4XkZv
	1IVnFNLH0sGQTa4cJakyO6v2lTgTmsLbNDl+GRh1pdkOjPJ1ma1DeDBsdGZGGjwsYT40PzSe8q3
	S8Ki9A4D7ysx2JD0ogzqjHPd4eESTWR2TxlFf0uUxCig4n0iz4m337UeM5eO5s2/IfzY7eVBnCe
	K7dPm4V9/2t9ywxgzl31s6/ZpZewkXAmL5WBQJk54KR4UprxsxM+YA==
X-Received: by 2002:a05:6512:3991:b0:5bb:7829:741c with SMTP id
 2adb3069b0e04-5bccc6b594cmr64148e87.1.1791258321918; Mon, 05 Oct 2026
 20:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004083759.1016519-1-maimon.sagi@gmail.com> <asQ1pF9AAqOiEo3r@devvm20253.cco0.facebook.com>
In-Reply-To: <asQ1pF9AAqOiEo3r@devvm20253.cco0.facebook.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Tue, 6 Oct 2026 06:44:55 +0300
X-Gm-Features: AclHuK9PN1lCiJLlPnCC7s8Qa_5To1aOEypzViWt-JVLXj9lXdRlnfiN5UevbJ0
Message-ID: <CAMuE1bGXcNwKKX1firkq6eEzymkrDOp8PnnowMzz97SibtpoSQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net: axienet: free outstanding TX buffers in axienet_dma_bd_release()
To: Joe Damato <joe@dama.to>, Sagi Maimon <maimon.sagi@gmail.com>, netdev@vger.kernel.org, 
	radhey.shyam.pandey@amd.com, michal.simek@amd.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	daniel@iogearbox.net, jacob.e.keller@intel.com, suraj.gupta2@amd.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 2:41=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> On Sun, Oct 04, 2026 at 11:37:59AM +0300, Sagi Maimon wrote:
> > axienet_dma_bd_release() walks the RX ring to unmap and free every
> > receive buffer before releasing it, but frees the TX descriptor ring
> > with dma_free_coherent() alone.  Any descriptor that
> > axienet_free_tx_chain() had not yet reclaimed still holds its skb and
> > its streaming DMA mapping, and both are lost.
> >
> > axienet_stop() disables TX NAPI and stops the DMA engine before calling
> > it, so nothing reclaims those descriptors afterwards.  Bringing the
> > interface down while frames are in flight therefore leaks up to
> > lp->tx_bd_num skbs and mappings each time.
> >
> > Walk the TX ring the way axienet_dma_err_handler() already does: unmap
> > every descriptor whose cntrl is still set - axienet_free_tx_chain()
> > clears it on reclaim - and free any skb still attached, as a drop.
> > This relies on axienet_stop() having stopped the DMA engine first, as
> > the RX walk in the same function already does.
>
> [...]
>
> > Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Eth=
ernet driver")
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Assisted-by: LLM sparse
> > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> > ---
> >
> > Notes:
> >     Changes in v3:
> >     - Clear tx_bd_v and rx_bd_v after freeing the rings.  v2 only caugh=
t a
> >       NULL tx_bd_v from a first open; after a close followed by a faile=
d
> >       reset the walk would have read the freed ring (Sashiko).
> >     - Reword the comment on the skb free: a descriptor can complete aft=
er
> >       TX NAPI was disabled, so "never transmitted" was not always true
> >       (Sashiko).
> >     - Say in the commit message which hardware the test ran on.
> >     - Kept Jacob's Reviewed-by, as the changes are small; please say if
> >       that is not OK.
> >     - The hardware test is v1's.  The changes since only affect the
> >       failed-reset paths, which it did not exercise, and how the freed =
skbs
> >       are accounted.
> >     - v2: https://lore.kernel.org/netdev/20260930133851.663023-1-maimon=
.sagi@gmail.com/
>
> [...]
>
> >
> >  .../net/ethernet/xilinx/xilinx_axienet_main.c | 26 ++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/driver=
s/net/ethernet/xilinx/xilinx_axienet_main.c
> > index 09443623a3e2..c88c671f8b2d 100644
> > --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > @@ -186,11 +186,34 @@ static void axienet_dma_bd_release(struct net_dev=
ice *ndev)
>
> [...]
>
> > +     lp->tx_bd_v =3D NULL;
> >
> >       if (!lp->rx_bd_v)
> >               return;
> > @@ -221,6 +244,7 @@ static void axienet_dma_bd_release(struct net_devic=
e *ndev)
> >                         sizeof(*lp->rx_bd_v) * lp->rx_bd_num,
> >                         lp->rx_bd_v,
> >                         lp->rx_bd_p);
> > +     lp->rx_bd_v =3D NULL;
> >  }
>
> The added null writes makes me think that centralizing this code and usin=
g it
> from both axienet_dma_err_handler and axienet_dma_bd_release (instead of
> repeating it) is a good idea like I mentioned in the last post.
>
> The code seems right tho even tho I don't like duplicating the logic.
>
> Reviewed-by: Joe Damato <joe@dama.to>

Thanks for the review, Joe.
Agreed on the helper.  As on v2, I kept the fix minimal for net, and
will send the helper to net-next once this has reached it, with both
axienet_dma_bd_release() and axienet_dma_err_handler() using it.
Thanks,
Sagi
