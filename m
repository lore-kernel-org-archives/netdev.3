Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481348;
	b=kAgwMc1NzR3l8MooinD8DAlqQv0kkv4lHcf6M+/PEN2Hwuou4gmHkHbeOzzautNiqMci
	 ANyvWvO7xEfGZsQkKg5uUY7QbQJ6sqJrkkDZ8hUCRhYN3QQO/4QhUnNd2/x6RWiMsitF3
	 1yFceGeXU5lWe06eSyjGZ09QnmEZg9UvV+PM6TOwnq7fsEN2+AMw+i9g98tWRWl6yJa4l
	 /qKbDm0jaIte4ZExz65W+TuI6frLV7OuRsiljqz1LGE8BpD6ITSCBxRSl3RBgpbFka/GH
	 BcdPQOfGPuyUxtowemUN9g4vIQAyi3bGpK0kFFytbyP1LP65vqpyVSUA0nOGKaqK5qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481348;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RAUVUkaVAJutQSAxyGsrEcG/xVcU2rDE9W8151Bo6sk=;
	b=rEc5lD5yTUcXk4hxYBXXu82/fbOU22NWdwZTeBeg7QDWnOtuL4fvF68vOeL+Cgs7fW89
	 8mhHbGJOHaAZze1YqeH9GkO0ZtGurrQqVggHQk4XdOnlJKMByPSlZuSDl6Rb+LGXNqy4h
	 dgNdJPJvpB4f5meRIBfi2+qrkgdIYl9fd7D9esCh6Iamq+sGmrRBkoq92yxRSUcA2XCcD
	 k/H/l6nTtkL8x6hOBMYTYQuZTjLfzmSlkXdJJQOaPqISQgd63tJdlqGQ3aA3R8gUDyFfE
	 8yrCiz94SIA/q9OW1BSonu3gci9eALarUkTKOBFSBm4YIx7y1WDuVbybGFgoXDM1zQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZzuWkX5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB11606A321;
	Thu, 12 Nov 2026 11:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZzuWkX5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82C01F00A06;
	Thu, 12 Nov 2026 11:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481347;
	bh=RAUVUkaVAJutQSAxyGsrEcG/xVcU2rDE9W8151Bo6sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PZzuWkX5dhUpmRTusTre4F/Jqr9VN2K2tAHChfkXDRi294DhJb0EvzGyUCeIhJfas
	 5O9rNAESEV/CLSctmpg01bI1SV6Nvb+9RgaBNqqi9OgKJJcutZy4wlnNIEbICHs6VH
	 ZkE1zUDS/0zTEMfKBD9EaD6dlOfkqvAS57BE/GAzcNLsNfFJKxCKEC1E1RC/nTDq58
	 I07GN3yXmVanWnomWX+OcSh5Er9pnJhn3WZQiurH7+AygYHnillHCenOFhm9NHiA8o
	 b6L6iDKsVK8NZRMrweKevYTQAQTLRwFFcojFZe4xJ0fhFKYQjErw2A22hiCtsi5PN5
	 674tdiZSSyCDw==
Date: Thu, 12 Nov 2026 12:02:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Asdlerto Korry <korryasdlerto@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: net: nfc: samsung,s3fwrn5: Add
 pvdd-supply
Message-ID: <20261112-sophisticated-peculiar-husky-c8ce51@quoll>
References: <20261111-m52xq-dts-v2-0-063289405882@gmail.com>
 <20261111-m52xq-dts-v2-2-063289405882@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111-m52xq-dts-v2-2-063289405882@gmail.com>

On Wed, Nov 11, 2026 at 05:07:46PM +0200, Asdlerto Korry wrote:
> The PVDD pin of the S3FWRN5 has to be powered before the chip is
> enabled. On some boards, like the Samsung Galaxy M52 5G, this supply
> is switched by a SoC GPIO. Document it, so that the regulator can be
> handed to the driver instead of being kept always on.
> 
> Signed-off-by: Asdlerto Korry <korryasdlerto@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

This should be sent for net-next.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

