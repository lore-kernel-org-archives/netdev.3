Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6B4B4041;
	Wed, 16 Sep 2026 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577568; cv=none; b=FBr5OKHN7fCgVK46xlS2o18Mn8g8XsCjyOhgCWN34CTnGVDBbBqeh/gOQHiOkz+syRu3cfPqjFqT2CtTbWKsoGK8wB0BrKZ3QiGZNsGTlhzp9x62LF2I4LdYudIkdGbB3AcB1sPMqYqRexXePOE1jAR2G5VWadZjZqaOA1eDGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577568; c=relaxed/simple;
	bh=+7airHDE3PtH7ond3yrLNxXmrn2F84jwlK2NYh87MYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGdEYAFPm6CJZ8M+nUzy1bE2dI+clIVSMrsMR9zu01HiP4rHkQRtMX7ue1EaOFKPk0xmANK4uf36O4ByeGlMH+/9N6d+PGjrH7pkkC5FMzjZ0dla2iAYHPpuG8w5PwgXMG3dO3YuWeGj7JGw54NXgXUvUNT5eM12MGEuTHlt6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ogS8rujA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ogS8rujA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=acBKg2iUfuozfgd2lK7Fd0gwUoP8pMuPREZqYNWxnZA=; b=ogS8rujAyj3bv292dkmGYGmxy1
	0NFmHQeIR8aNRB7dsT3jdtrkbodLC8Hn5UWr1J7zymvSvvpGSFqt8GTHY0poEOR2LyAeta1wcpw8+
	PMx6xIcpSMB+GJsyNxpmFLimrR0o05VjK08DK8kHM/AF4xRNtm6WQauf5x/Uz6uzmLh89Hqj2hyPw
	Jtm7i+PytLowFd1rhsL2uqVSytmrWZnlkx+nfwEG3Pnt5FTdRQTqlyNPzFFZB5mMwKaXOXv6fTSSe
	lWCfn3lLJlIf6bWa9rrLjaZgcY9y/+bLCivuluPUiP9iZXo501W+ZfocXOS+OdSacQh0Pzq5owUXA
	c8LDTw6A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6sry-00000009nSP-42v9;
	Wed, 16 Sep 2026 16:52:27 +0000
Message-ID: <239ec20e-103b-4dbe-add5-61241fad7e19@infradead.org>
Date: Wed, 16 Sep 2026 09:52:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: networking: radiotap: Fix bracket
To: Manuel Ebner <manuelebnerli@mailbox.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260916123458.314458-2-manuelebnerli@mailbox.org>
 <20260916123458.314458-8-manuelebnerli@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260916123458.314458-8-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/26 5:34 AM, Manuel Ebner wrote:
> Remove needless ')' from code.
> 
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Documentation/networking/radiotap-headers.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/radiotap-headers.rst b/Documentation/networking/radiotap-headers.rst
> index 1a1bd1ec0..aadc7bc6b 100644
> --- a/Documentation/networking/radiotap-headers.rst
> +++ b/Documentation/networking/radiotap-headers.rst
> @@ -133,7 +133,7 @@ its prototypes available in include/net/cfg80211.h.  You use it like this::
>  
>  		    case IEEE80211_RADIOTAP_ANTENNA:
>  			    /* radiotap uses 0 for 1st ant */
> -			    antenna = *iterator.this_arg);
> +			    antenna = *iterator.this_arg;
>  			    break;
>  
>  		    case IEEE80211_RADIOTAP_DBM_TX_POWER:

-- 
~Randy
