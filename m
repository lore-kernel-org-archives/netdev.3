Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296F22701DC
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782579243; cv=none; b=HCZPsRPO8YWzJGXUwXN4iNFCCpFHcP4c9alAac71bdSEhn1XgL9ovBMU1scXWhzUgC/u4urqndsjgnCR8Ze7miShACBU0LPj7x1BKh/HFPhQjhbXn85knU9GKiIgCU6kzG+jIaJXyjQzujVxvVxvOvG/g0OddiLZ4CnxcqJoxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782579243; c=relaxed/simple;
	bh=rWNJ+nWH3zByciyqYf1dZa6E0Vryg3VlN2/mkJpjSJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G5g0abz5bOi9nSgIM9YVUugZHvk8giDj1WwN7tmeRrZF0p9hryGHaStXB9u+VbQAqq07+altbEwkG0KbCv4sAEbK0lOg1/puMAlYOVw6TlVKXXvD9Gemmm8Mi1jltvvKqZnf5alANjK8nXlYUwnz1yQfpTGneV95xb+4SWrefSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooK1TFmc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooK1TFmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ACB1F000E9;
	Sat, 27 Jun 2026 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782579241;
	bh=rWNJ+nWH3zByciyqYf1dZa6E0Vryg3VlN2/mkJpjSJM=;
	h=Date:From:To:Cc:Subject;
	b=ooK1TFmcLq+qtpDExwhO4CzxA+rmCXYd2mkEvsuB7heev/jeSX+CeqwgrClvpHvin
	 vNwLoogRqBZSPz+gyId6Mo1elUwbXPLmIX6zvVuctLoPC5Aq72vHCxl9OdRL5h/r3d
	 mvYi8as79IwYa61USCU6yiZDzA5VrJlVTaWmiTDAHWS8oNpbjtQ7ceYsY7SvBd5GPt
	 Tfd2i6lVuJ5mnfTk6u7Yt/vD86pnmOHvV4E0zxcFd/5bpdQsKUUCZKQwOTDrgmXgwO
	 vsuGsjTNqSEy7D7XGsYJI+GSWJg4t3ZwGCpNUnvgPgU4XSsXG5EmIwAVSEnQ/Uynsa
	 RhrMpDijzccgA==
Date: Sat, 27 Jun 2026 09:54:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Pielech, Adrian" <adrian.pielech@intel.com>
Cc: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 intel-wired-lan@lists.osuosl.org
Subject: [TEST] intel: low timeout
Message-ID: <20260627095400.3c3d9f80@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Some of the tests need more than 5min, could you increase the timeout
in the runner to 10 or 15min? Looks like it's hard-killing tests right
now after 2min:

https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/xdp.py/stdout

which leaks config across tests:

https://netdev-ci-results.intel.com/ice-results/net-next-hw-2026-06-27--16-00/ice-E810-XXV4/irq.py/stdout

BTW the JSON reports the timed out tests as pass.
