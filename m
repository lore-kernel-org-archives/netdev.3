Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A833750CB;
	Tue, 28 Apr 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388947; cv=none; b=ukL9/6Pj0T0pIuG5iAiDglW0zIgPAnr/njZBe/5kggxIB1WQJjyR+l5xLsc62z/ZKbDKcH3MDXHzVP/7/zjyoPEqD26Svrfxzi9FI282vPE6vq7/V3WtGzCm+3ZAuieBr+nowZ49V5GxXFysZRPn4xos4wscAr1b6Za5715tVjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388947; c=relaxed/simple;
	bh=PzId5a0tFIgoI8ePje6nABaU66hUi/pkjgUJKKWBiZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDdLICUM47oCeyY014gJrTfImn/2/RU609ma+2xoGZTIJnUido/594CCwSroPHAIGAe2ozkF7jF5Lyop316er9+ITfvXn4tqkiLtDRRqAUfU90o3X6VqWcmkR8+2ejso2n2p/Ok3GrFAkhK2OYEfl4fwdZs0NXqlFQP2yAkxsSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3zl8jDGL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3zl8jDGL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+labt3RgifwinfBvxdLxys9917Um1xxkHFHMmsU6yNI=; b=3zl8jDGLNXVFC23OoWkQnMByUk
	hBSwV7cItI/i8NZsMXKcfGNNl+8/8FuyH8f2b3VkEXKSoQf4VMw9cKBoYwntKNZICVeV5Rv5T5xx0
	tmU4dfWhltjV9tpzwQXxqs/K1Ty3JldvY6h8ZuhI5jdWt2+49Ugtp17ea/CCMCYKULCM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHk3T-000MB7-7y; Tue, 28 Apr 2026 17:08:55 +0200
Date: Tue, 28 Apr 2026 17:08:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 9/9] thunderbolt: Add support for USB4STREAM
Message-ID: <ef5411f4-0e4c-4ac1-8ae0-0d557fc0ebd2@lunn.ch>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
 <20260428072209.3084930-10-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428072209.3084930-10-mika.westerberg@linux.intel.com>

On Tue, Apr 28, 2026 at 09:22:09AM +0200, Mika Westerberg wrote:
> Introduce USB4STREAM protocol and Linux implementation. This allows two
> (or more) hosts to transfer data directly over Thunderbolt/USB4 cable
> through a character device without need to go through the network stack.

Is this mutually exclusive to networking, on a device?

   Andrew
