Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC92EC090;
	Thu, 30 Jul 2026 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401818; cv=none; b=J9X3i94NdHcyGpNrTCXrIL/bBDpn1oxgAgbrg+I9s/lrDZM8x0TKfVVL9F+Q2GWm0IGjohSwCcucti56yPt4s4oOZXOc3aQLYfGu6nktaHHhCa6i1QXX4zzf3eUyV46twpsBcL2os0deipoTaEUQT86KnSkVYZw4mM7jy8DU834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401818; c=relaxed/simple;
	bh=xEUzrLSfR31FUrCJxzV92n79SPsROsMSsC0Zl9xPEe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxEBEUvgoEXWw/uIwW8w4v+VOcYVKALn2UrgR1jvb0wCh2NDizxapFONUiruwZ2iC76Af1Omv0xJDBmpP4gjh3Hj3O+dE9ZEmHj/K/b25ea9DCRgpDl4t4LB3cVjIC5T1htTROXIo9MN5xXZpXoCPv2evqWLymIRxstprHc8cHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LR3A2Oqk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LR3A2Oqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE361F000E9;
	Thu, 30 Jul 2026 08:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785401816;
	bh=Qw/99DX4r42XpUlbuOhI95orDjDMjRH1edbN9M4IEWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LR3A2Oqky1dxDJjWFN05/iNQQtV02mEP6oNEwoY3uSZy7yi1cn5zL6zGZqrVxjHGm
	 z3Zup7RNGy9KjmglFASyTDlxlcWwvg5KEQj3DpqK34PZgYvC4obAQQcOvBU1yRoHDb
	 upF9mRxs/LI7dfhQ+G5kE09p0iXhIBZm9+6SH4jWyFokwDyr9040+tdYwFGn/Vhf4a
	 kOHhMqGNhRT65uwPRea6VJ2iYtNuNnlmMCwHQD9M6RvwfeI4XhbQ0VuZE5dDvD45zG
	 IPAdguVQq5MDJT/quLxtbfqu83Scwb/mvNWN4GL946g0IPvl7cFCCugDXN9N4SsmEf
	 pWAP14+DYW4FA==
Date: Thu, 30 Jul 2026 10:56:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
Message-ID: <20260730-positive-vagabond-coot-f9d8f7@quoll>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>

On Wed, Jul 29, 2026 at 06:36:55PM +0200, Vasilij Strassheim wrote:
> Add DT schema documentation for SoC-e FPGA switch devices.
> The binding is split into:
>  - a switch IP node describing the MMIO register block
>  - a DSA MDIO node describing the DSA-facing switch instance
> Both nodes are linked through the soce,switch-ip phandle.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

Best regards,
Krzysztof

