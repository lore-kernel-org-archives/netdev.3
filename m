Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607693;
	b=rb+Y833HdGIiUSkZ3518eEjzmyn2OuDQpKORwTMaOEc2tPu3mDQuL1S4mhJSg3AQ+OhI
	 I2XJz/7oToBxZw08Psasi6tu1rVJ1RVehJ7Br4M0dQUp3eDABIhB9q83Uda8KfSW/zl4a
	 UItXHr407nqBeaIA734J4974pAPuvpz7TvKthE6EnJ4hClUMg+E2tfP1JeuTEV3sOsIBg
	 vk5pTTB4WUrXhcuuF987mRDD/hAaA4wlU5YmxXCtEsk+jQq6BURYAb0BidAWBS8uaNrwt
	 nnCH79WUyZAqczqG/Fh6ZqS9q7UU8kKx3gpaP/VDA4kOuYy16Khcps4gHPbs6AWVN7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607693;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 CC:In-Reply-To:References:Date:Message-ID:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=3aCBQKEtp9jqdbxK61a0BgBPXP3SZR1YDzpZ4g2BdjM=;
	b=fMQbp5nytbi3pizg5Kd5ho3GZoDBklMiQlfZIihmC6cPJcPORGWvaryIwJAvMRgh+2CQ
	 QM9B8z1CNag3G6rXaD83HEOV78UMW40OMLsyIvbc6QGfiUyvdVKqzIhxcBZMuMm20T2va
	 13Wb1AKA/M4ireAbqm0oehi26rIRsej7+VLeEf16X2NSgKwKht/TdMQrZpHD1UsIMLywz
	 vQSaNUq8KsXOR6AU+Z0hRlugwjyuMGSyQl//ZZbs4Y8wox1a6MRQTXGW1VRR6lVKrfy/l
	 A+hpDDdBhGPGBUqRCr5Z8SyOUGSbNLp7vR4/hHY2pJ/LKfd052PTCHsUMidYdj5esDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=mei0pUs9;
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030A606A327;
	Fri, 13 Nov 2026 22:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E030A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=mei0pUs9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794607692; x=1826143692;
  h=mime-version:content-transfer-encoding:subject:from:to:
   cc:in-reply-to:references:date:message-id;
  bh=3aCBQKEtp9jqdbxK61a0BgBPXP3SZR1YDzpZ4g2BdjM=;
  b=mei0pUs9kEtgVbT+ocsWv9mtoMX13Nmp/ZHrSmw7LfTwGYkwBhx7zZZP
   3IFjJThfo5V3SMoBpKZwHyd0ruiOURviKKPBpGXSrjTzvo5DplUJ9YujV
   YIx68a5gxTESJc3573rgmLB8aFNkXSNaocvlvFV6KrLcPuH5G9lrgS2Qn
   A+gaK4atOrB2VSNbO54Q01+n1F0zrOyHcNu61GP2Rey8YX97I7iddv55s
   6QJizExJMc1HByQBl60Sbak9SK2orgDkAZFWKosvhKozn22CXBLOQp/4k
   IaXn7UWM5r4j+lXhcenptSqt0GVdjq9GaeBGhDKJteigeBxDJp3CXRRCy
   w==;
X-CSE-ConnectionGUID: ywE1/K3jR5CPwJEwmV8jlw==
X-CSE-MsgGUID: ef8xOWpQT0GK9UdboiUvHQ==
X-IronPort-AV: E=Sophos;i="6.27,212,1787011200"; 
   d="scan'208";a="33736295"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 22:08:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:1812]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.227:2525] with esmtp (Farcaster)
 id 444c19e4-de88-464b-b426-2eb94dc7e491; Fri, 13 Nov 2026 22:08:10 +0000 (UTC)
X-Farcaster-Flow-ID: 444c19e4-de88-464b-b426-2eb94dc7e491
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 21:10:13 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 21:10:11 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next] net: ena: reuse the whole RX page on 64kB
 page kernels
From: Arthur Kiyanovski <akiyano@amazon.com>
To: Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Breno Leitao
	<leitao@debian.org>
CC: <kernel-team@meta.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Harry Yoo (Meta)" <harry@kernel.org>, "Shai
 Brandes" <shaibran@amazon.com>
In-Reply-To: <20261106-ena-rx-reuse-64k-page-v1-1-ac75b20c5de8@kernel.org>
References: <20261106-ena-rx-reuse-64k-page-v1-1-ac75b20c5de8@kernel.org>
Date: Fri, 13 Nov 2026 21:10:01 +0000
Message-ID: <179460420100.28403.4448372982347245597.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Fri, 06 Nov 2026 03:17:11 +0000, Harry Yoo (Meta) <harry@kernel.org> wrote:
> [...]
> ENA_PAGE_SIZE. With this fixed, a comparable workload pins only 497MB.
> 
> When PAGE_SIZE equals ENA_PAGE_SIZE, the room left in the page equals
> ena_buf->len, so nothing changes.
> 
> Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>

Hi Harry,
Thank you for the patch. The issue you are fixing is real, and the patch
is very welcome.

I want to suggest a few changes to make sure that the performance of the
datapath of 4KB pages is changed as little as possible, as this will be
the common case.

First:
DRB (Dynamic RX Buffers) - is what we call the reuse of the pages as
long as the remaining part is "large enough" instead of allocating a
new page for every new packet.

The ENA driver supports DRB only in the non XDP case.

Therefore some of the calculations you are doing per call to
ena_try_rx_buf_page_reuse() can be saved as compile time constants.

For that I suggest defining the following in ena_netdev.h:

+ #define ENA_RX_PAGE_ROOM    (PAGE_SIZE - NET_SKB_PAD -          \
+                   SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+ #define ENA_RX_MAX_BUF_LEN  (ENA_PAGE_SIZE - NET_SKB_PAD -          \
+                   SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))

Next I would like to use the old calculations for the simpler 4KB pages
case. See these suggestions inline.

Could you fold these into the respin?

Thanks,
Arthur

>
>
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 7eb6456ed0d5..4a35cb6a7785 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -926,19 +926,27 @@ static struct sk_buff *ena_alloc_skb(struct ena_ring *rx_ring, void *first_frag,
>  	return skb;
>  }
>  
> -static bool ena_try_rx_buf_page_reuse(struct ena_rx_buffer *rx_info, u16 buf_len,
> +static bool ena_try_rx_buf_page_reuse(struct ena_ring *rx_ring,

Becomes unused: struct ena_ring *rx_ring parameter and in call sites.

> +				      struct ena_rx_buffer *rx_info, u16 buf_len,
>  				      u16 len, int pkt_offset)
>  {
> +	int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));

Becomes unused:
-	int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));

>  	struct ena_com_buf *ena_buf = &rx_info->ena_buf;
> +	unsigned long room;

-	unsigned long room;
+	u32 room;

> +
> +	/* Room left up to the end of the page. On 64kB page kernels this
> +	 * can be more than ena_buf->len, which is capped at ENA_PAGE_SIZE.
> +	 */
> +	room = PAGE_SIZE - rx_info->page_offset - rx_ring->rx_headroom - tailroom;
>  

-       room = PAGE_SIZE - rx_info->page_offset - rx_ring->rx_headroom - tailroom;

In runtime there is no branch here because the result is known at
compile time (same with the next suggestion below):

+       if (PAGE_SIZE > ENA_PAGE_SIZE)
+               room = ENA_RX_PAGE_ROOM - rx_info->page_offset;
+       else
+               room = ena_buf->len;

>  	/* More than ENA_MIN_RX_BUF_SIZE left in the reused buffer
>  	 * for data + headroom + tailroom.
>  	 */
> -	if (SKB_DATA_ALIGN(len + pkt_offset) + ENA_MIN_RX_BUF_SIZE <= ena_buf->len) {
> +	if (SKB_DATA_ALIGN(len + pkt_offset) + ENA_MIN_RX_BUF_SIZE <= room) {
>  		page_ref_inc(rx_info->page);
>  		rx_info->page_offset += buf_len;
>  		ena_buf->paddr += buf_len;
> -		ena_buf->len -= buf_len;
> +		ena_buf->len = min(room - buf_len, ENA_PAGE_SIZE);

-               ena_buf->len = min(room - buf_len, ENA_PAGE_SIZE);
+               if (PAGE_SIZE > ENA_PAGE_SIZE)
+                       ena_buf->len = min_t(u32, room - buf_len,
+                                            ENA_RX_MAX_BUF_LEN);
+               else
+                       ena_buf->len -= buf_len;

Use ENA_RX_MAX_BUF_LEN here too, so that headroom + len + tailroom
stays within ENA_PAGE_SIZE as it does elsewhere in the driver.

-- 
Arthur Kiyanovski <akiyano@amazon.com>
