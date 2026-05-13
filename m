Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B137FF58;
	Wed, 13 May 2026 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711435; cv=none; b=NF8q/tpRcUGa6EoH5bllFibOPr94vTwsgFPzYlvg4JVM0SpbedZoTPysJbAupF/37MBKPvb/1U8pq764urJc2zfCHhG904hFV7lztO1RX5GFuaWCz9+ml1GetxIv6BJeSyNOWeB1xOE6dwn1dk29YfwuKCXhOuIZv3ULGUeNo88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711435; c=relaxed/simple;
	bh=NXP84lvtAJkBs5OOdZdw6bPQK+75PbJWLaGmXLWSShY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSd6Rn5O3/ML2mN9ZzISggOqXyCspQzTAvgXfcEVVAbvR/hZh7aH+AQvSAGss+wp4IE2WQwrEAV+IOQr76DDiTX6Sr54PDRgZ4jcoOCPdlxnSogR7z8rogy0/4dat8b5XgQPKfVbgNKf5Vti4qpQ3EcIIY7k7ctKU2CXQYc0JP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4TH6LM6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4TH6LM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13150C19425;
	Wed, 13 May 2026 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778711435;
	bh=NXP84lvtAJkBs5OOdZdw6bPQK+75PbJWLaGmXLWSShY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4TH6LM6bGmxdAlgMIZO6VtcI8hx3CftdRZ4aPCbeOlzQVExWwd4w3Evu/R9yMCZP
	 wcSqjdkQNDxLABPVTng9+/ajTM4dVa60LMhRK+tURkrti/gZv+33zORrnQJd9LhXE4
	 U0N1CkfPX7eBHjoezWnrSsDRpj+uaS6/kMxgKS7SdUjyfpzDDpJ0OvlZire4CxVWAl
	 4fqp0nb3SZq1Ix5xCceW5a3i7tGfZEN+UGyzjHE73jTb6ljm4paDQkSkRZz3jzKRD0
	 WU1ucSQPSKM5GgSsWyXXumIjUxfHqRhsyIhSNNoZQ8xRFAkV2IY0xg2npe8KysmCtb
	 DaCr+iYJ85xcA==
Date: Wed, 13 May 2026 17:30:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: edumazet@google.com, o.rempel@pengutronix.de, pabeni@redhat.com,
	devicetree@vger.kernel.org, kory.maincent@bootlin.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net, krzk+dt@kernel.org, andrew+netdev@lunn.ch,
	luka.perkov@sartura.hr, conor+dt@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: pse-pd:
 microchip,pd692x0: add port disable GPIO
Message-ID: <177871143033.2145977.6127255354690890686.robh@kernel.org>
References: <20260507104720.262641-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507104720.262641-1-robert.marko@sartura.hr>


On Thu, 07 May 2026 12:46:54 +0200, Robert Marko wrote:
> Microchip PSE controllers have a dedicated port disable input that like it
> name suggest, will disable PoE on all ports.
> 
> So, lets document that GPIO.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  .../devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml     | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

