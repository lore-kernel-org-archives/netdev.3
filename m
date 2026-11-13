Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589210;
	b=pk2Dz3JNI15mfgoYtgkGwJ9FzreVjQMtGTFYwhW7wcyvmCzHpqOSfdeKfrBkQQnYooK1
	 Iqj13PLFVl0y9uvwhNFEuJZosolYot8QlBY1OeIep0RlHZB1ZNWrhEKK9TNewKAkNpfQr
	 sbDfFdcsWf7QXE0e/bA/s3JYMen4ecge4vdHvTxh9E2kXr411JPIGlxKtrAWwAzoHLjcz
	 BlQMepoz3zUnu581iJ/sVoBMhw+l0wq2oF1NO4b6rkfj3tjaWgBnPg5Yumbq3d547Cwl7
	 0py+P8A2meZfFcRzihoXdDArbp+nNaQfj4ljoU2IUYP2INsU5dLLN2KYB6uRmQy0fSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UHCYxYd5XK4zwFxBPXElPTHuvK0+v9+ml9Xij7/pCH4=;
	b=JhnJyz+rCKMR5eyci5mDB6rXmTtsb9aCe3+09Nlghj+FTys6W+y+5j7WfhjWxhp0vaVi
	 yYwYMEyd5to/bH8wXImrkTmE1+TthOXYdqSEh/fP3u6FoXcdDpnTeDerLA2f1H6LwMCJN
	 1/+tSoSB3aEu2Tr5j/d483HMV8zg7xVsvSPymHVnVf2sQaGhuXZ6TjnWJ+ApIBvbsygAM
	 U31Gj/HgFoZQ3+86q029dT148qG4JWrIC9vKTXRFGHw10S9Bg1Z98uQ1JFV4tWGl/XsBL
	 xe+uHALKo9Zy6NLEOsGiOYc/p/p8iPXh4nZoWC19FVu/doThN9/HBSEOAGfPADBXR6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LchjyZso;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE560A2619
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58AE560A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LchjyZso
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-97ccbba8e86so330556241.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794589209; cv=none;
        d=google.com; s=arc-20260327;
        b=j+0utQ3+orM01ymW/F3a0psnvt6XA2l5SOReL40BuJe6edkN7Snro0irxU8gVpN3ic
         BKdmTWHXEf+FLSxatZMPdpCK/fJqwEjbPqpftC4nJEgsmmTyfgqZZcUsKA70ZKqL3VhX
         5fTiv0qTRbIVgs+jOEMvVXCaS0FMOK6UmbGELR0xUSomowA2mpOkKB9YG2j5LjrMv6BX
         nSMF0FUusOtCWXfNFnscme6CgCsx+CJorvaxEGMv+T+8AhT0Trj66JASwoMdbll6j5I2
         dEJBxOsgJ4aZWEmoJedavYkaRdltOp46a/j/s55X0Mq3T/iI6KseFMIvaGEA5EKaBE4L
         h5Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UHCYxYd5XK4zwFxBPXElPTHuvK0+v9+ml9Xij7/pCH4=;
        fh=OUF3QgKwWrxysT20kaYsngl+Jsi6q4sigW+fwbYjJRE=;
        b=G1WP28wt5X7w5Ly3MudhTp5j1fEDrHHsI3OiPfXLLzE/zX02BBPssEjKC0z0SRMonD
         QgahPrUK6U8v2e1/41lqlNsK/7Y8uEH0tVrdfddLa6osD6SELsTMgqt4K/PlkCXWWN3b
         CvmWfob9rBxSq3aq80BLb0qmVOQIudYeh7JLmIQHr+9Y+8i1+Qrk9ri52pZjp2IYg2mk
         GKuz+Gj8/oyca4BC/QrXBq6SrcoofvlsvznL3I8wpkBkY2RZn6oOY5ceHR0mSkLesMTs
         BxNWk19pZP26JsFi5fcIaoJPzS/357CqIlSVHvYAiOqMb6YUIiUAs8VgPsD9MzCVmhaC
         j6TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794589209; x=1795194009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UHCYxYd5XK4zwFxBPXElPTHuvK0+v9+ml9Xij7/pCH4=;
        b=LchjyZso169605P1QIIak18hEtfTovA++tCZlMIcI1c8zfYVIwPE0Q0jhr/6Uxe7Gc
         s6CpIuJsi9aNrxrKZh5k9jYCrOC/nZtJxM6KpAiJl+xyCWVMqcfImMIXo7XGzYOub2+U
         gNL/+lIUxWlS/otfV1FOL/VtpdWPITu2ji6m//8XxziaT3swyXDf0OBhd7CTTreNTRxZ
         2xk6b/U+HTBz1h7IvwZvEe8W5X8dqhS2TNlSc2FJa9AM9bGcZAl6vcC5nePg4shCWo2K
         X19dFX9+pi/kByWp0Kh2bpkTPz/OT5r4NJT60sWZeMyNEySwOtECgeh+HAssdU6ojbpF
         04HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589209; x=1795194009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UHCYxYd5XK4zwFxBPXElPTHuvK0+v9+ml9Xij7/pCH4=;
        b=qCXv7vdAeleUjPoM88YVDGrJoEKaEo17JNmZxIL/j3lMLw3WSYhlc0GnFvX/mQ4dN3
         L9SpBQD3R4CQwDT5j0FJlVOXs9t0Z9jj88vVhAghH3XAPjIsmBuB5d8bD4I7Hd+0dBbg
         yr4BOvBS+qHY4ta7ORJQYHJI9Hu/QJHB98Nhvxol3GAlmh+LcIq+YTTBBeOIO2N6LJH/
         ayZtn+LsAMu96uoxNOQzBI6mUhm+/7T2Uyd2RvlaF5J7DUBD0mPnJNRTS+GL2pbfGNUj
         jhAkyXsacNYjq12cJ/E0/bg8i44VtZkMilBl6UjzeXfYQA1BDTPormWc5g2019Un7aTc
         3JtQ==
X-Forwarded-Encrypted: i=1; AL+hErEDKRJKSxu6+T0WKMuHvnKLWkLmdDNbqJqhINfnzfp30tChV+wuFe/6Zged33MIAG6DcgPA8so=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+L0u3WereVdK2/C/I2E4zx27kT+lAML+jyUaJunme5qO9eoqH
	5wYf3sA/v96QDMfkiKe/E9IXuB9psGwclCnXedYY/i/b9FmDwPyay2uSvYiJEhPQT6ED4pYFyWt
	JYOTz6wuQ4d8xrvy2+FjTnjCEpOrbimVzmKwUlu1u
X-Gm-Gg: AYBFou0GTW0NiV226lMcCHId11ByJReEREEAGZPimhjEQ/0lrQlWXOh6Z8eBqOpu6WZ
	Lg1LVz2djwWE+WW25+NHXwspNt0IpNZImFog4nd/uACvwQKCR1F5zdPyGrzFGo6mF/h4OG+EKJ5
	pYKhgbsDJwVawj7kR8skdqM+l4Zn0ZPf93JTy9jXW19Xr+grs1FFn/Pq2E686Q6NVhzj+mn0Rmd
	tyGVXlHUoMZTJgTPq1+DVwpbmXkWu7MJPAYBNGZZzts4/+sBX6+Bya3GEFBGo3AIfZAbLkfLvNx
	hCktJjSGDWeZty4h/BIWUUH0SzNNRbikLCCMI7k42R8ioEMZBGgMdrtHxO4GaeXSGTUV6cIh7UP
	Yd9FvuxG8UZPnZVc2ylM1JxyNood2xdTlKBiS
X-Received: by 2002:a05:6102:6054:b0:7c8:1fd5:82b5 with SMTP id
 ada2fe7eead31-7d64d760b84mr707578137.14.1794589208188; Fri, 13 Nov 2026
 09:00:08 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112011108.1524624-1-sgzhang@google.com>
In-Reply-To: <20261112011108.1524624-1-sgzhang@google.com>
From: Brian Vazquez <brianvv@google.com>
Date: Fri, 13 Nov 2026 11:59:55 -0500
X-Gm-Features: AclHuK_36w4X0Vb1j6PMfyNVfQLXnMNvnnYRJqgmsyGgLC4L1v_Ze30b5mGksjY
Message-ID: <CAMzD94T95F96c0oq+4POQsMHfkWOWjODNK_n27Xw6BsdaGExog@mail.gmail.com>
Subject: Re: [PATCH iwl-net] idpf: preserve tcp-data-split setting across hard resets
To: Ray Zhang <sgzhang@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, intel-wired-lan@lists.osuosl.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michal Kubiak <michal.kubiak@intel.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	David Decotigny <decot@google.com>, Li Li <boolli@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the patch Ray,

Since header-split is on by default on this device, and vport_config
is allocated zeroed, what about fliping the the user_flag meaning?

  __IDPF_USER_FLAG_HSPLIT -> __IDPF_USER_FLAG_HSPLIT_DIS

If we do that then config starts with the right value on the
user_config, if it's flipped user_config is already persistent acrros
hard resets.  And then we can just delete the call
idpf_vport_set_hsplit(vport, ETHTOOL_TCP_DATA_SPLIT_ENABLED) from
idpf_vport_init and do not worry about where it should be.

On Wed, Nov 11, 2026 at 8:11=E2=80=AFPM Ray Zhang <sgzhang@google.com> wrot=
e:
>
> idpf_vport_init() runs on both initial probe and hard reset, and
> unconditionally calls idpf_vport_set_hsplit() with
> ETHTOOL_TCP_DATA_SPLIT_ENABLED. If a user disabled header split via
> 'ethtool -G <dev> tcp-data-split off', a subsequent hard reset sets
> __IDPF_USER_FLAG_HSPLIT again and silently re-enables header split.
>
> Move the default idpf_vport_set_hsplit() call to idpf_cfg_netdev(),
> which runs after idpf_vport_init() sets rxq_model and returns early on
> hard reset when IDPF_VPORT_REG_NETDEV is already set.
>
> Found by code inspection. Reproduced and verified on an Intel IPU PF
> (8086:1452) by disabling tcp-data-split via ethtool and triggering a
> function reset from a test module via idpf_idc_request_reset(): before
> this change tcp-data-split reverted to 'on' after reset, and with this
> change it stays 'off' (with rx-hsplit remaining 0).
>
> Fixes: 9b1aa3ef2328 ("idpf: add get/set for Ethtool's header split ringpa=
ram")
> Signed-off-by: Ray Zhang <sgzhang@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c      | 1 +
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index cd1b173e3b27..db6603711be4 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -945,6 +945,7 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
>         netdev->vlan_features |=3D netdev->features | other_offloads;
>         netdev->hw_enc_features |=3D dflt_features | other_offloads;
>         idpf_xdp_set_features(vport);
> +       idpf_vport_set_hsplit(vport, ETHTOOL_TCP_DATA_SPLIT_ENABLED);
>
>         idpf_set_ethtool_ops(netdev);
>         netif_set_affinity_auto(netdev);
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index 928de868fa62..fc56437b01ab 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3381,8 +3381,6 @@ int idpf_vport_init(struct idpf_vport *vport, struc=
t idpf_vport_max_q *max_q)
>         memcpy(vport->rx_itr_profile, rx_itr, IDPF_DIM_PROFILE_SLOTS);
>         memcpy(vport->tx_itr_profile, tx_itr, IDPF_DIM_PROFILE_SLOTS);
>
> -       idpf_vport_set_hsplit(vport, ETHTOOL_TCP_DATA_SPLIT_ENABLED);
> -
>         idpf_vport_init_num_qs(vport, vport_msg, rsrc);
>         idpf_vport_calc_num_q_desc(vport, rsrc);
>         idpf_vport_calc_num_q_groups(rsrc);
> --
> 2.56.0.611.g1030f0b940-goog
>
