Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968F02EAD1C
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784987738; cv=pass; b=aMu8ccrIXfp4epkFWJ/cQabyqhIoXcPK+l1cNr6NorTueplrpJUnn+w/b9hZNOI4aVk48ffKahJtDYV4Pj8TxCnLPnFyXt+ekV3rppvyH89/gjK74IYOVl0rz2qk7a7axZUpndaPLsNyr6YnhroTD3b9o4Snj7plt4rTfD6Gqmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784987738; c=relaxed/simple;
	bh=IRdykYTlkN5ap1y5hYJQTLrsRJiNxzFb2o/eGNkPuOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HN5gWys6fWtWqZGwcmloup4UmJy4pjTLJyozyhF0yLteR/fIE3JtCJvoosTMpzWozGY2o0d8j6BH1kC2mJCXZsoesrEmcUdsSA4skOkRw4+D54UygXvYZciiUtRAjc2M8lhpQA9HgN8M0cUGG17D62mcXBCpGpWrMG0t9mQdpNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggJlzG6x; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggJlzG6x"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1740c36c5cso176883766b.2
        for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 06:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784987735; cv=none;
        d=google.com; s=arc-20260327;
        b=ZUQs/GrOLsfTKqDiFXnGslYWGiwkuePu3Ps2iXFxEIaDZ08wVj8X1BZ1S5aLhN48Z6
         nP/YPzczwuB7L9yQefCjjdR5/FcpgtAFpy/qIbFyOrNPDom6C/aR2xXWhCMUbn9KmP6M
         9hN6OdEq2EjZH7EccHqPjAqSgrnbXApBDlnnaGcn5c5eG/JtPY8Fo+b8wpCsHQOCtL1l
         o/cIDqVotVGpQSzCxqmHf2VMwKKByGnEoqkOUn9bMdGZRTT9nN/7em1ssDWqDJwdjw8U
         e0jPRMKrvBw5iFXYfNxN6hGCsDzxITBSBqZMGkQ5PyEg2OwHm2wocBeYaO1ZbLSdL2us
         oWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/puKwbTTWP9a8ngnv5J1npAvEdozJh9Yntg5eX+y3+I=;
        fh=Cz0wks26zw70d79MuVX21KW/a/otPA5cc/gOBQN7nVQ=;
        b=FVbnHJ7tOeT1C/gCrZa4cQtgD6/bgYoqeA4WsSrupx9y2GhDIQJPN76y0oAnPZOTuf
         UcZ2gnHzXTshAAI88il5joMK2xFq4jNxr897Kmkw8xV5L6Ift7Nmvtzl1qGi07P0q9J2
         wfa/Vp5GZ+vWNU2Pi8r2Hqpq5JioGxP6C0Ei6nCYliXLUhBK45hiy3hXDLOZ7pfVNu7n
         RTk8Yc+c5MQGdXlZ3LkBpetQexsYnC4n/m3Rbd3wOvFIksSSRgeJGcTAXOfesAynyC7e
         tvvUJmvbEEDfKuLcEKvNSdX3ww0kPVhBBFvPlOhhplcYTfVJ3fp62wDeom2z8rC8H2ps
         c26w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784987735; x=1785592535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/puKwbTTWP9a8ngnv5J1npAvEdozJh9Yntg5eX+y3+I=;
        b=ggJlzG6x1d2HSA5i7OFipj9IgDDitkvvHAmmSuelA4cUuGm4Wh08OVZQvqQzvWQMNP
         8ZKR58Y5FNrKGFKQxjn7sFic+6nAjzOMayPxt5SF/UlnGSTjsIZUHEfkzWePA3sP3Y9W
         MaG9js+zcqzQpNxICDN01z7VbnPwle8iubiuoLEvXClRI7QwZsvVJDPMWZZ4z7dNfJo9
         +iBD0DO4/shNFENMdBUWf5OtgxFRQ8lcUaNrrifA0TsD1P7Ca/xjzfQtgQLxks7g5nOG
         ghc+sG0T7EDITrSRgUrmbJOoCnwpLWbujbclAAA40faUrsC/mtSFWFFK2FGboTZUsjEV
         p2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784987735; x=1785592535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/puKwbTTWP9a8ngnv5J1npAvEdozJh9Yntg5eX+y3+I=;
        b=ajfxKZ3CmiI9FPt3tkbQ2s4CyPGCcJ78UOHjFOaA8LrxAlvZQ7zrDRJxrseRf4VKB7
         V0BLDBbpia3Uu0eFOJuzQ+NlTCoqvFJP8+M8EREMgeANkJ3ftfq+hUK/5xdrGCDLDqBs
         mhtVX4IQKH+mc5i2RhRX6Kdz2oTny9+votpDu1Do8J2daw1Nk37CNylTVqYRgIsYZaEN
         Sq8gSZ8X7PvnTBCmYGdiBBTf9omFhTNBliqcLjJrxdj+vqjBN1xM17SDD0UdTBgaCsUw
         TH4UFZRaKKUo2IWewyUq11Tgq3Wk9B5ZAfV/sktDS6wxZIeml/dEBcXzTPhCp/2LTifo
         5GoA==
X-Forwarded-Encrypted: i=1; AHgh+RqZRyTz+9RqsuvvWR74n5YR4gfJ6gCZLEU6zYKooEmV+G346jgdXjcW7RssszCyVMRdAQlmZQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzK8t1Yzf/zJiQpq71E0xawi1tw/zwMREpR1Ie5UbrP1YlITAk
	b46u4Bm6LK3qQ81/ZonjVct+TnwEAvLMiAC7q8GZocHtpJozwfy85Qcv+2MmUI9cHX+wBUMMD77
	KBnqEkd5XnFnoYkxkhBcbsmXSpN0xBQ==
X-Gm-Gg: AR+sD135u0MDKXeofaKLQvsgDW4kbcn+X2bO8Rp/vCTBlpiFA0B9Zxuzt4aveDSspx/
	QaPAi4VfjaYOE4iMxCG+1O6/xrgP4Q76DO7EUa8xW5YbE7KZCAwyNcg35RHO3ZhTY5VLeGcYblJ
	EmtaqjvhkfhxkB48lw4s3KdHZaHqoYU1YJwcBBp69x7Mx95slcHOjtjHloM0TT5hSfefQJ/jNrm
	INjuFqmniRDgMR8tFGLsKG4NpoPObZB0K1805X5B2t3e6S0gjeLAUMUJsJ6BPMqv5mPYyJFd5ve
	bSr1S9cUgdEsTiBtKouTM0RZ2sZZKizpk5QCaH1jASV4Ccgcf8l8g6dbEC+HmVYN00NlpgE=
X-Received: by 2002:a17:907:983:b0:c15:f376:9642 with SMTP id
 a640c23a62f3a-c1f1f119245mr92930166b.65.1784987734642; Sat, 25 Jul 2026
 06:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720143511.43408-1-mhun512@gmail.com> <IA3PR11MB8986986280690863E016ACA0E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986986280690863E016ACA0E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Sat, 25 Jul 2026 22:55:22 +0900
X-Gm-Features: AUfX_myEDpHU_7CZdJZCAMYsX-P6rIRFrfbnz5EzBgeFs4qgEBEIgk406Eww6Uc
Message-ID: <CAGEsz8HNGUXsiZ_4Eg6atPjzWnTbWoxDwGVybgks3DmGhyH-=w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v3 net] idpf: disable PTM on probe
 failure and on remove
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Olech, Milena" <milena.olech@intel.com>, 
	"Tantilov, Emil S" <emil.s.tantilov@intel.com>, Mina Almasry <almasrymina@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood. I won=E2=80=99t repost it unless I receive concrete feedback.

Thanks for the clarification.

Best regards,
Myeonghun Park

2026=EB=85=84 7=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 6:17, L=
oktionov, Aleksandr
<aleksandr.loktionov@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Myeonghun Pak
> > Sent: Monday, July 20, 2026 4:35 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; intel-wired-
> > lan@lists.osuosl.org
> > Cc: Olech, Milena <milena.olech@intel.com>; Tantilov, Emil S
> > <emil.s.tantilov@intel.com>; Mina Almasry <almasrymina@google.com>;
> > Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> > <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Myeonghun Pak
> > <mhun512@gmail.com>; Ijae Kim <ae878000@gmail.com>
> > Subject: [Intel-wired-lan] [PATCH v3 net] idpf: disable PTM on probe
> > failure and on remove
> >
> > idpf_probe() enables PCIe Precision Time Measurement with
> > pci_enable_ptm(), which takes a reference on the device and on every
> > PTM-capable device up the path to the PTM Root.
> >
> > Neither the probe error path nor idpf_remove() drops that reference,
> > so the PTM enable counts of this device and of its upstream path stay
> > elevated with no bound driver, and the device's PTM control bits
> > remain set.  pcim_enable_device() only arranges for
> > pci_disable_device() and does not undo the PTM enable.
> >
> > Add the matching pci_disable_ptm() to the common probe unwind and to
> > idpf_remove().  pci_enable_ptm() failure is not fatal here, so guard
> > both calls with pcie_ptm_enabled(): pci_disable_ptm() decrements
> > dev->ptm_enable_cnt unconditionally and then recurses upstream, so
> > calling it after a failed enable would drive this device's count
> > negative and wrongly decrement parents shared with other endpoints.
> >
> > This issue was identified during our ongoing static-analysis research
> > while reviewing kernel code.
> >
> > Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > Changes in v3:
> > - Rebased; aa8671af0c38 ("PCI/PTM: Drop pci_enable_ptm() granularity
> >   parameter") changed the call signature, so v2 no longer applied.
> > - Guard both pci_disable_ptm() calls with pcie_ptm_enabled(), as
> >   pci_disable_ptm() is refcounted and recurses upstream since
> >   e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and
> >   Switch Upstream Ports").  Raised by Tony Nguyen.
> > - Dropped the v2 claim that pci_disable_ptm() is a no-op when PTM was
> > not
> >   enabled; that is no longer true.
> >
> > Changes in v2:
> > - Disable PTM in the probe error path, as requested by Emil Tantilov.
> >
> >  drivers/net/ethernet/intel/idpf/idpf_main.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c
> > b/drivers/net/ethernet/intel/idpf/idpf_main.c
> > index ab3c409..97bafeb 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> > @@ -159,6 +159,8 @@ destroy_wqs:
> >       mutex_destroy(&adapter->queue_lock);
> >       mutex_destroy(&adapter->vc_buf_lock);
> >
> > +     if (pcie_ptm_enabled(pdev))
> > +             pci_disable_ptm(pdev);
> >       pci_set_drvdata(pdev, NULL);
> >       kfree(adapter);
> >  }
> > @@ -266,7 +268,7 @@ static int idpf_probe(struct pci_dev *pdev, const
> > struct pci_device_id *ent)
> >       if (err) {
> >               pci_err(pdev, "DMA configuration failed: %pe\n",
> > ERR_PTR(err));
> >
> > -             goto err_free;
> > +             goto err_disable_ptm;
> >       }
> >
> >       pci_set_master(pdev);
> > @@ -279,7 +281,7 @@ static int idpf_probe(struct pci_dev *pdev, const
> > struct pci_device_id *ent)
> >       if (!adapter->init_wq) {
> >               dev_err(dev, "Failed to allocate init workqueue\n");
> >               err =3D -ENOMEM;
> > -             goto err_free;
> > +             goto err_disable_ptm;
> >       }
> >
> >       adapter->serv_wq =3D alloc_workqueue("%s-%s-service", @@ -366,6
> > +368,9 @@ err_mbx_wq_alloc:
> >       destroy_workqueue(adapter->serv_wq);
> >  err_serv_wq_alloc:
> >       destroy_workqueue(adapter->init_wq);
> > +err_disable_ptm:
> > +     if (pcie_ptm_enabled(pdev))
> > +             pci_disable_ptm(pdev);
> >  err_free:
> >       kfree(adapter);
> >       return err;
> > --
> > 2.47.1
>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
