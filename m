Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF533B974
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773341777; cv=none; b=UfnzanE6iXGItyllrPz43DdM648tKcMMPhVfpe8RnjwmOkqXxhsX8xrg91qcT+DTG3FicJhLdJl4GN3AX4fowEawMg0CqoVW03x1nXlNqRIp0++CxKDA1i3AAQ7wdAmdmm0nISr+BmAJnULhjcINC5Nd3hormmT2gRSHCAz3VUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773341777; c=relaxed/simple;
	bh=kWznZNvAog+f3GshpHTgqXEPG6CQ2aWoU6mzA7oIuds=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=FzMLC/V0wS4jKz84fgG25geQDsjipWNBZkYbzi0URWz8HAMEVkVFhhI1e1TcjI12faqG1/byE+5auxaa7sIpIU5z+d+CV7kokvP5vdun/nI1Zok2IDgUZyqpAl4d+V/dRVJ3MVp42vcxcFhitWfb7GPuN32QP5493tlAZhhcFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI8hh3dV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI8hh3dV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC5BC4CEF7
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 18:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773341777;
	bh=kWznZNvAog+f3GshpHTgqXEPG6CQ2aWoU6mzA7oIuds=;
	h=Date:From:To:Subject:From;
	b=GI8hh3dVSrwC/AhxnvHOpx4QQm6tv8/mqLqf0gLejSMQbncvsir6GweGvB1smETd7
	 ityelLankmTs/pwLjBeb//xCjA2BlPLd4W4werSWxJA3Vjb/m5PdggYbYwuBbKgfL4
	 CvRbkzEu01/zTDFDxL9VMUqh9hRPm1niXCeDDMO9aRxbI38ZRrdB63LCqQynuNp1Yf
	 0mbyNLjKK07s1SLuDrVjjuK5RbuuWczxVI4yD9f0E3C21XImy6iNvVZ7ge4tH3J98H
	 QuaCrzxCf1/eeoBLTKilxAKZdKf8zGo4a7ucV6gKTsSfdy2g0Ivh0Jyz91+5pU7Dkn
	 vxMqOkbonkXiw==
Date: Thu, 12 Mar 2026 11:56:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev foundation TSC meeting notes - Mar 10th
Message-ID: <20260312115615.79c2abb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Present: Andrew, Eric, Johannes, Kuniyuki, Simon, Willem, Paolo

NIPA/Lab MoU
 - Approved by board
 - Simon to move paperwork forward

PHY SoW
 - Appears that work can commence now

Lab status
 - Racked 2x stage 2 machines, with NICs connected back to back
 - Began provisioning tests (ETA 2 weeks)
 - Added runner for emulated fbnic

Conferences
 - Time to consider LPC Networking track, Paolo will follow up

Research grants
 - Simon to look at creating RFP

Logo for the foundation
 - Jakub to get a quote to create logo
