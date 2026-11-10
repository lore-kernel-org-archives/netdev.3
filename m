Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329658;
	b=O1N3j8bT6+/cU+7stPProNLSnzvqsv0CLEMrujqcJet9tZpc5x6o+dBgvRcnNySyycSx
	 SoOs3kbadNrjhMUznO2zxYvk9hItzl58jG/tRJ4XOktbirUx3cEMxmVT6Aw46Gx42CL7F
	 IGtE9jwQ4F/hL3EloUjkZ5yTFGhh4HMUZ/Qx9GZg0fstr86NkL2q6FSOyPNTPfm+BP2aF
	 39wSWGWcv7LL9I+Ek9/8TKixPjLVHtxlCD517SPIyA5a9ce5vPAPA97Fp3yjEQIGhuH0K
	 VE9M27d1PEpUrgYn0BIljIorAgLMUSt0sbK4YMkHTFnPraOEo4faPH9OGg7B/lhSApg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329658;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=zs5bt/5To5f9+9MXdJShQVi+jngx145IJ7lgHvq/EaQ=;
	b=XICk2qiToE5viUOPBHONC3eA7Ya5wE4lbJTN1UjbhzWwu0L98xhelJAuL2YVl0mThsMm
	 DHMWKgFpTzLsIt28sE7EEsJmnuwGGziyk5Z0ZrC6HTPz/isYAH3Ud6X/4upv1L32PbmIU
	 6oGRYr0+tB3Z5ZVF+Jfj6yuez+c6qPiTZQ0AsKxoK20L7nbtxfFD+MWr408VCkQJcfmC9
	 HW3K6u2gj3DuwbQ7nTW9JQcXoNh8kwirbjPndbloUvu7QBLP4cb6iyYJJ+Xk0cAiw9oCt
	 6pPE5BcgZqygp98OLF55OrGYYox/iVy2mMfJw1FuWsDK47NMLFgDLnJ1rEjFDfOtw4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fQ8eMqKQ;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D863606A9E6;
	Tue, 10 Nov 2026 16:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D863606A9E6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=fQ8eMqKQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zs5bt/5To5f9+9MXdJShQVi+jngx145IJ7lgHvq/EaQ=; b=fQ8eMqKQ9bOrJ7v3f0mp1RxoTm
	ZEExisguI5bkvkOXznOpekMMq4qB7aUyZdbsNJ3h87PNhDu7u5RvLQtm/PENp1XDsUzQ9BlRJ2h4/
	qv40OmLNb61PFxStZi/o0nL2VdonQlXzJ65fCp6tci0BpdPWG7vdzrF8xA3tU5p0Rhho=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQp6o-00FXHf-3t; Tue, 10 Nov 2026 17:54:10 +0100
Date: Tue, 10 Nov 2026 17:54:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Frank <Frank.Sae@motor-comm.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: motorcomm: add missing trigger link for
 YT8521
Message-ID: <d936a52a-57e7-45ba-a73f-156384f8813a@lunn.ch>
References: <20261110100001.1873309-1-amadeus@jmu.edu.cn>
 <20261110100001.1873309-2-amadeus@jmu.edu.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110100001.1873309-2-amadeus@jmu.edu.cn>

On Tue, Nov 10, 2026 at 06:00:01PM +0800, Chukun Pan wrote:
> TRIGGER_NETDEV_LINK is available in led_hw_control_set,
> but missing in led_hw_control_get. Add it.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
