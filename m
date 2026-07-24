Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B92931FB
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910517; cv=none; b=s9IyzgUkjeYRgDwaLRYcsyKO6eHcqJcSqiR0/iOlNm1kso7zM2OVP1qcbVx4XP36quZD5OLeD8ZDQTeGaOrG0boO+LyPDmOcu1qmJ4wkajHT7phR26qBgGlvkjvZUjPzORatKWJZhHFDh6eE6HV2HvBIs4yXJn14EEqW+yBDARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910517; c=relaxed/simple;
	bh=1DFTVj3pJY1s6gMw7gzZwqZ0RQ4l6j3fHS2dBB5xI0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyHBaxVfgqLj1wJN3ud8iX4E870xAQtf5TJD3X/odgjXfd3H2B3u10bdirju2+ZBQiQk7zKQikfgU9y2+4WIcNsh5uc6Hd6V0JelxXWkbokffiiUfy8FhEp6IQohjUgjgbdHNji204NwzLzBQo0JhaSBA/bCVlCcJwdWkuBnmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRmEGAaG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRmEGAaG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cad8076b01so7071335ad.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784910515; x=1785515315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9vR2aGNsACSZcu5zSecY2lRBl9pUsU1K/NomQNXicc0=;
        b=YRmEGAaGizaYMuAXGB7NFih/7svluRwB5gPKPlyiB7cv7bLcsow0dX3abpQDbm8KrM
         xNPhU6Riyz5gmXPu6LFqs6n6mxm45wDod328ERz8NB8xi27FotGBqR8Cu0MZYDIXhwv/
         vtZqXFl+hnxX+y3+eTDMi4e+qFNe6dzxnqCNJvcEMY9XSLJ2rAesCArzRocf3C+OzBC+
         jgaKRpYRWcPGT0fPYzNVmVfaB3KpXLCUNymHBQgq8mrBhNJw3qeFVsIpP4FbDCxPtyev
         /F8/d4YTEUpRFrxZ9PfO/owLrqkDbwe3v8FBZ4GHlrfVvA1TiQdEEAH2AcRDBwvHXWZE
         GjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784910515; x=1785515315;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9vR2aGNsACSZcu5zSecY2lRBl9pUsU1K/NomQNXicc0=;
        b=cXwWiqOEPZWA4vmXUOh9tAOuCtsckLkCsixFyZrK6h9b8e8JRs66mIQVEYDjqdHnI/
         6GobZdqF3VUPtPdE5kDpyX6O51MeRZQ6CuqDZ0KDcwhg8SLAWfPmZJUWIEzdYcw1D4NP
         WHzjFkSam6f5FWqTyvmmJYrlBS4Afv6kM2wz5V7lMcY7lKgyApgOL6kH00RdFi/DhmLG
         YjSby4W0qWjTlHlB4sX+K9ChKLCHQfjbmxoG8EPguWzd0HmBw8CV8vRpwV3izLymTzH8
         B4IAjWvGdd5vh3jgLMsGeuE3b08GcXPrN4GxYfezDxVHxMGFIlm6u/X5tocVuX7j4xc5
         xBBA==
X-Forwarded-Encrypted: i=1; AHgh+RrPgTHq886V+B9N4f8toBhZ8gUoHdv/0XqJu4iLhipZ4xU4qHdf9EIn9yq/MYS8igzdBi3pYs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WZUPj/rXby9GsMretOEyi6DvRzcZY0kFjXU7SnLU5K6uWXYE
	msHbZKPgDn0lQJ4e6gD1KmQzvAhz6ArtbzKBGGaIvHuhY2pB1XkAb5Ty
X-Gm-Gg: AR+sD13ATmoisqpWZvM5ccwFn3KYPHX4HI0BxzbbeJkagTIBX75W6cGz/XSnqaLmk/8
	T/aX7iD86CDVLamIJW2DYqDQtGDpKSXQuYb6+XRC5YIlan5JXEHSljM8Ha16lJHIuuOBubW+YMl
	SLxGoNUfvaUrLLHdqB8ar+C8TNgOoC54FR3avUnuInMW2Kh35iWUkIhEeGd58Ys469pJGYBAE5d
	PzTdDyuNQh1JJiigzTSnb1gpVZZUpnzAizHBFSW0DKQg/komvRezLZbs+5KzfZ+NAN9Qofjbw9K
	O13Ixzrz3ma9/U/V4R4ZO5+2eh9MzA0tSvQb4340myUHYeUSU37z+QHrMcx8DI7Qz0Zk5gp8CZj
	/sgJ/ENH8XrxEWvuk25ScOj+pjQ/E9N0FVfNAGGJuR5lWl3KrZWoghVHAU4Y1Plz/z5O4xWh2kN
	qSF/UTzpcMxy6Yr3MAtUyVOJR6hHP0XiY0MTZB6b409SRwdw==
X-Received: by 2002:a17:903:b10:b0:2cf:bf3e:4812 with SMTP id d9443c01a7336-2cfbf3e49edmr46291485ad.2.1784910515543;
        Fri, 24 Jul 2026 09:28:35 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.redmond.corp.microsoft.com ([70.37.26.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd849asm54371185ad.28.2026.07.24.09.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 09:28:34 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Ma <jack4it@gmail.com>
Subject: Re: [PATCH net-next v5 0/3] net: nexthop: per-nexthop UDP dst port for fdb (VXLAN) nexthops
Date: Fri, 24 Jul 2026 16:28:16 +0000
Message-ID: <20260724162816.10207-1-jack4it@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724064143.09de074e@kernel.org>
References: <20260724-b4-vxlan-fdb-port-v5-0-cd1c6aeee058@gmail.com> <20260724064143.09de074e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 24 Jul 2026 06:41:43 -0700 Jakub Kicinski wrote:
> Please push the latest patches out to GH so that we can point our CI
> at them and validate the selftest.

Done.  The iproute2 companion -- which is what the selftests need to
exercise the new port -- is on GitHub here:

  https://github.com/jack4it/iproute2-next/tree/vxlan-fdb-port

That branch is the posted v2 series on top of iproute2-next: the
NHA_DST_PORT uapi sync plus the `ip nexthop ... dst_port N` keyword.
Both test_vxlan_nh.sh and the fdb cases in fib_nexthops.sh gate on
"ip nexthop help | grep dst_port", so once that ip is installed they
run the port path instead of taking the SKIP.

The kernel side is the v5 series already in patchwork (series 1133589);
I can push it to a branch as well if that's easier for the runner to
pick up.

Thanks,
Jack
