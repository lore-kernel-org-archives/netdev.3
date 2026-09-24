Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2B3E00A5
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790243817; cv=pass; b=AG0wkrzyVcD27Kx9MbJWCGuskAuneTWDrf5iIZo8Q9+/djyRmAvKWPM79hHpMvgUG31gN+oVEoTujbng3ChvrKJ9ubsmhkVitfAGPnz5IvkWsApXpCOjDZzIznpKXQCHAB/RV58eaMYZir9+h8yPY/R5WJbZEGax4c18b/btIPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790243817; c=relaxed/simple;
	bh=P1ndA+eBVn+zYbAgTqPlA5s6bd2yOGM1nW0tBCwcEQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKIFqL4qsuxAmL9WGxv2sXXS+s1T1X8MG1qxj/GB61OVe5oO5nBLuZ+mrB+7jvNfuhCeOkdUs69FD5pSEyA29JPKrrTPLzpxHsj7AT7Kf2I5FtXZ5Ff08BFHSiP+xbbOTXhT435Vipp/Y4KfVxA5zCocuikjsHyAhmVu1jJT86o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJVbFSWT; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJVbFSWT"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb7692a57so23806411cf.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790243801; cv=none;
        d=google.com; s=arc-20260327;
        b=djHbrClUs9MoeCuwg4ygjKblLedwGNAp2prB8MUR8+ruZAqyjc1uUDXJb3lhYqHvAw
         s1CZ/CxIUcJWOrxYpXRyjE/DIVTJX5nT4DUymPZn6OkaXZYVRMp7t5mm+7/F+L75gaim
         HekqyQMMC9q+YB1vOvsQjccAECP+dSOkr+F7+9ZLd+A089BsKAJ3LiofRu7jr1At66OB
         +DV+/VPmrbmTtXm5W/oVrUcfg1R9aDfRJyP79Gxy7mmCfc3rWwqHo1TTbK4SRqcaw6eU
         uBECI1yq+HHmCVY7T6gtUzhpCsHJW4DHOSUhQNu47c6ei+YlgR1UIrWqeNVWh7l3VLZs
         VBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZIYNgjeCL0OsYc0prVytzssq1ZX8j8EgYAM9VB1jIEI=;
        fh=qyP+Q7W9iPrZ5cIvNGWBTPof++OGSTRRohy2yB6xei4=;
        b=k9izvplHCvp4fTFgf3VHZVgZUqzirTLW+i82fVr1Z28bvaEHvYPidEZGhoVGn5hu7F
         QJxgnBxuID+BPZtElAbyrczs09nv193la4MczyxayiF/bmvnZ5p8vUL6THcmRy8nQz5k
         QNJiYhjK/Hjv+VLrYrkDl7c7HT3M1y4nV/+I7Ea+PsPbkty0zInD10yLbXTHkj6Sni9j
         OFpXAjsTxky6KG8YxVkaPvGBkaw01fp/dm3Ss+dRDeoiNCNMnRrYXBaQBkD2X2+b1DVz
         uil9itgfQ66u5ye3vwjfnN7xMCKefybTklmOUnq9ORjjqIwSAIv09Mcm6H6MGHafTSoR
         ucxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790243801; x=1790848601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZIYNgjeCL0OsYc0prVytzssq1ZX8j8EgYAM9VB1jIEI=;
        b=PJVbFSWT1X8mh3hx5PnKzYW0FA/5H4rTYypMG8e8iiFO5+aj/nMoI9Gyr3Iu0eiS0a
         ZaaWilagYC66hqDVHeZrt/JkpRuoFook6AwqndEcd9wc9iKuSc/qkSEA4OBN1vUN4A6E
         SPbEJivIzQWCLAgHdwfpXWFin95GtMqkzsmw7Y/lPabc1SvRNmaAs6/UEfvMWBAzsVKT
         /YRgxIyEqzYo9ZzcInvBJwndjBRVcoeIYlqOm12/vGG55nYbJC+qBj2inSaSB4zHV4jY
         EzcG4Fv3KSfA1uX9XE3lOwQwhVmJjQeKaDTbbvgnl/i5Lr52Hm272rIZRl00vaFuE1/V
         sgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790243801; x=1790848601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZIYNgjeCL0OsYc0prVytzssq1ZX8j8EgYAM9VB1jIEI=;
        b=IQtLtQPjJDD60U4LTafY3PdN/mFmH1unS1UHgNdam+JnEe9z0ivldeXI1YH6tcT8lv
         MCRcJBuz57C0Qrz9VCWS7QlJHcaA04K+LB4KXi4KCkolHLfFtQHQdzXrxAXw3LNh/eaf
         xWfhz418fcvH2u936Aw5Zp8fWQq8unTTNOPirZlJ//gwuSxRXqr6ywKZgfPvMbbOm0uw
         C1v6FmlfJBtxb+nQ6TlQ+sHHJy7sE82uN2mUBtrd34p0/1Lby09zrnc7Azk965C5LRCY
         37vAD5w12BtJZnj9iXnWfDZDavkA/FQhj5ASibBYBuuOtjP57+dXkpYg69yMnXW9P3c0
         Nf/A==
X-Forwarded-Encrypted: i=1; AKwUvBw0ig7DoK52JYtKnq971CAmyWGNXF6qasJzq4QAMiaP5FtaK0DblLYpbJqSI9QgbEQglIf6Tmg=@vger.kernel.org
X-Gm-Message-State: AFuF++k+UgFtPUK4lbD7QKYmWI6P6AGpTEbc+SNFfysbC3Vf3wW6LsHS
	ojSLYRm7giv8qiCGkNnrsEIRSntkeAvLfV5HcHL5onqdew+wcQbSBA4+zB0q37TKh+z0yfGLwA1
	DcOTd2bNrTppYSDAK2XO/hQbe3CWdxkQ=
X-Gm-Gg: AYBFou2d9Ar9t0860/9PFA9Xud5fyN4oqpseRwApxuwC19rieG4iZaLs+2Yryu28J4P
	IboWAL+W6PRKodKVawcALtC0+U7vkp04TfBDhxZ8+mYhydLeB6RfCQMKrNhoVLYx9O7M/BWWpHU
	b6HXOTsC2g+ZLvVUzHOMIu0VRLWUfNbzzeEPBYkeX56fGGO6DNFmzB0wWQCb6HPAu+ycHxCFO/n
	VmFpIPKioS03dnwCG9x4SZt3vvG9AqWllZBa43x63kbF3zpv+1ZxvhXRxT+sdXp898XIWyu1Tnz
	CvYGwjG20n8t6D2824YbbYqBkhEMarJUH+gJEcuBc/OTriVaBYMQAzFm
X-Received: by 2002:a05:622a:410:b0:532:d838:12dc with SMTP id
 d75a77b69052e-532fe9eed7fmr14187851cf.3.1790243800860; Thu, 24 Sep 2026
 02:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260924095152.3069-1-nsvatoslav515@gmail.com>
In-Reply-To: <20260924095152.3069-1-nsvatoslav515@gmail.com>
From: =?UTF-8?B?0KHQstGP0YLQvtGB0LvQsNCyINCd0ZbQutC+0LvQtdC90LrQvg==?= <nsvatoslav515@gmail.com>
Date: Thu, 24 Sep 2026 12:56:28 +0300
X-Gm-Features: AclHuK83QQU4UjKE_sfTN9cHFKc0YIJOfadhF_smKbWELBPGpi5wSU3S_A9rXeo
Message-ID: <CAJ_tAk7VFvsRk-suqg7-JJHcm=N1kEt9-qgg6sD+u5oAfyB03Q@mail.gmail.com>
Subject: Re: [PATCH net v3] net: e1000: fix warning in iounmap on probe failure
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please drop this version. I accidentally sent this without staging my
local changes.
Sending v4 shortly with the actual code.


=D1=87=D1=82, 24 =D0=B2=D0=B5=D1=80. 2026=E2=80=AF=D1=80. =D0=BE 12:52 Svya=
toslav Nikolenko <nsvatoslav515@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> When e1000_probe() fails, the shared error handling ladder attempts to
> iounmap() the hw->ce4100_gbe_mdio_base_virt pointer. If the hardware is
> not a CE4100, this pointer remains uninitialized (NULL). On architectures
> like x86, passing a NULL pointer to iounmap() triggers a WARN_ON_ONCE,
> which is fatal under panic_on_warn.
>
> Fix this by conditionally unmapping the CE4100 MDIO base only if the
> mac_type is e1000_ce4100, matching the exact logic used in e1000_remove()=
.
> The hw->hw_addr iounmap() remains unconditional since it is guaranteed to
> be valid for all error paths reaching the err_sw_init label.
>
> Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dca1ef9e2e234b8d3599b
> Fixes: 13acde8fffc0af ("e1000: Fix the CE4100 bus type for the MDIO/PHY r=
egisters")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
> ---
> v3:
>   - Switched from pointer null-checks to checking hw->mac_type =3D=3D e10=
00_ce4100
>   - Removed redundant check for hw->hw_addr since it cannot be NULL here
>   - Added missing Cc: stable tag and Closes tag
> v2:
>   - Expanded commit message to answer reviewer questions (reproduction de=
tails)
>   - Added appropriate Fixes tags
>   - Added Reviewed-by tag from Aleksandr Loktionov
>
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/=
ethernet/intel/e1000/e1000_main.c
> index d7f5c6f16142..156903089fa6 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1227,8 +1227,10 @@ static int e1000_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
>         kfree(adapter->rx_ring);
>  err_dma:
>  err_sw_init:
> -       iounmap(hw->ce4100_gbe_mdio_base_virt);
> -       iounmap(hw->hw_addr);
> +       if (hw->ce4100_gbe_mdio_base_virt)
> +               iounmap(hw->ce4100_gbe_mdio_base_virt);
> +       if (hw->hw_addr)
> +               iounmap(hw->hw_addr);
>  err_ioremap:
>         disable_dev =3D !test_and_set_bit(__E1000_DISABLED, &adapter->fla=
gs);
>         free_netdev(netdev);
> --
> 2.47.3
>
