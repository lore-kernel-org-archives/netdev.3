Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12A3A0EA5;
	Wed, 17 Jun 2026 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688424; cv=none; b=SuyyoYum3Zce6Z4KOKj6Gns7qJpHW5H+6u2F3K/l1I/vvj/4kw+Nu6p4wJCDC0S/3RYDeJbuGem+3UHFtVCod9M/wknqs0gyDkVC8fDfFr4cCH49dnwPKWXu0CsqbqXv1S91UFUnO6mqcV+DbtBSDoBBlKd/5AMwX2NRHXpLfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688424; c=relaxed/simple;
	bh=NVa0tojqEi8YSdZ8VmhU38zNVq4yYH9d7MBub3B610E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rClRao4hVBmTqTat4XYua7W8LrPbe2lfdaHM2y6yRedMSFSai2hx2L2Whd26WKQwDAH8uS6yb6jbh6IQbU7D1UybkZJv3jsgDW+QmlWFxNBu+NU9NSRyM+yVtAC8E6j+bHHBFzQ8RqYC4w+hbqgEFDI5mK/37NCccg9HWhRW+V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aR8nNYp2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aR8nNYp2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=r2yS8mg0I1Xq5cyNHdg4EeK/NPxaF7wQvpyDjjFT2Zg=; b=aR8nNYp2IxLXVxM6nyI+XHrGp7
	GVkBDIuDh3WzQQtPt6R1w1ZU6IPUBSsejGtYTUXn7dyVhnAT8bE7I+pgqFL7erSXoelmRUdiiPOJ8
	I6nwE8zDBsBaai7eZaL5JipZWmGTTIoDcmH+9WuV4CXybfH9IbuXbQaI5LFCeQONBpaM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZmXm-0089lq-GY; Wed, 17 Jun 2026 11:26:46 +0200
Date: Wed, 17 Jun 2026 11:26:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Ziran Zhang <zhangcoder@yeah.net>, Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rocker: Fix memory leak in ofdpa_port_fdb()
Message-ID: <61892bd4-7368-4cd8-b360-0267e5c47156@lunn.ch>
References: <20260616013245.7098-1-zhangcoder@yeah.net>
 <1446e974-0df0-4956-b2af-7a9403da3c8d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1446e974-0df0-4956-b2af-7a9403da3c8d@intel.com>

On Tue, Jun 16, 2026 at 04:29:59PM -0700, Jacob Keller wrote:
> On 6/15/2026 6:32 PM, Ziran Zhang wrote:
> > In ofdpa_port_fdb(), the hash_del() only unlinks the node from
> > hash table, but does not free it.
> > 
> > Fix this by adding kfree(found) after the !found == removing check,
> > where the pointer value is no longer needed.
> > 
> > Found by Coccinelle kfree script.
> > 

Is rocker actually used any more? I'm not too sure of the history, but
was it not added as a way to develop the early switchdev code? There
was a qemu implementation of the 'hardware'?

Is it still useful? Should we actually just remove the driver?

	Andrew
