Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E1435AC01
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780494; cv=none; b=hQtlgB69NlKZw52CM7/1q+Imq+JBu2IhqCGNn4B7QPiHzxiGKTvAwKGgC0Euh6+Sckqo8BCBeKFVSlZZSuwo5POYe50Ep3csozhEfAmknxMtvRndtg1AJwTCJzjzwv8orVi42Gmuv7g06PKkw+Si2F353PaG42GGKNppWSPvoPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780494; c=relaxed/simple;
	bh=tVD6I32X9o09LnLSiCTDoJRb9N9XzkPtf1rrJepbfPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDFDNuuo6wp1b6PjfDZFlEw7zkOCxUwBwLseWP9OIwg0ue2ixLYvaaqJ7sMEUIIdXYpqZKzNVoQ9+w2H4PwsZiUicz//kATi/NSm8luC4/M79wm47O9k/2yNjrTs79N8OObPPOBaGHtzxfRHJqOj0kKtwK4TUuPQjbQn3N6L8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=FJuy6yhc; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="FJuy6yhc"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398c066106cso1136052a91.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 18:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1789780477; x=1790385277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ICHHulJUCBRD5f9GaFqjX1G74LjOBZZCUQAyH59jdAQ=;
        b=FJuy6yhcPMn+EeD5lXAan5Rt72HBYRFz9Rh9RyE6dCcJh+omUhnFB7YQ9Ib9jtA7Ew
         0zkL8uCF44AeuiDyNmUe7xiNNQdQ7RU41DWeBkY4p/ofo49Ldwz4BUcC3ew/vN3/7W5j
         m5JbTxBxQrMJONQ2kTV3xsmm8uKbElJsv9fsuNd9kBak0qNb+/fM7ZWpj/Munouq8KWO
         hC93qSgxZK6TSf/SQnnrJZbK2CkD0wFi6CJUxsIjtqeAeEuGTzU6+3Ro5GjOUxge2Rtf
         h2gcjBzY7HizMJhgpZRc2NIWAs7AAa/7X7WdTSC47VVkMuiONINpmk1/S29wmaHsjhhG
         GXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789780477; x=1790385277;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ICHHulJUCBRD5f9GaFqjX1G74LjOBZZCUQAyH59jdAQ=;
        b=NLUl9mvBwGfpi/ojh6/xHUdgMRStiX2OMEWef7Yek241XAqZR5ANLgziHGBexicMQC
         ZF49KVPpxt4NNxMMvRE9YE/xws5LWKUn3wQoI5mU++sHLA/QT784tcel2l/NIvcoR1a/
         xreSeR6Z5hFNsZpgM0EY+MhczhedjLnALcc0MMfIJd3sRjHsPkayWPOb9eaebD7V0KS7
         332jJ/mo7imemNc4tQF0AlPPH4/hUu4myPZdzJHIHLoBhMaeSHT4Pcp6IexGVkiYWsJ9
         W4gB9YeTFvKkdlzh+nc4U4jhmNZgFiJuvjzSWr/gnzUj57XCa0aVH5GVSI6qvs8iqgni
         BP0A==
X-Forwarded-Encrypted: i=1; AKwUvBwPrZmNGZxMGe5A1ug5ufNVIuXDs3y/+DI79hFmT/SOzYOBhatuMl0xRbll3sS2FM9c1cOAHAM=@vger.kernel.org
X-Gm-Message-State: AFuF++lI5X8dyW9gCEXQOYkHJvesga9Nh/hgMUNaSOYgEXmgGwgd0aNs
	L2Bk45ZRBnIOtUJGcsNhy5oP0ZzDGclvQOAS2JDp3F0QsCmLFQ/HIVdzQxbn5rX2v5s=
X-Gm-Gg: AYBFou1PNMRg6ZYepKzfqLJBv4JL5adQCvr3btUjaeYTBUDxglLLsqeXiQvS/9dlIRO
	pPpGdpm1ZU3u9VxSI2psG1L7sND7YMRj2ZFDyqd5ib1DSG7qxZqR2x1zdvjXc6BsQdIaZotJPJB
	a2rhPQG8aNd+I2puY9mDorvDlskbP7q+72SaJfvOXjlO2Xthu146AgSLhkUgpuj5Gv0YSnLF2dP
	3AP5zQGDlaFqM5DTttUJbsb/gOLHwb4GKbL+E58cNbnj3/JXfiKNNjEkgAmYyYr4dRX8WR6mtwE
	21QkoXAeIinqvsVFJ6lENrYReIGgAH+CBAjvPXIDbupnfIcvc1jnrJhmQ2FpgbnrbsISfzwXnpQ
	NiU2BGLQWVozKxvcdnK78vTthh/Ga7T0evE1Q8nojrgR8sMqlArhP7pw8A/ANKkqsUYTGSuh3nz
	OI73c/Ieb1TW1ZWvO3ldeLUv7p5Xo0N8h7eZlNZE//ioCFD+55COCK
X-Received: by 2002:a17:90b:2dc3:b0:39d:e9b6:cec9 with SMTP id 98e67ed59e1d1-39e54d36756mr14388646a91.7.1789780476843;
        Fri, 18 Sep 2026 18:14:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55f124d5sm2722789a91.4.2026.09.18.18.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:14:36 -0700 (PDT)
Date: Fri, 18 Sep 2026 18:14:34 -0700
From: Joe Damato <joe@dama.to>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 07/10] net: ntb_netdev: Reject short RX frames
Message-ID: <aq3h+iaPkvy7n4Wg@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260914084838.2158249-1-den@valinux.co.jp>
 <20260914084838.2158249-8-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914084838.2158249-8-den@valinux.co.jp>

On Mon, Sep 14, 2026 at 05:48:35PM +0900, Koichiro Den wrote:
> ntb_netdev passes RX frames shorter than ETH_HLEN to eth_type_trans(),
> which expects a complete Ethernet header.
> 
> Reject them as length errors.
> 
> Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v4:
>   - New patch. Included here to fix the existing RX length check before
>     adding checks for ntb_netdev_hdr later in the series.
> 
>  drivers/net/ntb_netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
