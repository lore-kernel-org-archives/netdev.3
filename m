Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F9233933
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661015; cv=none; b=u9s6ftyFfc7KNtbEMROaWiJFWrpxh0wwidcNJo/BpIi4fLr7UG7bTsrwNFqAnjzgoojc3T5C770yqglONORIpeQxtzsE9Gg8amam4xx0YOgR1goZsO1Hwd/sf/pQM6TwNfoC9go9iH0Rq6Erqemjoplr5SuOg3/0VagJ6BmZn/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661015; c=relaxed/simple;
	bh=ZB2kSNGWruj144MZSHxh5Sgn4hFf6O52zFdjPsZBmT4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References; b=lDOIkMxBXUicVNH2aciQSPJVUuchO1dA8333X2w544ztXjYnzaEtDf1tQAAYH3Dd3vRoBvsTG38g8UQTxWfpw5P+CHa9+lOVvV7li6l6ZXAlC3VxlE5oCnPTGGmzyP2yw84SNjxwoHhcaIEFI+iZ1abn8KvgVuppUXkrZV7kQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXt/nohp; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXt/nohp"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36da8439078so4501840a91.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 18:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781661014; x=1782265814; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZB2kSNGWruj144MZSHxh5Sgn4hFf6O52zFdjPsZBmT4=;
        b=WXt/nohpYQygO6SOx3mE8DheCWu3QcxryLmy5JsbhZ2L7yVA6nTH2ebB/Iu8IQ8FRM
         U/tZiUz2sg0A9KRZq4+caf5iGxUBlFD55FePStQn7Hh6knmOynVYJrXi8Am5EUgOKlVl
         FzVMt1NjF1hN5bK+kye/szZ0prkw4wOh/SLJZRwkvmLuCDk55GnjxVsKaB8QBdVCADFX
         Fr0FA1FAbtAMYUNLVpd822JVw0zQko/FNujSza++7pqquQiaWn6xEBoT3R+E6hqY03VI
         1c+Xiu1aJAFFynmX/x5P95clIxdut8r3/ZeZzbvemDeHHF+eYQnIGIiwf/IQsBb0HPyv
         BSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781661014; x=1782265814;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZB2kSNGWruj144MZSHxh5Sgn4hFf6O52zFdjPsZBmT4=;
        b=pGFmBf2f3TqTGoAjXqZqAEM6QPf/ZqouNPAznRe5ukMrKEP6acSV76UGC4JhLv0CDH
         uwaW6+qmKj08lAaaMimijPZBH50/uEp7R22UQBCa0ryiUy38Nbpha2kDPSOQYrF/Oqxp
         Kmxz/1eQ+CXSc0lw136RdDLKygR0E1roZ/sEIvVpIsI4NPsHGaqxs3hWBJNvjf1KuK/t
         dEI1Xp45bSJY31VrgnHo88r3lenc7UXhoZB5bDixoGHot8sjnStxP/wCFuQF1BvZhUKV
         TvKhyhY3NRlQ/4QCaM3XKVzEaVDjH7rN+ZFzZQL5QXBbeIvNMP+bgSY+0cxUzAUbZ9Ko
         l4cA==
X-Gm-Message-State: AOJu0Yz0P844rPzvhPONc6NsawAFzU8bN2opTDXr4IcyMuFdhJCCCpmo
	XA8KBQOkQM4rqKm1Ndi/yR3eQ6cDa60corOplPFfp8Tb5O48T5mRhwiyff0phNtfCa4=
X-Gm-Gg: AfdE7cn7f24+TwukzliwZzmI2ebWOv4yeT5IC0OTtgZ/mcQmvv68CYvJ8899Ud/OjOw
	lGwrQfC1BhAzS7f4amIt5+5bwoZpLiyQEVW3zE9a8ok6ftx+SlDhJvnffOmS74Mq8kIkIgt4Vla
	mn8xN6Mzdy7+YQa+CXami2szvE73u5QuxM2vBKhq2QTWESHkg2A0mVWE4bLRZhmQvPJGtcpiYnt
	tTu1wnmjedYuclit73rndJBR6NWIwi0uTzT3QAvR4/Vw8wn9qrU/btruULbZLKtIytVN0YSXFzE
	A2cKR8sA1ZAfvLGSgCfjIYxaxWbajUzCn0v9foOkBvq1CBW0Y+r8brzWa2vIKKYMAqWIj4Aqc32
	FHUDRI0+4jjBynYG8lf62hyl2KeQ92ARQ+Y4MBhslzvQH1UQnHru7tEQiyBP8WC/f+pht05ECPo
	ljYjkDIQ==
X-Received: by 2002:a17:90b:5107:b0:36a:a16b:5f65 with SMTP id 98e67ed59e1d1-37c9372863cmr1891905a91.11.1781661013882;
        Tue, 16 Jun 2026 18:50:13 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37ca1dbc8c9sm434740a91.2.2026.06.16.18.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 18:50:13 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Wayen Yan <win847@gmail.com>
To: lorenzo@kernel.org
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2] [net] net: airoha: Stop TX queues on error path in airoha_dev_open
Date: Wed, 17 Jun 2026 09:50:09 +0800
Message-ID: <178166100984.2204581.602535015871075159@ai-server>
In-Reply-To: <178161146875.2165143.7400860261990016053@gmail.com>
References: <178161146875.2165143.7400860261990016053@gmail.com>

Thanks Lorenzo, you're right. Since ndo_open() failure prevents
the net_device from being marked as running, the extra stop is
unnecessary. I'll drop this patch.

Regards,
Wayen
