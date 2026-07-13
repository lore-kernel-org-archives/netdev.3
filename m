Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F4261B70;
	Mon, 13 Jul 2026 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923711; cv=none; b=inEjbE6bA6/HtF3sx8jH4ARSjjB2SvM6Bde0nKuGpmlJLzLyyx3gycSM/qo2Ni2xhlnVjvqupK1OQMf7xhto4akqzBbQORL/e06mTA7vzQbrJQKmk9CdITfBMl/8kHozV2LR7RMyZ/HznG351h9o+9YydHLkjzJt3SBN9Syibqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923711; c=relaxed/simple;
	bh=jNDNfyooiOnQ4+cl8linfC1qrE3LXmwVhskMhrutDQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm9kX9It3YVnS44ffKp1Qrm/cuxXlPLscnSdT0z8z4CBMtACVDwmUknRIW7cvWJMO7LDmlwkFAFSMbdBW23IWbNOhpLD9OLufmav9Nfr0Z+s61AuCcxWUtJcUx6vXlvWDztpkGViQw+kP0rSW/clV21tEobAF0Ru9BMetQcY33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2AQ7Qq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2AQ7Qq0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A751F000E9;
	Mon, 13 Jul 2026 06:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783923709;
	bh=kaTNv3bKzOu84AByAd/Y5/b77Y1B8vZd+CffeqsQ3tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i2AQ7Qq0KQFRL1idrKsEbe3jRCUAcOwNXf3LPx7/5PnmWw+/y1nB9Bm48XVizpGQQ
	 QdTXNYZLr16kFuTidjdPnOSVWzcciYpTv7ktmXqEyfTgIiOteZZ5Pw5nCkxX4Br/8T
	 PzwHNCY+ZM+1lyPscMKDesbjzAJhD+sHe3xruzf+7Q/wah0wLYkQjJrqHQ3fK5d2qV
	 dWg27f3PkOL5A8rCNZUmQ/pFemAQroIpeMURU6Y2OMS3PrJDEqxDW7rZVAVuSPwYHT
	 tjXd6LU+OnF5w/cnxitI39fbNHe25EMmlJZiR4k6VWmMsn+gu3ZIj4OYnjMGhSeBvT
	 qdNdHeyljBwnQ==
Date: Mon, 13 Jul 2026 08:21:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mikhail Lukianchikov <avermoal@gmail.com>
Cc: Thangaraj.S@microchip.com, Rengarajan.S@microchip.com, 
	andrew+netdev@lunn.ch, conor+dt@kernel.org, davem@davemloft.net, 
	devicetree@vger.kernel.org, edumazet@google.com, krzk+dt@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, robh@kernel.org
Subject: Re: [PATCH v4] dt-bindings: net: microchip,lan78xx: convert to DT
 schema
Message-ID: <20260713-polite-industrious-herring-2fb6c0@quoll>
References: <20260712113821.12543-1-avermoal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260712113821.12543-1-avermoal@gmail.com>

On Sun, Jul 12, 2026 at 05:38:21PM +0600, Mikhail Lukianchikov wrote:
> Convert the Microchip LAN78xx family (LAN7800, LAN7801, LAN7850) binding
> documentation from plain text to DT schema.
> 
> Restoring a mistakenly deleted email in MAINTAINERS file and fixing
> microchip,lan7800.yaml.
> 
> Signed-off-by: Mikhail Lukianchikov <avermoal@gmail.com>
> ---
> Changes in v3:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

