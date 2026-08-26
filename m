Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2737339C006
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769152; cv=none; b=F29Cz7mfQiFZao8tHwz42+0BMHblCoo3FhnIgBgTLfKGp0L8oSzOi87JQfJe/peauhHwEKY7ixUplGbh1SgOR4EOWN3SS6/BxIELYhoPa66/Ib/0zhJBV4y2/AwLVnR3FXTK1oo/dWkhi0aacoDNxwerExkkEq7XeHxMc51dyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769152; c=relaxed/simple;
	bh=tbgq4t0OFMkZxlpxE6fozn6lVY8Yn/h0hvloaFPv1ak=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=XPRcZUL+bovbBFJfLqc4W7AcGpzUpBgrJg/EDs7pn9sR3tiHrwxoDPbUVLFLKU4XOi0tmkH1E/oVe7MZ+RRm461Q6YBZCDxsTSoy9BWkCVd5AphVH2A1HYc11q+7c6YYetG3EYPVbILmIDSVUytRrqCr49rNsrIDK5GN5YfBuR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nChOROIb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nChOROIb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D00E1F000E9
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787769143;
	bh=+n6bKDkO53IVd0nnBBHB/FQlHI4UsiAiMFvJH1xOAj4=;
	h=Date:From:To:Subject;
	b=nChOROIb61VUBWU+SLWL+K2Xk/mm8wAW1p+BZgvnk1P4rZAJ+Ko5thS1i4SPUIhu2
	 CtLpK5ItH5bOUdmyvJff74SN2SEDWC9P6gBbQlIW+XCNts6FBZ/yT0xlrQ4jkUQnWg
	 b7/i6r7GB0YqQ7bCABWcEDU2o1W7QxIywVNfVtrWx+mMSP+PViG5GdL+pI4m5hLJp2
	 RKH+hmft1YQdlLidef6hEha+lESpgnprt1mfy4imKh3d5OpAhQJ5kHv9ms0ALWtkJs
	 rbhoOpc89tacuTdlGmzg06JauQOvJFk7VBnF/6XacI3steAFRAH9rRzMfimoFycOnL
	 VrDhjppNRfRvg==
Date: Wed, 26 Aug 2026 11:32:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Aug 25th
Message-ID: <20260826113222.0c82c0e3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Present: Andrew, Eric, Iwashima-san, Jakub, Paolo, Willem, Simon

Academic research program
 - Minor updates to proposal
 - Need to coordinate with Board Chair on next steps

Logo
 - Feedback on latest ideas/drafts shared with designer
 - Updated designs pending
 - Approximate ETA: next TSC meeting

Conferences
 - LPC track accepted

Lab Update
 - Contracted admin and development
   - Dockerisation of self-tests complete
 - Next: close loop on hardware testing

Request for funding for more NIC testing
 - 2 machines, 400G NICs from nVidia and Broadcom, w/ crypto offloads
 - DRAM / SSD prices are crazy but not expected to go down any time soon
 - total cost ~50k USD
 - approved by TSC, Simon to submit officially to the board

PHY testing development update
 - Contractor is refocused on this work
 - Expect tests to be included in next patch drop
