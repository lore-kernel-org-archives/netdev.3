Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A41217F27
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775414937; cv=none; b=HhdW8+7nKeG1P62ENW7WdMFyv/T1GvTQHFlq6BYpR1w2ZHDzwRIo6AyWf6do/he1iClby0KSAh1+vLbzOmL2G/ZqjMApgYomjzA7KWyIxddEFPghffgobteo01Xqn36o+emQoNuj9cHxfQqUbbmugOrLd7mddLqmvQxnBmpQEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775414937; c=relaxed/simple;
	bh=HhdXzIJLM1Rn5JbiMjzV3GyTYXA1NOLeWtl1ZvzyAFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdRL2OsL/AkEcufKGnCaWWhrYlLNCWvNaNCywwUrp9J5eWQAgpXtcNkaXfGXYUqyCrqNKv3sX5Xmq/87vqQR3RB/7h2dD9pspsQRvEEEgqAZxGWlI6MZW2srDTHaDQXAYfxy0/fXHNPv2rxuLyIuTscidxD7nuXto76qrRYliE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=bR4vDQAO; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="bR4vDQAO"
Received: from x1 (13.3.31.150.dy.iij4u.or.jp [150.31.3.13])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 635Im9t1020855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 6 Apr 2026 03:48:10 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=d0m/uSUpZ4dD0X+/7W9eQ9TTrjWvnwv1/3y5kplZ7gI=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1775414890; v=1;
        b=bR4vDQAON069DCBuPJt/JmmvOJNWItx17AaDhUEi0qRxG0wZ+Pkq5h92ALAZEZJz
         zq0QdsondLNMACcqc1aOvseBkboSqI6yq2OnQI8Eqls1amAB3Q2AdV+ALVArGHt7
         ZI9aUPP+GE3du892uBTWFsSyhHrNz5j7Cq5y+q3mTpfFBTvkXZ+Q4l3kdBW37lbA
         mgU2nrR5PAizp93ZXRsN8LwuPHVhQIERDfGpv1i6RgFfkOwl8v1vOmI7vvZysIga
         Vq1MDbmUU5bRNd0IEs02hMmMRIl0CjHkDBs/Kwj9eE7l/KGlTgo1nof6MjsqB1gt
         pXsH5aTQktwSxxyJxiG1yQ==
Date: Mon, 6 Apr 2026 03:48:09 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH] ice: wait for reset completion in
 ice_resume()
Message-ID: <adKr6gLrkL9TGimW@x1>
References: <20260402024220.210466-1-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402024220.210466-1-aaron.ma@canonical.com>

On 04/02 10:42, Aaron Ma via Intel-wired-lan wrote:
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index 3c36e3641b9e9..a029c247510fd 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5702,6 +5702,16 @@ static int ice_resume(struct device *dev)
>  	/* Restart the service task */
>  	mod_timer(&pf->serv_tmr, round_jiffies(jiffies + pf->serv_tmr_period));
>  
> +	/* Wait for the scheduled reset to finish so that the device is fully
> +	 * operational before returning. Without this, userspace (e.g.
> +	 * NetworkManager) may try to open the net device while the
> +	 * asynchronous reset and rebuild is still in progress, resulting in
> +	 * "can't open net device while reset is in progress" errors.
> +	 */

nit:
IIUC, this change is best-effort, since ice_resume() still returns
success even if ice_wait_for_reset() fails. If so, the new comment may
be better phrased to reflect that.

Otherwise, it looks good to me.

