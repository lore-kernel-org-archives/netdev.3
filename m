Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5203C1404
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849202; cv=none; b=dTif43EK+SVnX8eU4mkIXu1YSE0fQX8czvRVzbCVmKf/JIrJldTZmM8J/1K7aSc8XflLYRywfG1CiMAWR/SXv2E6S+SCyVZRUq2Dl1EJQvoTlCw3GBmiddpMS/13pUiD3PLcQ0yy5krc5Z+iXY8b0/yFNBNSzAQ277tcPwhymq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849202; c=relaxed/simple;
	bh=jqGw01x33DhS5aeU49v/Mka+0a7do3a5KwJhwuhUuqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIHSK80nYXqhItiCOsBh/Gnzw5LTrxpspozcO5mLgTy7YvHi0nvOIOtPe2KLZucniHCf0eqPKsSQLZtIJCTJAD/v2weXtDoQi3O+I+7b+HMScVMO2aOs7/N4aBj2aWPUWqV/iiQt6fJjJYrk/72QeV4iFy0gqJepIQUTto6Kpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmrQvy9G; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmrQvy9G"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so3231329f8f.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 02:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776849199; x=1777453999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/otYovZDuesUe7jQPZmu+0R6E/qDznQJDykppq+S9E4=;
        b=cmrQvy9GsZpTehdjrKDddZ/pZ0/clv1D4ygYn3LOPsF7tkqfbHyX7AI+wYczsi2Ulx
         2hQ25QhoW7WVoYX8WCUDAIGiv+eQxOz4rqYo2IC+mtk5n/Ry/HgtFBtSeWPR6kTrRvgO
         a6ravUPCMXsQKUuXGgkFB56UBzDeixp4zfsSdOJgFcgTv/590a9sMUzpUDEBiyoqo8Im
         nBc7/PWHHCAp0dUzJrZQ3ITKSmOOLMtSCL8ZQgHgnw8BEYtml91IUcDHg7f48pzf6ddB
         hExCDHc4FApOLgzpTa2HGYq21E0vW8nr0RbUJvp2w3ufDh7ogg5ZfI7OV9xYCiCVkqrA
         /Gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776849199; x=1777453999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/otYovZDuesUe7jQPZmu+0R6E/qDznQJDykppq+S9E4=;
        b=GDTsdtJ/P/EYDAiqPIASt+oN35DIgel+RzAsL8RwpGtyVYWt+HL25/KavVftAsM4Ej
         xqOmtjws1VVBHPdL3Cw26JSrxs7T/vpJcib/mxtNH6aTlgDtHtttNsTP9mEkEm9Fau/L
         pFpb0LhR5P+/paRhS0ZSV6/P1lty5hv7E6ZO00CPFQs2GK36m3JWY9bY68aPTBs9MZ1L
         PEv/kSeZd6yOz7ZKYIN6P3VYpuT4/QdikQ/h0fHLj4d5GEKSomiK73lpjst4LFdQV95P
         56RfkOzukpfjtmiSwYCJIgsUxah2dFOPMJMeSyOfvdUVCcfPLTvxthAIuILq5Ytbp7in
         rZLw==
X-Forwarded-Encrypted: i=1; AFNElJ+W8u+X+89KdXRGfxNMm5us1zOmEdJyolONyICNpRSTIFjid9cr3ck/4WJVSMlGItoV5oSSZB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuQNeJdh51ibQG48wDlLbHq7AOkUkllR3N4aHluv+k4a4yMKI2
	gjJmODBM+CjsF3wua5mQYRtXFRe2Wjef8w2+BIVdgUk1ALK5Z178ryEw
X-Gm-Gg: AeBDieswBXDVQReMS6EYOCJBVv/WllVJ6yl9wvpQJzt2G2fcWawDhNmrm+W8EkDHRt6
	FojcI6n3Ydx/8PM7ZdJvpVCbb+4EYV74Ec0g9FLccdV4sPkI4ZNVZ/hVUZu8NyIH5p6r5O+yzFH
	Q/uVGqVYgu/GiMNH/VOLquRkKYLlw3Bv+/iQfdr6Aza02IhS4C2QGqkCKW5V56kd6fV0jaQA+ZI
	yVJrjZMB5mt52E6boSyW7aNbACJnBGvLMntKE/zITr1MO0trShEU2SW4AV0y4r1AZYgQBsH2ANO
	PMUttROtBhxeTvYxIg53c/UDy9wBt4dbQVWF6b0yH3zJrOmq6hUkqBlBoMz2dnfxYZqWJBsT0ba
	tiWlhF5hEkJYF4XB78uMyuu21A3JwO1TdKRVc2k4vA1ABGIK1wetNLGUVj6pmxU0x8XxELC5VJs
	4uDwpeZRJJPhapWiyqaGj8XCEQdBN3q3novPqvpq6pCVRYUeXeN9b2CSI5jntTdOJwm5Veq+Nez
	aGa5Kq9CwK5EA==
X-Received: by 2002:a05:6000:2085:b0:43c:fe66:43ec with SMTP id ffacd0b85a97d-43fe3dcbed7mr33744158f8f.14.1776849199309;
        Wed, 22 Apr 2026 02:13:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm48660815f8f.29.2026.04.22.02.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:13:18 -0700 (PDT)
Date: Wed, 22 Apr 2026 10:13:16 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
Message-ID: <20260422101316.0efdcf24@pumpkin>
In-Reply-To: <CAFr9PXn1ixyhD42OswoyGZ=W-O-oZygUGpRNm2dcAuYBNgtmQw@mail.gmail.com>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
	<CAFr9PXn1ixyhD42OswoyGZ=W-O-oZygUGpRNm2dcAuYBNgtmQw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 07:03:19 +0900
Daniel Palmer <daniel@0x0f.com> wrote:

...
> Maybe we could add a special thing in the maintainers for "this is
> code only crazy people use" and have a rule to ignore untested AI
> generated patches for it? :)

Is marking them EXPERT or BROKEN enough?
(Or a similar new option.)

	David
