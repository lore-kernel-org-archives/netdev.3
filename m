Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594517;
	b=q6ry0T+FNFr1u3b3zgCHueGiThj18YGIGDxScMBuY/aAecfUzcTLIusxwFuUWk0UCZYw
	 4lB6pHWKyh/KoQLsgUvOHAG9jEzyN5AqUqmgzRuUfWNeZMlzjGAmJJXWqnrfSCBpmkBbs
	 kUh/FmqYjsTl/Zn2J9nOmna9rzl6Add3wW/xdafCdoLlicFDBwr0XrddKbc7FOlanG60N
	 53JSxdpAok/4uRuPrcWp/pkyJfsxFfS2rMJkSCWOraVbl4/VihclZiyVV4kY26B5Yog/t
	 mAOdh5winaxIvNpzzIWQrKMCblvBNxylzfZSuqM3FBQHE+gddy47/p1v8QfL/ZKHWUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DTnZOneL4PMu8XoXZjbkX+6/k13bvPAdWUl/Ap54aVI=;
	b=LvmQCuN8WEtpSzSXhMb+WR6VXphjqUwDmoOxrDhKnLoMj9eLcMcowPyrLkXY74UGZQqb
	 NiM1+2FJsRChuIhlYRsdI+6GbihJ7+7pZ7en6Swe0YvIbipYzkCg0NT1nfNZ3AuHMHArK
	 99581FsEERYjHs3OfWYKZkhK0zwxDmW9d+OTgUJYiahPVVZ/0Kd8xaovVAVSE2lfdl3Km
	 9o/YYwCvpcarhgZ7+IhO8Nqx7hHXxM/TK1NI+1hlCR33Zm72AYBXXrogzs0wDu16KYBFT
	 CaalA4ZTgjbzO1uzmmRywlkraIzOHnV/B/Aa3MvLLN0gMlZt4HKve1MB9rvLgLnF7VA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M8+POkKx;
	arc=none smtp.remote-ip=74.125.229.139
Received: from mail-dl2-f11.google.com (mail-dl2-f11.google.com [74.125.229.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43435606A336
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 14:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43435606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=M8+POkKx
Received: by mail-dl2-f11.google.com with SMTP id a92af1059eb24-149f2b3f25dso126303c88.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792594515; x=1793199315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DTnZOneL4PMu8XoXZjbkX+6/k13bvPAdWUl/Ap54aVI=;
        b=M8+POkKxPXsKEjqsml/3a+mXvMk+h/ukjuakWI8fUHVQbYHJwyf0YOC3xc2r7uBiqC
         qXPZYumpPiCBLVeQyOk3ZynkPWDe3I1g/zKZHPkHjCzCfXo+HJvj55hFG/+T9D/O76DQ
         CaHKVfBWwjLu70HyK8rBOl+gQH6O7KlHuiPEnLYG51ioFigVdgeJZekzO2skZYAcxycQ
         Ol+T+CYjoPP4C8g2TiUKx8uE2rzIwiWgq6MdXDTdlME5A6vCbMG7Dg1IzbEbiBlLv10E
         4SHEuzh9hdkp9r5pSiwrA6f8XNPQlFhK2QhwToXzzjeC94fbwJi4Cild7Fi4+SPOrSG2
         AtCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792594515; x=1793199315;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DTnZOneL4PMu8XoXZjbkX+6/k13bvPAdWUl/Ap54aVI=;
        b=I8GXxUCAji/nE/hQ+6QulVZilaeQ3t90zFNN9l+/ai/kcaIXOFIuydQmgne5eFNB6S
         DIH3ytUfiHJM0C88tpl2btO3GkLr5mliUFQ6uO8qahvRD4n2hZbvE5bun0Ei44WS5RCD
         rmv2MtgkrVnmqxrg3tfzUGxtWRPLU2n2hp2PzXpQVbnYBk+I/2UXdmNaLjtOmHqwrl5V
         Il6awRlSQ2Me8pkRxAz7GAPaygtq/1Tn5wbRfEngOTmzalrOl3NikScoiTskNc/F2nI/
         l/m20wkDljw3BUOzADMM+1yw49LnUfb6muX5lwIgQmAABbAFSru1xc+Qg96uvxYNeBKT
         jBrA==
X-Forwarded-Encrypted: i=1; AKwUvBx/pQ6UuyjtdpKGENVdk3uGIRAa9PoP+qIm9AUFqVhc2XBsbP2OzXM4ll+QBPP7D798QYRV0Jo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmuDwIKZZOCHynZnLIFqCmV8h9W9IG9cpfna6Vw0fLwbe86bQ+
	r7y2EVPcukd2je5htdRCXX56DXF67xWm42DQVECBHmuVFz/F9XPDJr7K
X-Gm-Gg: AYBFou3tbNXhD0WqvDWqpu0SBmyL369cAxkawb+IxEScswbN1CdCJ7lyy7GHTg4LWkT
	Up9FgTb03EnbpghS1WUmzrPQTs2wZ2cqOX39GEKaFcOFaUpwPlde7sRTnRollJI5pSIBmx7BQWs
	GdqeSQy0IMsRbcKzikcEHBw96Yr3bKOpW07YXFwHTlNZg2ELwssd7sn3UPTiYGSs0OOGyBAvvix
	wZMeT/aJsY3x54CRyMXK5u5/vzTuIfVL6RyidT0Xxvk8Ew31filR6sh4nDxESfRlGQ5cCjEMgpU
	BtWaoKTLuR/D79iU/GTJ6QW6KDEn0seYimuRdU6ZBiGjQ8BBGdQJOnZkY4+KznUYnNSmMgkoGWg
	MEVsk5wZtQqF/tySNBTUgJ0bMvbOP2iVgVACRd7a8P8IouuEY1xsjiS9zjZk4ZqYSJHrkwAjTQE
	y72vgRqWoGszAScuqOoxWRibzAUKAZqCw3q5am4LKanYE8dwsI7iCcQftxqyUyKmsOij11DMuN2
	mKKtRaG7XkVNtCKyYhjlJaKOOle/leblrlIFI3Ugy7dxwHJJA==
X-Received: by 2002:a05:7022:4589:b0:143:2719:566e with SMTP id a92af1059eb24-190a728a556mr3628729c88.42.1792594514995;
        Wed, 21 Oct 2026 07:55:14 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:42::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903b3d0530sm7236819c88.11.2026.10.21.07.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 07:55:14 -0700 (PDT)
Date: Wed, 21 Oct 2026 07:55:00 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Shuah Khan <skhan@linuxfoundation.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Breno Leitao <leitao@debian.org>, thomas.petazzoni@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: drv-net: devmem: Skip when hugetlbfs
 isn't supported
Message-ID: <atjSKD3o3_dQm7tc@devvm16445.scu0.facebook.com>
References: <20261021090852.996899-1-maxime.chevallier@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261021090852.996899-1-maxime.chevallier@bootlin.com>

On 10/21, Maxime Chevallier wrote:
> The devmem selftest requires accessing /proc/sys/vm/nr_hugepages,
> which is only available when hugetlbfs is supported. This isn't the
> case on all CPU architectures, for example it isn't supported on ARM
> 32-bits on cores that don't support LPAE.
> 
> On these devices, the devmem kselftest doesn't skip gracefully, it hits
> an exception while trying to open the nr_hugepages file :
> 
>   # Exception|     _reserve_hugepages()
>   # Exception|     ~~~~~~~~~~~~~~~~~~^^
>   # Exception|   File "/usr/lib/kselftests/drivers/net/hw/devmem_lib.py", line 36, in _reserve_hugepages
>   # Exception|     with open(NR_HUGEPAGES_FILE, 'r+', encoding='utf-8') as f:
>   # Exception|          ~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   # Exception| FileNotFoundError: [Errno 2] No such file or directory: '/proc/sys/vm/nr_hugepages'
> 
> Let's check if the file exists before trying to open it, and return
> immediately if we can't.
> 
> The _reserve_hugepages() runs as part of the "require_devmem()", that
> skips if devmem itself isn't supported. Before the blamed commit, this
> check was done prior to accessing nr_hugepages, so the problem wasn't
> showing.
> 
> This has been found by trying to run the selftest on stmmac, on an
> Altera CycloneV SoC (Cortex A9, doesn't support hugepages).
> 
> Fixes: 8ac4255c1e0c ("selftests/net: devmem.py: add check_rx_large_niov")
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
