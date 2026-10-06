Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E326331355D;
	Tue,  6 Oct 2026 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255282; cv=none; b=Ugq+WO7AP0R6i2Jikqo9Ndm6VJf83A4JcJxs8MS2R2ZGtJrNN3GUz59Xl5KnBDmeBW1Wgzpt+2o2y2eG9yYR3PsRhypBCa5HcyATZ1l+J0HXJdec9W1iLj1jBS0AkLalfZ9RE9nVfHuF9uowpZ3HaR8yuXspqMXSpZrdNCOB1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255282; c=relaxed/simple;
	bh=zyf6fpGJ9fGW+qLGHtHwtx4VqZ+EdkgC7p9XwJMEeH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN7ss1pKkh+4wOblgggBR05YcD0Vg6ypG8TNcRosz0RxRfhfGbsdRxcse5jRr5lOyJKmYG/ZLt5JPSKs7OW63MZY/fwlW44mdkcLfA/Xljq+vM9LqJgrz2scN0iBj4ptIFjUUeK6QKJ0x29ikd5oc/EnFHUyrGGHK6mK/Jfo+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJBDTf9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJBDTf9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0FF1F000FF;
	Tue,  6 Oct 2026 02:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791255280;
	bh=51aaeKYcGhV4Kb7P2IAuLi6lYCc3jqwrtXLEV3iE9S0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aJBDTf9RnukTCL1NMcFi0rkBNE7xK2WIqej2ql5t525WQf1bi5QAi0I6PG0N0zxe8
	 gykIkPwJzmcMQk8QbvAbC8w1Gf0WlA5rWeXnuXAlPD0SdY3tRKBlNTvLxheuA+9qkJ
	 rgQWA+WUhvQKDNB1Vrc6puBIhmwMCzPWmK+JpfQIuqvBWu/MFfKn15DD+n254gNTw0
	 4TcFZUan9DiZ6TETSWVe6q3NlcBGJ3KMtyjRNVTO6kCW9A62iQX6kd3NB6zWI3zHLF
	 e0e+AjlZ34H3JhlzHY2OvBbz3VdioJulG4uYXQNFlHJPMnTeT4ABO4ziExV8zzZySo
	 83u44AcDIYAZg==
Date: Mon, 5 Oct 2026 21:54:39 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: krzk+dt@kernel.org, xiaolin.xu@motor-comm.com, hkallweit1@gmail.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, ming.xu@motor-comm.com,
	pabeni@redhat.com, jianmin.wang@motor-comm.com, edumazet@google.com,
	Frank.Sae@motor-comm.com, linux@armlinux.org.uk,
	netdev@vger.kernel.org, kuba@kernel.org, andrew@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v24 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
Message-ID: <179125527935.3451194.3177043188168544519.robh@kernel.org>
References: <20261002153034.934814-1-kyle.switch@motor-comm.com>
 <20261002153034.934814-2-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002153034.934814-2-kyle.switch@motor-comm.com>


On Fri, 02 Oct 2026 23:30:32 +0800, Kyle Switch wrote:
> Motorcomm YT8824 Ethernet PHY is PHY package of 4 PHY-s.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
> ---
>  .../bindings/net/motorcomm,yt8824.yaml        | 78 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

