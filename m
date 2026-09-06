Received: from mta0.migadu.com (out-78.mta0.migadu.com [91.218.175.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5605743A7FB
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788695140; cv=none; b=fY0hTbWvDV7QK51Yu/1vgNJPSW7Cr0mWdycK9SYzGayjOQ2HQW2bVQYJczJUY4tRnBaRTxO4W2syZ+3rk/ue+mk2lygd6nuOKmRKU8+rdL8Z1BRWxsnoM+o1ZJMAzS9dl82r9oBBlEl6X2E8qmGNevtquZC3GchXldhL7SkT0po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788695140; c=relaxed/simple;
	bh=ZtUeZ7Yibt2jGNcUKuwRepqyL6cGsgYYmGga/rUTm9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYQKKtdkNeTR5fIzKYLXF7ktgS4odKc8xpCriGG5Bkii8/mJpnXuyNxcA+XA1BeC+gSMtS/Q6F3cLtjcJIx3Rbubtsiy/1w4Ka4ln8qNrAAfo8qEzRFK9DGu3mOI0ayVzQAtLwhGqP5lgeZ52D5Mlgp1X0cm4qUKnQBWvq4fSP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aFGqjdSO; arc=none smtp.client-ip=91.218.175.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aFGqjdSO"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZtUeZ7Yibt2jGNcUKuwRepqyL6cGsgYYmGga/rUTm9o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788695133; v=1; x=1789299933;
 b=aFGqjdSOC1AA51gMRJMyItNT0hyG672lgRiW3FUxOgX+R32lWg4k/+q/VwFI6thpH+cpeLRh
 H57K7fOl8e7wodht/7M+jkLbJgR+vD4nL3KEs+f2GwMNcnqYP0BMYMkjH8MH5Glqd/z8cme/IIL
 fJvIAPdtLkFnRknLWVinbPRs=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9114a5f128862369;
	Sun, 06 Sep 2026 11:45:07 +0000
X-Mizu-Trace-ID: 9114a5f128862369
X-Migadu-Flow: FLOW_OUT
Message-ID: <d53aebb1-d707-4ab2-93cf-39c732e5c3d8@linux.dev>
Date: Sun, 6 Sep 2026 12:45:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] MAINTAINERS: dpll: add the netlink spec
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, arkadiusz.kubalewski@intel.com,
 ivecera@redhat.com, jiri@resnulli.us, donald.hunter@gmail.com
References: <20260904191023.3869690-1-kuba@kernel.org>
 <20260904191023.3869690-5-kuba@kernel.org>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260904191023.3869690-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2026 20:10, Jakub Kicinski wrote:
> get_maintainer.pl on Documentation/netlink/specs/dpll.yaml returns only
> the YNL and NETWORKING [GENERAL] entries, so a change to the DPLL uAPI
> description does not CC any of the DPLL maintainers. Ten other families
> (binder, dev-energymodel, ethtool, handshake, mptcp_pm, ovpn, psp,
> team, wireguard, rt-*) already list their spec explicitly.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b23fb6f2f4ef..b000853829b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7919,6 +7919,7 @@ S:	Supported
>   F:	Documentation/devicetree/bindings/dpll/dpll-device.yaml
>   F:	Documentation/devicetree/bindings/dpll/dpll-pin.yaml
>   F:	Documentation/driver-api/dpll.rst
> +F:	Documentation/netlink/specs/dpll.yaml
>   F:	drivers/dpll/
>   F:	include/linux/dpll.h
>   F:	include/uapi/linux/dpll.h

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
