Received: from mail-oi2-f41.google.com (mail-oi2-f41.google.com [74.125.231.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC5E23D28C
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901212; cv=pass; b=ccmiKWbDvsOVkiH1U7JKUe/QyKQF8EpIorGetKsLlcVggCG0HcMId9Gx11wJua8S+c9DhTRJm3vqs9Ko08LRegjq1PqDHFUQdfHkrhmGOI2Kj98ScSqZDLBmD4lHnyogLB54JGRFggJpKtDDuIGWO+AUFOmViHXXlHwUkW+95PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901212; c=relaxed/simple;
	bh=bYabJjtwOJnu9LtbmZmJTdXpdlbi97usRjh2CIJhQWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G58ePoXmjeKtMoTD4Cku5LQ5Z1Ll1KX3Cgb9nNBzKGXGiBmhGp/K/1JfGjjUa8O4Xw3APoiWMYYvu3GSUvmvSjM80G9kzo3PnraRbcYTlLlTjYJjb3Sz2khfFXrQ6/Pewo3kBdL5KyzhzzIT9ewb+hKGWTCuj0YchuFez2fWHNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7hwy1PT; arc=pass smtp.client-ip=74.125.231.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7hwy1PT"
Received: by mail-oi2-f41.google.com with SMTP id 5614622812f47-4f4a36e08f9so418528b6e.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 17:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790901209; cv=none;
        d=google.com; s=arc-20260327;
        b=dTFczE9jADhK2FChH9ybBQqSat8uqYmsMXq8L5U9B4/C8Kee4n1QKQTsql1CKirj3I
         ksLBo1VlRj8PuqI5sN0pB9Y9H0xEgq2NbyhQG4g+dlzAMDPDZEFGjgZTxZOw5T5d1s51
         rhtfdgkGxQLo8MH7yr/yF0rc8OUm3joGIflckAFXHw+gJmuB7Y06q4QLpbWpqOwXBKZW
         I+jew72Nt/FpR0vbq7OCk9pE8VU4cKxQoO/blLSTFMQmlkEYvkugI23kVArvlD+rVr13
         GHU6Dz4ewoZcOwmw4PRVykwu2IGgFUZdRke1jLO/8KQWIAVlXEuSgBrjA8XfEqnboARp
         uIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WWpsUMNlZs+RUsKVOAxmXszI92yXtYeCX1oLIS2CEuE=;
        fh=A+f1xXRvXwuPUx29oivAq9IcxMCSEbZL28nXoqnUCVw=;
        b=nROObbNPZsXDtIMSYN23GDdwUCLRtswrZsKtczIUAD4JLDlZaL21KthULPNeIWmPSK
         UkhPBkT2kYrxDeBs1GJM3a2H+pwsn6UGu+ILEgrJoqyiIa/Ny12R5tN0XoIguabE60C6
         3ABiFmifods/wxRGIdtBsxaQ5dGsDD9Dc8HP2227DrNyoo5Trxp4k8wreF9rYY0cI/uh
         h1rGkntsZHgSMOJnVe4u6FTbsCttXsW1ROGCuvX+E1GCyY8K7EbGLtsTztV9evn9cp91
         n/FHN9wTpAO1+gqgI0z614hWAxZZ5wDXWdhNL6WcMSFwF5q6fRwDT+q2nEc6h53jHaKk
         qo5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790901209; x=1791506009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WWpsUMNlZs+RUsKVOAxmXszI92yXtYeCX1oLIS2CEuE=;
        b=I7hwy1PTFCZGfomdWaVmcUB+e0eZhPnhxrHfCp7vJQ8tWpxRxbfbvs0wQTC00FXxG3
         VAt/KeCN+ovDKeNm3piqRPKcdmPSKQooZsm8kp3IeojSuMN14xhTqiuclp5TK4bWzoI6
         eOSFZBD+6y0IHNOAlqK9eyrDM0mzu6qNzLILKIiY9J4q+3IIy35+imxhIsZ1PXyJzH6E
         +kuaepQS2YvnU8pcdKTp1/KFT43NNwyU3d6K6zBPGflXYySXJ3+gOFlsacaU81NDDx1x
         VE2g8ODcKfSxwQOz7g2DrgZTqffX2TKwBv2b++UMOJk7npKEO5x4lz5HorffV/NJhK16
         IFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790901209; x=1791506009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWpsUMNlZs+RUsKVOAxmXszI92yXtYeCX1oLIS2CEuE=;
        b=US/rp3+zTMDEvrOqolf525pGHhQOTo36UZKV3My+q/xgYcaaFcAh0twOsX0OxmsXH/
         9li+G+HHUOFeXdVfiPe3NBxllkHtasnXuJYGn7Mhsm4sgfToy+0EILr2525xaOYQSuny
         LltTFuledteSZtHm+o8iSoIUtALRHaJzgzUH+mQME6PiHN3bj4uuNnwLzyDkVFcFcAWn
         +qoGp5ZMig/mbpI+hndbWgPUOk1RL5unEh7Lvl7+DisaP+ec2PAo8YaTptPoxlAXwJbu
         bYm6xhHH06zL7rfaLc+lus94xXcWH09FF5Wq4gKhfTrooz4Ul4x/pvW2XIkGfTFct4Ey
         GIoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhR2UB6A74fHFPqe43/6upOoBIsjgYvcTM9lplBIbetmmeN/EXVp8LLE+PfoTurrt+7soQPDc=@vger.kernel.org
X-Gm-Message-State: AFuF++keLmtX0I/z7vkVt0IPBfEpEQGrfMlUiARs1ItaQULKhsUTs+Xc
	TMcv35d1o3TM67B5Kx2iAAioQscJZQ1SlUI8ktQ+kId/JJHKhJliBXfhxUJKceeGgdbR6iNj2zO
	CggXYojFChV7mRio2vNykuxLy4HgnWTI=
X-Gm-Gg: AYBFou3AvqDdWGRoLwI66jwqNL1ezZS/efGBZBq9K0I21Q/Ss11GODj5ZtwiOFgsMPh
	2TY1QHypjGuGcBdE0SwRtTVSvisQvrGgjahx9UukF0TRLdqFIfnC81oxqY3zsu3i6hORc0joeB6
	cbq2lRZd5VpveZMBvqiHI5eNrTPIuZ57kPAdnQhE83h7xXh9JzaTBPvhRPWuLzhxHTmv6iLw5NO
	bbc7w2Zho8V9oc0nOqzQGsoxXSY6j37SQuGsCF/ZPv5nnjT+El/+91Pog2rqnj43gjfr+roBbnQ
	VF0hqP0dPfStnTlZAO3xx1rgqSQf+CrryHvPtEAQvGU1DgeA27Q787g7XZ3memCFaDqAac6Tw50
	DJbHjtoOkT2ywJA==
X-Received: by 2002:a05:6808:13c2:b0:4e7:86e1:7e25 with SMTP id
 5614622812f47-4f52b3b885dmr857032b6e.65.1790901209465; Thu, 01 Oct 2026
 17:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929025414.313641-1-kyle.switch@motor-comm.com> <20260929025414.313641-9-kyle.switch@motor-comm.com>
In-Reply-To: <20260929025414.313641-9-kyle.switch@motor-comm.com>
From: David Yang <mmyangfl@gmail.com>
Date: Fri, 2 Oct 2026 08:32:53 +0800
X-Gm-Features: AclHuK-S11c8PrkNEL_RkSTGvJlPdotZtVOzHYvX5zldJmk5ccsB7b8ftdaa-Kc
Message-ID: <CAAXyoMN8KsnY1RsR-YGd+mRs_R+QrzXMZVHxGavsRU8PCS05ig@mail.gmail.com>
Subject: Re: [PATCH net-next v10 7/7] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com, 
	jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 10:54=E2=80=AFAM Kyle Switch <kyle.switch@motor-com=
m.com> wrote:
> +static int
> +yt922x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
> +              phy_interface_t interface, int speed, int duplex,
> +              bool tx_pause, bool rx_pause)
> +{
> +       int ps =3D ethtool_speed_to_yt921x(speed);
> +       u32 mask;
> +       u32 ctrl;
> +       int res;
> +
> +       if (ps =3D=3D YT921X_SPEED_INVALID)
> +               return -EINVAL;
> +       ctrl |=3D ps;

../drivers/net/dsa/motorcomm/chip.c:4500:2: warning: variable 'ctrl'
is uninitialized when used here [-Wuninitialized]
 4500 |         ctrl |=3D ps;
      |         ^~~~
../drivers/net/dsa/motorcomm/chip.c:4495:10: note: initialize the
variable 'ctrl' to silence this warning
 4495 |         u32 ctrl;
      |                 ^
      |                  =3D 0
