Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0254D1DF25C
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784352427; cv=none; b=fa5i4dMNBxbvERfq31qJLPgtOg0zuor7KgL/EseJYz0GxlMagwZeyuVY/8bnybuJZ6zM5tew+yk4eSkg9tpIjEN5lV4UR0Rq273Loz5uylCmUWSpdqzLgxmyKzZnkTlgLmQV1jlwVKryd6yNGzzy5rgmMOnc8XHiZ3jZLBbvPzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784352427; c=relaxed/simple;
	bh=nZV8SHUwGVzCabLmhH/NnI+MtPu5E7IO8adSdE4qMQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjaS8acX1eDVOZ/4FGH89VSyMbrzr4cZcbpfIo5AVktMJq2ZSj82iiX6lDg7Txoz0sgVcKgP4Z6wNa28/FZUVr+aoKg4PPyjlKy/EY+MwAxkQdQF+erDio8qPoFqgJPfhF0lhAKlqCWoJC4R7bNRxkauD0QtVs9scm083aq7Uwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNGyrNJS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNGyrNJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784352424; x=1815888424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nZV8SHUwGVzCabLmhH/NnI+MtPu5E7IO8adSdE4qMQY=;
  b=iNGyrNJSW8br9eBGriy20Fm6IAqD2mSfoYVom4IToof9MRgcbfI/H+/z
   cXo2eobFYNFFbCrbA19ytk9TycQNnmeOlCExYLC2QeRgsphYDmPIsqXBj
   kM6m76OWqG7zhxmz6P428IJggxMzeIUfiV88dyy+5OsnoIWuHWvYlyDMM
   9yih2W/nlv8XiOcFJdUCtrhYaXfFQvujOGVZGKUT5Oqb0SA+hKOFuGnBj
   fT2ichUDxpxFpW/zCALdD8QY2Nmz9mehsLJJ6BMacKctI7sUiUFKaZDvA
   qmN0XcsjdrsxfROMqUtIpv6PllB/lHJE9TgCdcUsl+o53l8jqjuQ4Kkfp
   Q==;
X-CSE-ConnectionGUID: yde/skwJSN+BoryEjT7DpQ==
X-CSE-MsgGUID: IAXXZKo9TiuxSHB+05eoUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85042286"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="85042286"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 22:27:03 -0700
X-CSE-ConnectionGUID: IcI6DVwbRj2M8hyENn9wSg==
X-CSE-MsgGUID: K1lI7xygRZOz6lEKbOXWIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="261230655"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 22:27:00 -0700
Date: Sat, 18 Jul 2026 07:26:56 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
	kuba@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	dev@lankhorst.se, zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com, michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com, mallesh.koujalagi@intel.com
Subject: Re: [PATCH v4 2/5] drm/ras: Introduce error threshold
Message-ID: <alsOoFEuSPSyCMTB@black.igk.intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
 <20260623101043.255897-3-raag.jadav@intel.com>
 <0769389d-e73a-4dda-878c-2bc9e59deff3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0769389d-e73a-4dda-878c-2bc9e59deff3@intel.com>

On Fri, Jul 03, 2026 at 10:43:06AM +0530, Tauro, Riana wrote:
> On 23-06-2026 15:39, Raag Jadav wrote:
> > Add get-error-threshold and set-error-threshold command support which
> > allows querying/setting error threshold of the counter. Threshold in RAS
> > context means the number of errors the hardware is expected to accumulate
> > before it raises them to software. This is to have a fine grained control
> > over error notifications that are raised by the hardware.

...

> >    *     + The error counters in the driver doesn't need to be contiguous, but the
> >    *       driver must return -ENOENT to the query_error_counter as an indication
> >    *       that the ID should be skipped and not listed in the netlink API.
> > + *     + The driver can optionally implement query_error_threshold() and
> > + *       set_error_threshold() callbacks to facilitate getting/setting error
> > + *       threshold of the counter. Threshold in RAS context means the number of
> > + *       errors the hardware is expected to accumulate before it raises them to
> > + *       software. This is to have a fine grained control over error notifications
> > + *       that are raised by the hardware.
> > + *     + The driver is responsible for error threshold bounds checking.
> > + *     + Threshold of 0 can mean invalid threshold or act as a disable notifications
> > + *       toggle for that counter depending on usecase and the driver is responsible
> > + *       for handling it as needed.
> 
> I know i asked you to add this in last rev. But after reading this,
> error-threshold bounds checking at driver level
> should be sufficient.  It's upto the driver on what behavior needs to be
> implemented.
> 
> Some may notify on reaching threshold or crossing threshold.
> I think we should drop this sentence here. Let me know your thoughts.
> sorry for the confusion.

I think it adds more context and good to have in case someone comes up
looking for the details.

...

> > +	/**
> > +	 * @query_error_threshold:
> > +	 *
> > +	 * This callback is used by drm-ras to query error threshold of a
> > +	 * specific counter.
> > +	 *
> > +	 * Driver should expect query_error_threshold() to be called with
> > +	 * error_id from `error_counter_range.first` to
> > +	 * `error_counter_range.last`.
> > +	 *
> > +	 * Returns: 0 on success, negative error code on failure.
> > +	 */
> > +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id, const char **name,
> > +				     u32 *threshold);
> 
> Add a blank line

Sure.

> With these fixed
> 
> Reviewed-by: Riana Tauro <riana.tauro@intel.com>

Awesome.

Raag
