Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793144492;
	b=gRpm5uXn/1K2baxmKG7aH+ymLvMn+A8VwLqpC0yspHpRrGZrEawj13zr2xZkMTnu8UCq
	 79OK7eJ7d/ppOSslGYbS9eQD8Arr/L+IXu19fV6d4r6o5Q83KKDaZDBGjKQ4nLkseZpIg
	 8Q8fz5T7psp0RGOj7vWTObvgr6qZL29fI6r0/lQGvJAqAEl0tKys1t1CcFlFFsXlV6dHa
	 YEelDLm+ZKFMepJqKoslNJZ3ZIGhbXUynh9I1zrMhYvLSAjEeEkKHMr1TkzPFlmMlXtL1
	 w2RUgFdhYZTmmIUdm2TRM6LZgJWaDpyos1msqjI3J3dBUnfYEWLPBomhbFH7ZTvmY3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=0I1FBZ956wGLn/X8olCE/kflFcHGoe1hSLvpL3SotdI=;
	b=oRHvw9ViGf0Bxh9B3IUSRnbkOxWiBG5WwfmSsE4MX0s4meT4urIoI+lQ4JbD3qELRVbK
	 +Ztd57CBzN88tDgg9I5cWIjuNjC1cMt/hNqmWmIdCyTfXOcApCZlNHo8NN1k1UcqrRQPQ
	 Dh+ZD5huaqjRO4rvrcdJ7gFi4zXZFZzqKjwpzgn0ENPlIZKtS6MN+LeBPAIE5WDR8Asx1
	 iMhUDd+PK8huUErgEYUVibVIE367qQJ6zp0QXKCDB8tqVJjBafOpakbmsu5zsbc+DwMOQ
	 nXv/JCfnJrys0tCQ4rxB7Re7HEBb9cJtGRjvnzaYjGi/Bz8FQsQVJReit6NaTgZdtwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q7QASbKg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AE7606A31D
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 23:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67AE7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q7QASbKg
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6e560e00a86so363113eaf.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 16:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793144491; cv=none;
        d=google.com; s=arc-20260327;
        b=cmof33QIkjrqCx0vmHt7l2CzTe/NCs3IM4qNlknPd8h9ZFhcQMNRCgMsF6LDOc1zvs
         vOhg8GUddZzL8k/KhcP/Dy8t0xR87QK+lCi4qAuNAivQDO+act+yaYhlWNo/oqmMEeoO
         4jDarZeZrJVD0Cmx88AGpQNwVA5zyMDJTJSRKjkONigXue1fMIYsX3Rwe1Tlqif6846N
         sZXDj6a7etTwrcGWn2X4ztYszn1AKdfKHBHILoJV+qYNl6XhgH6wiiVX1RPwmGJj4j44
         zj6rQeNgsZacR7Zq/BcEFltavGISKGVoTY1RxZgXmVVW0xIaGuZYxmr8Tw/umQqN/KpD
         ijlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0I1FBZ956wGLn/X8olCE/kflFcHGoe1hSLvpL3SotdI=;
        fh=WsGb5HGFqcP3v+Or1e1/XXJEDsWbsLElT/8R6eVaRYg=;
        b=DVFwTvzZpJpKKffc6PSFZ5dodlnYMqqXKZ5Y14fJvXVMiReUEzJZV21Pi292zmpdud
         FCvdTr71RVwkq+BKGz4uOHX744beiNxtoc2NS6lpI8CxLpZCqr5JA0nWMvD5tIjW+VLm
         ykHWWkUNODdsw52y3XgUQ8VDNUA99W0kQxz/yzED+3SLhL6zMmkgfE+QpIW3kTihq2Ow
         YOCTMboq6EPnkLOnvRVWmGTs+syR0S7dic8dofvvEMU/cvN6yfftflPaYBOQEOoeb+QP
         1A/C888NnqdmrWwR0vD5aAjmRGqr0Z4gDMwcb1LHMkLvC5/0ABEHVvcntMR1o66vLk3+
         2+Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793144491; x=1793749291; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0I1FBZ956wGLn/X8olCE/kflFcHGoe1hSLvpL3SotdI=;
        b=Q7QASbKg2H6XxG9/YowWVGCNfGIQ8KZYkWMnuqExkdNFXLcCWVLT7rnfAyE2iQcVFV
         4LnF85d4oQp/1xY2FfTLvUUR4gnpBLnOFK0RLWybfVxT7Zv+VNCG4tm7Q4wtFliyQXui
         Qi15iO4kcWpA0q4O/HODfzkGz/d4YRZQlg2/lWgC+ZT0nwXRoGPWDQvk55tnmbhxEHoE
         LWmygWZVqDVaeqDpbyaB/x9LRbm0k+TXyPpXVx/m1KQrfoUo4Toyj6uWFAswyMZeubjx
         U8m0E/rillRqW5NSvLfTNZqNrl0fs5sWoIdcu4iN5C0ULpsSkJgR+up5cgMp0O+BrPPJ
         HizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793144491; x=1793749291;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0I1FBZ956wGLn/X8olCE/kflFcHGoe1hSLvpL3SotdI=;
        b=hxEezamkaCi0fLkWR0MalAEYrusypP+UDUWK/sHNG9ig24LYt5fInQiImgs7/D4SNT
         kKrO68OaqlKAWC0dPWqwaf4m6b2WJRc5id7HlQuFkFWdO40KfsuOen13LBdxgC3vhsO3
         zqPRWoOd8KWlJc9Fi4JTQaZGEifDO8AsaGawlWCxgCOxL+iXoimvK9LO/uwqx9LR/FX0
         kFQGrmDx6HaS2BTjFRQhcqfyb0B6pkfI4VtRrhzZ7vdIZg9RfuyRfRdG+LeY6L4OmZM3
         QFegJw0p/1C+H6gAEy6te7Y7f9kbUveAPMiN4qpdQ/vWAlYBmM4i6ctOBMNyRVoOrM7R
         l6kw==
X-Forwarded-Encrypted: i=1; AKwUvByESCsZWRviUSuNKcR+ikd6Y+y0gjRLy9mCEeQspKllPbedZagBqiRPXOkDelOqiq6LsVoIsdk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ27RXGXE+arY4XKJ7Z/5TD/M0vGCFJNFaS1YCPGkW7+jh/HbXa
	HEJF8FqTMe5OIDG9daQ6RC613Dn7K2XuMRpRhzQ66f63LKxbeKdvHl/hTTeDndH4+bRH1qV88qn
	4Xn1McmI4jEWHeLoKjidBkMEjBkvqHASalk39+UQ=
X-Gm-Gg: AYBFou1uGS1C43bj+tgijgAJx+2rcage4XQy0ugrfs6JlTPaeO3GuhR3HUXDy8jQ+4s
	ae3pSABU5MNZap8oNpATtKVm/xQfAdfYFhgjELEzS9Z/EybzD7tfrdRU6653U8L9CkD1q9dl6zL
	gpb6Cx+9Cr32I/Wg6YsbBvvePPqj919ya6BC6K+M5+tmu7WJkdekmzX0QWKy1YPPfHzctLaQ/hK
	Z/IkjE0pQUIgw/iPvxgvBibkdFR4ym0butP300W0MJjauKoyCV/uwMUJF9FZez3VJNj92Cytf2L
	xkRQVnCDX5vsyNfeTGAS9np83q57rFPRnsi1cYl5iRrSdJvnVbxuxFFXXx7q9OD/Dt5Q2u7EIol
	avSoyfGk7mUMRrkClJducMzmSSpUy0k7QAxCv1t83vSHTS3dDDv0=
X-Received: by 2002:a05:6820:3416:10b0:70d:8086:e497 with SMTP id
 006d021491bc7-713f157287fmr289110eaf.38.1793144491336; Tue, 27 Oct 2026
 16:41:31 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-b4-8139cp-napi-v1-1-c9b683d9564b@gmail.com> <179297317507.3134.14510456592684233796@kernel.org>
In-Reply-To: <179297317507.3134.14510456592684233796@kernel.org>
From: Colton Pawielski <colton.pawielski@gmail.com>
Date: Tue, 27 Oct 2026 18:41:19 -0500
X-Gm-Features: AclHuK9ZlS2Hzsq_FlWB3EDnNwqFet-LXqbCSo5sxsm-OM2xCGrDfP92Bwret24
Message-ID: <CAJpaz4bZ65aQtNDuxRR385GePEvdfWDszz3qufQWPp6+xh5wZQ@mail.gmail.com>
Subject: Re: [PATCH net] net: 8139cp: close race between NAPI completion and
 Rx unmask
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, daniel@0x0f.com, geert@linux-m68k.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 00:06:15 +0000, netdev-bot+sashiko@kernel.org wrote:
> Wouldn't this CPU then spin forever on a cp->lock it already holds? On
> SMP, one ARP request or ping from a peer on the link looks like enough to
> trigger it.

Yes, this is correct. napi_complete_done() flushes GRO into the
stack, and a reply sent from there re-enters cp_start_xmit() while
cp->lock is held. The LANDISK is UP, so it didn't surface in my testing.
I reproduced it in QEMU (x86_64, -smp 4), where v1 locks up shortly
after link up, and on a Raspberry Pi CM4 with an RTL8139C+ PCI card,
where lockdep complains within seconds. I should have tested it on
a wider variety of hardware configs, lesson learned.

v2 will leave cp_rx_poll() as it is and fix the race from the
cp_interrupt() side instead.

Daniel, Geert: thanks for testing. Since the fix is changing, I'll
drop your Tested-by tags from v2 and Cc you on it.

Thanks,
Colton

pw-bot: cr
