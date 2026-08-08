Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494D21256C
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786148524; cv=none; b=XYIz+CXC1Ii5m9bogUY7/B0Xre3q8QEMkKesUDRl5RMCpEjpHkcKXdLEMgdlri6C5bZ6Olr+q3kLHxvRfoBARlPG/yt7sPNnEGOxmRw8XdXsHxs6UuR6PFdNzksuTKOcyUUt+ersFVQlDIt4/1VapAgS1+FD40DAvA476lpuqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786148524; c=relaxed/simple;
	bh=L0/5AlrGOWEmLFb7LGHWfCrzS8DEh7JVlxIrpe8QtE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVGrLKHev0U+8v2XMIlu8xIZA6m/0ByhhC8CBohWX3EiU9D6m6GDY9f7lr6BD8BrkCBL5vhh+E5fcxUCsR78G5SHREWQCPB5+V+NyDElfg4ZzdKeNWLtK0GtoDhU8Ac+bjbXP7fDeRhoLd5hgh8xuhq9OJLl82YJX2McqBowWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=evalinux.com; spf=pass smtp.mailfrom=evalinux.com; dkim=pass (2048-bit key) header.d=evalinux.com header.i=@evalinux.com header.b=JDYzNazB; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=evalinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=evalinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=evalinux.com header.i=@evalinux.com header.b="JDYzNazB"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6ac83a09781so1428420eaf.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 17:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=evalinux.com; s=google; t=1786148522; x=1786753322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0/5AlrGOWEmLFb7LGHWfCrzS8DEh7JVlxIrpe8QtE4=;
        b=JDYzNazBGewZ/njruqpeRTMmbsO2Tc2QhU0ml+wlz/t2bk+TM62S9Gg0ySFgCY6A81
         az5zoTaXw+kwJ3EQPzX4UseQQsSIcqBIVQT/CZ+lqEXUd748zRCGoA+AA4HL5FCFLHYv
         rvsSQ2A7wd7LdT1qKmQYPUoOtGydbKkkkjtf1bVd6Qcmw2HtILNL25/lhZJ0xR9PYLje
         fqA1Hgq9qvg8FZEPq6b896QGNVRe32DbaIBMN+0N7vnQRtPWCR8H/zu+sKJM+E2Vxqz1
         qBgriCyTZy3PQZAbMAgiv8W8BgG5rrpH6DJLQaWKV0QRIoTeps3AALvMPydEqEzGvj5x
         R9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786148522; x=1786753322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0/5AlrGOWEmLFb7LGHWfCrzS8DEh7JVlxIrpe8QtE4=;
        b=LMOxBEZQmJ/3lTmHjUb11bUpCKs9fIUjR2zofcosfnOCeuxXPPteb8D+3JeHPFCUjK
         eAYFBqhPiyYYyZ3UlStgI8y+q9seeKCc0DF2Ceq5+vMaNdmEB30dau1Sj9LuYjQx8gId
         y/jXHdIHe5UE1ZCAS++KDB96pJc9vHueJ1mD37LyPNuYnmBMfc9uVkWkt/CNxDTxUa10
         a1BSUQN2cFCamMBrGzsW2yh0I11bI/WDWiGr0aZogEHzuUSkOYuVkU5By1QUo9/sBrf+
         vSY2JvDfyDW5O9fIr5qptpAIO4CafRh2J9G4x0uMW28hNMdBDDjViBFk0YBfL4+oEqn/
         zRyw==
X-Gm-Message-State: AOJu0Yx2eJuS81p6hEtEBILkzfQ0dagjaY0YkfXUf9CaaLdNDNRk+VGp
	ra88c0gVku3K/kSsrt9LbuoPm5P3Q8wHEAQ2lEj1MiHdAwQx2wLYmiwzX0MxYVEWQzEJHtWxKQu
	QSclM6xRJOw==
X-Gm-Gg: AR+sD12z12YjjxToft23afzto2WcSxr0mmEGvNOIFdgAoTjs6rFg6yqf3mqx9vzDxrI
	gSINtHWi7TzcxBcrgSgDknYOycF0kA3KhAkvAaeb1wvOcDJ+EbJHIrvw7ykXsxITbmIKYmg6b0R
	ZD3z9gkuQpC2pwBkmiUDRUTE590XYYUmQgNFG1IprXu0iMJILyM7W/whrOWyMWplLM+ErjvuRXC
	y4L8oIV2csO700RawofEbskzVW0PTVDCna3JijO6o3pD9Sj8TKCNmVqNlS1A+qHoTcCz/dNnf3v
	GHmmPrTRrHpViosPc3mXupYHfqgelpTEiDa0MtqpbbnGenM2DGPf6ka3XpAIIw2pe2ZQjADQ2NY
	dp9jnXwKqDFL6K8pCOFvYJf7rekBhZ/kqmfEAe02S2deAw0aIAom0eOcOwGJCdfsLSg/PyHUFGz
	8t4svCl9cEMIL3QANyx0sTM66aPOQRQ2hPhvrcGKjAxbEpDQsHZWdcxcpPneI55yAyRTdyrDwYK
	UqjbNbeJ+NpCo5R3DsEXXDSn9J8WOq6WA==
X-Received: by 2002:a05:6820:161f:b0:6a1:7c3e:f62a with SMTP id 006d021491bc7-6b04500510dmr1376885eaf.12.1786148522326;
        Fri, 07 Aug 2026 17:22:02 -0700 (PDT)
Received: from desktop.casa.g02.org ([2001:470:1f0f:2e4:14ce:9fa2:a97a:cd20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bc7f3d1sm3679764eaf.8.2026.08.07.17.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:22:01 -0700 (PDT)
From: =?UTF-8?q?R=C3=A9nich=20Bon=20=C4=86iri=C4=87?= <renich@evalinux.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org,
	Joshua Washington <joshwash@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	=?UTF-8?q?R=C3=A9nich=20Bon=20=C4=86iri=C4=87?= <renich@evalinux.com>
Subject: Re: [PATCH net] gve: use gve_schedule_reset() on AdminQ flow rule timeout
Date: Fri,  7 Aug 2026 18:21:59 -0600
Message-ID: <20260808002159.2076241-1-renich@evalinux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAB2Dq3r_e3hS+f7n9d_mJ4Kx5pL1vW4z@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue #93 on GitHub was opened for the CentOS Stream 10 gve_add_napi deadlock, which MR !3007 addresses. The link was included in v1 in error.

However, gve_adminq_configure_flow_rule() calling gve_reset(priv, true) synchronously on AdminQ timeout remains an AB-BA lock inversion bug under ethtool/netlink callbacks.

I have posted [PATCH net v2] with the GitHub link removed, the Fixes tag updated to 57718b60df9b ("gve: Add flow steering adminq commands"), and Przemek Kitszel's Reviewed-by tag added.
