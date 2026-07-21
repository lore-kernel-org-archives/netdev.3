Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DE7443AB0
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672370; cv=none; b=WtwCLYLA7UEIGpaz+Bxi6e3Te4QqEAY3a0PZzgMCC2F/M+CBOQkoJ9yk5MxMeJnBhEClBg6npJTJzzvU+VX3NwJXVZ3yBiJ+DvtALA7Vt94ULeW0g26cjVrmsWcgs47NF4qzFz+s4xozbUt4M8PZn0kuDlQFQGyYrdb3ZsLrHmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672370; c=relaxed/simple;
	bh=6i5jYXsAZTIuZy3JweEhPDPIMYGEmqGb5I4PHkRBVko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XBP4Kf69gmxfjuq536/HYSQr0OwHz8OgN+AeTOAp8NdhBSW29WDNoCQIH++Yv3pMHC/SSxdTs+nN/lu2Wj2Jk/bvj1gQwIIux5UIP1vm7ihLjX/Bv9BXgO0oyGLK7JRz5aX0pOCRb2B3z9iLj0jZG02VMo8SnhrcbGMO9ozA55o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+2bhQKL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+2bhQKL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2caf228a910so94045145ad.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784672365; x=1785277165; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Sq8auGZ8N5ZH3jsftC3dYQE6POMa6K7YTQrQOZw8OU=;
        b=V+2bhQKLV/oIK8gGigPBBtDpJlQyln4Epovpe2+KD1pJpU0IxcalJyWoyrtcg1nQsd
         A0jN9jQqJTz1m0S1psFzUF7eLuIWyjGrdT25MPrfj3RySozBuR3Rw3WMPWFrndWBXCfa
         JrXe1fEpD1utSzpEC5XsBKVyuIm519n/QK+MxQCYleU9tDIgj+C3TJr4JavYejuwL+Bf
         7iVepRa3jdYgFdXcEdJ6RvjMDfc229rZ1Kc4lzWKMd/NqN3VRUorZtuXn8mGMftT1hjW
         l3cX6E/YcCZe+sD5Epv7dAtiuIN7orQ04WUpvwxoHkrPOkPZCYNLCiWD2Yq7mcQf7dgf
         pnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784672365; x=1785277165;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Sq8auGZ8N5ZH3jsftC3dYQE6POMa6K7YTQrQOZw8OU=;
        b=q+pC0xvQEJpP9R0Wb0OBSokbfQ/H1a4yhH9r2mpAwHvS1AcZ5mTqpW6/xubZTSBJR5
         aGzWz7u9YIc57m+jK9cZOgVo5HQ/SM9vMYo/+SxrFR0Kn5ERl0aoNaB6xXFX9oWKzMb+
         +HKNPwQEyor6vz8tkXq+Y9+RuXWwZav+4LNFg3q+qL/byJ70wh+rWHUSpmT1RIsmvugb
         uuw9t55ve40beKBNozua7uJGZ4eVwxY4rH9ar6ctGySsWHGMu4hEk4N2aSWzZinI3cJn
         gtt7nP+ygQScN9lLHQ+LBhSB4b6qOcC8PMNgA/COZP9mTzrCqQm6rSnOWXzWaqWJWvsk
         Kr4w==
X-Forwarded-Encrypted: i=1; AHgh+RrEpQeck57uX0OdN6HdVn8zZLIoMZG6bHQdnLOzrYw7r+Xx6SDFAfFN1KK6b/mYKb4x6vs6IxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9bjLtO+jC07OtR0ZjAxTP+CoYcbBh1OheyLhu0Xz+SHiEtLT8
	2d3P9PH+bfwL4ISFDh5jbpiXeWnuyE5+DqsUGsjbCpjdpGUy7TJhj5Tf
X-Gm-Gg: AR+sD10al8I/CAcZOejEZ0uFdrwvw8L1OecLXkaWnxGnDz47ClALciqzHbBl8u9tXn/
	gdXbpDCdecFOuW3o8bsHqjOrWchHC0IlNgscb+A78o0E6De3mdU8U+Rrv/veeirwMOvK5FBA5Lu
	k3hyzsbdiUrtMSoCDxD//hIVPYaPOfH5naje+ns9QZEyDh6v+nU2Y8OnfboeeWgG5f0T/xzklCN
	XvoediLE2iiDnwK1EhDgKWM5B/CIoW0A44syO/LZX1bbUY1HfcVmcd1dciPRsiMGbr+McBzFiPr
	XdpJBkmQgjhM+SIyTupvD31h5lQiX6/sm1mL9t4heJQDnEv5d0qhTwWR+t1UuvkkQU7jE/F4twK
	0DxgWb8KezxcyOCYogUHT/LPOo/fbYeciXItOU0o4eXzKN3zQe585+xPmMCmyW10h6mf9fCCtrd
	hq9UTipAseCAdL/ntANfLoTkc5r3nL2yI/A40=
X-Received: by 2002:a17:903:b08:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2cf34835859mr239097795ad.8.1784672365186;
        Tue, 21 Jul 2026 15:19:25 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.redmond.corp.microsoft.com ([70.37.26.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efae5aesm3657535ad.15.2026.07.21.15.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:19:24 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jack Ma <jack4it@gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: nexthop: add NHA_FDB_PORT for fdb nexthops
Date: Tue, 21 Jul 2026 22:19:05 +0000
Message-ID: <20260721221907.2702-1-jack4it@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721151741.GA2667735@shredder>
References: <20260717-b4-vxlan-fdb-port-v2-0-f4862e8fe867@gmail.com> <20260717-b4-vxlan-fdb-port-v2-1-f4862e8fe867@gmail.com> <20260721151741.GA2667735@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Jul 21, 2026 at 06:17:41PM +0300, Ido Schimmel wrote:
> Maybe NLA_POLICY_MIN(NLA_BE16, 1) given that it's BE16 and that we don't
> dump / use a destination port of 0?

Done for v3.  Switched the NHA_FDB_PORT policy to
NLA_POLICY_MIN(NLA_BE16, 1), so the core rejects a zero destination
port for us; the "fdb + gateway" requirement stays in
rtm_to_nh_config().

> Why not nhi->fdb_port ?

Good catch.  Fixed for v3: nh_nlmsg_size_single() now reserves the
NHA_FDB_PORT space under "if (nhi->fdb_port)", matching the emit
condition in nh_fill_node() so the size calculation and the dump
agree and space is only reserved when a port is actually set.

Thanks,
Jack
