Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B185390CAA
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115945; cv=none; b=J74r65AlyCHxu9JAtINF1pWp9ANvX1xPzxNKdctZV1o9Df+auwCK7hnEbeCoPKbWV71aRi5F3HAVPEhiPn2w+vvwu18Wszl/ToAcOgRcbmHkaE9SVfjtSgsTTTpDk5O/uE6njy2Fx68Q0+Rx5tA6N9RazCNu3tdO4uDlWXMCafQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115945; c=relaxed/simple;
	bh=6VMDfjOa+2yABTRe5xbHI+YTqsKzHNkOQHpPdAHav2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTN4OrfVWVwVtOJz4d2RnVBw/PAopNTp8uBMAZAMotflGYXEFgphu8k4T/N9vJ7T+dgSuDv7JCncDX700G4bl91dokFmveaimUHKA+rQIyv+wP7uZynNebcxhMRYYMVGtceQVQJZb2Q/Q2Vo9PbU492otqfCJXKzt5spo2QM7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuT0Ee5c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuT0Ee5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DADC2BCAF;
	Mon, 13 Apr 2026 21:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776115944;
	bh=6VMDfjOa+2yABTRe5xbHI+YTqsKzHNkOQHpPdAHav2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LuT0Ee5cAHSymTSyh2Rdk/Pexavx7EXbycEIycnlK/gCwzHyPIJZtNvJ2AFog+kH8
	 qBILhTRo9InFAysfoBde0jYDdSU5iYA8Hj7slHub6S1CHs7FeXht9XF+MwysDHCJlW
	 pEzY54caYEBRMuWcllQCEc/nXYHvt4elc1qd6p25RGq3Mb4GJm2IMgrMmY1wQF/Hox
	 lowJCtjoWvDdfsayPKkf9dfaHL0MkyOrA1Gq3uxLgRwnztaY+KbviRZ5jvNxZp/LFe
	 7+nI9tJi4pCJdzKXsjoBiFLp0z3IcYoXKzagXFA4V2gmZJkEubmCImXd7lZDgMaIVQ
	 qZtMXNWNPcoAA==
Date: Mon, 13 Apr 2026 14:32:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: pabeni@redhat.com, dw@davidwei.uk, razor@blackwall.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Follow-ups to nk_qlease net selftests
Message-ID: <20260413143223.7a22c2c3@kernel.org>
In-Reply-To: <47b7d67b-2240-4815-87c8-368413c9ddee@iogearbox.net>
References: <20260413114011.588162-1-daniel@iogearbox.net>
	<47b7d67b-2240-4815-87c8-368413c9ddee@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 15:02:22 +0200 Daniel Borkmann wrote:
> I'm planning to address these in a v2 of the series, but as per netdev rule
> will wait 24h before resend unless you'd like me to explicitly resend earlier
> (given merge win timing).

Please go ahead with v2 as soon as it's ready.
