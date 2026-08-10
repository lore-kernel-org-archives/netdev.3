Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24865357A3E
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367780; cv=none; b=Y/3WiaM5hkK/fKXfsWq6mR4JnCpPq0LK9o83JoBjxmSj/Av8Oo5nL82FbBa7+X72G2VM2+VrLVyjo9jEiaGSP0tKNmp78Y0eEl6cxTX1AK2LxhVgt6ZaXr7VspfGz7kNval59MmkBDT+L3yNOqBEU7r+fIwKtljIwPRXfv0Mals=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367780; c=relaxed/simple;
	bh=Kw6DgNTDjJ7Trh38aLjU5+eLyuRV6tLCyWZnLl0+K0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V1Nf2Ks94BBiCb9kULybKSH7crRskMeBhRWFZSvkzVhhkbrM3t6ZOByno99LVg9lZe8YeGuNriWAiBYdTioUEPXdZKpAKiaYo0HPHo+XPP1enU1jaWu/FjvIzHO58PQ12L08RVDhTahejR3cC+6OLAlCu27piokMFaxbP7ojZzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJWci2xF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJWci2xF"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f703a9d05so1395051f8f.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786367777; x=1786972577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kw6DgNTDjJ7Trh38aLjU5+eLyuRV6tLCyWZnLl0+K0I=;
        b=ZJWci2xFfkkumgx+8cG3Dq2PaOQYVIshRUqB/PM7ut95v2WhX+By4UsYpgszwIZ14w
         Cwt9aW2EmjXJL7QkpdshxYE/TcIOBHQ0xBbI4oUDsava3TrbifqsGfoGVXJFDJDrydA5
         sUPkt62OnG5W/u0bUbTZeCKPn9dSa41bnXwVSMW5AM5+uWdTVK2YULYpB6ZRWYuAnmiL
         irkNFlu7KDQjAVdFtOfWJd8BEsvy8+PNMUQevfamxiNmdOLNuBD988a3HkGTec8LXQEz
         hj82hFzXlO+dVKpmz52meg4BzuPLVF260UJS1W1KAAe0gvTU0dpIEytFTw+y3w1d87tE
         8M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367777; x=1786972577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kw6DgNTDjJ7Trh38aLjU5+eLyuRV6tLCyWZnLl0+K0I=;
        b=C3jTaNISDonKKAxmSj/u9pfa/TqDHzmgOXv4ctoKMuT4H/DVSSdJC9uqVzvvCrZY9I
         JNRDTKz1/rU2v+oA1n2z98czDuWknLdj6NeVFrk/FIkttTC8pgkKeee2XZqyLP+TtUUU
         37CHZMiCuReatbicGgObufV1DOUmuIohwPgaws9x4BqmDnhIOgWWwNAuOa8r5zfz7R/M
         wwjsY3VawqC7wEOQkT+CXK3/4ucnA6yJjjZJdhkDCMslbMJInF9wWWUwgNngzQnIsdju
         poWEbYfkM9wtLhKJiI9wPTh8Y7daZbY4Z7v/VrPRuXPtq+ajE0bHG6rweGA7+xW4kpuH
         ASBA==
X-Forwarded-Encrypted: i=1; AHgh+Rr1FyUBz2le3RhJuEpbJktXGTLupdmRb2tLOXla+7Ghl7DKAsvmMRe1nj84qHZG6v0W2CnvOdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxztDlJSyJWsK1aDkg2IfUllgG1/FZ7lQLzpkbEWYS6QPbfe0CY
	KSkFGKCVPTfV8RvUJzUCR4CTBKhP715VlwZcVlml/9FJ69CUGyZk6ODl
X-Gm-Gg: AR+sD12NcxzqZtLGpBKO8A3y5Fbc6EppvNF+zcteCe80CpLUm6wqMqBkPnaAHCV6cfn
	e3her0vH7mXlXMf7Lu+OUJdljcZUtLnTv8O6BBoSmAF3cqUJ46152LyWOuzb6sPyJEx/rPWjMqz
	GKFkUwFzzshVslIzEvGzLVfxsXfKinLTg/lOfG78VskVgQUzj+76I7Kehl4mU3R11Au4MJjkGbK
	/lainDRc3e2hPJbCM5RnmqLr3OIYHvZQ/Jk6GRWWrbvoFeNyO0lVMc/4klA2JzyZdXf6nR/G5P0
	k2vsRo7BvSlhTofKebTZLNTWYC9FhNoJ59Jxc+eo4TXJhyoXq9cAVhL3gYrWHaxQgJRL5NvxlbG
	A6NRDEasB5WRfLVt156bUKoxY0S+0gmat3iOI1fLcAH0PeBP7oPQKfoq2VLaupR76LCLFEK95cn
	2cs9FUQivVAR5CmY6NvmgCEDafonYsUbSVnP8BZV3HHM5lUFUxc8+RJn5AFbfAbni+o9maK8wPr
	UVSQrg=
X-Received: by 2002:a05:6000:608:b0:47f:9662:85fe with SMTP id ffacd0b85a97d-480026c8757mr32089392f8f.16.1786367773907;
        Mon, 10 Aug 2026 06:16:13 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800214557esm32740180f8f.2.2026.08.10.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:16:13 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: stable@vger.kernel.org
Cc: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.18.y] net: fec: do not release NULL pages when RX buffer allocation fails
Date: Mon, 10 Aug 2026 15:16:12 +0200
Message-ID: <20260810131612.2637858-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810123902.2611897-1-mehmet.fide@gmail.com>
References: <20260810123902.2611897-1-mehmet.fide@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A note on the trees this applies to, since the subject names only 6.18.y.

The loop this patch fixes has been unchanged since 95698ff6177b ("net: fec:
using page pool to manage RX buffers") in v6.1, so every stable tree from
6.1.y onwards carries it. I checked 6.12.y in particular: the code there is
byte identical to 6.18.y, so the patch applies without any change, and the
crash is reachable on the same terms.

Please take it into whichever of those trees you consider appropriate, not
6.18.y alone. I only tagged 6.18.y because that is the tree I reproduced and
tested it on.

Thanks,
Mehmet
