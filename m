Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB243CEC3
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524716; cv=none; b=biFom6e7k/+i3f2+TZQXBbazU67B5vL95veRRCazF+gKz27e2qIMeOY516cF4aprbiImVKbvasxJbfKJqZKOQrtDZZSgGfuADKlS4++Pga0raUujFVszY8ePMlZZKJqHLgCPxcHTs0n3Jj6II+xyHw8blZ7ic7zUw8zUl4CwrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524716; c=relaxed/simple;
	bh=Xog4Xy52QjZzRWpbCRX/asCqFS/9YWYMh1wtSA2ILgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omG6QksaUmdR4/48X9PWCUMB5Lg5ySSxzZQLqduSAkR5uO+4JMsGk5OVrtEroQ5t+XvK3YIcuT2qrV7nPVGh9XNufo/usgWS4jjcFBPdDVBCRTan6UdBlXm2qoc/OzUAEAoHEQmHfHX51x0vi9YpJHdNN/DnJslqTNlpxbXPBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvPqMmr3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvPqMmr3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA671F00893;
	Wed,  3 Jun 2026 22:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780524715;
	bh=UzKeV94F2AnXXTeiKTzeYdMnsxBLzgzrW53K73uvhm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HvPqMmr3d85PrETDjpVRoF7bLHs/PcQB2vW6IG+dLWIOxscePMDMBBYIhvhdRGu0G
	 a5IfgJ8setNs2QfXuZ1aRAXsozcomDb2PHGLePHs739cOtpCEef2hz4da0PJfAkRkF
	 YDODA4Eo6/BtVspNzg0m9ALTL7369J+Inohu6N2ZQwysxAZIS/1zh0+SA0rOjoCoMO
	 yX32FRZfKuH7NS8mryNT+z9xjuCApxtT7TmQQnIR0QDo+pJe+iUw9d/wiZWAdEt9uI
	 Litcy6b5wc40nBp0I8Y74OPH+4zPsKLVTwKYZDYQABS4vFfVHv35OORF0sX/YR13+F
	 rGqKBU52BDaUg==
Date: Wed, 3 Jun 2026 15:11:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next 1/3] net: ensure SCM_TXTIME delivery time is no
 older than system boot
Message-ID: <20260603151154.433c1c55@kernel.org>
In-Reply-To: <20260603190243.2789335-2-willemdebruijn.kernel@gmail.com>
References: <20260603190243.2789335-1-willemdebruijn.kernel@gmail.com>
	<20260603190243.2789335-2-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 15:01:28 -0400 Willem de Bruijn wrote:
> +		switch (sk->sk_clockid) {
> +		case CLOCK_MONOTONIC:
> +			tmin = 1;
> +			break;
> +		case CLOCK_REALTIME:
> +			tmin = max(ktime_mono_to_real(0), 1);
> +			break;
> +		case CLOCK_TAI:
> +			tmin = max(ktime_mono_to_any(0, TK_OFFS_TAI), 1);
> +			break;
> +		default:
> +			tmin = 1;
> +			WARN_ON_ONCE(1);
> +			break;
> +		};

net/core/sock.c:3079:3-4: Unneeded semicolon
-- 
pw-bot: cr
