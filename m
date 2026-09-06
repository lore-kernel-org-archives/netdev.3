Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A4F41DDE8;
	Sun,  6 Sep 2026 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788684650; cv=none; b=NNSk8ToMiLSMx9cbwsXi/AqQw5u6vp2LYk3DeW5f6ocQfvTo9tmZOoPC54/V+pxyDybcFfn8nzLxl2mwsBNDy8JTP2FWrj6uWyVoZYeWPSwptAvbTrKG6y8wFJYH+HTQ5TAZOVxBJxPH+8ERQGhBTxsDScMi0em4lQ7/MUWUpOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788684650; c=relaxed/simple;
	bh=QCrxkLnBheZdSWs0VdpLCLOhV0iO414xVZBbiQbr2TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6KR+o4JGA+G+JBq2bpEbrxpNfBG10f2wsYNHNfcLCURUq9LJ3FmfnDXemucJBu+Npa62T+e51xchoDBjSCrLCG0UnRoxTpZzVRNEaeBAC/iXPJ/pbHxRlGCIgSZqA8iwDPmZhOjPXFED1D1X4Vr82lWEs7s4ivxSHpmstbFtiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdnF7prQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdnF7prQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BE01F00A3A;
	Sun,  6 Sep 2026 08:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788684646;
	bh=0id2YY5pP9gAEYb7cM3kFahfETFF3hnWLbjOK24RpHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kdnF7prQ8zopDeyyKcLUegLUsYl9i/7Z0B0Z/bFghhmV2Jtbyj/E4IJ5P9UZoO3nW
	 M0lbYNeiprBfoX28//ylZBcpaKgCdPGNPS7C2oIIhVyLZ+xc+4i3d2U7Elq6yNwrHz
	 WVWPW8lcqnb3KQ1Dq6O85vLPElvFEESM5B3MQ/pL6v9FunfVyV/dTrl36bjM2WVQfB
	 ytYSuFMijPSQytIBk1NKRhjIwiIKvDxf4NeoSnRx2v8OEYx0MzzD+RZ1BWr/ERUtnb
	 nQrf7sI2xxpcvV+cOgE6I/Bds8OEyVOAyCih/qreUR6iejI/3bcJrtrtU8ROWl+DvN
	 5+n08F2mZa/0w==
Date: Sun, 6 Sep 2026 09:50:42 +0100
From: Simon Horman <horms@kernel.org>
To: "Rawda, Tony" <Tony.Rawda@disney.com>
Cc: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"vitaly.lifshits@intel.com" <vitaly.lifshits@intel.com>,
	"sasha.neftin@intel.com" <sasha.neftin@intel.com>
Subject: Re: [PATCH] e1000e: set fixed clock frequency indication for Alder
 Point
Message-ID: <20260906085042.GF40544@horms.kernel.org>
References: <DM6PR03MB383684B3604D2B332361B810FAB62@DM6PR03MB3836.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR03MB383684B3604D2B332361B810FAB62@DM6PR03MB3836.namprd03.prod.outlook.com>

On Thu, Sep 03, 2026 at 06:06:33PM +0000, Rawda, Tony wrote:
> On some Alder Point (e1000_pch_adp) platforms the XTAL value reported in
> the software STRAP is incorrect, so the SYSCFI bit in TSYNCRXCTL selects
> a 24 MHz base frequency while the SYSTIM counter actually advances at
> 38.4 MHz. As a result the PTP hardware clock runs ~1.6x too fast
> (38.4/24), which prevents ptp4l and other PTP-based time sync from
> disciplining the clock.
> 
> Commit 688a0d61b2d7 ("e1000e: set fixed clock frequency indication for
> Nahum 11 and Nahum 13") fixed the same problem for e1000_pch_mtp,
> e1000_pch_lnp and e1000_pch_ptp. Alder Point silicon likewise always
> runs at 38.4 MHz, so give it the same fixed-frequency override in both
> e1000e_get_base_timinca() and e1000e_ptp_init().
> 
> Observed on an HP Z2 Mini G9 with I219-LM (17) [8086:1a1c]: before the
> change the PHC advanced 16.0 s per 10.0 s of wall-clock time and
> /sys/class/ptp/ptpN/max_adjustment read 999999999 (MAX_PPB_24MHZ);
> afterwards it advances ~10.0 s and max_adjustment reads 230769100
> (MAX_PPB_38400KHZ).
> 
> Fixes: 59e466888038 ("e1000e: Add support for Alder Lake")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tony Rawda <Tony.Rawda@disney.com>

Reviewed-by: Simon Horman <horms@kernel.org>

