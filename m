Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E8471276
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134685; cv=none; b=bd9USVKVUK06be576no7HjOOsVJJ995XrS8i8kZrRVENiAS34lfTwgtTG5rUZ6riMypi+FTQjDmuHzv/nXNw8qbUXRTP93tdySGuK2IngTK7n4MMTT6jKVzg+flOyqO6Dy3mTKuKG1q/mXSTZRahZHQj9Kd5BjH6F4RfkRq4BfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134685; c=relaxed/simple;
	bh=jfZ8rsHk8indjM0Zk+DYEedBp1/Cz23GDfXWpz6sFXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akLAKyyYuTyu+Ux+bLjKSeewOX/annlYXnOMPSBCW/Eew/lmgkoDjTOq92r4Xh+ZiYZcWXTVywxXYOwks0XuuXfwRcJRH/rb0MqJfBAkDZWkbXyyPG4xf54rsd3oh1U1nj7RHzbnK+12LuE5hFPTEc5lOC26rcIWUhivJbWTXTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=D4Gs/M0t; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="D4Gs/M0t"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c29c6a3930bso137419766b.3
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791134682; x=1791739482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jfZ8rsHk8indjM0Zk+DYEedBp1/Cz23GDfXWpz6sFXE=;
        b=D4Gs/M0tZWtbCiT/UEoislCDMECwgdu68eLLFfevw5ycVYD/lNs/PXaieUjt36cJ99
         mE2Syqqe6RY3N5qnJizN9iCZeOnk8swRuZfgQHnrkDYOI8LmEG4D38FwnH0XVVCt7/BA
         8PrYfo6zrv60OByJ+WyRBlBzTz4nIr03isGaCYjwxtl6AVY20L2y0Z4aj0vhuA3dSI5v
         pxoPtatQt9/55MgsGR1I/fOdyY/eLOTFgZ482QStmOsAX0nUwzCV3FV+CHzXOhJtFcoY
         uuP52I4Rz3TRsP8Sz/gPsgBimShXCltHrKW5Veqku1KurC5NZW4Vpj90h/x6O9GUretW
         yMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134682; x=1791739482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jfZ8rsHk8indjM0Zk+DYEedBp1/Cz23GDfXWpz6sFXE=;
        b=HsROCGCtmsOsK1M7iZ4dkMgZxINscgH9X/I33XsGiG8/PYyJIdS629AsXudXcM9cH+
         Kix5Q+nlzhez/7BoSywbA74B+EcYdD7NhA/dtVb9ztEIBJNQy7kFE1A1oO10xKzG1+Mq
         unwjJJEdBlM9rxUFaS9hG7MEK4F6QjRRuJ/jIalquy/kYI2uoxgqKbUV/ArK0QsHbIsp
         UjfVHcgH/XZ2Hv/VX5dIlT2vIDWKrV/vbmfC18DWC9xFPRCtuwX/iAK6dbgH1RPH+Ao1
         b4ejIModhG/vttjJDO8gjvNslxwk5vj0fz+S8+vqyxRDAEdzNoD+irt3lOUNDh5N+Uyy
         JHbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdWuewXtY8/c+PztJ3KWTVgK6hM8q6vkV7G+P+omf23O5ms5K3CemIji36pARXnF5RppcKHLY=@vger.kernel.org
X-Gm-Message-State: AFuF++mCK554jD7imAcjzw6RQFInOrS0d3ZBVA5bMMl2x6erVBlBWl6/
	0HuJbruLycJo8mRxj35Dq6Ya0ZpKzuUwHUqVLeu+GNcB/UAvn0UcKoSDD9gu/7X7dg==
X-Gm-Gg: AYBFou0MXUJiYSSHdYM/TSdzSnsq6GG2qTeKJz0uRn6efawRhKrpzZdJ2XWHtaYji6o
	CzkLSMJa87xlwIDWlO4ADFpnTIRCE9H3lWGO8ZAUP7vGqD/UXPpaHRdzj5X+T5OvCx7t1PcAewF
	qYTYjpP5+Ppl85mEVklnnanlrFKLsW5hzD88wZZK57qHqvSb9/0LbJrw7eKIrQg88rsInNopw7p
	CC0H9YQUUlTPnAaiD0VGK7JOxJpCZtbONk6unbVPezxp7PRQF1VjrtVoWUcRRGN/n/kuFSaRn8t
	VzopcQ9Kw5QJwZdJDTX1afTIhn+E5rBsX6rJ0F7YpacKiNwXN7Vpp1GN2MYoCF3yLVLPuqrwcZx
	CRvzjwbeZ1ENmZmcy6EoyaCwdrub7JHTtUnTZS0ShEsYwWSJ/aXbyRubxMtN6967zsSZmQGPC7m
	UBRYNONrYRTQLfw3xADMzGHqfdKd/AzTrqq8edFYMK5mY/cW0y0s7uTCVNNe3Ui9GxdR7qlmjha
	I3zpc2BMNrnjIVuvESHka99+0mPciXE3VGbejoRFYZ/qGjjNUJ/b0trN0FcGm5ida/AF5gSVeZN
	q3psORetLLvOk9STWAYueJGtq8aEua3ptv1sougacF7eu2Ri66PusfRziISEFAlYp4mqLD4Jj6w
	4h+HNRiAngQ3NhC3RSm//L6PEaUX2hzONN75BG3vZ/w8zXQ50Knbxq5RtYjAfFiSb4UtDImSr2P
	2PTy0bSpM=
X-Received: by 2002:a17:906:f592:b0:c2e:4474:8737 with SMTP id a640c23a62f3a-c2e6ebfd138mr440395266b.6.1791134682255;
        Sun, 04 Oct 2026 10:24:42 -0700 (PDT)
Received: from Desktop.fritz.box ([202.71.144.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cfa6645sm316564766b.73.2026.10.04.10.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:24:41 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com
Subject: Re: [PATCH nf v2 0/2] netfilter: flowtable: correct and advertise the vlan match
Date: Sun,  4 Oct 2026 19:24:39 +0200
Message-ID: <20261004172439.3548490-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913104251.648421-1-julius@bairaktaris.de>
References: <20260913104251.648421-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Pablo,

friendly ping on this series.
