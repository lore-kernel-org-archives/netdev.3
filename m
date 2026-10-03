Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E03FA5FA
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791021380; cv=none; b=c7cxW3S6StLkHCQP1+HikDHPKeDkeg7HGSw7H6ChgEVA6grPtr/J3JSstipIIyudffuHWpWYnua+CPW0jOIZBc9lFa03x7h0OxC0bc90kkYFKgZCozWETE/rU4fw0E3A4COxnsAZjNUSK7jbSpCGz4a+2u4QWH4Fm82OtcPujdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791021380; c=relaxed/simple;
	bh=yoxZ8bT/2tnoW+aoZPk3W+kJx2jfdtxBJMrb8XM8I9A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GEHG8UyGfVkGM4PhBatqvGx8eeMe6iuxKse27XE92uDHqC+/gWB0RS+MFWunihaR2d4eeqmunYedxzU2qFHO+yzy8qq1Vvi+MWPKRQjl2ahgXRhxbQ254grX8cKLXLA/0cA4ISq2n3C/mxl2tJVBDVi6fEthDRBYVsD4Jiz9Zt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ooi0/ZCi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yfl8fz3r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ooi0/ZCi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yfl8fz3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791021378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i118fgept/V5HNHIJAC4nRHOFN2iHEPIInJ6/LxCKAc=;
	b=Ooi0/ZCiFC2wP2moyqmETTm+CALGbv/CPhFEwL9qGhAlwgSyRwdXCVqBX25rl5bwdbuUeX
	EVcv25syOKTn28C13lE8aH+kTpZyHIxIVaPzd8TVLGJfDt92AEsDaK+mKs2N6Gh9XXny9/
	ejibjwFp3PaeVB7/TmljiZW1KfFdtt8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-VX06OVy2Mb2vm-SjqiHSmA-1; Sat, 03 Oct 2026 05:56:16 -0400
X-MC-Unique: VX06OVy2Mb2vm-SjqiHSmA-1
X-Mimecast-MFC-AGG-ID: VX06OVy2Mb2vm-SjqiHSmA_1791021376
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a01d1fb07bso4587405e9.2
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791021376; x=1791626176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=i118fgept/V5HNHIJAC4nRHOFN2iHEPIInJ6/LxCKAc=;
        b=Yfl8fz3rAreF7c+1ltgHTRz5XKmdvuNVMpBLRl3eld+vG831+ZJR1p8+RchwLo5WvA
         cO4349w6TXrGQQ5NN68ElD8VB16O05noOx3oWLYrHJiLFVefach+QE3VN7/jNcqQwcGD
         JB24Jx2a4RXrneXVMRpEs+v7PsCv+h4SpjoHoOgEV31iEVWbcNtTy+sil3aGQe2MyMyZ
         JNtkBl8zBQWHaEN4Swvp8hYrDSvKDoqwE9N4fRZYEXv5bOXzXcnVa3xJ6fxnN9D6FiVI
         WCJpg1ulrpiXgH1Wgi0jjxZAkX503yQlegJJ+uMIdz0htf36q4z61kkivlIfmZ/rcgAG
         /slA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791021376; x=1791626176;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i118fgept/V5HNHIJAC4nRHOFN2iHEPIInJ6/LxCKAc=;
        b=WQdA4d9+pntP47YHZI74peuDCEoElDsVIwDq59A23HNUlGNZUJ0VxeoO3wmV2c9PDu
         3+SSRgAmvVTlpoNiIFBcMlm2CVe1MYaVAPgQPnrn1i5pDf+GAKU0cLD+5mazcVYe6rXm
         6Ybd50e+jIurV0vXCzv68ui/zD0m35NGbTu8x12/OyZMS0LmHCKBZo1P5jE3JHaqQhAY
         VRLl3Cw/mqWmtLLwrQQphHr4wp9IH9b8CTLEi8DFEFzZKYiwC7ws48IBT+6qWuuWgMyO
         Gnx8e6cWfrZoz2RbxodW9g5MaWAbyQ39SEiDjAIPvHWvoFxyNXhHNZ6YymqKrJESvqAd
         ZfxQ==
X-Forwarded-Encrypted: i=1; AKwUvBx0CNxfH0PQhIwt7W90im3x6XkarCFcV+azXTRbm24nap3jGfJZnVRC6wkleeeJgoOMk0HaHs8=@vger.kernel.org
X-Gm-Message-State: AFuF++kAO066OkPtPvB9vfdSYgoBi5eFpnDi1toW3wC9+2G8eJ5DZwNs
	Zi5lkcSSeM6QT3X0TGYNM8yUeyTDqQGU+mR3qdN2ucyqhr5MHxUl6ApW/wzh7J4Mr6pLeccsbXD
	LvjLV18UuWOqk4wFzsyU986e7cbJrl+TQ5XoOI2Q3hCj9JNM6OLhildhhggjON6rvhB5k
X-Gm-Gg: AYBFou2pGPOaKWHVrAOn7ynB6TMumJcn1LabLHQnxqiJMZZVGV/JLxa7RifkzYeFk14
	yTiE08ZdV5T+BInV8lmOvDTU9VG7t4FuJHI0618yuJabKYt6LRUtYnMlPhG019MhjOjSycyie4J
	vdMx0ctjfE2ZpQ+e41DdDS2fjHVwjQuJN+d2V6uwh15D4Z75j5ml8pog6cO7CnFpxoZaLY0f+eo
	yr+FV5KRrkIqeDkRjSNErHLGjkKP9IySOKiuvWP1rDVJExtnR46xbByU8UH+y3SzGz6FzCuAHp4
	3GJwVuv84GPaD67t3PvUJgdgx8bDOqEs+kyFjxnMLz7khIKM0HoOJgm+gXIDzDl+OaQ5XK454xB
	iuWMAlWk9xif4yWVxpk/XKvPGjvY3Pv+WnllR6YU=
X-Received: by 2002:a05:600c:b90:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a1680b5402mr30627945e9.2.1791021375675;
        Sat, 03 Oct 2026 02:56:15 -0700 (PDT)
X-Received: by 2002:a05:600c:b90:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a1680b5402mr30627735e9.2.1791021375223;
        Sat, 03 Oct 2026 02:56:15 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm121786205e9.2.2026.10.03.02.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2026 02:56:14 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:56:12 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_09/10=5D_ice=3A_program_multica?=
 =?US-ASCII?Q?st_magic_wake_before_tearing_down_the_main_VSI?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-10-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com> <20261002130752.2597259-10-poros@redhat.com>
Message-ID: <5BEDFB6E-4B19-47EA-9CB8-893CCF103D49@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 2, 2026 3:07:51 PM GMT+02:00, Petr Oros <poros@redhat=2Ecom> wro=
te:
>Since commit 5b246e533d01 ("ice: split probe into smaller functions")
>ice_remove() calls ice_setup_mc_magic_wake() after ice_deinit(), which
>frees pf->vsi=2E ice_get_main_vsi() then returns NULL and the function
>returns before it sends the Manage MAC Write command, so multicast magic
>packet wake and keeping a locally administered address across the PF
>reset are never set up on shutdown with WoL enabled=2E
>
>Program it before the netdev and the VSIs are torn down, as it was done
>before that commit, so the current netdev address is used again=2E
>
>i40e had a similar problem, where the multicast magic wake setup ran
>after the admin queue had already been shut down, and fixed it in
>commit e661414c98df ("i40e: Remove duplicated prepare call in
>i40e_shutdown")=2E
>
>Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat=2Ecom>
>---
> drivers/net/ethernet/intel/ice/ice_main=2Ec | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main=2Ec b/drivers/net/et=
hernet/intel/ice/ice_main=2Ec
>index ceb9fec2af21e7=2E=2Ea885b3e0baaa5d 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main=2Ec
>+++ b/drivers/net/ethernet/intel/ice/ice_main=2Ec
>@@ -5456,6 +5456,8 @@ static void ice_remove(struct pci_dev *pdev)
> 	if (!ice_is_safe_mode(pf))
> 		ice_remove_arfs(pf);
>=20
>+	ice_setup_mc_magic_wake(pf);
>+
> 	devl_lock(priv_to_devlink(pf));
> 	ice_dealloc_all_dynamic_ports(pf);
> 	ice_deinit_devlink(pf);
>@@ -5466,7 +5468,6 @@ static void ice_remove(struct pci_dev *pdev)
> 	ice_deinit(pf);
> 	ice_vsi_release_all(pf);
>=20
>-	ice_setup_mc_magic_wake(pf);
> 	ice_set_wake(pf);
>=20
> 	ice_adapter_put(pdev);

Reviewed-by: Ivan Vecera <ivecera@redhat=2Ecom>

