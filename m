Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09938538D6B;
	Tue, 13 Oct 2026 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906811; cv=none; b=ErE5GgN8HuiAEIouRe/l4CSXIg1AOCKyACUD5hM9E3mHHBJnYuDhfBdwEbgB6j1RxOugLLevAg0+EfwlmF/SHeVuysDe3Qnc1ttJ1jNbPN9OAo8vMwrSXxBoyJ8zC1M7culYMcELffP/m/OWpn08YlWSfOxUzavsqqY+gAePELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906811; c=relaxed/simple;
	bh=xUnvRm2acvjNtMVWOwJ2uQbbtHX+DX458hlhln26ifs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzOnzikECO5yy3/PPcZ4TGdDDahMcigGzaIkfRVqSDJ7KXjP9tRnM0lHTrNHsJVFwbiK1r7Y2RRWBpuqwISnd4V3iqGBFEZxkRn0ATU46UG1/ZVZZ29EBG3+IpvOzstFtMwvfXf/hHJx3xY98db/+h+3SGcUQPYI3t9pheHB0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UFlem6oz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UFlem6oz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WpprqyoKKf4vuxMGjK2g9YtANlYKQMF5MhtfhZUNOz4=; b=UFlem6oz+4hs7ursT7ydqyOWbM
	dx2n+GsyBOaphr/wkVWWZ9XRt1ZCys9NWS7LCdjx3yB5eaAtrbEg1o8zk3gR+1qI1tKRYcZMlbkxB
	BjTPJeL7vV80EI4lydeSOlexDXSBNm2aGuXdS2Ec77fGT9VpxM6TwjIHpH09JiUyTmvM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGeoN-00AYCy-QS; Tue, 13 Oct 2026 17:53:07 +0200
Date: Tue, 13 Oct 2026 17:53:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>,
	netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>
Subject: Re: [PATCH net-next v14 1/2] hinic3: Add ethtool statistic ops part1
Message-ID: <e67529ea-6f6d-41e1-acbb-86f63d44daaf@lunn.ch>
References: <cover.1791858167.git.gongfan1@huawei.com>
 <441404dcc8af513f5c3dcee2fd88cefd5b888def.1791858167.git.gongfan1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441404dcc8af513f5c3dcee2fd88cefd5b888def.1791858167.git.gongfan1@huawei.com>

On Tue, Oct 13, 2026 at 10:15:03AM +0800, Fan Gong wrote:
>   Add PF/VF statistics functions in TX and RX processing.
>   Implement following ethtool callback function:
>     .get_strings
>     .get_sset_count
>     .get_ethtool_stats

Please break these into the standard statistic groups. Only
proprietary counters which are not part of standard groups should be
reported via this interface.



    Andrew

---
pw-bot: cr
