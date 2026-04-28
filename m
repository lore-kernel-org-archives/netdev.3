Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9E3330D23;
	Tue, 28 Apr 2026 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397080; cv=none; b=NsQZ74yoA8wKi+AS4j05l7FWmEUVw/PXeg65fCYcbDOCtpeDk+DSmm74Z2wste0a4V0IsPy3l2pb166Cn96/079rYXrVt7Dx83zQxFX5wr1v399LzCKPpFa+Xo/RgF1LxGYWBd/C/pg4ke/3T23UEoT+gvfXd+LiYr/ElnGOCcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397080; c=relaxed/simple;
	bh=Ks+zy8T12Y6GZ3FyFHq88+2s6itPF5th9+YzVmFMPwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYcyrl1Ywuvm0D7KWqTK8AjI/SQPwd6quWgrzvw+nIhNlGTar4cUP2oXrAb9HNhzk9yy3LWXNzIDsVWrMcY9b5tVhKWFnwyz+2yi3nfv3dcRtZ3lwWquPnLjYv1Z3OD3boVOg5e8udWLQ5phCEJYL5U1Q3NhU5Y2s+QTf5OdDVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2IgLQxS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2IgLQxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777397079; x=1808933079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ks+zy8T12Y6GZ3FyFHq88+2s6itPF5th9+YzVmFMPwo=;
  b=R2IgLQxSfHSMOetaOaavA3GFn4ASvAy6m1/dhfb0zUqc4t2VRDBt5UEV
   Pv0d6mvf+2ptWhOEpJVFsFfxWbIcndxxmS/Nf/vRbtfuiKKDp2f+FYAMN
   7ERHOpJ4pC60+v57+o0Qvsmp2gQI2KuobvowXj0oCASlKjcHwuiCz3EUh
   ArD90Nq30hlZrpKQ23DsSZcS1PzkR0/XpfuJbITM+yfyVxZdt71nyKKbj
   QUffEnsm4fqd2wC9nNPKvQdBxipaGOW8os3i5vu9e+/UhjWjH2H/waEEH
   BpCZ3pAOuNsQnusaSQiFrIFrsSKaOHGz3zYCSOqipmftSYKNnXJC8pNWa
   A==;
X-CSE-ConnectionGUID: uNC1CH1MTNWXkM1yM1HR6Q==
X-CSE-MsgGUID: ELZld8VHSg2N4c/KvTyc8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78230536"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78230536"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 10:24:38 -0700
X-CSE-ConnectionGUID: yh4CqZhkQu2gGGaQsgX3aw==
X-CSE-MsgGUID: whgKWaQlQJuBDL0j66PmVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="272157200"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 28 Apr 2026 10:24:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 375A595; Tue, 28 Apr 2026 19:24:34 +0200 (CEST)
Date: Tue, 28 Apr 2026 19:24:34 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 9/9] thunderbolt: Add support for USB4STREAM
Message-ID: <20260428172434.GV557136@black.igk.intel.com>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
 <20260428072209.3084930-10-mika.westerberg@linux.intel.com>
 <ef5411f4-0e4c-4ac1-8ae0-0d557fc0ebd2@lunn.ch>
 <20260428151311.GU557136@black.igk.intel.com>
 <e38bb396-748f-435d-9d17-5e7799edcc64@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e38bb396-748f-435d-9d17-5e7799edcc64@lunn.ch>

On Tue, Apr 28, 2026 at 06:45:34PM +0200, Andrew Lunn wrote:
> > > Is this mutually exclusive to networking, on a device?
> > 
> > No - they can co-exist.
> 
> Do they have there own rings? So that ethtool -C on the netdev will
> not conflict with your configfs setting of the interrupt coalescing
> for the stream?

Yes they use their own rings.
