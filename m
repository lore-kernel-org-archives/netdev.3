Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDF23E25B
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 04:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786681896; cv=none; b=q//bjlLfheQFyJr9Xdm6e67CIQhmIT2kGjYkeRqaM5QFx4bbbaNm3MM+/DnSHwc6ViksAYl8k1RpOq5r9evW/PnRNmvhJxWusbhW3qFczUophHS736uCZ1O7rcvQP/IIYcPrbL7tkUQNqJXM8pyObmrVATu7pyjl3KCmufCnZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786681896; c=relaxed/simple;
	bh=mqmbsOhXmMeoZa7URMfx+LqBREMmyjr0EHGmAVBhs04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoT6QX0aNZMlwJUJbMz2zvsrEawoXu5rA3Wu5kUNxQ5qEpeYg7OQzN41wo3EOQdWcuXEm7lM5SFj3Cvb+myxezWaDZl7npaQtxT391+8JMqRzpv3Iu3i3+dVynAb2jJ1GURHnk5tq8mJFaMupEpY+qyRBn/R1DPK033jwL+oiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVsh6BYu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVsh6BYu"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbedf433a99so532533a12.2
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 21:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786681894; x=1787286694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mqmbsOhXmMeoZa7URMfx+LqBREMmyjr0EHGmAVBhs04=;
        b=HVsh6BYusvxxr6KiwoulZbhma1smZpPjV/2j0kU6mle8rSe4HR43IYiwHB57+v18K+
         2leoaDP4nOaLOclAAB0Ssosb5A1kc1G/2DhEk8Dvukja2zeOGQENRfAFWZh0zr/zlgZE
         iJkefA00cfykwokspMuPnZ58XwV3VXqb18otGeK7BtFYlr22j7ZaqhVfrh1CkbFrbq43
         nfACF+cbE8UclOHjXfc5UJ/c8CI49DIr+p2a0XTU1oBLk5RQMJOGYQVMXhdQvo3H/tr8
         hxtMZKu5sHCkpLXGxB8kz9dE9eX21jdZsGhG582mVomWxjzcduVVdz2XwMcYOb51Wg3A
         kNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786681894; x=1787286694;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mqmbsOhXmMeoZa7URMfx+LqBREMmyjr0EHGmAVBhs04=;
        b=cHm3MLlVZOpAoseZPWrfqL0F4bVeccdYcnruLW0TZsN4DujvqVUlW8qDkqh759dCcd
         WEmUYwvies2WYCq8n4xBUVJ1WsiNKYwdwzxXTdgFV3r0bQbVgNkw6bgCM+8Xm+9iqe3d
         NQE0XKAS7ozzF6il46ue8G3wLB0B/I4bqiJXOAIPW9Nwk0o+B7co3Y8yWxLAt7/Vqg0/
         MPnP+LUMDxd9m7PA/yCtlcQn7o95vQhyNjcSvJdFTGGORBBGFt/ZYRyUDdclwCCSKAuT
         sU1NfyFOXet3WiUXyw4oxEXsVWEmU93emWa/fycC098ZuZa9wB5VmzkR7/tncQ7aDWMS
         vNeQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqTTwrm8vhfuDFWUqd2wVP6Dnf8USFjOOI0jN1XT0I0MyfU+KTTfq9vGGm9ei01OO2NekYzN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfpfYjGZfDWL6PhVZ+FAcfEVwZn4EnM+VTXZHDJVwjX2EDQPUA
	9T+RDCaRrleADonqmE4w96gH4LxygLScflEwROCqfaWCH1n+NMNqc+93
X-Gm-Gg: AR+sD13rXq2oRX08d2av7b+zz0iUnJZXV1iszyZ1NNV8y9WxSNtqrEhirJYrnc4IIOJ
	jXNe1HnwH3p04meNDFg7lPGZqZgjMh6Lh0i93M847A0myVVfAvZifCck9AXtVCyRMzVxvC+OlcY
	w5Z6h+gRLgrx916tpN1aSBZ2TE5Ac5c9pboGXce4aJKP0ABXoXmId6Qgcj3+YJnsBm+7j6sdxXB
	YhkRxlrLEkkEOOEHf7zon3Wgg9MG11k8acXVtZdewKuynJ5xycIkwWtLGwoFZkW8S79pllkIrez
	f0UL7CYfNJydjVpxcUotGGP5YVTOa89/D3dnK4C9iD6s9910o8zEQUtX/zIyh+oAv106QDWMuTW
	Q9msBWJcYh13/mQHJf+z+JYeegw2x6sFWb7Vh0Fit/f7nAh3yEPpQvwmL1hlgRiukLdJ2slNZoq
	dVzdL+YFNsiyBtc7sIHsrnYwsbMq8b2b72QJGqJDK9OEcS0WNys0/ouMgkZziTotc=
X-Received: by 2002:a05:6a20:4321:b0:3c3:88a5:83e4 with SMTP id adf61e73a8af0-3cc71a2974cmr3124821637.10.1786681893513;
        Thu, 13 Aug 2026 21:31:33 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413889d914sm4450683c88.13.2026.08.13.21.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 21:31:33 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: sgarzare@redhat.com
Cc: stefanha@redhat.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vhost/vsock: keep IOTLB across feature updates
Date: Fri, 14 Aug 2026 12:31:21 +0800
Message-Id: <20260814043121.59610-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <an2RzeZ2zI8mWFRM@sgarzare-redhat>
References: <20260810134018.143973-1-physicalmtea@gmail.com>
 <20260810134018.143973-3-physicalmtea@gmail.com>
 <an2RzeZ2zI8mWFRM@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Do we need a Fixes tag here?

I overlooked the Fixes tag. Thanks for pointing that out. I will add:

Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")

> Do we need to do the same in vhost-net too?

Yes, vhost-net has the same IOTLB lifecycle issue. I previously posted a
separate patch for vhost-net:

https://lore.kernel.org/all/20260726141158.1652386-1-physicalmtea@gmail.com/

I will update that patch in the next version to use the common IOTLB
teardown handling for the ACCESS_PLATFORM transition, while retaining
the vhost-net-specific checks for IN_ORDER and other unsafe feature
changes.

Thanks,
Jia
