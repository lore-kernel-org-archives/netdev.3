Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE468441635
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785318854; cv=pass; b=kqqiTLeQQu+OC8Haz8oNtH9itUq2BRTJn4gouyE7EY4SePY1PIj3bkyj75FDmriWZxd4LB+zqp8qdJgX13YX0Hket0gRaTFEINGe698l2STtE1CqUSwA1Bgbe+iC/ll9+5Vhf8JH4G73KfZbyTVSV2aioN3P4kHI2ZqcfLAm0+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785318854; c=relaxed/simple;
	bh=rP7BjFvQ2F1S8qcl0M/g0VqSVGVgtmQW6//1T0K4nNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rsQ5BZcLoisYBA7seyzIFC1oWyLTv3gm2IWtqr12gWaIl5nBSvS4iHSrFmkXiCe9Vk32P9szZo7+mT8fPVvlghspRni1Pil/yGS/DbGOQov0iaVwFDwRKgY7VjwTkTU0nzgiwyaggk5YFBfYeseHSnRCt5nFy//QAVf/j6x70m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0dnYfuN; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0dnYfuN"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca53979f8e8so68169a12.2
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 02:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785318851; cv=none;
        d=google.com; s=arc-20260327;
        b=si7Yn2mUoZF5ai7la7LSAJjwV1UNtgUTUlJgM7C7LmoWyz33PM8DSmlmrmyVY4KkcQ
         xWAX+bsRmw/rLvknmCnkZ8+xBysQWB/yL2uIx/Qbr8aI67EFgYhtBQuL7YJCUHFEyMva
         PCu85JusNQl5BcTBSJMVHpe7bKV45mztyUgUtADGFFpSW6p1TjvLz54lZVeOqJ3d6b/m
         3HKyfhL4OFfoDCT88uGIz01NRCQVfXkl7uXCdv9WkXY8QGF3hK8O1EG2wi5efyoNQ0x3
         VelN/tfvbQy99MEdnwEYUcFQWKfSInq0SHQJ0fyzt7i2ztdQRSqg3wCV4b7O6h0yd6ze
         Oeww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rP7BjFvQ2F1S8qcl0M/g0VqSVGVgtmQW6//1T0K4nNg=;
        fh=9N7Kx+AZaW910UsrHRWZ2YmTlnfCjZPoR+Y9W9BOP+g=;
        b=paH0KhDKEQ6egUiGJivzip8wJcwG5lvGK1t/Y2O4QgVGPuM7ht7fpe01CIhzEc6igt
         SfKtKkvOpsMda09mgLvRackEvV8fYFqrGv3Amef7vMDehF8yRmvC/8gLbfkCcLlbaOem
         Egmm0cqiBqrbdJ/c31BHEb+pGL7+TAJ0e/gDK/HGyhmGFMUMwqUp4NZasrm/fEeHD4+s
         xdPZ+hLKfDNrnAZRsvP5tdeX+S2jK4kq9F0etakgpbqK+l43Qjl3OJAt1twb+SPKMPGh
         yhGQ4c5eDG9/PscdHiMXgoAmKyiPVnodbM/cJnVN+V/8UTJE5En1Ftsi/YA/TdjXWo+v
         jTyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785318851; x=1785923651; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rP7BjFvQ2F1S8qcl0M/g0VqSVGVgtmQW6//1T0K4nNg=;
        b=L0dnYfuNzOYQSr3J7VZVopp4qKSAi5nblaCELmd26htBYgoN7ldSHNKxrWAv2C6xuZ
         4C/UKWoUUhRe+dCyBhdqU9yePQ19vWIiw8fOeinAOCNe21z5KBkRdnJ0UXmR6Xq9lCiv
         dbJPZI4N4E2ZlFaJs53qNSONVP8u4j0uFA89BoUwSdOpl5XSGibTTWWQBQP+hxrfQuNQ
         b9OOUWkCq6o+Icz7vjTawW1rbxQglKT88yiK0fizHYonD57JY2NxNOvUxcbJhO5Xfynq
         ExSkA8ORgL9E79mtVMyOvDH6ikJfR4ry9WAPWxY9woP2cUOtAZ8Y4dK/7Mxpd1eugt2F
         k7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785318851; x=1785923651;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rP7BjFvQ2F1S8qcl0M/g0VqSVGVgtmQW6//1T0K4nNg=;
        b=G+uD11dTXk5onP4OM5ZwG6omPHeU6p3Qk7q8RUjUBR9cO1Zt5jvJcwIMQN+/5F2IXU
         W2YUCydy8XmtwW0nc9HrLEChW+V4Rkl/SDAMXsILeE5RRPyxCYw7xlHylIxtu86wYwVU
         sQ1eV8T+ecnCtLL9ul3PQV5j3TeI9KGi6qGuSTLVMkCk4yJA+lQnuT6udiF5t7E9yss0
         /X+E2JkpZKm9n1Wqalcl2vqYSjmzFhZlFvQC3XH6e8/saRh01GjiSUoNzEgYM+CI83Vk
         ifj7VCamTjRJ9oH0dtlMZBEJ6SxMWAolwacFBVIqAlgQuTGInWbMYMTIXayLdYQUM9CW
         q5Ng==
X-Gm-Message-State: AOJu0YzoQWJiq6PZ9XXcp6W4XqBJON4Y4an5FMLUKJgaNmZX0GoJC6Oe
	uN0I5/LROK4CUNoOGXPp8aEKBX7i7xvbVM3VekMJpPNG3TPofHdw6JhVPaXwgG5m1xxFAgLGFkT
	q0ocWYz+2RDDbWgDTOOL+6PZdxQLBaEw=
X-Gm-Gg: AR+sD11DuSfFtKJakOdzFZFLoYZq/yXgIg2kEdXLJ8dbH8drAkL3afYI7IwEjKTWNYM
	NRsbX1USXaiLfnkSy91MO0N68lz78KLyJZsWFjou2tpw4PvrPi7HUi6cwnt8ruiCrvgfv5ZaqYR
	bfY0IAE0Es1jYFv3TkzYr72/JYK+aRSIA3RLHJCj+ENJb3pob0QqNggUut4mNgbZawxXvNzGSqI
	HKwaYIHzwv0yagPmzHgvcaYXhMC5kC1WTIhNkHS0HAuvSPRTaNIcDmlm7boH7t9lXl4IPRvmOvE
	p6jDMXniQPhsvAvu++SqYNy2FFqo6OE/o71hN6DgAC2tYHwnH0b2uTt7Fs/z77GrEPJcEQPdIJZ
	nOzasOCii+2hEQI/DFQmnnIdUtZFG+LUaBBo=
X-Received: by 2002:a05:6a20:dd93:b0:3c8:e10b:7aa0 with SMTP id
 adf61e73a8af0-3c8e10ba35amr1946887637.4.1785318851492; Wed, 29 Jul 2026
 02:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729030122.21462-1-q.h.hack.winter@gmail.com>
 <20260729030122.21462-3-q.h.hack.winter@gmail.com> <willemdebruijn.kernel.36b6c7169b6c6@gmail.com>
In-Reply-To: <willemdebruijn.kernel.36b6c7169b6c6@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Wed, 29 Jul 2026 17:54:00 +0800
X-Gm-Features: AUfX_mxhkvmo3EEEhm9LRdfp5oOIoHFBG_U9ePZX4E9k50o-Kfi2gbetm8DrHvI
Message-ID: <CAH78Gvsoa72OU_5ChR0hboEPO13cGoEdVFDRmeNzmRZ_1gMtww@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] packet: use consistent hard_header_len in
 TX_RING send path
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, daniel.zahka@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

You are right, this reset is unnecessary. vnet_hdr_sz is fixed for
the entire loop. When it is nonzero, copylen is overwritten with the
current frame's vnet_hdr.hdr_len; otherwise hard_header_len is a
constant snapshot throughout the loop.

I will drop it in v5. Thanks.
