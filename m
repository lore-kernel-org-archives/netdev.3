Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12DE41A569
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577300; cv=none; b=MqZjCvkvTVY1OrLTWRzHK4PQNmqe7JkO6xuL8vb31m/TxnLfBmfXe4NEom3GWVeshw/VgTYmfirhvrXu3sVmB1XomgNWTX0dMWhpLpXeZVIKL0nGa7bT9vGUfA2D9wOolKxZGjePntJNdXhNBL441QLh+OnrtzDt4pDcx4430Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577300; c=relaxed/simple;
	bh=NFWgPYNfkGm66jhBFFnqwAdP9P27YG+093TFH/tXxRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1KVXrC4x521ZJ7MrV2Ve24GWk15IfbUzv+qdU0zgOoQYfQeCeqp1LWPl7F/0Jn8Cxuh8lGqWlPmDiKSBfwvizTckbYlEGvlAYYs2r60Qu2JWRUx6RP/okB96lVFjdiYf58aJTPnF7GsdvHliD8Bsu6Q4Z3Kd+LVq1KOA+OgIhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBP12lM0; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBP12lM0"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-74a9ac9cda6so1838276137.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787577297; x=1788182097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NFWgPYNfkGm66jhBFFnqwAdP9P27YG+093TFH/tXxRI=;
        b=IBP12lM0oTtmPAZdiJuuHLEuyNYJZK08DRUpejY76tFv4cg8hLfDAzFK1pnYFmCx1T
         4CfrRAIaIamkiaOscM3nfX/kTnLUHazxPRiZrJes82d6ms5dVta5dtOpj2JWagigNh6x
         2x/XevYBhpEltOkTxl9kOFfrMqid8qXIK0NVT4SCAbiBZU3UwCjIHLp5IPu0qxEOc25X
         Q2rIiHeOdka/qYQ2xVf0HZcWW5z6lHUOYbwBNbjy1JcMAcciTWXnWDOw/+tx6fy3Yp+A
         3A8AN5/1EqzTPKIS+HlZQmtsZvDwoxfbq1iRanKxOjn25QuzPWHry7xRUX3SCpubTQT2
         aiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577297; x=1788182097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NFWgPYNfkGm66jhBFFnqwAdP9P27YG+093TFH/tXxRI=;
        b=AqW0geZiUrB3Ac36Twdl7+wxZ6c6AG/FiAGBTaU/8OLMLedAshgY9E+i1W3LMuc8oG
         sGEfx5ZveyceKnCfciUPWC8WeUN5xPqwnO+2JlP7lC1QhMcEPm3bm4KsxptvloOLrGvG
         /jfBve5S1/fstgUg6eYvPCmSXmDdWcRJxeTpKrUV5K/qui9REUzvUZ/mJpMnD898ZpSs
         MRfb4bZpWK6ilKmXjDV8QMQJqvSaojOyjJ9zaz7Rj71EsBqPhSaiKAFee0+/ceY5jTwS
         DX408CG8oIoG8gN0pvhGOpxtndGppfycHsgCrEQUzxze7PGZ8CqiHPR72yVQdNK3BMuf
         L6sw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3dgEtmZ71WWoa6FQ8zjxXEcDqF2PhcjhorHPtZyH3BaB+bvYmbRZ5asJaaVHIj2rv07qw0po=@vger.kernel.org
X-Gm-Message-State: AFuF++mREvrDKtPBH8UFHxj4bBswoEYUBMzjaqvz1CVTw6j2Tg0+glRN
	TANRlimC/BJz7zr3jD9OURFme0aIwCEd3pnUhFeyesWtBJTjdp/IHPEj
X-Gm-Gg: AR+sD10JoFZ4BUGLdJxOtsOu5bI6GA6brHxr++IBbukCtbL9li/NWj9wiLhdyAn97uJ
	bOapLDB1MDL6j9KijVyXa4Ox+9SbPvzDnaGlwFp6KmM7xiaNtLXfZ7zyixua5AHP8WbAQFhW9eC
	N+c3+eq3yWKYFtFvUNSiyaFVQzvtVmODKym1kVWa2Azc0/up92SUjQMTe6mZ1Oc+yIsxMGCg5jo
	bFrVjJGL8/F/o/7KrdBV+sDeu8QAnYoKzQEuBZfRxMpGVzQAuN5NvcQjyfG0TaLBvHz9uGNthg8
	3aY2W1ZWJq3+/6tZTWAD2TwtUh9JXyvkUi1dYroK+9rpCAzcPd5/HqVIiAvaoALfcxYRN40A+c6
	5oiqjUWO82xH8CfZlXKTSyQR7bLOnduM/kIIPWsgQ5EAwiH6+OPKlHwo47GSgFPx8dwJY5VFdul
	CHICk3YyAWwLneChaih1shMJRl8tHOyQy8CWsBX0z6l2icgAuULJ0q6ZMqy7P3iEc/SG+Q8JWOL
	xE8v4zlHcE6HAeuzyxNITtpAkGIkI32LuacCJymE3mbMSzhly7vFhIXHZHsg7/Lutvw
X-Received: by 2002:a05:6102:5689:b0:779:aedc:88c6 with SMTP id ada2fe7eead31-77a5f8ee20cmr10431883137.0.1787577297390;
        Mon, 24 Aug 2026 06:14:57 -0700 (PDT)
Received: from customer.bnssarg1.isp.starlink.com ([2803:9810:59bd:1f08:f453:2aee:b17e:bcf7])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97c836fa899sm7711635241.8.2026.08.24.06.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:14:56 -0700 (PDT)
Sender: Mariano Baragiola <mariano.ignacio.baragiola@gmail.com>
From: Mariano Baragiola <mbaragiola@linux.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	littlesmilingcloud@gmail.com,
	Mariano Baragiola <mbaragiola@linux.com>
Subject: Re: [PATCH] udp: resubmit encapsulation packets on all multicast listeners
Date: Mon, 24 Aug 2026 10:14:51 -0300
Message-ID: <20260824131451.33372-1-mbaragiola@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <willemdebruijn.kernel.13d69ffd770f1@gmail.com>
References: <20260815141128.1564949-1-mbaragiola@linux.com> <willemdebruijn.kernel.13d69ffd770f1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for checking this.

I fetched current net and confirmed that 3cb8d4b9bfeb is now present, so the primary-path issue is fixed there.

I also checked the SO_BINDTODEVICE case. Although different bound devices can bypass the port-use equality check, multicast delivery requires the socket's bound device to match the packet's ingress device. Those sockets therefore cannot become multiple matching listeners for the same multicast packet. FOU/GUE sockets also do not enable SO_REUSEADDR or SO_REUSEPORT.

The secondary clone path is therefore not reachable for the positive encapsulation return. I will withdraw this patch rather than repost it.

For completeness, I found the original issue while comparing the multicast receive path with the unicast and GSO paths, then confirmed it with a focused FOU probe against clean and patched kernels. The clean kernel dropped the multicast encapsulated packets; the patched kernel resubmitted them to the IP protocol handler.

Thanks again for the review.
