Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ADF47D44C
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785861936; cv=none; b=Zglze8oY+mV6O+xAaQpMhup5Uhha1unHa0Qs5idbtUUTmunBcqBHPEczX6Fz4aMq+vMFYkq9rDiqwLed2+fhj3W5PKqkXBIPtI0+idG1QLK/4M7lpgoFgXtPgFOhXTpSZTDZhlwTnH3afgYZOSPi3ORzQl+5c+DC5P9sFN1o74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785861936; c=relaxed/simple;
	bh=pBFtmcjPU/gI1tH/3/qdncdOj9MWCCyRGbDhTP6zUVU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YQuoQXnUetYPY6j6H8WmhaeKAsx3OVdz6w0gG5ld2f8Fp28exIdGSkDkOiVBgo2v6IAgdH7erz6o3fLRFs4GUCLEIRH7vlVDAEisDknWZmtTD5FSUbjDtL1Yeoy/h5DYEB3JRejcLOGcRYueQs/gF2VM7lL1hx8UoMglp7pFozc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdQCWLRc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdQCWLRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E4D1F000E9;
	Tue,  4 Aug 2026 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785861918;
	bh=FjoTEp3VlIM9Y1gTcvHjpzHoMKPXr60CoFGlDoZq6SI=;
	h=Date:From:To:Cc:Subject;
	b=BdQCWLRc1Rh3ppnYOKB2mJRwxfBLOt84Qw9BdoqmpZPHLMgOdRtLEz7rxAwBfN8cJ
	 6f0UByzr60Zp4cB7kWAEFK9AqPbuyfSZ8eEvTJ1AYju/Od2idUl3KloILgnypB5UN0
	 kNOZHRV8S/LRog3WvcB33t4achizu6WDQcDIbiGQmRqzIt0NPzJqwpbjXcWVHBr3yE
	 53xOk4Ya5HS8MlCZSA83tirbfvNOMNOVqepPApkTpZ+1zvIQnO5jk+KANolo44zsjr
	 13Cn5B8xGws3HgVqTOSRZgYFEgA00ndheIGYI6GloQw2E9sphqUqVmxF1A8ULRF6q2
	 4grgMyCprYl9g==
Date: Tue, 4 Aug 2026 09:45:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [TEST] CX7 timeouts on reconfig w/ page pool failure injection
Message-ID: <20260804094518.53b56d24@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The CX7 testing in NIPA is looking pretty good, one major source of
noise, tho, is that the pp-alloc test sometimes locks rtnl for
a minute.

Here's a failure in that test itself:

# # Exception| subprocess.TimeoutExpired: Command '['ethtool', '-G', 'ens25f1np1', 'rx', '2048']' timed out after 20 seconds
# # Exception| 
# not ok 1 pp_alloc_fail.test_pp_alloc

https://netdev.bots.linux.dev/logview.html?f=/logs/hwksft/CX7-dbg/results/763842/test-outputs/36-pp-alloc-fail-py/stdout

Then the next test that runs also times out during setup:

# subprocess.TimeoutExpired: Command '['ip', '--json', '-d', 'link', 'show', 'dev', 'ens25f1np1']' timed out after 20 seconds
not ok 1 selftests: drivers/net/hw: rss_api.py # exit=1

https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/763842/test-outputs/37-rss-api-py/stdout

pp_alloc test can fail, but spilling into the next test is a problem.

At the retry things clear up enough to return to happiness, tho:

https://netdev.bots.linux.dev/logs/hwksft/CX7-dbg/results/763842/test-outputs/37-rss-api-py-retry/stdout

I haven't try to dig into where it is blocked but does this ring any
bells?
