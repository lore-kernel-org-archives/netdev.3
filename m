Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B9036212D
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168157; cv=none; b=d5nEYJxs6zlHEmSmLghwNYf2kfUkdW0JpCf/wV2rLbXevSwcn8XW5Tvct/qxHyBxZnDPJBy23ZA+Qz+7+z3jrBLfW5YZx0kcXdlFd/Bupg+wPYHowwN6ktsO0s5MMg7Yw1X4e/HSpc67sbLSHKEO6wX4d05uwvLjLnPXDM4T6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168157; c=relaxed/simple;
	bh=cdf6zOQ68rkdfy+2UIkAzlZ/8jxopWcx2C9dkL08eXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8IXqR/23h6vJy5Jz7qorqiMGDjZnWRsqrYDilqXpKMFe1b9xx17OquWo2fjBsXDhll6xx1BKu3YHLuxJs/vCst3MWdA+KGPHi4Krse2SkXIFJcN8JjfxNj6hznR6p0aoNSTlw1ORbMw66NKiV/I9/NRX+OwRBpDasidhkMgrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=achG4C+S; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="achG4C+S"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf18c30bb2so57430895ad.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168156; x=1781772956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIc5aGCRuh/WNyXNC0AmWEpzTu7IhjAFmIuMhEhGp7Q=;
        b=achG4C+ScP3ijhroh9tnCJQ5vNFrOlEVRBDNvdqeC1/pL/SiuGGc5i3+F4+5bIae2r
         b+V8r//b5sho9KgPQSoZcZHZZTFvXYs52rwWIWi2O8Bl9tSVdvyjmY+yf51RJSLxvpog
         yoFs1XGLnovtVwowIV5IYW+/gxFj5jupC49Jy5TULZzqLL52FEmgN7kigOWbKLIzA59J
         Ad/Dy9PAxzQFE7tfGSmI9BkQF/smig6djr0Jlp5oCvbGvBOtTL77gmLI8JsOGbwn5T/6
         GyXlZ6oyOOvljm66CthP9kQCfpjwOUBQm47LesC6mqw1ykU8jPiGpKjadeQAluDmaV+f
         vzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168156; x=1781772956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cIc5aGCRuh/WNyXNC0AmWEpzTu7IhjAFmIuMhEhGp7Q=;
        b=RVq+vUj9scWB++ELUv4Zs2B1xE3NsD5OFWF+J+cP6n9AW6LOl3+zUQ2TM/8FmyKxEy
         8fbNIE9PKZRmU2bpNIbttCaTDLYfeZHaY2VResyC/NKDhDz5ODyj+XhbZH1/3as8fYq8
         1sP+hxRnoKIjjC/ssEoIfwZuYJPOXroM6401UTtr/dhDYZYfKlzfFK/EW3nut1abAKO6
         KecMoFiHQ7u6j2EoQe/eIJnSAFRSum5h2NtbX0L/gouFnCMy6S9/9btd57tRxzQUEDP5
         iGSaTerYkRCg31yPOK2KSwaX//qOV37mCqgMBvOnxLz7Jit8M7VkYwPucbFXf54f4SPZ
         sbQA==
X-Gm-Message-State: AOJu0YyFSYqnHCsccyWzlk8GLYTO+aAK3+LU/n1bVO1pJiK1BGgFylmm
	J9X+iv3GZwOP+0K/97Yw5c3RT+HPiaMNFklb5B5MrONIqPpW41fkwaY=
X-Gm-Gg: Acq92OE4Gsln//zrBMz1UFQmqzI4Ty3AwPzh1FjWESY5JfuZQ/PSD6olb2mxnXDIkG2
	27vgIX+6oR5ESMfVxg0S6cidtXS1c4yBbGjC0EVwTLcH1fh8CchAo9EETrLE0ISMzw5Bd3cqgRq
	OKXgqTqXlbPBIJNtJzRthkJL4gL5r17U9Oi0/NtIj/ijGcNuRwnZJ9u7QPZQfQeTQq70UKZtxAz
	XRLJTQNrvEdhiiTL6U3LXexQEx7N/87wCzTRS4oNRhFrv0YzXfeYZqxDRzdgRq8rOhVd0xZd6zR
	c6Abf6xqPZm3zlGtH+HvtpfNRdhWrWtbF96TgS4/vVR6Y1/eM6swb1wqGVJQJBMj6PMGqtKXETn
	eW1Am4finTl7TTzJ+spEnDQZLKbj55HktVzFI6qMT5M1gPYhuw41qQNtBQEEKcIQOrsfqGGAbV/
	5Jud25MFs0nlLhn1LwQgwxwiCeBNQVoKy3Elc/XtPRkNJ4N1OQHPisfnKx2IBJ4ylGnN+Te6U6o
	HlW7A==
X-Received: by 2002:a17:903:2ece:b0:2c2:7e17:39f6 with SMTP id d9443c01a7336-2c2f2f5dc47mr22090075ad.36.1781168156009;
        Thu, 11 Jun 2026 01:55:56 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edbb49bsm140758755ad.38.2026.06.11.01.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:55:55 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: sgarzare@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	pabeni@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bobbyeshleman@gmail.com
Subject: Re: [PATCH net-next v2 2/2] vsock: fold sk_acceptq_removed() into vsock_remove_pending()
Date: Thu, 11 Jun 2026 08:56:03 +0000
Message-ID: <20260611085603.626387-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aipyNh_qseEUxj6Y@sgarzare-redhat>
References: <aipyNh_qseEUxj6Y@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 10:35:23AM +0200, Stefano Garzarella wrote:
> Maybe we can keep these patches separated (which I like) if we
> introduce the vsock_pending_to_accept() I suggested with an initial
> patch of the series.

Agreed. Will restructure as a v3 series:
  1/3: introduce vsock_pending_to_accept() for vmci
  2/3: fold sk_acceptq_added() into vsock_add_pending()
  3/3: fold sk_acceptq_removed() into vsock_remove_pending()

Raf
