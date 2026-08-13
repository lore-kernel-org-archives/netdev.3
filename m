Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C189D30F52B;
	Thu, 13 Aug 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614654; cv=none; b=uZ491xkraZ2BvI6CPwDWLWlB4GFXYCkiweBOBwB12d5sasFeybzaWL1VijVQOiMmvYF3LIg11leqInti4jGv3UdqmErOF8TQUNhS4Fp56CYJaJRDO/+Rvfbu1NE8UMM82ft2baw4O2u+/xp5ypUJGPDDC+b8/dDowFTYw0k2K5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614654; c=relaxed/simple;
	bh=fpivq/z8TNO20q2uPslVLS/NYbfWoLAvfvw6PhyN8wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZc3D6E0jPGcmiROpvR8YcNnw3mCOoNVrEKV7VnABFFMXnwwj7OPbAcqeEduTmNOrRLg+C/8PnjYv68Eo3/6aV0C4Gzt1RKG0NhZ34YecMz3I/nPfr0SOpreF8TCjbY89NyVauoLz0MSZkgXpOlWSVn9QkoVsouco8CdhU+bf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg34C87U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg34C87U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8A71F000E9;
	Thu, 13 Aug 2026 09:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786614653;
	bh=fpivq/z8TNO20q2uPslVLS/NYbfWoLAvfvw6PhyN8wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Eg34C87UiZtLBJ3U5eBp7Djcw0UNIMZor5JJh4HHh7HzX4nGqEhcPBuv8yPOjR/GG
	 EJX9iY6+QKvA6WtevPUQnZ3LYp6TTNVuhgjS8LkRHvMZROds0c2sExW8yjD7VV8Jcb
	 WuEBt8SdnI4V9I/rWTLbHWS1oyEZ+xJVhXi0uVYzfQlaAKO9u9035mVHHteuKcY++K
	 rtAPtve9LQPnr1EhTNx9cBPuDwicCEavjJSp3+Y/3rpYHojMktF5VEY2/yBATfJ1MT
	 OkHMQb9P3TwidCDMFgP80iZAB8Hm+d5vDQypJoKunUx//cOAtlqhGscz0uRSE2Bblg
	 f+XEMLazKbc8A==
Date: Thu, 13 Aug 2026 11:50:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Matthias Kaehlcke <mka@chromium.org>, Fabio Estevam <festevam@gmail.com>, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: net: asix,ax88178: document the AX88179
Message-ID: <20260813-macho-analytic-mandrill-c37ac1@quoll>
References: <20260810-msm8974-onboard-usb-v1-0-08a805768328@oss.qualcomm.com>
 <20260810-msm8974-onboard-usb-v1-2-08a805768328@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810-msm8974-onboard-usb-v1-2-08a805768328@oss.qualcomm.com>

On Mon, Aug 10, 2026 at 03:42:33AM +0300, Dmitry Baryshkov wrote:
> The APQ8074 Dragonboard has an onboard ASIX AX88179 USB 3.0 Gigabit
> Ethernet controller whose RESET_N pin is wired to a PMIC GPIO, so the
> device has to be described in DT for the OS to release it from reset.

Would be nice if you checked other devices from this schema if they have
reset-gpios as well. I think they do (confirmed on AX88772 and
AX88772A), but having this explicit would spare us from validating it by
outselves.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

