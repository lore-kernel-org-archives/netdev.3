Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D98E2F3C0E
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781425359; cv=none; b=kq4PZVcy+zFMI/an8gczD+Aqb/vEluyJF+m3DiYjmR/PYCSsyXEFZ4Vu+k/60Sk1RPd050i1aWBA8bF9/Tcanskx6KFT0+YjCwr/9+qQfdnFfT1gh37GAFrnqaUydcZ0v3JEEPFTmFZ2C2rtyy2Cr53mbcixjo6BgNjh45KmMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781425359; c=relaxed/simple;
	bh=qb21hqb1S7YZ5BeL08StiBkLAbTGYCv15aAj6D/zaWI=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References; b=Tv2OydxzRu2r/y0b6HNHwoNR2e7xkAz5vZL+x/zR6t2r13G5Fqubl0C06SOCKLI9CkZKUKdrFxKyMfNWwVSTOkAdbu0Unw1g2+3qN2+fh9ySAVT33jmqnRSiIHaQYnczKKmu4Tys59mTh2MgF+sun0wOoOS7d53GNKtbTf9bmWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnzdlwBn; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnzdlwBn"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c3315c5dso25243215ad.3
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 01:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781425356; x=1782030156; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb21hqb1S7YZ5BeL08StiBkLAbTGYCv15aAj6D/zaWI=;
        b=CnzdlwBnp8QscPBXMTa9wQYuWIn8m4BeoEzE7nt8UDMisra/xQXDkW69hOHPggX6u9
         Z9MRwBb6VMhG+H9aJOc/KtVBJ4W6k3mtgNsRutWaGOFUPdypdx9il6TJNvqBaNorT5NV
         7DdT7XuOreua7B6IuOkQ09lADlqS3v8f/gc79IDpjnJMElHQLcYWIoa98imHR4TbONO+
         G29IzdgBA9HHtkLxFOvOUqnQKlsVFVpNREVHWHkyeOv5vIvnd5E/UI4x0DBIBa7+OazJ
         s6+wE6EsT2hrX1wlJeU9ch9llpNFZwSF0ksUIUQNF/YF9YXpdBDlpwXAtRtBJtM+360f
         L/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781425356; x=1782030156;
        h=references:in-reply-to:message-id:date:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qb21hqb1S7YZ5BeL08StiBkLAbTGYCv15aAj6D/zaWI=;
        b=YpouxBScZzPqb/zOz9DE8If0WnE7+17WpB90vdrcwawHXTH0dbvLKhIALi/eZUSIGJ
         uIMtNH7EzxgZwJSuRhnlBIlyzYhDmKXqBerAgLjmHYCe8sRMjAaSIQ4znX481mcxMb3w
         lXyDCftRcSOXK5zKTRYDDTUmSmsDOZZiSWRSVptEqoKuQxcqvAfKHjwFGN5hA7MXYeGS
         dbvz627J5PcfIJHvQU54XifMPdJgyOGefc6LEiOJeHG9W1aWScYEBDF5R87Eyi/sy1mJ
         VxQfMKCdoNtU7MyEh7R01Loat4zrEJv5N26C8fssIx7gLhG/2viFxEbUadL1YPvX8BBa
         xoiQ==
X-Gm-Message-State: AOJu0Yz2mQvAy0WhJtC0kKlur4Ph756uYvfTLbetSChmMR75kImBQBg5
	iZW1lHvH0h2Q8LLD83zv6wkcgu4UyAJxjJamRQFkf5VtYx7swGY57mIh9GSywNsuCUI=
X-Gm-Gg: Acq92OGKIu+9sjHAm5N8jdPgeizx23O54xJI10IccouwFo05vcwCNEC29LgurqiJYeW
	Pvbsu6JbfywaMi9eAQPd6imPjY5MOtSR3RBDQgNKkyDs9d4JmOqj085lEUp+W3yP3Q5kSZVj0di
	VZ24tftf6w46WJLXRCEP9wg3h+ZyaREu4EyMnrpsZukiJhQqY+AyvBvjp0ej5jOCdMfQOAa99f+
	axnefnBtZUbzxngwixL0LaUbioGL8vwgKEWXcRPX+HF/W274mbaTB1A4Mzd/SOwdGFXqFm+iFok
	wljT22BqwCKCB57FnRXap+n3wGeaRgO2Opyx7hxgh8tu8uvhSEO5SONufGhb5b3gjuY3nbQfHTE
	pBcxxX54qww+aWZn/S+6gfjGufWyBtvXB1x2x2aJFyEsAQyaiKgplaHskMH44Km/JoqwcbLjSdR
	0cnXkNGhMx1PXUWqhU
X-Received: by 2002:a17:902:f78a:b0:2c0:ab82:6ba7 with SMTP id d9443c01a7336-2c412840b4cmr130549805ad.33.1781425356220;
        Sun, 14 Jun 2026 01:22:36 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327aca9dsm67318685ad.50.2026.06.14.01.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 01:22:35 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: net: airoha: Remove dead MT7996 NPU firmware declarations
From: win847@gmail.com
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org
Date: Sun, 14 Jun 2026 16:22:32 +0800
Message-ID: <178142535221.1923709.6145590590751458758@gmail.com>
In-Reply-To: <6a2dea77.01c4f138.336eeb.a256@mx.google.com>
References: <6a2dea77.01c4f138.336eeb.a256@mx.google.com>

Thank you for the clarification, Lorenzo.

You're right - I missed the DTS-based firmware loading mechanism
introduced in commit 3847173525e30. The MODULE_FIRMWARE() macros
are indeed used to notify userspace for firmware loading, and the
firmware names are defined via DTS for different board configurations.

I'll drop this patch.

Regards,
Wayen
