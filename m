Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E2123A562
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525383; cv=pass; b=WeMeZcsnqHbzfTlCvwOFBpgCX6K6tqF3AI7y5mD89cEUpMfFixqUKyXvMG7wVgHgiztyrLd+S2IYolcazdo7FjDXZqeqdTnVo4YUJD8hCS4tlZ+obmWQFj57VOkN04YrT1yFCf48W/iDohqc/iiJJY5FVoInCxqFhkIyNLQzY6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525383; c=relaxed/simple;
	bh=WcIdMprkeQHTVJFd/DxGg1QEGU26MxJmwLKQOA7imnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1oMR95Ii7EC90IFEdAy6NojnRrQQrNnQXo+v8vpCKokO5d89l8ZBVYEfeS4kqi7a3/C0IZzo9xJqXH/yFQaU0hqZ2tiJs0m/hhpE9y4+j5y2krRXqSrdo8tqbuP9Ww/cRQlv0iHBvWfS4vObnvp5oeaK6mKSYYdO4YyAUX1vuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFjaBIBJ; arc=pass smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFjaBIBJ"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7ec1e9d3359so977087a34.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:16:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785525381; cv=none;
        d=google.com; s=arc-20260327;
        b=Reo0HNvrnWi/4VvQoFQJSFOm42t8LwnzPmqamSvFGyCsliHkoL70QQDteBIiOi3K2f
         SvNJczc8SphELA9SsmrWEPmp6OuD04f/tEp9/4vNjsV9zkUfRWvFx7LF4Pnx25xYyQoK
         7UkKC4dq/ZAX3oXbN2Ndkc559uEp8V61CLL+o8q5G88LasjwCrPPc20ZqX06o/ZS2G8+
         av6YeIFiEEr7WHyyWDxXezCAQjcy0Gh1e69U6WE4ibvs8KFAOtk1sF7Pdq4046usXE0g
         uFvqgydFBE2PsKfRZgJBeKR4JAclHWbkSRMXOlvDjOfjLL9dWMFQj/g0Voc8E/05eHUf
         TrVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WcIdMprkeQHTVJFd/DxGg1QEGU26MxJmwLKQOA7imnQ=;
        fh=ftOzXZRU/69nA4hvYQOaA1m7bYEQPG6VYBNyoljwPxc=;
        b=jGxBAmr4viVBOEz7Eg3Pqeq0R30tRYiyqyHn9wF4gkKUozGK0GcchCiW21pvcDe0nI
         B/jcfsc5AW47J0cMTGv9rJ9EwXpZ3MyUBmCdIvXqZqkW5Ay3u21go+cTFV2P1ApvzKMW
         10waALiaVxHOvUQOsHEqBQIeYbytDLISzoEP7y8YovHYoAo51F0X1t0lic1Sty2co5yH
         YywQ7eZOIHECo9mzsE5LXFsZDdYZtxLqDardLC1Two2/ZE0JYn6aL10rO0MNzsrVkKO+
         UcBs++3ZWuom1F5PljCyxS5kGj1qfBCb47fnNK7jJwrhzafZ9O2ssKbmITRS/CSRJWxy
         mV6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785525381; x=1786130181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WcIdMprkeQHTVJFd/DxGg1QEGU26MxJmwLKQOA7imnQ=;
        b=iFjaBIBJ4bP0Y3gkhDmD0pibmjCZ3WJolfuFVWxJfuJRxAzhEC8qgk1oLamI6mThQ9
         zL4/+aqewYWjWhpcGZkRqDFfBvNp47heULyBOgrwKAAIfVxoGjVTNZegzU35jQD1WVg0
         tVDbURV8xCG0WLmMRASAnGVg/CIVcNZxZ36H34uJK85PbPsohHk61g0rInbSfeE5RMoV
         LzPbQi6Ml5i65XNd0Yy64Q3nsvk+Ksd1W7bUTZ7MYchkFtd0MjVN72ZIqdhb8iIKnY0F
         FN0eQVUiR+dw3b075Oq9rCatIg9TSrpF+FZr35V7/JG+kGClBm4YClMGFf7ZtbbWo3Rp
         CjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525381; x=1786130181;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WcIdMprkeQHTVJFd/DxGg1QEGU26MxJmwLKQOA7imnQ=;
        b=Ef6wB3/1/dCwctCYKUwzm8IPOHJ4ScdkVhO14Bn6o9Ciwa4YCfFuRgxH6vze6ndJ04
         cYKRnzwlCRDjRMfwO9I3r+t801AN5Is7qfLVQpZGnvwU9xkydqfAHZ7ZooL7DOWYKL4O
         al5xlL9T3ooWo78XXRDUsYCLVlxatBXAoPgDhrZt7AXyy8Dtdc0wZhqCMZ0ChPMiIsvY
         yQh41XZ+JePeOXf/ga8VVCdISgZRn1VV2DqCa38umwts1/LR4aoigqJCvIrA/xSlSGUb
         T1BBeA0vmgAx504bJu/fJS/wF9lDJ1q4MkJ+8Dn71dkCCkk3sa0eR7xkaRkxmGnj3yiU
         S5Yg==
X-Forwarded-Encrypted: i=1; AHgh+RoBGZPBLkzT55CpDW9d0XNCrFdr5HNjYis4NecDol6kJXzuFngV1gV5gxypWGt7X2bOtAngx5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Exp/Dnha6Hzi0n77znfylEaz42xrlSc8qSnP7NoxoVlrRZyT
	coy4YOmTEmMabaV+n/Eg24hkHi+bmC6+nO2I5Qh4Fx5gI2Erjn8XYe6HPCfczRLZc+4dQlzao1p
	TartFv7NnbELagIJFPTO2030yU1x9XwE=
X-Gm-Gg: AR+sD13LNYpBaZeXGF0jSlrm1whjRed1d1wEgh5tD2S/6lRA//8aMn1GW21n28zgaG4
	FpQkysIYzYnLsdeUtBfM+SlrzUg/J3uKZR8s1qaPwwHdHUfVFrnBKBtGFHU6JkWintdWQniu4L3
	j3J/7t0zAuM0Rt3bnB9gQXu4HWhedPFjq0HwMVzc7VFEYE1JXpoc6CIEJYDF+LoFQ4dKf6W9DQH
	0rCEzpmZvG8rXVZdCFIT279YMIrPjD1ToM4yl27XbowvShHK3y9MaK9y28d/LUXeWn5JlQ6AJKp
	wsniBM8PvHmp00acOdklGqbKVVX1Xk3IPqlQpTEUTWhxwVc=
X-Received: by 2002:a05:6830:349e:b0:7e6:f4a3:1df5 with SMTP id
 46e09a7af769-7f196c3f407mr1997239a34.1.1785525381080; Fri, 31 Jul 2026
 12:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amywpyZgGWyhzBjZ@hpe.com> <amyzGw1-MVLpNH-d@hpe.com>
In-Reply-To: <amyzGw1-MVLpNH-d@hpe.com>
From: Robin Holt <robinmholt@gmail.com>
Date: Fri, 31 Jul 2026 14:16:08 -0500
X-Gm-Features: AUfX_mxOliEzi-UvkmZ47zK6UHlImFjGFtYwHJvZHCLe82s6EGrd8o4SMO-P8OM
Message-ID: <CAPp3RGonT=s3ftHnPbmXKcxnsqr5M1x5+m7F8HvbsvsyxccGqg@mail.gmail.com>
Subject: Re: [PATCH 2/2] misc: sgi-gru: Remove SGI GRU driver
To: Dimitri Sivanich <sivanich@hpe.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steve Wahl <steve.wahl@hpe.com>, 
	"Anderson, Russ" <russ.anderson@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 9:37=E2=80=AFAM Dimitri Sivanich <sivanich@hpe.com>=
 wrote:
>
> Due to security concerns, remove the SGI GRU driver, which cannot be used
> on anything newer than the long time unsupported UV2 platform.
>
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>

Acked-By: Robin Holt <robinmholt@gmail.com>
