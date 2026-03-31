Received: from ida.uls.co.za (ida.uls.co.za [154.73.32.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881524A067;
	Tue, 31 Mar 2026 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.73.32.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940063; cv=none; b=F/qK/z5kKvnjta97NIcBz2g/7rp5QOOJU9L8t3OASEXxkX5ed795O0N9irxtFSZeb2kezzkqar2t/I6ah3vDsjg61thu3GzA8NqeGA3TSXoGaCg6vIJ3g6CYoeHTm/kt4R88ZOzfcZcm71fAKa6ldUykJRF/fAj6rqyz8tylBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940063; c=relaxed/simple;
	bh=O/0qHlCx7400cSiRBCThKdrPCIzm2gw2WUdC8zjc5Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/QL2ZfzdqlDXgpBn2xy2uQIvsa+X8Op9xpdaDzkXkfyEbRo70G7XWYMoHboesZKEOzewS2qhSTIo/QGYHyQ/kEksPUirBvRd405xuCAag+285zWK3FRjq39k8gf2DyknVcoF2+Nwify2QRZsmweAUI//ojgYGd+72EmyYrpB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za; spf=pass smtp.mailfrom=uls.co.za; arc=none smtp.client-ip=154.73.32.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uls.co.za
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uls.co.za
Received: from [165.16.201.5] (helo=[192.168.1.162])
	by ida.uls.co.za with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <jaco@uls.co.za>)
	id 1w7SWB-000000000du-0quy;
	Tue, 31 Mar 2026 08:24:03 +0200
Message-ID: <0aa6aa20-0e2a-48e9-8273-53b2fecd287b@uls.co.za>
Date: Tue, 31 Mar 2026 08:21:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] pppoe: update Kconfig URLs
To: Qingfang Deng <dqfext@gmail.com>, linux-ppp@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Dianne Skoll <dianne@skoll.ca>,
 James Carlson <carlsonj@workingcode.com>
References: <20260331033303.5664-1-dqfext@gmail.com>
Content-Language: en-GB
From: Jaco Kroon <jaco@uls.co.za>
Autocrypt: addr=jaco@uls.co.za; keydata=
 xsBNBFXtplYBCADM6RTLCOSPiclevkn/gdf8h9l+kKA6N+WGIIFuUtoc9Gaf8QhXWW/fvUq2
 a3eo4ULVFT1jJ56Vfm4MssGA97NZtlOe3cg8QJMZZhsoN5wetG9SrJvT9Rlltwo5nFmXY3ZY
 gXsdwkpDr9Y5TqBizx7DGxMd/mrOfXeql57FWFeOc2GuJBnHPZQMJsQ66l2obPn36hWEtHYN
 gcUSPH3OOusSEGZg/oX/8WSDQ/b8xz1JKTEgcnu/JR0FxzjY19zSHmbnyVU+/gF3oeJFcEUk
 HvZu776LRVdcZ0lb1bHQB2K9rTZBVeZLitgAefPVH2uERVSO8EZO1I5M7afV0Kd/Vyn9ABEB
 AAHNG0phY28gS3Jvb24gPGphY29AdWxzLmNvLnphPsLAdwQTAQgAIQUCVe2mVgIbAwULCQgH
 AgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAILcSxr/fungCPB/sHrfufpRbrVTtHUjpbY4bTQLQE
 bVrh4/yMiKprALRYy0nsMivl16Q/3rNWXJuQ0gR/faC3yNlDgtEoXx8noXOhva9GGHPGTaPT
 hhpcp/1E4C9Ghcaxw3MRapVnSKnSYL+zOOpkGwye2+fbqwCkCYCM7Vu6ws3+pMzJNFK/UOgW
 Tj8O5eBa3DiU4U26/jUHEIg74U+ypYPcj5qXG0xNXmmoDpZweW41Cfo6FMmgjQBTEGzo9e5R
 kjc7MH3+IyJvP4bzE5Paq0q0b5zZ8DUJFtT7pVb3FQTz1v3CutLlF1elFZzd9sZrg+mLA5PM
 o8PG9FLw9ZtTE314vgMWJ+TTYX0kzsBNBFXtplYBCADedX9HSSJozh4YIBT+PuLWCTJRLTLu
 jXU7HobdK1EljPAi1ahCUXJR+NHvpJLSq/N5rtL12ejJJ4EMMp2UUK0IHz4kx26FeAJuOQMe
 GEzoEkiiR15ufkApBCRssIj5B8OA/351Y9PFore5KJzQf1psrCnMSZoJ89KLfU7C5S+ooX9e
 re2aWgu5jqKgKDLa07/UVHyxDTtQKRZSFibFCHbMELYKDr3tUdUfCDqVjipCzHmLZ+xMisfn
 yX9aTVI3FUIs8UiqM5xlxqfuCnDrKBJjQs3uvmd6cyhPRmnsjase48RoO84Ckjbp/HVu0+1+
 6vgiPjbe4xk7Ehkw1mfSxb79ABEBAAHCwF8EGAEIAAkFAlXtplYCGwwACgkQCC3Esa/37p7u
 XwgAjpFzUj+GMmo8ZeYwHH6YfNZQV+hfesr7tqlZn5DhQXJgT2NF6qh5Vn8TcFPR4JZiVIkF
 o0je7c8FJe34Aqex/H9R8LxvhENX/YOtq5+PqZj59y9G9+0FFZ1CyguTDC845zuJnnR5A0lw
 FARZaL8T7e6UGphtiT0NdR7EXnJ/alvtsnsNudtvFnKtigYvtw2wthW6CLvwrFjsuiXPjVUX
 825zQUnBHnrED6vG67UG4z5cQ4uY/LcSNsqBsoj6/wsT0pnqdibhCWmgFimOsSRgaF7qsVtg
 TWyQDTjH643+qYbJJdH91LASRLrenRCgpCXgzNWAMX6PJlqLrNX1Ye4CQw==
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <20260331033303.5664-1-dqfext@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-report: Relay access (ida.uls.co.za).

Hi,

On 2026/03/31 05:33, Qingfang Deng wrote:
> Both links are no longer valid. Update them to the correct URLs.
>
> Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> ---
>   drivers/net/ppp/Kconfig | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ppp/Kconfig b/drivers/net/ppp/Kconfig
> index a1806b4b84be..c751959c53a1 100644
> --- a/drivers/net/ppp/Kconfig
> +++ b/drivers/net/ppp/Kconfig
> @@ -122,11 +122,10 @@ config PPPOE
>   	help
>   	  Support for PPP over Ethernet.
>   
> -	  This driver requires the latest version of pppd from the CVS
> -	  repository at cvs.samba.org.  Alternatively, see the
> -	  RoaringPenguin package (<http://www.roaringpenguin.com/pppoe>)
> -	  which contains instruction on how to use this driver (under
> -	  the heading "Kernel mode PPPoE").
> +	  This driver requires the latest version of pppd at
> +	  <https://ppp.samba.org>.
> +	  Alternatively, see the out-of-tree RP-PPPoE plugin at
> +	  <https://dianne.skoll.ca/projects/rp-pppoe/>.

ppp now exclusively has the plugin code (originally from roaring penguin 
I believe).  Latest version is no longer relevant, that plugin has been 
available since at least a few versions back already (at least a decade, 
probably closer to two).

That same code has recently been dropped from rp-pppoe, which now 
primarily focusses on pppoe-server, and relies on the plugin now part of 
ppp package itself. rp-pppoe is only required if you're running a 
pppoe-server, and I don't think rp-pppoe at this stage will function 
without ppp.

Most people will never need rp-pppoe.

Kind regards,
Jaco


>   
>   choice
>   	prompt "Number of PPPoE hash bits"
