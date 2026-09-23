Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB03ACA5D
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172460; cv=none; b=oIIhyYEfOMAOGLP8zp1cfEZJ6w9mvK3Y1yXdKZewxL7Xif5vwLWPVgKxSspZgGRDt/TwdzclKjDuTL5ErkD5VCPtHxZaDXEMtI3FcZd21tA3VhOI0XyllgPZFKvOMJU6fr0wy2yU9eKCXSgCjCLW8uOiSjutOg7yRiGSdWMZyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172460; c=relaxed/simple;
	bh=qVO2aOXV8qOfQW3a+N4ntdYpNIUu+AmmtXveRqFp7Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMpKtypgEl4GGF+RyT9HtegWwKqUwzht5tbAynrb7Gj2bmT1CTVgK5dmQMl4D/+QiQUVPCNMXYKCuSUeSfKnRT97ewCt5+3uSZ+1Y3kSzhVVVdICdOMDe94MubHK2e4JnZ7DwUf7G7X0Knebhe35gDMNoCoiiyCcMxsUZ6u2okg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWtIoDBl; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWtIoDBl"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144ecebb6cbso417328c88.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790172458; x=1790777258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qVO2aOXV8qOfQW3a+N4ntdYpNIUu+AmmtXveRqFp7Jg=;
        b=JWtIoDBlcQZJO4S6+jJ/vWwBCVTyhXEo4M7CwqJdjgEqDzOT82PRdJkFBsdQoKmTJo
         HFvyvs6pxFZRyFh6jLz7k3HtxQAiwczKoOWMDCzSk4MiL34TBey2vlCRpTmypCMWKVnD
         LRoRpl3A9xGPd2OpxSWCKgCMW/c+YgGL7r+Jic3gQH8m5KV589G01UPWN++6QNrDT1iY
         7Voa4mK847ynZXQbx/4c9aYONnLyVDJquoWmZCAw/9FFnr2YJHezFC+CCPlpq9fTeGKh
         NqK8R/bBeUec19+KEw5uOk0g4mQzZ114hvpFMEC2CFxK1hxkWTSvKFSKGMpjYn7C3ChP
         sgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172458; x=1790777258;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qVO2aOXV8qOfQW3a+N4ntdYpNIUu+AmmtXveRqFp7Jg=;
        b=ZtQdiX8BP29p8RVBRAxhIz4CUp+u3Cmdx2CNWDCH+EzZAzqKgMLtQE2k7Qdoyayds9
         PRnKttxiGkIWErjIxm4nJHGd8kSN7jeUBmTZxcVU70ioXQm2oiK6kdmRQBm/pYs7uat0
         0m6r71VI2ZX1fgTmiuMc3wY4Y6J6oa1bPrsV04GMbXn7r2wHZEOrKCJ4hgBWobPsTYly
         gKXlQ53OqMIQNq1pJ9O9eVbSqAlfTTiNCREfqFgnZ7HVQ0HIi03lHdgmwkkgYNI8GUzU
         l6/3wsEfTcrUVpy7JjslNsYbQ8HV2F46uAF2Tl3HtRkiw5VAZ5yiPmYbIIGRG/AESK/R
         yddg==
X-Gm-Message-State: AFuF++kotrDSz5yrNDZkQXDAGeFqfiVl8nfEmq5/HDuIZameaw7zQXzI
	HSJCZBRXc99pruhaVL/JqPPTj6ymTxPN2GbJNGYvKhh0g63g6kmU3YhI
X-Gm-Gg: AYBFou17Jt1dLwmkjP7Jp/qCTmhI6WVODcbYGC7P/qxdlezS4JCknLHvDaVCaTBHdNn
	O9jgYQONTCVMd3vhA9QKE3pMy+lM2eZKwnVqaXCDUeRlPVCzUMYZo0NB5oUiS5m4KMwkuSVNRT1
	w7IRjYjoK877jRl/VzZo8+SsZJKEs4DWlRQGD8xhL2ywo18IgwiqEt1s/ZLu8jsxR6oV/W1rSrO
	vNVsjpUFcI5n0HydT2zB+YCXsAWW3eBdi/L5AQgzldvPAfGnYNxCpqFUzQo7cqmcj4+Hz3+c1N0
	sBHsshsgZtQ6INkSyd5sJ6upFWu2ckDhiQ9i4U/GBmrxYAmut94u05gKWFlCoBROktFQB465ESN
	AURkNR+OKjgq/3wRsKnlZEjxlz9usDYQNK+wJ4pHo//aNMmU8kD0Vmzmjcj8vWdjeWetVXATmvc
	9m8Lw7O/qdpJHqbxMirvpWPkM2gN/efM6rqW9cTtoG0Jx+SJL7ryfsKAjpdUvpcIjdAMmJ7XrY3
	Uzo
X-Received: by 2002:a05:7022:3c07:b0:144:f8a3:2eb8 with SMTP id a92af1059eb24-144f9086e0cmr2903706c88.9.1790172457980;
        Wed, 23 Sep 2026 07:07:37 -0700 (PDT)
Received: from houminxi ([61.170.225.122])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96846f85sm6391689eec.20.2026.09.23.07.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:07:37 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] selftests/net/openvswitch: add SCTP flow key test over IPv6
Date: Wed, 23 Sep 2026 10:07:29 -0400
Message-ID: <20260923140729.1044989-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179008950943.2160803.15856491533624064435@kernel.org>
References: <20260918144647.2024095-1-houminxi@gmail.com> <20260918144647.2024095-2-houminxi@gmail.com> <179008950943.2160803.15856491533624064435@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 22 Sep 2026 15:05:09 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Medium] The promised skip when IPv6 is unavailable is incomplete in
> test_sctp_connect_v6().

The /proc/sys/net/ipv6 check only sees ipv6.disable=1. ipv6.disable_ipv6=1
still leaves the sysctl tree, and a new netns inherits it, so the address
add fails and this test would FAIL.

test_icmpv6() in the same file does not check disable_ipv6 either, and
its ip addr add calls also ignore the exit status. Aaron already said
this is not something we special-case in one test. A real usability check
belongs in one helper used by every IPv6 test in the file, not in this
series.

No respin for this comment.

Thanks,
Minxi
