Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138E471CED
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785937355; cv=none; b=ZB/yhKgz7YWI+AKbMmZGHPSXFUqEt8HDZwnWqhj/qv2hNRp1eGGY1SdYclY+Svi/td6VLYiRqFksYafIL3vJFXipB/GEI7TDYkQT8biUiPprUk/+So4E0Zu09n8HOwAtxnELUtmWVpFJWIED4wvkOwWyjnpds4Gh6MmqYnSGQEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785937355; c=relaxed/simple;
	bh=RVTieBkl5PxGC5DHHDci1txVVRWbP0oOgHybHdzRmuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uZBwOtGnrUxyR6neVDAgqQNGzWkun2y0w9zqrJkji2bChngL99LlS9MCOjICr7aD+sUki3qQq9TEfw27lTRtYkxvBwXDnnMdSlb0Ayqy8h0hSl5jnv2yigXiy+GgLHeUaZrrckZxfbQjpUdnryvyMKgHYALW1+jQcFHOIlwIcy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7P7BR6u; arc=none smtp.client-ip=209.85.217.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--thaisonphan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7P7BR6u"
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-737d34a0dc8so734064137.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 06:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785937353; x=1786542153; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RVTieBkl5PxGC5DHHDci1txVVRWbP0oOgHybHdzRmuI=;
        b=n7P7BR6uMe0+DqmPLTg5ilHU6VLkDL9N9xNnjT2G3t2L2xtmk80VA7vcofX7bgU7ZV
         c+QJkmsP53oqWWes3Ew+ILnmU/fN1weTlTpe7Gr3opHN/HVje2tf7t0Ov18dvVdLDvbu
         rJOmxc/6kSphy1oOAHC8146fvN8k07mJ31bAH0E/W31Yxigt1QjjF8m3S1nbdJ3QpR8G
         yJvSymLCn73HM7N49nm0YOHYgJafsF/NEl89zWMvc7hkN/8gLas0PZBkaKGovBUMsyGY
         +86CbugW4maVKldVOemzJLuxZLiJ66y5DUNX6S7qr8PGxzYIO8RW9v2eoCt6zTyd1EdE
         3HFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785937353; x=1786542153;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVTieBkl5PxGC5DHHDci1txVVRWbP0oOgHybHdzRmuI=;
        b=chs3W/FNx4FxAO1bXTciqJWq0o/TiKv0haJSiJqKttNJXKhX6Ci8YAmnugjY62jVOm
         cSIHgcz1+Ud/itVSMgQiWaabiqs2FVlh8J7+7n5rgFvD8xAZpifMY1M0P4IUkZLmUwZ/
         d/2zPosG3uA0+qm9ZWZCyMYyA91yyNzWVSrTEwD6vhJBdacFFmAvZujCQM2xzF623ZJn
         e/1xYOrMA4hpcY9BiefXrmSRdjDGdmUZr8osF2FPhAkmFUJIiiFdzcPKP+mGUcSVTB1T
         FpsAGb24021/+tyE2dbxDhNHb+qG3pc3RNUKn5XbOrHdmXZ95E1Yr7WDXYeQq+BTuScT
         //xA==
X-Forwarded-Encrypted: i=1; AHgh+RrvwXuzZaELEDnHWCLj9IkXceHZ4pTZ9GJIbtmeQpoY/4j8NrR/e9/fEgmHWkHJ77r+e/3/48Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmLNSRYcz9kLlmR/rtxCSdGn+Bow7E5qKCJXhaup2XldPLVKm4
	oFE7/Kopm6J3n1El2RYKeNAdHdO5aC8bUVvasxaGR9SLfWK8htgoVFl9KJ7vE25qaCDgBki8hbX
	3rQIz6xMEtzCTXm81HAPLo0+s3w==
X-Received: from uabdu25.prod.google.com ([2002:a05:6130:2819:b0:977:cd2d:d150])
 (user=thaisonphan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:f8a:b0:738:1ef6:51b9 with SMTP id ada2fe7eead31-760e80f94ebmr1897347137.5.1785937352795;
 Wed, 05 Aug 2026 06:42:32 -0700 (PDT)
Date: Wed,  5 Aug 2026 13:42:32 +0000
In-Reply-To: <20260804143359.702b0237@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804143359.702b0237@kernel.org>
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260805134232.3378922-1-thaisonphan@google.com>
Subject: Re: [PATCH net-next 2/2] tools: ynl: check alloc fails in generated code
From: Thaison Phan <thaisonphan@google.com>
To: kuba@kernel.org
Cc: ast@fiberby.net, davem@davemloft.net, donald.hunter@gmail.com, 
	edumazet@google.com, gfengyuan@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, matttbe@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stani@google.com, thaisonphan@google.com
Content-Type: text/plain; charset="UTF-8"

> Silently eating errors in setters does not seem great, better to crash
> and make it clear than things are not working than have a silently
> misconfigured system?

I was thinking that the user could check for NULL in the struct field that
the setter was allocating for to see if something went wrong, but that is
probably not ideal either since a user might assume with the void return
there can be no errors, and I didn't realize the field is not guaranteed to
be NULL when it is passed in.

> AI also points out that setters are preceded by a free (in case we're
> replacing existing attr, multiple sets on a single attr are allowed) So
> if alloc fails we'll end up with NULL ptr and len from previous
> allocation.

That makes sense, so we could have an unreported free() on the key someone
using the setter might think is still allocated. We could maybe delay the
free() until after the malloc() works, and maybe we could return an error
code in setters that allocate to let users know something went wrong.

> Maybe tackle the setters in a separate patch, and keep patch 2 scoped
> to the easier case?

That sounds like a good idea to me. I'll make v2 only tackle the getters
and look into a different way to handle the setters.

Thanks,
Thaison
