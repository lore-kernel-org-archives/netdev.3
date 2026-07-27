Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908D02C15BB
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196502; cv=none; b=tbL4NX3bDn9VcIujgtM/1+viUVO1q9wK2uDHmoiTuhcJ9NsbdjBrbPG8kw1cGa2ar3w84raugIcDes7zRr5KV0rBThW30HwwgHECrgYUzpuk8kv+pYmCZHlLk24mmL5/QJFSt0pofDddCWu7xRw3wXD4i8wjbZiXjXQs1A1Y/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196502; c=relaxed/simple;
	bh=BAwmK6l66+CenVijoYCPH7iiKWxHptCzPpoJ5GGRuAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCrn3eDgjVLP5HFII7bwU/+szNfTZcS3EwN6v6M13KqEBGZnEHUrYUPzIaGvmWqWUxF8/Ak3WxU6OeVz9bV+GNBSGuwkF4yeZCDUrWs7dO01uwap100eFjj6D87ruWs8UtmtN4CeU+4AjWuvqjlDh5xDnBnATBvfOrBszqrcxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFDH1x6F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFDH1x6F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B891F000E9;
	Mon, 27 Jul 2026 23:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196501;
	bh=E5FIT+D1YkRf8OaNralj7PRkG2rKvzIvHpZowMmCOWc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VFDH1x6FhoNPH8ibhIE43xgvyGJ24+zr7Hn89a1BEBq9+jlDKAvgbdkKTTJpvox0L
	 xaDWh9NeO7jPbZlARxjj6EUWQlHUg+LJwj+fe9fXDvK56u/ysFG3eTWDkJrtJIxc2H
	 9CaHrUiqVkKErHJf/8alu1JmtEJ3Nrl+IA8uYT2B7WlJ6g9tmEIqaUYt4y8HpFllVk
	 NMoG0oWYAXENWHWJiX+5rVwJV1Hr0pBDDAdm5ZE0nJPt0dEyQjtCxB5P084V5j9/Ws
	 vfeLDBv10T51/SMTB9PJ4Q7nTLLiuiTqdXYb5Fgkp8XzElcNsarTjSk91UCMyoXpnF
	 wsIo2sWCyxYrQ==
Date: Mon, 27 Jul 2026 16:55:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 mohsin.bashr@gmail.com, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next v3 1/7] net: ethtool: add hardware pacing
 offload support to rings
Message-ID: <20260727165500.46a46ff0@kernel.org>
In-Reply-To: <20260726202902.760552-2-willemdebruijn.kernel@gmail.com>
References: <20260726202902.760552-1-willemdebruijn.kernel@gmail.com>
	<20260726202902.760552-2-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Jul 2026 16:28:45 -0400 Willem de Bruijn wrote:
> +		if (offload_horizon <=
> +		    (u64)READ_ONCE(qdisc_dev(sch)->pacing_offload_horizon) *
> +		    NSEC_PER_USEC) {

Let me just quote these 3 lines back at you.
Translating from how they make me feel into polite words would take 
a while :)
