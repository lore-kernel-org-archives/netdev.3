Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5044AB9A;
	Fri, 24 Jul 2026 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784922063; cv=none; b=MQMDPc2l+UIon7Z6Xwo2EJRKQl2SR5d8gige87dLjOyb/iko7aDKKK4Uy/d+tGkNgXddOvb94qnYGC05da6d80A0xf9uLw5+jTv/50l8WqZ3LpL41YA3McPQ0/UJhG914F5cHwq5PsdDFfxCpOCl0afjjcIL59nbhic8sAvtHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784922063; c=relaxed/simple;
	bh=LpU4ykZ8R0oqq343zSEpvE6Cc/2y7GH0eV2ZmCKD9Go=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=u60Ajje5qlIxfVV8bwPmKYmp14lr7F0PJK28PYozuXpwcch3ldarZz+9iBXW3npetaLwmHaSIg4DPa3dvdlcwKaO8+mrcfZvpE279WNM/HwDPue/adChc+jMV61vaoV03iVya+eCC5tpA7d8ILCIM9xFmOzHr3NHo3dLfThOWRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=AlazS7/T; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="AlazS7/T"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB2C3A4DC3;
	Fri, 24 Jul 2026 21:40:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784922059; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zgtrZs5kuGCjXtf5pIj1oU3wREM7qS1iuWTueRL7k2Q=;
	b=AlazS7/TgeHhh2dwcsa/WoSwnVDmCQZmQpJw/LwIo4WhZ0DnYfCVIXCYyJIy4kdUQpWWF+
	4d5RB4xcAx/G8yVYG/3fUHKXDsMROGSajMrRG/Uu2wTmc63ju++45kMXOuFmLnnEXiaAIA
	3DrtC1wbrUe3JmR6x2L9041sp8ujSM4EgpjPPnF6q2soJ5kWMBlW4j1L0rJ9pq0mP+ubu9
	v0+sTLZhg0ppzStE6BkXI7n/iwd5ATcrC52Cpxko0aM3DqBnmbwFGM5XQY2jCSTydznXo4
	qiQ19ou6JUOKWBdBxrTn79BInhqpViiLw+KjsIJ8Ets/FqFxK9vnwqZtiCOJUA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 21:40:57 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: theo.lebrun@bootlin.com, conor.dooley@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, git@amd.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: macb: remove unused ENST Q0/Q1 time
 register defines
In-Reply-To: <20260724043257.2221030-2-vineeth.karumanchi@amd.com>
References: <20260724043257.2221030-1-vineeth.karumanchi@amd.com>
 <20260724043257.2221030-2-vineeth.karumanchi@amd.com>
Message-ID: <c3ad1ae49245a7bea85075d3b6a8ff31@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Vineeth

On 24.7.2026 06:32, Vineeth Karumanchi wrote:
> The ENST start/on/off time register definitions for Q0 and Q1 are not
> referenced anywhere in the driver. The driver calculates these register
> addresses from the ENST base offset and the queue index instead of 
> using
> fixed defines, removing the unused macros.
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
> ---
>  drivers/net/ethernet/cadence/macb.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h 
> b/drivers/net/ethernet/cadence/macb.h
> index 2de56017ee0d..a11052565436 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -184,12 +184,6 @@
>  #define GEM_DCFG8		0x029C /* Design Config 8 */
>  #define GEM_DCFG10		0x02A4 /* Design Config 10 */
>  #define GEM_DCFG12		0x02AC /* Design Config 12 */
> -#define GEM_ENST_START_TIME_Q0	0x0800 /* ENST Q0 start time */
> -#define GEM_ENST_START_TIME_Q1	0x0804 /* ENST Q1 start time */
> -#define GEM_ENST_ON_TIME_Q0	0x0820 /* ENST Q0 on time */
> -#define GEM_ENST_ON_TIME_Q1	0x0824 /* ENST Q1 on time */
> -#define GEM_ENST_OFF_TIME_Q0	0x0840 /* ENST Q0 off time */
> -#define GEM_ENST_OFF_TIME_Q1	0x0844 /* ENST Q1 off time */
>  #define GEM_ENST_CONTROL	0x0880 /* ENST control register */
>  #define GEM_USX_CONTROL		0x0A80 /* High speed PCS control register */
>  #define GEM_USX_STATUS		0x0A88 /* High speed PCS status register */

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
