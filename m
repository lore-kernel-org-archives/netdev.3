Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3EDEEBA;
	Fri,  3 Apr 2026 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775215638; cv=none; b=g8WvQWGa3zWBW6GQr7+31W1gz191zFYmB+iS33VP7En0dRNCUUOcKvM4lK3NcHtbT0lSm5xY0GA79LHHe4/osPiCpgVhbS0UbhjSFETg11ag4wfF5cbaP45jp+H3UqzcJYWILg8MVz+C8laDBXB6FTuwIFjJT6SX997z6PJm41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775215638; c=relaxed/simple;
	bh=8ptg6+lDlnNWXZzdode46v0AX6LoQ04u750EgYPk0mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlGBOOSRPIaAX3jr2wGZS9QLVdissSsYvd9mIHLbGS/0AcBmtKCvh/XPbeqUdVHn1ND87x/CcPjdgp3n+hVlbnO7GWpK9crrNZtrW2qW3+65lHW2iE9o2Kk3JzYORn902fFe7oL1G+jxjAZFWRog4ZEvFVW4e36i+ENIw12QB8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i4k8v/4c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i4k8v/4c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97984C4CEF7;
	Fri,  3 Apr 2026 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775215638;
	bh=8ptg6+lDlnNWXZzdode46v0AX6LoQ04u750EgYPk0mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4k8v/4ckXyOC7M7sWAWb1JozoO+vf07H/m8qMiGkHjkdVQK2G45PJXMPCU8sszgU
	 7P+5OPGJ1Z90Mz4nfr+HO8NKtHhDFKwXBwSWKgGOOt4nIfN5BrBX81g8kYun/5Y5WL
	 f3i2Wfsot35Q1V5FStGlUTmDrAkuIDqSbwDvB6ho=
Date: Fri, 3 Apr 2026 13:27:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "He, Guocai (CN)" <Guocai.He.CN@windriver.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	"miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
	"johannes.berg@intel.com" <johannes.berg@intel.com>,
	Friend <netdev@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: commit 0c4f1c02d27a880b cause a deadlock issue
Message-ID: <2026040331-evasion-walk-f572@gregkh>
References: <CO6PR11MB5586A4475A5EEC47FC10398BCD53A@CO6PR11MB5586.namprd11.prod.outlook.com>
 <PH0PR11MB55934A1C9A8C35B1E751C247CD50A@PH0PR11MB5593.namprd11.prod.outlook.com>
 <14d65103-8809-4a1b-b115-bf5f8d7110ea@leemhuis.info>
 <CO6PR11MB5586DF3964BAB4E6131A86CDCD5EA@CO6PR11MB5586.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO6PR11MB5586DF3964BAB4E6131A86CDCD5EA@CO6PR11MB5586.namprd11.prod.outlook.com>

On Fri, Apr 03, 2026 at 11:08:46AM +0000, He, Guocai (CN) wrote:
> No, The mainline have no this issue.
> The changes of 0c4f1c02d27a880b is not in mainline.

That does not make sense, that commit is really commit e1696c8bd005
("wifi: cfg80211: stop NAN and P2P in cfg80211_leave") which is in all
of the following releases:
	5.10.252 5.15.202 6.1.165 6.6.128 6.12.75 6.18.14 6.19.4 7.0-rc1

confused,

greg k-h
