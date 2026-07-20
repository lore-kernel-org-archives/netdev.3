Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FE2425879
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556543; cv=pass; b=OIq1x5AufJekfsabUAiYrn2f0kN7Otcam315eItp2GUrmsjsGqaIjziIj7dfCZ1RHuIHWIcAFYzGb5iFHk4DnNDA9S0r2pa5ZJja7J63EoWkVkHI3FqN/isQoVa2REb68QmtAc/Xa95LfRYQgGut1aSQ9KaH6xwTc2sNopSE+w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556543; c=relaxed/simple;
	bh=W7/0GcsetZredKbf5ladrH0PIY5JdqBl3EmDuXIBkxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC05vgzeW4Wb/3EJhecvga0mmRFhC95kgm5gq4MZb3RdPEa5kDzw2OrNYpNMKS3UGzfcREN3ATmY/ZjwP+6rwZ4mihKJYCMt1/AbN57J4Ww2pL0tMSAy4GC92l43BFaj/DRaNKJIvg9Pb16uEc5s74+hcPOq9sI3HIDTNGbvh9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g89q+iXM; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g89q+iXM"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15e2dab83eso1104072266b.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:09:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784556540; cv=none;
        d=google.com; s=arc-20260327;
        b=XTuqq/BwgOL/w7BBUlmdYIrzuIui+DR5vCb3wRypQYWoa1TxiST1naKVtCCwJf5T+k
         YrRXp9QpgszYnRcBk53kA2OdVmH3FE0upeHFXJ+VUh4EPfk3Qdzv8c+a03QqNNWxK7kJ
         Nb98pMMSaoTCRl9LQj93BCGPlyfOkwz6KAZIL4b7pIJMN3kNwR+9N+dpYj/IbAQ3rN2o
         N2w/IIaxuyJpIGdD5US1Th3lBG2zRAXyD0owkrM7i/wI0FjRB1cduXke3zNyLTB317Ft
         Ur/9529ZkfywbdJlqg8QiR0N/Mdzp6/xBSd9K6lAWnAUZO3fHYusCW+S6cbf6Zk5vEDX
         fe/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a0WHbbtZjdUGCOVhaSfhJTsOarehv1PQGNc28148fV4=;
        fh=bAPkp4dhGomLxtoyEqWBa4+J9932SW0SDF4Ezi6QY3I=;
        b=AWWH4XpHyBDk0PIeBHirtDhAepbTO9ACDc9Yci1G+xiMMg5dOUtHOca0RUzm1+AgMq
         b7u3iN0rxBzGcFK1Z/djnCzKhrQbsQwK9F2WT6wFJTOV/hhhuEH9zSbBmYN2UKlPwXtX
         m/pjNvqowyKpAAXcIKi4dUM4GAVGLPl6oKLnVulG//IcaaQ4GeAs2mpnQuQns+HxbnEE
         fiwMOL4MWNlQe59q2jj7yO/8qoU4W9rbU80c/H1qXgTJwdPHRXLioAAOQJqoGzsP4cEh
         csYtTuvfttb2udJJkl75/EWshKMSMRaJjbkkWiarj0UmjJnfTeMQOJWtNA8pTT4m6yR7
         AIFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784556540; x=1785161340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a0WHbbtZjdUGCOVhaSfhJTsOarehv1PQGNc28148fV4=;
        b=g89q+iXM2LR+Dp3/QfQFhMyT1QfwKJzJhv/zIOOXTL53Kre0oeBQCOe8TcHoltSHVr
         JqAkflzLmVC5hpCLQUnZ9Pimhb1NXotKLZ5/wwEUg1XdP9cuOKqAaXV9NEIxqRw2wWr7
         eXIi7y1/ZMd+ntZrLCeU4TcFRU6fsvIzRT4w0ji+7CIMAhDIMA67Y6bTrn0fO3guw3i6
         JsUnMLq4+ioUB84Qfz58cGRpyhb2bXiHBgNemPWcK6016hE415HaUbr8PNl0QkxWVxth
         e3eZdou9O4M2ol0/zYALdfcJr72QXnJB/qywu1RNzGyD5DHbLFKGRanENA4v4ptVUQJI
         F/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556540; x=1785161340;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a0WHbbtZjdUGCOVhaSfhJTsOarehv1PQGNc28148fV4=;
        b=c+OAl8ydRud0nHMDjxODKGV+U76C+peG1lh/ORTru8l/rIt592YABb3jSop8mdPi9I
         2O1CDZM2sSA/WglJPlFMrqNiRQ6sUlMAfV3lCFKis8fEckC/W5HHenCHBfakVrDfpYKs
         SAJnVlk7njb+hHCI6dnXwLhkFW7/sC9AoCzkpTXgBspWcOWitdah2BkvNEkjuWgVKHnL
         9t3zcu0BmF5QTzNTf/+gLeySRw51MZMtTH8l3s3X7cMGjF7TpDzdr8ZZucd6haJfd/TQ
         EScv5r2ZUpEt9gghaa19e+2HocY6v0HzSlbK2UcM86Nqt8UAQMcAhiIak0UhJtVIpUjN
         aRuA==
X-Forwarded-Encrypted: i=1; AHgh+Rqcr4poBN5UJ7htUpVcnAzpVSu5U9ypvUifq1eYMFIRrqiqIJ2GXPeF2MpxQgQ8J15Y9eWwMqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8/7vaIyaFJUnnhIDou0HonBxUqjaXeJiJsmXHFJY9TmYXwQM
	TG11SDR1CNHJvLx+r8WpqQSB3Doc8PPbxf7gNj2nBAW047mIGv2XRAaxmSvp8O8CKgkviX13ed4
	cU8/5CVJByyx5GP18+zgO4eBg46hdFQ==
X-Gm-Gg: AfdE7ckCrRuYMBzCLdEFs1sXXvTAh587pvz57XOgY2JjYtEWClGyMuOF2PsTQxFKzpc
	sIlrQ7KkgdDgIArGoD4x19dJZ7RXwPgheBuKtV95sN7T7/SiG0NmpCLX7xMDDk23W9J4DeYY7hn
	JTe3rgpbU966GXTiKZ20WEg3kAObcDCUxC6gJKgZuU6qFEWvrIPJ7y0fq6sXExoc5r31ZFMdq/a
	8Q+5n9cOvv/ZWJaEYLe/gmuq7Jghlp7x1QHpwRQ5+0O+2tIudDWavofajo8i/sskleYsRgXlgK+
	T9X8zy/IGF8V/T/h83PkIBXc4dP2UEQ/U7Ggapj/HKOKMO0Fu3+R5kRfIhMkGmQgDdRbRUo=
X-Received: by 2002:a17:907:c50e:b0:c15:e193:14ad with SMTP id
 a640c23a62f3a-c16b47289d2mr581296966b.13.1784556540095; Mon, 20 Jul 2026
 07:09:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715074342.49281-1-mhun512@gmail.com> <37756e55-5feb-4f5c-9400-55a9762f9a77@intel.com>
In-Reply-To: <37756e55-5feb-4f5c-9400-55a9762f9a77@intel.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Mon, 20 Jul 2026 23:08:48 +0900
X-Gm-Features: AUfX_mxtVoqkdqPhiDiY7yGDPj-pWoFyQNJiWjpvvKZjBhKCfwEI-uuXWEFQe7I
Message-ID: <CAGEsz8HUg5yApfwtdHK4CAX7wfpBoyvrC2K8Pe1JZGu+G7hZ1A@mail.gmail.com>
Subject: Re: [PATCH v2] idpf: disable PCIe PTM on probe failure and removal
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Milena Olech <milena.olech@intel.com>, Emil Tantilov <emil.s.tantilov@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You are right, thanks for catching this. I missed that pci_disable_ptm()
now decrements dev->ptm_enable_cnt unconditionally and recurses upstream,
so calling it after a failed enable would corrupt the counts of parents
shared with other endpoints.

v3 will guard both call sites with pcie_ptm_enabled(), which idpf already
uses in idpf_ptp_set_caps(), so no new adapter field is needed. v2 also
needs a rebase since pci_enable_ptm() lost its granularity argument.

Thanks,
Myeonghun

2026=EB=85=84 7=EC=9B=94 18=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 5:21, T=
ony Nguyen <anthony.l.nguyen@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
>
>
> On 7/15/2026 12:43 AM, Myeonghun Pak wrote:
> > idpf_probe() enables PCIe Precision Time Measurement with
> > pci_enable_ptm(pdev, NULL), which programs the PTM control bits and set=
s
> > pdev->ptm_enabled when the bus/controller supports it.
> >
> > If a later probe step fails, the error path releases the allocated
> > workqueues and adapter memory without disabling PTM.  The remove path h=
as
> > the same imbalance when a successfully probed device is detached.  In
> > both cases, the PCI core's software PTM state and the device's PTM cont=
rol
> > bits remain set with no bound driver.
> >
> > Add pci_disable_ptm() to the common probe unwind after the PTM enable a=
nd
> > to idpf_remove().  pci_disable_ptm() is a no-op when PTM was not enable=
d,
> > so the non-fatal pci_enable_ptm() failure remains safe.
> > pcim_enable_device() only arranges for pci_disable_device() and does no=
t
> > undo the PTM enable.
> >
> > Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > ---
> > Changes in v2:
> > - Disable PTM in the probe error path, as requested by Emil Tantilov.
> >
> >   drivers/net/ethernet/intel/idpf/idpf_main.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/=
ethernet/intel/idpf/idpf_main.c
> > index 0dd741dcfc..f08ce13c20 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> > @@ -159,6 +159,7 @@ static void idpf_remove(struct pci_dev *pdev)
> >       mutex_destroy(&adapter->queue_lock);
> >       mutex_destroy(&adapter->vc_buf_lock);
> >
> > +     pci_disable_ptm(pdev);
>
> Sashiko says:
>
> If pci_enable_ptm() failed earlier during idpf_probe() because it was
> unsupported by the bus or controller, does this unconditional call to
> pci_disable_ptm() corrupt the upstream PTM enable counts?
> Looking at pci_disable_ptm(), it does not check if the local device was
> successfully enabled. It climbs the PCIe tree and erroneously decrements
> atomic counters like ptm_enable_cnt on parent switches.
> Could this eventually break PTM for other downstream devices sharing the
> same
> switch if a parent's count is incorrectly decremented to -1?
>
> >       pci_set_drvdata(pdev, NULL);
> >       kfree(adapter);
> >   }
> > @@ -266,7 +267,7 @@ static int idpf_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
> >       if (err) {
> >               pci_err(pdev, "DMA configuration failed: %pe\n", ERR_PTR(=
err));
> >
> > -             goto err_free;
> > +             goto err_disable_ptm;
> >       }
> >
> >       pci_set_master(pdev);
> > @@ -279,7 +280,7 @@ static int idpf_probe(struct pci_dev *pdev, const s=
truct pci_device_id *ent)
> >       if (!adapter->init_wq) {
> >               dev_err(dev, "Failed to allocate init workqueue\n");
> >               err =3D -ENOMEM;
> > -             goto err_free;
> > +             goto err_disable_ptm;
> >       }
> >
> >       adapter->serv_wq =3D alloc_workqueue("%s-%s-service",
> > @@ -366,6 +367,8 @@ err_mbx_wq_alloc:
> >       destroy_workqueue(adapter->serv_wq);
> >   err_serv_wq_alloc:
> >       destroy_workqueue(adapter->init_wq);
> > +err_disable_ptm:
> > +     pci_disable_ptm(pdev);
>
> Like the issue in idpf_remove(), does this error path unconditionally
> disable
> PTM even if the earlier enable attempt failed?
> If a subsequent probe step fails (such as dma_set_mask_and_coherent or
> workqueue allocation), this path is taken regardless of whether
> pci_enable_ptm() succeeded.
> Would it make sense to track the PTM state in the adapter struct, and onl=
y
> call pci_disable_ptm() when it was successfully enabled?
>
> >   err_free:
> >       kfree(adapter);
> >       return err;
>
