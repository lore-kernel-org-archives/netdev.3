Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803A331209
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 05:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785217997; cv=none; b=gfzI1yCJEV44/2opI4SKNtAgRtzE2YUmhnd63hIv7C69V2tiCefvyung8MCAdkUkLfzth9ePPxAjVg1ckAAmiXdTx6m00oJ3udhkPKmBAQH51XhDBPTu5F6AIuK+0q6nMmjUORdeRmOATZBRD+V3f44zrE5VZ6SqM51gVGtRanQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785217997; c=relaxed/simple;
	bh=hVgSZZXuBFk7uISejArwO/h3BcZVvMYOjz9HEoNwm3Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=T2NcFSSTgt3ed+IfA4N7qiQ5CZDeCFmr8Aa+RuxKdg5a/MeDU+cdpnLd6WPkCcorrwzajNiBKU1IhhtlvYplCn4xDMxW6tM0T0TAqUzJ8JSOuQVcS5xo9ewkzdU7Ba9fsMif2NUfNL5tkl7kutK5AMcT9ZvJ2ufGhfd+qFgEJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=A2kAB8cs; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="A2kAB8cs"
Received: from smtpclient.apple (border.lukktone.com [139.130.100.52])
	by us.padl.com (Postfix) with ESMTPSA id 9C53160964;
	Tue, 28 Jul 2026 01:53:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1785217994; bh=hVgSZZXuBFk7uISejArwO/h3BcZVvMYOjz9HEoNwm3Q=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=A2kAB8csum8T1cdCCYPmfMI57RKgHLZNh0yziPOEFzqHwbvKSbM4TfsHyN4bFvlNr
	 rWkc9VWbZevbauwiBYQmGjlvlHrD1xwUn9vUgaJcWi2cpobJW2M8gFIOzNc7FyGTA8
	 /Zz1LggeeO9A+B7GDbkH3YoN5Bhrl7pWmC7FdsZhwDvsuMUMALuiD+CZQLyI/k9+Ph
	 3609E3aIjbB1UmluDJ40wVs5iWG2IVuHeBF0KR/BZKbKpMnpvUqNhj8COqWoy9fUpY
	 VwXs+HOXwTCvIU3MVPRjBjNfVPR1L2n80RbhLm/1/HuD0zs5YOJhwicTMNvXluq/yE
	 UEt4o54w8QwlQ==
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH net-next v4 3/5] net: dsa: mv88e6xxx: decouple the PTP
 timecounter from the register lock
From: Luke Howard <lukeh@padl.com>
In-Reply-To: <20260728040001.D87D21F00A3E@smtp.kernel.org>
Date: Tue, 28 Jul 2026 15:52:59 +1000
Cc: robh@kernel.org,
 netdev@vger.kernel.org,
 Vladimir Oltean <olteanv@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Cedric Jehasse <cedric.jehasse@gmail.com>,
 Kieran Tyrrell <kieran@sienda.com>,
 Max Holtmann <mh@rme-audio.de>,
 Max Hunter <max@huntershome.org>,
 Christoph Mellauner <christoph.mellauner@joyned.at>,
 Simon Gapp <simon.gapp@gapp-audio.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B172FBE5-8086-414F-96B3-7D5F2D764062@padl.com>
References: <20260727-mv88e6xxx-ptp-fixes-v4-0-10b4020155fc@padl.com>
 <20260727-mv88e6xxx-ptp-fixes-v4-3-10b4020155fc@padl.com>
 <20260728040001.D87D21F00A3E@smtp.kernel.org>
To: sashiko-reviews@lists.linux.dev
X-Mailer: Apple Mail (2.3864.600.51.1.1)


> Because cancel_delayed_work_sync() is waiting for the worker to finish =
while
> holding the mutex the worker needs, can this lead to an AB-BA =
deadlock?

This is a pre-existing bug with a simple fix that will be made in the =
next revision.

Luke=
