Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749632DC350
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771030; cv=none; b=EuCm5vnjz9UD0R//9BiFy5nMSigeXcIkxbrQyq991w0QY2hwW4SWgFhnzQnT9qNfYBr9RtxZQRcO7I2IDC6f3sjSk8LC2bNpfCZdYmqd5WHxI5Hz3hhLHrPgipNzR2KhFRqYGPK36B4zPJmnhh+X2iqET5vs0uYLQJbsKyO9yi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771030; c=relaxed/simple;
	bh=xX+IXMPW2P6MfkNy8t+mUr9sj2Zll/A3MxrgWHIbltw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DM5HR4krMQcu4isqt9ARDS9OBwwPLqB6ItVH8d1JdG2333BeVR4LagBs6gn43RTTscvCK91n7HIZCtqcR30Dzg5CgRf/wgTfjD2BPwwInCjDlDVpUvHUq190Pvt2vXXfyngLiHTiFReWjIHohIP42eJevYDrmSQSdqex4yC/ddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQ9J4E51; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQ9J4E51"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso119679b3a.2
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 18:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784771029; x=1785375829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nx2KjPDx0JgpwngNp+VsU8xD8xU+8AxWDsarHpeVVmI=;
        b=iQ9J4E51vqr80L2/Mgecf01JWnWlp4o3+9Zf1Aa/1q0+IkeMWNNLcQ0WBlqa8ui/k1
         9uVcpSYQnOthNQGpTfI9lzrK7KC8BO+l7YWWe0ztubfdKaqL2jFVY3tqsS8ax/VkzZSZ
         xJxwS4rGCsGO5wccU1e+ol7kZvCW+WaUj1Kglfmhxv1xoYqZGutE6Zj3GVPCOHZ/CF5P
         aL7OjXVWt4tqafuoYvABuy2CvUWClz8Yq7lrBaxYi1DZkRZ5R6gO8bPHTcCFywki8p+i
         0s/7RMlIr6nwVnLRWoCJ7XuJmW5dCdcaBflesVX2uvuHTIZtGwN25v15vm9zuqARF1yu
         Z/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784771029; x=1785375829;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nx2KjPDx0JgpwngNp+VsU8xD8xU+8AxWDsarHpeVVmI=;
        b=gd0a4ZAsSEU56m7YxKEYVOfvZt5A8o52fgGsnnti9BzdRqjSfZQX35SY9XV1UoR0+z
         Uup8zDyRZkuuBHR1+VdfRhxLUWDwntER4vQ8m/VwFqT8LnqoSd60Zsxjbwp3TMKPt/s+
         AmJZZO37cQam/yoHVSk9hExVSdwyLBkQhOCEuTotgru+tnbflt26GLaHpcFa3rH2LR42
         +5O3t66s4m3bwt9neZbIDfqKh1tMjh6neD6FGkdoU0YSc0dv6Lsxo2m3rSGSUG6dNm9f
         mDY0DkOa0IMaPBujCsv0mg2gbIYXoLmf48FeTejH9cH48K8qdkBuLIk+HeJNHDQAPceo
         BBfw==
X-Forwarded-Encrypted: i=1; AHgh+RovrrJqO61UPME5FBOktu0ruhi7KTISZOULB+U4Nb+UGdL8WoBROraDyTK08sG+nGbRtFueD6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjocfJhjgrjupWFwXVP6znN91qM1MkAV2Nr7o7uctpY9T8pDTz
	BSNGHo+p8RDrXYLMmQLgzGaUA2ofISRW0nvCxqFplKvpnesJYATVGX3J
X-Gm-Gg: AR+sD12o/sPRNWDvxDUiduLQXi8GpFY1xVYViXGpYFXRMG4Ecjt3riSLnzZ44dST7b9
	3PIcBFWcuTawABMjRo/q08+Ik94wR7QEfy4EIAv7GYwyvQjan2XaMj6tTsZ+cEvLyWAGZjrvdnZ
	oCPkUYqjxv18XA55VqLkGlojaK1qPkvwphMYvlX0WpiRcDyW+ey0B5nXm9aNpgO5xzPL/zFzhiv
	c6qLeVClbypmXNTUQrXMUVkMXUfr1jiSWkIcwwUaLkSJRN0Jwz0ooCUg/OQ7bWvUbTrhgnCgU5i
	NuaGUNMXpcMwPJMKN8o7HtzLDUex4N7iU3nTjbX2T2NsjOb3Zrd+guZv/E7JNYJ66D89eltj9gP
	trhzPT8uxeuarXA4s/pKOlOnrzld6eTxUvdNlxozXIEz+pIZ6VXKzcGAsgIFP7YERZAHr87AW9U
	Efj4kmiK5GRw3XUtXr0/oyg+cgOTu4JIqUD64nAKiaUkO4Qw==
X-Received: by 2002:a05:6a00:10d4:b0:848:5d9b:687c with SMTP id d2e1a72fcca58-84e2bbcf64cmr1398945b3a.54.1784771028660;
        Wed, 22 Jul 2026 18:43:48 -0700 (PDT)
Received: from CPC-mjac-HKWGEZ.redmond.corp.microsoft.com ([70.37.26.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f18ba96sm1830121a12.17.2026.07.22.18.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 18:43:47 -0700 (PDT)
From: Jack Ma <jack4it@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jack Ma <jack4it@gmail.com>
Subject: Re: [PATCH net-next v3 1/3] net: nexthop: add NHA_FDB_PORT for fdb nexthops
Date: Thu, 23 Jul 2026 01:43:02 +0000
Message-ID: <20260723014302.994-1-jack4it@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722152346.GB3022830@shredder>
References: <20260721-b4-vxlan-fdb-port-v3-0-9aa0a543a78a@gmail.com> <20260721-b4-vxlan-fdb-port-v3-1-9aa0a543a78a@gmail.com> <20260722114621.GA2928696@shredder> <e48c03d5-8056-4b65-a651-5f57c1a4da9e@kernel.org> <20260722152346.GB3022830@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Jul 22, 2026 at 06:23:46PM +0300, Ido Schimmel wrote:
> > No preference on dst_port / DST_PORT versus other options
> > (NHA_FDB_UDP_PORT for example)
> I don't see a reason to make the attribute overly specific (to UDP and
> FDB), which is why I prefer DST_PORT.

Thanks both.  Done in v4: the attribute is now NHA_DST_PORT with a
matching "dst_port" keyword in iproute2, and the internal fields
follow suit (nh_config.nh_dst_port, nh_info.dst_port).  Validation is
unchanged -- the port is still accepted only together with NHA_FDB and
NHA_GATEWAY -- so the name is generic while the feature stays FDB-only
for now, exactly as you suggested.

v4:
  https://lore.kernel.org/netdev/20260723-b4-vxlan-fdb-port-v4-0-46e3a2dd88a3@gmail.com/

Thanks,
Jack
