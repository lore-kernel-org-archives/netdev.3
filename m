Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013CB334C05;
	Tue, 11 Aug 2026 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484396; cv=none; b=DlE/AHvTzKQrzL279c5Z45AeCGH1/qA/xcsxW2yuPp9CL3zxCCA+jw+U1am6zmq4JT/pwKr17ripXtsoga1HicADgLTU3N56EffQM+UOxBLPZ/lKwfT+QyylskojfTdyq4qDlA9qrmVpICrsGKEB+dspZ0TQ5eA6SFDdkizNook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484396; c=relaxed/simple;
	bh=0ydN1dOFogfF+NmxEKuzwqvV0ue4DwQqs1H77rphn5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0EIZD4AWqj+DAH/updyNw5CGm7tm0RJ5GCDoWbYFHKBiVsvTyyBhPEnmATuLxqmaYAV6GGzEmxKjDtfYhZoFvL2pC2DCP4zHdH21WdH4fHHHqBB9nUgHAkF5+0pL7DgafRuCCAg0rqtJT73J+TqC/5tweryYAa7TyvjUUpFRaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b68pZujF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b68pZujF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377761F000E9;
	Tue, 11 Aug 2026 21:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786484394;
	bh=ZqTcN1PasVGnl8221zLotA+HhEu2DCh+PLsghGoWCs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b68pZujFiZYFHUcUQl7v6ZjfdltHLBQAWYuK5gTsX/tWvQW9PIKECY3o3upboO4L7
	 FfUn/p21RmxqrHFoKcwId6jNgEjJT7EHGf5BOcPr+TGWH81qTKzv5HrcSIUSwFusW1
	 xpcQclNMu+Hi0NjzXIJvS+obFJ7kkxGVPxPOQU6+pPpiEw385WOUMLhweDnjD92dkF
	 SWFTZoQS5Vocg2LBitnFMumZ+SY5in2epQfc/OikANwglrD/GBIGDvsqFRW4xuxTKu
	 RuG0WMgre9/I3kwO7MbcqqIBp115DZAZA0YaaVvS7wTTmK5EcCNoupqqdoqPUCwpk9
	 gmWpjYSqcAqBA==
Date: Tue, 11 Aug 2026 14:39:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>, Simona
 Vetter <simona@ffwll.ch>, "David Airlie" <airlied@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Riana Tauro <riana.tauro@intel.com>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: Add entries for drm_ras
Message-ID: <20260811143953.01329a4e@kernel.org>
In-Reply-To: <anuCGPAUpJTs7Ztz@intel.com>
References: <20260805094949.536651-2-rodrigo.vivi@intel.com>
	<anMeN5B8LbaM41jz@black.igk.intel.com>
	<anuCGPAUpJTs7Ztz@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 16:12:08 -0400 Rodrigo Vivi wrote:
> > > +M:	Riana Tauro <riana.tauro@intel.com>
> > > +M:	Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > +R:	Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > > +L:	dri-devel@lists.freedesktop.org
> > > +S:	Supported
> > > +T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> > > +F:	Documentation/netlink/specs/drm_ras.yaml  
> 
> Net maintainers, ack?

Makes no difference to us FWIW (even with a more specific entry
the files still fall under the overall YNL entry).

But the M's match the authors so why not:

Acked-by: Jakub Kicinski <kuba@kernel.org>
