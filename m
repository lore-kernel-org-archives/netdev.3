Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D4455619;
	Sun,  4 Oct 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791125128; cv=none; b=VtUKHI7htjs73F2fVsy8qW9UvCsfn9CGj0akmPgwjU9FasFx64P0WVRvGvg7mCkL458hf2Y/WdN4/37G7VJ4A6+GJQt5iRR8SvJjvFCYss1iti9nBnTqDkvZn/hv+1oxJ6JfYBFqTbLKrhLJ2XWPDYgcrU0e51AN3d48UeyzcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791125128; c=relaxed/simple;
	bh=b5HU/UHLmrAopsEUI7DjH+Rr21xBEqf7j1jORuMJ7dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9oL7wmtxm69/tu8S2XnXa+TlcUxNc0FURvJv/PQqTOhJcJiwub151Z1PBjyqxbfqGYovU88boCj+9r8VC/2vP3e6irz8sAvNHbfnXcWllGgDlFUW9tfQzX1y1rj2EhYiJuPPvK0781CvQPq5RMjlNGFfiXZwmRI53H7gwWNtsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OTkmtRNA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OTkmtRNA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zx/CoOu1HuzQ3qCq3whgDNdU4gkodPjsS56YvVj7h6M=; b=OTkmtRNAr0ev+xyLTHe7Rz0TTQ
	qgokJtdM6VBLXR3D0gzlhOi7y4Kaztl0ZUYhL1dtsgzLhPLNWadasfB5l5EBtg2JdDaDJxge+Dw/J
	ScL/Zvq38f3OeFWMDrNHEiKCN0wxYaiuFwPHA6NCtqKBtw/iZcsdLs0vSrv23xdxv65c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDNSk-008tXn-Re; Sun, 04 Oct 2026 16:45:14 +0200
Date: Sun, 4 Oct 2026 16:45:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: Re: [PATCH net-next v19 5/6] net: dsa: mxl862xx: recover switch
 stuck in MCUboot rescue mode
Message-ID: <35da2f04-0797-49c0-9926-62eeda9798e3@lunn.ch>
References: <cover.1791035885.git.daniel@makrotopia.org>
 <dd243fa0df46b0cee4caf155b0388ea1702853ba.1791035885.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd243fa0df46b0cee4caf155b0388ea1702853ba.1791035885.git.daniel@makrotopia.org>

On Sat, Oct 03, 2026 at 04:53:34PM +0100, Daniel Golle wrote:
> A broken or interrupted firmware image, or the sticky rescue bit, keeps
> the switch in its MCUboot loader, which exposes only the clause-22 SMDIO
> download interface. The clause-45 firmware API never comes up there, so
> an ordinary probe would spend its whole timeout on a mailbox nothing
> answers before failing.
> 
> Assisted-by: LLM
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
