Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794292654;
	b=yExqA9T885uy31jHv7K+FFJ2BtET6bEy1pFwHX7XmGe7zZluLxLKcfqBMYhcihEOHySC
	 5cPBLGR3Ldmma3gwXvlze4OTs/IgeLHllX6csWmce5Z9radJM6PSxyjahoJXXRSAzKwiF
	 SCtPdsNqEYXuOf2x0J5AweY8D9QJ6G3NJJclXRgsBx8JDj+pXezzWGL4gRPfzGAQa00PV
	 lyzuGQJVoiOXsvRg4/90ihUn6BcTjhRDJAwtY/oqSnW3KmkfQtDwz9QLIgLblAc+beV3c
	 zGBfanMlKx/OeO6bjF58pKd/7TaG//1upnUGvX5aoVZhc25h7KPvM6bJhRYu++DPvbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794292654;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Otp6rHHLbh7SWeIk6Dh9ZnKUDl+2T8Xlwlgu0O9xfKY=;
	b=fHlMu1T80Yb87G1L8/8EJNhyO2BgF0LpFfbA6e3R5u/S9eDjm5ybTsJCY1BUvJ9jW2t8
	 w23tuPO/tPfhtKfqny4T3QCjRuhFs//LzaqdOsKtCZKz+/XU8fV+h6dlvElAl3z799+vb
	 uOeusOwRi/jvg+hlqrzOUxno5x6oxJKB5gd8SKwAzw7fzYBSOAdenIMJe6ZD/DSZlyNWW
	 DsYhcj98G1Wv+EuM0Ts2OdKyGW6m9TwgKhRCE7W3ZsoW9gk9ZW7G7TD8L6jmZTwS6ilJs
	 GzQ6t4C0Le4pvJWsw0WfwjJvCaavo9B8o3wmF3P20DqlGqALETsIqm5b41FecM+VCJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hpqi6ILY;
	arc=none smtp.remote-ip=91.218.175.64
Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ACA606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1ACA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hpqi6ILY
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MEcLAKy7pZPHJ6KG807RxSolmDmWbdERHvyLsRAzMv0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794292650; v=1; x=1794897450;
 b=hpqi6ILYJt8J+4TeYY9veXcjC344nYhWCCr3L5a4h1WE8nVytChz75st23pRPv6qmjEFDhOb
 o9YEmqH43GEg4GKjoiryogg+pgvrz+Yl2AMlM1/L8svLYHKJjJF/ZiSYypbX+lMmTBTfrhHJOl8
 enI8qBt/D8xx/1mYNnoFS6Nk=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 520d86cabd9c72f5;
	Tue, 10 Nov 2026 06:37:29 +0000
X-Mizu-Trace-ID: 520d86cabd9c72f5
X-Migadu-Flow: FLOW_OUT
Date: Tue, 10 Nov 2026 14:37:19 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jingjing Xu <xujingjing@cmss.chinamobile.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] tools: ynl: preserve non-ASCII string attribute bytes
Message-ID: <avK7M8VNcWNXrNEw@fedora>
References: <20261110033922.49297-1-xujingjing@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110033922.49297-1-xujingjing@cmss.chinamobile.com>

On Tue, Nov 10, 2026 at 03:39:22AM +0000, Jingjing Xu wrote:
> Netlink strings are not restricted to ASCII. A valid non-ASCII interface
> name makes a getlink dump fail with UnicodeDecodeError, and encoding
> such a name for a rename request raises UnicodeEncodeError.
> 
> Use UTF-8 with surrogateescape for both directions. This preserves ASCII
> behavior, handles UTF-8 names and round-trips raw non-UTF-8 bytes that
> Linux also permits in interface names. Do not replace invalid bytes and
> lose the original name.
> 
> Discovered by Codex-assisted code inspection and reproduced using real
> rtnetlink operations in a temporary network namespace. Tested ASCII
> names, a UTF-8 name and a name containing byte 0xff in link dumps, plus
> UTF-8 and non-UTF-8 rename requests. The original library fails on the
> non-ASCII inputs; the fixed library reads and writes the names without
> losing bytes. Python byte compilation passes. No kernel instrumentation
> or hardware was needed.
> 
> Fixes: e4b48ed460d3 ("tools: ynl: add a completely generic client")
> Signed-off-by: Jingjing Xu <xujingjing@cmss.chinamobile.com>
> ---
>  tools/net/ynl/pyynl/lib/ynl.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
> index fb5acb8acded..2402d7c383e7 100644
> --- a/tools/net/ynl/pyynl/lib/ynl.py
> +++ b/tools/net/ynl/pyynl/lib/ynl.py
> @@ -301,7 +301,7 @@ class NlAttr:
>          return format_.unpack(self.raw)[0]
>  
>      def as_strz(self):
> -        return self.raw.decode('ascii')[:-1]
> +        return self.raw.decode('utf-8', 'surrogateescape')[:-1]
>  
>      def as_bin(self):
>          return self.raw
> @@ -852,7 +852,7 @@ class YnlFamily(SpecFamily):
>                  return b''
>              attr_payload = b''
>          elif attr["type"] == 'string':
> -            attr_payload = str(value).encode('ascii') + b'\x00'
> +            attr_payload = str(value).encode('utf-8', 'surrogateescape') + b'\x00'
>          elif attr["type"] == 'binary':
>              if value is None:
>                  attr_payload = b''
> base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
> -- 
> 2.53.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
