Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA9353EDF;
	Thu, 13 Aug 2026 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614935; cv=none; b=r5/FuFdNvhk0ySd/KVD0Ssh0dvifk+YoPaLd0jeubgn4OI3berdTZeqHzlKZBlnKgyjQmp+9pImq/ZyBZB8O+Tm/Qd/+sJEqr91XcmKqamKbLR56gnSFOxu6xKlkJo7XWiWojg0frwGbcrsxYLbbH+aCTKAsDDYs5VyQJoCR/M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614935; c=relaxed/simple;
	bh=la5f4ZT9IRk83zzTEDeq6++g3nftlPGwHElIDy1F8n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZocEV0Jf9aTn/JC/cghESkx485YRiCyLfRm8M1knzUUevld3coEg+f0/gb7/2uhPXSQYc9iZ/t0iIiieA1xRieNi2YWNv63ChebxtWBhX0FMctjTwqldX4Iz3Qhx4scrQ8+d46ugaTd/fXvDEuq6MVTQyCDMdrrAvIkiAsF/+Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wuS9U-000000001zE-34Ob;
	Thu, 13 Aug 2026 09:55:08 +0000
Date: Thu, 13 Aug 2026 10:54:57 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, horms@kernel.org, corbet@lwn.net,
	skhan@linuxfoundation.org, andrew@lunn.ch, olteanv@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 3/5] net: dsa: mxl862xx: add devlink
 flash_update and info_get
Message-ID: <an2UcS6q9AZp7vxq@makrotopia.org>
References: <66aaa1b09b0f2e9e74a7274a878c6902e1aa2b9c.1786294649.git.daniel@makrotopia.org>
 <20260813082233.71011-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813082233.71011-1-pabeni@redhat.com>

On Thu, Aug 13, 2026 at 10:22:33AM +0200, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev/
> ---
> Subject: net: dsa: mxl862xx: add devlink flash_update and info_get
> 
> This commit implements runtime firmware upgrading for the MxL862xx switch
> using devlink dev flash. It transfers the firmware image over SB PDI,
> reboots the switch, and defers a device reprobe to re-initialize the driver
> using a workqueue.
> 
> > diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> > new file mode 100644
> > index 0000000000000..9799cf19d31a9
> > --- /dev/null
> > +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> 
> [ ... ]
> 
> > +static void mxl862xx_reprobe_work_fn(struct work_struct *work)
> > +{
> > +	struct mxl862xx_reprobe *rp =
> > +		container_of(work, struct mxl862xx_reprobe, work.work);
> > +	struct device *dev = rp->dev;
> > +	bool bound;
> > +
> > +	device_lock(dev);
> > +	bound = !!dev_get_drvdata(dev);
> > +	device_unlock(dev);
> > +
> > +	if (!bound)
> > +		dev_dbg(dev, "reprobe skipped, device is gone\n");
> > +	else if (device_reprobe(dev))
> 
> [Severity: High]
> Is there a race window here that can lead to a use-after-free of priv?
> 
> If device_shutdown() runs after device_unlock() but before
> device_reprobe(), it can clear drvdata. When device_reprobe() subsequently
> runs, it triggers the driver remove() function, which returns early because
> drvdata is NULL, bypassing dsa_unregister_switch().
> 
> However, because priv was allocated with devm_kzalloc() during probe:
> 
> drivers/net/dsa/mxl862xx/mxl862xx.c:mxl862xx_probe() {
>     priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>     ...
> }
> 
> the driver core will still run devres_release_all() and free priv. The DSA
> switch remains registered, and any subsequent access to it via devlink or
> netlink could dereference the freed priv pointer.
> 
> > +		dev_err(dev, "reprobe failed; device left unbound\n");
> > +
> > +	put_device(dev);
> > +	kfree(rp);
> > +	module_put(THIS_MODULE);
> > +}
> 
> [Severity: High]
> Can this cause a kernel panic if the module is unloaded concurrently?
> 
> Calling module_put(THIS_MODULE) at the very end of a work item means the
> module reference count drops to zero before the function fully returns to
> the workqueue core.
> 
> A concurrent rmmod can then proceed and unmap the module text section. If
> the worker thread is preempted or delayed, it will resume execution from
> unmapped memory during the function epilogue, leading to a fatal page fault.
> -- 
> This is an AI-generated review.
> 

Both issues are real, but hard to trigger in practise.
See

https://lore.kernel.org/all/anpxFdwNxk0XwPjQ@makrotopia.org/

for a proposal fixing this in other existing drivers (mxl862xx re-probe is
modelled after iwlwifi which suffers from the same issue)

I suggest to merge this series as is, I'll then convert mxl862xx to use
device_schedule_reprobe() once it has landed.
