Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C13396D0D
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021617; cv=none; b=h5m+aG+tyZm5c6GYC5ooHccqe9O8GqBpN5m1o0fAxsvXq3tsxo+JutVOnzDpYqfgt/pDhK21gUHYQOhc0fVdgWDTxXOtbrnuuHTvg+/p7LA7B0vf4rc9SVdZz0Dbp1ae9a8KLwNUtZmGtHdRt3Ya2Qn4t3/ChT4J/2cU0Ovsa0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021617; c=relaxed/simple;
	bh=ego9dV+YELhNLRK5iLpAykCauQjIGFkXb1T2o9zi+C8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8EfIIWN0Z47TlIR/tMkGqwv3HA3Ad6AxgOp3uXCo2QmC3U+EBwXKZlG4Oj3kQTsX58zPLaqwnwwjTKZpoyXCbbAzDl5Stogk3VdeUPreZ+okdZ9pqDLF3+srUztB/zNEnRWHBZ2kQJ81wLtSs9wqY60nxAlqApkeTXgIgORpCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvK5L7O4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvK5L7O4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D563D1F000FF;
	Mon, 21 Sep 2026 20:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790021616;
	bh=3OjbXjhGeiI5DNampLyJ1FplkxjgVN+03IgSLJLTNpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FvK5L7O4Sz5deW4AIw859jXKW3sNXAa2ebKAX6YaaQsN4TtR/iSeiixT5SRw5v2L8
	 0tkKbOuolE/zoLWOunbkzxmQDdfjMEIi6wC+nPvut6Be3K5myIyYX7MBQOtwu/u/wX
	 LsYiOqM6exIT5CFVAX/JSIoA1M6pLkBE/ThQYSbxHyOu88VHAN/vR9i55tcTz827Qq
	 QfVKW0DeqR1M/oTNUt8Kq9bfCx/4POlUyT0f3hEe5Z7PaVRZT2pvqgOeaFk4u5Di2N
	 SLKkqjMZNnn6Ha5Rim3+bgq4ii3Zb+mzFbjaZ2F7OHr/4eQtXj29wdp7/9/XWD+dA7
	 Ntd80cm5ZKKsw==
Date: Mon, 21 Sep 2026 13:13:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pei Lee Ling <pei.lee.ling@intel.com>
Cc: andrew@lunn.ch, netdev@vger.kernel.org, shubham.das@intel.com,
 siddaraju.dh@intel.com, balaji.chintalapalle@intel.com
Subject: Re: [RFC PATCH net-next 0/1] Add Clear fec-stats ethtool handler
Message-ID: <20260921131335.7f2dc18e@kernel.org>
In-Reply-To: <20260921154637.2376544-1-pei.lee.ling@intel.com>
References: <20260921154637.2376544-1-pei.lee.ling@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 10:46:36 -0500 Pei Lee Ling wrote:
> ethtool: Add Clear fec-stats ethtool handler 
> 
> During optical cable re-seating, transceiver swaps, or Bit Error Rate (BER) 
> troubleshooting on 25G/100G/400G+ links, operators need to establish 
> a clean baseline for physical-layer FEC error counters (corrected/uncorrectable blocks).
> 
> Introduce a standardized netlink fec-clear operation using the ETHTOOL_MSG_FEC_SET 
> message type with an ETHTOOL_A_FEC_STATS_CLEAR attribute. This provides a consistent and
> non-disruptive management interface that can be uniformly supported 
> across all required drivers.

What do you really needs this for? Some local testing?
Any real deployment will be computing deltas for counters
so resettings counters would be meaningless or worse it will
make deltas negative. Perhaps you can fix your tests ?
