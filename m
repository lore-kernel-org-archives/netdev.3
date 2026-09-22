Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83C39AD3B
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790086959; cv=pass; b=M8lvufa81pKkCeaW0htHgwYMgtcgYZc5vpe1+49PTwVkpH9U6/+NMAy73H23kT6rwZJISpMya9Mh1jy+0WBqHE2oZ+1ZazXcH3CtRYrhNzbs5rg8lH8SQdcA0h9zoBAWlQKcd201IRMoSRzZqurbyHCYflg1a1mCHNM4ae1Twuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790086959; c=relaxed/simple;
	bh=UfRh7sNseGJXTKsVsEpvuIA/dx++uiblm+pTJYzSZD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLGmxZk4W1jtkIOXEYfSe1GJyWRUVRzGNeFF7Izy4D1LcJIZQknTpO6VeI2o2nZCnoIhrwNV/BZzLAJf5/3iykN6GpWYHs39nAWUcWo5L9vWro8gqql8u/oRLgWHP9x4I5z1PWlcMdKr/xd7J21T34sNEAEyQZSxO0HtImcYH9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NQXAC5zz; arc=pass smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQXAC5zz"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-532db7db0c6so8322071cf.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:22:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790086957; cv=none;
        d=google.com; s=arc-20260327;
        b=gQFxXC84H8ueP+jUriX6cEmG7lAN8YdxQendo7bELh8IFwXEOvwdhmXzgGxy8Bh0H6
         KgosOEBL+02156T8lhkyLBpznJ+R3JIBhQd1soF1fZZaUQ27iYjT5QFaVSCmCo1miC/Z
         jz60Fb6ruqqVCaoyWwssJy3F0BGGYSnpWpP4SNV2RjtzA7rKbnqtB6iJNiRa+rRwO/i0
         k/WgSu3RRiBY36DZ4t3SNqzvggW+DHJwyRpqjop3DdSVCl6ocFS6HgVGwAvhY26Wv7Bs
         S83p5uB9E+FwxdkSWbUzrkiyd+OHuvkNs+Dd9KdaWMdFQ3c3S2ZK/6E/C30rGhC/5EBP
         rmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UfRh7sNseGJXTKsVsEpvuIA/dx++uiblm+pTJYzSZD0=;
        fh=TEEltYLN2K12JIBHDd2cNLnDERzcLMymK2cfXCIPBAA=;
        b=HZJsF5bAHh33yQqeFzF728O7TAFuceKCAgsFCfLuhqtzVVFpIgNKDD5WP/4x2+Oxug
         +5GG5Fp2JrGUgRAAwFDBIw6mJ/bmadQO4Mh0d9qQYIQQj48MPBmfLuNtEXyclvWZGIgr
         TGVMlF4dn3DdMyzZVfbWQnBkLbZvVs5oUlycrcouPRVPMIu7cL54jPdwBfbo1G0NGsOz
         GA3bvCFQGqeetYYOeHqaK8IsthEVtVP/U8CP3L/aczjywHp3WfuvMP8ZeMFBzOCJzUqU
         +rgeC4O04w9mrQiO5HCPdK18ltpdThtYlI+/8reshhDQGK+M16hh0pxDPTxc+IHyOQgN
         +Rsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790086957; x=1790691757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UfRh7sNseGJXTKsVsEpvuIA/dx++uiblm+pTJYzSZD0=;
        b=NQXAC5zzLsrSeo6GKczo2TATy4QZHz2Jpi54CVnMwc+Mn5hai3tsQOWqelaMNWSkBA
         DqZ+0VmqrMBo2sKc3ge3vDRoWACQp9jWubk3KnIIhs/wItFvxuX0/Ltw0VUeJasmrxU8
         lE4IaLQhXa3RQbcAH9ZHvqYfaYmwLbiRL+LKCg9OqN6hxulpHAPmBB15S3b4Te8EaUmC
         b1tcbxSLfVlALgFqQHew9RlUD20pZzOfdMNc6J7I7BNJkllg/dtWNxI5H6NIzDTROeav
         CdvOQf6m3BURhsaU4W31+Mtf2vKdmlQy3qUAPM7Lmn8x5ztLZokjbsw1IyaLO2yjUJZI
         WEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790086957; x=1790691757;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UfRh7sNseGJXTKsVsEpvuIA/dx++uiblm+pTJYzSZD0=;
        b=ZHA3+CYM+R8N0S2JiNHeDR00eEEZTxXfN6oUafrr+fGnZEglN7OKKc3Aq/cg0TzLeP
         uEPr9jMHcKCu30m6uI1VJlTanWT2HnyFeoGWPFZtcDXL0PMvXLyCm84AKw+Vo0+DVJqN
         RW8BLoTFx8KFeEmsSlqwMvBl5RZdTr7bsFopTzFJilb1XElYOgH5DKp1EkBxFVl9U7H5
         Ef6hotTEIZ/IQBLKEcWPX4XXTRG9qaX67Ss1PnkqX3NQ3ySR1qCGhCkssMyTzb8/OvFU
         +NPm/PrNkYBdC3dnunJ/N5m73H2/DO4PJqpDaxNd8BL319L3FRMZhnTG6E4BJFeHqUDZ
         EqnA==
X-Forwarded-Encrypted: i=1; AKwUvBzjqI6xgUgUP0d7bNq3c1txLtlPL/tgznl3oBE3BO73giZodqlnkIfHpe+eqXXg2zlUCvPgIjE=@vger.kernel.org
X-Gm-Message-State: AFuF++m5Dt7aZx140+qaqCKFgYNxlHQzOUgEPClQmGCaSTbTBr+9/W0A
	1HJrgQzUn3TSj6bjQXcdw/jnpOLD54oX2FlPW4rR+tGD4Bxe1sC7VvDDkeKwOXDUxPxDw45yAAt
	s9uZ+LbJuBweVz6Ge4RME9Ali2xWs3Mwm6j5Ey18Q
X-Gm-Gg: AYBFou1Yxqcn4QYiupW2B0oQOp0DVNQES/BhUpnyUXZDZyPohLjtt8TQzb5rXgpe9SN
	6Uk1yu9E1DaXquXZKZNRnlcsFXDjKrV1A6VkyNeozEfJ/GBIubtscl47s1DScBpzJFcL1C1bLgm
	mRNOgR3runK0b9KGa+2aqq1mgufGH8fhiRl9BWS5cIS/3zBvIhfCDaHaq8GMwmwOEWC8YiNtihg
	b68EfvEDePvELmAqi3q2uTDlpbf1PUpgO1n6qVOuBkZd7IkCCOaBzMYBWEMpkUn1NurRrVjr88f
	QSNTlDKqSCRrPyHOxw5xAemwu9O4i48Q5Kk4/y5K+eROwzkjfLbd5aAaNLWFZC/8ONIrwmEe/vO
	0egEXL6XC1W6ms2ZnQaknLalue2IULooWHJ68bOYgWpze6CENA4dpBo5d3O/SKWgu3TdH/j8OqV
	eHHhgj
X-Received: by 2002:a05:622a:4a8b:b0:532:9adc:63a0 with SMTP id
 d75a77b69052e-532d8e70eb5mr58677071cf.68.1790086956186; Tue, 22 Sep 2026
 07:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <729830b8.130.1a0c945579d.Coremail.18983559317@163.com>
In-Reply-To: <729830b8.130.1a0c945579d.Coremail.18983559317@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Sep 2026 16:22:24 +0200
X-Gm-Features: AcwNN1WlFAdwrvFcuaEYrLMwWoTh1QrUe7UwPBFveZTKSMv8vTEnEckZQgsXIv4
Message-ID: <CANn89iJ45jSsXMShe+9gYVSMLwpC15nmBROFkdNWVVR-ZyE5YA@mail.gmail.com>
Subject: Re: [PATCH net v2] net/mctp: publish the mctp_dev only after it is initialised
To: Binbin Deng <18983559317@163.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Binbin Deng <dengbinbin21@nudt.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:19=E2=80=AFPM Binbin Deng <18983559317@163.com> w=
rote:
>
> From: Binbin Deng <18983559317@163.com>
>
> mctp_add_dev() links the new mctp_dev into dev->mctp_ptr before mdev->dev
> is assigned, so a reader that picks the device up in that window
> dereferences a net_device pointer that is still NULL:
>
>

> Fix by publishing only once the object is fully initialised:
> __mctp_dev_get() runs under rcu_read_lock() only and hands
> this object to readers as soon as mctp_ptr is assigned, so
> they must never observe mdev->dev =3D=3D NULL.
>
> Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
> Signed-off-by: Binbin Deng <18983559317@163.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Please next time wait ~24 hours before sending a new version.

Details in Documentation/process/maintainer-netdev.rst
