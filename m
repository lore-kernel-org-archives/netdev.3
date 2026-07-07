Received: from bregans-0.gladserv.net (bregans-0.gladserv.net [185.128.210.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266A3B9D9E;
	Tue,  7 Jul 2026 20:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.210.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454781; cv=none; b=fbx47/HJ6L4cPlXr69jrdBDLK1NBaCDR5oReexNTcv9K5lKJ+sdbTWTiTOnDrmHQwEFyekGXDSFRK+Omy+xZlXvv72ZuJgeD5vGB0zRhGNDr/ezKNryRn6CvpcL1GNB1pvPzUp3ivVOpYm24ZPxdk5x2kp80G4pLqla26YMX0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454781; c=relaxed/simple;
	bh=WYqFwOi8quQy3Uk+VrFiQW/eZL0UWoAEItTKR3fuMzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fy8TqWheW8kwIolC9mWpORCFQdMbKhyFh/Jx477/vuAMWS6Wiw2FxCuqca+Bg0MDUVifLgpXcm34pkLwF4KIew60wTHGzAr6Yn9EymHxgrGES57kpWVjiL7Uu82MGZVyZIGPX2/v3pb/XHi+g3+ey+hxaj2ZCuileydb+YHcRgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.210.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Tue, 7 Jul 2026 22:05:52 +0200
From: Brett A C Sheffield <bacs@librecast.net>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] tun/tap & vhost-net: make qdisc backpressure
 opt-in via IFF_BACKPRESSURE
Message-ID: <ak1cIAwQzKS35x0m@karahi.librecast.net>
References: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
 <akt_Q7kdR3Zb8_GZ@karahi.librecast.net>
 <20260706091706-mutt-send-email-mst@kernel.org>
 <2728c540-2e76-4e06-9064-ed1dff071cbe@tu-dortmund.de>
 <akvhhy_JpH64KrcL@karahi.librecast.net>
 <0d28fdc4-3c03-48d6-bd59-e59f7a01f4b6@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d28fdc4-3c03-48d6-bd59-e59f7a01f4b6@tu-dortmund.de>

On 2026-07-07 08:52, Simon Schippers wrote:
> Brett, can you try the two attached patches here with iperf3?
> I think testing with 8 and 16 threads is enough, so where there is a
> regression.
> 
> The two patches are about time when to wake:
> Currently we wake after consuming half the internal ring buffer.
> One of the attached patches wakes after 2 cachelines (128 of 1000
> packets) and the other one just wakes once the ring buffer is empty.
> 
> This would really help :)

Sure...


7.2.0-rc2 (unpatched)

threads 1
[  5]   0.00-10.00  sec  20.4 GBytes  17.5 Gbits/sec    0            sender
[  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver

threads 2
[SUM]   0.00-10.00  sec  12.7 GBytes  10.9 Gbits/sec    0             sender
[SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver

threads 8
[SUM]   0.00-10.00  sec  11.5 GBytes  9.85 Gbits/sec    0             sender
[SUM]   0.00-10.01  sec  11.4 GBytes  9.83 Gbits/sec                  receiver

threads 16
[SUM]   0.00-10.00  sec  11.6 GBytes  9.95 Gbits/sec    0             sender
[SUM]   0.00-10.01  sec  11.5 GBytes  9.91 Gbits/sec                  receiver


7.2.0-rc2 with 0001-tun-set-waking-threshold-to-ptr_ring_empty.patch

threads 1
[  5]   0.00-10.00  sec  19.6 GBytes  16.8 Gbits/sec    0            sender
[  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver

threads 2
[SUM]   0.00-10.00  sec  11.1 GBytes  9.50 Gbits/sec    0             sender
[SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver

threads 8
[SUM]   0.00-10.00  sec  10.8 GBytes  9.25 Gbits/sec    0             sender
[SUM]   0.00-10.01  sec  10.7 GBytes  9.23 Gbits/sec                  receiver

threads 16
[SUM]   0.00-10.00  sec  10.9 GBytes  9.34 Gbits/sec    0             sender
[SUM]   0.00-10.01  sec  10.8 GBytes  9.30 Gbits/sec                  receiver


7.2.0-rc2 with 0001-tun-set-waking-threshold-to-tx_ring.batch.patch

threads 1
[  5]   0.00-10.00  sec  19.6 GBytes  16.9 Gbits/sec    2            sender
[  5]   0.00-10.00  sec  2.00 GBytes  1.72 Gbits/sec                  receiver

threads 2
[SUM]   0.00-10.00  sec  13.9 GBytes  11.9 Gbits/sec    0             sender
[SUM]   0.00-10.00  sec  4.00 GBytes  3.43 Gbits/sec                  receiver

threads 8
[SUM]   0.00-10.00  sec  12.7 GBytes  10.9 Gbits/sec    0             sender
[SUM]   0.00-10.01  sec  12.3 GBytes  10.6 Gbits/sec                  receiver

threads 16
[SUM]   0.00-10.00  sec  12.5 GBytes  10.7 Gbits/sec    0             sender
[SUM]   0.00-10.00  sec  12.4 GBytes  10.7 Gbits/sec                  receiver



HTH,


Brett
-- 
Brett Sheffield (he/him)
Librecast - Decentralising the Internet with Multicast
https://librecast.net/
https://blog.brettsheffield.com/
