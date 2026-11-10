Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322393;
	b=OKKg6psl/P+H9n4OEIp+Omg3kHLkbIXty2ESIyIsOV8M4Y7vZ73Vf6j7hKnyki3Leqoi
	 RdxfN/Db8aLGAqYmlzedfKfJuzaDlC55YvQT4Njmf1jbusazHnzlEZ+tKi5qMwwf3dqyg
	 NjfOlG/PmvNdA2hvfE/kojqEST1AnhAqWHQDhQxx2K2iLJd7ik7ho8qmlAQbhW7FSz/Yh
	 UxnFDCvbVq4rXPpb+SLt+3hWhYNc7HmCrNNUrmsugyESktbvOmbPGCN4vX0iAnyiI1mN/
	 217mYZh++ZoDjj5lYjPArUOOCYmB8x9ckiegFmrP+0fRAkKlzhlUVhfk771hqRewiFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=dDIkJRiJIif1geyfkVO2Ozh8mdHsZxD2cOh2+CSfbig=;
	b=WqH39+gstZtmQS0+mqJiPedLoQIiX9aCli1Fg6u6KulofO1L1+YvqQctkWsGpkQsRY4b
	 p6fb6vapP2vT7N7aAqZjDtVjXeNlosj+R/RgV1EMLgLlM4dih0RiyujsjI4bRgTYBS/Z4
	 XhL085VsrMPD418d7ubLwuWRzaWQmN+vgRl4QahIff5I6ZWJLPy+NiFe9J95h5xxEF515
	 UwoI4FJ1psEH5G3UxR3jTCBdaPIis4I5QuPJdQThfUGq9n1wWeh2VowvIhwdshyS7CqsM
	 qvTHi5/knwEKaZHJB+mddzT/ZWnbk7HrUV2/+bc08DUOEZSJPZYgDBSygZ+u6uXBG9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZw0lyud;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A960A6F7B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 723A960A6F7B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eZw0lyud
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so1037203b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794322393; x=1794927193; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dDIkJRiJIif1geyfkVO2Ozh8mdHsZxD2cOh2+CSfbig=;
        b=eZw0lyudW7NnjkoBj31uuoQIZaMnFbTuwhncJGyAvzsoJzzYWPYiR96gWEhBU82fQi
         l/F5J2gD4+S+Bk5FosOQ9ABgv6SZeycpdu3nVvVhUkz7mG4SF/MOzqDXundCHTKmjV92
         6OTwy8Fepw36ImAsa2O0wXTqKttEMb8/6hSjXIYMfrG1eZvWLZVxSkFugG1D+56q8guW
         /9SRucxq2JcwTFULSvMofFU5j8nCrPz4SaXe5MC1+v1Cx+MPZR/ok2EQ35MEItRlJdQ4
         ScQY0aYtYO+RsVn6k0mdBswyojlktW+ct0viV0gxRW5AijfobvgQyyXEASP+74Hc1CQd
         Ftcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322393; x=1794927193;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDIkJRiJIif1geyfkVO2Ozh8mdHsZxD2cOh2+CSfbig=;
        b=rR6DHaAfafLcy21v1Gj+mZRh9nlGkDBJnlE8JcAyFmc5OCNYINkHEDf8/CD1K6cdfJ
         15ohzIF5mpY1VQLJIHCbo2AaQjwq5nd3Dft/Tyuqjh93e+pxdJivP4PP5uR0+PiWUz2z
         4qgIdeBxNCGvfeld66jGaLAt3HaRcAKdIqolwKLDGr+aVOOUija44vA2FvFPXX0uaVl5
         cA3sS20zXDXidcq9AIpyugHWzyab0x8mbqslCrzg1SlzPdfp3v5XavNcN1z3FXslYqv7
         BQXpySJ12qTCumd4D9F0RGuHAgcMSgNqhQqw3L7XwhgkKSOVi3/V71813PxrC85Fq+ff
         W5aw==
X-Forwarded-Encrypted: i=1; AL+hErG+TYHSg6XMcgtsC8wOVhiz7qB+dIhuftlHok+6crbZvPQ1MsSzIRHyswDYM9mWPWU5YkfcBL0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qTvgV4kpyW1iNRaMURYv9qD8d1bWxYxz7K6emaZJxD9IQQt8K
	NqY58JyDjtExPwlUPomL6p5WgIOor+d/KdNvt7zZMR4U0eGDfk1NK6hQax+Kz5zdnKc=
X-Gm-Gg: AYBFou2Aymk/voFIRbRn45uL45mHLyNRGo+i8tv4SNb2SXrp0D7nVEw49LDcDl6gU6t
	irQCvVfK3y0rXFnjfvAI4SXKg8S1dpFP7eDKNLbhDhWbmF9VgEw0A9VOW4wh00mvE+01IOVJ+zO
	jXwUBwtE6rq2XNyqpUclIyTGL742GsHK28WIS0XWkBJpNYpLKCbf6VysUBduoCMZZXox0Gg90Zy
	Qy47x8pmFIA4MDhaw1wpihe4PSP473tfFpHXIS+av4JuBYGEjmEh8GQYOEAvFuOCCKglZbLlHUW
	N948XaboI8ThcHFC+RXZ6lKezNTpbSV8HJjyR2sRE4xq4NVrxpBGdxIkSv5m7sYXsWTh2QIq2GE
	mWOeZyHY2KFpJorStRX9zuBmFzaTo7ZTXessDn0gYFtj+4EnV8pfgRWvI3THnWR37bKtlMrJTJY
	rZxvqtDkMPQAqskxw2Py1dkO4F7z7AkEsHiLLRu8l2R4+QC6b5CQKPkdePNHlFneMAtepFtWIwq
	WBZQouvctM1ZVt8FWs32zUJfu8UaP2lNxCLTN3ggfwUO6N6Iu+BwogYaPMCsfj2N1+QsOoNatSn
	yZWi68+RvLgsmObQGuvKDtYi4AQONczRrVw=
X-Received: by 2002:aa7:9315:0:b0:886:9078:546 with SMTP id d2e1a72fcca58-8ba86c8b151mr2810034b3a.26.1794322392607;
        Tue, 10 Nov 2026 06:53:12 -0800 (PST)
Received: from [192.168.45.62] ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaa2a6c46sm991031b3a.9.2026.11.10.06.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:53:05 -0800 (PST)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Eyal Birger <eyal.birger@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] xfrm: reschedule NAT keepalive work for new states
Date: Tue, 10 Nov 2026 23:53:02 +0900
Message-ID: <179432238280.95628.18388676747807754064@gmail.com>
In-Reply-To: <179432201725.488859.12108349638231652047@kernel.org>
References: <20261110144321.94096-1-pocj8ur4in@gmail.com>
 <179432201725.488859.12108349638231652047@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

The issue was identified while reviewing commit daf8e3b253aa and
inspecting the XFRM NAT keepalive work scheduling path. It was not
reported from production.

I reproduced the delayed keepalive on the original kernel, then verified
the change with arm64 QEMU/KVM and a virtual NAT gateway.

Thanks,
Baek Kyu, Kim
