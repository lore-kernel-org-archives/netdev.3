Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DB3AB29E
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708601; cv=none; b=oJJXSee5Fuj7UTobp0hIKnepU79OR5mAHaOPZqWh4fhbjlZTa9T43ge9TILTeh7JKX1s4P5yF5I+4NyQEGqEF30WBSB6TRdQuNIWQWLhstyZeEzpsQUaUyvdYj3bj7pkqObepYmrAEEokd8lgq4AYgH8RMHo4x8Tiz9149avuT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708601; c=relaxed/simple;
	bh=75WIdoyehgQt4Cvq9Rasz+hBaYGFXii+O4btnkeMIkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNW4zFKgUgV1B/IZgCMR+SfPBAGxRdPNwP3xKKvor5TXLHYaZ0q3XfXHssHJ50mochH/4fzdi7kSi0YCXe7QWWss5NqUkdV28dzhaw0jct8yYysboVbtiu4FPKMA9+bFjLVqsEO4svDRmz407ldZ+v5V1SH4iPZnnA+II+k0xyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbhDcVGb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbhDcVGb"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84830c774a0so749155b3a.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786708600; x=1787313400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=75WIdoyehgQt4Cvq9Rasz+hBaYGFXii+O4btnkeMIkc=;
        b=nbhDcVGbRY6mEqtji4ay7q2+IgyyPEQWwJJNfssRWJArWGGxQ5FF/BGPblC4PAHeRx
         1qM/1oTnuvSc3id8cFxNLvRpz934XWJEmdJ8AdLD0maQIPPm1WCac5WX1PH7FTkS1iso
         dEoWDn8Kf1vOK2m+jBdoHDuzBWWjUxvqvgM+B6VQSSwM9/PbpIlQUYdTavzVbOHCBqXq
         EMZ/HMeGrIVrdW5MxpL23QAMaMGKNydw9hRxXSm/PusMv1L9jmTlHrpgLXTXFE18kYyZ
         1tEiZX18Sn7Ze3xc0twCmfLDyFNCzpmcFDHZfp+TkCuRvo+Og98Qz4qHBr9XIeMF65VU
         //Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786708600; x=1787313400;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75WIdoyehgQt4Cvq9Rasz+hBaYGFXii+O4btnkeMIkc=;
        b=kJ07AOq68Vn6rDzRkrGKwXfImE3GCra9VBBCyV0a/cPwaK0UfrdZK091McsRdw3kGe
         Es1TeD7BAdTOjlBd5xFmw2ImEsZ64NOfndYvzsz1iAzFSJk8xRr4Oiezu9ICHY3+HNs2
         lQfeE4e1uXvjZjk948QqQd8AN59mY1VN0WVhDh9IMr936W5cSAbZMrTXsK8IcuPnHgts
         dBXTEj/7yaX0SzgMOo4x4Ycr+69+lNfxRMDSbwUu8sY2frwYA/1NxtaWoUTikZNsOYdM
         G9aHPirc01ckJg9zfStC1/7nCzMX95pOxdu9/aDo/aGApfx/O5spl+NYYpYhzB0uIxup
         p4GA==
X-Forwarded-Encrypted: i=1; AHgh+RoZLMkkhyYLefqr05os2RtDGUp4trstsHY5C2HlXGorIMn+cwvD+qz2FXn4iycC+N179qDeUHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgHMMBojZBUKymcJuRVnfP4rYHHfu7Fso96FkPI7j71QY6lJz3
	X08EzZWFk2a1cBr5GX/tN0zxfp1tVVoQimErr6D/z1+NFCBGQZqMajqn
X-Gm-Gg: AR+sD13KQy7/WQEjhLIQIc+U4Ynu1MDh/koKtrgrYiQPHfoFpZdG7RALkGyCCT1R4nV
	HEJ53sBfFyCSi3+k+HmCP/XC0Ovhsv9650FNpHJ0ZMnu/wYp3sLGhNq89bQsy9skMJrwrXr7fPu
	pRNvfPETTuwav3byVCpAWlpPNLfLmOds7bFCG7Qj3FMYYRXTemzu9zzCv2SvUpEovpwp9oTobFm
	UktfITXIs2zDS5zmVlBg7YpeAeDkGcUEdPXhFNHNHGa9y5DOBNKk55/LEa8wUdDRm6U6f9/AtMK
	+t0TMMb+UFJXTIvCjI7EC2c3+TIXa2tul3a3jEeQbIMfdKoowIq2QjnJc/qSX+4JE7dZArX3IA4
	CsNhXvHqNSFzUkM5O+lNJXJ+7V2iO+98hqRYFhzj4Rlsy9kdJ0zGjbdw0fkBAWvTU3TMHA4UhCE
	JkGgtGHa4jNzlxs126Q7sFsCOM35Mx5o5keNsNfJo2O5a4cS3+cT7+HC9GihH5
X-Received: by 2002:a05:6a00:b48:b0:845:a435:a2eb with SMTP id d2e1a72fcca58-84fde41c7a4mr5213758b3a.31.1786708599236;
        Fri, 14 Aug 2026 04:56:39 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517cfeb3d9sm366669b3a.11.2026.08.14.04.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:56:38 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: sgarzare@redhat.com
Cc: Jia Jia <physicalmtea@gmail.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] vhost/vsock: keep IOTLB across feature updates
Date: Fri, 14 Aug 2026 19:56:12 +0800
Message-Id: <20260814115612.127842-2-physicalmtea@gmail.com>
In-Reply-To: <an7KyotZ5vZOURu2@sgarzare-redhat>
References: <20260814072903.124991-1-physicalmtea@gmail.com> <20260814072903.124991-4-physicalmtea@gmail.com> <an7KyotZ5vZOURu2@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Will we do the same in vhost-net? If yes, all the callers will call
> vhost_init_device_iotlb() with dev.iotlb NULL, so should we remove
> that behaviour and add the check we are adding here inside the
> vhost_init_device_iotlb()?
>
> Or there is an use case where vhost_init_device_iotlb() is called with
> an already initialized dev.iotlb ?

I will check whether there is any valid use case for calling
vhost_init_device_iotlb() with an already initialized dev->iotlb. If
there is no such use case, I will move the check into
vhost_init_device_iotlb() and apply the same change to vhost-net as
well.

Thanks,
Jia
