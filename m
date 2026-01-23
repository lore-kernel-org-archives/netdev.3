Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C70531282E
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132905; cv=none; b=OjDTOlxz9YI+UEi4AupJHAEMS3Ok8dQWCV2cOwkqeWiUUoxeAiEEh7kkpll84SmPmFeFBUeCjRHCLnf4Lhc5DhiJyVtgxQsypoB9mDJttHRaURWZnp1R4ciiM5JNemP/LdwP2/InOMW65HvGExMqKKZS24pX0ZK3iAF7erFR6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132905; c=relaxed/simple;
	bh=Z0UHI2LTFgIv/loWWCM5jw6r8E+O0f0YNdfwY4NyVP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tkLKNH8HrYcOh0u14kwfY9kFeZrlmHE6BKECc7R+l7sABFrfGI6B9IhdSmW2kbYJ0eqQ+r96mC3NPslPDpe6yTOVsxtSkkwDhNQuf+H1nMqjcKbCeV0CrThHrWh0lbRJIzeM7SMejhuVJ9BMprUu7qAmwMsKaj8EHYFyX5fVuhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/IfW4xu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/IfW4xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE6BC116C6;
	Fri, 23 Jan 2026 01:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769132903;
	bh=Z0UHI2LTFgIv/loWWCM5jw6r8E+O0f0YNdfwY4NyVP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H/IfW4xut/bHAeJkmzraZYFVdwuxQpdvTVVkJ+dLefZRRVkOVgrX/kBaeG7a1RwbK
	 nIHiVN9M3ZrI7iNDBjcNGS9vQ9kVKkEPaRXc9etsWb+Bwt2pZnKTrbHxN3b4KN6rG4
	 X0634po8VT0hdsAWbYFhU3kNKP0JuGZB92cBortlEnVSBkh0CXA5eGn0d09lxl7TLB
	 4SzPcGqqIWBm4bx1/jD9FCXb5sIvLQhIhMLA8zgsFYzCazWj5BE0yEy14Jn7d3p/Tk
	 6fE8usGpxUrm3+L9ElE36sAdj7s22e5Gz7dLpKn6msAyW3Q8auPiinGBRYOrxNgBU3
	 nrJF2WgSiSJRw==
Date: Thu, 22 Jan 2026 17:48:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
Subject: Re: [PATCH v5 0/3] tls: Add TLS 1.3 hardware offload support
Message-ID: <20260122174821.70553ffc@kernel.org>
In-Reply-To: <20260122192851.86670-1-rjethwani@purestorage.com>
References: <20260122192851.86670-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 12:28:48 -0700 Rishikesh Jethwani wrote:
> - Rekey handling: HW offload key update (rekey) is not yet supported.

Not sure this series will be merged without rekeying.
We'll need to discuss pros and cons.

> Testing
> =======
> Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).
> 
> Both TX and RX hardware offload verified working with:
> - TLS 1.3 AES-GCM-128
> - TLS 1.3 AES-GCM-256
> - Multiple KeyUpdate cycles (rekey)
> 
> Test methodology: ktls_test : https://github.com/insanum/ktls_test/tree/master
> 
> Please review and provide feedback.

Selftests are a hard requirement, I already shared a link with more
info with you.
-- 
pw-bot: cr
