Received: from mta1.migadu.com (out-89.mta1.migadu.com [95.215.58.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35038B7B0
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 11:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522289; cv=none; b=LPjbEYcIofJZMFP9lpFsG6u1sy3tu/0rQ0PYylNZvQ1r8TNKhIw5toSCd2fdcUEDtN9Kf+oB93g+XtET+CFQxqPiVVlWaALheomjYGsJvojTrEkv7H8JEv70kpVPxIjF7w3/US4sYJGYU2ETWt8cbPPVhIBqjd7ARi0WYK1438U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522289; c=relaxed/simple;
	bh=Q9ph3p/pWFyaUSJKb02PojfLrHNnHmtPSnuvV5o91UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNnt4MMpHF+N6aiIrO9lwKmrw/YSbO5Wix/9XiIBlJi4ukDw/K24QRyiDI+m/BxuzxzL2mutG9oafkqD45cfZXViEJDl4uYPn+v6gidOPNBXXiSKvAyTzOZPfJuj4bpB3902+SZwIPXMYGS5dgRkKv9RSlck9S1pJZLj0yMVoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qDJyWVDC; arc=none smtp.client-ip=95.215.58.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qDJyWVDC"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Q9ph3p/pWFyaUSJKb02PojfLrHNnHmtPSnuvV5o91UI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788522284; v=1; x=1789127084;
 b=qDJyWVDCfeGdes69FElBS5Tuhv7iXRutExCM5SyZ7d74InDyuhp5lODniyKhYqFQkPK8eGG7
 zz+FNk0fwGZIwAaTpHC9IIC0S2lXHcymcPnO944lW7p1GjR56d1hlCBkBXgW//FnAqrrLnByT3E
 5A03VKjqXEbfER5rPamPpouI=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 7bc6712efee2e929;
	Fri, 04 Sep 2026 11:44:44 +0000
X-Mizu-Trace-ID: 7bc6712efee2e929
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 19:44:38 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>
Subject: Re: [ANN] Containers to run Netdev CI tests locally
Message-ID: <apqvJmgi9ZKmDDrW@fedora>
References: <9c66a2b4-2787-4421-bc9b-627de2f708bd@kernel.org>
 <appsQWUIC9-5Nze7@fedora>
 <bf2cd349-7d1f-4ace-acb7-948dbeada200@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf2cd349-7d1f-4ace-acb7-948dbeada200@kernel.org>

On Fri, Sep 04, 2026 at 10:33:18AM +0200, Matthieu Baerts wrote:
> Hi Hangbin,
> 
> On 04/09/2026 08:59, Hangbin Liu wrote:
> > Hi Matthieu,
> > 
> > On Thu, Sep 03, 2026 at 06:19:25PM +0200, Matthieu Baerts wrote:
> >> Hello,
> >>
> >> TL;DR: containers are now available with all dependencies to easily
> >> execute all static, unit, and functional tests in an environment closed
> >> to the Netdev CI one:
> >>
> >> - https://github.com/orgs/linux-netdev/packages
> >>
> >> - https://github.com/linux-netdev/nipa/wiki/Running-Netdev-CI-tests-locally
> > 
> > Great! I've been struggling to set up the local NIPA docker. I'm following
> > the steps from your git commit description. Now this article saved me.
> 
> I'm glad it helped!
> 

From a user‑experience perspective, I think the static tests work well.
They display the check results clearly and save outputs to the result directory.

However, for selftests, I do not see any difference compared to running vng
directly on my local machine, i.e.

  vng -v --run . --user root -a mitigations=off --cpus 4 -- \
  	make -C tools/testing/selftests TARGETS=net run_tests

Do you know how to make the result looks like the CI shows[1], that each test
has a separate log dir and shows stdout/stderr.

[1] https://netdev.bots.linux.dev/contest.html

Thanks
Hangbin
