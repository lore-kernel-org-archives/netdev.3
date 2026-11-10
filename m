Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316888;
	b=oGLu1BPSc9gn5LS0S0EwaGzMY5zlKDVRPL5MEKqn/yDRZfPV+Ap5BgOrcdrN1fUfHAKH
	 LlU87rFDvu6zzhhp48JuaKkkf15EuKhFR0tz2Je7tTk6APqZF9EHakWaB8aiaBkkiwWZw
	 zSfIeFEHUPQtSqYDn6mVvmfUy0NZv9gmYyV0/Sen9qIYiXUM359Uj/GpqtbYUhTb/5xtJ
	 SNZ4aec88TZFpUSoyyanTrE6Nv6bbfkcv9rSmwnB2n7oIIyGDtWsPXslaFDpEK03iR3LX
	 J4CPoSsJig33evQyk6ZOjVEJPLbQDcOpxHVwI6WynoRCUZCN4in91FK5MC9jC5uooEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316888;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=QpQfPYpI+y9c1llUQddkcpk9DlThXv1YGiGLiMFANjc=;
	b=43XSbQfNX8xpG5hpwOksTZwrULYthG4/AMBDFcShRBHLTuVQrJkjSnEwIxK51IVZvN9r
	 tTeKP3gE/b3yFARhvKsdi/XjQF8tbI/eh1KUUf7Q5YnL68lg9FsDmlERX+2KSkY/+DbJw
	 6AK3NyVHAnIzfximgNchBA3N/W3Xmr99A06T1Jk3+vi3g4Ryy21M0+Fd7dNVqGYDP9JFZ
	 /3T8yrifTDplFIcqh9hB9lUUvahjxHGMNpbPM8jOFnYfBV54z4hKcql317nKPY9dpEDWg
	 eskQzjL53Iy0zrGZumxrREmffo+7oSiY3M1tAX74JtUY5Vuu35ieOHS2KjJ4r+WffVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=6Hh1o9UK;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36960A6F4C;
	Tue, 10 Nov 2026 13:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B36960A6F4C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=6Hh1o9UK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QpQfPYpI+y9c1llUQddkcpk9DlThXv1YGiGLiMFANjc=; b=6Hh1o9UKTpaN3fNM5nslp4CAHR
	hFJ7MSu559jyP58a2kRcwheXI+5+5IbS3Rk7nlk2P19O5XFwyMlqfz6Hw+5OFBPzQ994f9L6nvPoO
	lopYaZaD8AONes34Z9DGryB9NSbyZOk5Ocrwk3jZhKQ+OfdjBactLEqv58V7PZG1SCZo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQlms-00FU66-Og; Tue, 10 Nov 2026 14:21:22 +0100
Date: Tue, 10 Nov 2026 14:21:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dsa: motorcomm: Fix RMON fragments stat
Message-ID: <0900eff3-eb99-4b05-814e-35e186264bd3@lunn.ch>
References: <20261107132040.1066996-1-mmyangfl@gmail.com>
 <20261107132040.1066996-3-mmyangfl@gmail.com>
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
In-Reply-To: <20261107132040.1066996-3-mmyangfl@gmail.com>

On Sat, Nov 07, 2026 at 09:20:34PM +0800, David Yang wrote:
> etherStatsFragments counts frames with a bad FCS due to fragmentation;
> report the dedicated RX fragment error counter instead of the alignment
> error one, which is already exported as AlignmentErrors and
> rx_frame_errors.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
