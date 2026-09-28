Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981E4E36F1
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611285; cv=none; b=l7BQlxVcDsobeMfTooEGTzalcY+Dy2AdpO+ASa2UaAvbuKqWPeOfZptrZWndOsiEOyem2UFZgSe91hbyZRxodupLK0lYihnE1lWpZX86mhpIZ0hFS4FgGZaUGagrfrQpyPyPlUqMxTSi6Zra1gYjyTo9cyrDEaeMF/lO+qZrq3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611285; c=relaxed/simple;
	bh=uSKWGEy+h0iZrPZ3sx1w7LlZBURNAT0ImgBibqITfCc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=rrui36k6DnACLpareCZv6j6MQZeExnC1CpIs+eDkqgbIgC+jc6QItg8A2sRrj/GZ3WERMa1Aks/sO5Yxy1BxMJRF2sgajp5QG5YiZ7V/oQxzuTCMN7wFlxVOZZeOmBLiQaZlDb9UnF/7/wu/yw7HW4G50ff/e2ij+QMdwp+xffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLYrsp8U; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLYrsp8U"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-9144443299bso16289006d6.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790611282; x=1791216082; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0L0FfZEwFrI5hnOen6cKyT8bGV7DqSFD/qxUGYMRgC4=;
        b=mLYrsp8U1ewdKN6ZuAjN904WjXAEnrq4AROfEBedTkheVduZCT4PiT55DZJIXp+0/I
         PNJ+y1jYs8N5IIQ7GUemW/6n5Al57tktiB88eNM9uRcE64P2YRIpsyTlhReGwx7K213O
         BXYWlQeY3KEpFgBEiiYxPvpEwv4S3sDJyCQBAoBkj/3JmujluI67wQvdOvoOGF5K30mI
         UECe2a1QcygOk3lWajoZnfe0J1mLqNKfwfpWZ/lHvVZbtCLW+aEeyvMxFY1VsTT2eD1d
         7JRkgdXyannb/R4mrCdxydOLkcXbm/8e0mstAqz3aI+xts6QHsPreWzJmNZENx2xJm9I
         EqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790611282; x=1791216082;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0L0FfZEwFrI5hnOen6cKyT8bGV7DqSFD/qxUGYMRgC4=;
        b=cJKUuMQINlXXh0EBsWcGgja+mJDULCC0Ux1XyVM4fcTb2wFp+UvUghMe7vbz+yEPtq
         Iuc8wjncFhcXd4HFYYxDLy2JY0B2UXxS0TiMGPXhWDN2DeI+GF5Lp2hmrCz4BJXocZ0a
         FLPRrymWBE/N5gaOE+GD8sTiDEFONWda+dhgj7XTtqb5G/IONFMn12HFhWOe0kUJ3uDi
         hoYKe+aCcyRkii9O/YdeLaWyGcZaGKn4ZAiVf3n3FGub4IXhsHGHiu7QEZt5AbDTabtF
         QPTnZKGA/Jng2bm+4RNw/7nQJLSo2BD7lPiyoiaVQ4ypwusmb0NHD3YwOARvOFIWqJzj
         urzA==
X-Forwarded-Encrypted: i=1; AKwUvBxuNfMX7wzEZoBBJc9A4OYwca1cGObEEkqBN+oBxWdqL3M6ljC0m5/lIq1NDobK9/fAWk5/+j8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLWRMW889SY3zyHLR8PKU4cnq5gDkcKG0MIkXaOox1iSEFCAqVf
	4fbOkeGAap5ImGmda7ONYyfNL+gp7d2/8giyBDOAlxZWIT3HQcYU/By7
X-Gm-Gg: AYBFou3xvGuT6Xh41qTuuhS/+N8BfITgcrK+rrmgw0wvqXFSz4peFXfIrVhPprXN8lL
	dGBJRAj1Va0folxdvtswoihmCss8BCb5tO+Njj5FaXOb+Je6NT3WWcnE4Bp5DNCAq1giNa9z6lD
	eqvSaeHOiBipHx9rcy1PcnxbQLEPEU44ySRhBNkfihS/XnJxc0kDq+HXEYlk1ceSqMd46lm3Q6n
	U9tHFsBPf8Tso4S/8LoAr3U4vk3HcYsiVIFTQoCn0L7F2dl4MUpUiYn75QJPh2dSFrgWIZ2JPG1
	X1ul85PAZmKjwkiQZVQacyGGmg7RTkTXe2zhxdjH8E83+e8JSAdVN6BgkhoF3iGGO2zxaqt9SkL
	srk+syFnzsO9mxl+JHJeuENkyeN2a6K6OCXSKj470/8VNBm8MTLyhEbfeNA3zWfTlvqQd+dxZh3
	9eUbGp7e1nrEM3E+i3EneNFs17gT/kXgX3l/lVAwNEtEXvHiMd9jjlcDHabjU+1U0xPKrLs1O74
	X8=
X-Received: by 2002:a05:6214:1d26:b0:914:40fb:8e89 with SMTP id 6a1803df08f44-91440fb8eebmr178876886d6.16.1790611281978;
        Mon, 28 Sep 2026 09:01:21 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430e09985sm83727016d6.30.2026.09.28.09.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 09:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 12:01:20 -0400
Message-Id: <DLR2Q21OM7VS.EXK4BZIZJ1VL@gmail.com>
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: <netdev-bot+sashiko@kernel.org>, <daniel.zahka@gmail.com>
Cc: <alexanderduyck@fb.com>, <kuba@kernel.org>, <kernel-team@meta.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <dimitri.daskalakis1@gmail.com>, <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/8] eth: mpnic: allocate MSI-X vectors
X-Mailer: aerc 0.21.0-threadmapfix
References: <20260924-linux-mpnic-v2-3-4badc9b58b9e@gmail.com>
 <179055370029.3145.13976204260796634034@kernel.org>
In-Reply-To: <179055370029.3145.13976204260796634034@kernel.org>

On Sun Sep 27, 2026 at 8:01 PM EDT, netdev-bot+sashiko wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in ca=
se
> you want to address the nit picks below when you respin.
>
> Low priority / nit picks for your consideration:
>
> - [Low] The driver frees its MSI-X vectors both by hand and through
>   devres.
>
> --
>
> eth: mpnic: allocate MSI-X vectors
>
> This commit adds mpnic_irq.c, which allocates one MSI-X vector for FW
> interrupts and one vector per online CPU for the completion queues. The
> allocation happens in mpnic_probe(). The vectors are freed on the probe
> error path and in mpnic_remove().
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_irq.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_irq.c
>> new file mode 100644
>> index 0000000000000..bcc33655cbbea
>> --- /dev/null
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_irq.c
>
> [ ... ]
>
>> +void mpnic_free_irqs(struct mpnic_dev *mpd)
>> +{
>> +	struct pci_dev *pdev =3D to_pci_dev(mpd->dev);
>> +
>> +	mpd->num_irqs =3D 0;
>> +	pci_free_irq_vectors(pdev);
>> +}
>
> [Severity: Low]
> Is it safe to call pci_free_irq_vectors() here when mpnic_probe() enables
> the device with pcim_enable_device()?
>
> pcim_enable_device() sets pdev->is_managed. Because of that,
> pci_alloc_irq_vectors() in mpnic_alloc_irqs() ends up in
> pcim_setup_msi_release():
>
> drivers/pci/msi/msi.c:pcim_setup_msi_release() {
>     ...
> 	if (!pci_is_managed(dev) || dev->is_msi_managed)
> 		return 0;
>
> 	ret =3D devm_add_action(&dev->dev, pcim_msi_release, dev);
>     ...
> }
>
> The kernel-doc for pci_free_irq_vectors() says not to do this:
>
>  * WARNING: Do not call this function if the device has been enabled
>  * with pcim_enable_device(). In that case, IRQ vectors are automatically
>  * managed via pcim_msi_release() and calling pci_free_irq_vectors() can
>  * lead to double-free issues.
>
> With this patch, both the err_free_irqs path in mpnic_probe() and
> mpnic_remove() call mpnic_free_irqs()->pci_free_irq_vectors(). Devres
> then runs pcim_msi_release()->pci_free_irq_vectors() a second time.
>
> Today the second call does nothing, because pci_disable_msix() returns
> early when !dev->msix_enabled. That makes it an internal guard, though,
> not part of the API contract. The TODO in pcim_setup_msi_release() also
> says the implicit managed mode is slated for removal.
>

For these two reasons (second call idempotent, msix auto enrollment in
devrez slated for removal), I think it is ok to keep as is. Let me know if
that is a problem.

> The pattern is still present at the end of the series.
>
> Could the driver pick one owner for the vectors? It could drop the manual
> pci_free_irq_vectors() and let devres free them. Or it could stop relying
> on the implicit managed mode, so the explicit free is the only one.
>
>> +
>> +int mpnic_alloc_irqs(struct mpnic_dev *mpd)
>> +{
>
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c b/drivers/net/e=
thernet/meta/mpnic/mpnic_pci.c
>> index 68a64377e6c5a..127b71b44b0fb 100644
>> --- a/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
>> +++ b/drivers/net/ethernet/meta/mpnic/mpnic_pci.c
>> @@ -112,12 +112,18 @@ static int mpnic_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>
> [ ... ]
>
>> +err_free_irqs:
>> +	mpnic_free_irqs(mpd);
>>  err_free_mpd:
>>  	kfree(mpd);
>> =20
>> @@ -132,6 +138,7 @@ static void mpnic_remove(struct pci_dev *pdev)
>>  {
>>  	struct mpnic_dev *mpd =3D pci_get_drvdata(pdev);
>> =20
>> +	mpnic_free_irqs(mpd);
>>  	kfree(mpd);
>>  }

