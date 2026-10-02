Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A07331200
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790974236; cv=none; b=W+wNT0jp9KoVeRwkhK2askn1+XfWsOjIKEuPcnU+wLfPEBs5yl8HaEw97a1amoxzhPD73s7SfQZEueCrHU67mTS9gKARAQyFtlMQMldP6+94YPepyHdGnw8HtDC/rWOAyB3rmLftqDAahEVDdfbblMrqV1kJIW7Z8DK7h5rkqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790974236; c=relaxed/simple;
	bh=r0wAsCW09uYJLGw/k9Eanv0esNYUb2MmEuteA4NS4xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP46PN8t8YtGOHdjVUwS9O5XjgloH+zpSYb35P9AmtP1fi/OsiIjmC2RiXpB3A40Gul0BmTkvPbydH18TQOZtWrn3GW2Z3XoakTaWhS7dq3qRKn0wce3wo8RqXingwighkcM7F42GNb7FIbjHRm5K1ffZkWmt92LqMnEdFnv3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=X1UUwx/S; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="X1UUwx/S"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso2583448a91.3
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 13:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1790974234; x=1791579034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPjEZZ9EpGI2YyupaPWjnZ3uGj54v5irCmpCUt3ENzE=;
        b=X1UUwx/StpRGBM3DXE758FkAphrL0xKzpMwyKedC7rBEnd3nfN1DjBMxvX/YzIj13f
         Mk5F54yAL9m+viVNnmI3AxVisxDYLphDUhBzbMkBdZZUfuajG3DdSkwFVKLmOlLQbRmu
         3jQnN6MYv/7RWkli2HKH/yW0+8Z1vEP5n9i88kywQ65+tgYMqrP1dJ3mj8O1DMW3kFsQ
         2FXGIPAJ1VUXz/FNlFMdsi0oaF/d2qXJqNPO9w0WGyADbvhXiNPefn2JoFfswFb4Pl92
         A6J0HXkgN1h1ksYXAegw8LP3IvRLYDDn39jDDqYr2Jl/2zFo5LY/Mu/Y4jftqP9QBDLS
         YnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790974234; x=1791579034;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aPjEZZ9EpGI2YyupaPWjnZ3uGj54v5irCmpCUt3ENzE=;
        b=HU6tBKW2nqBkv9MygjLr8VTDWt7e7RosTqYunv0tqgJA1dqPpiNLVM+51eVF2foZxJ
         DTRBum65K3uvKKCvaceN44BhGfmQTvtqtbBPRqtMsm/CROOku3+ZSSNHzWz5IfXtpNpO
         MqQsRcluEb2OEyjU0H4mTTeH5xDUKOyZC5XpWuUBjpRt3vAlfzxJoeVQ8wOgk7MmaFm3
         h0tw2AqxKLY+ZJ/P47uCYdO5bLR2U6LV2tdrIgDrPvpOv8/5ZEYNieNd5bxQdUk6+5vf
         s9XtjTjko6fDZMAyIU6DB22pB360hG/W9iZoV5MAA555Y2tI1Ji1KXY2rzxEsZ4/5RAt
         hspQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlLrIIw1eZxO/37FwrWNg7PbMU3QrCKtuXfyzkP54rF+OCAQo/sJck2Df5qJRMa4Ep+xFXqYg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIs4wBgkiVRrsaNMt1TMmKCA3b7sjA0lGFBvhattmkQgquEptBT
	K67c01taeNqYsC5LFxNZ0v6dfESTN/9wBgVrq3UnuUKNkl+ROPs6goxnsF9Sridu7QE=
X-Gm-Gg: AYBFou1iIAnkr5U2D4DgFT8SN2joil18vR3YY1fDEF1FlMlHg6RsGWrXe6cDkPmEZO2
	/Qd0oig8/2fwKhXofY6orAynJhDrQsJVJKreziWUJ8IaYyUq2YwH+i3I1gKSRNhshkc0zvqA/eC
	TOyfQYTcItz6Ssss4B7Y0096orUhqow8doC/KyXrW791HtsfJ3qTzxu42bVSJa26vSei+JEyQKi
	mu9LU+9NsEmFYUgj5J1nLLZ/CzNW+drui853DcDwXRTjKW40nh49GR9spGu5BChUj843AuEVLl1
	DU87mVvLCrHRtvjVXFZFSthRiEcQaFGDQVDUkCTylFkXz+k0wopfyr3KFl2tmPMtifFMJaRUPu+
	yARRWz0R1r67H6r2H9Ob3gsz+PtKPKs0pDas/RoyU3bHraaD3kXDuPZnxu3zR2XvojL1IqgdRP7
	WfDlWFyvlDEHGoNQk9loIk8XNNFZeV03Xf7HgwZbh/5bWqWluOSRwpZb4561PF6/4A8FgqB+P6D
	FbWmCn7Umrq
X-Received: by 2002:a17:90b:1d43:b0:39e:1633:d29e with SMTP id 98e67ed59e1d1-3a786736686mr353131a91.5.1790974234324;
        Fri, 02 Oct 2026 13:50:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d4f7316sm60634a91.9.2026.10.02.13.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:50:32 -0700 (PDT)
Date: Fri, 2 Oct 2026 13:50:31 -0700
From: Joe Damato <joe@dama.to>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 1/5] eea: Drop temporary buffer by using
 %*pEhp directly
Message-ID: <asAZF53tsdq/QAYv@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20261002100035.863275-1-andriy.shevchenko@linux.intel.com>
 <20261002100035.863275-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002100035.863275-2-andriy.shevchenko@linux.intel.com>

On Fri, Oct 02, 2026 at 11:59:19AM +0200, Andy Shevchenko wrote:
> Instead of calling string_escape_str() followed by %s specifier,
> use %*pEhp specifier directly. With this being done, drop temporary
> buffer.
> 
> Note, as Sashiko pointed out in [1] the %*pEp, which is the direct
> substitution of the original call to string_escape_str() with ESCAPE_NP
> flag set, makes the whole thing like "no escape". To add some sanity
> to this the used specifier also includes ESCAPE_HEX.
> 
> Link: https://lore.kernel.org/r/179089728102.434549.12368098081790653201@kernel.org [1]
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/ethernet/alibaba/eea/eea_adminq.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
> index 73d0caf25700..f2284fc885c3 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_adminq.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
> @@ -522,16 +522,9 @@ void eea_adminq_config_host_info(struct eea_net *enet)
>  			dev_warn(dev, "The hardware-driven state validation may be abnormal.\n");
>  
>  		if (rep->has_reply) {
> -			char buf[EEA_HINFO_MAX_REP_LEN] = {0};
> -
>  			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
> -
> -			string_escape_str(rep->reply_str, buf, sizeof(buf),
> -					  ESCAPE_NP, NULL);
> -
> -			buf[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
> -
> -			dev_warn(dev, "Device replied: %s\n", buf);
> +			dev_warn(dev, "Device replied: %*pEhp\n",
> +				 (int)strlen(rep->reply_str), rep->reply_str);

i have no idea what this otuput could be but i suppose if you wanted to remove
the terminator write above, you could do:

   strnlen(rep->reply_str, ....)

instead, but that feels like a fairly useless nit so:

Reviewed-by: Joe Damato <joe@dama.to>
