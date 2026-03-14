Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ABA13DBA0
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773497344; cv=none; b=AKE1827pjjzBadzxhwmNRSnQ6CPPn6Q8zZ+hZBFcGuhKscMWhn2ZudAUT95PPINnQ3g4hFuNbQNj50FvjeL5JXu+K4+QTqRwDRgV6UcmC/Lx7KeeMAKRWYZHWPm8+fNwBHzpVQKtergY7NqY4F03DkM6pndvhJfSLPKPK/2vEcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773497344; c=relaxed/simple;
	bh=JeZBxGCWTdgnXP24AZ2xzC4EEtua14BDZ4rDTKgA530=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lh3DDYPSEoAKGLUczqCF2X6NWuTDG1zBmKvk+i3gKhhHCDPZblUP9v7dYyCc/dbVtPs+s6u935+qP0oi089uM2/SCyTKX5cotJ1ba7mZFmlquu6lTuqlE7C6tON/wjPtW3TaPfhL4WDfGeM/BxEDg29GYbPynmJsdEe3cSHhbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHq60I1r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHq60I1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28EEC116C6;
	Sat, 14 Mar 2026 14:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773497343;
	bh=JeZBxGCWTdgnXP24AZ2xzC4EEtua14BDZ4rDTKgA530=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XHq60I1rfSm0Qcqq5pRaoe8+LR3P4vrdZzFNzrdYsxEWGir5l/Yc9pjO3d5HW6jNQ
	 104bzJF9qo2FzAETRPEOuZJJ8+PUPdjsxhj9O3eTOYvJVXn/dtH2Cili5ESfb2bcZx
	 4gBVel9PQfwri33zOmqAUChOyzEtmsL0mU5KotUvSiH3Y9KOssE8iHm8HrIwzM9Lbc
	 tDOPi3ottYyLJnEI6URma8mvVAFpjpdGdWU1SNx6cdHsqvc1grKt48kv5Vg/ns329Y
	 atAkudt1gqOEbUzC8EZ1o4XBZiHPhfrmtEaaRfm3WFs8sGHDD3QL0whZrtaNnypYuE
	 aSJimDP5Rsi+g==
Date: Sat, 14 Mar 2026 07:09:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 00/12] netem: fixes, cleanup, and selftest
Message-ID: <20260314070902.4025c388@kernel.org>
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Mar 2026 14:15:00 -0700 Stephen Hemminger wrote:
> The netem packet scheduler is widely used for network emulation but
> has not gotten enough of my attention lately.

There's a few tests in tdcs which need adjusting:

# not ok 363 d34d - NETEM test qdisc duplication restriction in qdisc tree in netem_change root
# Command exited with 0, expected 2
# 
# not ok 364 b33f - NETEM test qdisc duplication restriction in qdisc tree in netem_change non-root
# Command exited with 0, expected 2
# 
# not ok 365 cafe - NETEM test qdisc duplication restriction in qdisc tree
# Command exited with 0, expected 2
# 
# not ok 366 1337 - NETEM test qdisc duplication restriction in qdisc tree across branches
# Command exited with 0, expected 2
-- 
pw-bot: cr
