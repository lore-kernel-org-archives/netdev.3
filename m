Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5BA4F4CFF;
	Tue, 22 Sep 2026 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077734; cv=none; b=JPw72Vbd7MD0k9O4Ln2kXBHfyx3p7vbSSnEGSF79mspn37PEr+3i5oOv6Mw+pfGe3XHwp/hZ4iBls4hmef5RODckKWBA/8v65AVbcQDBGa28MXHSDKVBdkRFdiWbZqVE2F1D/m8zjpQHYNVgebtMCmBuTsoOtN6CymY8ECL0lrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077734; c=relaxed/simple;
	bh=vW1Ol1BVKUr1haiJQnrDA/kESi2UGu6ZufvqWMjgDcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTvt9o1YPE7pprt2xxyV1Bp80FbxdXPJJkip83gpSyPHmVKS7eZTFl+vS+8DYqVnhRpxg6+xgw+jCQBUGv7YY5AxGhc277LrulvI3XTRnCvhZrRa6C++NPmiAF58T3MJYyGUxO1Cw0tmHuAOLCQCgCm/8tJF0wv9QeGNRSlRLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z0O+tWYQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z0O+tWYQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NMTJ1NkWpe9BZuhiFKqO3Dp8+T7bLXsGAjYG1UAn3eU=; b=z0O+tWYQoNeI9u9qrg0RnxBlud
	VLQnTw9mP21mDzK1DgivRUTCQow8LMRoTS/LHROjn5608SHSeq8ZwnH7cDSWYnbaWsr5S2s3oA118
	6od9ZKtM6V4dt6aE7JE2pkbKIOkXz0YTH7fvwir14rED615tguQvfWJKlPrhaAnkfPSs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8yzN-006Zi3-I0; Tue, 22 Sep 2026 13:48:45 +0200
Date: Tue, 22 Sep 2026 13:48:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] net: dsa: motorcomm: Fix register bit
 field names
Message-ID: <47557718-605d-4a58-8670-cd9f1481024a@lunn.ch>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
 <20260917185010.3189199-5-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917185010.3189199-5-mmyangfl@gmail.com>

On Fri, Sep 18, 2026 at 02:49:51AM +0800, David Yang wrote:
> Review and fix the incorrectness in the bit field names. No functional
> change.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
