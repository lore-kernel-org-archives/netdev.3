Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674181;
	b=knFXjlACfh2BTfyWTi1nk8gV5ZpXNWtLIwFDVA6cYIkuOpjfUeyfrNTAgUxOFMmu+31o
	 zjbfcgnHelaTa+AhonBeirtBX+eSeM6Jjyu3nP682HXPaHXkpWnaEOO6+nSU1joDyWTSF
	 bSN8AMMK3O3YR6DiUHijiw8kR1rGNTCkYGdA1JznuzO1wvyFOh1DdHKt/Wg7PiUeEDxhq
	 l9iryoRKhGtlAsWzuyp1Rj8FpU+YC26A1SldtmwSOd1H3+e4UmiNwLwUDjiw3+ugnhQB4
	 PMpih0nsFAQGvl12eb51YOWHNqBJ73AhCthv//zApA4e8UBv+EipQeTGvtR9tSeln6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:In-Reply-To:Mime-Version:References:
	 Message-ID:Date:Subject:From:To:Cc:Content-Type;
	bh=G5Tsk3ByfWYIOghSMBuXaEzf0w6RDj7ianNmQih0uC0=;
	b=ZbnsM3cmmfQvrULyShLDIF/fUauna8GmWtlErHyOXPekhlKjD//khljHNpuJIs7c3sGm
	 78ghuRgL+CsiELWccYGReKigksuqp+25U+wVvZbbCe+KOOFSX/tmQaC1vx9IAn7pfszk0
	 C2c4xLiAVVXSPCucSgJndnHSNjtQvnCzA01VJZL9FBFm3R56QDL6dTF1FFJHiJc5/DiDj
	 DQsrhcQ3Ucw6wRgbEtdbHORqmFzLkUkV8GXJnw9X7EvaGhddzyjpYCXzCxrCnnF6iwhGq
	 yNYIHAdMoi71HmUhCvowK/1g4ITjQY4yDdNDah/2H6g7/Q7HZzlatsvPQ4Bp3/4XIRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h5l8Kd+2;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27749606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27749606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h5l8Kd+2
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35c3c370b17so6247684eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793674180; x=1794278980; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G5Tsk3ByfWYIOghSMBuXaEzf0w6RDj7ianNmQih0uC0=;
        b=h5l8Kd+2+0yiqwG9XsS4x5KUTiSK7qDdyu/sZAJDT7sNjMfZai1vYNUGFRVpOliP0M
         klYZb/sEHLC6MLv0zAiGyfqn1NELOWnqepXXiElEUZqAGXBXP+ZNs2LmuBwUeWc2c4QG
         PiSnCR3feWrjirfvdIl3WYsMJW2pFLmQj985U26psW0iZsFs6a4EOhtfu6UslP7FnSfQ
         pmEdhqouz2WE7jbc/YuPvGW0o1wUfmTZaGaY0Hesezvf7VUCkrbm8OWNJFYSazW8g10w
         WD9Suano5pMZK3+7PcqGv9TRNppXr+sMdT/0E5fAP6c+nkvLGT1t+nz0TlJVO8noDcYl
         aOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674180; x=1794278980;
        h=content-type:cc:to:from:subject:date:message-id:references
         :mime-version:in-reply-to:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5Tsk3ByfWYIOghSMBuXaEzf0w6RDj7ianNmQih0uC0=;
        b=YC1maecZyxRJQIUTeZoJbVpQTpuH7yXPUKbnOgMW6YrmXM5CXRg0XZJufrDctt6pXM
         YuOEKCj2B+HH2miCp18chYMta0BDtzHaI8W6G+S2cnVK3zWtjb3NrYamWG3UBmPTV6sB
         1w3+9fINy1nDNsrWT4rB6eEqaOHNqcB63b9M48fA32L3b8nP3BAwR7kxQFe0taVM/Jzo
         iPzN7PqArnjwXFAGwzBn1vI7PfiftxzKqe8kEPbuC66vZ2/CKtqACTL7J8Okkb5x4w+k
         gPjRNBRbZuMxUioea6SJ2M/j5x2Zg1O1Cp7Fu22jjpDbDKOStf1WnA9NvYgKye9Sig2c
         8IVA==
X-Gm-Message-State: AFq9FYL9ivz9O6x73bmGjpg+VGvBEmSeuO5kHhVIiitbtxQyuWDxtBwR
	ZDpAJM9CR3rWpRnaFzcdPAMOjTpehYwFBS6FPHolfjBykehuv/AUEUofi0pHmAC/Agwp0FWoQgY
	kXwtQ/TJy3kR9rfNWhgDykT07Tg==
X-Received: from dldyr5-n1.prod.google.com ([2002:a05:701b:4505:10b0:143:7311:4b88])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2094:20b0:187:efba:9ba2 with SMTP id a92af1059eb24-1ac5e8e1decmr18531952c88.44.1793674179760;
 Mon, 02 Nov 2026 18:49:39 -0800 (PST)
In-Reply-To: <20261031162804.1893-2-maciek@machnikowski.net>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261031162804.1893-1-maciek@machnikowski.net> <20261031162804.1893-2-maciek@machnikowski.net>
Message-ID: <18e46929c704a74d.3137322e32382e36372e3935.158c8d.0000sendgmr@google.com>
Date: Tue, 03 Nov 2026 02:49:39 +0000
Subject: Re: [PATCH v11 net-next 1/3] ptp_mock: Expose ptp_clock_info to
 external drivers
From: Mina Almasry <almasrymina@google.com>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, richardcochran@gmail.com, 
	milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch, 
	vadim.fedorenko@linux.dev, horms@kernel.org, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, Oct 31, 2026 at 9:28 AM Maciek Machnikowski <maciek@machnikowski.net> wrote:
>
> Allow exposing the ptp_clock_info of the ptp_mock to the external drivers.
> Use spin_lock_irqsave() in the PHC callbacks to allow gettime to be called
> from the netdevsim transmit path.
> This is a prerequisite for implementing ptp support on netdevsim.
>
> Co-developed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Mina Almasry <almasrymina@google.com>
