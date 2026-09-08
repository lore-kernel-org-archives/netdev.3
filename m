Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2041D228;
	Tue,  8 Sep 2026 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858769; cv=none; b=X7ChnqCy0PGTIYDmxjDNEGPt+agnDdSoLOPJ7tCbx+4dveHZy2lPKDsGk2fF95xVvT6/06QnOrDmjsVMekLvNgd+5AqIGl+Z99/YfcbIbNApnj2ToxeXtizcHwrZFWRP05APOXy0rcQDx2UDcSEd5BA60sGOhmKAySuaU8YC9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858769; c=relaxed/simple;
	bh=2VYm5IC7nuJ6OknmMvYKwB3JYyLeLDeJ7e8jb90oMIc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ZVchFrVo2GoqIFF2K/K3mOaMBD0Zejho8oNTCzXCVeiRNr1ovMsiF1yV6EYURapr5rj6uVuPZ28zROYe17h4OJpe1xrIi6kLisLRrTxY4NbmRFiYaofBDafpPE+1MCJbmDPitX7exE66vm0Z0b9I+VpXvhwrmGFXUoNDIaZ2YZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=YT9tXJlI; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="YT9tXJlI"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52F7DA900F;
	Tue,  8 Sep 2026 11:12:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1788858761; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Sc/cb0D1NeF0QIYQrpnHf0R8EKpxNCtbo752/2TJJzo=;
	b=YT9tXJlI2CsJIPw32viEZbbPRsbRQ79zfxRTQtauYyDc3Ju/de/5V3TboTnIKFDzmYn6g+
	lqMFBTeEXCuxhWdltN/a2ULsCkNRc5p+T9/KKLH07ORF3okn29OdSAjxjtlpSg76NIHkXB
	9XuIY0X6uCU3Wf5dKj8FNy1zCAC+u5PPQeorlCl6B6WvNix5zQnoW0Nd9pPUkZE7iYGZdg
	OWqzti6z/TLmFit1ahJtd9AyQ2QJp5EI4fO+1OdSp+y1oWweoom8s3QerxXKJW5K7wOp7Y
	UI8sk85o7mmVdmCZCNOgk8gKusixMXg492YAg2yW3Lpyr/LXRsWG8LwyVyQCEQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 08 Sep 2026 11:12:37 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: James Clark <jjc@jclark.com>
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>, Conor
 Dooley <conor.dooley@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net] net: macb: fix ordering around PTP timestamp read
In-Reply-To: <20260908053150.28694-1-jjc@jclark.com>
References: <20260908053150.28694-1-jjc@jclark.com>
Message-ID: <efc8c860b90e8f55882241267b0e242d@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi James

On 8.9.2026 07:31, James Clark wrote:
> PTP_SYS_OFFSET_EXTENDED returns system timestamps that do not correctly
> bracket the PHC register read on MACB/GEM. On a Raspberry Pi 5, the
> returned interval can be as short as 37 ns, while an ordered register
> read takes approximately 1 us. This biases the midpoint used by 
> phc2sys,
> causing CLOCK_REALTIME to run approximately 0.5 us ahead when 
> synchronized
> to the PHC.
> 
> gem_tsu_get_time() reads the nanoseconds register using the driver's
> relaxed MMIO accessor. On weakly ordered systems, the subsequent system
> timestamp can be taken before the register read completes.
> 
> Add rmb() after the bracketed nanoseconds read in both the normal and
> seconds rollover paths, ensuring that the read completes before the 
> post
> timestamp is taken. With the fix, the minimum interval on the same
> Raspberry Pi 5 increases to approximately 1 us.
> 
> Fixes: e51bb5c2784c ("net: macb: ptp: Switch to gettimex64() 
> interface")
> Signed-off-by: James Clark <jjc@jclark.com>
> ---
> This uses rmb() to preserve the existing accessor and endianness 
> handling.
> Would an ordered MMIO accessor be preferable for these two reads?

AFAIU rmb() fits better here. Switching to readl() would also order the 
read
on arm64, but only for hw_readl(). hw_readl_native() uses __raw_readl(), 
which
has no ordered version, so that path would still need a barrier.

> 
> Reproducer:
> 
> #include <fcntl.h>
> #include <linux/ptp_clock.h>
> #include <stdio.h>
> #include <sys/ioctl.h>
> 
> #define DEVICE "/dev/ptp0"
> 
> int main(void)
> {
> 	struct ptp_sys_offset_extended ex = { .n_samples = 25 };
> 	long long min = -1;
> 	int fd = open(DEVICE, O_RDONLY);
> 
> 	if (fd < 0) {
> 		perror(DEVICE);
> 		return 1;
> 	}
> 	for (int batch = 0; batch < 40; batch++) {
> 		if (ioctl(fd, PTP_SYS_OFFSET_EXTENDED, &ex) < 0) {
> 			perror("PTP_SYS_OFFSET_EXTENDED");
> 			return 1;
> 		}
> 		for (unsigned int i = 0; i < ex.n_samples; i++) {
> 			long long bracket = (ex.ts[i][2].sec - ex.ts[i][0].sec) * 
> 1000000000LL
> 				+ (long long)ex.ts[i][2].nsec - ex.ts[i][0].nsec;
> 			if (min < 0 || bracket < min)
> 				min = bracket;
> 		}
> 	}
> 	printf("min bracket: %lld ns\n", min);
> 	return 0;
> }
> 
>  drivers/net/ethernet/cadence/macb_ptp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_ptp.c 
> b/drivers/net/ethernet/cadence/macb_ptp.c
> index e5195d7da..8209ec190 100644
> --- a/drivers/net/ethernet/cadence/macb_ptp.c
> +++ b/drivers/net/ethernet/cadence/macb_ptp.c
> @@ -51,6 +51,8 @@ static int gem_tsu_get_time(struct ptp_clock_info 
> *ptp, struct timespec64 *ts,
>  	spin_lock_irqsave(&bp->tsu_clk_lock, flags);
>  	ptp_read_system_prets(sts);
>  	first = gem_readl(bp, TN);
> +	/* Ensure the PHC read completes before taking the post timestamp. */
> +	rmb();
>  	ptp_read_system_postts(sts);
>  	secl = gem_readl(bp, TSL);
>  	sech = gem_readl(bp, TSH);
> @@ -63,6 +65,8 @@ static int gem_tsu_get_time(struct ptp_clock_info 
> *ptp, struct timespec64 *ts,
>  		 */
>  		ptp_read_system_prets(sts);
>  		ts->tv_nsec = gem_readl(bp, TN);
> +		/* Ensure the PHC read completes before taking the post timestamp. 
> */

nit: comment should be wrapped, to fit in the usual line length

> +		rmb();
>  		ptp_read_system_postts(sts);
>  		secl = gem_readl(bp, TSL);
>  		sech = gem_readl(bp, TSH);


Tested-by: Nicolai Buchwitz <nb@tipi-net.de> # Raspberry Pi CM5, min 
bracket 37 ns -> 981 ns
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
