Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795E23817E;
	Wed, 10 Jun 2026 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056987; cv=none; b=Vm03Yz8EK+JfaIEymGcGTOX5zDqYCeoVzVbvL1zjjsAijdDlf1HU5mmjEwBrXNoyqLeH3WcA1AOEAogSAKoLP8FwKzbiujfVTKkO0LhI3ESJO1n6K2BRPMOnkj38nfZIQ3/b6xbNDpEA7ULcWKPB4P1zFMHwcwu4AVXeFgE3cUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056987; c=relaxed/simple;
	bh=W/5i041repKS0mG5elrQdpAcF0JJTGFCaAA6m5EyEgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZeSZtFQ/V85IeOUNNtw2SAZ38HibNTkFGsfNoR81WlVmiSiw/3HdNBs983b7Z/V4EuboVWe9zushEam4F5cfWZwhK0/zyw7Z0U1XNCX7axssEvqLYz8UIjAh6N5hYmJk7bFKB574ex9zzEN92dEn/a8yHvgZqBT+vI1xKCVBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+X11G5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+X11G5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931B71F00893;
	Wed, 10 Jun 2026 02:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056986;
	bh=7l48xgA2RCbzfca0T82uFke0CpEFcH8eHBslok+lvCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L+X11G5Ix0WLRjS1ahDSYpy9KkQXYxZFk3bu4mR4HCbJmtXL/quMl8hRM60xBd5iD
	 VwSmOBjEWF6s9U8/UFD9duB5DCaCf6I1Y7fBthwyE92M3O9u3XbURB/mHZSXZF1erw
	 YFB6xmYWDT8N4Hz3Lke1e3sD1ym8R815H42D3R426c0i5GgCu5qcW5naDoPqsnHlGH
	 0hcvEaHHaZxToBJCh7DvhlRkeOlMayOnB2ywW+gOC5BiUxt4VvzfHq9KehjoczWSZs
	 y3oZKl2d4/klIGa4l75keBifWleSJfGFim7aW03/gI2UUDwGniMVJu0WzBp5BW7Ejt
	 ev19jIm2/gkCA==
Date: Tue, 9 Jun 2026 19:03:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Ioana
 Ciornei <ioana.ciornei@nxp.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
 <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v08 4/5] hinic3: Add ethtool rss ops
Message-ID: <20260609190304.0e08826a@kernel.org>
In-Reply-To: <c9945323626546592031f3a2c65c798cfa66fdc9.1780907605.git.wudi234@huawei.com>
References: <cover.1780907605.git.wudi234@huawei.com>
	<c9945323626546592031f3a2c65c798cfa66fdc9.1780907605.git.wudi234@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 20:36:33 +0800 Fan Gong wrote:
> +	}
> +
> +	indir_tbl = (__le16 *)pair.out->buf;
> +	for (i = 0; i < L2NIC_RSS_INDIR_SIZE; i++)
> +		indir_table[i] = le16_to_cpu(*(indir_tbl + i));

This cast needs a __force

drivers/net/ethernet/huawei/hinic3/hinic3_rss.c:771:9: warning: cast from restricted __le16
