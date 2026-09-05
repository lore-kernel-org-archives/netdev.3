Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0038237B
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788581383; cv=pass; b=ZQ5OPqDOeZFSoiMwrrfznYCJUsUGo76tOdEJFX3N8JF+8wSHyQ15v4upsd5m/m7+cmyMHuykYSnF7dFumMr/mbru6SwDvurif45VeNK4rikG9Zuy9PTAxqmNXn3IyVXtdWYBZLaZMlzxRd72lbMigvJVftqP5lohib0vum3Tkkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788581383; c=relaxed/simple;
	bh=QWn6X1YFiIQ4R3Q6NjaIeDPlwfd6j3PDWtBvbTjR0VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU6kzajfxyjlqO00zJ7d4EA2ZBfgDWW4Q4TI0gp8LjXoYl0gjG2+ZSDTi5/4B9rE8nYQSBa9ymDbTJrft6x9YARg1RnNwwNa0VSHfzlbuB4hdlMFsVXR7nqKfLOyKJJXMqwqatJA832XysQNcOdndDPwI/4HigK2kYobmq5hXQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1R9vjP0; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1R9vjP0"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-39647184c73so2733898a91.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 21:09:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788581381; cv=none;
        d=google.com; s=arc-20260327;
        b=kF9J6F6X+B1Paw33x6xyba92d2sfpQg6qwnACy/FjpTRPy5CpBopxqzzb9f+v3kg1e
         4SZ9qtQiyl/PszVBo+qcv3BronCQ08Y5wV5LsPPzSvJIFE/Y8/GgvJ9dGR0ssrcjfbu3
         Q3GdEWUeMBk0ZFxuXeaJeGb4QRGsOOpW2h86SZgxVpw+nL+xKfGciQzHzETiJ18Y4dTv
         jngNvkA9Gs+oaLFBDj7KDFBS9f/z59jzGsvPPmgWOk2m/18R3MGj1SDuHVFeVjmqWbty
         qBHDfVImbGgFNf6y3CJQFd7HxPDsNLxTqS7HEAwy714vAAl3+oau9VvS1Rrc2dzYDKKG
         nfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QWn6X1YFiIQ4R3Q6NjaIeDPlwfd6j3PDWtBvbTjR0VY=;
        fh=O2M6SO4uXEH6rac6dhKM4Ig5an2+iXc4E45U70d6zW8=;
        b=F0KRIfxqxT3DsTvDqZBfH91XQZ+6ZFPue0+5OiGsrLltRVxO97hLffsuaTcKGnDi4B
         NheItqnUuhOB/G/5dQVoCeLNM5gnv9MfT8DdOhswv47Jfznx4T/Rp9BO9F1MkgaBpe6y
         Pfy7aUdHF7OwWcVbbh686LJKq38gli7hbASN9zrAot1pu3Td2oqkUI0Q1asENirgUxo+
         3YCu+vXOYO9/Gfq4HcVmkinUGFCMOsmh+cEz7Il2nWxlAzPJLYjIXi/eNAaMiky3DuWH
         UrHn53qSkZpZ1QIc6Dxm2W9fvdz7gCJG07yldKcUgg4H8xbdHk6o3B6oxvyAR5t/KCEm
         K1dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788581381; x=1789186181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QWn6X1YFiIQ4R3Q6NjaIeDPlwfd6j3PDWtBvbTjR0VY=;
        b=c1R9vjP0BfZtLQvC9S0geAMzp1hf1v1yRo8ffdaF6ZSGtMHnP90qSNJXkoISTEG0Va
         ztIBAqvdHt/G4D6b1F8f3EsU3XK6VwRHD9OatZ+RTTcp5Q4PMd4mV6Wo52v5FVWAayjA
         blgjWvDyF/Xj+RW2RP/dVaaDGuzYUf9tujEWV7euBTp3tEoSCBdxfxpLTOU9Bypc7M3d
         RM+X+w2GGnAuTcZFoYy21MAZQqIY6xTcVRodxVqYIvx9wFpDSTUWbZb6PgZfNTW8flnN
         6dT6gLiwTAkBUAuOwkIm1aNLaQKEam6B23DVWMa7pt0BZqWLKf8Yu61aTAEOyqGFkDBF
         l/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788581381; x=1789186181;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QWn6X1YFiIQ4R3Q6NjaIeDPlwfd6j3PDWtBvbTjR0VY=;
        b=djtRlbdpvkTG/dLtKkk+azadt63npcioXgdaQVJav9E6u9wor2iRxCjHqy1X+sUkot
         miS5zz3Iq4VGfKWD9dZ8FXOe6FbHf1IBfUdU9je5hCt5Wra3gPscMwefrfhErcd5V6If
         6itNmAN3mYDJFlB9UkmU+v+35RzLFdhp3yim0HtDZOI++uWCXFeFpJZIy2OjWfDj7nmZ
         eDvCDxgJNcRZbThFx/dsgF1lxc8eIK4j//BMC3IertAVCH9e8iZibs3ENHTi86xJCrFS
         +S/+tOdTDcn0bgWepaD2wBVE9BPREVYSbFZDUphrcJOsuOrc3pCteXREqivyKGCbnPco
         bWJg==
X-Forwarded-Encrypted: i=1; AKwUvBwWm7DdvQVL6lVqG6kNlxBYPxyFiIBm3OR8DHWKlDH9zNRF9dntUFnSqUp5LN/djf10vCJVpao=@vger.kernel.org
X-Gm-Message-State: AFuF++lMQLVb7IsH3Zk3qRb63s7dqmbIEOxEE34qyGC5tDbIO9L899FU
	LmxFv2BN9JVTkgF4PwjnV1Acc+nUDojshzFkqSpRVa3FZm64IpsQkPQS4wzX81f6OCyn0dZP4T7
	59/5TTXYHun9RMNu2Lz1RJW5b508YSXhxnEj1yjF2
X-Gm-Gg: AYBFou04Ti+pF7oFAzjnrTxx60DLAaGLjleVT6SLMb1jkiYtIifSSKSErPQG0A5FWST
	BMaoaVz+OSidxlnzyz+H3J6+ecBX+Oi7SqNzr4T69ueEQcyBYbi89rb4XbC3euh6Kr68TjdTiDL
	EK2n6Vgcdcf4NGMyqTCf1jdeRXdphv/5Eg09Gb1m+E9leDR2aRUWxv5Wzh88K3kZpLNlUPFgbO/
	xD2DrxsNpCL4kCX9+9CdhwefpV9YL+iQT0ScbynNZasewJaZDI8XokSb755JP2IT8s4P7n3B4p0
	Qze/3dVjEEhEPKuetsZAal55HgO/nDatS9cTzceR4Pow6xHvvowODQ6QpeRcE6FsH1plIpccbNJ
	v01zAxeEaHNxwqgmbv12rERVVy5OYSj723BL9aoHtegstOCH4uk2pKsBC+G2oZgc8MuQ1r+/A/o
	ANmxyiwUMvSlo4
X-Received: by 2002:a17:90b:4988:b0:398:ceed:b903 with SMTP id
 98e67ed59e1d1-39b080364famr19930154a91.11.1788581380572; Fri, 04 Sep 2026
 21:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903120840.1024153-1-edumazet@google.com> <20260903120840.1024153-5-edumazet@google.com>
In-Reply-To: <20260903120840.1024153-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 4 Sep 2026 21:09:28 -0700
X-Gm-Features: AcwNN1VBEcheMG4yns8O8V9CzcJDuXNMcXWUoJcSIOg7hNEwFdEsDfUkDiZVAjc
Message-ID: <CAAVpQUDfVS_S4j=zie6cf0gziNoGsQ1A+g8i4G1kB2deARmPfg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/9] vxlan: pass vxlan_config pointer to helper functions
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:08=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> In preparation for converting vxlan->cfg to an RCU-protected pointer,
> refactor internal helper functions in the RX, TX, MDB, and VNIFILTER
> paths to accept a pointer to struct vxlan_config (or pass flags/
> saddr_family where appropriate) rather than directly accessing
> vxlan->cfg.
>
> No functional changes.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
