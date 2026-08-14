Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE173C09FF;
	Fri, 14 Aug 2026 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728091; cv=none; b=VKORUazDGueJSf1CtmAry/AQxzlPOkOyL7rbArrPSzno4LcjglcvWbGH5S6y3+mXwlCxl1sIVekkYsddYWDL5xgvFuf0aW+n8SncHhLp5tvb6vEaq3dZX3ojfR4yC8lGRJ8yYb+wLTDLFiz0+EVTOd/28M0C+Do5gz+QaR3pBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728091; c=relaxed/simple;
	bh=+N3+95NIS85ocALRdeDM69PHVAdZVhc4PcFyO/2PblU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6J41jUHwsTWM5frdBYEcsGihAARqodOCwTW2J9PpZXnsJyrjyfUxJgGeekv+ZCgwiU8BU8WFazquoOc5UXk6EVua+xlqT0k76nB/BGS/ys2U2Ng4WwnvN4igqkZWPXYIz7y8qm/kYwVWmYfRtAzx0rLNK2bN5Ku2QPOLkt7GRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ84Tt/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ84Tt/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D641F00A3A;
	Fri, 14 Aug 2026 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786728090;
	bh=G4Sj6oqjO0ELg5FKSZLE9uUZEVynMLtR9oIBdeswzH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eJ84Tt/SIYEN22yrywSVSqs3/o5SeDAoIa4WkzhF02Pkc7+0kNC7fZbn4Vp8mXdQy
	 kNRhCqF/x/1rAgUFneSjwADQOCA0FaFfTOTLg6I9bSfL79CX3gi2h7BGH/7kbdQyvJ
	 sq4oH40GvcZLkr0ZSMhhlQa3wmY0lco2fpq7tSVx3/XX3NhXuhSldpE+EZmCZ6jpFM
	 rJCU3qHhOtMAnVPgH+wpnasejie9+2XbMAgxVDJ4aGFKIXCe2gOgWSUApAths49MLd
	 99KPuiRBNHMIVsZUF0ypaof8U7wdcHQmcWUYjDzJH20gb/tDH2DQcUsiUJoPv9ojsc
	 vWeGLiUF4/xOw==
Date: Fri, 14 Aug 2026 10:21:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, Ruoyu Wang
 <ruoyuw560@gmail.com>, netdev@vger.kernel.org, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: initialize err for empty target lists
Message-ID: <20260814102129.7eae0354@kernel.org>
In-Reply-To: <0ad34e55-8f3f-4847-a885-854ad62afc9f@lunn.ch>
References: <20260813153126.3952893-1-ruoyuw560@gmail.com>
	<4b095542-6656-467a-93ce-4a39c6c80c46@blackwall.org>
	<9ee8e417-e626-45c3-8c4d-cd605123ff37@lunn.ch>
	<an4pYO_Co20iITY4@penguin>
	<0ad34e55-8f3f-4847-a885-854ad62afc9f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 02:44:11 +0200 Andrew Lunn wrote:
> > I didn't mean it as a maintainer, it is customary and good practice
> > to email the author of the commit that introduced the regression,
> > that is all I was trying to say.  
> 
> Interesting:
> 
> scripts/get_maintainer.pl --help
> usage: scripts/get_maintainer.pl [options] patchfile
>        scripts/get_maintainer.pl [options] -f file|directory
> version: 0.26
> 
> MAINTAINER field selection options:
>   --email => print email address(es) if any
> ...
>     --fixes => for patches, add signatures of commits with 'Fixes: <commit>' (default: 1 (on))
> 
> So it should of done it, if it was run on the patch, rather than the
> file.

FWIW it's a common mistake to run get maint on a file path.
I sent a patch once to print a WARNING when paths are used.
But apparently the path case has at least one important user - Linus :)
