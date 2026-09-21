Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325204B44BA
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004212; cv=pass; b=HDJFBuFa7dY0HpFsl2bODFyevQzTiXIla3dZ8E7zqePDA4Lm88g0aNGTCYZlYjyXzNcVaKE0kDu/w568jhdaYpL8UpE9wlXQMndnbLfvWVrJl7WrF/OHMIa1DFOLGqIPaoxSzETOka2IiwlgUQvkYjpYJqb311gPULTmnuyrYOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004212; c=relaxed/simple;
	bh=Qvro5yCQlNCOhITq/IgfziBeqn/uBwkhHPkGycI5TvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1Ix7rpkcFrW4/3E1OVKyXGfB70xwgq84USubEqhvsRpA12kmdHki0QRRwJWQbyiRT1diBKGRSnr1r8o27aX4abyFK3XmR1LHBvmcat/kBlJO2GdhztF1A4gXV0Ur267Vi3YABB8W1WTi5DqssLhhJwoeCULvLe4e2Q1d1OuBAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMIjwpvC; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMIjwpvC"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d90ba1d807so37885975ad.3
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 08:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790004210; cv=none;
        d=google.com; s=arc-20260327;
        b=lS2zzXhq9U39bXvuVUss46m/rKS4NsdY2H5o6lgBjKstpIvJOdcq94o5An0bIVWLaH
         apBUB/d8pBgJDeU+3JhiWnCnOAZufkA0f76fjOnN5092FJpFhvob41re3swQVfDoudXQ
         m/yzkY4kqtyoxqfPSVPcv3MjOs6lqCdWU1d4ozzd2IlT58jb8qK4pHu0m7a0vugRtHec
         P0eoDNYtIlOagd6Qy39CgV7C+Ql25PMpAOB4/t5HsCNmAg6AqwzPZ+VnsbokTPjiC/Yh
         IFirYLiNTgMS9IBTRFBX5v3wLtzM9ks0DhVG5UNv7X2lzinhIRiXOP+b7fnzFuudIEvY
         n5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=INq7XmDF4W6s4uqXjWWhutx+bhm3j3Ixyq53lQ+50kg=;
        fh=xFfEYSuxZwTva788t22Kgq0oK40s6ZoiHS44D8V4siI=;
        b=qIS7Be/JSHSVbNYUwAhPloXpYi3yEFkhMYziGi792RBkHDA0GkdCHei2eDROR8tbgQ
         vFhvpYbmtrOOkuIWAR7Aj93Yoyig0yVrCLTTd3gE8V2stkUc+vQRXfgTHSOjZt9QfZdF
         eYbSia6sLCmzw0sQF2FE0ILocDxh6rlmFU9sfDZZhHcbFG7Kmfj2Hs6x0qzRX0yxNPXA
         jpSHdD4JFJumKt80w14VpnqFFJskku9cJQtc0+w0DgJk1Jd4o/3sqIVDQAOErKMFVUlu
         v23to+jJzqQ4cIIrwEBNBICHuh69HpBGpuQbFPKAQ92XYrL6Do6IcX08LoYSegUiDvbb
         Wczw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790004210; x=1790609010; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=INq7XmDF4W6s4uqXjWWhutx+bhm3j3Ixyq53lQ+50kg=;
        b=RMIjwpvCSnEId6iLqqzpVweOuPEhmX1L+Tyr4Zz8O4OoKvZsfMUg9mCUiJbpa+uXBj
         N+gFFQ2TQIjV5LoHWXs+7fstuuvcCxCLBXFh7cnKrt5NfNsv3Ha4Fb8l5Id0PvqH/J4m
         ch761hTNk4r/QmVt+ht2v+JxUB3/GQftp52qqqMJnV+GyREll5VMIF+AMySfJuKaofbv
         NXQxD4VkvwCtzzUwCQoB0+In7Rhl8vJv9wKf85Lqash/c+SotgbIHx7KFaiIP9Ph8Jxv
         FrBPPYYNgsc4bVkj1pbGWtk2LzBoBd0B6xlMISvgZoq9NMcnR+FeTEbcHs6AG1rQROBv
         TXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790004210; x=1790609010;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=INq7XmDF4W6s4uqXjWWhutx+bhm3j3Ixyq53lQ+50kg=;
        b=Rq7dycK7NTaXH4ZBdvdQLD8f+9URfeqy0ULF4Eei5RC4GIzKZdBONrScPxoFiI0TY3
         Z32iMfYeF8VDkfpLr4Wjo+n29uXMsvtqSLF/VPrU2CP+uttvLIMVnszHgyf2lZ8pINPa
         AQ9hyjsV0Ym7bWpSW2730ErkzlNsgSVLAx5JVCx5DRHLdjdGp7P+o2ePTZwKtS0v+AUu
         ZKDHtqgVfMliGG6nzRsnhK9TkG4WhEjf4SU/B7fscLBJRf7n0CQ7lrEJtcuQyFZ4atHQ
         WnTavsB481PxyL6N+2wY1yiZU4GIIgrMVrsyQPReOUHGjv7hv+iumqOvuUUThBElp/b/
         7IGw==
X-Forwarded-Encrypted: i=1; AKwUvBzpsufWnWrZhzJ9rgnQnOLo0kS+Sy8DUtIsZyYzgQ5dZN/33kni7R3NBbzGhu154gZREBsOmzY=@vger.kernel.org
X-Gm-Message-State: AFuF++lRb5cm8NY79v/yGw0IEWvNaHKliVm3TrgYlYgf32ZfBjFDgqeW
	eICuMYceRGaMJ8WaybmBeZLu13z0TdeQYfa7AUX2gRKMXEno8tQadNqlrDgru7/6ClGabIiMYmT
	wTPjX5ynuVblDonUoc06uQ8p89+sz3Xg=
X-Gm-Gg: AYBFou0CberDJJS+xlbGJi1jIHNGKHdR1P6NeT4Pgw/onD6rVyRZKqTcPYN8rGOVCfs
	pQszZnnA45T4sZ+KbwIO9osYbKlKq89R2OLf2UY/AUXJR2uhNw9QB+Rcav1mDGsmbCrYN4Mo8rG
	Dz+KlU1WO2liHWjZms5p5DitjklkRoZigNnfjROt2qI0LCRUjXwtdNsXO09Try+1/y6ZR7JRJzT
	y3Mt92HEvIILWzIf+nmmQeDyAgB5r/0fmU8AH6rSfp9lVNoS7FFwno9D0NS3Dg4UTZncT8ZyCMd
	Zv1K1VS8jtbvUPX3fD4PS3Bt3PkC5krM/A2yasnCvQgpj+Zb8VTDgpptew==
X-Received: by 2002:a17:90a:d445:b0:3a0:2817:1fcf with SMTP id
 98e67ed59e1d1-3a0281720f7mr8496428a91.11.1790004210586; Mon, 21 Sep 2026
 08:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916022954.2690322-1-lgs201920130244@gmail.com> <178953744017.13037.8123570146284827976.b4-review@b4>
In-Reply-To: <178953744017.13037.8123570146284827976.b4-review@b4>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 23:23:16 +0800
X-Gm-Features: AcwNN1VTUBM-S9HR0eeeidh2kablCG-BVFJX7Z6YN2-YKoW6ujal7wVJmjF5B58
Message-ID: <CANUHTR_pjrYXHkMZH_QheAUr86=dJ4WFC+DNMgzUYsm+MsEXPg@mail.gmail.com>
Subject: Re: [PATCH] net: ena: fix PHC cleanup on probe failure
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: David Arinzon <darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sang-Heon Jeon <ekffu200098@gmail.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Dawei Feng <dawei.feng@seu.edu.cn>, Amit Bernstein <amitbern@amazon.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arthur,

Thanks for the review.

On Wed, 16 Sept 2026 at 13:44, Arthur Kiyanovski <akiyano@amazon.com> wrote:
>
> On Wed, 16 Sep 2026 10:29:54 +0800, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > index ea89619039d8..5f0864d16dd3 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > @@ -4122,6 +4122,7 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> >  err_device_destroy:
> >       ena_com_delete_host_info(ena_dev);
> >       ena_com_admin_destroy(ena_dev);
> > +     ena_phc_destroy(adapter);
> >  ena_devlink_destroy:
> >       ena_devlink_free(devlink);
> >  err_metrics_destroy:
>
> Thank you for the patch.
> It looks correct.
>
> Please resend this together with "net: ena: fix MMIO read buffer leak on
> probe failure" as one two-patch series - both insert a line into the same
> hunk, so they conflict with each other.
>
> --
> Arthur Kiyanovski <akiyano@amazon.com>

Sure, I'll resend both fixes as a two-patch series, with the PHC cleanup
as 1/2 and the MMIO read buffer cleanup as 2/2.

Thanks,
Guangshuo
