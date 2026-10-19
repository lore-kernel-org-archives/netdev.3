Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DEE4ADD97;
	Mon, 19 Oct 2026 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404894; cv=none; b=IIwM7/KPp3bISq8QnKR7OicdV/gYeB4JfqlbTeQpCnpuSk/MYN3P1TiIjWivpYbdTU3UxXpC+EPaw8O1Oj3DnKVYUQfWum9ZLNNzdN1aKAsrMYVLiysERjrjyG7XluuYZf5A/n6i4LNjAho3iupxjrDcDOwHjH0Hg8/lWiy3pv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404894; c=relaxed/simple;
	bh=1eXwY7/I+iJ2v8Ki3peXvImDVovue3VG5PXtS+K3VoE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=C44JlSBWnN+d6Jt5+a6JzgdJ1XrpGTPmPLPHD5Y73ahGqV35/0zsqOACwb9/+DP8vUEtiDp1cAJtkNYuXQz/K9Gn4kvom6H2HJDYnmCFveY95BnfzC4P+ElH+P3yo7NaU4DwKB6nFyPi5Kj4A+XkOkZmxvne5NDflee1ySWIL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Su6Yj7Xr; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Su6Yj7Xr"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A99F1A1584;
	Mon, 19 Oct 2026 12:14:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792404890; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yNIklo0e+FghYVj5vJdXCDS67112tcNKmBhcCw427F0=;
	b=Su6Yj7XrYuYxCFORqB+isOvVO8pfCPgScsa+8/PfWhF0XJt7WYXH+uMKedWEbUVv5V0fe3
	901ssD5kVOyBowwec5wPWkYapceyuUrUky3JNig98hQMrAoj+XzeZ/gsydIek9eeXqcKEa
	HnEVI7FJ4bsbdzWZUrSl2x+5Kw9BTpJC3fOMQEPbicpqKLH071J63e0fbt6vJJ3jpadnwg
	qKbcA0pN2XKV7LJTSZkUcWGcSUXQID8VhYbMn7i33JGAJ6nTOaiZwnmNxrpIZh7iZHTZRn
	AwdBFaV+5oBtXVplflpn8Cf4EWt5jzzabjN2CiimzB+wt7kTa3tOReUTdEVNuw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 12:14:49 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
 Raju.Lakkaraju@microchip.com, davthompson@nvidia.com
Subject: Re: [PATCH net-next v1 5/5] net: lan743x: add byte queue limits
 support
In-Reply-To: <1e42bb2a36f305d8b3ba805e85d18c3dcda14887.1792008404.git.cbabroski@nvidia.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
 <1e42bb2a36f305d8b3ba805e85d18c3dcda14887.1792008404.git.cbabroski@nvidia.com>
Message-ID: <37cc7e1bcc81c71ef9bf2009e1eb68a8@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 15.10.2026 17:00, Chris Babroski wrote:
> Report the bytes queued to and completed by each TX ring to BQL.
> 
> Besides limiting how much data sits in the TX ring, this lets the stack
> stop a queue once the bytes in flight exceed the BQL limit. Without it,
> a queue is only stopped when its 128 entry ring is full, and the TX
> watchdog only looks at stopped queues. With light traffic it can take
> tens of seconds after a TX hang to fill the ring, before the watchdog
> timeout even starts counting.
> 
> lan743x_tx_close() frees pending descriptors without completing them,
> so reset the BQL state there.
> 
> Assisted-by: LLM
> Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c 
> b/drivers/net/ethernet/microchip/lan743x_main.c
> index 2545a846478d..7739fa49fc44 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -1708,10 +1708,23 @@ static int lan743x_tx_next_index(struct 
> lan743x_tx *tx, int index)
> 
>  static void lan743x_tx_release_completed_descriptors(struct lan743x_tx 
> *tx)
>  {
> +	struct lan743x_tx_buffer_info *buffer_info;
> +	unsigned int bytes = 0;
> +	unsigned int pkts = 0;
> +
>  	while (le32_to_cpu(*tx->head_cpu_ptr) != (tx->last_head)) {
> +		buffer_info = &tx->buffer_info[tx->last_head];
> +		if (buffer_info->skb) {
> +			bytes += buffer_info->skb->len;
> +			pkts++;
> +		}
>  		lan743x_tx_release_desc(tx, tx->last_head, false);
>  		tx->last_head = lan743x_tx_next_index(tx, tx->last_head);
>  	}
> +
> +	netdev_tx_completed_queue(netdev_get_tx_queue(tx->adapter->netdev,
> +						      tx->channel_number),
> +				  pkts, bytes);
>  }
> 
>  static void lan743x_tx_release_all_descriptors(struct lan743x_tx *tx)
> @@ -2003,6 +2016,10 @@ static void lan743x_tx_frame_end(struct 
> lan743x_tx *tx,
>  	if (ignore_sync)
>  		buffer_info->flags |= TX_BUFFER_INFO_FLAG_IGNORE_SYNC;
> 
> +	netdev_tx_sent_queue(netdev_get_tx_queue(adapter->netdev,
> +						 tx->channel_number),
> +			     skb->len);
> +
>  	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
>  	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
>  	tx->frame_tail = lan743x_tx_next_index(tx, tx->frame_tail);
> @@ -2276,6 +2293,8 @@ static void lan743x_tx_close(struct lan743x_tx 
> *tx)
>  				 0, 1000, 20000, 100);
> 
>  	lan743x_tx_release_all_descriptors(tx);
> +	netdev_tx_reset_queue(netdev_get_tx_queue(adapter->netdev,
> +						  tx->channel_number));
> 
>  	tx->rqd_descriptors = 0;

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
