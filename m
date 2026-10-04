Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2C635F170;
	Sun,  4 Oct 2026 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791098828; cv=none; b=giFA7zx4HBDM210MhR/RiN9NpZdpGumpWOSY98p8op4VyWeU12bCxC7nvDejlV09FTz2m7PSeZsUKph2n62STCsT04zKK03T0gj8LJOhYqxldHMNbhQXiGvFDZP1oMbttjpeAmgjYpu9lZdOR3alDoZ+26/g3obCOTLiTtitLCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791098828; c=relaxed/simple;
	bh=l8rJJm2qi4mvsO2SSVFmre8ravUbeWmYFL0geCmXYCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l78wjOiY4aEPXEnngLA36Eya95EBAD9Zf5gyfH2K1Y3CXOWu51tP5/VjBLkxr2mMc3Kt0J+QTbNLIOTkWB077RHLRD7s6FXDaKh20D9mn89GQ50jt7Bj2v1q7P6ZZZjoq4GvxwcL8qgd9RN4xFmltjGU3UXy3dueBp/HloGcdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j6L6oCK2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j6L6oCK2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A871F000FF;
	Sun,  4 Oct 2026 07:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791098827;
	bh=l8rJJm2qi4mvsO2SSVFmre8ravUbeWmYFL0geCmXYCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j6L6oCK29W3xKZIydfGzl7vZyY66zLoUPzVam3i+pANhcBB9LQc7dnbwMBUNli0fr
	 f21KnLNhtGC1AJTD8fK2Yi5EumaNTQxcuLP4nTHm1PsJi3mxRFKzPCSWHggt3UmI5p
	 keYQa44sMBbphNlDvtIZneWXyeYW8KvQ+gtbAwtDXpilOqoCZo7H/3pp8EZPfznIJq
	 lDzxuU8FfCYdyMlk2WwLWsCF2K1OpK5pVtdb/PWEE5upuQpJ6ZWVCj46oRFG2r9GAT
	 IP2erQ+H4N62fohnB6LMl64D/g8wBF6Ux+55FUlOK0Z0jgpMhYo1YU2MI/Cjt1ujM+
	 O9zL4MqW3G2OQ==
Date: Sun, 4 Oct 2026 09:27:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: add reset
 timing properties
Message-ID: <20261004-transparent-cuscus-of-honor-8ccbb4@quoll>
References: <20261002135542.359756-1-giometti@enneenne.com>
 <20261002135542.359756-2-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002135542.359756-2-giometti@enneenne.com>

On Fri, Oct 02, 2026 at 03:55:41PM +0200, Rodolfo Giometti wrote:
> How long a KSZ switch needs before it answers on its management bus
> after the reset line is released depends on the board it sits on, and a
> board that needs longer than the driver waits has no way to say so.

Not completely. This is implied by compatible. Individual phys/mdios
have their own delays but not the entire device.

Best regards,
Krzysztof

