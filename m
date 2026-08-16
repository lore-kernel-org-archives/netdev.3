Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC72BDC0F
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786911722; cv=none; b=HRTfhhX4FKd/ZR5VuCj4keeic3vYQI+2/iDtVECZMof3J5XtWw05EK+6qnMVLx6MjmGqPVh8oIXRLH6A8zRgyDXaWUNG3sAJ1UMB1jPfslHj7bqnbSxYD6h1jXYWgY0KPvxxfyYwgMGSouTinnrkX4NtrSX3T9A91ANVFGrRBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786911722; c=relaxed/simple;
	bh=UvgKyoYUU7Hc1biHTcTCYgRpgSe0N62YOStc8DIdglc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NG2mK5KcZaBbfSRZwSFGiw9JJg/e2if+dFA8qvWkRAheMcr606le8xK7cemn9Z7Tuyqj9HH9cdj8UnsfCXtNkFg/+PO+hPWbqw/i37csDNzNx6tMj6S6ppLih4QS+1mn0FCRHvk++6QT2e4YYNnllSiiSGziJdiCCMbew2ptsh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=s+0QbEmi; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="s+0QbEmi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A997C1A16A8;
	Sun, 16 Aug 2026 20:21:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6812B60352;
	Sun, 16 Aug 2026 20:21:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AF2C11C4FA91;
	Sun, 16 Aug 2026 22:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786911705; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SxXftz2oqhRF+f5uuDER1ooQFi0Mth0EN2bV+gopjEo=;
	b=s+0QbEmi/4T6zrMFP/vSH6SMjOOPYk9ZRz1bXaR0u1dnAAWtpx8DmBn3ybC5rr8PUKk8mK
	X6Qbpe7lJD2+hIxfJDpHGWN0Ym0uSaRmmlbeY7ykRYZl/CKSi+jaK3ja76s+U5eR/9b9O+
	E9TKBWA/3JNI1gTznDnynXmSNb2+obRIYz9uoDsnd0P9jhHGkqoGJMqYX2bqASksW6sP6s
	4N2u78KfHqO/scGcbLXm+OL5rHu2U08CRuNpeC0QhOwSob8KLIIdDW0XrutRjOMPzpgnFY
	xeGk14F/hl822KSxrq2hFlayy/6rJJuUpO6f/U/ybZ4RLhZX92o+wtNnoXk/OA==
Message-ID: <a7437b71-9ad4-4909-8a2f-fba5db035647@bootlin.com>
Date: Sun, 16 Aug 2026 22:21:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] MAINTAINERS: update entry for socfpga dwmac and
 gmii/sgmii
To: Dinh Nguyen <dinguyen@kernel.org>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
References: <20260813005536.2068392-1-dinguyen@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260813005536.2068392-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/13/26 02:55, Dinh Nguyen wrote:
> Matthew Gerlach is no longer at Altera, so remove his entry as a
> maintainer for the SoCFPGA DWMAC ethernet glue layer and the GMII/SGMII
> dt-bindings files.
> 
> Maxime Chevallier has volunteered to maintain the dt-bindings YAML files
> as well.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>

Acked-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> v2: include Maxime Chevallier in message
>     s/Mathew/Matthew
>     s/Chevalier/Chevallier
> ---
>  .../devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml   | 2 +-
>  .../devicetree/bindings/net/altr,socfpga-stmmac.yaml      | 2 +-
>  MAINTAINERS                                               | 8 ++------
>  3 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
> index aafb6447b6c22..cfb53080dba26 100644
> --- a/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
> +++ b/Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
> @@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Altera GMII to SGMII Converter
>  
>  maintainers:
> -  - Matthew Gerlach <matthew.gerlach@altera.com>
> +  - Maxime Chevallier <maxime.chevallier@bootlin.com>
>  
>  description:
>    This binding describes the Altera GMII to SGMII converter.
> diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> index fc445ad5a1f1a..8f5d63bb2187a 100644
> --- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> +++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: Altera SOCFPGA SoC DWMAC controller
>  
>  maintainers:
> -  - Matthew Gerlach <matthew.gerlach@altera.com>
> +  - Maxime Chevallier <maxime.chevallier@bootlin.com>
>  
>  description:
>    This binding describes the Altera SOCFPGA SoC implementation of the
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8014b9f8253ed..e5ac94395670c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3588,15 +3588,11 @@ M:	Dinh Nguyen <dinguyen@kernel.org>
>  S:	Maintained
>  F:	drivers/clk/socfpga/
>  
> -ARM/SOCFPGA DWMAC GLUE LAYER BINDINGS
> -M:	Matthew Gerlach <matthew.gerlach@altera.com>
> -S:	Maintained
> -F:	Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
> -F:	Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
> -
>  ARM/SOCFPGA DWMAC GLUE LAYER
>  M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/net/altr,gmii-to-sgmii-2.0.yaml
> +F:	Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
>  
>  ARM/SOCFPGA EDAC BINDINGS

