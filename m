Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F394071F3;
	Tue, 11 Aug 2026 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434086; cv=none; b=R4EjYmP4V+/Y2lUmHCtLY/0u5fS2NBH3G2H5MNiz1xDHoKr9hs9jZUf69tVGX/cP1/hsG1cadse2/SZWWs5QxNaQFMy5ZHBbTwW1oebIvnngiGYxnhFdu3qs2YG8Y0i5jTQfv7LbLt606UFi9XHlzXU8HgS75yKqofE0e2bYHHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434086; c=relaxed/simple;
	bh=YE4zxfqoS718PX/VMay3qoI30hnw+4wezmUti26rmEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDO6Tt4N7N8VE32tBifJdSPIFDOiXtN1ptEsrd9HeP1bQLZ7PjQ6fNYnbBLM9UOFgZT5ELvA6i0nPbHbjPPhfDJRwgGelKoQ/AbkXaGYvfk9RCE/d+qqpf5nrqD2RjthiYbn9tCKlocP9C6kkIXc1TVNypE/GbGW600wlqQlWA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzsKM3uK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzsKM3uK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3CC1F000E9;
	Tue, 11 Aug 2026 07:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786434085;
	bh=8XuLWxH0rXtRYf+MARpPtt9gjBsSQOSsCHiXGGkzL+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CzsKM3uK2unKezMDxuF6LDW+N6NF5MzA2BMblRMQ8bqjq3zTACoIoNodrlexndzXz
	 An9WkyyvSBRIV/ALNA+p5Ifkrw118FFIu+PR9ItOPOAEN3vKiDS0qxTVRpeZuMXbxd
	 SVmKUXPLS1n9ly7IIKKruxLhY/uX525Wrd7TIDkDA7bGxw1TEhYUJlH0NP5jSei7sd
	 CZJJc2RchAwpLOCbuqswwTH+skPjDJj/C1C2yU8av92USvvyOJMuGsvxG57yu6x00F
	 gyY+KDG5pe0dB8LpujHS8/6oOsdOFBtIZr+XXz+PVWevlrNhZkhylMSkws+9810fWt
	 taMteTOxg6Acw==
Date: Tue, 11 Aug 2026 09:41:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: David Heidelberg <david@ixit.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Subject: Re: [PATCH v4 3/6] dt-bindings: net: nfc: samsung,s3fwrn5: add the
 S3NRN4V
Message-ID: <20260811-statuesque-likable-harrier-d5dbfa@quoll>
References: <20260807021001.239389-1-jorijnvdgraaf@catcrafts.net>
 <20260807021001.239389-4-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807021001.239389-4-jorijnvdgraaf@catcrafts.net>

On Fri, Aug 07, 2026 at 04:09:58AM +0200, Jorijn van der Graaf wrote:
> The S3NRN4V is a later part in the Samsung NCI NFC controller line
> this binding documents, found e.g. on the Fairphone 6 (SM7635). Its
> host interface is NCI over I2C like the S3FWRN5, but it is not
> compatible with any of the existing parts, so no fallback compatible
> applies: its bootloader reports a hardware version none of the
> existing parts use, and its RF configuration is loaded through a
> different proprietary command set.
> 
> Also document the PVDD supply, the externally switched rail powering
> the controller (boards feed it from a PMIC LDO). It is required for the
> new device; deployed DTs for the existing parts never described a
> supply, so for those it stays optional.
> 
> Assisted-by: Claude:claude-opus-4-8
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

