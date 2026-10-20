Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507963;
	b=Z8xeo/QuIddEbgJ/uPT9AOZzqL/NzGmbR9DSzeIJJLc6Edeg3ehH24/Op+utOGQzRK9h
	 lEQcGKYXs2V/ukS3Rs0DF0+83V0GYTcNDpJXn0rko3SjwIZMXWN1889GKerf3d8qIFADe
	 8mbLFkNxt2L3Mw2jPmF2Yp7UaJbHm5WqkfDl97FcQWAHJzSw4C3NlCjKVVy5P4KpOhS39
	 TG7eE9DzpocUVccC/k3/Qn1m0xi3bTsaMZ0+5qaQX2rPqwfsdL8YmKTPyZmOE7bU0V3jI
	 5saVM1iYp419x7S4UEi5C5pCbBqNJKNunxSUwnu0vJowuqm5hiiujuErSQz1RFSLPlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507963;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gt6Y85M4kAfgeFbvU9seGRhqfBj39ecJG/UgGwQgng8=;
	b=ygXTJtgQc9X0mFJdEu8+imbwrYgriymBIlwyl/EC5FCgCiRJz9TLInavFwWwTksrj4Vx
	 p7YPSDoEFdB/LEV+SNVAaIF3BeVJiJu2y9hxRL9jVqjUWmW4aA9Fd9s5B0I/5KTUmYmH6
	 3mWO/bQ7r+US1gvwJ5gnxWvYDL+qEdRbpYTylUXnKiumsAs+bASadRKYtUD/Manz1zIZW
	 9ThohNUFDZhio4MIrilbkIgnj6SwSFN13qpVAI+biD7+ja4crixj6/pvZ3/CIIADItqhv
	 jwxZ6+vJchdjLfbasV6H9nbXqVxfiVFZCIVh+KxtIxfQawpu5wlCTCLWokq5azdTyYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PSP3O93a;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240F6606A31E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 14:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 240F6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PSP3O93a
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1d484b4a9so42522265e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 07:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792507961; x=1793112761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gt6Y85M4kAfgeFbvU9seGRhqfBj39ecJG/UgGwQgng8=;
        b=PSP3O93acGb2qbkqkldCxvnM+Af1EZDg6E3X9A8QStfBeJAjsa5Lu8MRiTNi8+zS+x
         o6HPz6N5ZmCl1fWr6etwdPtNzZFOEk/LA1T0rqAzwD7TudJwxpxlqj0+9iPyhGEvKUNA
         DH9NnTL1Zc6fXXSPj2adSYvlCRfFZjPWtCRB7WuyQSkXkQo5uocr1HuUh6wECwE7CVXL
         ExdSYerpS6CmBdq/5FfPv5H0dmOL38NmHNvKcT4V4DVMBO3Yd3Q+ZL6z8BWztj7i4hiH
         NMh3Y/PQoxG7obPJi2dVbh0oFaFPG5xAyNErJJQD+Tiq6bMq0JkfXzIY7B7Ulp6Zh9PQ
         20og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792507961; x=1793112761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gt6Y85M4kAfgeFbvU9seGRhqfBj39ecJG/UgGwQgng8=;
        b=t0eUENpUXZdILmo9U43b4p8SDUjt3EOfIh6jwy9mYTTZSN4Sibjr/1h4J1n/q+ABXp
         V+96cj8e4vrcnrjWSUjM8owTjrQQacHwoiE8sg7kOb+S0neyawgAp8xvAX6383niGRbd
         066V0+Y/lrx6s9PV1iNuBOgXra27gVfFq7KGVH0k2rN5zIx0OtBn/yq01hXjAZYhRJ6J
         6lKtw8Bif+d1dKHASZkQYLv8vuoFq4nFWFsFJWNd+dLGfBJq4bLiwJxeQFzSn4c6vSF3
         Ad8gcI1SgNYDt9bFzjHnDNetbhg5CuW/Jx3bXkuAVT/2DEFAoQucONKK4nmexo9uHr03
         cwJw==
X-Forwarded-Encrypted: i=1; AKwUvByQuDgPvog8sl4esXj0lg4I8LpXP6DVoa/uFEett4MBf4cHBW155nGT8kmZecKROR+ib5KkE0g=@vger.kernel.org
X-Gm-Message-State: AFq9FYK0iQINV9BeC+ct4fgtsC+elRH5KQAVlNGrR7QTEbIl2LsJ4mzF
	h5/+ybEtegyY5c41l4LJXxZa0ot7GiKCJJgOhGz4nj2745cdGeoIChet
X-Gm-Gg: AYBFou3Az79RovSpqISDtHSV0w7KB0fG7+1vZTUlmMrYESK/wszJY27XoreeNEDj4eV
	bxLx915z+sJZcQ4dWTEYnmEBvsc4vmdsCcAPLk1ysZ5bp4yBQw4LRXmJy7F2jPlSligSn91WUrf
	ubm+jZd4d+BAtnTY0NVzA1gNc3H+c1qExGSDGSoEa4uEsA6/sqxm3XQg48YmPifOJO4OFhJNJ4e
	qvzNy9CGSdXV6w2WBHuRBS4l+Z5sQLKi4X2aiCHSChAR0QtVopzE0zdV5KGeEThXx77hVtMw8YW
	HOHhQFZf061FKU0oKeQ9+ZJ9fQB80pBul2qoYNmsxT5xWr4kYNk2SK92MERRXq8Ouek4kgvW8BZ
	XH9i3HtTFtU+nO49w+nDjZposhtWsJkLb+NGMzSytgcBIbagqD27UCwaEpoLkrGxxzYk7nURcMI
	VIChK9aL8WoGZRlIJ3XUBwL3N7uSbdI2mh1uMZ+hCvZSBjlNZ+Bkmh96ELScHvzTA5TbDoVGeJK
	z0iWkh4x8/h4cbKx+MQ0oITTsvEwhIwENRqp2y1cLg2HBLQ2vTBwxoHRUPevgj0dR7pafS/yOwL
	0ICSHn/PEFcN00m7q9ZgVrJ+88rnf3JmueWS0mUQkd6OM43ZU6MPxx3Ufg==
X-Received: by 2002:a05:600c:83c9:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a1d764145cmr213720455e9.33.1792507961101;
        Tue, 20 Oct 2026 07:52:41 -0700 (PDT)
Received: from p15v.lan ([217.169.3.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cdf2f0d1sm211770555e9.2.2026.10.20.07.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:52:40 -0700 (PDT)
From: Peter Morrow <pdmorrow@gmail.com>
To: tariqt@nvidia.com
Cc: petr.pavlu@suse.com,
	yishaih@nvidia.com,
	leon@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: net/mlx4: no ib device for Ethernet ports without IBoE since v6.6
Date: Tue, 20 Oct 2026 15:52:39 +0100
Message-ID: <20261020145239.3798017-1-pdmorrow@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261014133951.3219055-1-pdmorrow@gmail.com>
References: <20261014133951.3219055-1-pdmorrow@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apologies for all the resends, email client issues are
now resolved.

#regzbot ^introduced: 7d22b1cb9d84
