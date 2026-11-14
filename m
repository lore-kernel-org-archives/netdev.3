Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622978;
	b=ybEK0aQnhnLq1T9mSZIacABZ3FuUmVKPj5qYby88N6FFsjARDC1uiCTlsvqezKaR+aHb
	 bTS6qa4y1HYHRcC2fLoDGkUXrTMrHF6N28woSxEAmdM2LC6s16qHCNRryYf3/M7r7d4nM
	 qyx/LqJ+qIZTX1qgFsch1L+OXwFqNJ9MqZCmzv0+jcW2gjkO1Xr1VGlpokrrWtSVzM5cD
	 8I7PMx91HTzgXAN3lE1gzmkvaCEyjF7DHFm6uVb4ospujNE4AJdhj3sETm6PUJbxzcSjP
	 Fbuh6r0ZHNvBCF+JgqlfW/g7AJFxdorz9t4EkbVuM1Blj97BBdfHoUfRJ/PBte/FkeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622978;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ri1xlRxHn3PpAwAsX41UtDYJGQ/Ua6qS7HlCwHPYiP4=;
	b=L3kAVZs5Vpi7JKF75RCYk2AVSp56HPnMPkeM6ptccAkXfBTEACi/sA5gQxbgMPcrZJHQ
	 z8hStvMHMif7Q2TsHBaucTurH2LQJd45OP5hMgYyRd1SgwjSstI1wbXEXsayAjddCbvmk
	 +zms4yA0sLjY4XPKKzeALo/AjSb8AnMz+x5cq4Wyls+YuolOUWOKV1L4h0fRblYOX6Xfp
	 FOZ6XdzQuPtOdyBq1o9d1p0C47DJ2KiqqnRNLVNaLgAc8FlOI9Vufxs7/RbC8tfvy+z4Q
	 qRv7fTR3rQo2RsCsPuaCBhVunJV9wUKV/AfFB7nLjJngP38mJNf3jUnhJOPH9X2ie3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGXCURLp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923D0606A327
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hGXCURLp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9EB1F000C4;
	Sat, 14 Nov 2026 02:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794622978;
	bh=Ri1xlRxHn3PpAwAsX41UtDYJGQ/Ua6qS7HlCwHPYiP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hGXCURLpMDBkBreCj04UGv6zlq0e+mBMIFmOl9WSXeOndIm9C9IWEAQuxOKF8HhSA
	 KyYXkJTRLuCkNlzwPUJrIHi2AcXhycnCv0CE2UP7clHA8WytXpMjl29fO/4oxVVXS1
	 +cGTaw1X8j+RUEYrSZtZy3NkrvTztd+I13wLSAmZ4ppRl+JbZcOr6rn4qd3JPS4Rzx
	 l8ZS9qxmnwU4Lhgy3Ehg5lCqiyB1rdhf3kpqiG7g0Tb6ug0EuViK+T08TT4LkkHB6q
	 0RO9+FXyari6SaypOKcOUY9hjRCw7lP8Fg0K3nQoOw45Mat/nfJqnEt9x+1MlP3/Ed
	 +yAmTlbugb2/g==
Date: Fri, 13 Nov 2026 18:22:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH net v2 0/3] rtnetlink: fix truncation of dump entry
Message-ID: <20261113182257.68bb7758@kernel.org>
In-Reply-To: <20261110172925.3293312-1-stephen@networkplumber.org>
References: <20261110172925.3293312-1-stephen@networkplumber.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 09:26:15 -0800 Stephen Hemminger wrote:
> While analyzing one of the OSS Scanner dump reports for iproute2,
> a bug was uncovered in netlink route dump.
> A route dump whose first entry is too large for the dump skb ends with
> NLMSG_DONE and status 0. The route and everything after it is silently
> dropped; "ip route show table 100" prints nothing and exits 0.

I agree with Ido that this is net-next material, please drop the Fixes
tags, too. The last patch no longer applies, please rebase and repost.
-- 
pw-bot: cr
