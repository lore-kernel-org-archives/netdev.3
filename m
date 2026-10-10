Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113237A83D
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791670455; cv=pass; b=Br8NkjHFoIBO9FjuHv9cQmCQwzz1FpdF3fv+JN7FaZ8qq6ZEX+ndaJEhHtBagi/ugKC5OQiyo459IPi4nqSmy8ZBcqfyWdU87GeHXda0djs7Tlfc7MF3/6vkcddW1oHPmVtffeDfLQ1laLf94atKCCuZ1b6a2+NvRKugKPsCNZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791670455; c=relaxed/simple;
	bh=CBxiUJ5zCN5x3bulAKsga+lnv9YLj+R4wsUCpY3zfcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5lUTp8L/n7avbIMHhModkRSxaEw+ZIC2AYpAYuP5Jzp09FkqapTnxqOcwKW1g4mwC4FxOVx58qgjTe0QM2OtJ0T1QaEU8QT2mYtJPJlxNz3BcdTtSSQL9JFlhffzOcKF2jJDUM4X5W2+aqhfI2cu2alxDkTX5IuxjCJ6k9Z3Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LMJDMsK3; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LMJDMsK3"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-677bf06de21so500262d50.3
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 15:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791670453; cv=none;
        d=google.com; s=arc-20260327;
        b=eagZJvkxhCaptUrKm9+fHLhhnzbGfIidWc0xTbLriYbUVizC015l8dHbS0Qw8aSMLk
         1JimxkYGXN8F8Dr+pE08gJEiUt5TPWDp3uVVQNtdZ5FbrTBIOVu5Su3XGZckwyJGJ3mz
         hHbgMVwCuYXNUBsDyJIpoBmmIAmBKgN0EZ7NH2MBCT2ytY0YoZtb4pZMfjAwhM4SKgm4
         gAWAgY1w5aSHn7Ly7suRyot2Ch8RyEqMahaCQuPTVhvzyROaqY3S7tkbZMCF4DTV3fOI
         i+dkxP8YbFeFyuayEydPP+64EvYJ+M77PvyZBRaSFD/p67BPi+Ml4+qyNQsrRc3r5ZlZ
         Piyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zVgQ1vCIGkE4+/FMfnHlA+BYK3hVjeRnxeI7/qrvVC0=;
        fh=ufjfCGtDDZ7ff5cknuoei1xUj1uR3miKDtx088wcK+c=;
        b=PRYGcdk4jj/DKTH9jsl5WPjSDtXQa+mVipJKNMOgrblm0aphWYMUvMiuNM4nnOWrWC
         zoJLJTKdjIgM2icO5DHgW1YWAvUTx1dfhThjn8JnRQ0+MylMp4wV+moBt1awemD3DCMU
         mYMsr9RO3GcDF3h1zpZFCnmDQ2JXZbYVdWIgNuTInjDZrfCmq/TpGY+UdVAlf597/0W8
         yhzYLzKiojMVWElv8wyLj/80ag05UopwjDpHPQcK+D4Kl5OjQWHwLOfPrD5Dv4VbJDlR
         39Eq8vZk54MH14PDvGoDbB/6unCUwVGUPIBvL3lIRyXIq2RFVRS8iM4WjeBDHayewOG4
         vAcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1791670453; x=1792275253; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zVgQ1vCIGkE4+/FMfnHlA+BYK3hVjeRnxeI7/qrvVC0=;
        b=LMJDMsK3242JizWdooZ9/eHhzyuX3Ai2xdG4ZnIknTQuUyKJuboJyIIhzPlolYIjZm
         I0UXMG2rmCsMMMAyzXwgLbUvjuH4Ei9dUQFr7T0vdnRv2xwzZXZlw+xx0YFyYPh0iGqo
         vePTnFi++VpqeVW1y+l64pdfF4t5R/nC0Ry92eyL3BHP9ULB9hyGCCgyiwgXQm6Q9KSN
         99NgUEMW3ke8b+ZaN0apnZPoEtO3pS3VItx6Rchy4KUCD9OWO2oUduq+3OEnA1vHqFxa
         AvgDgZ9ULBHgtnB52ovIxiNuTVWfSKJ+bFeqpSmTsZqD8nyknnIcVKfzmAx3fllieLBP
         XvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791670453; x=1792275253;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zVgQ1vCIGkE4+/FMfnHlA+BYK3hVjeRnxeI7/qrvVC0=;
        b=Pccx1ZnEYRuw1SQlLvESoqrf/XU0cg8qleS/GhzVWdWz0VzZbzD5oANi60mifIY5Ws
         n9mJiY4L65fMjfLCuXE1sqZ025gt8i6A6JORA5R8X6q53NXTzVXXvZ9Pf0wgF7gG5mhY
         57IjW+QZ9jHScY2OgWNSjyY4z1mOGK8HxZYSvXkhYN3vOkRSas8cRxHu4nZJMHBrX0m+
         23388QDQba5U8Cad6eXYpZd1RXn57CcD8LanSXhkDT91bpuU9DQ8RVX1IMDrfRV0Au8D
         qsQxir/hxD4xjQCL02LEaSEO72O1o/Y9Mkyadl4zRvVzkufig6mfUxWekYWgOsUV1nA/
         2H3A==
X-Forwarded-Encrypted: i=1; AKwUvBygHuQbFTeCwkBS9zWSNxHRpMvqUihie3GCb7RSnE/5MX6Y4XDgNu0FnZLw6opR05/i1Fr89b4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlOk7bguqXgH8qW3XzPHfkKeMYHkswu6vXkaN+2mbe4AMLeMcL
	Jbg02u3+pXv0f/5owUwyJIJ3WAQ4sQNsgqPa4FHf1ibjQJuxohQacq2m7XiL7+NkWVrBdv3Fuj8
	qXp/T2r21KMk4hKO7BbKId1q7t4SKiH0=
X-Gm-Gg: AYBFou0wQcdLZE5eS7HFi6iIlElLStGAgwrFXMzEWTPw9HgevGShCcbIhClFhYMEpCW
	w7Ubftf6UXRjKlBVLtzsi2bCJgf/DtWbRx2udnfCaOvapezucolVHw9dHnWdWx/pVyBE3HWVtzO
	fPa3f30Bh4ocdtHZQPAQHJgGfKu62DS4osaFAis6OieFEOpHIBYo3Q7v8IP25x0a8mlVmFrKi82
	vpuGdqyf3JrE2f4RWUJ1H4gSaDA1oXwyQnXP7GVWa0WkhDAH5JNOZD0Qv7KC/YpMvkX/3AxdHcg
	Cel3zXHGpUBcKvtGfxuDX8r5iWWZg4MWVF07RkRtGp5icbcmz2LadaQvLgP0jtAKIWm3eSSb3Zy
	Huoe4sAUXXR54
X-Received: by 2002:a05:690e:803:20b0:676:9240:d69c with SMTP id
 956f58d0204a3-67936275489mr1125092d50.91.1791670453112; Sat, 10 Oct 2026
 15:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010105900.247342-1-tanure@linux.com> <20261010105900.247342-3-tanure@linux.com>
In-Reply-To: <20261010105900.247342-3-tanure@linux.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 11 Oct 2026 00:14:02 +0200
X-Gm-Features: AclHuK8gB-tkTlpSxcPTOLR3EaTkCZhRdAGo-iA2p3YlqPx-9RYK-GDsrGLBxVo
Message-ID: <CAFBinCA7rPu0obv+2aadxqkzMYKmd1+DLJgRe6y418v0QrwSSg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
To: Lucas Tanure <tanure@linux.com>
Cc: xianwei.zhao@amlogic.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On Sat, Oct 10, 2026 at 12:59=E2=80=AFPM Lucas Tanure <tanure@linux.com> wr=
ote:
[...]
> +        # The TX delay is a quarter of the RGMII clock period per step,
> +        # which is 2ns at 1Gbit/s.
> +        tx-internal-delay-ps:
> +          enum: [0, 2000, 4000, 6000]
> +          default: 0
Is 0 a valid value? Let's say we have:
    phy-mode =3D "rgmii-id";
    tx-internal-delay-ps =3D <0>
    rx-internal-delay-ps =3D <0>;
According to patch 8 this means: MAC is responsible for adding the
delays - but it doesn't add any delays.
I'm not sure if this patch (removing 0 from the enum) or patch 8 need updat=
ing.


Best regards,
Martin
