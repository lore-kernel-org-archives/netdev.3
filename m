Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861FF239E7F;
	Fri,  3 Apr 2026 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220555; cv=none; b=YU5RHyAgHOmJK0TtHB/mrII8y46GJr9GKRqAK8Lqk1h436Yzg+ZTmc8lU6hjGamyKcV9qlxrrnfh75mybFD/8Q4XsEpAkXxXdU7+LDRJlnZwzoRJ2nBVR9+kM2/fmjrLVyTxWFF9RG4WEFqKtwWYmn/oFX/UcalClvu0MI8whZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220555; c=relaxed/simple;
	bh=+Gmps33FngXtRV+HbcVt1uHDIEW0qTrIRlrmLWpPgxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzlxQStfV5n+apwSRr7zw/iSCPyFWS21TsbtQBy/ZPtXKbsTy+FZ4X3SoyXSpvXIALKZzde0GeMlC+1VGNAv61mrtNpUqql3EoJT3G0rUBAW68zKnTFzfthhksazPdEVzQHwWBuxKeizGDn9m+AzvTToGaUswtmGfam4rbQej4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j1jVQVS4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j1jVQVS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDD0C4CEF7;
	Fri,  3 Apr 2026 12:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775220554;
	bh=+Gmps33FngXtRV+HbcVt1uHDIEW0qTrIRlrmLWpPgxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j1jVQVS4CboefT/ydBqJV/WJLRbiSr2Vlw5cdSsqh1FRxxdaSK2DnseVCQHRn4D5c
	 LGXeGgzVX2qO2UsbBeoejZOPYqhynBoXV/x79SoyjrXKicJNo0XRMek61VwTHH0LQj
	 W5GLKTL4ZTM+tDLloJh4lLU0shva0G4RByG9T5QY=
Date: Fri, 3 Apr 2026 14:49:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	Friend <netdev@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: commit 0c4f1c02d27a880b cause a deadlock issue
Message-ID: <2026040349-chowtime-freeload-5ca4@gregkh>
References: <CO6PR11MB5586A4475A5EEC47FC10398BCD53A@CO6PR11MB5586.namprd11.prod.outlook.com>
 <PH0PR11MB55934A1C9A8C35B1E751C247CD50A@PH0PR11MB5593.namprd11.prod.outlook.com>
 <14d65103-8809-4a1b-b115-bf5f8d7110ea@leemhuis.info>
 <CO6PR11MB5586DF3964BAB4E6131A86CDCD5EA@CO6PR11MB5586.namprd11.prod.outlook.com>
 <2026040331-evasion-walk-f572@gregkh>
 <DM3PPF63A6024A9C09C1B13E5DF46C0B72AA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3PPF63A6024A9C09C1B13E5DF46C0B72AA35EA@DM3PPF63A6024A9.namprd11.prod.outlook.com>

On Fri, Apr 03, 2026 at 12:44:48PM +0000, Korenblit, Miriam Rachel wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, April 3, 2026 2:27 PM
> > To: He, Guocai (CN) <Guocai.He.CN@windriver.com>
> > Cc: Thorsten Leemhuis <regressions@leemhuis.info>; Korenblit, Miriam Rachel
> > <miriam.rachel.korenblit@intel.com>; Berg, Johannes
> > <johannes.berg@intel.com>; Friend <netdev@vger.kernel.org>; Linux kernel
> > regressions list <regressions@lists.linux.dev>
> > Subject: Re: commit 0c4f1c02d27a880b cause a deadlock issue
> > 
> > On Fri, Apr 03, 2026 at 11:08:46AM +0000, He, Guocai (CN) wrote:
> > > No, The mainline have no this issue.
> > > The changes of 0c4f1c02d27a880b is not in mainline.
> > 
> > That does not make sense, that commit is really commit e1696c8bd005
> > ("wifi: cfg80211: stop NAN and P2P in cfg80211_leave") which is in all of the
> > following releases:
> > 	5.10.252 5.15.202 6.1.165 6.6.128 6.12.75 6.18.14 6.19.4 7.0-rc1
> > 
> > confused,
> 
> The change is indeed in mainline, but the locking situation in mainline is totally different
> (that mutex does not even exist there)
> Therefore, the issue is not supposed to happen in mainline.

Ok, does that commit now need to be reverted from some of the stable
branches?  If so, which ones?

thanks,

greg k-h
