Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468637;
	b=IOppVwsyIS5mZJq+0wTkg2MdgrlagHC3oLXH/rPsKHl/YceBvGNp77yJa0zBWXc/Iq8+
	 aAlE50oQFWcbUjbq21MaG+VaSZQXjGlohoYyibK0o3wBo00O/VOLuCuIfezX3+BkLxS2f
	 2Z1y8h9NnpjdxijCDcSN0j4LO2Arh8PFKtfDO9KqfK8Srj6U8jq/OO8ez7pzKL4E7l6At
	 l9UIHQMXZ6/+3KRPEnpymIZ7OXO79YWSzWPcciINgJ+dJUQkOaC6aeC9kuDIVMA+oVesE
	 8e2BsK6eyWOfhIaPHWMtk9trWAikhTU5pmAWK1ot0eJ2POF7B/3WNpjes6ZNWqDPnLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468637;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=PwsB3w3IGTBBRMoLaneSoM4ODkNVnmOpEafVevDzJLw=;
	b=WhqE19B8tfpHnyE3awyb57xJJ7GtUgYxDe6phXhCNXA3YJGD6oeL/faidUGOB+0u/hv0
	 Yl7jVA5N5syVGK1N9kl2xK/mAK5FqZpK0eLTz2WdSA8Rkt0h+1CuYR0T3V4v2ulKrNu37
	 1CONK7o9ynf0xVImk9zrQTz9ltxKPy3X2I6Xin4PA3DOQX6tLQqxWulsR7YrhOOMPTBmD
	 80fxGKLErKf3IZQCpxCV6sFDM9m3pHBZHxqKPPT3Y/glOhRlu5z55vTJUayPK0vll9pIm
	 wwkB5HIkdH2lDbjHVIKDstpBeB3/3B+vDewt0ijfEXEsBynKlyEJ/3Z7CPACXM/zseg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DPMA3dk4;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A63606A31C;
	Thu, 12 Nov 2026 07:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37A63606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DPMA3dk4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=PwsB3w3IGTBBRMoLaneSoM4ODkNVnmOpEafVevDzJLw=; b=DPMA3dk4FDl/bjba/fpoYHDgfR
	PF+VSqLj8OtUIoi3igaR/h/ivDQ4MMJ6ij6D4xIpO7nUdLVMkhYysTQq5NbImlkBKw2GpjZW8caUB
	zkJD+w9D0bIosY2DtvnYPM5frL8eeLHy/iMgD16Crs2xMUSTXDdbqinaUgzhUVpfA16yqHtjGYoKN
	cwDfPCuX4S7EB0LCYbqTdlX6yqmFphTSPpyFxmQWOzSfgL4WkFVBtKLyJiX4KSpm0gYCQqmtyjyge
	CSIHdyxonT2OEHj3kidFXuxDh9X6v2BAe8xFpfL7k4SxtM4vP4obUdcZXnBL85oDq3DhZc0ANia9H
	HEcR+A3Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPGT-00000008w2P-3Sb5;
	Thu, 12 Nov 2026 07:30:34 +0000
Message-ID: <f49599ba-7fcb-4c24-a94f-28fa953e8b00@infradead.org>
Date: Wed, 11 Nov 2026 23:30:32 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netlink: specs: rt-route: move fixed-header to
 operations list
To: Hangbin Liu <hangbin.liu@linux.dev>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>
Cc: Wessel Jacobi <wessel@jacobi.pw>, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
References: <20261112-ynl_fixed_header-v1-1-8475ea19e409@kylinos.cn>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20261112-ynl_fixed_header-v1-1-8475ea19e409@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/26 10:46 PM, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> Wessel reported that fixed-header is not shown in the generated HTML
> page like rt-link.yaml. The doc generator only renders fields on each
> entry in the operations list, not operations-level keys. Move
> fixed-header onto each operation so it appears in the HTML.
> 
> Reported-by: Wessel Jacobi <wessel@jacobi.pw>
> Closes: https://patch.msgid.link/8610ee11-e1dc-481a-9654-11188a06786a@jacobi.pw
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> I'm not very sure whether we should also set `fixed-header` for
> `newroute-ntf` and `delroute-ntf`, since these notifications are identical
> to `getroute`. But because `fixed-header` is defined at the operations
> level, I've added it to all list fields to match the existing behavior.
> 
> I rebuilt the HTML documentation, and now `fixed-header` shows up correctly.
> ---
>  Documentation/netlink/specs/rt-route.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
> index 48d1659f20f3..b5786b465eef 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
> @@ -708,13 +708,13 @@ attribute-sets:
>  
>  operations:
>    enum-model: directional
> -  fixed-header: rtmsg
>    name-prefix: rtm-
>    list:
>      -
>        name: getroute
>        doc: Dump route information.
>        attribute-set: route-attrs
> +      fixed-header: rtmsg
>        do:
>          request:
>            value: 26
> @@ -772,6 +772,7 @@ operations:
>        name: newroute
>        doc: Create a new route
>        attribute-set: route-attrs
> +      fixed-header: rtmsg
>        do:
>          request:
>            value: 24
> @@ -808,6 +809,7 @@ operations:
>        name: delroute
>        doc: Delete an existing route
>        attribute-set: route-attrs
> +      fixed-header: rtmsg
>        do:
>          request:
>            value: 25
> @@ -815,11 +817,13 @@ operations:
>      -
>        name: newroute-ntf
>        doc: Notification about a created route.
> +      fixed-header: rtmsg
>        value: 24
>        notify: getroute
>      -
>        name: delroute-ntf
>        doc: Notification about a deleted route.
> +      fixed-header: rtmsg
>        value: 25
>        notify: getroute
>  
> 
> ---
> base-commit: c88fd6989aea9237a60a4859139a265bfb7ddc0b
> change-id: 20261112-ynl_fixed_header-2d7acfcb54f8
> 
> Best regards,
> --  
> Hangbin Liu <liuhangbin@kylinos.cn>
> 
> 

-- 
~Randy
