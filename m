Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37013F65FB
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311405; cv=none; b=HKCTHumpLqXIOnBrxits3JLQiIPfTjUzeoRQHj44QZ5WSZSrWKfwfdLhIwAdXcxIMOWzETNY3hFOkTZ3DdMdjFl12z2BSd0YpNJj+h4dhjEzWcNYYrFnrQu8BweXsuM8u5oQluNJxOyKtpqdcNOQCqFUSWd6ZOtAjJ2J77bUrh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311405; c=relaxed/simple;
	bh=28GhqlBebqOgho+tdi21xI5zxR0h+n1Zl46jPz5s4zM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cEizGBAsBJqtwr/wbYoJzYqy1bAo2Z/Ly/alYEYJ8UdxE831xd1osGvva94h3gMjJDU9EG0SwRtDd/UM9gMJCtpT0It8ABQtb9oOaOSVEeZvNcj6ldAECuNla5/q6Ft6/5wxguwpuxV7M/IE77U9RqUugRoy+ei70mLrCMuzo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E23/wyEv; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E23/wyEv"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6688a2dceb8so411832d50.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785311399; x=1785916199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eIaoLBAJi14aziVF/VtvuHHQDHZL9QF1j5daqFTSzrs=;
        b=E23/wyEveEXu16BNf7EsqJONZ5wV/9yTTl6CdkMYSLuUKkCRjH3fyqyszv07Tj5JPt
         LHYmMtcwy9OKI1yiiK4fy4G4xnr5ioKpLkV57ei6ZT8P5RHrOklMMofKqv2tPvGbA3Rc
         y7mb7adQf2fnguKQg9HT/HzEATua69+oZn9PpbfSEa83uDAin/5ZpxoNkNmJgNk1o+9G
         8UsMgFgDUJKESlasEF8E53WIewfVqVSZ//WowjOfT3JQVZYdyKreflqlAkdE1QYdw8T1
         VchSV42GbxCR/BOBOVCiM2BnQzfUSGpuS8DSB1sfwqUlqnYZXAggVfeDJz0ZDVNfpFD2
         HXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311399; x=1785916199;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eIaoLBAJi14aziVF/VtvuHHQDHZL9QF1j5daqFTSzrs=;
        b=lvnZdvBKdHBtNpd5tk35L3e9kgIWGjgwLpRlbRO8hG+1Zu3u13HwWES4U+v46iP8Tq
         Nu6lEPxtuOJylCMQIaox6m4ZQmhHAw4rCUq0zu+eTuhzKxLvij2OUGfH0Bb3tB1cKBVi
         uP7Ut+YkX4GcEFnqwQUoAz7afWYQKAnZbySo4dbXL/sfFQ5yECdg9cj/8K7fnbLvobZC
         B/h9Y30R+AlKKugrJpyALMdG9FgW4K8GxE7S96pkkkvgyQHnwu1CgYi2Lg4OwXOvMATq
         0t8UGQfTjdW1h/ZE65MnHVUoudYPjRqXpvdzkSrlDquRvJnwLG/rpkigC9Zvy5U9mCeV
         HXkw==
X-Forwarded-Encrypted: i=1; AHgh+Rr9bn4sudKM5sLT8xA+P+cHzmKHWxCTuuAj3GSkOCENvA+6K2QY9Q8setopNr2M/4bX2WxGDKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDf/zO/Leld/WCRh/oqBxhuGhQAXjtghYrh/XjXIUHQggg2lL
	b5ZNdfd+m5JSJDOFq68DEaU6Y9vGh/u8uPQRg2ZRE+B9Q5BBno8eL65k
X-Gm-Gg: AR+sD10O7b/vAQ+6tbXkqrmOBfQpa1JRuUX1GXoAewzgyiRjO7uwlsoB4WsZmdc1Y9T
	Pa0ywzty31KKOK0+sTnE+O75bvunDMDIUklZca19A0woAMf/Ia1Cuay0p2DuQ3n9EDzR+U2NJEj
	FGmYXlxfkq41ATKe21qOPekzHojYbVld7kqfyuFctU9sK1Zolkcpd3MFBLgYTOCYQzBVCRN738l
	sZeIvGJu5Mab6+WwiMPVv6p+HqEBQzgpgTg1Hhw6L5izQARwDr78yRcNedFOv4BYUixd+Xyczrj
	Eg5CLngOzg6CE3uGAc0S8btDhs16rdG03R+uHSvfXvFQzYl3Ur1k76YQSl3EmTzWI1HKZtd8z2W
	bLAQCHyGRmVSvv/pBSVffxfZpnmPZw+3/YweMN8jcYEFPf3taEdzbrZzRF4aaWMPc8o/YvQ+84n
	V/cK6s7+EOd2yt9WyM8VOEycWuF7VgkNMcq7iqPwoUJUoxiyZKigFfK+XJ7p6f8cjEmdJneioL1
	8AM4TLct1lhePY3elP3D12Q1Gvp9HXEin8b25eW/6fHi0I=
X-Received: by 2002:a05:690e:2513:20b0:667:c39b:5466 with SMTP id 956f58d0204a3-669057e15c4mr1988022d50.63.1785311398738;
        Wed, 29 Jul 2026 00:49:58 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66912662711sm1379263d50.20.2026.07.29.00.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:49:58 -0700 (PDT)
Date: Wed, 29 Jul 2026 03:49:57 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 Joe Damato <joe@dama.to>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.345fb70d551@gmail.com>
In-Reply-To: <20260728160935.4128982-3-joe@dama.to>
References: <20260728160935.4128982-1-joe@dama.to>
 <20260728160935.4128982-3-joe@dama.to>
Subject: Re: [PATCH net-next 2/5] selftests/net: psock: Generalize stats check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> Generalize stats check code so that callers can specify the expected
> packets.
> 
> Signed-off-by: Joe Damato <joe@dama.to>

Reviewed-by: Willem de Bruijn <willemb@google.com>
