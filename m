Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740013E9C12
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143660; cv=none; b=UZoL9EzSCKLwQ03i/kJbjB8WuzId921XqXaMj5/9BXSLYkziTZKMAPZCJm0ifeSKPk7KciW9EvQo0FRv4IRYaj1x3g5kEwOfAujPZmhBQ4J5HJ179k/089gTGilLlmWfglYP5EYlc5ZCdu1lOggg5dgI2c1ApwnCYk90u0JIESw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143660; c=relaxed/simple;
	bh=Ub71spstyLFlI/ed3S4Sftw243+6LpfdBp9EJLWPF9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uO5f1jJTkYpp9wXYxuawwB3kYN+wS5tuO6T++vSSgTTTGT+Hh9On91HXwzoLXqnATRL31b7M2lnwX+9ZfwxAaTPAaFxqbbzP+N9drdCbx+Jthr+At+pbPpeHr0fsNfmHPwJp3pWUq/cWHGRYcgAjWCQmddaoC4/07zKFYb3UZgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=YRDbYB6n; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="YRDbYB6n"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f707e5d75so1637896f8f.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1785143657; x=1785748457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CvoOIR4zXM8kcVSn7TlgTFMfrKFyI+wlUlCuS+RENlM=;
        b=YRDbYB6nd3GF9A6c92I+ZA1RGAxzjxH5PnE6PzY/cZwiWSqsSwuDAEk6wuxNOzsCQd
         e2mjT2PA1BRxWK3MvZsN91bPJ67LkjLuyIlf93mTzZ0HxZyOWUGoepTeACnoTVoyAwPL
         B2Tz/TKk5GkLwkXPs1bpo2KLfC8VWLpZdAwJk3s9qDwIAVqNOa3u8USDT5BQVjYsddos
         9y9MwPyCs/K/VXHq5kMHPIEtJfeCWuLvJooiT8CAbpmUAnBQmZbG7Ow1s7v8NkJFM4vl
         bmAX7FiqajsyPnVTlElNuGIPl8fh3DbwQ9uYOiAXpjs+/0g1pH8siKLCeSlLBsctQd63
         1EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785143657; x=1785748457;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CvoOIR4zXM8kcVSn7TlgTFMfrKFyI+wlUlCuS+RENlM=;
        b=YSKpGv+01nOjh3V5ESICUrQ5JQKqu0tAfkWmYPDz9ta8iTqnO+vBfSlGkaHif+J6/o
         S9tskLvu6bdXXMnCDsDbzIJE83Vhs9C5NEarKfu7ETw4glGt4BIR0KuJU5iF9EcN3lFC
         PegA4oCH1w/a107vnuu1wcG28RCzx9gcrSovN/t+kRzAJbw67fthtoEvXJhPAedbQ7tZ
         R20HgWGHUTQrK6Lw+CJpK72U0fJxt/dFNgRbdI33OwAdDFUpYvKkq2qa5d1A56IPo5Dd
         5N4hQXj7EOUgO56XUYwPnnkPP/+IbMN9bCGR7P5SXvupeQQ0BMm4SudkhY3/jQ846JBd
         OCKg==
X-Forwarded-Encrypted: i=1; AHgh+RpFoMgjYfQ0z2bqvgT6oQLQkUF8ivaPOg1iFzboa5+oTxU7mGUK/XY4As7I22sbozS/hwPy3hU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzohQrbN5BMaPTTjAt0GHlXW6CQi/3xINN5jx4q+b7YQtiSfxp8
	M00Ldc6i8PW1vO37bhQEJP6SYKfN9Z4P1gHWNWf0/DMY/EVMjVUybS0eQ8IDr77XKX0=
X-Gm-Gg: AR+sD12JPRpVym9gYitK58pWn2Cu0bIIaUDljHr9Csmy3oxUON+EKvE6NamowifcdU0
	NvXx1ioepeCuFWa7JydEvq8Zr3op+paL6p1w2SniHIf4UIYHmzDOj0Kx718gIlBcY7j56cimNiP
	hOIrn+9ll1oaENuxls21ky/YilZ66aGrDYiDRddlQbXpCcG3rhjk3uADXR7/WYR6bzejnrEKfcC
	WT75mZEEsabYJ4S+pq4LqTL3HkFk0FdURWkweWepFEI2enS0OV+mt9OfrCa1Prs5xsY11Uoci/e
	v3SynOYdVAP9BiYvDFPdWm9eg/g+uGyhtDCxVKnkHGGR5WwdQ2WwmxTVh7+2TVgd6Y+BS3JMUVL
	SAW+Lxcu9kzPfI3JpEKHwmXqEjH2ilZc8vGi67nxazWxv/MFMBU+QXOmqM6FIEOccjBmpMyBelw
	==
X-Received: by 2002:a05:6000:200e:b0:47f:9441:51b5 with SMTP id ffacd0b85a97d-47f9fc8c064mr9641263f8f.5.1785143656513;
        Mon, 27 Jul 2026 02:14:16 -0700 (PDT)
Received: from localhost ([109.160.73.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f939c1465sm32843149f8f.26.2026.07.27.02.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:14:16 -0700 (PDT)
Date: Mon, 27 Jul 2026 12:14:08 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org, sdf@fomichev.me,
	daniel@iogearbox.net, almasrymina@google.com, matttbe@kernel.org,
	skhawaja@google.com, dw@davidwei.uk, Joe Damato <joe@dama.to>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 3/3] selftests/net: devmem.py: add
 check_rx_large_niov
Message-ID: <amchUJlyq7ahQIco@penguin>
References: <20260724-tcpdm-large-niovs-v6-0-7975f62cdfbb@meta.com>
 <20260724-tcpdm-large-niovs-v6-3-7975f62cdfbb@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-tcpdm-large-niovs-v6-3-7975f62cdfbb@meta.com>

On Fri, Jul 24, 2026 at 02:21:17PM -0700, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Add a new devmem test case for binding the dmabuf with rx-page-size=16K.
> The test sweeps RX payload sizes straddling the niov boundary to cover
> the sub-niov, exact-niov, and multi-niov RX paths.
> 
> Silence pylint invalid-name (`with open() as f`) and too-many-arguments
> (ncdevmem_rx grew to 6 args) at file scope.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/drivers/net/hw/devmem.py   | 11 +++-
>  .../testing/selftests/drivers/net/hw/devmem_lib.py | 59 +++++++++++++++++++++-
>  .../testing/selftests/drivers/net/hw/nk_devmem.py  | 10 +++-
>  3 files changed, 74 insertions(+), 6 deletions(-)
> 
 
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
