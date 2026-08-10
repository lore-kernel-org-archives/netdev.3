Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23A430CE6
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381108; cv=pass; b=f8aA5hP2Ibmr5nSGCT3ctgIM0RpWf5igV+ZmhQ4trRfKBk/vghewnPnyvgFT8V1dlwxEQHVaQKZLYu3nxCdE93jH7dmuXyiMVq6G7hlqO6qRV6eK0irNBGE6hEMvyn1qXI4EmlGHO3/vqtWFDtYSb+eieU5uxrzP1JfLErcb5Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381108; c=relaxed/simple;
	bh=zpul/+dQSEfUwq4qJmXTVE/JC256xxMwGMA/9vorZV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rxy+2v4AWvXLr0e4bCOPZ65NLHKSzhmz+XyyL97ZV6jLOS0QiT9sIjVBWeNl+JGiC84ehMwCMGw61XT8SfdyG+vwY3X5IFNvIZ81eS7w9GyaTvFns5x5HKDf9UniPrSr9XKHtHWTjGgGAiF37HO0+eKXr8aKNytbQ4fPi405dq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggSIg+pM; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggSIg+pM"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4996e2575dbso745e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 09:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786381105; cv=none;
        d=google.com; s=arc-20260327;
        b=qjc1vCA/nKORZqB282q8NQOCrxYTQcaUkvaI/CWo6qgu01h6PLJVZKuQk0Y29GAD+g
         KI70mS1EbvexJsaGTMDY0jjTrrHaY7V5yASab+OThZc/FHveRqTIB90Bl4tz2Ps7+xVS
         J6LP2GGAlUfaGRWhj2veitKniZWyDjTJ6r3cydBWrzlFOTG7vuI+CCSfRn/c7f0dVP7G
         5WZj3m/AGGDumoWq6J8+6eoh82g708GI/OMNQUAMMDA0PTcONmbl6EWuTznvYI82y9YP
         2hEeiOyvuNd8YqeUU/puEjzc0ocGPUWcaOzJZDuNbGbLa7RKn3VKfAN2snCCpx0pthhV
         4r1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zpul/+dQSEfUwq4qJmXTVE/JC256xxMwGMA/9vorZV0=;
        fh=tavjGFSBkcmLT4ZBv5pVHSbWxtUlaYh3Awt8h6tEALk=;
        b=ZvzUsksjcNkFonp0DimnoZPzsqyyZdcFjQCEsBWWaE4mkspijH9El7W3MurWDTd6Jd
         CdFSNHK92fHW5hjLj9jjx5XY3G7p9ysxu/mp8NTKgywv1palcHK+O+p4KbRmv1mZie4m
         GUHDziWkdg/PxDIlQq77tlzpYQO3jKLVQW01Bfh/+IOSBHgSOTUpPeayoQDeDfoqUsCM
         CZPIE6hu5OgJ9hm/DLB1oHibfqdY/SSjYLkmRk5T/6X+mkyJvovDWOjDoAQoqw9e632o
         aOH9HbNrxydB25Tcz+zigz/ay8or9n82lSlTDY73t0j4h7sEmcN97Mgp6Iw9Cbam8CLJ
         gAsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786381105; x=1786985905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zpul/+dQSEfUwq4qJmXTVE/JC256xxMwGMA/9vorZV0=;
        b=ggSIg+pMJeQxEuY3+7evR3ixEwTSN8Ga/t5AKt4doQHfFRc/MOTpv12qqvC9gRfq/9
         aIYiqgSadjR1B6Fh9xP18wVP8YgsDE1DOkiJMu/TO93guFXqTNgeGXoF96THrzM2JPsR
         pn/otK4jiYwnP/7UjjhJ0yMLCVML89s+P9umKzwrIIlJ+7lbNmzjfhnASxTTqyE2Dag1
         DTaerIXPuYQJNe6pH3xsJ64fJY2oSkBy8U5SRGMMLw9qjxreHdnWCWuVGQrDpiUOcobA
         xzg9zB4eCxcVnbh/R0u9zvYXKWlUN/AFppbItfJ1SG+VBrfnPFI6gYoU2ZCbDD7ZwgcD
         uyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381105; x=1786985905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zpul/+dQSEfUwq4qJmXTVE/JC256xxMwGMA/9vorZV0=;
        b=QU6FdY92g/nOeMF85XEpIhinzUlECOaneY9AfUi/3vqtTMLxTkj0yGShtzivp15wNK
         ejKu+hSiZSEQXfahbk5BiZncA+JsHYtIK4gN7PKcE0LandvZvhva2veWJdB9vNeLJreA
         MHzk7HkEa496JrjHfPkltN2hkd7PqOm0NeoLnKdHFOHnlyKl3XoLkqvqaK6Bxafq7Ei/
         iQ6JTM4N33tvI//8jaaOepEN37T+dIjHjVW4uZ1OgSrP7SJPfwLknQZxxLU4Vec4Hjq+
         vkBPuEX6OPw8Sfl7W71qU8fkqr+/2tUuTPBZ/Asa5JMnu/RewZWy54zxIk4B9Rn8PAor
         QRcw==
X-Forwarded-Encrypted: i=1; AHgh+RoJgUJzp23RRBD/gbS+Ilb7ONZBInIh2BTlTsnDEEYusQYMa5I2hOc0JfN5NwXYOYXFS01WbC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYLNGZYxJ1lLL9U5+hPxyU3ct5/rL0vKELNAbd2fL3tOECIbiZ
	BH6p05kTlkZXRi2pXYvVYwYDePD1CMStyjC+O8XA4S0Ac6Xys9bkjDKNKqDmY6nwQV9OLrBslIV
	EQ3NjrbActwuEWINQKIY8kQ+uTzFHKST57eXpZl9B
X-Gm-Gg: AR+sD11AwDkA1qyCnEwgwNPtIQlwADFmSqWhODMjBrDShoF2qJKtGpwtZdukkBImJiH
	cdKZJcEUMlc6CcTfcCkCg7s0zpdj0WR68enn2lTn6j2gCtc2aXrNy7SNfgr/wQ8UbH4H2El6Duo
	YQuiZumJx5QBBSWcyoXKkuM7rsCSgjR1oMdRpcoXj5rjWIqEF/cYEfngg6T9ZR8LRISzz6NaU/J
	3rriK0NFua0hi1ajCIo8lVn1KxZxO0lKzx/cBPB1GTXfNUSMLznR0UcVOZom9fM7LBxJcX4F/66
	1r72BQskBoHseixh4J7uRQmw7JA0MasKEsbHFhK7t9itL2DOQNQRKJ4TfCo5n+fIiXp0ozggI60
	=
X-Received: by 2002:a05:600c:1509:b0:493:b169:784d with SMTP id
 5b1f17b1804b1-499624f37a3mr2740915e9.8.1786381104075; Mon, 10 Aug 2026
 09:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a71f80c.40259c87.584f4.04b9.GAE@google.com> <20260805132634.12646-1-pavankumaryalagada@gmail.com>
In-Reply-To: <20260805132634.12646-1-pavankumaryalagada@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 10 Aug 2026 09:58:08 -0700
X-Gm-Features: AUfX_mzPXynboiXULgosGiuhuHO4F_LSQrtWxrOVhMOQ5C24CN1qC2pqrRVIDkE
Message-ID: <CAHS8izOmcbyd+y=sQAxRau=Nj7VmoxZLDd00YAGsBEiwyCVCbA@mail.gmail.com>
Subject: Re: [PATCH] io_uring/zcrx: reject netdevices without ops lock support
To: pavankumaryalagada@gmail.com
Cc: syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 7:00=E2=80=AFAM <pavankumaryalagada@gmail.com> wrote=
:
>
> From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
>
> zcrx registration can fail for netdevices that do not support the
> required ops locking model.
>
> netdev_queue_get_dma_dev() requires ops locking support.
> Calling it for devices without ops lock support triggers
> netdev_assert_locked_ops_compat().
>

Ha! netif_mp_open_rxq() does check for the ops locking support, but
get_dma_dev runs before netif_mpu_open_rxq. I would prefer a fix that
doesn't require every caller to add this check. Maybe make the
function return -EOPNOTSUPP instead of asserting? Or changing the call
sequence so that netif_mp_open_rxq is called before get_dma_dev()?
Pavel?
--=20
Thanks,
Mina
