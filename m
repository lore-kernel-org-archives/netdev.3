Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157B447F2C3
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248576; cv=pass; b=NX2REBxdl3GK+vnyECN2t6d5xHUmv3YLeTOFZ23LwRcxpT5JS+aJIAvztk6qdENfZv1+BXHAlDFmiEHLrqVSyU5nkzh4aVt0dyP9jRFDoWV81jbU495rcG8yOBt6vHsOc296wy0iQpqdK024fuALjFJ04C+QPorVgjwJloTVeJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248576; c=relaxed/simple;
	bh=R90ImgEHCwJyKD2bJwF8D8+9N9Wmq1BCm62ClNOCriI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQp7YQVFb283g1BsO/mXul1K/gAcsSeOJWSSnD9XXj2g3DSJlBDJms/BXNkkEZ/wpWSuXqpPVYiYDNwXUtg72ikB2vkqyxrPp2S/vX3cvTqpiYSOLcjLW3W/LdQyDMVIwDbvQZcPuWVgfVuzNbhsgEvDsbOlcMHR3TKS8PH/nEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERDGz/Jk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EN7xufpM; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERDGz/Jk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EN7xufpM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787248573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slRJAhpiu+OMl9eXIZnbJ6nz1I2rRm6Fs8xx70l6HI0=;
	b=ERDGz/JkpQ+Ap1tlulRGvRAMrhZ0KpPeaATFXoDSoguTs3FwEjqN1M9Mwa/7xdXQFHyxSJ
	FI1pI07rFaWEkcguqDyQeRX1OzlTA+UgCcOwTijfLequNxPK6mA/tCO2Wa5LdI1kOipnb2
	dPKCnAQK8P41A/jMgr9iH+WOA/3HpQE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-SfbUZ20JOuG_v_ssxoLS-A-1; Thu, 20 Aug 2026 13:56:12 -0400
X-MC-Unique: SfbUZ20JOuG_v_ssxoLS-A-1
X-Mimecast-MFC-AGG-ID: SfbUZ20JOuG_v_ssxoLS-A_1787248572
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ef8249f871so2183656d6.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 10:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787248572; cv=none;
        d=google.com; s=arc-20260327;
        b=YrMnhsqWt0hwU4oBSt5MhvZwmWy7o15hOQ3UP12LV+iGwvedWNacJOgs8K1zPlaa47
         gVFM+fJZJW7yk+ByxYVSlLKWnl0u9vv0xt5F7p5AMbGPAM5o9F5kM7gzb1kAz3XpxYRZ
         BXwWsfjp2iDgmxBMahgk+hlohVBNJll6/7dEUZ2IfTBjmjHW+NgGx0suftBFZisyhRKf
         EIrphwfPbJThnkinQ+dRVZe00UkXr30O7JOVueoWhqdst24X8VsF2aUUsYY1op2XofUD
         dcwcDxqPBBH0on4mPtQs9Nx7e76qlEPTzAc0Yl8LPdPCh3WkZJaGhXUmmhFt//0aCtXK
         4gsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=slRJAhpiu+OMl9eXIZnbJ6nz1I2rRm6Fs8xx70l6HI0=;
        fh=+2TAzy12znk2Etkjepe/uh+Td/+KWqRjoJBzMmsw0vg=;
        b=fG6OzOvDilfC179yq5IQKv8dI6VFSWCY4vjOOeu06RzHdGtnHSpcSL4XjgqbNsKP4Q
         BheFxzEz2jlvF+uL97l6wcNMvsSZ10evMywH1K59eseKlVd4m3Mf5cPXtfGViSs6odqX
         xw3FY3jBu2teUlD2R68Dqof4s1U2RSSdYQETyjA+nSNT/rPSwrNrsVCjyHYWUK42W8mU
         i18tnRPR3rKJqWGEYWStvJ1sEONC8FcTFVYeoukLK48Gzn6bn/4SaCvtgHYYZ7idwJFM
         K74gpa43sR5J1ByQXRX5g1i4MFB6M+6/gzrJuF8kEXv4hoxBV8AI6QZ3hxjq8EzcOCec
         lWAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787248572; x=1787853372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=slRJAhpiu+OMl9eXIZnbJ6nz1I2rRm6Fs8xx70l6HI0=;
        b=EN7xufpMDoaUNJGBq7PcVP9BORAvwELu/ZVeuxvB5ZJLmVwB5azHPhHPxUhvMbw8ul
         XL1lkpg6cPk/E7kn6bxiZ51xb7T/Qe3ocQmsX8LLnpE8XlD4Fo1SQbrtjgCLtV2rONga
         UCC1nEBY4cuMAw1Mqiq0vJa13mevpm8xUJD/tNLQ9kIHLcJPlTrGHxXuDbuIsv+NnogA
         Mwh6pZVAWgwJsi4vyNOlmO9UyjIa7s3JBQhGeaNBpjBSy6qFTaIB1AasnjktKVC3clB5
         jwWpvjvyWVcXPzBvTZPBDDJPhI/kjHveTwihawoIEdQYNtNKaaghJJCFdkUTZ1hV3p5y
         D5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248572; x=1787853372;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=slRJAhpiu+OMl9eXIZnbJ6nz1I2rRm6Fs8xx70l6HI0=;
        b=Mz0JnjVhR2UuKpHJQQWXylOnMy4nBO80JTwt4YMMBV0JKgnCq79WUyIdWxkD99AUgh
         OxTbKMt4eX+bRMf5rUw2fINhnF1C8GlXJ2IkqKDbTaxDSv4d9g17JYx+XlgXgoN2YJDP
         dGpdTFjkKdm00ttbFFE10hRbY6og+Cp+GEmWB8rr5QAauP+soyXr60IjmTW3J7w4hXGm
         cZqCE9lQeyZ4TXu/xck2y7psjR34LywVYw0QsnucxPQO3lTeHnPNidWIe3tvw12HJ+pD
         NzsN28Qa1WKv7rHgdxNAnHW0Q1Rm6qgii9zLuCyJSJvRbNdNrgPRw/u58Qi+op7FyltF
         p1Zw==
X-Forwarded-Encrypted: i=1; AHgh+RqN9vHwOPHj2o4yhTv0uLwbKJGUvh+QnxT726zFNAn+KKvCEy6PEx9MkYyCp/nxHUpwRy2oW68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVtK7Vi7wK8kUfTyQN+GwxYWoiK3lt9ue/HXd4YSzm0E8U3yVI
	yHwARj7KvoiErGJGu+JEK8Txy4KuCPUXEFrORMiI+PIkOmUGivLxM70r3baKvE55mWQuOniaFV/
	txnB7KRCdTsOcEk459/8KOre6zEUa3Ua47INxeOVQ1uPewTBeRHMcKgnBU+TKBYXE5hwwEvVrFT
	9A1QZfSd7q820/caBZgaGMQ9SLvhEsw+qD
X-Gm-Gg: AR+sD11uOjFs9T3dQjhOwXvaku8uzzAA5lTS0l2ik5TYHdTLcObWfdoqb1cvoQmu4jn
	Pn50wMRYjksM+oKXlu0QMdXuLbpSov/OjAGYzLgOjacLL6rNZD9yXN3MrIlTPUxT9apCppHCPRF
	NiMUCav1WgL4gp5ZN7k1iC3QUq13nO41ZQBtxMXM/+mTHL8+74RATwUwH3C/1jWZuJeFbEYBlLJ
	5QWwuLz7UG+brWQgLQ=
X-Received: by 2002:a05:6214:1c4e:b0:90a:81e7:404d with SMTP id 6a1803df08f44-90c5e6eb585mr174689596d6.9.1787248570879;
        Thu, 20 Aug 2026 10:56:10 -0700 (PDT)
X-Received: by 2002:a05:6214:1c4e:b0:90a:81e7:404d with SMTP id
 6a1803df08f44-90c5e6eb585mr174689066d6.9.1787248570313; Thu, 20 Aug 2026
 10:56:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818141556.64303-1-thwalsh@redhat.com> <CALs4sv1zb7OemFcKRceoO49F8yPSOdZWSkomvU=mGmReR74=BA@mail.gmail.com>
 <20260820103950.5dfa2969@kernel.org>
In-Reply-To: <20260820103950.5dfa2969@kernel.org>
From: Thomas Walsh <thwalsh@redhat.com>
Date: Thu, 20 Aug 2026 13:55:57 -0400
X-Gm-Features: AcwNN1X3jvlhn_URVFLZWAfe-6th0rqVl-xxvTO5engWR_NyMB57kNDXXjjzxYg
Message-ID: <CAD+aA83e_HP=Z0pXpcxW5j+TUXdgP3Dx8_LGxrMjdVwtERRCtg@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Gate TPH enablement behind
 BNXT_SUPPORTS_QUEUE_API check
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Michael Chan <michael.chan@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 1:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 19 Aug 2026 15:18:49 +0530 Pavan Chebbi wrote:
> > >         /* Enable TPH support as part of IRQ request */
> > > -       rc =3D pcie_enable_tph(bp->pdev, PCI_TPH_ST_IV_MODE);
> > > -       if (!rc)
> > > -               bp->tph_mode =3D PCI_TPH_ST_IV_MODE;
> > > +       if (BNXT_SUPPORTS_QUEUE_API(bp)) {
> >
> > IMO we should not gate pcie_enable_tph() on BNXT_SUPPORTS_QUEUE_API,
> > since TPH's initial steering-tag placement is valid on its own and
> > re-steering may never be needed in some cases?
> > So in these cases it simply disables the feature.
>
> Since irqs are requested at open wouldn't this mean that users who
> program affinity (all serious users?) will have the wrong TPH? Which
> is presumably worse than no TPH at all?
>
> IMHO the simplicity and consistency is good. AFAIU queue API is
> supported on fairly old bnxt NICs so the combination of CPU needing
> TPH and NIC design being 15(?) years old is rather unlikely in the
> first place. The real scenario where users may run into no queue API
> support is FW being old, in which case FW should be updated?
>
Thank you both for taking a look, I appreciate it.

In this particular situation, the customer had very recently upgraded their
firmware. "RX queue restart failed: err=3D-95" messages were still observed=
.

I should note that this was prior to the addition of bnxt_tph_update().

