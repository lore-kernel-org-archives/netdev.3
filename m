Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FDB42FCAB
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212745; cv=none; b=E6UZ6E4cXT29YcbQlztmO1EdCIX3ZvjFhokxVPDrx9Jn8UVknRQuegWbdGr5r80NFPio/PdLXl+DICvyssuylQzYF/6Bq4wUoewZDmEw16dANl8IHb3k02LofTwv9ziXIuDaJiCVCaGNSi3zJb/Bt9hUXzIEfUSGie8i3WifKoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212745; c=relaxed/simple;
	bh=qsT0+91EEk7IFRz1wumgRWzow/otcNxlxulqB9I2Yv0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P663fTUG+GyzvV7DbNwWBIRChRIYYB4BfxdDKZ5RrtJJ0ZB3P/UOuIGaygY75488hHaBrOnsUYYyp2FyuF8DSZ4rAv0p/NpcQWBr49wHXCSiDypX/FWn7bXNuyWV4m/9/ezoRD8Qm/XUMilN5E4k6LGoAdkzoeEtEKaO94Pr/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEE7fBUE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEE7fBUE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493bb0e2894so9067915e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 07:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784212739; x=1784817539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qsT0+91EEk7IFRz1wumgRWzow/otcNxlxulqB9I2Yv0=;
        b=pEE7fBUETwTp5JCdmbuXhVGK0pJvBncvCe8G4F2dn4nq2IzpHiWGOrxFHmTj98oZUt
         Yjf8lxO/E60mafmG9VJeo15a7klW0oE1ui7mkbcCL9tPbc0wiPJhKkZb3i0OPWNRtoI1
         H+2NW1hIJDDOV7l1Zc5HekFUh70hf8ejougIZQeJgIwE3fLRw0V6Vhshf1JIIvOBfTx3
         teuqP6lYgktuzh4J83aIyO3XeFG0AZBlFSL5LlwMqDh47aXiHpMjTn3SvuRWKarg+2Z4
         hID/r9hD8TAP1tcy82Pw19rmIRAOBeBhqjeGzLcqEEdEUJVoPihyQl3kIXhFAUFiTTE+
         tQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212739; x=1784817539;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qsT0+91EEk7IFRz1wumgRWzow/otcNxlxulqB9I2Yv0=;
        b=Jga8MykIEHYOzckI2CZ5V7MPrYTM0dBT0iijzK/m8BupL7c5Sr5/LF2fMuLwZvokJB
         DHsG5Vv3eXHTRiKRS6SavDxAsP5zBr/8ZCRqDJ5SXGXJtRDOlW/0mNFJ74UWwyeDZUAv
         7yjs03kDQEmTwYll7PHu9KS+KYOzxeZR0rBFKhUvwY05/2RTjxCB6K9TMEb8N5HJjpAl
         UMDJzlbzD+OiuNkTmfmDXnzbS4t4ddoGUggbPmmXSgLO1ceYbq0TJD8sOgjM6q/fnc8o
         dR779MfIQ/AB8paa/pO4EYZQDiPHFXuVQXqEipb/NhLSZ3xBvcNs1I3C8BAkXQ2iN/fv
         XLcA==
X-Gm-Message-State: AOJu0YzwHhmaMnkFdRLEhgTnU4nwAJWgAqsN7UNRfwDVEOqwi/5J9EOR
	EfKVnrxzrLNuqROCrM7N5wzMnPhN4GGUbrbyZ+9c6vdk832kXQYZlYqS
X-Gm-Gg: AfdE7cne5OXkiwkJp8iMXFN8Iyoe7ElzQCod2GjX+SC/cIuC2esiiWU4eqV9b66+k2Y
	HJ78BesIZVEqbB+odH+n5RjqBdLHWPinmLlcvx7u5dH0ScBn6Kv0jWutxDH3wB6rvy0K73BvjbF
	BxKYc+zU13qdST8dI6qqYfsOCsxz+OWkDU8p91pwY7/LJaLjwnRee3IJD4+FcHXVIGW7J4AIrr2
	FyI0xTX2eIezrmrD1Dl5tPD1KegpXL1s0gWF/k83uE6aWiu/YknDbrmBMX+aqMyRTpGA2+YJmEn
	OAE0tT7RYcNVjg0567c6P7VikY6fOzF2AXeAmDVYLUIkbzCvO6Oes/GaoN806YIHcbifdAefitH
	iOa8VoQE1pcRQrxk8QUXxkyNOolIKHEYyhwJz0oia87uUkiOmgHyc9F1kSal9fm9pVPXckUuPq+
	He0KjtIBYy3zG6dnZYCwhLfmuINia8UyqjxjVmrPlFpG/D4rNf975Jx6AZUl3IulrH3G++j8Ihp
	hrBazwT+JDwPYe6Mm3AHtOPUeHCel7RbOKcTxTO+mQFOTG60xhPKWsvUXyz
X-Received: by 2002:a05:600c:34cd:b0:495:4044:11fc with SMTP id 5b1f17b1804b1-49540441311mr33025625e9.7.1784212739282;
        Thu, 16 Jul 2026 07:38:59 -0700 (PDT)
Received: from L-022584.energy.envision.com (dynamic-077-187-169-051.77.187.pool.telefonica.de. [77.187.169.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e9425asm100233605e9.11.2026.07.16.07.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:38:58 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, David S. Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Felix Maurer <fmaurer@redhat.com>, Luka Gejak <luka.gejak@linux.dev>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: hsr: emit RedBox-MAC TLV in PRP
 RedBox supervision frames
In-Reply-To: <178420323080.16062.11665494757602926366.b4-review@b4>
References: <20260706134131.61659-3-xiexinet@gmail.com>
 <178420323080.16062.11665494757602926366.b4-review@b4>
Date: Thu, 16 Jul 2026 14:38:57 +0000
Message-ID: <178421273771.87.2937123145126003737@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 13:59:54 +0200, Fernando Fernandez Mancera wrote:
> The indentation is wrong here, could you keep at the same level it was
> before?

Sure, will restore the original indentation in v4.

Thanks,
Xin
