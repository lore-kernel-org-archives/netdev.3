Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379D3ACA65;
	Thu, 30 Apr 2026 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543932; cv=none; b=BYoYHqaSovj/fGgzQE9Anj7V1oYKV4eaHF2MRvf2t0XfgdCk9YclcLvsNnjLmpoJSFD0vOsTdeOvAqU9PpIi9kHWm3kFMAIpoOmRqSHlNixQcZix0qOmo/t14A6OIitI2XZKSftJ1E1bHN6bHzWpE+jjEkmUPGeGsPtGdM1AXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543932; c=relaxed/simple;
	bh=rzHdmnYTUdONY66bBJjqqsOWqkMIUbSR7F6vgZuhok0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0EHpRSuVCWyOKXY+TdvijHv98wJFYVtGZNyPR/Q2zicIC4VqMiRTTR38Ez0WjbBzY1GwTaxmZqBkQEhqw16f2+nHr6RIndEYSenojO8T1yNohGZuaeJGYF2Cj8e8gx/oX3p/WEhGP/HXe9usY9kG+CPKr1akhgGul1fFO/NgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsF9TxgL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsF9TxgL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E7BC2BCB3;
	Thu, 30 Apr 2026 10:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777543932;
	bh=rzHdmnYTUdONY66bBJjqqsOWqkMIUbSR7F6vgZuhok0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsF9TxgLrJfH7gWzTKDNkbm9Mnaiq6QQGL7MKjIY31Qt4BfIhnxJXYxit6JBpTz/p
	 F1v9GlyONXAw7OeTbWv1174rUpO5jpMfTft4xcD8X4e74lFXqsgnAxno1iCwEMXAis
	 HpMaWUPcB3U6HDib/tiZEK+9hgfRjwUsSc9PNmGUgS3szIJaMs2RRSJRZsPtOGgUOp
	 cP9Sl4+rLq2buTEvKh6NOusVBwTD9v/rJpwS0V0C2VxEw6piAyeG4tMzJ/df1RqDxs
	 /JBJ1uHDLxvOBUpb2ETCBJvrMbHtUx2y6kVrHCm/BZQDt95t+6zmjHw6yFL8o/A6zt
	 OUDiVS3E0tKPw==
Date: Thu, 30 Apr 2026 12:12:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Document Shikra Top
 Level Mode Multiplexer
Message-ID: <20260430-esoteric-badger-from-hyperborea-1049ef@quoll>
References: <20260429-shikra-pinctrl-v1-0-1b4bb2b3a8d6@oss.qualcomm.com>
 <20260429-shikra-pinctrl-v1-1-1b4bb2b3a8d6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260429-shikra-pinctrl-v1-1-1b4bb2b3a8d6@oss.qualcomm.com>

On Wed, Apr 29, 2026 at 06:41:56PM +0530, Komal Bajaj wrote:
> +properties:
> +  compatible:
> +    const: qcom,shikra-tlmm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-reserved-ranges:
> +    minItems: 1
> +    maxItems: 83
> +
> +  gpio-line-names:
> +    maxItems: 165

Further pattern said you have 166 GPIOs.

Best regards,
Krzysztof

