Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27654442FAD
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791527346; cv=pass; b=L3dmiR8PDEK8EqXnNBFMoWjmYkHrO6eHEtlm537n682hfUDb/7H33Z4DCgCYNGvCrmmsj+bywlQtXo1+cokufV3AMLH6skRo/q1d8E7dW48o6szD1i7pXyvI1MHCazBKOT4c9xoxHEk329Y+BnZscYRbfTmARQk8Ksu8Sj70/ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791527346; c=relaxed/simple;
	bh=Y5NCAAj+S8CVX/AK6zeAmzUsBUrcPbh6f/6GokfhsQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgnkMNqjBQVT5w4fsWVmR8fskH9/3CRj/ycf6ACLVXGb3CuuIHe9DcUnM6bX+v+xnAGQ6T50ogSmUpd/GNoCsa0utGDA5MxVoPiA9s7y57ZfZNxmEXu3BTj1lmwc14/qTk9yJ8ljOcMacugppfZsMCCI9MQb4P5n3nPWvtruC8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFB9ma93; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFB9ma93"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso5057220a12.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 23:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791527343; cv=none;
        d=google.com; s=arc-20260327;
        b=j4OND6NQhBOKaEUeMmPwGjTM06or+SPtLP2atkibs8TdjODfdbTz4WcMU2WPYec2c3
         iuOa2mHN98mJcAqKyNzPdL3zIzDIUk1jBWpWSpVlome4Uxrm0VRhQuakhTQDfXcABsE5
         lv7cWyX0LeTOgAnD8jcYWowkRY06LGC1VoKNpZqfVBP5CWjqFfrT7bYBoBzucuA5SXft
         m5f4TeWC9B0UeoAAJaJD+a/Qr3ukceDey/IoI53xenB2sRjS2GXg1iH9Yb9BE0jdazud
         Wb+siexQf57NlZoCoP7kJfQRnNxNRFgjNb+ZDcrQQXx3G8fK4I6a7vpvaOVaLGYj3y4X
         gxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U1VUoDa7q17rAeqnY7bbHsgshGRs6k3XUU7zBz6pXTY=;
        fh=9Lt/Ov+E9XagEW4maSWoSytZ/A84cNlese4pUwWLmoQ=;
        b=e9qxdDOjywS2o8ycmLGhaJUvHY8vdZHR6y6LFjqXMpcsBEArToo8qoy1tvj8pSo4qj
         eDNY7o4LbcBA9q0k4v4ugIHuWDDIWShWnxZ2S/godAR4Ffej7kiVKi4OP2AXQx0t/oTR
         iAvMWY/m+p7dGaZ+l+1qNzO4tlTtpT2s2OV16pUAhr+2vtl8IqojepZfSeAellyGgnk4
         MP6AHWis4G/qnjD5kFi05hEtkgVFU38qi+MTa37ZRyPtVZZxZblcPHzcqlHAdQ7ciUZG
         s2qc/OClJFSfA0oaj0lMEqs1MxqWnpyf0XvtLknJuebYKaDvg/SsctX6iIrwSBq8Vgo7
         1tHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791527343; x=1792132143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U1VUoDa7q17rAeqnY7bbHsgshGRs6k3XUU7zBz6pXTY=;
        b=WFB9ma93JZ3Nl1BNB3eZkXfmHvUmBSt2pU5rbVClkK9djK3bnXDrFrGVfa71uw5j9r
         bso5qwjiFI9JVSoYThINt2nTUnJzeJS/I9eRmPtI/JZJLbKsGvZ/cm9IjjcQJ3V/ugy5
         l8jD+oE8aZ/S+iTPpYw29e5dyjcKPnUr7xsIzT/liKjKFNfSyOK6Y3b0JjV/tUojU+NJ
         hrBCo3BsdHtDTJZYYcYgQHbUaRdK5sLU3oTtl7zhHSHXSZn6noIo3Cbiq5Do9AGj2f2A
         NHVGjmmKksg2WcAQlRyyRreXCDvAVbJgKW0HlTGm+Wf/CE70A4TnNcxDq9WXfhgh4BE8
         55TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791527343; x=1792132143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1VUoDa7q17rAeqnY7bbHsgshGRs6k3XUU7zBz6pXTY=;
        b=QQViz0DJxVposC8R/M0Mh3QS+aYzt7Agcb2Bp3SEUTvWQCqvbL5kMMkGSQhdoLEc7+
         uMeS67wMUz9uI4nexNXSljf72z8vFmQx9S0CY2feluxekNETwpljrvrcA5qjDxog0dIV
         LOWqBgitbb+ZcriGuQ566WWMjWElixmSmzQqaQ7SvywWw5cgL7/MduzYRXQdB7NYvwzL
         CrzmWtX4sGAkU+vyLpZ8bdoM5RoK9UXi4WQwUPaIQg8uWFSsUcEP1UTEbA1qLxPjkq7g
         ITH0CeCDmi7mM5AoC/OGlgoVeipz96FSE4cbZTjZRSPC5f06otlI3bpobjHllLQaAL5z
         laAQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVSAFqZiJx2TZkvd1M/AdgMEdXIiy2ytf0sH3P4OncYADKMpByfRXAfZh89eBMxPe2IAiQOe0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQcbe9ltP/frWL8QfSUYNw58qQG8t70Bj/C4LCu0+beRD3ssIM
	9evLqUllVdIIN4UVUbwrh5qK1DdofhgJ+KOrr+SwvU7+2fBtiWAULmaZkUudWJk4R1ihbrjAX6r
	9HOENd1QNRqL+7ZxZb8QSu/8WdBrNZ/A=
X-Gm-Gg: AYBFou3g9u3fXIulrJ5lInRAHkCS5KBYHyEb59PWOKrUquKO85Q81KPmb6u6DdcJH01
	j7yaJwteZtQP1/35fCn9tIEHZzAJOSJkMjh6pH6e2ADMMCIiAtaHupXPW21oeXVhRMCAmCEjHZ3
	W241sA+0Gjm6wM/SXzjy3S1Myk7AUk5n7d3E1SmIVI8mFET63kT8nErv6qmDD4+nundyb5pBn6G
	XDbyUo5fPjndKrj421w8D2KZGjB7r61SOoPkxuN2PUnF3D1u/9JdXyRFGiv+CRuUnZHyQXYuTsN
	UgGtRB9+qNqc/VRzdo1UbjckWLNSr+qMrV1Jp2g9JO8U0QZ9mEscXaNdVIFtRcU4+y/wUnW4XP8
	S5JogFhHTQo0gUqS2B2mKgureK2rcYS2731Pas1yeiw==
X-Received: by 2002:a05:6402:450e:b0:6ac:9a44:d409 with SMTP id
 4fb4d7f45d1cf-6b17c1dec0cmr625458a12.4.1791527343140; Thu, 08 Oct 2026
 23:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008220433.965791-1-linmag7@gmail.com> <038bffb2-e40d-44bb-b7ce-53e9de32e50d@lunn.ch>
In-Reply-To: <038bffb2-e40d-44bb-b7ce-53e9de32e50d@lunn.ch>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 9 Oct 2026 08:28:51 +0200
X-Gm-Features: AclHuK-JpJJ8BWVdNGK7pt4HrpIyJkAQKyqnfpnG3fkPyd0w-Sx8RYMtjvqDjms
Message-ID: <CA+=Fv5QvhYd7EqVBYKWVgvf92SLE=FjE8EYcZvUQ7HKdx2kc3Q@mail.gmail.com>
Subject: Re: [PATCH net-next] tg3: normalize inherited M3000 register byte order
To: andrew@lunn.ch
Cc: pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Oct 9, 2026 at 3:13=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Oct 09, 2026 at 12:04:03AM +0200, Magnus Lindholm wrote:
> > M3000 firmware can leave BCM5718 vendor registers byte-swapped while
> > standard PCI fields retain normal byte order. Match the Fujitsu 10cf:16=
5a
> > subsystem, IKKAKU model and swapped revision/product signature before
> > restoring host control; reject failed PCI accesses or register readback=
s.
> >
> > Keep this in probe so failures can abort initialization; SPARC firmware
> > enumeration skips PCI_FIXUP_EARLY. Normal rebinds and other platforms
> > retain their existing path.
> >
> > Use tg3.h's MISC_HOST_CTRL_BYTE_SWAP and TG3PCI_GEN2_PRODID_ASICREV;
> > the inherited state was observed on M3000 hardware.
> >
> > Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
>
> > +/* M3000 firmware can leave the on-board BCM5718 registers byte-swappe=
d. */
> > +static bool tg3_is_m3000(struct pci_dev *pdev)
> > +{
> > +     struct device_node *root;
> > +     const char *model;
> > +     bool match;
> > +
> > +     if (pdev->vendor !=3D PCI_VENDOR_ID_BROADCOM ||
> > +         pdev->device !=3D TG3PCI_DEVICE_TIGON3_5718 ||
> > +         pdev->subsystem_vendor !=3D 0x10cf ||
> > +         pdev->subsystem_device !=3D 0x165a)
> > +             return false;
> > +
> > +     root =3D of_find_node_by_path("/");
> > +     match =3D !of_property_read_string(root, "model", &model) &&
> > +             !strcmp(model, "IKKAKU");
>
> The DT Maintainers generally don't like this.
>
> Is there a legitimate reason you would want the bytes are swapped?
>
> Can you not just probe the registers, and if they are swapped undo it?
> Does it really need to be conditional on the machine?
>

Thanks for the suggestion. I've tested a revised approach without
the machine-model or subsystem checks. It checks the BCM5718 register
state, leaving a normal revision signature untouched and requiring
the swapped revision, byte-swap bit and product ID before correcting
the byte order. Both register readbacks are checked afterward.

On the M3000, all four ports normalized at boot, with no additional
normalization on driver rebind. Link cycling and bidirectional
file-transfer checks also passed.

I'll send v2 shortly.

Thanks,
Magnus
