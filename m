Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E602F3600
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366922; cv=pass; b=CNTwIpt6zPARHEX+1KdUaIZQ/FIvf2XsI0rqG05jBi9605gt9cgQ4lR2xmzeXbezVjEwYMpi04DWM3Bol6UOoZZufXmCPBlyAzhB2qpBDI1U7l69rpoacVqYlpiM3cuyZEhRosa9ABAS0c2hqUJKrhrFobFfWnhkqMKDrarEgkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366922; c=relaxed/simple;
	bh=FOd/5VUXOmiJYUuOVSJphK/mYpX+tPhqsX43fAqse30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJPjWKwU6j0klPmvH3Ys17h52OVxjrXiZ/fOjY13Qiv+Vo12XMVYaxCYX9MoiItfv3ixcn+7DF7Nl1jtmnRj8QGhC8VppYTEv9f4QOtsmBxceug7y9Wm2f7zfEoLHSY4baGQmuSCFekokpOEx9WG8H9qvLz/evKrEIRF0sQFVzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d2WUHTFB; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2WUHTFB"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1397e093f90so5311714c88.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 22:55:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782366920; cv=none;
        d=google.com; s=arc-20260327;
        b=aTTPYD8bG3LXQ06WXm95kz6x/kx1mp3G9w/kh3kt0ErUabp9attwhclTE+rWwfpjU+
         l1pEMLbp8r20I/EFziojoKnpxAPo1SnbnqyMi545/gKWop0rDrJw1p4D7rWsw9q4Xb64
         d79a8t32w8QeaAL7rvabGj31yFXGKFGMGh9650lKU8HwWMyq6huEnN4hukCs/ptS05cT
         7NCtIvd0katTgkkFYFP0kd4kNMfLWuNm/HCtni/0Ej5DXJKerS4wJI4pWRFbINNWDkpC
         bn83eWwskQG1hmm7EzzyW3BmD1Mb9M14q95/IwGg994PffabVu5B36aKTlGwiii/MR9Y
         3QNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FOd/5VUXOmiJYUuOVSJphK/mYpX+tPhqsX43fAqse30=;
        fh=7ekdXJcec0y6qT3bFXo5Tv+kiwJemHozG2NP4NulLf8=;
        b=HqWjIcv4TejL7uyJtUjOrTFhqV+8BjbpE1fks8zlQluzI3QY2MC9a38LM4y7wwtQgR
         TkNA6QznbGRrD6XHtUc6sCMGMSawQGicwC1BO9bcEqvCnwMEu3KfCdVaPqCS0S5QsjHX
         /OAGg9QtFFoQNnEqBZAyfmCgHCvWWUTFmyYJMRqXrZQHb1LkP9UC6k+G6ek2AS7lnRiy
         VPUD/UqhN+Tn+aH0yW4zNFtviK2dTxpSct75zjVaMn/bzUtg9x54OklRjpF7WmaXOwtR
         oqqOXGFS1MYVmdUTmjZlBmXHrWDvl0O7astajINr90NJeTafskNAVYvsKpafvksKd2gI
         Ej1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782366920; x=1782971720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOd/5VUXOmiJYUuOVSJphK/mYpX+tPhqsX43fAqse30=;
        b=d2WUHTFB9yIS5uy5yRXwoMqMx8lUEN5rlMJGS/SX9syrS3hZnm3pN9oP/Gn4oHxTdU
         BC8Ao+g8aG34f4TLBKxl2mbVFjLf37OwvfeACeZiZPYncOHFHPppZI14ReDP6u80ANgc
         r36/ox0MwRSIyGA6ftfeXlQzNOTkA9cl2n63ZH6Tts86tSlMUfLGs886SSSc5GFdTFpV
         QP7O59EMUCvFK0pG3FTIoY9eH7dh7u07fhMqu160gb2P6KPiu3uEnLPHtgc1w6B1Hzcx
         zugybMuXUE8lSFzcxj4uJzVNu90iLrsN+4LmN29qN6xfH8S8iUyS7EOUHbzP2VrJGDSP
         dEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782366920; x=1782971720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FOd/5VUXOmiJYUuOVSJphK/mYpX+tPhqsX43fAqse30=;
        b=XLobh/v58tYRNlcd8ec/xweSCs2GqF/zzzSIuja0RZsWAOfGZwVSaxE1gJ4XezcvSA
         RGFt+mypggpjPtVzrYduGvizKrTGaMbpyiUQJHPHbUYCePZTpIkXoLmYG+eU060EcSOE
         6lJjC6HSonFQVxWPNyKE6sN11DUutV24lWlCrUIPav7D/QaUNtIrijbI5ggQJJgMFZZI
         yTqDsPR3LfJaDSJdt67fMKz1DhMvOemtGwQ6yfnHJCyV5AbxpTz3peOyImtYmQ8CsTFm
         2RNE2Wvp8vu/9MKu/9e1m2T5Yp/TRy95cWi8Wsu+7W54ZbQZxdUzp8W7fwKsHlfVgXdh
         DUgA==
X-Forwarded-Encrypted: i=1; AFNElJ88TXbGV1UPGdbpHdxSAb4yFS9ALExtjLlD8BC1nrgV3Q/MoaxTp7MgxkLDK9e/QG58rfJufbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHBFne3o+rFTL+JGthhwzqomvjwG9NeWEMANEjpEsE63W3DnpH
	7n3yeEqPE7FgeWYvsgAw2mtNqsy6XW5boRSCeXrsJoWu4q0LkTdc3szQtf+n5dEcs1bBAUQaz4h
	vg69nCYQk3n0QDU2Z+ymglY12NL1eXza80+EWsRhDadlV6j2Ll3Fcpbi3cg8=
X-Gm-Gg: AfdE7cn3NdTu/PppsanLbTfQ05VWKNhN2Vgri5+m/cWzzoLicvF4VdMc4KuqwmDhsbs
	UxPsaZGjnWuTgS9qJ1u4aagODO8DjXLp6mwBNX/VYPZ0EsqFM/r0T6+d7Lk1iR1ZUXo0m4kTgKq
	PraIsIg202R6GXWwzofHBftIweoAtWdPpJYjzh4jWv7H70qfluyxelFpgoj7vCV0iSF4hoMQqYy
	iHfFDj+g3eh+BMoLweqhqqabClfdkv8EfQBmIWmaVemqe4wRCcCpucORmz8nz1PmvGxJdct7iba
	tOaXf2nZANh6BIHK/ZmIh4IRdlyAOt7h8RH3Ek+rGWvCuspJzR0irjrpoiv38DzRbBpY+Zo63hy
	DQHmQe1x/UXcYa46xQv1JdAv1wHKOsB+HxvI18fle4w==
X-Received: by 2002:a05:7022:50e:b0:137:99bd:d156 with SMTP id
 a92af1059eb24-139db9ee306mr1184473c88.7.1782366918578; Wed, 24 Jun 2026
 22:55:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624182018.2445732-1-kuba@kernel.org> <20260624182018.2445732-2-kuba@kernel.org>
In-Reply-To: <20260624182018.2445732-2-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 24 Jun 2026 22:55:06 -0700
X-Gm-Features: AVVi8CcneuSra4RYyQ3E1DagzzlKOkzrLxygM4cc3N00dd19Hy5wApyOkF5FK6o
Message-ID: <CAAVpQUCbT1Q9BPTLrVCjpt2vcJiWsYKa0onJ_vwnq86L73m8mw@mail.gmail.com>
Subject: Re: [PATCH net 1/4] net: turn the rx_mode work into a generic
 netdev_work facility
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net, 
	sdf@fomichev.me, dongchenchen2@huawei.com, idosch@nvidia.com, 
	n05ec@lzu.edu.cn, yuantan098@gmail.com, nb@tipi-net.de, 
	aleksandr.loktionov@intel.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 11:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> The rx_mode update runs from a workqueue: drivers have their
> ndo_set_rx_mode_async() callback executed by a single global
> work item under RTNL and ops lock. This is a useful pattern.
>
> Support multiple "events" that need to be serviced and make RX_MODE
> sync the first one. Call the events "core" because later on
> we will let drivers define and schedule their own.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Oh very nice !

I was drafting almost the same change for dev_set_rx_mode()
in mcast path and some ipvlan changes.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
